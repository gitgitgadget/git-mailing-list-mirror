Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A13E20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753718AbdJaSTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:35 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:51060 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932532AbdJaST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:27 -0400
Received: by mail-pg0-f47.google.com with SMTP id y5so15351600pgq.7
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZHfObsxbeONmctgKvu5POx1Z0VCT5MKgVM4pLWGvFzE=;
        b=hgooU6xJ3j7/79BPZAjDlnehqxQm/pu/3uY5laHUQnBj4KKdLabL3erV4QhToSWQ3+
         80W7CXJFm7ZxZJOkrOzmc72SFb0leNj7DcPTGQVDHBek8K0z6JJ3aPH6BpoMvREHkV6S
         t5PGfmmicK/KsmNH3nkttlZmgmg2zzWsCE22Y/c06f3gNyi8IqPptvgQ7dR0F7EzbSoY
         xfTDIe8G+sYLPUah4jVimjN8DPGp2EI4DHOjkGEeBMOrVj87EbgZHCboGlLrzCF4dWLx
         //0yUlqRHSB5pUprDohWYlsT+KH3CI+f2C/yhm3XqFIZh4o0TqUQxd0JjL67QFaifZt3
         eIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZHfObsxbeONmctgKvu5POx1Z0VCT5MKgVM4pLWGvFzE=;
        b=RYCKFD/cYS6Q1UF/yUk0/tvnj4WmQmCKMy8uCCW/tpXoYAvuAdeO1d+B3UxE5HIavM
         NJd4vk7QDm+pBPJ1ku/ZMe0Breb1Yj1h1Hu+1soV9UnBAnMZ353dEnCsXhVDTn4l80MQ
         Rd0RBaQpWX/ABewrSFe8crLXJQ94vTurIefndvbMxqCdpJftIk0twDVijw/Um6k98vmx
         RHjeDrA1TY4pBvpGGEJFcUCT0c3uUypfYUvQNhXAdnTU7s9wBRC8wq42s7F28QmIbqxb
         Tj3sbEpitqvI+9T7lbqnNC8oWU2hUV0gYdZgilpUb2Tt1/d9NMUhMJbz4xVTGiQkE/o1
         mT1g==
X-Gm-Message-State: AMCzsaXzKcOOrMJuQTcRTfSkWsQOEcjEQwEnZo/dOy9mczi3BXIJ/+Nd
        6mikcJhXgrjn/Zl5IG8pIrZNaKvheF8=
X-Google-Smtp-Source: ABhQp+SIqH4oLGoOjzrMoLUomKiCmPhjhxD+yDkzsrwd/X7Lii5niLPvFgHcE3eSn3cJJ+1aORaCYg==
X-Received: by 10.98.77.195 with SMTP id a186mr2916579pfb.292.1509473966416;
        Tue, 31 Oct 2017 11:19:26 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:24 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 6/8] diff: remove DIFF_OPT_SET macro
Date:   Tue, 31 Oct 2017 11:19:09 -0700
Message-Id: <20171031181911.42687-7-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171031181911.42687-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the `DIFF_OPT_SET` macro and instead set the flags directly.
This conversion is done using the following semantic patch:

	@@
	expression E;
	identifier fld;
	@@
	- DIFF_OPT_SET(&E, fld)
	+ E.flags.fld = 1

	@@
	type T;
	T *ptr;
	identifier fld;
	@@
	- DIFF_OPT_SET(ptr, fld)
	+ ptr->flags.fld = 1

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 blame.c               |  8 +++----
 builtin/add.c         |  4 ++--
 builtin/am.c          |  8 +++----
 builtin/blame.c       |  4 ++--
 builtin/diff.c        |  6 ++---
 builtin/fast-export.c |  2 +-
 builtin/log.c         | 14 +++++------
 builtin/reset.c       |  2 +-
 combine-diff.c        |  2 +-
 diff-lib.c            |  4 ++--
 diff-no-index.c       |  6 ++---
 diff.c                | 66 +++++++++++++++++++++++++--------------------------
 diff.h                |  1 -
 merge-recursive.c     |  2 +-
 notes-merge.c         |  4 ++--
 patch-ids.c           |  2 +-
 revision.c            | 16 ++++++-------
 submodule.c           |  8 +++----
 tree-diff.c           |  4 ++--
 wt-status.c           | 18 +++++++-------
 20 files changed, 90 insertions(+), 91 deletions(-)

