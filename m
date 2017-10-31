Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AECAC20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932566AbdJaST3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:29 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:44333 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932447AbdJaSTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:25 -0400
Received: by mail-pg0-f68.google.com with SMTP id j3so15377840pga.1
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fIl4Xp6U6gaFAJS2CXgEImDqG6WfSb4UENynkRnkDhI=;
        b=OAZ79gdL0mSJ38b6kuhjQrOnRfgQKLaghL7ODPFyfHI87Is9j3HZjraySG8iqaKIg3
         QTcIiMqk2vrXB/tm2a6E4cNFOS17JHhCG+VnI76c41P1GCG3syCqZZw2Wj3kOUZ8XCsT
         0CrXBSEYiVHvWuAZXQP74kXJ9ThHmtqiBpQiqZICQZRC2RuQZXrFAsyqrbB1eURVrR2Z
         M7eAAEJM2L2xVLSF/TPcSR99SWW9V4S9gw/KQ4QzS5n5JRpBPJH4bcEeldq3OzT9odZO
         k1e85fFR8CAO2nOpmgm2aC1aHFMjFAgAoISG6YA/uZJPlaeRYqzgjlRJLrQBpxFVmBz4
         b/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIl4Xp6U6gaFAJS2CXgEImDqG6WfSb4UENynkRnkDhI=;
        b=Eu1oeY7takkX25yG4LJE1Qu4GPnNr+BWv4DLsSiSklvlbVzYjdV5rsudhJWS0mxl09
         RSFub096LpH/ocEh+ilcw1TmO0aWAMO6m8jHrmqbJd5av4xx0Voau16Uj0lMRg3T4o+q
         5IQCeb4RFJ9jEMbJVLg66mWpfPIsW7j+qqSM5N/IE9J+qsV2xglFFQUG1dsXuKgaO+bB
         IDzS9SV40DTTnLBl5GeL0hH1S85fgB4H3lrN1MtBTMTVqyPg4rMDzzr8e7pi0StBiyQN
         09xfS9yyJ5VkRvkUGgDLI+GA2boZ6wjTtHtoezSb3Rtez97Mc+HigNiOMFdlFPwXOrnu
         /U0g==
X-Gm-Message-State: AMCzsaUWX0Rdho141bxr+rChBFo1IkvONnXVEY7goIP0CcFicd6mlgow
        MAxRvmK0bDv7bgfFmu37lKlGXv6qDLM=
X-Google-Smtp-Source: ABhQp+QDzhmqQ4tNFWLYEtOBeINc7OcGCuj43O0Stqpd7K+ltTjyKPNY7H+henedkvPzxOOfFK8/Mg==
X-Received: by 10.98.159.210 with SMTP id v79mr2979863pfk.162.1509473963665;
        Tue, 31 Oct 2017 11:19:23 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:22 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 5/8] diff: remove DIFF_OPT_TST macro
Date:   Tue, 31 Oct 2017 11:19:08 -0700
Message-Id: <20171031181911.42687-6-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171031181911.42687-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171031181911.42687-1-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the `DIFF_OPT_TST` macro and instead access the flags directly.
This conversion is done using the following semantic patch:

	@@
	expression E;
	identifier fld;
	@@
	- DIFF_OPT_TST(&E, fld)
	+ E.flags.fld

	@@
	type T;
	T *ptr;
	identifier fld;
	@@
	- DIFF_OPT_TST(ptr, fld)
	+ ptr->flags.fld

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 blame.c            |  8 +++---
 builtin/am.c       |  2 +-
 builtin/blame.c    |  4 +--
 builtin/diff.c     |  2 +-
 builtin/log.c      | 12 ++++-----
 builtin/rev-list.c |  2 +-
 combine-diff.c     |  6 ++---
 diff-lib.c         | 19 +++++++-------
 diff-no-index.c    |  2 +-
 diff.c             | 76 +++++++++++++++++++++++++++---------------------------
 diff.h             |  1 -
 diffcore-pickaxe.c |  8 +++---
 diffcore-rename.c  |  6 ++---
 log-tree.c         |  2 +-
 revision.c         |  4 +--
 submodule.c        |  2 +-
 tree-diff.c        | 12 ++++-----
 17 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/blame.c b/blame.c
