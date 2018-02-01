Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 876451F404
	for <e@80x24.org>; Thu,  1 Feb 2018 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbeBANCk (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Feb 2018 08:02:40 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35075 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752038AbeBANCj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Feb 2018 08:02:39 -0500
Received: by mail-pl0-f66.google.com with SMTP id j19so3453652pll.2
        for <git@vger.kernel.org>; Thu, 01 Feb 2018 05:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6x2I0oxLuYE1KkrpltdyuYChNJPC8lhQYLNq7LhxCU=;
        b=a+Qw9u3m80eC3Ih4jpZgI4Al6aqE6KriGEnLkPd62Jv3c9b7XD8QpaEfVltw8xcXi2
         WA87PUq9vRGKraPozNfjIkG1t/EUoANCnkX6HNWDhmyZUvyZmmUtHNX1D5VkuwjCmnfb
         OYejMj2efg0eO1ulGCX5uWfrxtdjLCFBElhsDuAZ7Zdn+nfXFabae0eqQ6PbiXdAm3IR
         SWldXg/4xeCy4ICeMK9eCNFyQoOcJpkJZ2w/7K6xUaXhTCKknROcC+x9YExeHIX5IgsZ
         pNE9+LWSK35rh1SIk6Hg9hCSdefsEEf4dNGq5wbHtVjGF/txP3rQ2BqO/lCDoEty/Zec
         P6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6x2I0oxLuYE1KkrpltdyuYChNJPC8lhQYLNq7LhxCU=;
        b=I3JL9IYCaMS+UKVhgNQxF5ieD6Xr9lkB02iOnXPL3z5k7zKWxiUYdtaz57wXKK0zNx
         Q8ZTSHTxZvIPLcNGLPCOdwejU3ZpsFsET5jebQmJ3BdPF9s0rUGtEudocwd2s/DAVy0N
         jPb5TdH43t0eVEG6kfyLyoThNgxkpzArdzB5P1z6re/BY+H7eH4OufxAE3EsY6bMLiv8
         gybXpJfcglQ9AguitJDVIJULp8KdnEgtw3e7tZ9VFAk+JwaGE06y0iCs5+x9BvcJlvlo
         O3KcppJYCISFmyHWmjN+16/ppFyUeuPFKu91TpGpcdaQberluNxhwAPZHLNn0r7dkvIo
         HVJQ==
X-Gm-Message-State: AKwxytfckWWHYP4lkPmhuVbG6AdWtaxqco6bFyRy3NkzvEyzadbEHzHx
        QpxCREM/TO+vSxwkcJ/4EDVUjw==
X-Google-Smtp-Source: AH8x227LL3DzG/HaA527jWIC/9JQ9fwGHnIrdh9z/5I32Kd+kYS58GKsh2w+HIpMDf6nYXUkUqP0HQ==
X-Received: by 2002:a17:902:7402:: with SMTP id g2-v6mr1612205pll.170.1517490158398;
        Thu, 01 Feb 2018 05:02:38 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id y18sm47797478pfa.175.2018.02.01.05.02.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Feb 2018 05:02:37 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Feb 2018 20:02:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/2] diff: add --stat-with-summary
Date:   Thu,  1 Feb 2018 20:02:21 +0700
Message-Id: <20180201130221.15563-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180201130221.15563-1-pclouds@gmail.com>
References: <20180201130221.15563-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Certain information is currently shown with --summary, but when used
in combination with --stat it's a bit hard to read since info of the
same file is in two places (--stat and --summary).

On top of that, commits that add or remove files double the number of
display lines, which could be a lot if you add or remove a lot of
files.

--stat-with-summary embeds most of --summary back in --stat in the
little space between the file name part and the graph line, e.g. with
commit 0433d533f1:

   Documentation/merge-config.txt         |  4 +
   builtin/merge.c                        |  2 +
   ...-pull-verify-signatures.sh (new +x) | 81 ++++++++++++++
   t/t7612-merge-verify-signatures.sh     | 45 ++++++++
   4 files changed, 132 insertions(+)

It helps both condensing information and saving some text
space. What's new in diffstat is:

