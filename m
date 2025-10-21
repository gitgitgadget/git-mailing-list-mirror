Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6282E351FA7
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 18:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761071201; cv=none; b=NZXRPH62Wpjb9eeiPsjMB06eytBKAIs5l5Moxao7jq576A0T+tSYJlnzqo6outAS27VMPtrOIzw+LbF+yLgp9zcfh6L24fnxR8K2EvpTzTt8fQnZN+dN4MK4MOJJDHDXqe2v7twFKcZh0TIwY0pMANMydJE1tjGNyKcIKXC8NeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761071201; c=relaxed/simple;
	bh=wr17g6l4au6xSSitx4QIY9LaqkujsYZEO3/BrT+pNtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNipB1DUTU2RM1rW57Ty8PJjWBdyzUi4w6cr/+ThWIMRa8GSs+U5bmMBcpmRX1EmMsaUZliPcMEy2DfWgTZRAermVsdRhBwvlhyHBB7p2ZTiSoq/jy4eC8/nqh2BbGJC2KlAyvaT77446ZglCKf/yOOinCBrDNn3ppG6y6XidfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rh9k5m7d; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rh9k5m7d"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-443aa90f025so2543673b6e.0
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761071198; x=1761675998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jWqZsPRLUd5dZ17gXAP6g/P4X+AP3VTo0wDXHa6nBhA=;
        b=Rh9k5m7duKGlA/bI+lC7hDW4J8iNQuWm41QnB6kWH91pnBxHfgz7m09ve/TZLsQw/i
         cBO23cv1siY9E8Sc4GCC2OI4QkpYXpf2B3J20fSXDL8jTNcxQAO1/o90RxpbZU65/zzo
         lvJWuCeTZrQhQj4yZTvRuhiIV+LccXK6MpECyaw87iEfQFt3uETOLpzgjwjTqNcDNCY4
         fg+XdSblVNEgw1SCvVvk/4ZKhepn6gv4IsN4vek/+S9C4qzmMeNZ2wWh9Vcuh1rc8qLA
         sB4gFjNav4uG6vcvUIzzEm9SJW2BwOdUSdpxTG07tnTyBPbaG0DeCcXl/XI+BzrBVfpz
         SD/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761071198; x=1761675998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jWqZsPRLUd5dZ17gXAP6g/P4X+AP3VTo0wDXHa6nBhA=;
        b=BZoc2N2IOyM1NhPiQJRTEyZItUop19CZQlFVMK2zuKNOcxNi5hvuqE/eaWqvTEALsz
         jSJRgez+AsxQO6YScoCdPaL/XrIMk74O+pd8yQo9kq53S51DTTg+BOP67V+MkH699Rc8
         +mxJln1PtOHI31KuAXGhJQy2sRgI/XvPDzBJ4zMCjLQThUxlDxLpUSZcrq7Ob8wU3q8L
         5FE8D6x+7rcRhJgmF2j3xOCLegq3hJPXFp6ys/wJqFivVp1W7WhH/FOvIDa02XsjgJ0X
         UcdJLdEbRQnsw1T2aXTWjbivg48rr8rim/XRWhW23ud7TDqY2oQZtU0v7sZzjb9US1ZE
         SqtQ==
X-Gm-Message-State: AOJu0Yz9KS7PbaKNz6bUHi9VmwyhomcjrUaGo8JjLfSsT9LZxjpXsCvl
	E+MZSpvJTkg/OmKgSHgJ8xxC94QVEt9Li0M/Ct2J55ZX6ajIMQ2YIF8Ok9yV0A==
X-Gm-Gg: ASbGnctnAArEBPKJssmxice3WZJaKDt9vJRlmGwsq9wjgjjSijroB6lEpbUi2IePeQR
	teEYlk7bpzBrq3XFK92/nDJvATqZS0TOcQuqTWa8NPQe+rZLowMt2h5DXJ1in7dh2YGX6O4drLD
	VOJr9CB839xVvT/T1mCxZDnzov44I4km2tk2KLiZSuxftP/WJl7LepEX3WQPDl+2DQ/O/7BZFEM
	1Sob2rB/fSI0T1vvaFU29Rmn2TsgIW06eo0zX3+1O+tCKuHgdQKSjQI0NjkXRxC2+ohlloyT7Tt
	KtREbVaUTpQLau2BgNRDPQuvwLtcgftj2srMcCvJx3rQZBxLT00yvPmkRQ5kEEhbjbPH8+BQpNn
	yHnIxY7B6cLsKW4y8y1FypfWGkXkOx8/TP05rhA3sLXGNa0CikKBx0KRvBgZk9a801I6t5iMcb2
	wgF6uzxQbpFLfvjQBi4jM=
