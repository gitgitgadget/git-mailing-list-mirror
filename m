Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77F921F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbeKUEQV (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 23:16:21 -0500
Received: from mail-lj1-f175.google.com ([209.85.208.175]:38506 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbeKUEQV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 23:16:21 -0500
Received: by mail-lj1-f175.google.com with SMTP id c19-v6so2399726lja.5
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 09:45:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N34/hcTVgDuNNYIpX5/gDTjc8M+B/i/c1PbyzO0x3/o=;
        b=sl4MrZJCCW39r7qtlbrIUr4VGhz9X46vBNKsjuaJLY9oovMCXwevb82g7sdDY4XaMH
         NQF9/jg4Ztz6yZSHunXOMWoj3RkRWRBO67PvqNQqYYhLykPgg/5XIj0KOyVKXA2AZd2R
         O8ieISAV3KJg4jGh32rEqhojmurH1zHifAF2yhVsn0htwiAEclySM2shv2tmUksAdLkY
         kIYxGJXBdEE8T7btzLodg6sffUVcBEbgUoRCGhAnQi2KLKmLr3PxEP2NKRepGqlvTeJo
         RXYrv2XXNJCvHSfhmfJeVNzolRP7EFAuVn2263I10+3KLl0PFxnujdgHIbnSLREexZQm
         3Twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N34/hcTVgDuNNYIpX5/gDTjc8M+B/i/c1PbyzO0x3/o=;
        b=UL3z9wtZzPk+N5onss4f2yV69x8/i1oiPf7za0vPA+Kdvr61AEtgTOazzJoA+tHwlH
         2SnfvyX+hUGVx682EZApkLcKBgTVpXqRmrDkLKgovpe9hfXEAeVs9ss2Pow5bsceug7+
         GfUKkhNmVYFR+txrLwUPQu5TyaiHf8nwvGJ1kCkKLEqC8PyViYoRHBCGE3zzf3t0Vpvs
         K8ryeBzVN9c8CRkwEUGTtmQ7kkEr1z8xuw8aZYk+lw4lZhieSx5GEWmBiqlK9CfyTZqY
         +6CWb+UEU6iaVrQGPgt3PohIAsdVCnjvrQ2r4Mt62zI6Qi4HUws7Sjmjz9fR/npNlaZk
         jfXg==
X-Gm-Message-State: AA+aEWZ/cgDeA7C/E68Z8GAY/8ofSg7oROTiiQ+SgPkZm4EbPByF65HW
        hR+CMPBPEB/EV1q/VtwPwbENxtXb
X-Google-Smtp-Source: AFSGD/WqwA27+GyDzsUCKlQiEUawmqwARMa2/ju0JeSDuoU5TH+bYuVR1PElx6knhB/COUq0Juq+Ig==
X-Received: by 2002:a2e:2f15:: with SMTP id v21-v6mr1795445ljv.56.1542735957805;
        Tue, 20 Nov 2018 09:45:57 -0800 (PST)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id y81-v6sm2988751lje.30.2018.11.20.09.45.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 09:45:56 -0800 (PST)
Date:   Tue, 20 Nov 2018 18:45:54 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [RFC] Introduce two new commands, switch-branch and restore-paths
Message-ID: <20181120174554.GA29910@duynguyen.home>
References: <20181110133525.17538-1-pclouds@gmail.com>
 <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
 <8736rx1ah9.fsf@evledraar.gmail.com>
 <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 04:19:53PM +0100, Duy Nguyen wrote:
> I promise to come back with something better (at least it still
> sounds better in my mind). If that idea does not work out, we can
> come back and see if we can improve this.

So this is it. The patch isn't pretty, mostly as a proof of
concept. Just look at the three functions at the bottom of checkout.c,
which is the main thing.

This patch tries to split "git checkout" command in two new ones:

- git switch-branch is all about switching branches
- git restore-paths (maybe restore-file is better) for checking out
  paths

The main idea is these two commands will co-exist with the good old
'git checkout', which will NOT be deprecated. Old timers will still
use "git checkout". But new people should be introduced to the new two
instead. And the new ones are just as capable as "git checkout".

Since the three commands will co-exist (with duplicate functionality),
maintenance cost must be kept to minimum. The way I did this is simply
split the command line options into three pieces: common,
switch-branch and checkout-paths. "git checkout" has all three, the
other two have common and another piece.

With this, a new option added to git checkout will be automatically
available in either switch-branch or checkout-paths. Bug fixes apply
to all relevant commands.

Later on, we could start to add a bit more stuff in, e.g. some form of
disambiguation is no longer needed when running as switch-branch, or
restore-paths.

So, what do you think?

-- 8< --
diff --git a/builtin.h b/builtin.h
index 6538932e99..6e321ec8a4 100644
--- a/builtin.h
+++ b/builtin.h
@@ -214,6 +214,7 @@ extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
 extern int cmd_repack(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
+extern int cmd_restore_paths(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
 extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
 extern int cmd_revert(int argc, const char **argv, const char *prefix);
@@ -227,6 +228,7 @@ extern int cmd_show_index(int argc, const char **argv, const char *prefix);
 extern int cmd_status(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
+extern int cmd_switch_branch(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tag(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index acdafc6e4c..868ca3c223 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -33,6 +33,16 @@ static const char * const checkout_usage[] = {
 	NULL,
 };
 
+static const char * const switch_branch_usage[] = {
+	N_("git switch-branch [<options>] <branch>"),
+	NULL,
+};
+
+static const char * const restore_paths_usage[] = {
+	N_("git restore-paths [<options>] [<branch>] -- <file>..."),
+	NULL,
+};
+
 struct checkout_opts {
 	int patch_mode;
 	int quiet;
@@ -44,6 +54,7 @@ struct checkout_opts {
 	int ignore_skipworktree;
 	int ignore_other_worktrees;
 	int show_progress;
+	int dwim_new_local_branch;
 	/*
 	 * If new checkout options are added, skip_merge_working_tree
 	 * should be updated accordingly.
@@ -55,6 +66,7 @@ struct checkout_opts {
 	int new_branch_log;
 	enum branch_track track;
 	struct diff_options diff_options;
+	char *conflict_style;
 
 	int branch_exists;
 	const char *prefix;
@@ -1223,78 +1235,105 @@ static int checkout_branch(struct checkout_opts *opts,
 	return switch_branches(opts, new_branch_info);
 }
 
-int cmd_checkout(int argc, const char **argv, const char *prefix)
+static struct option *add_common_options(struct checkout_opts *opts,
+					 struct option *prevopts)
 {
-	struct checkout_opts opts;
-	struct branch_info new_branch_info;
-	char *conflict_style = NULL;
-	int dwim_new_local_branch = 1;
-	int dwim_remotes_matched = 0;
 	struct option options[] = {
-		OPT__QUIET(&opts.quiet, N_("suppress progress reporting")),
-		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
+		OPT__QUIET(&opts->quiet, N_("suppress progress reporting")),
+		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts->ignore_skipworktree,
+			 N_("do not limit pathspecs to sparse entries only")),
+		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
+			    "checkout", "control recursive updating of submodules",
+			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
+		OPT_BOOL(0, "progress", &opts->show_progress, N_("force progress reporting")),
+		OPT__FORCE(&opts->force, N_("force checkout (throw away local modifications)"),
+			   PARSE_OPT_NOCOMPLETE),
+		OPT_STRING(0, "conflict", &opts->conflict_style, N_("style"),
+			   N_("conflict style (merge or diff3)")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+static struct option *add_switch_branch_options(struct checkout_opts *opts,
+						struct option *prevopts)
+{
+	struct option options[] = {
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
+		OPT_BOOL('m', "merge", &opts->merge, N_("perform a 3-way merge with the new branch")),
+		OPT_HIDDEN_BOOL(0, "guess", &opts->dwim_new_local_branch,
+				N_("second guess 'git checkout <no-such-branch>'")),
+		OPT_BOOL(0, "ignore-other-worktrees", &opts->ignore_other_worktrees,
+			 N_("do not check if another worktree is holding the given ref")),
+		OPT_END()
+	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
+
+static struct option *add_checkout_path_options(struct checkout_opts *opts,
+						struct option *prevopts)
+{
+	struct option options[] = {
+		OPT_SET_INT_F('2', "ours", &opts->writeout_stage,
 			      N_("checkout our version for unmerged files"),
 			      2, PARSE_OPT_NONEG),
-		OPT_SET_INT_F('3', "theirs", &opts.writeout_stage,
+		OPT_SET_INT_F('3', "theirs", &opts->writeout_stage,
 			      N_("checkout their version for unmerged files"),
 			      3, PARSE_OPT_NONEG),
-		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOL_F(0, "overwrite-ignore", &opts.overwrite_ignore,
-			   N_("update ignored files (default)"),
-			   PARSE_OPT_NOCOMPLETE),
-		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
-			   N_("conflict style (merge or diff3)")),
-		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
-		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
-			 N_("do not limit pathspecs to sparse entries only")),
-		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
-				N_("second guess 'git checkout <no-such-branch>'")),
-		OPT_BOOL(0, "ignore-other-worktrees", &opts.ignore_other_worktrees,
-			 N_("do not check if another worktree is holding the given ref")),
-		{ OPTION_CALLBACK, 0, "recurse-submodules", NULL,
-			    "checkout", "control recursive updating of submodules",
-			    PARSE_OPT_OPTARG, option_parse_recurse_submodules_worktree_updater },
-		OPT_BOOL(0, "progress", &opts.show_progress, N_("force progress reporting")),
-		OPT_END(),
+		OPT_BOOL('p', "patch", &opts->patch_mode, N_("select hunks interactively")),
+		OPT_END()
 	};
+	struct option *newopts = parse_options_concat(prevopts, options);
+	free(prevopts);
+	return newopts;
+}
 
-	memset(&opts, 0, sizeof(opts));
+static int checkout_main(int argc, const char **argv, const char *prefix,
+			 struct checkout_opts *opts, struct option *options,
+			 const char * const usagestr[])
+{
+	struct branch_info new_branch_info;
+	int dwim_remotes_matched = 0;
+
+	memset(opts, 0, sizeof(*opts));
+	opts->dwim_new_local_branch = 1;
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
 
-	argc = parse_options(argc, argv, prefix, options, checkout_usage,
+	argc = parse_options(argc, argv, prefix, options, usagestr,
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
 
-	if (conflict_style) {
-		opts.merge = 1; /* implied */
-		git_xmerge_config("merge.conflictstyle", conflict_style, NULL);
+	if (opts->conflict_style) {
+		opts->merge = 1; /* implied */
+		git_xmerge_config("merge.conflictstyle", opts->conflict_style, NULL);
 	}
 
-	if ((!!opts.new_branch + !!opts.new_branch_force + !!opts.new_orphan_branch) > 1)
+	if ((!!opts->new_branch + !!opts->new_branch_force + !!opts->new_orphan_branch) > 1)
 		die(_("-b, -B and --orphan are mutually exclusive"));
 
 	/*
@@ -1302,14 +1341,14 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
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
@@ -1318,7 +1357,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		argv0 = strchr(argv0, '/');
 		if (!argv0 || !argv0[1])
 			die(_("missing branch name; try -b"));
-		opts.new_branch = argv0 + 1;
+		opts->new_branch = argv0 + 1;
 	}
 
 	/*
@@ -1337,56 +1376,56 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 	if (argc) {
 		struct object_id rev;
 		int dwim_ok =
-			!opts.patch_mode &&
-			dwim_new_local_branch &&
-			opts.track == BRANCH_TRACK_UNSPECIFIED &&
-			!opts.new_branch;
+			!opts->patch_mode &&
+			opts->dwim_new_local_branch &&
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
@@ -1405,6 +1444,49 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			       dwim_remotes_matched);
 		return ret;
 	} else {
-		return checkout_branch(&opts, &new_branch_info);
+		return checkout_branch(opts, &new_branch_info);
 	}
 }
+
+int cmd_checkout(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, checkout_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_switch_branch(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	options = add_common_options(&opts, options);
+	options = add_switch_branch_options(&opts, options);
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, switch_branch_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
+
+int cmd_restore_paths(int argc, const char **argv, const char *prefix)
+{
+	struct checkout_opts opts;
+	struct option *options = NULL;
+	int ret;
+
+	options = add_common_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
+	ret = checkout_main(argc, argv, prefix, &opts,
+			    options, restore_paths_usage);
+	FREE_AND_NULL(options);
+	return ret;
+}
diff --git a/git.c b/git.c
index 2f604a41ea..e8a76a99da 100644
--- a/git.c
+++ b/git.c
@@ -542,6 +542,7 @@ static struct cmd_struct commands[] = {
 	{ "replace", cmd_replace, RUN_SETUP },
 	{ "rerere", cmd_rerere, RUN_SETUP },
 	{ "reset", cmd_reset, RUN_SETUP },
+	{ "restore-paths", cmd_restore_paths, RUN_SETUP | NEED_WORK_TREE },
 	{ "rev-list", cmd_rev_list, RUN_SETUP | NO_PARSEOPT },
 	{ "rev-parse", cmd_rev_parse, NO_PARSEOPT },
 	{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
@@ -557,6 +558,7 @@ static struct cmd_struct commands[] = {
 	{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
 	{ "stripspace", cmd_stripspace },
 	{ "submodule--helper", cmd_submodule__helper, RUN_SETUP | SUPPORT_SUPER_PREFIX | NO_PARSEOPT },
+	{ "switch-branch", cmd_switch_branch, RUN_SETUP | NEED_WORK_TREE },
 	{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 	{ "tag", cmd_tag, RUN_SETUP | DELAY_PAGER_CONFIG },
 	{ "unpack-file", cmd_unpack_file, RUN_SETUP | NO_PARSEOPT },
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 8c9edce52f..c609d52926 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -126,7 +126,7 @@ struct option *parse_options_concat(struct option *a, struct option *b)
 	struct option *ret;
 	size_t i, a_len = 0, b_len = 0;
 
-	for (i = 0; a[i].type != OPTION_END; i++)
+	for (i = 0; a && a[i].type != OPTION_END; i++)
 		a_len++;
 	for (i = 0; b[i].type != OPTION_END; i++)
 		b_len++;
-- 8< --
