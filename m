Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BBEE1F404
	for <e@80x24.org>; Thu, 18 Jan 2018 10:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755493AbeARKF7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 05:05:59 -0500
Received: from mail-pf0-f172.google.com ([209.85.192.172]:35337 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754905AbeARKFz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 05:05:55 -0500
Received: by mail-pf0-f172.google.com with SMTP id t12so14080817pfg.2
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 02:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRV6pnzHD3PCRQy++w7AvSadnT6sxgkjIoI0eko6bMU=;
        b=JS7/h1sZzDPoSTox2soQ8CrcrejATWjlG+9SuR83D/Gxg2QHg+jTuHc+a3RiWmBBU8
         A9NkD6m9aab3ckWWBTrw83oOSP5MTiuZ/K21pHk+GB4gkqTKbgLmvkTj8ZB3evhWr9KV
         byeXGNk6DuJx8IKo/Y1YzIinNjErRXhudErzjZC40pt8e5F1N3ZYByDGESEg1qw7B5cb
         LsyzwDN7PpnZ/AfLHCF2BwWfL/hZpNGnaOOpgAii7XwISYVSxkZttbdn0GGOwCqaMl2V
         vSGF4hPknCd/2RSy6XCHUN02pEH0NRELfPvIUteb8YWY3uUmbr1jcwFeLboY3GGYZwyg
         GiBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mRV6pnzHD3PCRQy++w7AvSadnT6sxgkjIoI0eko6bMU=;
        b=MwrcubY6Ka4xdccSssNSLuArq3TcOz2wNKShs1be+cXeVuCCjw3Ki2/nbGqgI7GbWS
         NpfzjBlm7MpTge96cTFhacrHnb9vOWd3OlYhx3dYADXO6Mlbt0gigaVIexWMRJtlFxJA
         3+OnQYSyyddYVxZ5TEv2vZ6RZS+hAtJ3zkWTIcWdvJou9xQ6N1TduTKU7rRcj2L3HveA
         lE8TiYwplsWEm9nQSyfmb6YPkCSEMBiJYvAmtoTWfaUc9TFBpBFzM7Cq+BVdE+hAJe43
         wHteUwQ6k4R3l4ClGBeJrPTXLP4HHmQHjDNsan4ODbP+DDWfDag6Hj29Bwhe8lrpMerd
         mP3w==
X-Gm-Message-State: AKGB3mKMBAGjbStAAcs4J3T0rYelf8IsLk3ZqB/D39x3sQqZIEKasEa9
        WpYxfrNQQunY/g0JdLVt1b3HWw==
X-Google-Smtp-Source: ACJfBosp2uRebzSJGGzh/koMqvhpYvk9mopg3+THb8pfQauBctjcvdXDDPKWVMeL/ZuslFs8W91WfQ==
X-Received: by 10.84.211.39 with SMTP id b36mr45913471pli.217.1516269954548;
        Thu, 18 Jan 2018 02:05:54 -0800 (PST)
Received: from ash ([27.75.129.14])
        by smtp.gmail.com with ESMTPSA id c184sm11751612pfc.60.2018.01.18.02.05.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 02:05:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 18 Jan 2018 17:05:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2] diff: add --compact-summary option to complement --stat
Date:   Thu, 18 Jan 2018 17:05:46 +0700
Message-Id: <20180118100546.32251-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.15.1.600.g899a5f85c6
In-Reply-To: <20180113132211.13350-1-pclouds@gmail.com>
References: <20180113132211.13350-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is partly inspired by gerrit web interface which shows diffstat
like this, e.g. with commit 0433d533f1 (notice the "A" column on the
third line):

     Documentation/merge-config.txt     |  4 +
     builtin/merge.c                    |  2 +
   A t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++
     t/t7612-merge-verify-signatures.sh | 45 ++++++++++
   4 files changed, 132 insertions(+)

In other words, certain information currently shown with --summary is
embedded in the diffstat. This helps reading (all information of the
same file in the same line instead of two) and can reduce the number of
lines if you add/delete a lot of files.

The new option --compact-summary implements this with a tweak to support
mode change, which is shown in --summary too.