index f575e9cbf..7c019bc7c 100644
--- a/blame.c
+++ b/blame.c
@@ -209,7 +209,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
-			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+			if (opt->flags.ALLOW_TEXTCONV &&
 			    textconv_object(read_from, mode, &null_oid, 0, &buf_ptr, &buf_len))
 				strbuf_attach(&buf, buf_ptr, buf_len, buf_len + 1);
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
@@ -293,7 +293,7 @@ static void fill_origin_blob(struct diff_options *opt,
 		unsigned long file_size;
 
 		(*num_read_blob)++;
-		if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
+		if (opt->flags.ALLOW_TEXTCONV &&
 		    textconv_object(o->path, o->mode, &o->blob_oid, 1, &file->ptr, &file_size))
 			;
 		else
@@ -1262,7 +1262,7 @@ static void find_copy_in_parent(struct blame_scoreboard *sb,
 			      &target->commit->tree->object.oid,
 			      "", &diff_opts);
 
-	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
+	if (!diff_opts.flags.FIND_COPIES_HARDER)
 		diffcore_std(&diff_opts);
 
 	do {
@@ -1825,7 +1825,7 @@ void setup_scoreboard(struct blame_scoreboard *sb, const char *path, struct blam
 		if (fill_blob_sha1_and_mode(o))
 			die(_("no such path %s in %s"), path, final_commit_name);
 
-		if (DIFF_OPT_TST(&sb->revs->diffopt, ALLOW_TEXTCONV) &&
+		if (sb->revs->diffopt.flags.ALLOW_TEXTCONV &&
 		    textconv_object(path, o->mode, &o->blob_oid, 1, (char **) &sb->final_buf,
 				    &sb->final_buf_size))
 			;
diff --git a/builtin/am.c b/builtin/am.c
index d7513f537..fc54724cc 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1168,7 +1168,7 @@ static int index_has_changes(struct strbuf *sb)
 			strbuf_addstr(sb, diff_queued_diff.queue[i]->two->path);
 		}
 		diff_flush(&opt);
-		return DIFF_OPT_TST(&opt, HAS_CHANGES) != 0;
+		return opt.flags.HAS_CHANGES != 0;
 	} else {
 		for (i = 0; sb && i < active_nr; i++) {
 			if (i)
diff --git a/builtin/blame.c b/builtin/blame.c
index 67adaef4d..a29574984 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -734,7 +734,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		parse_revision_opt(&revs, &ctx, options, blame_opt_usage);
 	}
 parse_done:
-	no_whole_file_rename = !DIFF_OPT_TST(&revs.diffopt, FOLLOW_RENAMES);
+	no_whole_file_rename = !revs.diffopt.flags.FOLLOW_RENAMES;
 	xdl_opts |= revs.diffopt.xdl_opts & XDF_INDENT_HEURISTIC;
 	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
 	argc = parse_options_end(&ctx);
@@ -803,7 +803,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	}
 	blame_date_width -= 1; /* strip the null */
 
-	if (DIFF_OPT_TST(&revs.diffopt, FIND_COPIES_HARDER))
+	if (revs.diffopt.flags.FIND_COPIES_HARDER)
 		opt |= (PICKAXE_BLAME_COPY | PICKAXE_BLAME_MOVE |
 			PICKAXE_BLAME_COPY_HARDER);
 
diff --git a/builtin/diff.c b/builtin/diff.c
index f5bbd4d75..8cbaf4538 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -44,7 +44,7 @@ static void stuff_change(struct diff_options *opt,
 	    !oidcmp(old_oid, new_oid) && (old_mode == new_mode))
 		return;
 
-	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
+	if (opt->flags.REVERSE_DIFF) {
 		SWAP(old_mode, new_mode);
 		SWAP(old_oid, new_oid);
 		SWAP(old_path, new_path);
diff --git a/builtin/log.c b/builtin/log.c
index 9c0815270..2b2d36678 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -181,7 +181,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		init_display_notes(&rev->notes_opt);
 
 	if (rev->diffopt.pickaxe || rev->diffopt.filter ||
-	    DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES))
+	    rev->diffopt.flags.FOLLOW_RENAMES)
 		rev->always_show_header = 0;
 
 	if (source)
@@ -391,7 +391,7 @@ static int cmd_log_walk(struct rev_info *rev)
 		fclose(rev->diffopt.file);
 
 	if (rev->diffopt.output_format & DIFF_FORMAT_CHECKDIFF &&
-	    DIFF_OPT_TST(&rev->diffopt, CHECK_FAILED)) {
+	    rev->diffopt.flags.CHECK_FAILED) {
 		return 02;
 	}
 	return diff_result_code(&rev->diffopt, 0);
@@ -483,8 +483,8 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 	unsigned long size;
 
 	fflush(rev->diffopt.file);
-	if (!DIFF_OPT_TST(&rev->diffopt, TEXTCONV_SET_VIA_CMDLINE) ||
-	    !DIFF_OPT_TST(&rev->diffopt, ALLOW_TEXTCONV))
+	if (!rev->diffopt.flags.TEXTCONV_SET_VIA_CMDLINE ||
+	    !rev->diffopt.flags.ALLOW_TEXTCONV)
 		return stream_blob_to_fd(1, oid, NULL, 0);
 
 	if (get_oid_with_context(obj_name, GET_OID_RECORD_PATH,
@@ -666,7 +666,7 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 static void log_setup_revisions_tweak(struct rev_info *rev,
 				      struct setup_revision_opt *opt)
 {
-	if (DIFF_OPT_TST(&rev->diffopt, DEFAULT_FOLLOW_RENAMES) &&
+	if (rev->diffopt.flags.DEFAULT_FOLLOW_RENAMES &&
 	    rev->prune_data.nr == 1)
 		DIFF_OPT_SET(&rev->diffopt, FOLLOW_RENAMES);
 
@@ -1612,7 +1612,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	rev.zero_commit = zero_commit;
 
-	if (!DIFF_OPT_TST(&rev.diffopt, TEXT) && !no_binary_diff)
+	if (!rev.diffopt.flags.TEXT && !no_binary_diff)
 		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
 	if (rev.show_notes)
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index c1c74d4a7..c62382171 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -294,7 +294,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.bisect)
 		bisect_list = 1;
 
-	if (DIFF_OPT_TST(&revs.diffopt, QUICK))
+	if (revs.diffopt.flags.QUICK)
 		info.flags |= REV_LIST_QUIET;
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/combine-diff.c b/combine-diff.c
index 9e163d5ad..40cb4dd1a 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -898,7 +898,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 				 int show_file_header)
 {
 	struct diff_options *opt = &rev->diffopt;
-	int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? GIT_SHA1_HEXSZ : DEFAULT_ABBREV;
+	int abbrev = opt->flags.FULL_INDEX ? GIT_SHA1_HEXSZ : DEFAULT_ABBREV;
 	const char *a_prefix = opt->a_prefix ? opt->a_prefix : "a/";
 	const char *b_prefix = opt->b_prefix ? opt->b_prefix : "b/";
 	const char *c_meta = diff_get_color_opt(opt, DIFF_METAINFO);
@@ -987,7 +987,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	userdiff = userdiff_find_by_path(elem->path);
 	if (!userdiff)
 		userdiff = userdiff_find_by_name("default");
-	if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV))
+	if (opt->flags.ALLOW_TEXTCONV)
 		textconv = userdiff_get_textconv(userdiff);
 
 	/* Read the result of merge first */
@@ -1435,7 +1435,7 @@ void diff_tree_combined(const struct object_id *oid,
 	 * NOTE please keep this semantically in sync with diffcore_std()
 	 */
 	need_generic_pathscan = opt->skip_stat_unmatch	||
-			DIFF_OPT_TST(opt, FOLLOW_RENAMES)	||
+			opt->flags.FOLLOW_RENAMES	||
 			opt->break_opt != -1	||
 			opt->detect_rename	||
 			opt->pickaxe		||
diff --git a/diff-lib.c b/diff-lib.c
index ed37f24c6..456971b2c 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -72,13 +72,14 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
 	int changed = ce_match_stat(ce, st, ce_option);
 	if (S_ISGITLINK(ce->ce_mode)) {
 		struct diff_flags orig_flags = diffopt->flags;
-		if (!DIFF_OPT_TST(diffopt, OVERRIDE_SUBMODULE_CONFIG))
+		if (!diffopt->flags.OVERRIDE_SUBMODULE_CONFIG)
 			set_diffopt_flags_from_submodule_config(diffopt, ce->name);
-		if (DIFF_OPT_TST(diffopt, IGNORE_SUBMODULES))
+		if (diffopt->flags.IGNORE_SUBMODULES)
 			changed = 0;
-		else if (!DIFF_OPT_TST(diffopt, IGNORE_DIRTY_SUBMODULES)
-		    && (!changed || DIFF_OPT_TST(diffopt, DIRTY_SUBMODULES)))
-			*dirty_submodule = is_submodule_modified(ce->name, DIFF_OPT_TST(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES));
+		else if (!diffopt->flags.IGNORE_DIRTY_SUBMODULES &&
+			 (!changed || diffopt->flags.DIRTY_SUBMODULES))
+			*dirty_submodule = is_submodule_modified(ce->name,
+								 diffopt->flags.IGNORE_UNTRACKED_IN_SUBMODULES);
 		diffopt->flags = orig_flags;
 	}
 	return changed;
@@ -228,7 +229,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 
 		if (!changed && !dirty_submodule) {
 			ce_mark_uptodate(ce);
-			if (!DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+			if (!revs->diffopt.flags.FIND_COPIES_HARDER)
 				continue;
 		}
 		oldmode = ce->ce_mode;
@@ -362,7 +363,7 @@ static int show_modified(struct rev_info *revs,
 
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !oidcmp(oid, &old->oid) && !dirty_submodule &&
-	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
+	    !revs->diffopt.flags.FIND_COPIES_HARDER)
 		return 0;
 
 	diff_change(&revs->diffopt, oldmode, mode,
@@ -493,7 +494,7 @@ static int diff_cache(struct rev_info *revs,
 	opts.head_idx = 1;
 	opts.index_only = cached;
 	opts.diff_index_cached = (cached &&
-				  !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER));
+				  !revs->diffopt.flags.FIND_COPIES_HARDER);
 	opts.merge = 1;
 	opts.fn = oneway_diff;
 	opts.unpack_data = revs;
@@ -551,5 +552,5 @@ int index_differs_from(const char *def, const struct diff_flags *flags,
 	rev.diffopt.ita_invisible_in_index = ita_invisible_in_index;
 	run_diff_index(&rev, 1);
 	object_array_clear(&rev.pending);
-	return (DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0);
+	return (rev.diffopt.flags.HAS_CHANGES != 0);
 }
diff --git a/diff-no-index.c b/diff-no-index.c
index 80ff17d46..40d17e42c 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -184,7 +184,7 @@ static int queue_diff(struct diff_options *o,
 	} else {
 		struct diff_filespec *d1, *d2;
 
-		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+		if (o->flags.REVERSE_DIFF) {
 			SWAP(mode1, mode2);
 			SWAP(name1, name2);
 		}
diff --git a/diff.c b/diff.c
index 11fccbd10..8bfa57cc3 100644
--- a/diff.c
+++ b/diff.c
@@ -1481,7 +1481,7 @@ static void emit_rewrite_diff(const char *name_a,
 	struct emit_callback ecbdata;
 	struct strbuf out = STRBUF_INIT;
 
-	if (diff_mnemonic_prefix && DIFF_OPT_TST(o, REVERSE_DIFF)) {
+	if (diff_mnemonic_prefix && o->flags.REVERSE_DIFF) {
 		a_prefix = o->b_prefix;
 		b_prefix = o->a_prefix;
 	} else {
@@ -2729,7 +2729,7 @@ static void show_dirstat(struct diff_options *options)
 	dir.alloc = 0;
 	dir.nr = 0;
 	dir.permille = options->dirstat_permille;
-	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
+	dir.cumulative = options->flags.DIRSTAT_CUMULATIVE;
 
 	changed = 0;
 	for (i = 0; i < q->nr; i++) {
@@ -2755,7 +2755,7 @@ static void show_dirstat(struct diff_options *options)
 			goto found_damage;
 		}
 
-		if (DIFF_OPT_TST(options, DIRSTAT_BY_FILE)) {
+		if (options->flags.DIRSTAT_BY_FILE) {
 			/*
 			 * In --dirstat-by-file mode, we don't really need to
 			 * look at the actual file contents at all.
@@ -2830,7 +2830,7 @@ static void show_dirstat_by_line(struct diffstat_t *data, struct diff_options *o
 	dir.alloc = 0;
 	dir.nr = 0;
 	dir.permille = options->dirstat_permille;
-	dir.cumulative = DIFF_OPT_TST(options, DIRSTAT_CUMULATIVE);
+	dir.cumulative = options->flags.DIRSTAT_CUMULATIVE;
 
 	changed = 0;
 	for (i = 0; i < data->nr; i++) {
@@ -3117,7 +3117,7 @@ static void builtin_diff(const char *name_a,
 	const char *line_prefix = diff_line_prefix(o);
 
 	diff_set_mnemonic_prefix(o, "a/", "b/");
-	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+	if (o->flags.REVERSE_DIFF) {
 		a_prefix = o->b_prefix;
 		b_prefix = o->a_prefix;
 	} else {
@@ -3141,7 +3141,7 @@ static void builtin_diff(const char *name_a,
 		return;
 	}
 
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+	if (o->flags.ALLOW_TEXTCONV) {
 		textconv_one = get_textconv(one);
 		textconv_two = get_textconv(two);
 	}
@@ -3201,13 +3201,13 @@ static void builtin_diff(const char *name_a,
 				 header.len, 0);
 		strbuf_reset(&header);
 		goto free_ab_and_return;
-	} else if (!DIFF_OPT_TST(o, TEXT) &&
+	} else if (!o->flags.TEXT &&
 	    ( (!textconv_one && diff_filespec_is_binary(one)) ||
 	      (!textconv_two && diff_filespec_is_binary(two)) )) {
 		struct strbuf sb = STRBUF_INIT;
 		if (!one->data && !two->data &&
 		    S_ISREG(one->mode) && S_ISREG(two->mode) &&
-		    !DIFF_OPT_TST(o, BINARY)) {
+		    !o->flags.BINARY) {
 			if (!oidcmp(&one->oid, &two->oid)) {
 				if (must_show_header)
 					emit_diff_symbol(o, DIFF_SYMBOL_HEADER,
@@ -3236,7 +3236,7 @@ static void builtin_diff(const char *name_a,
 		}
 		emit_diff_symbol(o, DIFF_SYMBOL_HEADER, header.buf, header.len, 0);
 		strbuf_reset(&header);
-		if (DIFF_OPT_TST(o, BINARY))
+		if (o->flags.BINARY)
 			emit_binary_diff(o, &mf1, &mf2);
 		else {
 			strbuf_addf(&sb, "%sBinary files %s and %s differ\n",
@@ -3282,7 +3282,7 @@ static void builtin_diff(const char *name_a,
 		xecfg.ctxlen = o->context;
 		xecfg.interhunkctxlen = o->interhunkcontext;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
-		if (DIFF_OPT_TST(o, FUNCCONTEXT))
+		if (o->flags.FUNCCONTEXT)
 			xecfg.flags |= XDL_EMIT_FUNCCONTEXT;
 		if (pe)
 			xdiff_set_find_func(&xecfg, pe->pattern, pe->cflags);
@@ -3941,9 +3941,9 @@ static void fill_metainfo(struct strbuf *msg,
 		*must_show_header = 0;
 	}
 	if (one && two && oidcmp(&one->oid, &two->oid)) {
-		int abbrev = DIFF_OPT_TST(o, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
+		int abbrev = o->flags.FULL_INDEX ? 40 : DEFAULT_ABBREV;
 
-		if (DIFF_OPT_TST(o, BINARY)) {
+		if (o->flags.BINARY) {
 			mmfile_t mf;
 			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
@@ -3973,7 +3973,7 @@ static void run_diff_cmd(const char *pgm,
 	int must_show_header = 0;
 
 
-	if (DIFF_OPT_TST(o, ALLOW_EXTERNAL)) {
+	if (o->flags.ALLOW_EXTERNAL) {
 		struct userdiff_driver *drv = userdiff_find_by_path(attr_path);
 		if (drv && drv->external)
 			pgm = drv->external;
@@ -4053,7 +4053,7 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	if (o->prefix_length)
 		strip_prefix(o->prefix_length, &name, &other);
 
-	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
+	if (!o->flags.ALLOW_EXTERNAL)
 		pgm = NULL;
 
 	if (DIFF_PAIR_UNMERGED(p)) {
@@ -4207,10 +4207,10 @@ void diff_setup_done(struct diff_options *options)
 	else
 		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
 
-	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
+	if (options->flags.FIND_COPIES_HARDER)
 		options->detect_rename = DIFF_DETECT_COPY;
 
-	if (!DIFF_OPT_TST(options, RELATIVE_NAME))
+	if (!options->flags.RELATIVE_NAME)
 		options->prefix = NULL;
 	if (options->prefix)
 		options->prefix_length = strlen(options->prefix);
@@ -4273,14 +4273,14 @@ void diff_setup_done(struct diff_options *options)
 	 * to have found.  It does not make sense not to return with
 	 * exit code in such a case either.
 	 */
-	if (DIFF_OPT_TST(options, QUICK)) {
+	if (options->flags.QUICK) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
 		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
 	options->diff_path_counter = 0;
 
-	if (DIFF_OPT_TST(options, FOLLOW_RENAMES) && options->pathspec.nr != 1)
+	if (options->flags.FOLLOW_RENAMES && options->pathspec.nr != 1)
 		die(_("--follow requires exactly one pathspec"));
 
 	if (!options->use_color || external_diff())
@@ -5600,7 +5600,7 @@ void diff_flush(struct diff_options *options)
 		separator++;
 	}
 
-	if (output_format & DIFF_FORMAT_DIRSTAT && DIFF_OPT_TST(options, DIRSTAT_BY_LINE))
+	if (output_format & DIFF_FORMAT_DIRSTAT && options->flags.DIRSTAT_BY_LINE)
 		dirstat_by_line = 1;
 
 	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_SHORTSTAT|DIFF_FORMAT_NUMSTAT) ||
@@ -5635,8 +5635,8 @@ void diff_flush(struct diff_options *options)
 	}
 
 	if (output_format & DIFF_FORMAT_NO_OUTPUT &&
-	    DIFF_OPT_TST(options, EXIT_WITH_STATUS) &&
-	    DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+	    options->flags.EXIT_WITH_STATUS &&
+	    options->flags.DIFF_FROM_CONTENTS) {
 		/*
 		 * run diff_flush_patch for the exit status. setting
 		 * options->file to /dev/null should be safe, because we
@@ -5684,7 +5684,7 @@ void diff_flush(struct diff_options *options)
 	 * diff_addremove/diff_change does not set the bit when
 	 * DIFF_FROM_CONTENTS is in effect (e.g. with -w).
 	 */
-	if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS)) {
+	if (options->flags.DIFF_FROM_CONTENTS) {
 		if (options->found_changes)
 			DIFF_OPT_SET(options, HAS_CHANGES);
 		else
@@ -5808,7 +5808,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 			 * to determine how many paths were dirty only
 			 * due to stat info mismatch.
 			 */
-			if (!DIFF_OPT_TST(diffopt, NO_INDEX))
+			if (!diffopt->flags.NO_INDEX)
 				diffopt->skip_stat_unmatch++;
 			diff_free_filepair(p);
 		}
@@ -5857,7 +5857,7 @@ void diffcore_std(struct diff_options *options)
 		diff_resolve_rename_copy();
 	diffcore_apply_filter(options);
 
-	if (diff_queued_diff.nr && !DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+	if (diff_queued_diff.nr && !options->flags.DIFF_FROM_CONTENTS)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 	else
 		DIFF_OPT_CLR(options, HAS_CHANGES);
@@ -5872,23 +5872,23 @@ int diff_result_code(struct diff_options *opt, int status)
 	diff_warn_rename_limit("diff.renameLimit",
 			       opt->needed_rename_limit,
 			       opt->degraded_cc_to_c);
-	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
+	if (!opt->flags.EXIT_WITH_STATUS &&
 	    !(opt->output_format & DIFF_FORMAT_CHECKDIFF))
 		return status;
-	if (DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
-	    DIFF_OPT_TST(opt, HAS_CHANGES))
+	if (opt->flags.EXIT_WITH_STATUS &&
+	    opt->flags.HAS_CHANGES)
 		result |= 01;
 	if ((opt->output_format & DIFF_FORMAT_CHECKDIFF) &&
-	    DIFF_OPT_TST(opt, CHECK_FAILED))
+	    opt->flags.CHECK_FAILED)
 		result |= 02;
 	return result;
 }
 
 int diff_can_quit_early(struct diff_options *opt)
 {
-	return (DIFF_OPT_TST(opt, QUICK) &&
+	return (opt->flags.QUICK &&
 		!opt->filter &&
-		DIFF_OPT_TST(opt, HAS_CHANGES));
+		opt->flags.HAS_CHANGES);
 }
 
 /*
@@ -5901,9 +5901,9 @@ static int is_submodule_ignored(const char *path, struct diff_options *options)
 {
 	int ignored = 0;
 	struct diff_flags orig_flags = options->flags;
-	if (!DIFF_OPT_TST(options, OVERRIDE_SUBMODULE_CONFIG))
+	if (!options->flags.OVERRIDE_SUBMODULE_CONFIG)
 		set_diffopt_flags_from_submodule_config(options, path);
-	if (DIFF_OPT_TST(options, IGNORE_SUBMODULES))
+	if (options->flags.IGNORE_SUBMODULES)
 		ignored = 1;
 	options->flags = orig_flags;
 	return ignored;
@@ -5932,7 +5932,7 @@ void diff_addremove(struct diff_options *options,
 	 * Before the final output happens, they are pruned after
 	 * merged into rename/copy pairs as appropriate.
 	 */
-	if (DIFF_OPT_TST(options, REVERSE_DIFF))
+	if (options->flags.REVERSE_DIFF)
 		addremove = (addremove == '+' ? '-' :
 			     addremove == '-' ? '+' : addremove);
 
@@ -5951,7 +5951,7 @@ void diff_addremove(struct diff_options *options,
 	}
 
 	diff_queue(&diff_queued_diff, one, two);
-	if (!DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+	if (!options->flags.DIFF_FROM_CONTENTS)
 		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
@@ -5970,7 +5970,7 @@ void diff_change(struct diff_options *options,
 	    is_submodule_ignored(concatpath, options))
 		return;
 
-	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
+	if (options->flags.REVERSE_DIFF) {
 		SWAP(old_mode, new_mode);
 		SWAP(old_oid, new_oid);
 		SWAP(old_oid_valid, new_oid_valid);
@@ -5989,10 +5989,10 @@ void diff_change(struct diff_options *options,
 	two->dirty_submodule = new_dirty_submodule;
 	p = diff_queue(&diff_queued_diff, one, two);
 
-	if (DIFF_OPT_TST(options, DIFF_FROM_CONTENTS))
+	if (options->flags.DIFF_FROM_CONTENTS)
 		return;
 
-	if (DIFF_OPT_TST(options, QUICK) && options->skip_stat_unmatch &&
+	if (options->flags.QUICK && options->skip_stat_unmatch &&
 	    !diff_filespec_check_stat_unmatch(p))
 		return;
 
@@ -6134,7 +6134,7 @@ void setup_diff_pager(struct diff_options *opt)
 	 * and because it is easy to find people oneline advising "git diff
 	 * --exit-code" in hooks and other scripts, we do not do so.
 	 */
-	if (!DIFF_OPT_TST(opt, EXIT_WITH_STATUS) &&
+	if (!opt->flags.EXIT_WITH_STATUS &&
 	    check_pager_config("diff") != 0)
 		setup_pager();
 }
diff --git a/diff.h b/diff.h
index 26a1cab87..c3798a104 100644
--- a/diff.h
+++ b/diff.h
@@ -106,7 +106,6 @@ static inline void diff_flags_or(struct diff_flags *a,
 		tmp_a[i] |= tmp_b[i];
 }
 
-#define DIFF_OPT_TST(opts, flag)	((opts)->flags.flag)
 #define DIFF_OPT_SET(opts, flag)	((opts)->flags.flag = 1)
 #define DIFF_OPT_CLR(opts, flag)	((opts)->flags.flag = 0)
 
diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 341529b5a..6193c07f6 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -131,7 +131,7 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
 	if (!DIFF_FILE_VALID(p->one) && !DIFF_FILE_VALID(p->two))
 		return 0;
 
-	if (DIFF_OPT_TST(o, ALLOW_TEXTCONV)) {
+	if (o->flags.ALLOW_TEXTCONV) {
 		textconv_one = get_textconv(p->one);
 		textconv_two = get_textconv(p->two);
 	}
@@ -222,11 +222,11 @@ void diffcore_pickaxe(struct diff_options *o)
 
 	if (opts & (DIFF_PICKAXE_REGEX | DIFF_PICKAXE_KIND_G)) {
 		int cflags = REG_EXTENDED | REG_NEWLINE;
-		if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE))
+		if (o->flags.PICKAXE_IGNORE_CASE)
 			cflags |= REG_ICASE;
 		regcomp_or_die(&regex, needle, cflags);
 		regexp = &regex;
-	} else if (DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE) &&
+	} else if (o->flags.PICKAXE_IGNORE_CASE &&
 		   has_non_ascii(needle)) {
 		struct strbuf sb = STRBUF_INIT;
 		int cflags = REG_NEWLINE | REG_ICASE;
@@ -236,7 +236,7 @@ void diffcore_pickaxe(struct diff_options *o)
 		strbuf_release(&sb);
 		regexp = &regex;
 	} else {
-		kws = kwsalloc(DIFF_OPT_TST(o, PICKAXE_IGNORE_CASE)
+		kws = kwsalloc(o->flags.PICKAXE_IGNORE_CASE
 			       ? tolower_trans_tbl : NULL);
 		kwsincr(kws, needle, strlen(needle));
 		kwsprep(kws);
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 0d8c3d2ee..bd077ee11 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -405,7 +405,7 @@ static int too_many_rename_candidates(int num_create,
 		num_src > num_create ? num_src : num_create;
 
 	/* Are we running under -C -C? */
-	if (!DIFF_OPT_TST(options, FIND_COPIES_HARDER))
+	if (!options->flags.FIND_COPIES_HARDER)
 		return 1;
 
 	/* Would we bust the limit if we were running under -C? */
@@ -463,7 +463,7 @@ void diffcore_rename(struct diff_options *options)
 			else if (options->single_follow &&
 				 strcmp(options->single_follow, p->two->path))
 				continue; /* not interested */
-			else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
+			else if (!options->flags.RENAME_EMPTY &&
 				 is_empty_blob_oid(&p->two->oid))
 				continue;
 			else if (add_rename_dst(p->two) < 0) {
@@ -473,7 +473,7 @@ void diffcore_rename(struct diff_options *options)
 				goto cleanup;
 			}
 		}
-		else if (!DIFF_OPT_TST(options, RENAME_EMPTY) &&
+		else if (!options->flags.RENAME_EMPTY &&
 			 is_empty_blob_oid(&p->one->oid))
 			continue;
 		else if (!DIFF_PAIR_UNMERGED(p) && !DIFF_FILE_VALID(p->two)) {
diff --git a/log-tree.c b/log-tree.c
index cea056234..460bb5498 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -793,7 +793,7 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	struct commit_list *parents;
 	struct object_id *oid;
 
-	if (!opt->diff && !DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS))
+	if (!opt->diff && !opt->diffopt.flags.EXIT_WITH_STATUS)
 		return 0;
 
 	parse_commit_or_die(commit);
diff --git a/revision.c b/revision.c
index d167223e6..c893d9166 100644
--- a/revision.c
+++ b/revision.c
@@ -2399,7 +2399,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
-	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
+	    revs->diffopt.flags.FOLLOW_RENAMES)
 		revs->diff = 1;
 
 	if (revs->topo_order)
@@ -2408,7 +2408,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->prune_data.nr) {
 		copy_pathspec(&revs->pruning.pathspec, &revs->prune_data);
 		/* Can't prune commits with rename following: the paths change.. */
-		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
+		if (!revs->diffopt.flags.FOLLOW_RENAMES)
 			revs->prune = 1;
 		if (!revs->full_diff)
 			copy_pathspec(&revs->diffopt.pathspec,
diff --git a/submodule.c b/submodule.c
index 63e7094e1..58da9c668 100644
--- a/submodule.c
+++ b/submodule.c
@@ -616,7 +616,7 @@ void show_submodule_inline_diff(struct diff_options *o, const char *path,
 	argv_array_pushf(&cp.args, "--color=%s", want_color(o->use_color) ?
 			 "always" : "never");
 
-	if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
+	if (o->flags.REVERSE_DIFF) {
 		argv_array_pushf(&cp.args, "--src-prefix=%s%s/",
 				 o->b_prefix, path);
 		argv_array_pushf(&cp.args, "--dst-prefix=%s%s/",
diff --git a/tree-diff.c b/tree-diff.c
index 4bb93155b..ed0aa6a62 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -212,9 +212,9 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		mode = 0;
 	}
 
-	if (DIFF_OPT_TST(opt, RECURSIVE) && isdir) {
+	if (opt->flags.RECURSIVE && isdir) {
 		recurse = 1;
-		emitthis = DIFF_OPT_TST(opt, TREE_IN_RECURSIVE);
+		emitthis = opt->flags.TREE_IN_RECURSIVE;
 	}
 
 	if (emitthis) {
@@ -425,7 +425,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	ttree = fill_tree_descriptor(&t, oid);
 
 	/* Enable recursion indefinitely */
-	opt->pathspec.recursive = DIFF_OPT_TST(opt, RECURSIVE);
+	opt->pathspec.recursive = opt->flags.RECURSIVE;
 
 	for (;;) {
 		int imin, cmp;
@@ -484,7 +484,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		/* t = p[imin] */
 		if (cmp == 0) {
 			/* are either pi > p[imin] or diff(t,pi) != ø ? */
-			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+			if (!opt->flags.FIND_COPIES_HARDER) {
 				for (i = 0; i < nparent; ++i) {
 					/* p[i] > p[imin] */
 					if (tp[i].entry.mode & S_IFXMIN_NEQ)
@@ -522,7 +522,7 @@ static struct combine_diff_path *ll_diff_tree_paths(
 		/* t > p[imin] */
 		else {
 			/* ∀i pi=p[imin] -> D += "-p[imin]" */
-			if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER)) {
+			if (!opt->flags.FIND_COPIES_HARDER) {
 				for (i = 0; i < nparent; ++i)
 					if (tp[i].entry.mode & S_IFXMIN_NEQ)
 						goto skip_emit_tp;
@@ -706,7 +706,7 @@ int diff_tree_oid(const struct object_id *old_oid,
 	strbuf_addstr(&base, base_str);
 
 	retval = ll_diff_tree_oid(old_oid, new_oid, &base, opt);
-	if (!*base_str && DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename())
+	if (!*base_str && opt->flags.FOLLOW_RENAMES && diff_might_be_rename())
 		try_to_follow_renames(old_oid, new_oid, &base, opt);
 
 	strbuf_release(&base);
-- 
2.15.0.403.gc27cc4dac6-goog

