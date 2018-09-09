Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 894601F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbeIINnk (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:40 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42859 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeIINnj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:39 -0400
Received: by mail-lf1-f68.google.com with SMTP id z11-v6so15120758lff.9
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCuRYE2rHKsFgAuiM9J5Ku1jbXuIdB2agMSnKFNOgZQ=;
        b=Cs/ptR9mCMK1l/+mnuEPh9lFRxpXxU2NO1TFHh+MkBnD0nSEymA5yvGceBGI9qEFpM
         PTg+NsFmEOo4zJWOokBuQhvPGtXqyIz6G9Mnco0Tg87NO5Gs96WHW+k8UetVo0jsDWbG
         FAgXF5A4ER55RZz+cpqqx/igy3xb01QSlWJL6BHcuYv4UHh498CsV56GElfI/vqjODYX
         Jtll3pdrTqLr4v0WU5HrgYxAMXVp14xOZaqx6v8x6SNTqfnNXgLCsCnUHwvD4IEd+pDV
         9TDErIXmk1m9G1j99soTzT8/8UOBi3FZa45oeT0NnDAANqtaYsYj9c2qJMcBC27evyr/
         PzTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCuRYE2rHKsFgAuiM9J5Ku1jbXuIdB2agMSnKFNOgZQ=;
        b=LZRAxUuuU+1H8Ge6jrfYpnKynVBgpss8CwlfIiHUJLIZDvdB0aCy9qhjQfyMv+gKod
         jR5pSyN7LZvg3jgGYtL6yEszaGBDqSmJ5wyOgwUSHAKNtdwJPe4i3MHc8NrcnTXEhNbL
         PITa0GlzVAXLvuHMT/9LCTRAEs/L9DJUz+jXLbHRek1LcuAh+URL/90SkVSPqMiU+udR
         +fLBWiOqHoq4uohTVk/YiN9NFMk9SSppmLcoQhEnTOONYthrFGoogkqPvmq/T/0t+cWD
         6EN9iTrGs+Ddfz5wO9fzZjIPGH8UHIZ3eLCESZhAauJPuem0jvvBev3+K1BUQHnNStBv
         SjwA==
X-Gm-Message-State: APzg51CmwBuBIxlhB5SUnU6EMG+jk7pqE2a4ULxhipY4BKoXz0KWkHT1
        k0HaKFVtz7W4Pjrqb7+voGsTNVr9
X-Google-Smtp-Source: ANB0VdaKXDnqxlpko5gIRqfxuQV/2iE5S5cl64DiVLAHdtYlv/i1ix/YeZSSw/0nCjeyhQatFTYzFg==
X-Received: by 2002:a19:17e5:: with SMTP id 98-v6mr9445584lfx.48.1536483280551;
        Sun, 09 Sep 2018 01:54:40 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:39 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/23] diff.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:03 +0200
Message-Id: <20180909085418.31531-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new variant repo_diff_setup() is added that takes 'struct repository *'
and diff_setup() becomes a thin macro around it that is protected by
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, similar to NO_THE_INDEX_....
The plan is these macros will always be defined for all library files
and the macros are only accessible in builtin/
---
 Documentation/technical/api-diff.txt |  4 ++--
 blame.c                              | 20 +++++++++++---------
 builtin/diff.c                       |  2 +-
 builtin/log.c                        |  2 +-
 builtin/merge.c                      |  2 +-
 builtin/range-diff.c                 |  2 +-
 diff-no-index.c                      |  9 +++++++--
 diff.c                               |  4 ++--
 diff.h                               |  7 +++++--
 merge-recursive.c                    |  2 +-
 notes-merge.c                        |  4 ++--
 patch-ids.c                          |  2 +-
 read-cache.c                         |  2 +-
 revision.c                           |  2 +-
 tree-diff.c                          |  2 +-
 15 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/Documentation/technical/api-diff.txt b/Documentation/technical/api-diff.txt
index 8b001de0db..30fc0e9c93 100644
--- a/Documentation/technical/api-diff.txt
+++ b/Documentation/technical/api-diff.txt
@@ -18,8 +18,8 @@ Calling sequence
 ----------------
 
 * Prepare `struct diff_options` to record the set of diff options, and
-  then call `diff_setup()` to initialize this structure.  This sets up
-  the vanilla default.
+  then call `repo_diff_setup()` to initialize this structure.  This
+  sets up the vanilla default.
 
 * Fill in the options structure to specify desired output format, rename
   detection, etc.  `diff_opt_parse()` can be used to parse options given