For mode changes, executable bit is denoted as "M+x" or "M-x" when it's
added or removed respectively. The same for when a regular file is
replaced with a symlink "M+l" or the other way "M-l". This also applies
to new files. New regulare files are "A", while new executable files or
symlinks are "A+x" or "A+l".

With this tweak, the actual printout is like this

     Documentation/merge-config.txt     |  4 ++
     builtin/merge.c                    |  2 +
 A+x t/t5573-pull-verify-signatures.sh  | 81 ++++++++++++++++++++++++
     t/t7612-merge-verify-signatures.sh | 45 +++++++++++++
 4 files changed, 132 insertions(+)

Note, there is still one piece of information missing from --summary,
the rename/copy percentage. That could probably be added later. It's not
as useful as the others anyway.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 v2 changes "(+x)" and friends to "M+x" and fixes the "Fle" typo.

 Documentation/diff-options.txt                     | 11 ++++
 diff.c                                             | 64 +++++++++++++++++++++-
 diff.h                                             |  1 +
 t/t4013-diff-various.sh                            |  5 ++
 ...y_--root_--stat_--compact-summary_initial (new) | 12 ++++
 ...R_--root_--stat_--compact-summary_initial (new) | 12 ++++
 ...ree_--stat_--compact-summary_initial_mode (new) |  4 ++
 ..._-R_--stat_--compact-summary_initial_mode (new) |  4 ++
 8 files changed, 110 insertions(+), 3 deletions(-)
 create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
 create mode 100644 t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 743af97b06..92cbf7696f 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -188,6 +188,17 @@ and accumulating child directory counts in the parent directories:
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
 
+--compact-summary::
+	Output a condensed summary of extended header information in
+	front of the file name part of diffstat. This option is
+	ignored if --stat is not specified.
++
+File creations or deletions are denoted wigth "A" or "D" respectively,
+optionally "+l" if it's a symlink, or "+x" if it's executable.
+Mode changes are shown "M+x" or "M-x" for adding or removing
+executable bit respectively, "M+l" or "M-l" for becoming a symlink or
+a regular file.
+
 ifndef::git-format-patch[]
 --patch-with-stat::
 	Synonym for `-p --stat`.
diff --git a/diff.c b/diff.c
index fb22b19f09..ce1d24b417 100644
--- a/diff.c
+++ b/diff.c
@@ -2131,6 +2131,7 @@ struct diffstat_t {
 		char *from_name;
 		char *name;
 		char *print_name;
+		const char *status_code;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -2271,6 +2272,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, adds = 0, dels = 0;
 	uintmax_t max_change = 0, max_len = 0;
+	int max_status_len = 0;
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
@@ -2287,6 +2289,18 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
+	for (i = 0; (i < count) && (i < data->nr); i++) {
+		const struct diffstat_file *file = data->files[i];
+		int len;
+
+		if (!file->status_code)
+			continue;
+		len = strlen(file->status_code) + 1;
+
+		if (len > max_status_len)
+			max_status_len = len;
+	}
+
 	/*
 	 * Find the longest filename and max number of changes
 	 */
@@ -2383,6 +2397,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
 
+	name_width += max_status_len;
+
 	/*
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
@@ -2402,6 +2418,8 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			graph_width = width - number_width - 6 - name_width;
 	}
 
+	name_width -= max_status_len;
+
 	/*
 	 * From here name_width is the width of the name area,
 	 * and graph_width is the width of the graph area.
@@ -2409,6 +2427,7 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	 */
 	for (i = 0; i < count; i++) {
 		const char *prefix = "";
+		const char *status_code = "";
 		struct diffstat_file *file = data->files[i];
 		char *name = file->print_name;
 		uintmax_t added = file->added;
@@ -2418,6 +2437,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (!file->is_interesting && (added + deleted == 0))
 			continue;
 
+		if (file->status_code)
+			status_code = file->status_code;
+
 		/*
 		 * "scale" the filename
 		 */
@@ -2434,7 +2456,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (file->is_binary) {
-			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+			strbuf_addf(&out, " %-*s%s%-*s |",
+				    max_status_len, status_code,
+				    prefix, len, name);
 			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
@@ -2455,7 +2479,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 			continue;
 		}
 		else if (file->is_unmerged) {
-			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+			strbuf_addf(&out, " %-*s%s%-*s |",
+				    max_status_len, status_code,
+				    prefix, len, name);
 			strbuf_addstr(&out, " Unmerged\n");
 			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 					 out.buf, out.len, 0);
@@ -2482,7 +2508,9 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 				add = total - del;
 			}
 		}