- A new 0644 file is shown as (new)
- A new 0755 file is shown as (new +x)
- A new symlink is shown as (new +l)
- A deleted file is shown as (gone)
- A mode change adding executable bit is shown as (mode +x)
- A mode change removing it is shown as (mode -x)

Note that --stat-with-summary does not contain all the information
--summary provides. Rewrite percentage is not shown but it could be
added later, like R50% or C20%.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/diff-options.txt                |  8 ++++
 diff.c                                        | 42 ++++++++++++++++++-
 diff.h                                        |  1 +
 t/t4013-diff-various.sh                       |  5 +++
 ...-pretty_--root_--stat-with-summary_initial | 12 ++++++
 ...etty_-R_--root_--stat-with-summary_initial | 12 ++++++
 ...diff-tree_--stat-with-summary_initial_mode |  4 ++
 ...f-tree_-R_--stat-with-summary_initial_mode |  4 ++
 8 files changed, 87 insertions(+), 1 deletion(-)
 create mode 100644 t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial
 create mode 100644 t/t4013/diff.diff-tree_--stat-with-summary_initial_mode
 create mode 100644 t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c330c01ff0..595e4cd548 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -128,6 +128,14 @@ have to use `--diff-algorithm=default` option.
 These parameters can also be set individually with `--stat-width=<width>`,
 `--stat-name-width=<name-width>` and `--stat-count=<count>`.
 
+--stat-with-summary::
+	Output a condensed summary of extended header information such
+	as file creations or deletions ("new" or "gone", optionally "+l"
+	if it's a symlink) and mode changes ("+x" or "-x" for adding
+	or removing executable bit respectively) in diffstat. The
+	information is put betwen the filename part and the graph
+	part. Implies `--stat`.
+
 --numstat::
 	Similar to `--stat`, but shows number of added and
 	deleted lines in decimal notation and pathname without
diff --git a/diff.c b/diff.c
index 9d874a670f..6bf9867388 100644
--- a/diff.c
+++ b/diff.c
@@ -2129,6 +2129,7 @@ struct diffstat_t {
 		char *from_name;
 		char *name;
 		char *print_name;
+		const char *comments;
 		unsigned is_unmerged:1;
 		unsigned is_binary:1;
 		unsigned is_renamed:1;
@@ -2205,6 +2206,9 @@ static void fill_print_name(struct diffstat_file *file)
 	else
 		quote_c_style(file->name, &pname, NULL, 0);
 
+	if (file->comments)
+		strbuf_addf(&pname, " (%s)", file->comments);
+
 	file->print_name = strbuf_detach(&pname, NULL);
 }
 
@@ -3239,6 +3243,32 @@ static void builtin_diff(const char *name_a,
 	return;
 }
 
+static char *get_compact_summary(const struct diff_filepair *p, int is_renamed)
+{
+	if (!is_renamed) {
+		if (p->status == DIFF_STATUS_ADDED) {
+			if (S_ISLNK(p->two->mode))
+				return "new +l";
+			else if ((p->two->mode & 0777) == 0755)
+				return "new +x";
+			else
+				return "new";
+		} else if (p->status == DIFF_STATUS_DELETED)
+			return "gone";
+	}
+	if (S_ISLNK(p->one->mode) && !S_ISLNK(p->two->mode))
+		return "mode -l";
+	else if (!S_ISLNK(p->one->mode) && S_ISLNK(p->two->mode))
+		return "mode +l";
+	else if ((p->one->mode & 0777) == 0644 &&
+		 (p->two->mode & 0777) == 0755)
+		return "mode +x";
+	else if ((p->one->mode & 0777) == 0755 &&
+		 (p->two->mode & 0777) == 0644)
+		return "mode -x";
+	return NULL;
+}
+
 static void builtin_diffstat(const char *name_a, const char *name_b,
 			     struct diff_filespec *one,
 			     struct diff_filespec *two,
@@ -3258,6 +3288,8 @@ static void builtin_diffstat(const char *name_a, const char *name_b,
 
 	data = diffstat_add(diffstat, name_a, name_b);
 	data->is_interesting = p->status != DIFF_STATUS_UNKNOWN;
+	if (o->flags.stat_with_summary)
+		data->comments = get_compact_summary(p, data->is_renamed);
 
 	if (!one || !two) {
 		data->is_unmerged = 1;
@@ -4300,6 +4332,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	int graph_width = options->stat_graph_width;
 	int count = options->stat_count;
 	int argcount = 1;
+	unsigned with_summary = options->flags.stat_with_summary;
 
 	if (!skip_prefix(arg, "--stat", &arg))
 		die("BUG: stat option does not begin with --stat: %s", arg);
@@ -4343,6 +4376,9 @@ static int stat_opt(struct diff_options *options, const char **av)
 				count = strtoul(av[1], &end, 10);
 				argcount = 2;
 			}
+		} else if (skip_prefix(arg, "-with-summary", &arg)) {
+			with_summary = 1;
+			end = (char*)arg;
 		}
 		break;
 	case '=':
@@ -4361,6 +4397,7 @@ static int stat_opt(struct diff_options *options, const char **av)
 	options->stat_graph_width = graph_width;
 	options->stat_width = width;
 	options->stat_count = count;
+	options->flags.stat_with_summary = with_summary;
 	return argcount;
 }
 
