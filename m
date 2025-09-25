Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084CD2EE27C
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 23:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842981; cv=none; b=pwc/Cxb+y5wViIdeAwumgdPU9Ied192koDxCJJ+6M+oluHD52ivq8CJzP47BDZILDSqLph6pR3R8gatIRcWPjwDocpKiuv5bC+s69gRmKRACq/C4YeVCQL38kSVK3AC4K/R2YqW/CodxZny5Hk2IbY3qzwvT0h7c/Pu13kfjRao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842981; c=relaxed/simple;
	bh=Yn9lhm7gyIARtoQ47vwLdk/4SejPG7DzAQuNSrbjW40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHwp8u+joBcYUzNZgJmq30lULmcoqyHBkpDdZ/3hTm+kZPEIOq0QtsYe10eS+zVw9aC0ygWYez8Uq9P8+ggV20GpvxIZxIp6JUpxGJyBPVe+BAt9RLU1K7ioFceTzAB3axIq8VVjx6Bs4l8NN6dzGIk7fJwEoelvDK8QzfAFVA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XumAhz2w; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XumAhz2w"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-35bdcaf79e7so1216589fac.0
        for <git@vger.kernel.org>; Thu, 25 Sep 2025 16:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758842979; x=1759447779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqHOOiBm75FZe9uKk/l3sxX5+JzKX8R/KasVSiJx1d8=;
        b=XumAhz2wDm/8YeXCQSHOw6gmp6hqHrWno4mbVv4gQ7p1DnR6/TP/tDH9YSwd+RtzWt
         cU2n+rmk5WAC0HBupt8mrNtG8LqtkvEvnbMx36rfknOB5pu7x0LloCI7RbKdgO8XibqH
         ER3UvD/5b50qICFgicn7NJ7uKGbS+7I1JZF5tOB/lnLOLhc9Ud/WF30N8SNJnsIJjMlx
         uRxjpFAoorougpfa/iE6aiZ503gMVPrmLGOmSoq6UkwO4imAojd3BCUEpnLeS7IFqjQX
         qLYFVvP8jOtv1WpyexY5n4slo6nS6gKox2hj3u9SmYOlmU/ENYCqMRKQQiowj7o24YpH
         MirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758842979; x=1759447779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqHOOiBm75FZe9uKk/l3sxX5+JzKX8R/KasVSiJx1d8=;
        b=ad21VHhp2VfWJOJ0D4mX3ldH4M8whmAxbaPd1OeVNrPsgyPdNzb8tuNApvDZD/hQyE
         fAbLcu973U4+KhO3swswyyaxvqHRww+yj1j9MUIPtQJfcmx47m//Dgci+Ch4dXoN26pT
         5qdF8DMHE5Igb9zQQ8Bf23z7YkTy2xMWz8N+k88F99UgEYgNAd2/fLfIC0mPmhyGu39F
         f12jAWl2zapPwm9NdZ/FO0KyrawMIGOUpo+XOGdBfBLPedD1FFzEOZZ2CEqsiuhb6aUS
         zKgtErmGDfmodmoyxNQYAVHU9bWssE3cjZZzKWKgC9eiY20V5t9+RPDL4eZSGhYRfrDz
         O/aw==
X-Gm-Message-State: AOJu0YwYQw7fCzllDThT4OV3hEFzzbsolJoorQ6L/soi7AFlptYCdnUq
	joOOb5CCxzFmHYys2+PxYtIJ6sBK1BNuEzX/O0hXh3qTS7uBPCYzlgfhoZJAgg==
X-Gm-Gg: ASbGncszYOyGTomT1gabGWjqtT74bHA5rIxAcy7N/RRY1+gwHYBdgTd0gSDwFlBRLd7
	Lot5vlBNY8Uyzu5sASrrifS5wlYb/AJoel34OdU1SVSszQ9u2d8Ljm/phRGtR1zh210KbvGkrll
	IGh2O6wKMB+3A+9FMGreNkEq65f4iJ1gO3BDoydPbsg5w9OgNE8/qmuJcBby7KjyLMMO+WRI/rs
	kW8b0l+i1VsUlnGhqjb5rEb1oQoyMebd1d6bAolcbSAb+G42h9kSYEM9IpsI/rbVqeLRyRSmp7m
	jwu9RYd1m8WMTBSKWQOINNzpzSAVb3mIienzaCHLVF3rBEnPqkm6AWs9ID3csr872Y1YFhjt0zY
	nvhvH2hiwT6ZKKZn0oUy3YIR7xPNGbzFxzu8+IeszPg==
