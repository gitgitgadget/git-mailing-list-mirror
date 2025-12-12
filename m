Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8742D9496
	for <git@vger.kernel.org>; Fri, 12 Dec 2025 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579015; cv=none; b=gOVPW+DuSnd6Rskeg+ITkgWX/wGKg2ZZabPG9tvgCaq+nQCEtzyk8nIaNFWRS83kjkQNA6nbFq/3dn01kQ17XI9xwUsBTC6Yde2yiLlyWGXckfY+R7biwwM42RGtpEa8260x/3HpukwF6Qn/huM/klVyl2hZSrwa9FJawZFb1Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579015; c=relaxed/simple;
	bh=vs0+GuUFgqg2fqWBGIUHt6gJCMKNYiiN2fmGt+YtMiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bydQow0PAoTNAV2QnosiiIksO7tK3ACAhj4SF8WyLn9sgwdx+uzpJ9vxYSQMqRkgA2qHiP3LkxfJmSrlslLDQVTNEnnqpncB/bsxNjcx/zGD/QT9X4tcAHs6WTw9ikBxNFG/R0yf9xNarTdt3qd18X8Da6HU+B5+xgj7rLnRolQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCnKwj+B; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCnKwj+B"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45090ef26c6so628905b6e.2
        for <git@vger.kernel.org>; Fri, 12 Dec 2025 14:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765579011; x=1766183811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVR9sJ37kwXxVbdPzs4qfHl+MQQiWgxWuRH/aE2RgMo=;
        b=aCnKwj+ByGKfEMqIkU54KKnUXl1lQO4J65FNWyvzzxuUpp4JZp0LINBMpZPzdXdh4e
         7lFCKmc9Rny+gvZnOQgk1tjS6Z+v+A4naUP+1BWNn6ys/9A2KsWy/+q2YTfOSHfUwG01
         wkigOlNbTIpKaF66wlk9hPz5o6rWtesPzfMjzCChS5G7FS1QlEkM2nyGzP1qXTQ7COB3
         mBSug5fGkfb9HDm9Az3vf219IY/ZszlB80rpo5rdEY1tUbfU1imBCuBBLefzMgzf9Ox7
         uMr28DFVg8SkTbeBUSH/lcyLgvvUUYzj6AcLAbiArp0JGxszeQHCNRD2weHSjyfPfFE2
         aCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765579011; x=1766183811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qVR9sJ37kwXxVbdPzs4qfHl+MQQiWgxWuRH/aE2RgMo=;
        b=hZuhtoVZKLuN3nKbIu7rVLlivmIuaItEnAfd69cMVO2CusMU5JUemPkpVLbcb+/jRz
         3MGheHIfffql80v86z9GKYmXyLTf76MCR+0oZhTZNb+AIEfm6YMSgsnCuZc2wI+TWPNT
         4Br4cBEvHy97KH+7Ev9bClm3CkrdZySlq1zCKsiSsPtVWiXZ8hFLlBlCR0lakei+1AKc
         5oBHMKt+dsU0gWhAR7qon9ILpT4nQsgFTB8FNXQSTXJsyTGhMb9xQ08v06D5mx7ns9hA
         MGwb07wFsKWsM45X1ENNcy7yIxZXHPITwNixLIXIZFrTQgub76sgqOg0I5uuwaEPlRc4
         BaDA==
X-Gm-Message-State: AOJu0YzzYrUnzabtFvi0XoMhXQyaODAzBU/Tsv/Tfg7g9wlA7JTwVZ1I
	E3KOya697sUeSCKmqvQ0J49lQV7LkPbkxq2RnBIUZDW/a7Yg++wkJmbolaZAtg==
X-Gm-Gg: AY/fxX567agXNRZ97JlWXASSIUhNPFUMKHE2JPvYakMnJZapo/6XeQ+EBVnSFnPc/cE
	inh7EwGFAhTctjpM1f081yxNWAm2k8pZSESp7wI0ysqx7gfDIbbKKWqXq9ad+x+0YHjokDpPGhd
	mUTlYGHSr/UD3oyqUkIJRGmWeWzhAFigWwaXyIcmoZS7VJUnmTQxRCb4u/kdZPcaF7ZjUlyTj+B
	9Yu/I07EEBAGvOvy6MXjCk2CNX7D66ZKI/7k0/mFRo4qH0wMtJixB577dw8wqgMocDAfTolwyN0
	umIg4xDAXfLWtZb8+zafAw7qNcUGkX9TMNaDvQtwDJ1yJAUWVem1dtFu+NVSaWIFBkTk5IRSqoG
	e8Qj3iwQtiOofg7o8ePLlHnCGfIe2/IB7EVroHnNl9GW6JNSMRRe5qq35jlDEWRtrLPBLblwLdh
	hx53QO9/3T5yKb6Lq0OYI=
