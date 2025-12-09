Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8652F8BEE
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 22:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765321111; cv=none; b=qxJhRmCDCq37YKEZAEBne+PqGlcQpbjOhtwtakucxuSN+G4MJMiHaD+8jr6u+hCEvBLAHGUnuC/M24fJ1fHlos/LZU2LUFNOBnGHCENxldpUh4CLWfhkEM3qtwFmeofZU6d8W3Do3cW9nD/5wERGHV0Le78jPxieF1V51pZL/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765321111; c=relaxed/simple;
	bh=DJ4WyQVAQz9ETxUxlexGjbWe4T/2XgbhMd+SmjZcZ2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JizSEetuRZiyoshR3wMCiQ3YU5qkXS8FFU5vb7ewH2il66B9iocau28mRQBt4tpWeYaN24DHlyG8BO0ux5Uep84F+qAHe7YD25TO2Gpar3zXkcZAom/Jz1QkGukM1qQofNgOOf85BrcYwQAi8lwoSzsvhNstWjzeO4fiMAAkw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Grrn0Yim; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Grrn0Yim"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-450823a7776so2703416b6e.2
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 14:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765321108; x=1765925908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0kvErmEuR+Dz89uSzf4/m7HW1MpyaDNWdXlW9W3rBw=;
        b=Grrn0YimfH1KpMpD5+pRphASBOGZ4J7pkj5mAlaz7EcQ16LYyYpcLmowkhiQonQHM8
         XWAZrj6108F3HmU/a5G3BwgjiJ7XOLlQ3txhkkFGoBEPl+19JPVB1RW7qixT/5gDpWYz
         03sR1Uk/NhmJ8rYw5erKtfTFUAKNVZ10GDIp95elx6vfbEQE89klCPXZDwyVQMIwl06N
         DsPyG/e4MBulXR8NKXUbiCRv9lPLDBPpA9FtAutotBwtEiC2uJN/8tHZmmgBoyhRYyNX
         7o24Y7k1P10kHM1Vdafew7sUxuLwU8tUXEhmvQ1ES+CImdPUwfZo9IB28Z058Y7v2ALf
         54xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765321108; x=1765925908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m0kvErmEuR+Dz89uSzf4/m7HW1MpyaDNWdXlW9W3rBw=;
        b=hZ2kHCrN5TJjpo5cgZl8lCVx3Z50jQOnYU01wg3RxrxDgxjCFGgV6Z+hipEUpHGDsY
         0QykoN0n9PZhRLJMGdKpLKtdNESxAYrdexTS6qlO9M+jdMh3m1MqBXParccHMntHtwGT
         psWJ7bSCvd35exQuyYRaNpzQSqoULbx4D9tnuEDt0ON3x718NpO8+4KDF8q0FW+72H4c
         llK7hvgl5RooJyojb4txf+b+7xajDW7bfvBCLO5LWNUYHBZlPuxnO7HcS0faDkaOi3bY
         7fdiUtV7EIWcVmaU2knCBdWHlQq1zZ/BnHwHUMxTExzWcwy3EO7JGxJP4DQvMGWXZCXg
         tzsg==
X-Gm-Message-State: AOJu0Yw1myO+kRzYHtzIegKT4drUhS0PnmVAnfkt0qwTdEELjiJau4NG
	GnJTMAQ/Qwd//dnukRcXAzRdmO/Pu1DFNoPbjEkKV/fiH8p8ue49oyjO6uef3g==
X-Gm-Gg: ASbGncuJ7cZmxCnEGT1ve4dtjTvMaaFJV+zFmzJas5aFIhk9hwn2KvtPbDPzL1grjOK
	i6V2r/Cl3lnJ5IF5XNyOW070tiwNbV/GV3f/G+CHuHx91cweqo++lE/ob+1SlGZ+wcEfySgGZE9
	Pak1EoHN3r+/cW8z4TKHqjP5pB2yRDf5orYuXSOPV1eWHCByzZgTpBPqYf9W6B/KOnkbgeIpdC1
	PaqiNEl4fCBCR8xAjEdh4KrF97wgqkvhOA83qxtJHS7b8xOFxVbMU0Yna0TWD9vSzHJEW6h9aUb
	P9xrwboTbSr6IrnDCWvl3z/XTr7qgd+3OJGmVZXW5gaHLzaTmpj2QTwEt3KlblfNRLuBpN/ih9R
	pcg9+z/twz72wD5OA0jbJNnTOl1oNaboEo06gPbFJaARD+Nkj8zkJBm37mFDRH+TdEEt6lSaUId
	UJrDdmvttAoVB+/HB2tU4=