@@ -4542,7 +4579,10 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (starts_with(arg, "--stat"))
-		/* --stat, --stat-width, --stat-name-width, or --stat-count */
+		/*
+		 * --stat, --stat-width, --stat-name-width,
+		 * --stat-count or --stat-with-summary.
+		 */
 		return stat_opt(options, av);
 
 	/* renames options */
diff --git a/diff.h b/diff.h
index 6bd278aac1..d29560f822 100644
--- a/diff.h
+++ b/diff.h
@@ -93,6 +93,7 @@ struct diff_flags {
 	unsigned dirstat_by_line:1;
 	unsigned funccontext:1;
 	unsigned default_follow_renames:1;
+	unsigned stat_with_summary:1;
 };
 
 static inline void diff_flags_or(struct diff_flags *a,
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index f10798b2df..aa6f5da21c 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -361,6 +361,11 @@ diff --no-index --raw dir2 dir
 diff --no-index --raw --abbrev=4 dir2 dir
 :noellipses diff --no-index --raw --abbrev=4 dir2 dir
 diff --no-index --raw --no-abbrev dir2 dir
+
+diff-tree --pretty --root --stat-with-summary initial
+diff-tree --pretty -R --root --stat-with-summary initial
+diff-tree --stat-with-summary initial mode
+diff-tree -R --stat-with-summary initial mode
 EOF
 
 test_expect_success 'log -S requires an argument' '
diff --git a/t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial b/t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial
new file mode 100644
index 0000000000..105f29a92d
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_--root_--stat-with-summary_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty --root --stat-with-summary initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ dir/sub (new) | 2 ++
+ file0 (new)   | 3 +++
+ file2 (new)   | 3 +++
+ 3 files changed, 8 insertions(+)
+$
diff --git a/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial
new file mode 100644
index 0000000000..45008d09fc
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--pretty_-R_--root_--stat-with-summary_initial
@@ -0,0 +1,12 @@
+$ git diff-tree --pretty -R --root --stat-with-summary initial
+commit 444ac553ac7612cc88969031b02b3767fb8a353a
+Author: A U Thor <author@example.com>
+Date:   Mon Jun 26 00:00:00 2006 +0000
+
+    Initial
+
+ dir/sub (gone) | 2 --
+ file0 (gone)   | 3 ---
+ file2 (gone)   | 3 ---
+ 3 files changed, 8 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_--stat-with-summary_initial_mode b/t/t4013/diff.diff-tree_--stat-with-summary_initial_mode
new file mode 100644
index 0000000000..f99fcdc101
--- /dev/null
+++ b/t/t4013/diff.diff-tree_--stat-with-summary_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree --stat-with-summary initial mode
+ file0 (mode +x) | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
diff --git a/t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode b/t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode
new file mode 100644
index 0000000000..8dc8f3fe95
--- /dev/null
+++ b/t/t4013/diff.diff-tree_-R_--stat-with-summary_initial_mode
@@ -0,0 +1,4 @@
+$ git diff-tree -R --stat-with-summary initial mode
+ file0 (mode -x) | 0
+ 1 file changed, 0 insertions(+), 0 deletions(-)
+$
-- 
2.16.1.75.ga05e3333b4