X-Google-Smtp-Source: AGHT+IGcsLDqhxSxlQ1NfstgvCtV7X1fTtsqKV4llmow3putTTIN7EwgnTlRLWCxFMIakKVmjGQJVg==
X-Received: by 2002:a05:6871:107:b0:331:7220:f4e7 with SMTP id 586e51a60fabf-35eea09ee77mr2652221fac.33.1758842978690;
        Thu, 25 Sep 2025 16:29:38 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7a2402e5d70sm674273a34.36.2025.09.25.16.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:29:38 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v3 4/7] builtin/repo: introduce stats subcommand
Date: Thu, 25 Sep 2025 18:29:25 -0500
Message-ID: <20250925232928.3846-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250925232928.3846-1-jltobler@gmail.com>
References: <20250924212426.2930029-1-jltobler@gmail.com>
 <20250925232928.3846-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shape of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface key stats/information regarding the shape of a
repository via a single command. Acquiring this information requires
users to be fairly knowledgeable about the structure of a Git repository
and how to identify the relevant data points. To fill this gap,
supplemental tools such as git-sizer(1) have been developed.

To allow users to more readily identify potential issues for a
repository, introduce the "stats" subcommand in git-repo(1) to output
stats for the repository that may be of interest to users. The goal of
this subcommand is to eventually provide similar functionality to
git-sizer(1), but natively in Git.

The initial version of this command only iterates through all references
in the repository and tracks the count of branches, tags, remote refs,
and other reference types. The corresponding information is displayed in
a human-friendly table formatted in a very similar manner to
git-sizer(1). The width of each table column is adjusted automatically
to satisfy the requirements of the widest row contained.

Subsequent commits will surface additional relevant data points to
output.

Based-on-patch-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  10 ++
 builtin/repo.c              | 196 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       |  61 +++++++++++
 4 files changed, 268 insertions(+)
 create mode 100755 t/t1901-repo-stats.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..a009bf8cf1 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo stats
 
 DESCRIPTION
 -----------
@@ -43,6 +44,15 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`stats`::
+	Retrieve statistics about the current repository. The following kinds
+	of information are reported:
++
+* Reference counts categorized by type
+
++
+The table output format may change and is not intended for machine parsing.
+
 INFO KEYS
 ---------
 In order to obtain a set of values from `git repo info`, you should provide
diff --git a/builtin/repo.c b/builtin/repo.c
index eeeab8fbd2..0b7dd636e5 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -4,12 +4,15 @@
 #include "environment.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo stats",
 	NULL
 };
 
@@ -156,12 +159,205 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	return print_fields(argc, argv, repo, format);
 }
 
