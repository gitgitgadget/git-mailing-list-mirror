Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCF77202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 22:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932627AbdJ3WUR (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 18:20:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:56935 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932602AbdJ3WUP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 18:20:15 -0400
Received: by mail-pf0-f194.google.com with SMTP id b85so12118174pfj.13
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 15:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ng4WYJZx/vYR6fwWuxCo9YMoTPBA4K2QGBAKGGiZPA8=;
        b=kWZe9OPCH8JEsAaYA0D7/b11n8MFkPDqts6UhKGQbbsnZrKFSIxEOQxhJgACBe1AsV
         n8+9grpMd1oesHmkJPTGuBQlF+3dDvz3PDQ69gZpOctdhjdbxVDBzE4Pj0L7czLZ59lB
         Qe8NTZBSkalD5zUjNJSbCt1wvEBThy98vXEdjlWLZSAYUsJ/LNB3nAALLcdNk8lVz2rE
         UPh1YMfzet33bo4n/yng2iGohbclseR8/aErpFX8uUTd63DqpXAcsnW5dhrK2B6UIn8w
         4dEFgPs+6FkA4efkonEwhhqRkd4aDfnOZaPJLK5CRVs1ftmZ73RqaXksdbFvyBHX5Ywh
         aszg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ng4WYJZx/vYR6fwWuxCo9YMoTPBA4K2QGBAKGGiZPA8=;
        b=tqdc/1vCkehgohIU6li2S8wcmeAyT+I9rk4zD76MJk2sjLCOS3KXY4ZCz+HK2+s8bl
         EfsaqwbHzLtCI6EAYnhW3LQDDQZinXQYNlwTIxy2QpB4pE0nJJSl2QMImfe4YgBYWZa+
         GehOR2syW1vOA84wt48I9I8ZYzR4uF0rvNHtn6ki+pEJzRPIdmEirk+hAyW/uzbY0IMJ
         bK7nZ8BIuXRBJ7e1ntuQqVIpqs2XD6iupkpNaRcotZuSDi/OJL4tPcVRK0oS+raszB6R
         9yia/Hq0SMGs7w3tzAgwuSK0l3l+9oorMLUSD2r4BFWoKKyMRMu539hfJLmnvYpCpNRX
         ecQA==
X-Gm-Message-State: AMCzsaWeHA1S8/Z7B5cIFaauD1jo5BcBvDzAKyuMCCT/JCFMYQUTL1+b
        TVcAb7UR0j/CU5QMu75ErfWyUdEOubQ=
X-Google-Smtp-Source: ABhQp+Q8pgitntR8ovxWKcD+dCw76hOoPiTpz+2BJSQ9hWht8ChHVCdbqCEztYuDvb3yHOOkxTv0uw==
X-Received: by 10.99.119.3 with SMTP id s3mr9029211pgc.172.1509402014204;
        Mon, 30 Oct 2017 15:20:14 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id g1sm32423031pfg.111.2017.10.30.15.20.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Oct 2017 15:20:13 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 7/4] diff: remove DIFF_OPT_CLR macro
Date:   Mon, 30 Oct 2017 15:19:55 -0700
Message-Id: <20171030221956.92466-3-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6-goog
In-Reply-To: <20171030221956.92466-1-bmwill@google.com>
References: <20171030194646.27473-1-bmwill@google.com>
 <20171030221956.92466-1-bmwill@google.com>
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
 diff.c            | 30 +++++++++++++++---------------
 diff.h            |  2 --
 merge-recursive.c |  2 +-
 revision.c        |  4 ++--
 submodule.c       |  6 +++---
 7 files changed, 23 insertions(+), 25 deletions(-)

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
index 16d33c319..0e5abb5ce 100644
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
@@ -4761,13 +4761,13 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--ext-diff"))
 		options->flags.ALLOW_EXTERNAL = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
-		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
+		options->flags.ALLOW_EXTERNAL = 0;
 	else if (!strcmp(arg, "--textconv")) {
 		options->flags.ALLOW_TEXTCONV = 1;
 		options->flags.TEXTCONV_SET_VIA_CMDLINE = 1;
 	} else if (!strcmp(arg, "--no-textconv")) {
-		DIFF_OPT_CLR(options, ALLOW_TEXTCONV);
-		DIFF_OPT_CLR(options, TEXTCONV_SET_VIA_CMDLINE);
+		options->flags.ALLOW_TEXTCONV = 0;
+		options->flags.TEXTCONV_SET_VIA_CMDLINE = 0;
 	} else if (!strcmp(arg, "--ignore-submodules")) {
 		options->flags.OVERRIDE_SUBMODULE_CONFIG = 1;
 		handle_ignore_submodules_arg(options, "all");
@@ -4851,7 +4851,7 @@ int diff_opt_parse(struct diff_options *options,
 	else if (!strcmp(arg, "--function-context"))
 		options->flags.FUNCCONTEXT = 1;
 	else if (!strcmp(arg, "--no-function-context"))
-		DIFF_OPT_CLR(options, FUNCCONTEXT);
+		options->flags.FUNCCONTEXT = 0;
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
 		options->file = xfopen(path, "w");
@@ -5689,7 +5689,7 @@ void diff_flush(struct diff_options *options)
 		if (options->found_changes)
 			options->flags.HAS_CHANGES = 1;
 		else
-			DIFF_OPT_CLR(options, HAS_CHANGES);
+			options->flags.HAS_CHANGES = 0;
 	}
 }
 
@@ -5861,7 +5861,7 @@ void diffcore_std(struct diff_options *options)
 	if (diff_queued_diff.nr && !options->flags.DIFF_FROM_CONTENTS)
 		options->flags.HAS_CHANGES = 1;
 	else
-		DIFF_OPT_CLR(options, HAS_CHANGES);
+		options->flags.HAS_CHANGES = 0;
 
 	options->found_follow = 0;
 }
diff --git a/diff.h b/diff.h
index 4c1af4be6..f68fcf737 100644
--- a/diff.h
+++ b/diff.h
@@ -110,8 +110,6 @@ static inline struct diff_flags diff_flags_or(const struct diff_flags *a,
 	return out;
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

