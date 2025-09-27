Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D19B2E764E
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758984661; cv=none; b=oasGfkg4VvXGCtltU53b+l7Rmd2XPY78KQNQuPX39x+kH1TJ3PMdOF/DtKSxp4yGuzEeEaNu8L829gw8ADVICHB+iquPWfVTuqr2i4N35zFmnsFB7q2ABL4q62ZLGpiKH2x+bqvAtL6FQQOlaUYJBG9/bHdd7QPYMEpdIcxtzrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758984661; c=relaxed/simple;
	bh=XTPSwl9F5i1+ImyAQ0eAT7di+5j86dxrdvsp22t4E7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4r+V5l19V4DI9aBecGC8Mdx1UoxahEAsKj0b3YqZuz9KwZ//ZyQ7LjGmlVBShZbXGtStt2ysVTxDkAxbAipHIwo38ITysFD4LlewW/cDBL4pKUTF22X6w2jdlWfR4xFpH9LTg1zMFCWbO2u4BJi8KIVjuOorWUPyk/aUArsG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghBeoIPj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghBeoIPj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-74572fb94b3so2369244a34.2
        for <git@vger.kernel.org>; Sat, 27 Sep 2025 07:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758984659; x=1759589459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFkT1FJy9vxlBLVfflR7dPj1kscqN4leU4fvKWdE4Ao=;
        b=ghBeoIPjL0GH/HxSKNecgzbCe8TXaJbDbs42nRFk4dyI+005LtEJduFUdjPrRjoRxn
         WBSu6W+/4zrMS+UOm6JcWBDskwA87T3t++o/wh5xuC1E3qXrp3IU+rqzQBc/t21vsfm6
         9biQmAFmI3R1PnF5+nyVu+bnB7eJ9R+5VxTecR+35jFCpRS7tHXxYwqHK3OQrXFH6Sps
         4DmohfCJds8focofLj5z6+PL+dK/RlUryBUJS9GUn5P3C4R/TYLwRzQPsHv2SowSczjq
         1rAOfF1otToOB9UMGlLABFCSX3SaLQxuKEpwvekj/s47Oc0C6Tbev3mJ00NIPnf1MFxh
         zhxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758984659; x=1759589459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFkT1FJy9vxlBLVfflR7dPj1kscqN4leU4fvKWdE4Ao=;
        b=BqyPJGzhOHEl9J/gK5rNfwUPWd0slg6QGVndMWeE7O7ZMeIPBUU+ZN+/d3itKfIzi3
         +QmVuThejqkJSk1PqTpQUj6V29xAnfQR01hU+DCCp6KH7DMTTzDHiIVxh65Fz412L+NC
         cvFbwJ0CCa0D9FjYl/V3dRSVHm/sITEGbhbxi8xV5AY+8yu9IgEKaMob6VKRepvC1G2C
         1IaBZLn4t/R+dypxbVEQb3ZciDq+w+t3AUMZZq2g+rqtMJz0hn1wzxA5QeAr1JtkQfxb
         L596X6EaVBGUf0aFl48nZxGnfdr3ovS0bUnSLnQmc+3iX6i7vmqvS/AKNpWnlf8ekIcZ
         N9sA==
X-Gm-Message-State: AOJu0YyjzA0HaBZsD1iIG0GyvJu2caa/olvLys8cf1XRmD3v1vA92ndr
	E8l0QUTBAhlUbngeQAenRUAwTnZRmdlWNSTpRFJoAw80W+vnNU21Tb11WmM0mw==
X-Gm-Gg: ASbGncu6w0T8zg/NCXhVlsA0vZpmsLEelQYIm2ZuGafJhxO2gRC+4JeH0OV/pTIM8Tb
	WiUGDP3rCn6l7wWhc5YyxzU3p08moW0gs4gWcNR14YyRF8avBxwFT5NmqJc5c5AA9eA2A8Cb5yH
	HLYmVBXufKEjWVRDN8r0WE4z/YtBsfAQx5WNhMcI8jS5eXysdhd43EY3eryys1U4qKqIJ+hXd/O
	VjZvt6tcwlFxAZ4tde7qylI02deIviyDlHn8BKuBpgyID0/fQV6rvx5xkhYexM2aAO5ns5CkcTq
	Ea3LIy07kOBqR4CCTPOxQn887Tf/jOh/Q38fbR4tg0sYWyd5gGMX2cj68i98A+tgiptpaWaKPT3
	VVY8R8EZLJJHUa7OMQ0AxhwVOJguvjio=
X-Google-Smtp-Source: AGHT+IEYnlij6V7I+5pifAdjaXWRYcDPh1DCDzRwViEpmiUjDoTHPavggqZMnKIXnF7k5W5pJKnTuA==
X-Received: by 2002:a05:6808:1807:b0:43f:122c:a6fc with SMTP id 5614622812f47-43f4cea543dmr2970595b6e.36.1758984658867;
        Sat, 27 Sep 2025 07:50:58 -0700 (PDT)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51258cf1sm1345401b6e.29.2025.09.27.07.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:50:58 -0700 (PDT)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	sunshine@sunshineco.com,
	Justin Tobler <jltobler@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v4 4/7] builtin/repo: introduce stats subcommand
Date: Sat, 27 Sep 2025 09:50:46 -0500
Message-ID: <20250927145049.723341-5-jltobler@gmail.com>
X-Mailer: git-send-email 2.51.0.193.g4975ec3473b
In-Reply-To: <20250927145049.723341-1-jltobler@gmail.com>
References: <20250925232928.3846-1-jltobler@gmail.com>
 <20250927145049.723341-1-jltobler@gmail.com>
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
 builtin/repo.c              | 198 ++++++++++++++++++++++++++++++++++++
 t/meson.build               |   1 +
 t/t1901-repo-stats.sh       |  61 +++++++++++
 4 files changed, 270 insertions(+)
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
index eeeab8fbd2..889e344f15 100644
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
+	"git repo stats",
 	NULL
 };
 
@@ -156,12 +160,206 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
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
+	formatted_name = strbuf_detach(&buf, NULL);
+	name_width = utf8_strwidth(formatted_name);
+
+	item = string_list_append_nodup(&table->rows, formatted_name);
+	item->util = entry;
+
+	if (name_width > table->name_col_width)
+		table->name_col_width = name_width;
+	if (entry) {
+		size_t value_width = utf8_strwidth(entry->value);
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
+	size_t name_title_len = utf8_strwidth(name_col_title);
+	size_t value_title_len = utf8_strwidth(value_col_title);
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