diff --git a/blame.c b/blame.c
index 9d57c76baa..c229a10c0e 100644
--- a/blame.c
+++ b/blame.c
@@ -541,8 +541,9 @@ static int fill_blob_sha1_and_mode(struct repository *r,
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
-static struct blame_origin *find_origin(struct commit *parent,
-				  struct blame_origin *origin)
+static struct blame_origin *find_origin(struct repository *r,
+					struct commit *parent,
+					struct blame_origin *origin)
 {
 	struct blame_origin *porigin;
 	struct diff_options diff_opts;
@@ -562,7 +563,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
-	diff_setup(&diff_opts);
+	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -629,14 +630,15 @@ static struct blame_origin *find_origin(struct commit *parent,
  * We have an origin -- find the path that corresponds to it in its
  * parent and return an origin structure to represent it.
  */
-static struct blame_origin *find_rename(struct commit *parent,
-				  struct blame_origin *origin)
+static struct blame_origin *find_rename(struct repository *r,
+					struct commit *parent,
+					struct blame_origin *origin)
 {
 	struct blame_origin *porigin = NULL;
 	struct diff_options diff_opts;
 	int i;
 
-	diff_setup(&diff_opts);
+	repo_diff_setup(r, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1260,7 +1262,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	diff_setup(&diff_opts);
+	repo_diff_setup(sb->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
@@ -1442,7 +1444,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
-		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
+		struct blame_origin *(*find)(struct repository *, struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
@@ -1455,7 +1457,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 				continue;
 			if (parse_commit(p))
 				continue;
-			porigin = find(p, origin);
+			porigin = find(sb->repo, p, origin);
 			if (!porigin)
 				continue;
 			if (!oidcmp(&porigin->blob_oid, &origin->blob_oid)) {
diff --git a/builtin/diff.c b/builtin/diff.c
index 361a3c3ed3..ab89b06d18 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -339,7 +339,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 	if (no_index)
 		/* If this is a no-index diff, just run it and exit there. */
-		diff_no_index(&rev, argc, argv);
+		diff_no_index(the_repository, &rev, argc, argv);
 
 	/* Otherwise, we are doing the usual "git" diff */
 	rev.diffopt.skip_stat_unmatch = !!diff_auto_refresh_index;
diff --git a/builtin/log.c b/builtin/log.c
index b62082472c..4b602236d6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1361,7 +1361,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	init_commit_base(&commit_base);
-	diff_setup(&diffopt);
+	repo_diff_setup(the_repository, &diffopt);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 8f4a5065c2..592cb19caf 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -452,7 +452,7 @@ static void finish(struct commit *head_commit,
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
-		diff_setup(&opts);
+		repo_diff_setup(the_repository, &opts);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 0aa9bed41f..1c477c4dc5 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -34,7 +34,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_ui_config, NULL);
 
-	diff_setup(&diffopt);
+	repo_diff_setup(the_repository, &diffopt);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
diff --git a/diff-no-index.c b/diff-no-index.c
index 0ed5f0f496..9414e922d1 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -233,7 +233,8 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	}
 }
 
-void diff_no_index(struct rev_info *revs,
+void diff_no_index(struct repository *r,
+		   struct rev_info *revs,
 		   int argc, const char **argv)
 {
 	int i;
@@ -241,7 +242,11 @@ void diff_no_index(struct rev_info *revs,
 	struct strbuf replacement = STRBUF_INIT;
 	const char *prefix = revs->prefix;
 
-	diff_setup(&revs->diffopt);
+	/*
+	 * FIXME: --no-index should not look at index and we should be
+	 * able to pass NULL repo. Maybe later.
+	 */
+	repo_diff_setup(r, &revs->diffopt);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
diff --git a/diff.c b/diff.c
index 0848ac65df..1bcc0818df 100644
--- a/diff.c
+++ b/diff.c
@@ -4390,12 +4390,12 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
-void diff_setup(struct diff_options *options)
+void repo_diff_setup(struct repository *r, struct diff_options *options)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
 
 	options->file = stdout;
-	options->repo->index = &the_index;
+	options->repo = r;
 
 	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
diff --git a/diff.h b/diff.h
index 812f71d953..b88fccd2fb 100644
--- a/diff.h
+++ b/diff.h
@@ -336,7 +336,10 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-void diff_setup(struct diff_options *);
+#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
+#define diff_setup(diffopts) repo_diff_setup(the_repository, diffopts)
+#endif
+void repo_diff_setup(struct repository *, struct diff_options *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
@@ -426,7 +429,7 @@ int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 
 int diff_result_code(struct diff_options *, int);
 
-void diff_no_index(struct rev_info *, int, const char **);
+void diff_no_index(struct repository *, struct rev_info *, int, const char **);
 
 int index_differs_from(const char *def, const struct diff_flags *flags,
 		       int ita_invisible_in_index);
diff --git a/merge-recursive.c b/merge-recursive.c
index dcdc93019c..09e8bbfe4c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1812,7 +1812,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	diff_setup(&opts);
+	repo_diff_setup(the_repository, &opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
diff --git a/notes-merge.c b/notes-merge.c
index 76ab19e702..9b154a5da6 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -126,7 +126,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	diff_setup(&opt);
+	repo_diff_setup(the_repository, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -189,7 +189,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	diff_setup(&opt);
+	repo_diff_setup(the_repository, &opt);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
diff --git a/patch-ids.c b/patch-ids.c
index 8f7c25d5db..342950c79d 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -59,7 +59,7 @@ static int patch_id_cmp(const void *cmpfn_data,
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	diff_setup(&ids->diffopts);
+	repo_diff_setup(the_repository, &ids->diffopts);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/read-cache.c b/read-cache.c
index 86134e56a6..6f772b2885 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2137,7 +2137,7 @@ int index_has_changes(struct index_state *istate,
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		diff_setup(&opt);
+		repo_diff_setup(the_repository, &opt);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
diff --git a/revision.c b/revision.c
index 3457064ff3..0c6dc8c163 100644
--- a/revision.c
+++ b/revision.c
@@ -1468,7 +1468,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	grep_init(&revs->grep_filter, the_repository, prefix);
 	revs->grep_filter.status_only = 1;
 
-	diff_setup(&revs->diffopt);
+	repo_diff_setup(the_repository, &revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
diff --git a/tree-diff.c b/tree-diff.c
index 553bc0e63a..57a15f51f0 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -605,7 +605,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	diff_setup(&diff_opts);
+	repo_diff_setup(the_repository, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.rc0.337.ge906d732e7

