Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBFEB20437
	for <e@80x24.org>; Tue, 31 Oct 2017 18:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753562AbdJaSTd (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 14:19:33 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:56368 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932552AbdJaST2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 14:19:28 -0400
Received: by mail-pg0-f67.google.com with SMTP id m18so15356491pgd.13
        for <git@vger.kernel.org>; Tue, 31 Oct 2017 11:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vl9JCJPVfX4byZBb+B7gM36u8DXL+zl2buzWOjrb5bQ=;
        b=eumhDC+JBccRTtcspDwsDPGfjG0cce9/MByrKq0XxfXo75xc3uwCHoyo0dUY5MEFcB
         YQRCRICpQ3i7Tr/kg6hueKbaZ0+fN/yMjJJCe5OS6IgBT3x9jyJVGMuwEj2qy9DVlgKY
         ul25UPKFiVn14sTQCBaIk0yRd5tD+rwyvLWGACkuIyN0FgqmXNC99H3Rsvg6KM//hfW/
         5aXMVqxO5SnlSotYei6XQf6Lk4/hJKsUcylifGPL3bDAmB9HQnKO9pnINRnBmU9U4PQF
         a5SACBRxOFc3j5OeaZNgTH5wNWTdj5Gvtq2NfH62G5rOj0BBwesdLN+T9ThNCXSRBIxK
         kUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vl9JCJPVfX4byZBb+B7gM36u8DXL+zl2buzWOjrb5bQ=;
        b=g7aH8GKs0mvjYjG/4aDrLsPDXGPkUQDzhdEYNjgXTS5iOee9c2WskHKFIFhSoDSONO
         2zxqzfhHMJmpV+Z9qfxk2kQnOHzIttenXwh/pwjQ+n3fCB1uQxe1L87fYf0vkxJsE2Lp
         6v4yVE//nGbN+HojVuzWQ3VKP8n7QlPvIFMT2fVFtVg29teKEVkI12lITkAtBuvQdAfK
         WBrV+X8s8fOheZbl36wqXf/PxMearJ/7wrANkGnI/YNRO8LZRQatrmyQRiWTh3oc1uRQ
         daiDiWXepH6U4UodLjadeAxGdCj5uTWN2Gkdp7KXplex4mxFTG6kHhwbT8WUhJ12o2Gf
         SVcg==
X-Gm-Message-State: AMCzsaUL2aA57mkT1QDwhd//LfMTJmNN2dDdlti4TJ0nlb01ZWxLc4Zq
        kNBe8uWjstJMB9pxM57rbBxBIrccO/A=
X-Google-Smtp-Source: ABhQp+SAOmf5gvBEHuh2faC7FQZXnYbdCcpUVBc4F6BKvkMZW8veo1oL0yiXiIGK+D3zsX/KyN5BUQ==
X-Received: by 10.98.141.202 with SMTP id p71mr2965688pfk.18.1509473967749;
        Tue, 31 Oct 2017 11:19:27 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id a78sm4308985pfl.122.2017.10.31.11.19.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 31 Oct 2017 11:19:26 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 7/8] diff: remove DIFF_OPT_CLR macro
Date:   Tue, 31 Oct 2017 11:19:10 -0700
Message-Id: <20171031181911.42687-8-bmwill@google.com>
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
	- DIFF_OPT_CLR(&E, fld)
	+ E.flags.fld = 0

	@@
	type T;
	T *ptr;
	identifier fld;
	@@
	- DIFF_OPT_CLR(ptr, fld)
	+ ptr->flags.fld = 0

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/blame.c   |  2 +-
 combine-diff.c    |  2 +-
 diff.c            | 28 ++++++++++++++--------------
 diff.h            |  2 --
 merge-recursive.c |  2 +-
 revision.c        |  4 ++--
 submodule.c       |  6 +++---
 7 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 76994aa64..79db9e849 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -736,7 +736,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 parse_done:
 	no_whole_file_rename = !revs.diffopt.flags.FOLLOW_RENAMES;
 	xdl_opts |= revs.diffopt.xdl_opts & XDF_INDENT_HEURISTIC;
