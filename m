Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F51E28750C
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 21:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758749076; cv=none; b=n4UEcpirXfvLQa6uGKsbd45Z6prf8lnkZrElEMofnGSNtWdZ5g48BZSdC6/CactjKrTOeRIiB1gXZTkfLqtPCA2alEFf28j8QeJh/Xrh1Op00qFiH0IfvZxAsHCzgw4fAIA4rlJLTZ7DMrhfyoPeGxAUutTTu5NnM/d3I2tXUmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758749076; c=relaxed/simple;
	bh=PlfWUTeJOdJUeRwHzbu0meyfPVo+f+IQDD6CEIv1URg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uERXjaONddURQmLELA71HL9UTD/df394f3TFKuG6JIVWUU70KYy3puoYeBBVAajF+ear3jvfiVW/N113PqSlMkCE5lf+IyW0MXGxiojcNePkZXngCaYeeUlRg9LrOniq3Pj20mwbodEPbSgPgBd9ZHe6YiNYIF7xqw8WWHlvEqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8HbEV52; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8HbEV52"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-30ccec59b4bso207845fac.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 14:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758749073; x=1759353873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9VyM0WNdpp3RBuk8JO7Jjfzk2kEITU00kNnIncmKpxg=;
        b=f8HbEV52nlUrivylbMfRBzG2OaDPHQcO6eQ1WA766BpqkO7CcW4Q4JQcsQD54siTT8
         NsRSGVKJuBaAethVDtTHZU5uEwRbu0MWiCOhQbB/UqvQBVZ3T9jDFRRm34aclJv8yNUQ
         a4raSIeUNYiAe/9qDUntj9FgXN6nmfWf9tLOtWInGlk7ooEVjI2gXHdnjMCiXo9hOUF9
         5SQQcVFPwUa4AC2JYa0gj/TEocGNX+p1odTUJd0KNHm8Zh5VUU3XszcMI0KAjH9/82aa
         2LovXPf5L5kUyIZVUOK7OroKhVhwEv8uzXBdhfi20GUupZ6z3anzkTo3ieYuN9Jvbv89
         /6EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758749073; x=1759353873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9VyM0WNdpp3RBuk8JO7Jjfzk2kEITU00kNnIncmKpxg=;
        b=Dw0RoSCySMIDpFeEA6BKI6i5+5jqxNH2QyuBeKBcKWNAu7fGziQLTQ9i9nPfZGoH0j
         YDvnCxlP4bZFKdPpmF62ibZXnHcGpZNLG+bcCAM8ZG+oNhJIQYSQTcqGO3qSvRwjA7ZC
         daz4nzaw7J10Zxoq6m5yOuDZaQLRJ9zZJ9iFaCqDy6p+4hcfGt7tLYHZMgryje8Ozwx7
         No1ALzMZB2g1fIwMOdUacBqFcldGVvvezNnB31973Q894bASEu0XjYKYCtXenzkSSnhG
         Kk/Y00tVvIXjxgFGhVhxQuooMHlBzM2obHIntA3tgtv6N2NoQyCZzACpljCbJQA/oEYh
         58CQ==
X-Gm-Message-State: AOJu0Yz2U4A7TSPH+MtshWtJTmTbI7dfh0IhxkiqOL7Z7WD8obZy3Ixg
	a6bx1uPMrT0A6uRt5o49B7mpRuHmJdZdEEI+n5s2HJrazE3wRQJqcwwl7/Cweg==
X-Gm-Gg: ASbGnctS4LdtKNIHq1FI0WN7T8OMDBi4FAGAeoiDtHAyyNgoh8a1qBJT70Uw4i8/f8s
	LpGvn7x+B5Bcg20unKN9Lr/ucJ4zUeSgcgLwKZ9P+6qfft5vpDSOcfY85V45MO0zAf/YwNqZWCn
	QTow0zuDokGjV0YeEq6V3PbgCKzfwFO6WXRt+gyqb/FkIgvQiz+ERmYjIZuUMW6HnJkxEMp+0tE
	PsOmLba4tWaSLQCFD9Y8/txohDo+YIPXEIj4a1amlIHxv/8bT09wbrccictkuRaYJ/TrLBcDRh9
	dSX6munI77mjDsEAYhylPd9iM0d2Mxv+uFX3PSQLo7uCYRXOL4KupYrl2qgD7HHkT8MevXZjY0r
	n3lX2JGf1DXZ+TNRGGp76egmFch++vSI=
