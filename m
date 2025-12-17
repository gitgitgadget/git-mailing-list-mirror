Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43614346AE2
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765994055; cv=none; b=SOKyu8NXVb6imyL+TqeF7BvIl2UkOBno/8iFVjtpMQcWC6B2sdVai6BYj/hTk+7nbSllyRxEzbWGxt8KvqhyTYJkTCjqjJpQEWwjbxAdzPwaW/d6ecY1cHO0jzM1VSBWgi1GRcRfEtpG9Elx6X7URhmJMad4Jg6ronvCvMsXCoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765994055; c=relaxed/simple;
	bh=7n+MZu0uJITqIKkFzhBT4ai8bJfj5W0hkcprW4osVs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=egAF4zq0IUlkM0AKX4spo4FleZ7AizclJqZgTYh5wwlc8Z+zSdrFFenWLrm3Go7I0/5icHK1iGK9H0BWM4K9OeCwZxkrgti7izSGWwIVzXXNnNzd527MtxTDKUkGkzhe+9cxYWmz4ds1iaiO6C8SR/k5gA0RcZ8vbNfYdyvl/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUc6HcDD; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUc6HcDD"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-450823a7776so3780528b6e.2
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 09:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765994051; x=1766598851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SbYsQBBICDGTHqY54zn6XHWQ4OYy2EHQHiPcTopEvtU=;
        b=GUc6HcDDTxqDYvaBmCtwcJntNfEcQ3Ad/TdKutx7XjKrmLBGSoyqstwmdU/p0/vj9c
         ZJVSOrdH2a4EVh9fdDoL79L3RALlj55/0A9LImuG+ojSfm/vR6jVOFoM5qwMjCGi0rZp
         jdHWlvdEfVDkLV1SvU3ZNCR+Umj7VcZUXM7hwWMVOYh13CWiodqeOLEBGfbk1Mr2kf60
         AjuIy2Xyxg2XzfyseSBXkjyykKV7DZBPAOvVyyIPF6o3rwLIjsa6XP4dpu0tmp2WXUxU
         piakaNGMpMJuCU0m4Lr4quE9SBM3oKNg9bK98fJfZwtm09J3FdjIKxZiFOgVXwbhClt9
         uPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765994051; x=1766598851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SbYsQBBICDGTHqY54zn6XHWQ4OYy2EHQHiPcTopEvtU=;
        b=NvLHVgYooXhf1nxGd/RTcziFPayVLrjOH9dlSEyVyhBY5X6ElvxU795ImPOJ40T6Ju
         ZHO+3Ts1vf+a4E9j/yADIgk/VoLX+hjwzt9vxi64eiY7bd3U0JQaIu8FCdBwQZCoePTv
         1UerhNsadpRMnrZ/Ol6A4fTXoGfX4aTTDP6+nZ2f3JQ6t5yJzwE/zDTY+DvTBE/okPp3
         9NfBA8AO6konqINDr5krZN049G7qZFk/T6WhSy/TOsBoO02pazRKSsMudN+MksS0GFru
         rsv4B42WYFM/VEYybxmAZGWx3Fl350E39udALY8k9XA5yxjE6OkedQcJaGWt6MlG72wC
         zJww==
X-Gm-Message-State: AOJu0Yzaepkocn8el1M7kt3eifnWxyZVLbHjg8sIC4OfeLWjlKm+ZABR
	1OBHHZkqbAbIhMh6/eM2G086nymGhcEGh0eyg2XuJaMXt2zgrBiaSJk8xer2Ig==
X-Gm-Gg: AY/fxX4+gdOJ090EEc7FKwH/lTpO/UDAXMFDmQOrfY4tjxnpWG+lyF2z2uqkPg7e1dz
	vgY3bAujNyAyeHobzj3c1WOwh38aCN+NJKajE7kfDrT5XLNTnhisE8S4f4dO3ojwCt6Uznz5GKG
	4LagNR/Fhuqm/7fHaR7PXdjpcsk40p0a+PZcOSrEEVrVFZ7KpIc/scYTkOviSvjtiYVOjSk0zh4
	lESr7sZgSj9z5b8sr7xTFyU54bNYgcL7owL9Tw8Hongt3Bix/5xPyXjuWfcSBdR5CAH6JAhcbc5
	xL4vmoa8AFhg4aKrYxWhF563bCwebQY2Uvh0+C1vdz3n444VWrd7awHcxszEI6zVI5N8eioLKDc
	grDhyXAlzqv01UYDSntjJQTc0HzanpAs2lYYuXc3RV7Nfi3QlqzoCXGXrburxOzUeKZEq0WFWvw
	yO+PDf1IO6gmQl6mo4W1w=