X-Google-Smtp-Source: AGHT+IGVM7xc20vFGuLEPmI5N/Ygv6SqCoRrZtvJxXsHHLsbUW7UzYZbr4kRZq7ytqG2E80x8rkbtA==
X-Received: by 2002:a05:6808:1527:b0:455:7fa2:11c9 with SMTP id 5614622812f47-455864e8a98mr335908b6e.38.1765321108475;
        Tue, 09 Dec 2025 14:58:28 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4537f8a02desm8161354b6e.5.2025.12.09.14.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 14:58:28 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 2/6] builtin/repo: humanise count values in structure output
Date: Tue,  9 Dec 2025 16:58:16 -0600
Message-ID: <20251209225820.2861276-3-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251209225820.2861276-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The table output format for the git-repo(1) structure subcommand is used
by default and intended to provide output to users in a human-friendly
manner. When the reference/object count values in a repository are
large, it becomes more cumbersome for users to read the values.

For larger values, update the table output format to instead produce
more human-friendly count values that are scaled down with the
appropriate unit prefix. Output for the keyvalue and nul formats remains
unchanged.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 builtin/repo.c            | 61 +++++++++++++++++++++++++++++++-------
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++--------------------
 2 files changed, 82 insertions(+), 41 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a69699857a..8fb728b3a5 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -223,6 +223,7 @@ struct stats_table {
 
 	int name_col_width;
 	int value_col_width;
+	int unit_col_width;
 };
 
 /*
@@ -230,6 +231,7 @@ struct stats_table {
  */
 struct stats_table_entry {
 	char *value;
+	const char *unit;
 };
 
 static void stats_table_vaddf(struct stats_table *table,
@@ -250,11 +252,18 @@ static void stats_table_vaddf(struct stats_table *table,
 
 	if (name_width > table->name_col_width)
 		table->name_col_width = name_width;
-	if (entry) {
+	if (!entry)
+		return;
+	if (entry->value) {
 		int value_width = utf8_strwidth(entry->value);
 		if (value_width > table->value_col_width)
 			table->value_col_width = value_width;
 	}
+	if (entry->unit) {
+		int unit_width = utf8_strwidth(entry->unit);
+		if (unit_width > table->unit_col_width)
+			table->unit_col_width = unit_width;
+	}
 }
 
 static void stats_table_addf(struct stats_table *table, const char *format, ...)
@@ -266,6 +275,10 @@ static void stats_table_addf(struct stats_table *table, const char *format, ...)
 	va_end(ap);
 }
 
+static const char *unit_k = "k";
+static const char *unit_M = "M";
+static const char *unit_G = "G";
+
 static void stats_table_count_addf(struct stats_table *table, size_t value,
 				   const char *format, ...)
 {
@@ -273,7 +286,26 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_list ap;
 
 	CALLOC_ARRAY(entry, 1);
-	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+
+	if (value >= 1000000000) {
+		uintmax_t x = (uintmax_t)value + 5000000;
+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
+				       x / 1000000000,
+				       x % 1000000000 / 10000000);
+		entry->unit = unit_G;
+	} else if (value >= 1000000) {
+		uintmax_t x = (uintmax_t)value + 5000;
+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
+				       x / 1000000, x % 1000000 / 10000);
+		entry->unit = unit_M;
+	} else if (value >= 1000) {
+		uintmax_t x = (uintmax_t)value + 5;
+		entry->value = xstrfmt("%" PRIuMAX ".%02" PRIuMAX,
+				       x / 1000, x % 1000 / 10);
+		entry->unit = unit_k;
+	} else {
+		entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+	}
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -324,20 +356,24 @@ static void stats_table_print_structure(const struct stats_table *table)
 {
 	const char *name_col_title = _("Repository structure");
 	const char *value_col_title = _("Value");
-	int name_col_width = utf8_strwidth(name_col_title);
-	int value_col_width = utf8_strwidth(value_col_title);
+	int title_name_width = utf8_strwidth(name_col_title);
+	int title_value_width = utf8_strwidth(value_col_title);
+	int name_col_width = table->name_col_width;
+	int value_col_width = table->value_col_width;
+	int unit_col_width = table->unit_col_width;
 	struct string_list_item *item;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (table->name_col_width > name_col_width)
-		name_col_width = table->name_col_width;
-	if (table->value_col_width > value_col_width)
-		value_col_width = table->value_col_width;
+	if (title_name_width > name_col_width)
+		name_col_width = title_name_width;
+	if (title_value_width > value_col_width + unit_col_width + 1)
+		value_col_width = title_value_width - unit_col_width;
 
 	strbuf_addstr(&buf, "| ");
 	strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, name_col_title);
 	strbuf_addstr(&buf, " | ");