-	DIFF_OPT_CLR(&revs.diffopt, FOLLOW_RENAMES);
+	revs.diffopt.flags.FOLLOW_RENAMES = 0;
 	argc = parse_options_end(&ctx);
 
 	if (incremental || (output_option & OUTPUT_PORCELAIN)) {
diff --git a/combine-diff.c b/combine-diff.c
index 204b0dfce..5a3a8b49b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1414,7 +1414,7 @@ void diff_tree_combined(const struct object_id *oid,
 	diffopts = *opt;
 	copy_pathspec(&diffopts.pathspec, &opt->pathspec);
 	diffopts.flags.RECURSIVE = 1;
-	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
+	diffopts.flags.ALLOW_EXTERNAL = 0;
 
 	/* find set of paths that everybody touches
 	 *
diff --git a/diff.c b/diff.c
index 6dea186d8..e5f9d3078 100644
--- a/diff.c
+++ b/diff.c
@@ -124,16 +124,16 @@ static int parse_dirstat_params(struct diff_options *options, const char *params
 	for (i = 0; i < params.nr; i++) {
 		const char *p = params.items[i].string;
 		if (!strcmp(p, "changes")) {
-			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
-			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+			options->flags.DIRSTAT_BY_LINE = 0;
+			options->flags.DIRSTAT_BY_FILE = 0;
 		} else if (!strcmp(p, "lines")) {
 			options->flags.DIRSTAT_BY_LINE = 1;
-			DIFF_OPT_CLR(options, DIRSTAT_BY_FILE);
+			options->flags.DIRSTAT_BY_FILE = 0;
 		} else if (!strcmp(p, "files")) {
-			DIFF_OPT_CLR(options, DIRSTAT_BY_LINE);
+			options->flags.DIRSTAT_BY_LINE = 0;
 			options->flags.DIRSTAT_BY_FILE = 1;
 		} else if (!strcmp(p, "noncumulative")) {
-			DIFF_OPT_CLR(options, DIRSTAT_CUMULATIVE);
+			options->flags.DIRSTAT_CUMULATIVE = 0;
 		} else if (!strcmp(p, "cumulative")) {
 			options->flags.DIRSTAT_CUMULATIVE = 1;
 		} else if (isdigit(*p)) {
@@ -4205,7 +4205,7 @@ void diff_setup_done(struct diff_options *options)
 	    DIFF_XDL_TST(options, IGNORE_WHITESPACE_AT_EOL))
 		options->flags.DIFF_FROM_CONTENTS = 1;
 	else
-		DIFF_OPT_CLR(options, DIFF_FROM_CONTENTS);
+		options->flags.DIFF_FROM_CONTENTS = 0;
 
 	if (options->flags.FIND_COPIES_HARDER)
 		options->detect_rename = DIFF_DETECT_COPY;
@@ -4640,7 +4640,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--rename-empty"))
 		options->flags.RENAME_EMPTY = 1;
 	else if (!strcmp(arg, "--no-rename-empty"))
-		DIFF_OPT_CLR(options, RENAME_EMPTY);
+		options->flags.RENAME_EMPTY = 0;
 	else if (!strcmp(arg, "--relative"))
 		options->flags.RELATIVE_NAME = 1;
 	else if (skip_prefix(arg, "--relative=", &arg)) {
@@ -4697,8 +4697,8 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--follow"))
 		options->flags.FOLLOW_RENAMES = 1;
 	else if (!strcmp(arg, "--no-follow")) {
-		DIFF_OPT_CLR(options, FOLLOW_RENAMES);
-		DIFF_OPT_CLR(options, DEFAULT_FOLLOW_RENAMES);
+		options->flags.FOLLOW_RENAMES = 0;
+		options->flags.DEFAULT_FOLLOW_RENAMES = 0;
 	} else if (!strcmp(arg, "--color"))
 		options->use_color = 1;
 	else if (skip_prefix(arg, "--color=", &arg)) {
@@ -4761,12 +4761,12 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--ext-diff"))
 		options->flags.ALLOW_EXTERNAL = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
-		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
+		options->flags.ALLOW_EXTERNAL = 0;
 	else if (!strcmp(arg, "--textconv")) {
 		options->flags.ALLOW_TEXTCONV = 1;
 		options->flags.TEXTCONV_SET_VIA_CMDLINE = 1;
 	} else if (!strcmp(arg, "--no-textconv"))
-		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
+		options->flags.ALLOW_TEXTCONV = 0;
 	else if (!strcmp(arg, "--ignore-submodules")) {
 		options->flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 		handle_ignore_submodules_arg(options, "all");
@@ -4850,7 +4850,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--function-context"))
 		options->flags.FUNCCONTEXT = 1;
 	else if (!strcmp(arg, "--no-function-context"))
-		DIFF_OPT_CLR(options, FUNCCONTEXT);
+		options->flags.FUNCCONTEXT = 0;
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
 		options->file = xfopen(path, "w");
@@ -5688,7 +5688,7 @@ void diff_flush(struct diff_options *options)
 		if (options->found_changes)
 			options->flags.HAS_CHANGES = 1;
 		else
-			DIFF_OPT_CLR(options, HAS_CHANGES);
+			options->flags.HAS_CHANGES = 0;
 	}
 }
 
@@ -5860,7 +5860,7 @@ void diffcore_std(struct diff_options *options)
 	if (diff_queued_diff.nr && !options->flags.DIFF_FROM_CONTENTS)
 		options->flags.HAS_CHANGES = 1;
 	else
-		DIFF_OPT_CLR(options, HAS_CHANGES);
+		options->flags.HAS_CHANGES = 0;
 
 	options->found_follow = 0;
 }
diff --git a/diff.h b/diff.h
index d53e5a2da..258d735c1 100644
--- a/diff.h
+++ b/diff.h
@@ -106,8 +106,6 @@ static inline void diff_flags_or(struct diff_flags *a,
 		tmp_a[i] |= tmp_b[i];
 }
 
-#define DIFF_OPT_CLR(opts, flag)	((opts)->flags.flag = 0)
-
 #define DIFF_XDL_TST(opts, flag)    ((opts)->xdl_opts & XDF_##flag)
 #define DIFF_XDL_SET(opts, flag)    ((opts)->xdl_opts |= XDF_##flag)
 #define DIFF_XDL_CLR(opts, flag)    ((opts)->xdl_opts &= ~XDF_##flag)
diff --git a/merge-recursive.c b/merge-recursive.c
index e7b3df45c..9752aba4e 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -541,7 +541,7 @@ static struct string_list *get_renames(struct merge_options *o,
 
 	diff_setup(&opts);
 	opts.flags.RECURSIVE = 1;
-	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
+	opts.flags.RENAME_EMPTY = 0;
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = o->merge_rename_limit >= 0 ? o->merge_rename_limit :
 			    o->diff_rename_limit >= 0 ? o->diff_rename_limit :
diff --git a/revision.c b/revision.c
index f019dd277..6bb873501 100644
--- a/revision.c
+++ b/revision.c
@@ -455,7 +455,7 @@ static int rev_compare_tree(struct rev_info *revs,
 	}
 
 	tree_difference = REV_TREE_SAME;
-	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
+	revs->pruning.flags.HAS_CHANGES = 0;
 	if (diff_tree_oid(&t1->object.oid, &t2->object.oid, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
@@ -471,7 +471,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 		return 0;
 
 	tree_difference = REV_TREE_SAME;
-	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
+	revs->pruning.flags.HAS_CHANGES = 0;
 	retval = diff_tree_oid(NULL, &t1->object.oid, "", &revs->pruning);
 
 	return retval >= 0 && (tree_difference == REV_TREE_SAME);
diff --git a/submodule.c b/submodule.c
index 7e7998592..62a93bb88 100644
--- a/submodule.c
+++ b/submodule.c
@@ -402,9 +402,9 @@ const char *submodule_strategy_to_string(const struct submodule_update_strategy
 void handle_ignore_submodules_arg(struct diff_options *diffopt,
 				  const char *arg)
 {
-	DIFF_OPT_CLR(diffopt, IGNORE_SUBMODULES);
-	DIFF_OPT_CLR(diffopt, IGNORE_UNTRACKED_IN_SUBMODULES);
-	DIFF_OPT_CLR(diffopt, IGNORE_DIRTY_SUBMODULES);
+	diffopt->flags.IGNORE_SUBMODULES = 0;
+	diffopt->flags.IGNORE_UNTRACKED_IN_SUBMODULES = 0;
+	diffopt->flags.IGNORE_DIRTY_SUBMODULES = 0;
 
 	if (!strcmp(arg, "all"))
 		diffopt->flags.IGNORE_SUBMODULES = 1;
-- 
2.15.0.403.gc27cc4dac6-goog

