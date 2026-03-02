Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3B333F5BD
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772487938; cv=none; b=CeQz//BZ8qBRRQbrxH2YEEGEioBocsstgQv41xg18sz21tPoUQw1Ke/GtRYSGnZ3Un3pU0i7NE1gB0/NCUb68tqIIMaBqc5kO7ZLCjT5uRl9eg30xxRwDIXbEk692eJoLnByxgJ+mJDRzxyl2JRmMOMB71Wps8AxESE8VA9rikg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772487938; c=relaxed/simple;
	bh=ENpdcSw8XlVd2ysmPA0ao7SAM5l/Oc7x0F8Ur7egAZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GTcFYeKI4nBfRr3oxPpMeBHJmRL2b/YjZE9G6KmSoCYtAfPcFOO/rB2r+WSj0BbWHAOZ1KV4Qc9yc9Pr1QH3WD+aB4HvSLYnaXTrrmCxSZOZ+wn6+nsc9XzrH/V1N6WsioknNHZ3ecxKF1t5yTKHMND5Ws/nraf88h0MC1s7WE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njJI+v2t; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njJI+v2t"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d4c307db9aso3245141a34.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 13:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772487935; x=1773092735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aY1udbPP12jEye3N8Lq6iFv6gxHHWrayB6etfADELUE=;
        b=njJI+v2totcjJuSjnS/z73GVD9bOPgxqwM0UcR9Z/dUmH8oLzpov9WX2Pe+ADu1Zvy
         U0abA4VXkBRqroOiAgt8tnk7tbmIGJAmn8OOuC1UxCviToCWnfCS3CSTruvIBfTfEHWQ
         LSn1LNKhpa7aOO9BcLI6xFyGXip6W/SyIQla6a+5ayjoJriwfoole9VX3jSb28z/mr+e
         P+3UWPSp1Hcx3ULwO57w1IvZLGopXoyDbjVRTGArHXdKElJ//Fbpw/i5SZz7QbxJ5bi1
         +EEi/tOrs7jiYMH1RPpZCWq/8tEOoMjsIJYfgkcBMdpP6qjLw8rNqhl69nWbTrhYcMtH
         OCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772487935; x=1773092735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aY1udbPP12jEye3N8Lq6iFv6gxHHWrayB6etfADELUE=;
        b=Zblm11A4o95vrpgaHcI/aYM2xcKujrrLFekEx+0RTdewC9Fuuo4KlJbFS5OeaH+YE8
         rEXqeEWmd1uKdz/bBh47Pv6YvrmavAZ7MUfbyE+ycAlccIQWtypY4qw5kHiiI9Q8yNSt
         mVzZ7TZeptNzh7mQquIAGqHe+xAae32nfKUgGzewP+HtXabb47gtZI4tPDKI1FuZ05Z+
         IvjMMPvTFQV4GgXHuCNoIH9AZeZqsTldldljfn5wb5xedIvvFWJ0D0onDiu9/0j6ay9Z
         +k7DMMtWgDJFcR/isfdRrEWewwq2J5xp7HWQ4lQs2MKUHKA1krEA+kIVFrxBj1RUhVzB
         rAXQ==
X-Gm-Message-State: AOJu0YyFS+R5GKcn6JuTO1sZz9ZoPr31WwtvYqClq8yuc6gjlfq4c6eJ
	rfThMOEC+Spo+qp6pIn+N+w+2gdezvgqQfzdqGZGDcxz1NjcisbIvAv4WlfgXw==
X-Gm-Gg: ATEYQzyQkJqegbUgoFmtkg+LzMbeBrcS/LfIphOC4paVU8I80m6zkLPacmU1Rznynii
	G2itPkZ5KYSxZMxUQKLL3qTdjsITmrZmXI9ifRopCegP5fim4eczzQYYWmBM5IurXe6kW0ThDjc
	DzmR3AxkxYrS1BRvBAmMgzwMbGixB/fXCqC8nDdddFWtjTRUy0A6LzoWtxizQguSP95NvjUasl+
	AtjX7A7PMYHzHhSoogyWVvBa3UrtIk/ko34sZTVDZ7ttQwBAfWAsf/oJktxKKo/LX376VSZ2PcU
	/k0NhThOM4iwQVd0Tw5pVZvLUS/WqZWc3ZFhyKA+8uomQJkhA9oRkIGLBsHFgkm10reGkBUYWwF
	Gwrr2j9pYBJxLYY3bze9KnIjxwEctWLMt1nXxRX1Z5hfdYDwNmasr+Bl4eOtTUVxpSvh3kmlu2U
	0JzR8eIrHWRp+jSXCTAd5jO4v4n1LmiBE=
