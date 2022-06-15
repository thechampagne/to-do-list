require "json"

if parse_json().as_a.size == 0
puts "You don't have any TODOs !"
puts "\nWould you like to add one ? (Y\N) "
res = gets.to_s.strip.upcase
if res != "Y"
exit(0)
end
print "\nAdd TODO: "
todo = gets.to_s
if todo.strip.size == 0
puts "TODO can not be empty !"
exit(1)
end
write_file([todo])
else

  puts "TODO List:"
num = 1
parse_json().as_a.each do |i |
    puts "#{num}) #{i}"
  num += 1
end

print "\n"

puts "A) Add TODO"
puts "D) Delete TODO"
print "\nChoose method: "
method = gets.to_s.strip.upcase

if method == "A"

print "\nAdd TODO: "
todo = gets.to_s
if todo.strip.size == 0
puts "TODO can not be empty !"
exit(1)
end

new_list = add_todo(todo)
write_file(new_list)
exit(0)
end

if method == "D"

print "\nTODO Number: "
todo_num = gets.to_s
if todo_num.strip.size == 0
puts "Number can not be empty !"
exit(1)
end

new_list = delete_todo(todo_num)
write_file(new_list)
exit(0)
end

end

def delete_todo(index)
list = Array(String).from_json(parse_json().to_s)
list.delete_at(index.to_i - 1)
return list
end

def add_todo(todo)
list = Array(String).from_json(parse_json().to_s)
new_list = list.push(todo)
return new_list
end

def parse_json()
json = File.open("todo.json") do |file |
    JSON.parse(file)
  end
return json
end

def write_file(content)
file = File.open("todo.json", "w")
file.puts(content.to_pretty_json)
file.close()
end