diff --git a/blame.c b/blame.c
index 7c019bc7c..dc9cc237b 100644
--- a/blame.c
+++ b/blame.c
@@ -541,7 +541,7 @@ static struct blame_origin *find_origin(struct commit *parent,
 	 * same and diff-tree is fairly efficient about this.
 	 */
 	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.flags.RECURSIVE = 1;
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	paths[0] = origin->path;
@@ -615,7 +615,7 @@ static struct blame_origin *find_rename(struct commit *parent,
 	int i;
 
 	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.flags.RECURSIVE = 1;
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = origin->path;
@@ -1238,7 +1238,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 		return; /* nothing remains for this target */
 
 	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
+	diff_opts.flags.RECURSIVE = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
 	diff_setup_done(&diff_opts);
@@ -1253,7 +1253,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
 	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
 		&& (!porigin || strcmp(target->path, porigin->path))))
-		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
+		diff_opts.flags.FIND_COPIES_HARDER = 1;
 
 	if (is_null_oid(&target->commit->object.oid))
 		do_diff_cache(&parent->tree->object.oid, &diff_opts);
diff --git a/builtin/add.c b/builtin/add.c
index b70e8a779..e1d83b69a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -116,7 +116,7 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
 	rev.diffopt.format_callback_data = &data;
-	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	rev.diffopt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
 	clear_pathspec(&rev.prune_data);
@@ -218,7 +218,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev.diffopt.use_color = 0;
-	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
+	rev.diffopt.flags.IGNORE_DIRTY_SUBMODULES = 1;
 	out = open(file, O_CREAT | O_WRONLY, 0666);
 	if (out < 0)
 		die(_("Could not open '%s' for writing."), file);
diff --git a/builtin/am.c b/builtin/am.c
index fc54724cc..015425a0f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1157,9 +1157,9 @@ static int index_has_changes(struct strbuf *sb)
 		struct diff_options opt;
 
 		diff_setup(&opt);
-		DIFF_OPT_SET(&opt, EXIT_WITH_STATUS);
+		opt.flags.EXIT_WITH_STATUS = 1;
 		if (!sb)