-	strbuf_utf8_align(&buf, ALIGN_LEFT, value_col_width, value_col_title);
+	strbuf_utf8_align(&buf, ALIGN_LEFT,
+			  value_col_width + unit_col_width + 1, value_col_title);
 	strbuf_addstr(&buf, " |");
 	printf("%s\n", buf.buf);
 
@@ -345,17 +381,20 @@ static void stats_table_print_structure(const struct stats_table *table)
 	for (int i = 0; i < name_col_width; i++)
 		putchar('-');
 	printf(" | ");
-	for (int i = 0; i < value_col_width; i++)
+	for (int i = 0; i < value_col_width + unit_col_width + 1; i++)
 		putchar('-');
 	printf(" |\n");
 
 	for_each_string_list_item(item, &table->rows) {
 		struct stats_table_entry *entry = item->util;
 		const char *value = "";
+		const char *unit = "";
 
 		if (entry) {
 			struct stats_table_entry *entry = item->util;
 			value = entry->value;
+			if (entry->unit)
+				unit = entry->unit;
 		}
 
 		strbuf_reset(&buf);
@@ -363,6 +402,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
 		strbuf_addstr(&buf, " | ");
 		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
+		strbuf_addch(&buf, ' ');
+		strbuf_utf8_align(&buf, ALIGN_LEFT, unit_col_width, unit);
 		strbuf_addstr(&buf, " |");
 		printf("%s\n", buf.buf);
 	}
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 36a71a144e..55fd13ad1b 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -10,21 +10,21 @@ test_expect_success 'empty repository' '
 	(
 		cd repo &&
 		cat >expect <<-\EOF &&
-		| Repository structure | Value |
-		| -------------------- | ----- |
-		| * References         |       |
-		|   * Count            |     0 |
-		|     * Branches       |     0 |
-		|     * Tags           |     0 |
-		|     * Remotes        |     0 |
-		|     * Others         |     0 |
-		|                      |       |
-		| * Reachable objects  |       |
-		|   * Count            |     0 |
-		|     * Commits        |     0 |
-		|     * Trees          |     0 |
-		|     * Blobs          |     0 |
-		|     * Tags           |     0 |
+		| Repository structure | Value  |
+		| -------------------- | ------ |
+		| * References         |        |
+		|   * Count            |     0  |
+		|     * Branches       |     0  |
+		|     * Tags           |     0  |
+		|     * Remotes        |     0  |
+		|     * Others         |     0  |
+		|                      |        |
+		| * Reachable objects  |        |
+		|   * Count            |     0  |
+		|     * Commits        |     0  |
+		|     * Trees          |     0  |
+		|     * Blobs          |     0  |
+		|     * Tags           |     0  |
 		EOF
 
 		git repo structure >out 2>err &&
@@ -39,7 +39,7 @@ test_expect_success 'repository with references and objects' '
 	git init repo &&
 	(
 		cd repo &&
-		test_commit_bulk 42 &&
+		test_commit_bulk 1005 &&
 		git tag -a foo -m bar &&
 
 		oid="$(git rev-parse HEAD)" &&
@@ -49,21 +49,21 @@ test_expect_success 'repository with references and objects' '
 		git notes add -m foo &&
 
 		cat >expect <<-\EOF &&
-		| Repository structure | Value |
-		| -------------------- | ----- |
-		| * References         |       |
-		|   * Count            |     4 |
-		|     * Branches       |     1 |
-		|     * Tags           |     1 |
-		|     * Remotes        |     1 |
-		|     * Others         |     1 |
-		|                      |       |
-		| * Reachable objects  |       |
-		|   * Count            |   130 |
-		|     * Commits        |    43 |
-		|     * Trees          |    43 |
-		|     * Blobs          |    43 |
-		|     * Tags           |     1 |
+		| Repository structure | Value  |
+		| -------------------- | ------ |
+		| * References         |        |
+		|   * Count            |    4   |
+		|     * Branches       |    1   |
+		|     * Tags           |    1   |
+		|     * Remotes        |    1   |
+		|     * Others         |    1   |
+		|                      |        |
+		| * Reachable objects  |        |
+		|   * Count            | 3.02 k |
+		|     * Commits        | 1.01 k |
+		|     * Trees          | 1.01 k |
+		|     * Blobs          | 1.01 k |
+		|     * Tags           |    1   |
 		EOF
 
 		git repo structure >out 2>err &&
-- 
2.52.0.209.ge85ae279b0

