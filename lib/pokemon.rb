require "pry"
class Pokemon

    attr_accessor :id, :name, :type, :db

    # def initialize(id, name, type, db)
    #     @id = id
    #     @name = name
    #     @type = type
    #     @db = db
    # end

    # Mass assignment
    def initialize(attr_hash = {})
        attr_hash.each do |key, value|
            self.send("#{key}=", value) if respond_to?("#{key}=")
        end
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type) 
            VALUES (?, ?);
        SQL

        db.execute(sql, name, type)
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT * 
            FROM pokemon
            WHERE id = ?;
        SQL

        row = db.execute(sql, id)[0]
        Pokemon.new(id: row[0], name: row[1], type: row[2], db: db)
        #Pokemon.new(id: row[0][0], name: row[0][1], type: row[0][2], db: db)
    end
end