+struct ref_stats {
+	size_t branches;
+	size_t remotes;
+	size_t tags;
+	size_t others;
+};
+
+struct stats_table {
+	struct string_list rows;
+
+	size_t name_col_width;
+	size_t value_col_width;
+};
+
+/*
+ * Holds column data that gets stored for each row.
+ */
+struct stats_table_entry {
+	char *value;
+};
+
+static void stats_table_vaddf(struct stats_table *table,
+			      struct stats_table_entry *entry,
+			      const char *format, va_list ap)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	char *formatted_name;
+	size_t name_width;
+
+	strbuf_vaddf(&buf, format, ap);
+	formatted_name = strbuf_detach(&buf, &name_width);
+
+	item = string_list_append_nodup(&table->rows, formatted_name);
+	item->util = entry;
+
+	if (name_width > table->name_col_width)
+		table->name_col_width = name_width;
+	if (entry) {
+		size_t value_width = strlen(entry->value);
+		if (value_width > table->value_col_width)
+			table->value_col_width = value_width;
+	}
+}
+
+static void stats_table_addf(struct stats_table *table, const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	stats_table_vaddf(table, NULL, format, ap);
+	va_end(ap);
+}
+
+static void stats_table_count_addf(struct stats_table *table, size_t value,
+				   const char *format, ...)
+{
+	struct stats_table_entry *entry;
+	va_list ap;
+
+	CALLOC_ARRAY(entry, 1);
+	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+
+	va_start(ap, format);
+	stats_table_vaddf(table, entry, format, ap);
+	va_end(ap);
+}
+
+static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
+{
+	size_t ref_total;
+
+	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
+	stats_table_addf(table, "* %s", _("References"));
+	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
+	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
+	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
+	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+}
+
+static inline size_t max_size_t(size_t a, size_t b)
+{
+	return (a > b) ? a : b;
+}
+
+static void stats_table_print(const struct stats_table *table)
+{
+	const char *name_col_title = _("Repository stats");
+	const char *value_col_title = _("Value");
+	size_t name_title_len = strlen(name_col_title);
+	size_t value_title_len = strlen(value_col_title);
+	struct string_list_item *item;
+	int name_col_width;
+	int value_col_width;
+
+	name_col_width = cast_size_t_to_int(
+		max_size_t(table->name_col_width, name_title_len));
+	value_col_width = cast_size_t_to_int(
+		max_size_t(table->value_col_width, value_title_len));
+
+	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
+	       value_col_width, value_col_title);
+	printf("| ");
+	for (int i = 0; i < name_col_width; i++)
+		putchar('-');
+	printf(" | ");
+	for (int i = 0; i < value_col_width; i++)
+		putchar('-');
+	printf(" |\n");
+
+	for_each_string_list_item(item, &table->rows) {
+		struct stats_table_entry *entry = item->util;
+		const char *value = "";
+
+		if (entry) {
+			struct stats_table_entry *entry = item->util;
+			value = entry->value;
+		}
+
+		printf("| %-*s | %*s |\n", name_col_width, item->string,
+		       value_col_width, value);
+	}
+}
+
+static void stats_table_clear(struct stats_table *table)
+{
+	struct stats_table_entry *entry;
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, &table->rows) {
+		entry = item->util;
+		if (entry)
+			free(entry->value);
+	}
+
+	string_list_clear(&table->rows, 1);
+}
+
+static void stats_count_references(struct ref_stats *stats, struct ref_array *refs)
+{
+	for (int i = 0; i < refs->nr; i++) {
+		struct ref_array_item *ref = refs->items[i];
+
+		switch (ref->kind) {
+		case FILTER_REFS_BRANCHES:
+			stats->branches++;
+			break;
+		case FILTER_REFS_REMOTES:
+			stats->remotes++;
+			break;
+		case FILTER_REFS_TAGS:
+			stats->tags++;
+			break;
+		case FILTER_REFS_OTHERS:
+			stats->others++;
+			break;
+		default:
+			BUG("unexpected reference type");
+		}
+	}
+}
+
+static int cmd_repo_stats(int argc, const char **argv, const char *prefix,
+			  struct repository *repo UNUSED)
+{
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct stats_table table = {
+		.rows = STRING_LIST_INIT_DUP,
+	};
+	struct ref_stats stats = { 0 };
+	struct ref_array refs = { 0 };
+	struct option options[] = { 0 };
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	if (filter_refs(&refs, &filter, FILTER_REFS_REGULAR))
+		die(_("unable to filter refs"));
+
+	stats_count_references(&stats, &refs);
+
+	stats_table_setup(&table, &stats);
+	stats_table_print(&table);
+
+	stats_table_clear(&table);
+	ref_array_clear(&refs);
+
+	return 0;
+}
+
 int cmd_repo(int argc, const char **argv, const char *prefix,
 	     struct repository *repo)
 {
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
 		OPT_SUBCOMMAND("info", &fn, cmd_repo_info),
+		OPT_SUBCOMMAND("stats", &fn, cmd_repo_stats),
 		OPT_END()
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..071d4a5112 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -236,6 +236,7 @@ integration_tests = [
   't1701-racy-split-index.sh',
   't1800-hook.sh',
   't1900-repo.sh',
+  't1901-repo-stats.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1901-repo-stats.sh b/t/t1901-repo-stats.sh
new file mode 100755
index 0000000000..535ac511dd
--- /dev/null
+++ b/t/t1901-repo-stats.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='test git repo stats'
+
+. ./test-lib.sh
+
+test_expect_success 'empty repository' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		| Repository stats | Value |
+		| ---------------- | ----- |
+		| * References     |       |
+		|   * Count        |     0 |
+		|     * Branches   |     0 |
+		|     * Tags       |     0 |
+		|     * Remotes    |     0 |
+		|     * Others     |     0 |
+		EOF
+
+		git repo stats >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_expect_success 'repository with references' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		git commit --allow-empty -m init &&
+		git tag -a foo -m bar &&
+
+		oid="$(git rev-parse HEAD)" &&
+		git update-ref refs/remotes/origin/foo "$oid" &&
+
+		git notes add -m foo &&
+
+		cat >expect <<-\EOF &&
+		| Repository stats | Value |
+		| ---------------- | ----- |
+		| * References     |       |
+		|   * Count        |     4 |
+		|     * Branches   |     1 |
+		|     * Tags       |     1 |
+		|     * Remotes    |     1 |
+		|     * Others     |     1 |
+		EOF
+
+		git repo stats >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_done
-- 
2.51.0.193.g4975ec3473b