X-Google-Smtp-Source: AGHT+IFS7pPE5EYAy3+4Lz8uo2VA+QlRzCNRT0sdSb3z5sw5hvRu/aPVF2PKhQs0uM5KJgecjYxRXg==
X-Received: by 2002:a05:6808:1891:b0:438:27af:3ff8 with SMTP id 5614622812f47-43f4cc20b03mr678960b6e.7.1758749073523;
        Wed, 24 Sep 2025 14:24:33 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f46f5dbdcsm400117b6e.12.2025.09.24.14.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 14:24:33 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 3/6] builtin/repo: introduce stats subcommand
Date: Wed, 24 Sep 2025 16:24:23 -0500
Message-ID: <20250924212426.2930029-4-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250924212426.2930029-1-jltobler@gmail.com>
References: <20250923025700.3046260-1-jltobler@gmail.com>
 <20250924212426.2930029-1-jltobler@gmail.com>
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
 builtin/repo.c              | 179 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       |  61 ++++++++++++
 4 files changed, 251 insertions(+)
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
index eeeab8fbd2..32ddf2350e 100644
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
 
@@ -156,12 +159,188 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
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
+static void stats_table_add(struct stats_table *table, const char *format,
+			    const char *name, struct stats_table_entry *entry)
+{
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	char *formatted_name;
+	size_t name_width;
+
+	strbuf_addf(&buf, format, name);
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
+static void stats_table_add_count(struct stats_table *table, const char *format,
+				  const char *name, size_t value)
+{
+	struct stats_table_entry *entry;
+
+	CALLOC_ARRAY(entry, 1);
+	entry->value = xstrfmt("%" PRIuMAX, (uintmax_t)value);
+	stats_table_add(table, format, name, entry);
+}
+
+static void stats_table_setup(struct stats_table *table, struct ref_stats *refs)
+{
+	size_t ref_total;
+
+	ref_total = refs->branches + refs->remotes + refs->tags + refs->others;
+	stats_table_add(table, "* %s", _("References"), NULL);
+	stats_table_add_count(table, "  * %s", _("Count"), ref_total);
+	stats_table_add_count(table, "    * %s", _("Branches"), refs->branches);
+	stats_table_add_count(table, "    * %s", _("Tags"), refs->tags);
+	stats_table_add_count(table, "    * %s", _("Remotes"), refs->remotes);
+	stats_table_add_count(table, "    * %s", _("Others"), refs->others);
+}
+
+static inline size_t max_size_t(size_t a, size_t b)
+{
+	return (a > b) ? a : b;
+}
+
+static void stats_table_print(struct stats_table *table)
+{
+	const char *name_col_title = _("Repository stats");
+	const char *value_col_title = _("Value");
+	size_t name_title_len = strlen(name_col_title);
+	size_t value_title_len = strlen(value_col_title);
+	struct strbuf buf = STRBUF_INIT;
+	struct string_list_item *item;
+	int name_col_width;
+	int value_col_width;
+
+	name_col_width = cast_size_t_to_int(
+		max_size_t(table->name_col_width, name_title_len));
+	value_col_width = cast_size_t_to_int(
+		max_size_t(table->value_col_width, value_title_len));
+
+	strbuf_addf(&buf, "| %-*s | %-*s |\n", name_col_width, name_col_title,
+		    value_col_width, value_col_title);
+	strbuf_addstr(&buf, "| ");
+	strbuf_addchars(&buf, '-', name_col_width);
+	strbuf_addstr(&buf, " | ");
+	strbuf_addchars(&buf, '-', value_col_width);
+	strbuf_addstr(&buf, " |\n");
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
+		strbuf_addf(&buf, "| %-*s | %*s |\n", name_col_width,
+			    item->string, value_col_width, value);
+	}
+
+	fputs(buf.buf, stdout);
+	strbuf_release(&buf);
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
+static int cmd_repo_stats(int argc UNUSED, const char **argv UNUSED,
+			  const char *prefix UNUSED, struct repository *repo UNUSED)
+{
+	struct ref_filter filter = REF_FILTER_INIT;
+	struct stats_table table = {
+		.rows = STRING_LIST_INIT_DUP,
+	};
+	struct ref_stats stats = { 0 };
+	struct ref_array refs = { 0 };
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