X-Google-Smtp-Source: AGHT+IHs2AaillJJKw1LPbze2dkdri1pLVHc8MgghhudKDtcTnYQZPRoL0czVMqNph7aTvQ2OAygVg==
X-Received: by 2002:a05:6808:6604:b0:43c:afd4:646d with SMTP id 5614622812f47-455ac820646mr7693891b6e.14.1765994050709;
        Wed, 17 Dec 2025 09:54:10 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3fa17f4b879sm20058fac.14.2025.12.17.09.54.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 09:54:10 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 3/7] builtin/repo: humanise count values in structure output
Date: Wed, 17 Dec 2025 11:54:00 -0600
Message-ID: <20251217175404.37963-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251217175404.37963-1-jltobler@gmail.com>
References: <20251216173842.3357832-1-jltobler@gmail.com>
 <20251217175404.37963-1-jltobler@gmail.com>
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
 builtin/repo.c            | 38 +++++++++++++++++-------
 strbuf.c                  | 26 ++++++++++++++++
 strbuf.h                  |  6 ++++
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++--------------------
 4 files changed, 91 insertions(+), 41 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a69699857a..9c61bc3e17 100644
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
@@ -273,7 +282,7 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 	va_list ap;
 
 	CALLOC_ARRAY(entry, 1);
-	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+	humanise_count(value, &entry->value, &entry->unit);
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -324,20 +333,24 @@ static void stats_table_print_structure(const struct stats_table *table)
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
 
@@ -345,17 +358,20 @@ static void stats_table_print_structure(const struct stats_table *table)
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
@@ -363,6 +379,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
 		strbuf_addstr(&buf, " | ");
 		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
+		strbuf_addch(&buf, ' ');
+		strbuf_utf8_align(&buf, ALIGN_LEFT, unit_col_width, unit);
 		strbuf_addstr(&buf, " |");
 		printf("%s\n", buf.buf);
 	}
diff --git a/strbuf.c b/strbuf.c
index 349ee9727a..995ff15169 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,6 +836,32 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
+void humanise_count(size_t count, char **value, const char **unit)
+{
+	if (count >= 1000000000) {
+		size_t x = count + 5000000; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000000),
+				 (unsigned)(x % 1000000000 / 10000000));
+		/* TRANSLATORS: SI decimal prefix symbol for 10^9 */
+		*unit = _("G");
+	} else if (count >= 1000000) {
+		size_t x = count + 5000; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000000),
+				 (unsigned)(x % 1000000 / 10000));
+		/* TRANSLATORS: SI decimal prefix symbol for 10^6 */
+		*unit = _("M");
+	} else if (count >= 1000) {
+		size_t x = count + 5; /* for rounding */
+		*value = xstrfmt(_("%u.%2.2u"), (unsigned)(x / 1000),
+				 (unsigned)(x % 1000 / 10));
+		/* TRANSLATORS: SI decimal prefix symbol for 10^3 */
+		*unit = _("k");
+	} else {
+		*value = xstrfmt("%u", (unsigned)count);
+		*unit = NULL;
+	}
+}
+
 void humanise_bytes(off_t bytes, char **value, const char **unit,
 		    unsigned flags)
 {
diff --git a/strbuf.h b/strbuf.h
index 698b3cc4a5..52feef4c1b 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -381,6 +381,12 @@ enum humanise_flags {
 void humanise_bytes(off_t bytes, char **value, const char **unit,
 		    unsigned flags);
 
+/**
+ * Converts the given count into a downscaled human-readable value and
+ * corresponding unit as two separate strings.
+ */
+void humanise_count(size_t count, char **value, const char **unit);
+
 /**
  * Append the given byte size as a human-readable string (i.e. 12.23 KiB,
  * 3.50 MiB).
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