-			DIFF_OPT_SET(&opt, QUICK);
+			opt.flags.QUICK = 1;
 		do_diff_cache(&head, &opt);
 		diffcore_std(&opt);
 		for (i = 0; sb && i < diff_queued_diff.nr; i++) {
@@ -1409,8 +1409,8 @@ static void write_commit_patch(const struct am_state *state, struct commit *comm
 	rev_info.show_root_diff = 1;
 	rev_info.diffopt.output_format = DIFF_FORMAT_PATCH;
 	rev_info.no_commit_id = 1;
-	DIFF_OPT_SET(&rev_info.diffopt, BINARY);
-	DIFF_OPT_SET(&rev_info.diffopt, FULL_INDEX);
+	rev_info.diffopt.flags.BINARY = 1;
+	rev_info.diffopt.flags.FULL_INDEX = 1;
 	rev_info.diffopt.use_color = 0;
 	rev_info.diffopt.file = fp;
 	rev_info.diffopt.close_file = 1;
diff --git a/builtin/blame.c b/builtin/blame.c
index a29574984..76994aa64 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -708,8 +708,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	git_config(git_blame_config, &output_option);
 	init_revisions(&revs, NULL);
 	revs.date_mode = blame_date_mode;
-	DIFF_OPT_SET(&revs.diffopt, ALLOW_TEXTCONV);
-	DIFF_OPT_SET(&revs.diffopt, FOLLOW_RENAMES);
+	revs.diffopt.flags.ALLOW_TEXTCONV = 1;
+	revs.diffopt.flags.FOLLOW_RENAMES = 1;
 
 	save_commit_buffer = 0;
 	dashdash_pos = 0;
diff --git a/builtin/diff.c b/builtin/diff.c
index 8cbaf4538..ed41eb5a5 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -350,8 +350,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	rev.diffopt.stat_graph_width = -1;
 
 	/* Default to let external and textconv be used */
-	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
-	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
+	rev.diffopt.flags.ALLOW_EXTERNAL = 1;
+	rev.diffopt.flags.ALLOW_TEXTCONV = 1;
 
 	if (nongit)
 		die(_("Not a git repository"));
@@ -361,7 +361,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		diff_setup_done(&rev.diffopt);
 	}
 
-	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	rev.diffopt.flags.RECURSIVE = 1;
 
 	setup_diff_pager(&rev.diffopt);
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 2fb60d6d4..35c8fb65d 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1066,7 +1066,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 		die("revision walk setup failed");
 	revs.diffopt.format_callback = show_filemodify;
 	revs.diffopt.format_callback_data = &paths_of_changed_objects;
-	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
+	revs.diffopt.flags.RECURSIVE = 1;
 	while ((commit = get_revision(&revs))) {
 		if (has_unshown_parent(commit)) {
 			add_object_array(&commit->object, NULL, &commits);
diff --git a/builtin/log.c b/builtin/log.c
index 2b2d36678..4a24d3e48 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -121,16 +121,16 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
 	if (default_follow)
-		DIFF_OPT_SET(&rev->diffopt, DEFAULT_FOLLOW_RENAMES);
+		rev->diffopt.flags.DEFAULT_FOLLOW_RENAMES = 1;
 	rev->verbose_header = 1;
-	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
+	rev->diffopt.flags.RECURSIVE = 1;
 	rev->diffopt.stat_width = -1; /* use full terminal width */
 	rev->diffopt.stat_graph_width = -1; /* respect statGraphWidth config */
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	rev->show_signature = default_show_signature;
-	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
+	rev->diffopt.flags.ALLOW_TEXTCONV = 1;
 
 	if (default_date_mode)
 		parse_date_format(default_date_mode, &rev->date_mode);
@@ -668,7 +668,7 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 {
 	if (rev->diffopt.flags.DEFAULT_FOLLOW_RENAMES &&
 	    rev->prune_data.nr == 1)
-		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
+		rev->diffopt.flags.FOLLOW_RENAMES = 1;
 
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
 	if (!rev->diffopt.output_format && rev->combine_merges)
@@ -1340,7 +1340,7 @@ static void prepare_bases(struct base_tree_info *bases,
 		return;
 
 	diff_setup(&diffopt);
-	DIFF_OPT_SET(&diffopt, RECURSIVE);
+	diffopt.flags.RECURSIVE = 1;
 	diff_setup_done(&diffopt);
 
 	oidcpy(&bases->base_commit, &base->object.oid);
@@ -1511,7 +1511,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.verbose_header = 1;
 	rev.diff = 1;
 	rev.max_parents = 1;
-	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
+	rev.diffopt.flags.RECURSIVE = 1;
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
@@ -1613,7 +1613,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.zero_commit = zero_commit;
 
 	if (!rev.diffopt.flags.TEXT && !no_binary_diff)
-		DIFF_OPT_SET(&rev.diffopt, BINARY);
+		rev.diffopt.flags.BINARY = 1;
 
 	if (rev.show_notes)
 		init_display_notes(&rev.notes_opt);
diff --git a/builtin/reset.c b/builtin/reset.c
index ea2fad5a0..206819ef1 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -166,7 +166,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.output_format = DIFF_FORMAT_CALLBACK;
 	opt.format_callback = update_index_from_diff;
 	opt.format_callback_data = &intent_to_add;
-	DIFF_OPT_SET(&opt, OVERRIDE_SUBMODULE_CONFIG);
+	opt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
diff --git a/combine-diff.c b/combine-diff.c
index 40cb4dd1a..204b0dfce 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1413,7 +1413,7 @@ void diff_tree_combined(const struct object_id *oid,
 
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
-	DIFF_OPT_SET(&diffopts, RECURSIVE);
+	diffopts.flags.RECURSIVE = 1;
 	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
 
 	/* find set of paths that everybody touches
diff --git a/diff-lib.c b/diff-lib.c
index 456971b2c..f1cc3fd51 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -545,8 +545,8 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	memset(&opt, 0, sizeof(opt));
 	opt.def = def;
 	setup_revisions(0, NULL, &rev, &opt);
-	DIFF_OPT_SET(&rev.diffopt, QUICK);
-	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
+	rev.diffopt.flags.QUICK = 1;
+	rev.diffopt.flags.EXIT_WITH_STATUS = 1;
 	if (flags)
 		diff_flags_or(&rev.diffopt.flags, flags);
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
diff --git a/diff-no-index.c b/diff-no-index.c
index 40d17e42c..a3e194340 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -276,16 +276,16 @@ void diff_no_index(struct rev_info *revs,
 	if (!revs->diffopt.output_format)
 		revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
+	revs->diffopt.flags.NO_INDEX = 1;
 
-	DIFF_OPT_SET(&revs->diffopt, RELATIVE_NAME);
+	revs->diffopt.flags.RELATIVE_NAME = 1;
 	revs->diffopt.prefix = prefix;
 
 	revs->max_count = -2;
 	diff_setup_done(&revs->diffopt);
 
 	setup_diff_pager(&revs->diffopt);
-	DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
+	revs->diffopt.flags.EXIT_WITH_STATUS = 1;
 
 	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
 		exit(1);
diff --git a/diff.c b/diff.c
index 8bfa57cc3..6dea186d8 100644
--- a/diff.c
+++ b/diff.c
@@ -127,15 +127,15 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
 		} else if (!strcmp(p, "lines")) {
-			DIFF_OPT_SET(options, DIRSTAT_BY_LINE);
+			options->flags.DIRSTAT_BY_LINE = 1;
 			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
 		} else if (!strcmp(p, "files")) {
 			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
-			DIFF_OPT_SET(options, DIRSTAT_BY_FILE);
+			options->flags.DIRSTAT_BY_FILE = 1;
 		} else if (!strcmp(p, "noncumulative")) {
 			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
 		} else if (!strcmp(p, "cumulative")) {
-			DIFF_OPT_SET(options, DIRSTAT_CUMULATIVE);
+			options->flags.DIRSTAT_CUMULATIVE = 1;
 		} else if (isdigit(*p)) {
 			char *end;
 			int permille = strtoul(p, &end, 10) * 10;
@@ -3447,7 +3447,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	diff_free_filespec_data(one);
 	diff_free_filespec_data(two);
 	if (data.status)
-		DIFF_OPT_SET(o, CHECK_FAILED);
+		o->flags.CHECK_FAILED = 1;
 }
 
 struct diff_filespec *alloc_filespec(const char *path)
@@ -4152,7 +4152,7 @@ void diff_setup(struct diff_options *options)
 	options->context = diff_context_default;
 	options->interhunkcontext = diff_interhunk_context_default;
 	options->ws_error_highlight = ws_error_highlight_default;
-	DIFF_OPT_SET(options, RENAME_EMPTY);
+	options->flags.RENAME_EMPTY = 1;
 
 	/* pathchange left =NULL by default */
 	options->change = diff_change;
@@ -4203,7 +4203,7 @@ void diff_setup_done(struct diff_options *options)
 	if (DIFF_XDL_TST(options, IGNORE_WHITESPACE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_CHANGE) ||
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
-		DIFF_OPT_SET(options, DIFF_FROM_CONTENTS);
+		options->flags.DIFF_FROM_CONTENTS = 1;
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
 
@@ -4240,18 +4240,18 @@ void diff_setup_done(struct diff_options *options)
 				      DIFF_FORMAT_DIRSTAT |
 				      DIFF_FORMAT_SUMMARY |
 				      DIFF_FORMAT_CHECKDIFF))
-		DIFF_OPT_SET(options, RECURSIVE);
+		options->flags.RECURSIVE = 1;
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
 	if (options->pickaxe)
-		DIFF_OPT_SET(options, RECURSIVE);
+		options->flags.RECURSIVE = 1;
 	/*
 	 * When patches are generated, submodules diffed against the work tree
 	 * must be checked for dirtiness too so it can be shown in the output
 	 */
 	if (options->output_format & DIFF_FORMAT_PATCH)
-		DIFF_OPT_SET(options, DIRTY_SUBMODULES);
+		options->flags.DIRTY_SUBMODULES = 1;
 
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
@@ -4275,7 +4275,7 @@ void diff_setup_done(struct diff_options *options)
 	 */
 	if (options->flags.QUICK) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
-		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
+		options->flags.EXIT_WITH_STATUS = 1;
 	}
 
 	options->diff_path_counter = 0;
@@ -4630,7 +4630,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
 		 !strcmp(arg, "--find-copies")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
-			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+			options->flags.FIND_COPIES_HARDER = 1;
 		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return error("invalid argument to -C: %s", arg+2);
 		options->detect_rename = DIFF_DETECT_COPY;
@@ -4638,13 +4638,13 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--rename-empty"))
-		DIFF_OPT_SET(options, RENAME_EMPTY);
+		options->flags.RENAME_EMPTY = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
 		DIFF_OPT_CLR(options, RENAME_EMPTY);
 	else if (!strcmp(arg, "--relative"))
-		DIFF_OPT_SET(options, RELATIVE_NAME);
+		options->flags.RELATIVE_NAME = 1;
 	else if (skip_prefix(arg, "--relative=", &arg)) {
-		DIFF_OPT_SET(options, RELATIVE_NAME);
+		options->flags.RELATIVE_NAME = 1;
 		options->prefix = arg;
 	}
 
@@ -4684,18 +4684,18 @@ int diff_opt_parse(struct diff_options *options,
 	/* flags options */
 	else if (!strcmp(arg, "--binary")) {
 		enable_patch_output(&options->output_format);
-		DIFF_OPT_SET(options, BINARY);
+		options->flags.BINARY = 1;
 	}
 	else if (!strcmp(arg, "--full-index"))
-		DIFF_OPT_SET(options, FULL_INDEX);
+		options->flags.FULL_INDEX = 1;
 	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
-		DIFF_OPT_SET(options, TEXT);
+		options->flags.TEXT = 1;
 	else if (!strcmp(arg, "-R"))
-		DIFF_OPT_SET(options, REVERSE_DIFF);
+		options->flags.REVERSE_DIFF = 1;
 	else if (!strcmp(arg, "--find-copies-harder"))
-		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+		options->flags.FIND_COPIES_HARDER = 1;
 	else if (!strcmp(arg, "--follow"))
-		DIFF_OPT_SET(options, FOLLOW_RENAMES);
+		options->flags.FOLLOW_RENAMES = 1;
 	else if (!strcmp(arg, "--no-follow")) {
 		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
 		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
@@ -4755,23 +4755,23 @@ int diff_opt_parse(struct diff_options *options,
 		return argcount;
 	}
 	else if (!strcmp(arg, "--exit-code"))
-		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
+		options->flags.EXIT_WITH_STATUS = 1;
 	else if (!strcmp(arg, "--quiet"))
-		DIFF_OPT_SET(options, QUICK);
+		options->flags.QUICK = 1;
 	else if (!strcmp(arg, "--ext-diff"))
-		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
+		options->flags.ALLOW_EXTERNAL = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
 		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--textconv")) {
-		DIFF_OPT_SET(options, ALLOW_TEXTCONV);
-		DIFF_OPT_SET(options, TEXTCONV_SET_VIA_CMDLINE);
+		options->flags.ALLOW_TEXTCONV = 1;
+		options->flags.TEXTCONV_SET_VIA_CMDLINE = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
 		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
 	else if (!strcmp(arg, "--ignore-submodules")) {
-		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
+		options->flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 		handle_ignore_submodules_arg(options, "all");
 	} else if (skip_prefix(arg, "--ignore-submodules=", &arg)) {
-		DIFF_OPT_SET(options, OVERRIDE_SUBMODULE_CONFIG);
+		options->flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 		handle_ignore_submodules_arg(options, arg);
 	} else if (!strcmp(arg, "--submodule"))
 		options->submodule_format = DIFF_SUBMODULE_LOG;
@@ -4846,9 +4846,9 @@ int diff_opt_parse(struct diff_options *options,
 			 &options->interhunkcontext))
 		;
 	else if (!strcmp(arg, "-W"))
-		DIFF_OPT_SET(options, FUNCCONTEXT);
+		options->flags.FUNCCONTEXT = 1;
 	else if (!strcmp(arg, "--function-context"))
-		DIFF_OPT_SET(options, FUNCCONTEXT);
+		options->flags.FUNCCONTEXT = 1;
 	else if (!strcmp(arg, "--no-function-context"))
 		DIFF_OPT_CLR(options, FUNCCONTEXT);
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
@@ -5686,7 +5686,7 @@ void diff_flush(struct diff_options *options)
 	 */
 	if (options->flags.DIFF_FROM_CONTENTS) {
 		if (options->found_changes)
-			DIFF_OPT_SET(options, HAS_CHANGES);
+			options->flags.HAS_CHANGES = 1;
 		else
 			DIFF_OPT_CLR(options, HAS_CHANGES);
 	}
@@ -5858,7 +5858,7 @@ void diffcore_std(struct diff_options *options)
 	diffcore_apply_filter(options);
 
 	if (diff_queued_diff.nr && !options->flags.DIFF_FROM_CONTENTS)
-		DIFF_OPT_SET(options, HAS_CHANGES);
+		options->flags.HAS_CHANGES = 1;
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
 
@@ -5952,7 +5952,7 @@ void diff_addremove(struct diff_options *options,
 
 	diff_queue(&diff_queued_diff, one, two);
 	if (!options->flags.DIFF_FROM_CONTENTS)
-		DIFF_OPT_SET(options, HAS_CHANGES);
+		options->flags.HAS_CHANGES = 1;
 }
 
 void diff_change(struct diff_options *options,
@@ -5996,7 +5996,7 @@ void diff_change(struct diff_options *options,
 	    !diff_filespec_check_stat_unmatch(p))
 		return;
 
-	DIFF_OPT_SET(options, HAS_CHANGES);
+	options->flags.HAS_CHANGES = 1;
 }
 
 struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
diff --git a/diff.h b/diff.h
index c3798a104..d53e5a2da 100644
--- a/diff.h
+++ b/diff.h
@@ -106,7 +106,6 @@ static inline void diff_flags_or(struct diff_flags *a,
 		tmp_a[i] |= tmp_b[i];
 }
 
-#define DIFF_OPT_SET(opts, flag)	((opts)->flags.flag = 1)
 #define DIFF_OPT_CLR(opts, flag)	((opts)->flags.flag = 0)
 
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
diff --git a/merge-recursive.c b/merge-recursive.c
index 1d3f8f0d2..e7b3df45c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -540,7 +540,7 @@ static struct string_list *get_renames(struct merge_options *o,
 		return renames;
 
 	diff_setup(&opts);
-	DIFF_OPT_SET(&opts, RECURSIVE);
+	opts.flags.RECURSIVE = 1;
 	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
diff --git a/notes-merge.c b/notes-merge.c
index 4352c34a6..b50111cf2 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -125,7 +125,7 @@ static struct notes_merge_pair *diff_tree_remote(struct notes_merge_options *o,
 	       oid_to_hex(base), oid_to_hex(remote));
 
 	diff_setup(&opt);
-	DIFF_OPT_SET(&opt, RECURSIVE);
+	opt.flags.RECURSIVE = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
 	diff_tree_oid(base, remote, "", &opt);
@@ -188,7 +188,7 @@ static void diff_tree_local(struct notes_merge_options *o,
 	       len, oid_to_hex(base), oid_to_hex(local));
 
 	diff_setup(&opt);
-	DIFF_OPT_SET(&opt, RECURSIVE);
+	opt.flags.RECURSIVE = 1;
 	opt.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_setup_done(&opt);
 	diff_tree_oid(base, local, "", &opt);
diff --git a/patch-ids.c b/patch-ids.c
index 7a583b301..189869e57 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -61,7 +61,7 @@ int init_patch_ids(struct patch_ids *ids)
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
 	ids->diffopts.detect_rename = 0;
-	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
+	ids->diffopts.flags.RECURSIVE = 1;
 	diff_setup_done(&ids->diffopts);
 	hashmap_init(&ids->patches, patch_id_cmp, &ids->diffopts, 256);
 	return 0;
diff --git a/revision.c b/revision.c
index c893d9166..f019dd277 100644
--- a/revision.c
+++ b/revision.c
@@ -410,7 +410,7 @@ static void file_add_remove(struct diff_options *options,
 
 	tree_difference |= diff;
 	if (tree_difference == REV_TREE_DIFFERENT)
-		DIFF_OPT_SET(options, HAS_CHANGES);
+		options->flags.HAS_CHANGES = 1;
 }
 
 static void file_change(struct diff_options *options,
@@ -422,7 +422,7 @@ static void file_change(struct diff_options *options,
 		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
 {
 	tree_difference = REV_TREE_DIFFERENT;
-	DIFF_OPT_SET(options, HAS_CHANGES);
+	options->flags.HAS_CHANGES = 1;
 }
 
 static int rev_compare_tree(struct rev_info *revs,
@@ -1403,8 +1403,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
-	DIFF_OPT_SET(&revs->pruning, RECURSIVE);
-	DIFF_OPT_SET(&revs->pruning, QUICK);
+	revs->pruning.flags.RECURSIVE = 1;
+	revs->pruning.flags.QUICK = 1;
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
 	revs->sort_order = REV_SORT_IN_GRAPH_ORDER;
@@ -1917,11 +1917,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		die("--unpacked=<packfile> no longer supported.");
 	} else if (!strcmp(arg, "-r")) {
 		revs->diff = 1;
-		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
+		revs->diffopt.flags.RECURSIVE = 1;
 	} else if (!strcmp(arg, "-t")) {
 		revs->diff = 1;
-		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
-		DIFF_OPT_SET(&revs->diffopt, TREE_IN_RECURSIVE);
+		revs->diffopt.flags.RECURSIVE = 1;
+		revs->diffopt.flags.TREE_IN_RECURSIVE = 1;
 	} else if (!strcmp(arg, "-m")) {
 		revs->ignore_merges = 0;
 	} else if (!strcmp(arg, "-c")) {
@@ -2066,7 +2066,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.ignore_case = 1;
-		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
+		revs->diffopt.flags.PICKAXE_IGNORE_CASE = 1;
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
 	} else if (!strcmp(arg, "--perl-regexp") || !strcmp(arg, "-P")) {
diff --git a/submodule.c b/submodule.c
index 58da9c668..7e7998592 100644
--- a/submodule.c
+++ b/submodule.c
@@ -183,7 +183,7 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 		if (ignore)
 			handle_ignore_submodules_arg(diffopt, ignore);
 		else if (is_gitmodules_unmerged(&the_index))
-			DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
+			diffopt->flags.IGNORE_SUBMODULES = 1;
 	}
 }
 
@@ -407,11 +407,11 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
 	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
 
 	if (!strcmp(arg, "all"))
-		DIFF_OPT_SET(diffopt, IGNORE_SUBMODULES);
+		diffopt->flags.IGNORE_SUBMODULES = 1;
 	else if (!strcmp(arg, "untracked"))
-		DIFF_OPT_SET(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
+		diffopt->flags.IGNORE_UNTRACKED_IN_SUBMODULES = 1;
 	else if (!strcmp(arg, "dirty"))
-		DIFF_OPT_SET(diffopt, IGNORE_DIRTY_SUBMODULES);
+		diffopt->flags.IGNORE_DIRTY_SUBMODULES = 1;
 	else if (strcmp(arg, "none"))
 		die("bad --ignore-submodules argument: %s", arg);
 }
diff --git a/tree-diff.c b/tree-diff.c
index ed0aa6a62..b996a23bb 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -608,8 +608,8 @@ static void try_to_follow_renames(const struct object_id *old_oid,
 	q->nr = 0;
 
 	diff_setup(&diff_opts);
-	DIFF_OPT_SET(&diff_opts, RECURSIVE);
-	DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
+	diff_opts.flags.RECURSIVE = 1;
+	diff_opts.flags.FIND_COPIES_HARDER = 1;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->pathspec.items[0].match;
 	diff_opts.break_opt = opt->break_opt;
diff --git a/wt-status.c b/wt-status.c
index 29bc64cc0..59f9f3a0b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -559,12 +559,12 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	init_revisions(&rev, NULL);
 	setup_revisions(0, NULL, &rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
-	DIFF_OPT_SET(&rev.diffopt, DIRTY_SUBMODULES);
+	rev.diffopt.flags.DIRTY_SUBMODULES = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 	if (!s->show_untracked_files)
-		DIFF_OPT_SET(&rev.diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
+		rev.diffopt.flags.IGNORE_UNTRACKED_IN_SUBMODULES = 1;
 	if (s->ignore_submodule_arg) {
-		DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+		rev.diffopt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
 	}
 	rev.diffopt.format_callback = wt_status_collect_changed_cb;
@@ -583,7 +583,7 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	opt.def = s->is_initial ? EMPTY_TREE_SHA1_HEX : s->reference;
 	setup_revisions(0, NULL, &rev, &opt);
 
-	DIFF_OPT_SET(&rev.diffopt, OVERRIDE_SUBMODULE_CONFIG);
+	rev.diffopt.flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 	if (s->ignore_submodule_arg) {
 		handle_ignore_submodules_arg(&rev.diffopt, s->ignore_submodule_arg);
@@ -949,7 +949,7 @@ static void wt_longstatus_print_verbose(struct wt_status *s)
 	const char *c = color(WT_STATUS_HEADER, s);
 
 	init_revisions(&rev, NULL);
-	DIFF_OPT_SET(&rev.diffopt, ALLOW_TEXTCONV);
+	rev.diffopt.flags.ALLOW_TEXTCONV = 1;
 	rev.diffopt.ita_invisible_in_index = 1;
 
 	memset(&opt, 0, sizeof(opt));
@@ -2263,8 +2263,8 @@ int has_unstaged_changes(int ignore_submodules)
 
 	init_revisions(&rev_info, NULL);
 	if (ignore_submodules)
-		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+		rev_info.diffopt.flags.IGNORE_SUBMODULES = 1;
+	rev_info.diffopt.flags.QUICK = 1;
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_files(&rev_info, 0);
 	return diff_result_code(&rev_info.diffopt, result);
@@ -2283,8 +2283,8 @@ int has_uncommitted_changes(int ignore_submodules)
 
 	init_revisions(&rev_info, NULL);
 	if (ignore_submodules)
-		DIFF_OPT_SET(&rev_info.diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_SET(&rev_info.diffopt, QUICK);
+		rev_info.diffopt.flags.IGNORE_SUBMODULES = 1;
+	rev_info.diffopt.flags.QUICK = 1;
 	add_head_to_pending(&rev_info);
 	diff_setup_done(&rev_info.diffopt);
 	result = run_diff_index(&rev_info, 1);
-- 
2.15.0.403.gc27cc4dac6-goog