-		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+		strbuf_addf(&out, " %-*s%s%-*s |",
+			    max_status_len, status_code,
+			    prefix, len, name);
 		strbuf_addf(&out, " %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
@@ -3248,6 +3276,32 @@ static void builtin_diff(const char *name_a,
 	return;
 }
 
+static const char *get_compact_summary(const struct diff_filepair *p, int is_renamed)
+{
+	if (!is_renamed) {
+		if (p->status == DIFF_STATUS_ADDED) {
+			if (S_ISLNK(p->two->mode))
+				return "A+l";
+			else if ((p->two->mode & 0777) == 0755)
+				return "A+x";
+			else
+				return "A";
+		} else if (p->status == DIFF_STATUS_DELETED)
+			return "D";
+	}
+	if (S_ISLNK(p->one->mode) && !S_ISLNK(p->two->mode))
+		return "M-l";
+	else if (!S_ISLNK(p->one->mode) && S_ISLNK(p->two->mode))
+		return "M+l";
+	else if ((p->one->mode & 0777) == 0644 &&
+		 (p->two->mode & 0777) == 0755)
+		return "M+x";
+	else if ((p->one->mode & 0777) == 0755 &&
+		 (p->two->mode & 0777) == 0644)
+		return "M-x";
+	return NULL;
+}
+
 static void builtin_diffstat(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two,
@@ -3267,6 +3321,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 	data = diffstat_add(diffstat, name_a, name_b);
 	data->is_interesting = p->status != DIFF_STATUS_UNKNOWN;
+	if (o->flags.compact_summary)
+		data->status_code = get_compact_summary(p, data->is_renamed);
 
 	if (!one || !two) {
 		data->is_unmerged = 1;
@@ -4537,6 +4593,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
+	else if (!strcmp(arg, "--compact-summary"))
+		options->flags.compact_summary = 1;
 
 	/* renames options */
 	else if (starts_with(arg, "-B") ||
diff --git a/diff.h b/diff.h
index 7cf276f077..843276196c 100644
--- a/diff.h
+++ b/diff.h
@@ -93,6 +93,7 @@ struct diff_flags {
 	unsigned funccontext:1;
 	unsigned pickaxe_ignore_case:1;
 	unsigned default_follow_renames:1;
+	unsigned compact_summary:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f10798b2df..3f9a24fd56 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -361,6 +361,11 @@ diff --no-index --raw dir2 dir
 diff --no-index --raw --abbrev=4 dir2 dir
 :noellipses diff --no-index --raw --abbrev=4 dir2 dir
 diff --no-index --raw --no-abbrev dir2 dir
+
+diff-tree --pretty --root --stat --compact-summary initial
+diff-tree --pretty -R --root --stat --compact-summary initial
+diff-tree --stat --compact-summary initial mode
+diff-tree -R --stat --compact-summary initial mode
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
new file mode 100644
index 0000000000..0f086907fc
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat_--compact-summary_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty --root --stat --compact-summary initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ A dir/sub | 2 ++
+ A file0   | 3 +++
+ A file2   | 3 +++
+ 3 files changed, 8 insertions(+)
+$
diff --git a/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
new file mode 100644
index 0000000000..eeed5872e0
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat_--compact-summary_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty -R --root --stat --compact-summary initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ D dir/sub | 2 --
+ D file0   | 3 ---
+ D file2   | 3 ---
+ 3 files changed, 8 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode b/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
new file mode 100644
index 0000000000..5d4d511dd5
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--stat_--compact-summary_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree --stat --compact-summary initial mode
+ M+x file0 | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode b/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
new file mode 100644
index 0000000000..6b8c4531b4
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-R_--stat_--compact-summary_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree -R --stat --compact-summary initial mode
+ M-x file0 | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
-- 
2.15.1.600.g899a5f85c6