X-Received: by 2002:a05:6820:83da:10b0:67a:342:85c2 with SMTP id 006d021491bc7-67a0342867dmr3837371eaf.46.1772487934793;
        Mon, 02 Mar 2026 13:45:34 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d84dacsm9775877eaf.9.2026.03.02.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 13:45:34 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	kristofferhaugsbakk@fastmail.com,
	lucasseikioshiro@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/6] builtin/repo: add OID annotations to table output
Date: Mon,  2 Mar 2026 15:45:24 -0600
Message-ID: <20260302214526.2034279-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302214526.2034279-1-jltobler@gmail.com>
References: <20260223174120.2356504-1-jltobler@gmail.com>
 <20260302214526.2034279-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "structure" output for git-repo(1) does not show the corresponding
OIDs for the largest objects in its "table" output. Update the output to
include a list of OID annotations with an index to the corresponding row
in the table.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            |  78 +++++++++++++++++---
 t/t1901-repo-structure.sh | 145 ++++++++++++++++++++------------------
 2 files changed, 143 insertions(+), 80 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 59d5cb2551..ea7f5acd3e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -238,6 +238,7 @@ struct repo_structure {
 
 struct stats_table {
 	struct string_list rows;
+	struct string_list annotations;
 
 	int name_col_width;
 	int value_col_width;
@@ -250,6 +251,8 @@ struct stats_table {
 struct stats_table_entry {
 	char *value;
 	const char *unit;
+	size_t index;
+	struct object_id *oid;
 };
 
 static void stats_table_vaddf(struct stats_table *table,
@@ -272,6 +275,12 @@ static void stats_table_vaddf(struct stats_table *table,
 		table->name_col_width = name_width;
 	if (!entry)
 		return;
+	if (entry->oid) {
+		entry->index = table->annotations.nr + 1;
+		strbuf_addf(&buf, "[%" PRIuMAX "] %s", (uintmax_t)entry->index,
+			    oid_to_hex(entry->oid));
+		string_list_append_nodup(&table->annotations, strbuf_detach(&buf, NULL));
+	}
 	if (entry->value) {
 		int value_width = utf8_strwidth(entry->value);
 		if (value_width > table->value_col_width)
@@ -282,6 +291,8 @@ static void stats_table_vaddf(struct stats_table *table,
 		if (unit_width > table->unit_col_width)
 			table->unit_col_width = unit_width;
 	}
+
+	strbuf_release(&buf);
 }
 
 static void stats_table_addf(struct stats_table *table, const char *format, ...)
@@ -321,6 +332,27 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
 	va_end(ap);
 }
 
+static void stats_table_object_size_addf(struct stats_table *table,
+					 struct object_id *oid, size_t value,
+					 const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
+
+	/*
+	 * A NULL OID should not have a table annotation.
+	 */
+	if (!is_null_oid(oid))
+		entry->oid = oid;
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
 static inline size_t get_total_reference_count(struct ref_stats *stats)
 {
 	return stats->branches + stats->remotes + stats->tags + stats->others;
@@ -389,19 +421,29 @@ static void stats_table_setup_structure(struct stats_table *table,
 	stats_table_addf(table, "");
 	stats_table_addf(table, "* %s", _("Largest objects"));
 	stats_table_addf(table, "  * %s", _("Commits"));
-	stats_table_size_addf(table, objects->largest.commit_size.value,
-			      "    * %s", _("Maximum size"));
+	stats_table_object_size_addf(table,
+				     &objects->largest.commit_size.oid,
+				     objects->largest.commit_size.value,
+				     "    * %s", _("Maximum size"));
 	stats_table_addf(table, "  * %s", _("Trees"));
-	stats_table_size_addf(table, objects->largest.tree_size.value,
-			      "    * %s", _("Maximum size"));
+	stats_table_object_size_addf(table,
+				     &objects->largest.tree_size.oid,
+				     objects->largest.tree_size.value,
+				     "    * %s", _("Maximum size"));
 	stats_table_addf(table, "  * %s", _("Blobs"));
-	stats_table_size_addf(table, objects->largest.blob_size.value,
-			      "    * %s", _("Maximum size"));
+	stats_table_object_size_addf(table,
+				     &objects->largest.blob_size.oid,
+				     objects->largest.blob_size.value,
+				     "    * %s", _("Maximum size"));
 	stats_table_addf(table, "  * %s", _("Tags"));
-	stats_table_size_addf(table, objects->largest.tag_size.value,
-			      "    * %s", _("Maximum size"));
+	stats_table_object_size_addf(table,
+				     &objects->largest.tag_size.oid,
+				     objects->largest.tag_size.value,
+				     "    * %s", _("Maximum size"));
 }
 
+#define INDEX_WIDTH 4
+
 static void stats_table_print_structure(const struct stats_table *table)
 {
 	const char *name_col_title = _("Repository structure");
@@ -420,7 +462,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 		value_col_width = title_value_width - unit_col_width;
 
 	strbuf_addstr(&buf, "| ");
-	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, name_col_title);
+	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width + INDEX_WIDTH,
+			  name_col_title);
 	strbuf_addstr(&buf, " | ");
 	strbuf_utf8_align(&buf, ALIGN_LEFT,
 			  value_col_width + unit_col_width + 1, value_col_title);
@@ -428,7 +471,7 @@ static void stats_table_print_structure(const struct stats_table *table)
 	printf("%s\n", buf.buf);
 
 	printf("| ");
-	for (int i = 0; i < name_col_width; i++)
+	for (int i = 0; i < name_col_width + INDEX_WIDTH; i++)
 		putchar('-');
 	printf(" | ");
 	for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
@@ -450,6 +493,13 @@ static void stats_table_print_structure(const struct stats_table *table)
 		strbuf_reset(&buf);
 		strbuf_addstr(&buf, "| ");
 		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
+
+		if (entry && entry->oid)
+			strbuf_addf(&buf, " [%" PRIuMAX "]",
+				    (uintmax_t)entry->index);
+		else
+			strbuf_addchars(&buf, ' ', INDEX_WIDTH);
+
 		strbuf_addstr(&buf, " | ");
 		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
 		strbuf_addch(&buf, ' ');
@@ -458,6 +508,12 @@ static void stats_table_print_structure(const struct stats_table *table)
 		printf("%s\n", buf.buf);
 	}
 
+	if (table->annotations.nr) {
+		printf("\n");
+		for_each_string_list_item(item, &table->annotations)
+			printf("%s\n", item->string);
+	}
+
 	strbuf_release(&buf);
 }
 
@@ -473,6 +529,7 @@ static void stats_table_clear(struct stats_table *table)
 	}
 
 	string_list_clear(&table->rows, 1);
+	string_list_clear(&table->annotations, 1);
 }
 
 static inline void print_keyvalue(const char *key, char key_delim, size_t value,
@@ -702,6 +759,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 {
 	struct stats_table table = {
 		.rows = STRING_LIST_INIT_DUP,
+		.annotations = STRING_LIST_INIT_DUP,
 	};
 	enum output_format format = FORMAT_TABLE;
 	struct repo_structure stats = { 0 };
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 1999f325d0..918af7269f 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -27,41 +27,41 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository structure | Value  |
-		| -------------------- | ------ |
-		| * References         |        |
-		|   * Count            |    0   |
-		|     * Branches       |    0   |
-		|     * Tags           |    0   |
-		|     * Remotes        |    0   |
-		|     * Others         |    0   |
-		|                      |        |
-		| * Reachable objects  |        |
-		|   * Count            |    0   |
-		|     * Commits        |    0   |
-		|     * Trees          |    0   |
-		|     * Blobs          |    0   |
-		|     * Tags           |    0   |
-		|   * Inflated size    |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		|   * Disk size        |    0 B |
-		|     * Commits        |    0 B |
-		|     * Trees          |    0 B |
-		|     * Blobs          |    0 B |
-		|     * Tags           |    0 B |
-		|                      |        |
-		| * Largest objects    |        |
-		|   * Commits          |        |
-		|     * Maximum size   |    0 B |
-		|   * Trees            |        |
-		|     * Maximum size   |    0 B |
-		|   * Blobs            |        |
-		|     * Maximum size   |    0 B |
-		|   * Tags             |        |
-		|     * Maximum size   |    0 B |
+		| Repository structure     | Value  |
+		| ------------------------ | ------ |
+		| * References             |        |
+		|   * Count                |    0   |
+		|     * Branches           |    0   |
+		|     * Tags               |    0   |
+		|     * Remotes            |    0   |
+		|     * Others             |    0   |
+		|                          |        |
+		| * Reachable objects      |        |
+		|   * Count                |    0   |
+		|     * Commits            |    0   |
+		|     * Trees              |    0   |
+		|     * Blobs              |    0   |
+		|     * Tags               |    0   |
+		|   * Inflated size        |    0 B |
+		|     * Commits            |    0 B |
+		|     * Trees              |    0 B |
+		|     * Blobs              |    0 B |
+		|     * Tags               |    0 B |
+		|   * Disk size            |    0 B |
+		|     * Commits            |    0 B |
+		|     * Trees              |    0 B |
+		|     * Blobs              |    0 B |
+		|     * Tags               |    0 B |
+		|                          |        |
+		| * Largest objects        |        |
+		|   * Commits              |        |
+		|     * Maximum size       |    0 B |
+		|   * Trees                |        |
+		|     * Maximum size       |    0 B |
+		|   * Blobs                |        |
+		|     * Maximum size       |    0 B |
+		|   * Tags                 |        |
+		|     * Maximum size       |    0 B |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -89,41 +89,46 @@ test_expect_success SHA1 'repository with references and objects' '
 		# git-rev-list(1) --disk-usage=human option printing the full
 		# "byte/bytes" unit string instead of just "B".
 		cat >expect <<-EOF &&
-		| Repository structure | Value      |
-		| -------------------- | ---------- |
-		| * References         |            |
-		|   * Count            |      4     |
-		|     * Branches       |      1     |
-		|     * Tags           |      1     |
-		|     * Remotes        |      1     |
-		|     * Others         |      1     |
-		|                      |            |
-		| * Reachable objects  |            |
-		|   * Count            |   3.02 k   |
-		|     * Commits        |   1.01 k   |
-		|     * Trees          |   1.01 k   |
-		|     * Blobs          |   1.01 k   |
-		|     * Tags           |      1     |
-		|   * Inflated size    |  16.03 MiB |
-		|     * Commits        | 217.92 KiB |
-		|     * Trees          |  15.81 MiB |
-		|     * Blobs          |  11.68 KiB |
-		|     * Tags           |    132 B   |
-		|   * Disk size        | $(object_type_disk_usage all true) |
-		|     * Commits        | $(object_type_disk_usage commit true) |
-		|     * Trees          | $(object_type_disk_usage tree true) |
-		|     * Blobs          |  $(object_type_disk_usage blob true) |
-		|     * Tags           |    $(object_type_disk_usage tag) B   |
-		|                      |            |
-		| * Largest objects    |            |
-		|   * Commits          |            |
-		|     * Maximum size   |    223 B   |
-		|   * Trees            |            |
-		|     * Maximum size   |  32.29 KiB |
-		|   * Blobs            |            |
-		|     * Maximum size   |     13 B   |
-		|   * Tags             |            |
-		|     * Maximum size   |    132 B   |
+		| Repository structure     | Value      |
+		| ------------------------ | ---------- |
+		| * References             |            |
+		|   * Count                |      4     |
+		|     * Branches           |      1     |
+		|     * Tags               |      1     |
+		|     * Remotes            |      1     |
+		|     * Others             |      1     |
+		|                          |            |
+		| * Reachable objects      |            |
+		|   * Count                |   3.02 k   |
+		|     * Commits            |   1.01 k   |
+		|     * Trees              |   1.01 k   |
+		|     * Blobs              |   1.01 k   |
+		|     * Tags               |      1     |
+		|   * Inflated size        |  16.03 MiB |
+		|     * Commits            | 217.92 KiB |
+		|     * Trees              |  15.81 MiB |
+		|     * Blobs              |  11.68 KiB |
+		|     * Tags               |    132 B   |
+		|   * Disk size            | $(object_type_disk_usage all true) |
+		|     * Commits            | $(object_type_disk_usage commit true) |
+		|     * Trees              | $(object_type_disk_usage tree true) |
+		|     * Blobs              |  $(object_type_disk_usage blob true) |
+		|     * Tags               |    $(object_type_disk_usage tag) B   |
+		|                          |            |
+		| * Largest objects        |            |
+		|   * Commits              |            |
+		|     * Maximum size   [1] |    223 B   |
+		|   * Trees                |            |
+		|     * Maximum size   [2] |  32.29 KiB |
+		|   * Blobs                |            |
+		|     * Maximum size   [3] |     13 B   |
+		|   * Tags                 |            |
+		|     * Maximum size   [4] |    132 B   |
+
+		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
+		[2] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
+		[3] 97d808e45116bf02103490294d3d46dad7a2ac62
+		[4] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.53.0

