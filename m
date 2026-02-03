Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B6436165E
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157119; cv=none; b=OLuurbFWPD0S5pD1r4WP04SBV/j2q4nqYBgVj9R5kq6ZFulKyDGnwHpU7Hjv9LaxJfE9iMjHCXrU8BWpA4QrQYijsz3lZq3nMNQuQUAjcQIcpQv6df89Sl7Z0DOizzgXX9P+wfsF+IYegx1u4CVocYMXFHeAzeiaj0xpbo2vjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157119; c=relaxed/simple;
	bh=X6Qn3cNRBF0sEn5+MTCpm1yAynIcgtUrDS4NbjYPDa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uALMnLQWlFmVZCOwaCD3jbUck1Co4M4vVkkXzpZxSz97sJ6PzrxbXIRIQm4ufxOy9hpSBzr05UBfMk7xniopW3XK9tmIdDm4j7T6gvEHd3NvwtM3qM/EE9f2rF4eclUf83EJO/DQ2QpdAXiQIOl40Bgb+m65h9xLp3rXdjjNL+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/GjvbJO; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/GjvbJO"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-45c7a71ba20so2113671b6e.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770157116; x=1770761916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4LeWC9Sne1xumvZFzCtbtgJroSLIAhuQnfbFcFNYyU=;
        b=e/GjvbJOk/P0Pm+6l+ykWHQVzuU/Vund5tAajH6z0u3WEsxoGRFPVoggua3AMVSKUQ
         6a280jEsMCWmPgVQyqGSoQMdhhYRatETeyBkSBzgawkAtOLXhR6gcYjp1Nm8EM2ch8Ku
         42MV5XiRk1ycTS51wl15g8OFkXitLdvQhRJKdWHR9HJWan75elowoEyhnt5E/UHi9fJ3
         YNEaNre67XIT1lWJu4jHLNklvzuJK1u7U7MIH4UvGFVLD/Wxl+mRw0D3GQtKhpkaUWFo
         eJH/PeyTXxhRhpfAcB5F8ynZah3KXI2IKuB8jPpCoF6bnt17Q0+OfrCKPBUpIrcR6mMG
         ca+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770157116; x=1770761916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d4LeWC9Sne1xumvZFzCtbtgJroSLIAhuQnfbFcFNYyU=;
        b=FmyzvHhyOrzbekEPVgLXLyQyZjpeYECbCTX5OVM7mHRwMKXW+dnPl3j0uqiwGN6ZzF
         iradWafjhChE/fqrC1tpBR0m+YNof1tiT6QgRMnB5nNZG+nnT6rrl0Zkc8JirRSRseLJ
         3BrH7NuCQF6+g7dqFtTeg2Q+JROEKwEI+xaWDG6mkNRNKFKluWD3YvRBfSQMgbTpbTUG
         dBc8dz/i/oGLCCDpxC98CLkP6fYf7FCqnyzFwCwxQ8Zh1df+tDHy9oQKxZOyUs8NzG7G
         9y37oNCkHfWwCalr7cNg0jel0DJM23ghDwsH09qtLY5f7EtdeEE2lR2Vt8Ro+B4J8S+X
         t5Eg==
X-Gm-Message-State: AOJu0Yx29v/TRxCqhvaycfSvTLlB92D0KJaURn7E7ihXYM8vAI/ygZAc
	hHHGaIFPnSC41T1jHdrWrgmmVSAzCnW8XIL7QpTLipWKajGXSco23VovID+3IA==
X-Gm-Gg: AZuq6aK1FafCDjtMJj9vPEZ7Tuj2bv8U6UkdyIN2TdcSuIuvTBCmXo5xpysHUVqYPo7
	6UAu/2Xoc9I5M55GDuxKngB6CsbRmAyb6+p9/GOiP5nN6srokLb/OjcGBbQtBsUx++7scWy06ip
	vPeP0WCGgS35OjpWz8nZXyzevwXL0OlMLif3jNY3W2bUOY0tl4ij2WfPQZJ2BRtHaEF09DEAwKa
	qeaOAZqpTCgtstW3sNXGyneDNqWEWA4081+Mdz2EPlwYpmuzzL4Dp+N/1LzsS1b6iVLOXNduHBG
	GiGL/2VQ/vXiaktxdFUBdBapEdWAKW516/Ssd5SXMzQ4HmRDQha9sm1so6xE0iFAM/t5U0r4DKm
	nDQoUznUPqXJXzGsuyVqosjgeaChTczdNy6Lfxjd9/mV+Pya4Hppt7rcBarjB/DS4HCtC6ViK2G
	qjzc/X//zacgy8RRIaMyk=
X-Received: by 2002:a05:6808:338a:b0:44f:ff2c:f65 with SMTP id 5614622812f47-462d5a28e1bmr479344b6e.38.1770157115715;
        Tue, 03 Feb 2026 14:18:35 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40a53c3c4dasm479042fac.0.2026.02.03.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:18:35 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 3/5] builtin/repo: add OID annotations to table output
Date: Tue,  3 Feb 2026 16:17:56 -0600
Message-ID: <20260203221758.1164434-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260203221758.1164434-1-jltobler@gmail.com>
References: <20260203221758.1164434-1-jltobler@gmail.com>
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
 builtin/repo.c            |  77 +++++++++++++++++---
 t/t1901-repo-structure.sh | 145 ++++++++++++++++++++------------------
 2 files changed, 142 insertions(+), 80 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 51a4359685..6fc2d9db12 100644
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
+		string_list_append(&table->annotations, buf.buf);
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
@@ -458,6 +508,11 @@ static void stats_table_print_structure(const struct stats_table *table)
 		printf("%s\n", buf.buf);
 	}
 
+	if (table->annotations.nr)
+		printf("\n");
+	for_each_string_list_item(item, &table->annotations)
+		printf("%s\n", item->string);
+
 	strbuf_release(&buf);
 }
 
@@ -473,6 +528,7 @@ static void stats_table_clear(struct stats_table *table)
 	}
 
 	string_list_clear(&table->rows, 1);
+	string_list_clear(&table->annotations, 1);
 }
 
 static void structure_keyvalue_print(struct repo_structure *stats,
@@ -695,6 +751,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
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