X-Google-Smtp-Source: AGHT+IGkqBjteDldBO0rFGkxi3Hyqx9SP/DDf0nU0ONlprL65d494h0tFNmlfAMoj4zGAtNsfaaF4g==
X-Received: by 2002:a05:6808:1987:b0:442:6f8:b7bb with SMTP id 5614622812f47-443a2f1c2d3mr7697277b6e.25.1761071198160;
        Tue, 21 Oct 2025 11:26:38 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df722e5csm2795853b6e.24.2025.10.21.11.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 11:26:37 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	gitster@pobox.com,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v6 4/7] builtin/repo: introduce structure subcommand
Date: Tue, 21 Oct 2025 13:25:58 -0500
Message-ID: <20251021182601.2687284-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20251021182601.2687284-1-jltobler@gmail.com>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The structure of a repository's history can have huge impacts on the
performance and health of the repository itself. Currently, Git lacks a
means to surface repository metrics regarding its structure/shape via a
single command. Acquiring this information requires users to be familiar
with the relevant data points and the various Git commands required to
surface them. To fill this gap, supplemental tools such as git-sizer(1)
have been developed.

To allow users to more readily identify repository structure related
information, introduce the "structure" subcommand in git-repo(1). The
goal of this subcommand is to eventually provide similar functionality
to git-sizer(1), but natively in Git.

The initial version of this command only iterates through all references
in the repository and tracks the count of branches, tags, remote refs,
and other reference types. The corresponding information is displayed in
a human-friendly table formatted in a very similar manner to
git-sizer(1). The width of each table column is adjusted automatically
to satisfy the requirements of the widest row contained.

Subsequent commits will surface additional relevant data points to
output and also provide other more machine-friendly output formats.

Based-on-patch-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 Documentation/git-repo.adoc |  10 ++
 builtin/repo.c              | 200 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-structure.sh   |  61 +++++++++++
 4 files changed, 272 insertions(+)
 create mode 100755 t/t1901-repo-structure.sh

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..8193298dd5 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -9,6 +9,7 @@ SYNOPSIS
 --------
 [synopsis]
 git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo structure
 
 DESCRIPTION
 -----------
@@ -43,6 +44,15 @@ supported:
 +
 `-z` is an alias for `--format=nul`.
 
+`structure`::
+	Retrieve statistics about the current repository structure. The
+	following kinds of information are reported:
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
index eeeab8fbd2..e77e8db563 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -4,12 +4,16 @@
 #include "environment.h"
 #include "parse-options.h"
 #include "quote.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "string-list.h"
 #include "shallow.h"
+#include "utf8.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo structure",
 	NULL
 };
 
