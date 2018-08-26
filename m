Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3562E1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbeHZNpd (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:33287 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHZNpc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id m26-v6so1346083lfb.0
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1tVyKY5z40JkM+WunPA+ph0VX9wPl5iJ2rPvvSXxdwg=;
        b=cpQUVKYg8TRou2mBCkdS336S6xbWgAT7wtNk05jKL+e/qN2Yt5sLuzdoDIM0Ylfg6G
         R1VPP8sdvcbK207CyGA3SxxXyeZhqOYg7H3T/XaquLfj7YikQdeFQK7Hw/OBZa3m18qC
         G9MOl0ZEha0xOeUuNW/lXqizPOgRUQX6+gg47uTx2QJQ3EokRxysKQ+Xs0bZNFAvyF7m
         W6uOsU3RS/+C8suEX8ZnRc0TAYjlt84M7caOZUHbrO2M8LtNJKMIBE9R1VMx7eiK7Qq9
         hFqh83hXUZB2OReI+Av6sILeQbUaqC+X4eShvP113VA4NUWjXVBxdEac860wwhX5u+bW
         Z4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tVyKY5z40JkM+WunPA+ph0VX9wPl5iJ2rPvvSXxdwg=;
        b=qGa4llEvOoKYkaijBoiWF3as8t0vWM4sWBv61G3715eezhKU7/wNWdiNIpWb69hmSW
         uXHasmxFq7Lb9je8+24SE1vZcHI4ZNjr/o2s7EqCZm1U0SkduGVOVBfqEGmA/YMhwtc/
         cd+BHq4/2+WYeqK4BfLKII5n4StR5DdC5hjiejBzR7U1+TJg2S3Pf6PWqtAKTMEXwQvQ
         Y5hAqijze7ITomEvSGV08DdQ6pqabBZpy9l+gaAhsTzFbJVAzi/VZxYy+JdtV74Ksiv+
         EJMmXIkpRqGbiCqzn1u3bgwYsEOwWvZwqW/UpW/SGbS1NMz0EMSNQPH60nVP2FN3KRl6
         y4eg==
X-Gm-Message-State: APzg51CaDMFXS3EInGyIVyp7FqgvZcB9CRMQSy76Mm5K0/4Nx9/hbHH/
        znFScVPTWhM6tiSL+qSXRD0qBW/s
X-Google-Smtp-Source: ANB0VdYSciiHzrWDvyjz+FB3K3IZz6hnrN3ALkMujnHWkH/eDIw4Vh+ZLpItY8B1ha9ilv65vItcjQ==
X-Received: by 2002:a19:1f01:: with SMTP id f1-v6mr1518321lff.42.1535277803815;
        Sun, 26 Aug 2018 03:03:23 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:23 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 06/21] diff.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:02:59 +0200
Message-Id: <20180826100314.5137-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 blame.c              | 20 +++++++++++---------
 builtin/diff.c       |  2 +-
 builtin/log.c        |  2 +-
 builtin/merge.c      |  2 +-
 builtin/range-diff.c |  2 +-
 diff-no-index.c      |  9 +++++++--
 diff.c               |  4 ++--
 diff.h               |  4 ++--
 merge-recursive.c    |  2 +-
 notes-merge.c        |  4 ++--
 patch-ids.c          |  2 +-
 read-cache.c         |  2 +-
 revision.c           |  2 +-
 tree-diff.c          |  2 +-
 14 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/blame.c b/blame.c
