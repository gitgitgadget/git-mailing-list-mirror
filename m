Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC8BF1F97E
	for <e@80x24.org>; Tue, 27 Nov 2018 16:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbeK1DwC (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 22:52:02 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33779 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731294AbeK1DwC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 22:52:02 -0500
Received: by mail-lj1-f194.google.com with SMTP id v1-v6so20734940ljd.0
        for <git@vger.kernel.org>; Tue, 27 Nov 2018 08:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E5TO7/llHmklN9FyEnSwwtvTdG83hVgNWxa8P3ft6iw=;
        b=a9Z95MAza51+W1UkXylTGB6k0IX6Wvavljb/N0mkfpDG1FVYhIS7WS8Viy+hjx/Dx5
         Ula955cAvcMiRpm/MU38Oltpew0XdJS0FsWDAsWvRgSjcl62paZOYOgI2JJy6C2oKkkv
         ztY7piTqFP+9KuY26+4XpzzkTnhkn9QU3N1ummGm69lGc5Q6q6DsZPI7SK0jYP6z7ulK
         gyA2qIcP/mrBW5t+D6JKOJPnzw8pv1RNVtvRcyTknlxD6X4Sle1mlXr7EzAR4fzbmQ18
         gESB1LrJiTHdMf5DDCeXAxtMC8ATOaDnHPLV8AVxZDRLOdH750k9JAm8Yh6Nmwc67mBd
         Mj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5TO7/llHmklN9FyEnSwwtvTdG83hVgNWxa8P3ft6iw=;
        b=JhlLIXjEn961yTlwUkTjtO3+zYl3VoOVhl5efDQCtTDnOoggr5nrFCYqf5eiNxCP+Z
         WT4nMOZVavfjXrmWMyvoypsXvB3NURn7Yk1NkK0EqYZ/EpK6aQMMye7c353QVOWl7VvK
         +nrVtwtqME6ZWzsLwhx3bIc1lqM5CL37QXK6YgytS1C4DhBXSJ0MbaNP3N0if14+sUfh
         caiXTJU/V7D/cSK9H6MAK33w6cU8h6KtGhSg6EzFWOio52dzwoEcAkWQGxocYh3iM4l6
         Kwv1hPn9MDxqrF0cId6ufNUizag02UxHZn9FhCavcK1Ge44ZISHjRm3WZILtAhe0VNxu
         7a6w==
X-Gm-Message-State: AA+aEWapAja5VUxuuo/DBiQcJuqnTO/kuSKcQS+I6fVFVh9s8jMio09s
        b8mxrAItjNswYPO7MprgyS2vNSM+
X-Google-Smtp-Source: AFSGD/XKyZ3URTooGVYGwzYNSxroNSxC1cWY8dEeXDcBH+Fn4Rv8od8G3YQX+XQY3B2Xg9hU2jN+EQ==
X-Received: by 2002:a2e:9783:: with SMTP id y3-v6mr19964070lji.167.1543337609785;
        Tue, 27 Nov 2018 08:53:29 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g66sm694016lfe.42.2018.11.27.08.53.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 08:53:29 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>, t.gummerer@gmail.com
Subject: [PATCH v2 2/7] checkout: make "opts" in cmd_checkout() a pointer
Date:   Tue, 27 Nov 2018 17:52:06 +0100
Message-Id: <20181127165211.24763-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1327.g328c130451.dirty
In-Reply-To: <20181127165211.24763-1-pclouds@gmail.com>
References: <20181120174554.GA29910@duynguyen.home>
 <20181127165211.24763-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"opts" will soon be moved out of cmd_checkout(). To keep changes in
that patch smaller, convert "opts" to a pointer and keep the real
thing behind "real_opts".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 109 +++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 54 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..31245c1eb4 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1225,76 +1225,77 @@ static int checkout_branch(struct checkout_opts *opts,
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
 {
-	struct checkout_opts opts;
+	struct checkout_opts real_opts;
+	struct checkout_opts *opts = &real_opts;
 	struct branch_info new_branch_info;
 	char *conflict_style = NULL;
 	int dwim_new_local_branch = 1;
 	int dwim_remotes_matched = 0;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
+		OPT_STRING('b', NULL, &opts->new_branch, N_("branch"),
 			   N_("create and checkout a new branch")),
-		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
+		OPT_STRING('B', NULL, &opts->new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
-		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
-		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach HEAD at named commit")),
-		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
+		OPT_BOOL('l', NULL, &opts->new_branch_log, N_("create reflog for new branch")),
+		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-		OPT_SET_INT_F('2', "ours", &opts.writeout_stage,
+		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
+		OPT_SET_INT_F('2', "ours", &opts->writeout_stage,
 			      N_("checkout our version for unmerged files"),
 			      2, PARSE_OPT_NONEG),
-		OPT_SET_INT_F('3', "theirs", &opts.writeout_stage,
+		OPT_SET_INT_F('3', "theirs", &opts->writeout_stage,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
-		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL_F(0, "overwrite-ignore", &opts.overwrite_ignore,
+		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
+		OPT_BOOL_F(0, "overwrite-ignore", &opts->overwrite_ignore,
 			   N_("update ignored files (default)"),
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
-		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
-		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
+		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
 				N_("second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
+		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
 			 N_("do not check if another worktree is holding the given ref")),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
 			    "checkout", "control recursive updating of submodules",
 			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
 		OPT_END(),
 	};
 
-	memset(&opts, 0, sizeof(opts));
+	memset(opts, 0, sizeof(*opts));
 	memset(&new_branch_info, 0, sizeof(new_branch_info));
-	opts.overwrite_ignore = 1;
-	opts.prefix = prefix;
-	opts.show_progress = -1;
+	opts->overwrite_ignore = 1;
+	opts->prefix = prefix;
+	opts->show_progress = -1;
 
-	git_config(git_checkout_config, &opts);
+	git_config(git_checkout_config, opts);
 
-	opts.track = BRANCH_TRACK_UNSPECIFIED;
+	opts->track = BRANCH_TRACK_UNSPECIFIED;
 
 	argc = parse_options(argc, argv, prefix, options, checkout_usage,
 			     PARSE_OPT_KEEP_DASHDASH);
 
-	if (opts.show_progress < 0) {
-		if (opts.quiet)
-			opts.show_progress = 0;
+	if (opts->show_progress < 0) {
+		if (opts->quiet)
+			opts->show_progress = 0;
 		else
-			opts.show_progress = isatty(2);
+			opts->show_progress = isatty(2);
 	}
 
 	if (conflict_style) {
-		opts.merge = 1; /* implied */
+		opts->merge = 1; /* implied */
 		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
 	}
 
-	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
+	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
 	/*
@@ -1302,14 +1303,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	 * and new_branch_force and new_orphan_branch will tell us which one of
 	 * -b/-B/--orphan is being used.
 	 */
-	if (opts.new_branch_force)
-		opts.new_branch = opts.new_branch_force;
+	if (opts->new_branch_force)
+		opts->new_branch = opts->new_branch_force;
 
-	if (opts.new_orphan_branch)
-		opts.new_branch = opts.new_orphan_branch;
+	if (opts->new_orphan_branch)
+		opts->new_branch = opts->new_orphan_branch;
 
 	/* --track without -b/-B/--orphan should DWIM */
-	if (opts.track != BRANCH_TRACK_UNSPECIFIED && !opts.new_branch) {
+	if (opts->track != BRANCH_TRACK_UNSPECIFIED && !opts->new_branch) {
 		const char *argv0 = argv[0];
 		if (!argc || !strcmp(argv0, "--"))
 			die(_("--track needs a branch name"));
@@ -1318,7 +1319,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die(_("missing branch name; try -b"));
-		opts.new_branch = argv0 + 1;
+		opts->new_branch = argv0 + 1;
 	}
 
 	/*
@@ -1337,56 +1338,56 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		struct object_id rev;
 		int dwim_ok =
-			!opts.patch_mode &&
+			!opts->patch_mode &&
 			dwim_new_local_branch &&
-			opts.track == BRANCH_TRACK_UNSPECIFIED &&
-			!opts.new_branch;
+			opts->track == BRANCH_TRACK_UNSPECIFIED &&
+			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
-					     &new_branch_info, &opts, &rev,
+					     &new_branch_info, opts, &rev,
 					     &dwim_remotes_matched);
 		argv += n;
 		argc -= n;
 	}
 
 	if (argc) {
-		parse_pathspec(&opts.pathspec, 0,
-			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
+		parse_pathspec(&opts->pathspec, 0,
+			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
 			       prefix, argv);
 
-		if (!opts.pathspec.nr)
+		if (!opts->pathspec.nr)
 			die(_("invalid path specification"));
 
 		/*
 		 * Try to give more helpful suggestion.
 		 * new_branch && argc > 1 will be caught later.
 		 */
-		if (opts.new_branch && argc == 1)
+		if (opts->new_branch && argc == 1)
 			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
-				argv[0], opts.new_branch);
+				argv[0], opts->new_branch);
 
-		if (opts.force_detach)
+		if (opts->force_detach)
 			die(_("git checkout: --detach does not take a path argument '%s'"),
 			    argv[0]);
 
-		if (1 < !!opts.writeout_stage + !!opts.force + !!opts.merge)
+		if (1 < !!opts->writeout_stage + !!opts->force + !!opts->merge)
 			die(_("git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
 			      "checking out of the index."));
 	}
 
-	if (opts.new_branch) {
+	if (opts->new_branch) {
 		struct strbuf buf = STRBUF_INIT;
 
-		if (opts.new_branch_force)
-			opts.branch_exists = validate_branchname(opts.new_branch, &buf);
+		if (opts->new_branch_force)
+			opts->branch_exists = validate_branchname(opts->new_branch, &buf);
 		else
-			opts.branch_exists =
-				validate_new_branchname(opts.new_branch, &buf, 0);
+			opts->branch_exists =
+				validate_new_branchname(opts->new_branch, &buf, 0);
 		strbuf_release(&buf);
 	}
 
 	UNLEAK(opts);
-	if (opts.patch_mode || opts.pathspec.nr) {
-		int ret = checkout_paths(&opts, new_branch_info.name);
+	if (opts->patch_mode || opts->pathspec.nr) {
+		int ret = checkout_paths(opts, new_branch_info.name);
 		if (ret && dwim_remotes_matched > 1 &&
 		    advice_checkout_ambiguous_remote_branch_name)
 			advise(_("'%s' matched more than one remote tracking branch.\n"
@@ -1405,6 +1406,6 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			       dwim_remotes_matched);
 		return ret;
 	} else {
-		return checkout_branch(&opts, &new_branch_info);
+		return checkout_branch(opts, &new_branch_info);
 	}
 }
-- 
2.19.1.1327.g328c130451.dirty