@@ -156,12 +160,208 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
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
+	int name_col_width;
+	int value_col_width;
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
+	int name_width;
+
+	strbuf_vaddf(&buf, format, ap);
+	formatted_name = strbuf_detach(&buf, NULL);
+	name_width = utf8_strwidth(formatted_name);
+
+	item = string_list_append_nodup(&table->rows, formatted_name);
+	item->util = entry;
+
+	if (name_width > table->name_col_width)
+		table->name_col_width = name_width;
+	if (entry) {
+		int value_width = utf8_strwidth(entry->value);
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
+static inline size_t get_total_reference_count(struct ref_stats *stats)
+{
+	return stats->branches + stats->remotes + stats->tags + stats->others;
+}
+
+static void stats_table_setup_structure(struct stats_table *table,
+					struct ref_stats *refs)
+{
+	size_t ref_total;
+
+	ref_total = get_total_reference_count(refs);
+	stats_table_addf(table, "* %s", _("References"));
+	stats_table_count_addf(table, ref_total, "  * %s", _("Count"));
+	stats_table_count_addf(table, refs->branches, "    * %s", _("Branches"));
+	stats_table_count_addf(table, refs->tags, "    * %s", _("Tags"));
+	stats_table_count_addf(table, refs->remotes, "    * %s", _("Remotes"));
+	stats_table_count_addf(table, refs->others, "    * %s", _("Others"));
+}
+
+static void stats_table_print_structure(const struct stats_table *table)
+{
+	const char *name_col_title = _("Repository structure");
+	const char *value_col_title = _("Value");
+	int name_col_width = utf8_strwidth(name_col_title);
+	int value_col_width = utf8_strwidth(value_col_title);
+	struct string_list_item *item;
+
+	if (table->name_col_width > name_col_width)
+		name_col_width = table->name_col_width;
+	if (table->value_col_width > value_col_width)
+		value_col_width = table->value_col_width;
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
+static int count_references(const char *refname,
+			    const char *referent UNUSED,
+			    const struct object_id *oid UNUSED,
+			    int flags UNUSED, void *cb_data)
+{
+	struct ref_stats *stats = cb_data;
+
+	switch (ref_kind_from_refname(refname)) {
+	case FILTER_REFS_BRANCHES:
+		stats->branches++;
+		break;
+	case FILTER_REFS_REMOTES:
+		stats->remotes++;
+		break;
+	case FILTER_REFS_TAGS:
+		stats->tags++;
+		break;
+	case FILTER_REFS_OTHERS:
+		stats->others++;
+		break;
+	default:
+		BUG("unexpected reference type");
+	}
+
+	return 0;
+}
+
+static void structure_count_references(struct ref_stats *stats,
+				       struct repository *repo)
+{
+	refs_for_each_ref(get_main_ref_store(repo), count_references, &stats);
+}
+
+static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
+			      struct repository *repo)
+{
+	struct stats_table table = {
+		.rows = STRING_LIST_INIT_DUP,
+	};
+	struct ref_stats stats = { 0 };
+	struct option options[] = { 0 };
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+	if (argc)
+		usage(_("too many arguments"));
+
+	structure_count_references(&stats, repo);
+
+	stats_table_setup_structure(&table, &stats);
+	stats_table_print_structure(&table);
+
+	stats_table_clear(&table);
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
+		OPT_SUBCOMMAND("structure", &fn, cmd_repo_structure),
 		OPT_END()
 	};
 
diff --git a/t/meson.build b/t/meson.build
index 7974795fe4..9e426f8edc 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -236,6 +236,7 @@ integration_tests = [
   't1701-racy-split-index.sh',
   't1800-hook.sh',
   't1900-repo.sh',
+  't1901-repo-structure.sh',
   't2000-conflict-when-checking-files-out.sh',
   't2002-checkout-cache-u.sh',
   't2003-checkout-cache-mkdir.sh',
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
new file mode 100755
index 0000000000..e592eea0eb
--- /dev/null
+++ b/t/t1901-repo-structure.sh
@@ -0,0 +1,61 @@
+#!/bin/sh
+
+test_description='test git repo structure'
+
+. ./test-lib.sh
+
+test_expect_success 'empty repository' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		cat >expect <<-\EOF &&
+		| Repository structure | Value |
+		| -------------------- | ----- |
+		| * References         |       |
+		|   * Count            |     0 |
+		|     * Branches       |     0 |
+		|     * Tags           |     0 |
+		|     * Remotes        |     0 |
+		|     * Others         |     0 |
+		EOF
+
+		git repo structure >out 2>err &&
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
+		| Repository structure | Value |
+		| -------------------- | ----- |
+		| * References         |       |
+		|   * Count            |     4 |
+		|     * Branches       |     1 |
+		|     * Tags           |     1 |
+		|     * Remotes        |     1 |
+		|     * Others         |     1 |
+		EOF
+
+		git repo structure >out 2>err &&
+
+		test_cmp expect out &&
+		test_line_count = 0 err
+	)
+'
+
+test_done
-- 
2.51.0.193.g4975ec3473b