index 366d8d85e7..90a32938ad 100644
--- a/blame.c
+++ b/blame.c
@@ -543,8 +543,9 @@ static int fill_blob_sha1_and_mode(struct repository *repo,
  * We have an origin -- check if the same path exists in the
  * parent and return an origin structure to represent it.
  */
-static struct blame_origin *find_origin(struct commit *parent,
-				  struct blame_origin *origin)
+static struct blame_origin *find_origin(struct repository *repo,
+					struct commit *parent,
+					struct blame_origin *origin)
 {
 	struct blame_origin *porigin;
 	struct diff_options diff_opts;
@@ -564,7 +565,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 	 * and origin first.  Most of the time they are the
 	 * same and diff-tree is fairly efficient about this.
 	 */
-	diff_setup(&diff_opts);
+	diff_setup(&diff_opts, repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -631,14 +632,15 @@ static struct blame_origin *find_origin(struct commit *parent,
  * We have an origin -- find the path that corresponds to it in its
  * parent and return an origin structure to represent it.
  */
-static struct blame_origin *find_rename(struct commit *parent,
-				  struct blame_origin *origin)
+static struct blame_origin *find_rename(struct repository *repo,
+					struct commit *parent,
+					struct blame_origin *origin)
 {
 	struct blame_origin *porigin = NULL;
 	struct diff_options diff_opts;
 	int i;
 
-	diff_setup(&diff_opts);
+	diff_setup(&diff_opts, repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
@@ -1262,7 +1264,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if (!unblamed)
 		return; /* nothing remains for this target */
 
-	diff_setup(&diff_opts);
+	diff_setup(&diff_opts, sb->repo);
 	diff_opts.flags.recursive = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
@@ -1444,7 +1446,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 	 * common cases, then we look for renames in the second pass.
 	 */
 	for (pass = 0; pass < 2 - sb->no_whole_file_rename; pass++) {
-		struct blame_origin *(*find)(struct commit *, struct blame_origin *);
+		struct blame_origin *(*find)(struct repository *, struct commit *, struct blame_origin *);
 		find = pass ? find_rename : find_origin;
 
 		for (i = 0, sg = first_scapegoat(revs, commit, sb->reverse);
@@ -1457,7 +1459,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
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
index b62082472c..33084102e0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1361,7 +1361,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	init_commit_base(&commit_base);
-	diff_setup(&diffopt);
+	diff_setup(&diffopt, the_repository);
 	diffopt.flags.recursive = 1;
 	diff_setup_done(&diffopt);
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 8f4a5065c2..0a37d5ef2c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -452,7 +452,7 @@ static void finish(struct commit *head_commit,
 	}
 	if (new_head && show_diffstat) {
 		struct diff_options opts;
-		diff_setup(&opts);
+		diff_setup(&opts, the_repository);
 		opts.stat_width = -1; /* use full terminal width */
 		opts.stat_graph_width = -1; /* respect statGraphWidth config */
 		opts.output_format |=
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f52d45d9d6..ec1bbef15d 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -34,7 +34,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 
 	git_config(git_diff_ui_config, NULL);
 
-	diff_setup(&diffopt);
+	diff_setup(&diffopt, the_repository);
 	diffopt.output_format = DIFF_FORMAT_PATCH;
 	diffopt.flags.suppress_diff_headers = 1;
 	diffopt.output_prefix = output_prefix_cb;
diff --git a/diff-no-index.c b/diff-no-index.c
index 0ed5f0f496..eff23f71ae 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -233,7 +233,8 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
 	}
 }
 
-void diff_no_index(struct rev_info *revs,
+void diff_no_index(struct repository *repo,
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
+	diff_setup(&revs->diffopt, repo);
 	for (i = 1; i < argc - 2; ) {
 		int j;
 		if (!strcmp(argv[i], "--no-index"))
diff --git a/diff.c b/diff.c
index c6ff993c56..a702ed98bb 100644
--- a/diff.c
+++ b/diff.c
@@ -4390,12 +4390,12 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
 	builtin_checkdiff(name, other, attr_path, p->one, p->two, o);
 }
 
-void diff_setup(struct diff_options *options)
+void diff_setup(struct diff_options *options, struct repository *repo)
 {
 	memcpy(options, &default_diff_options, sizeof(*options));
 
 	options->file = stdout;
-	options->repo->index = &the_index;
+	options->repo = repo;
 
 	options->abbrev = DEFAULT_ABBREV;
 	options->line_termination = '\n';
diff --git a/diff.h b/diff.h
index 07ba13ec4c..1d364c3867 100644
--- a/diff.h
+++ b/diff.h
@@ -336,7 +336,7 @@ int git_diff_basic_config(const char *var, const char *value, void *cb);
 int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 void init_diff_ui_defaults(void);
 int git_diff_ui_config(const char *var, const char *value, void *cb);
-void diff_setup(struct diff_options *);
+void diff_setup(struct diff_options *, struct repository *);
 int diff_opt_parse(struct diff_options *, const char **, int, const char *);
 void diff_setup_done(struct diff_options *);
 int git_config_rename(const char *var, const char *value);
@@ -426,7 +426,7 @@ int diff_flush_patch_id(struct diff_options *, struct object_id *, int);
 
 int diff_result_code(struct diff_options *, int);
 
-void diff_no_index(struct rev_info *, int, const char **);
+void diff_no_index(struct repository *, struct rev_info *, int, const char **);
 
 int index_differs_from(const char *def, const struct diff_flags *flags,
 		       int ita_invisible_in_index);
diff --git a/merge-recursive.c b/merge-recursive.c
index dcdc93019c..6d10ce897c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1812,7 +1812,7 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
 	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	diff_setup(&opts);
+	diff_setup(&opts, the_repository);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
 	opts.detect_rename = merge_detect_rename(o);
diff --git a/notes-merge.c b/notes-merge.c
index 76ab19e702..804a631bff 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -126,7 +126,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_remote(base = %.7s, remote = %.7s)\n",
 	       oid_to_hex(base), oid_to_hex(remote));
 
-	diff_setup(&opt);
+	diff_setup(&opt, the_repository);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
@@ -189,7 +189,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	trace_printf("\tdiff_tree_local(len = %i, base = %.7s, local = %.7s)\n",
 	       len, oid_to_hex(base), oid_to_hex(local));
 
-	diff_setup(&opt);
+	diff_setup(&opt, the_repository);
 	opt.flags.recursive = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
diff --git a/patch-ids.c b/patch-ids.c
index 8f7c25d5db..9084604c77 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -59,7 +59,7 @@ static int patch_id_cmp(const void *cmpfn_data,
 int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
-	diff_setup(&ids->diffopts);
+	diff_setup(&ids->diffopts, the_repository);
 	ids->diffopts.detect_rename = 0;
 	ids->diffopts.flags.recursive = 1;
 	diff_setup_done(&ids->diffopts);
diff --git a/read-cache.c b/read-cache.c
index 86134e56a6..8e92b1e21f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2137,7 +2137,7 @@ int index_has_changes(struct index_state *istate,
 	if (tree || !get_oid_tree("HEAD", &cmp)) {
 		struct diff_options opt;
 
-		diff_setup(&opt);
+		diff_setup(&opt, the_repository);
 		opt.flags.exit_with_status = 1;
 		if (!sb)
 			opt.flags.quick = 1;
diff --git a/revision.c b/revision.c
index 3457064ff3..bfcb0f2a00 100644
--- a/revision.c
+++ b/revision.c
@@ -1468,7 +1468,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	grep_init(&revs->grep_filter, the_repository, prefix);
 	revs->grep_filter.status_only = 1;
 
-	diff_setup(&revs->diffopt);
+	diff_setup(&revs->diffopt, the_repository);
 	if (prefix && !revs->diffopt.prefix) {
 		revs->diffopt.prefix = prefix;
 		revs->diffopt.prefix_length = strlen(prefix);
diff --git a/tree-diff.c b/tree-diff.c
index fe2e466ac1..d29127b029 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -607,7 +607,7 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	choice = q->queue[0];
 	q->nr = 0;
 
-	diff_setup(&diff_opts);
+	diff_setup(&diff_opts, the_repository);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.find_copies_harder = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-- 
2.19.0.rc0.337.ge906d732e7