X-Google-Smtp-Source: AGHT+IFy9AT7oCbcrdWaJoc3hadmzJ+0Uu6Ta8p6UpA5R/GMtIPb+lOBNCvQPGEzX4ArbLb6MXQF0g==
X-Received: by 2002:a05:6808:1890:b0:453:59f5:e3b2 with SMTP id 5614622812f47-455ac9645dcmr2441349b6e.46.1765579010878;
        Fri, 12 Dec 2025 14:36:50 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3f614ded1b3sm173998fac.10.2025.12.12.14.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 14:36:50 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 3/7] builtin/repo: humanise count values in structure output
Date: Fri, 12 Dec 2025 16:36:40 -0600
Message-ID: <20251212223644.3090879-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.52.0.209.ge85ae279b0
In-Reply-To: <20251212223644.3090879-1-jltobler@gmail.com>
References: <20251209225820.2861276-1-jltobler@gmail.com>
 <20251212223644.3090879-1-jltobler@gmail.com>
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
 builtin/repo.c            | 45 +++++++++++++++++++++-------
 strbuf.c                  | 23 +++++++++++++++
 strbuf.h                  |  7 +++++
 t/t1901-repo-structure.sh | 62 +++++++++++++++++++--------------------
 4 files changed, 95 insertions(+), 42 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index a69699857a..d3dfe416d0 100644
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
+	char *unit;
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
@@ -270,10 +279,13 @@ static void stats_table_count_addf(struct stats_table *table, size_t value,
 				   const char *format, ...)
 {
 	struct stats_table_entry *entry;
+	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
 
 	CALLOC_ARRAY(entry, 1);
-	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+
+	entry->unit = strbuf_humanise_count_value(&buf, value);
+	entry->value = strbuf_detach(&buf, NULL);
 
 	va_start(ap, format);
 	stats_table_vaddf(table, entry, format, ap);
@@ -324,20 +336,24 @@ static void stats_table_print_structure(const struct stats_table *table)
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
 
@@ -345,17 +361,20 @@ static void stats_table_print_structure(const struct stats_table *table)
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
@@ -363,6 +382,8 @@ static void stats_table_print_structure(const struct stats_table *table)
 		strbuf_utf8_align(&buf, ALIGN_LEFT, name_col_width, item->string);
 		strbuf_addstr(&buf, " | ");
 		strbuf_utf8_align(&buf, ALIGN_RIGHT, value_col_width, value);
+		strbuf_addch(&buf, ' ');
+		strbuf_utf8_align(&buf, ALIGN_LEFT, unit_col_width, unit);
 		strbuf_addstr(&buf, " |");
 		printf("%s\n", buf.buf);
 	}
@@ -377,8 +398,10 @@ static void stats_table_clear(struct stats_table *table)
 
 	for_each_string_list_item(item, &table->rows) {
 		entry = item->util;
-		if (entry)
+		if (entry) {
 			free(entry->value);
+			free(entry->unit);
+		}
 	}
 
 	string_list_clear(&table->rows, 1);
diff --git a/strbuf.c b/strbuf.c
index 1fb47bf21b..cebb1593ab 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -836,6 +836,29 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
 	strbuf_add_urlencode(sb, s, strlen(s), allow_unencoded_fn);
 }
 
+char *strbuf_humanise_count_value(struct strbuf *buf, size_t value)
+{
+	if (value >= 1000000000) {
+		uintmax_t x = (uintmax_t)value + 5000000; /* for rounding */
+		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
+			    x / 1000000000, x % 1000000000 / 10000000);
+		return xstrfmt(_("G"));
+	} else if (value >= 1000000) {
+		uintmax_t x = (uintmax_t)value + 5000; /* for rounding */
+		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
+			    x / 1000000, x % 1000000 / 10000);
+		return xstrfmt(_("M"));
+	} else if (value >= 1000) {
+		uintmax_t x = (uintmax_t)value + 5; /* for rounding */
+		strbuf_addf(buf, "%" PRIuMAX ".%02" PRIuMAX,
+			    x / 1000, x % 1000 / 10);
+		return xstrfmt(_("k"));
+	} else {
+		strbuf_addf(buf, "%" PRIuMAX, (uintmax_t)value);
+		return NULL;
+	}
+}
+
 char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags)
 {
 	int humanise_rate = flags & STRBUF_HUMANISE_RATE;
diff --git a/strbuf.h b/strbuf.h
index a5e3ab0cb4..7532eadd02 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -376,6 +376,13 @@ void strbuf_add_percentencode(struct strbuf *dst, const char *src, int flags);
  */
 char *strbuf_humanise_bytes_value(struct strbuf *buf, off_t bytes, unsigned flags);
 
+/**
+ * Append the given count value as a human-readable string that is downsacled by
+ * some factor. A string with the corresponding unit prefix is returned
+ * separately.
+ */
+char *strbuf_humanise_count_value(struct strbuf *buf, size_t value);
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

