require "pry"
require 'csv'
require 'json'


product_name = ""
fats = ""
protein = ""
carbs = ""
product_id = ""
product_nutrients = [{}]

puts "Please enter name of the product"
print "You entered: "
product_name = gets.chomp

CSV.foreach('Products.csv', headers: true) do |row|
  if row['long_name'] === product_name
     product_id = row["NDB_Number"]
  end
end

CSV.foreach('Nutrients.csv', headers: true) do |row|

  if row['NDB_No'] === product_id && row['Nutrient_name'] === 'Protein'
    protein = row["Output_value"] + row['Output_uom']
  end

  if row['NDB_No'] === product_id && row['Nutrient_name'] === 'Total lipid (fat)'
    fats = row["Output_value"] + row['Output_uom']
  end

  if row['NDB_No'] === product_id && row['Nutrient_name'] === 'Carbohydrate, by difference'
    carbs = row["Output_value"] + row['Output_uom']
  end

end

product_nutrients = [{ "Product_name" => product_name, "Fats" => fats, "Protiens" => protein, "Carbs" => carbs }]

puts JSON.pretty_generate(product_nutrients)
