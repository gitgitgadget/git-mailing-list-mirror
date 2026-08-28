Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9239DBFD
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787957540; cv=none; b=p/kbivyeeXN+lng4n50j2Ng+6fGq6Awj94nJz1B4BCz4ZD2DXwdGewlSS6Frq8AUYxn0JyyC6CtUToRs6tvjVx3dLDqIB9qD1Xs431fC6IjPbSaoW9VFW3c4blbEUPO5P/0OO9hxpFPKPsQDjIzPCc3+a519aHz0XtpsAe2GbPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787957540; c=relaxed/simple;
	bh=Fw0Rzq1t38650gwWtBRGWB0r/YTvcHDWLObdibLAVFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4Tz59htkmWS/87xh8bbFK67R/umMscSbk/SnIB0GETz37eYoCFYiHivOrzWY+RAgtU9UPpiFF7fpapps0WsPzPcvD09BKqabUAxkzLjwSTsIPUHSw1pYhq2KrZGnMbu8+FAb3BOExZWG0FVt3n4RMR0aN0aINpJtqtumRTBaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qmdooLVK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JKTLekKo; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qmdooLVK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JKTLekKo"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EE2031D00098;
	Fri, 28 Aug 2026 18:52:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 28 Aug 2026 18:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787957537; x=
	1788043937; bh=xWrl071sxjLh2zYw5FAekW2K27c2q69snEd+LyaoB+k=; b=q
	mdooLVKZUTNI17Hy4mS8ffIsJiFQU1GYp6kTenZ4hYWGd5HfXusaKRf8azeDkAZe
	jViCFaub4TKh4b1x48Oox2uOsUGz4zim/gdKcttU6eQVmk+QpuMm29PtLuk46NGQ
	k1hDjlN/vr4f3qDLdtB5x5lYsXQ4ASoLc3Mp+1Wuo0nO0emO4kp2d2/VFrJzJaKc
	7YDhtleyzh6HJYJbfXGyMcthDfO7KAFgOJaFpfPw4piPHI4EkrUZnQ3XGJIlUnR/
	lzCGEcqvNlRJn2dqeL5jB0CQwejIZGIiCsqcVKaQJOTCN1P0sAEXQZHfpd8BLWeY
	UEeb4vortjASuz1IcfPUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787957537; x=1788043937; bh=xWrl071sxjLh2zYw5FAekW2K27c2
	q69snEd+LyaoB+k=; b=JKTLekKog0yr0VRq6iJNDOJV97v13UlU3j2eLyEyoVQZ
	d8vAlclt4WMKDNZKf75jgnhBZobN3F44RyRZOPz03CvuC2heLugZ4ZBq5+fU6Zkt
	NRvy6Lfj9aY1aOsd0TDhcVh8c3Hi3SgThI01fehamZV2+3Jran/cLMJQQ616hsJR
	oKFFw5b3CtP1M84mrjdGEAbIt+dm8wjW0np5jYBsXbKOC5KgiGkUzYE31X14+IGH
	UMoa6efMVeuSvrYCyu1+3E5hUtxZOa0e1aU18c11mOZoAW1l9y5dagDKndjXB+99
	GWJu1cJnsVUJ2isJAT1A6Unso/Pt6ydE0AJgv9eWZw==
X-ME-Sender: <xms:IRGSasyxG0vuqwidlqxxCBDbOCZ08sh6KNn_BpQLPLYN7UBrs7yMsg>
    <xme:IRGSamSbK4VwmJ4Ireg3Q7gvXDi9ftzZvbV55ZwJew_LWtvOFxHGDJumtt6joP5Dt
    MbbSB89m--Sdx7skqAQ2hZH2sD3HjSlo6CZm0C0OavEN5QHrUq1-_Y>
X-ME-Received: <xmr:IRGSar_3pQ147XBdmjTJVK3HCMuxhEB1cUCw3BoD7gAV2wxWb-8MtosB12S3OgAeF89PQupfCsEJWqGyJRVrvd5eMFgUQX9Drw>
X-ME-Proxy-Cause: dmFkZTFZc1aZYGFuzEDVUVxpzJZ8opiQwBz0q906Rslj8IJH7jHDX6qlWNF7tfiDyZtdWi
    28dREm4MF9odei9jLQW94Okec8Wv5BwvfspUUrrO4AaBmSS8FL1hhP6HcCZuHRG8G+dn3Y
    2wJzR4wXGv4zVG5fLcSKTdRGGRxAgCpaYWcrP/zbLqac8Vob4p11drv79vETw1ZAIcYBQW
    3eHMCykDoXUgzVJ9ufUgWi4gkkTP19aHXGBga5gwohlK3yav30L7FF9Q2yssTi9B58G//R
    aK8AmlnYiaLQbASrBKisqIdjQZy34Onqm71lzpGP2s1CGtuldZ7AaBo1KaGmHul2cws0L5
    TUI4EjWalsQw6DiWnd63mZ2eaeA60iXuhDqIE4rE0pfaoTUXl/0fzLtXFyJNgxuyXj+mU6
    SXdt4IsdN10k/LPH6fPHxoZvatGLY5LAKmndHWEr7Ce4DeiFTm2LYPTDniznHfGDDJgZRL
    OlnBrvUxyaynKsGtyckzKMTrxXC9NOR1MbZyk+XbG76PV65iR8uxDvsjtoUKb8DF7Cpvjx
    xndjwTBqHxQtMhgX8w3kL5tWS3EK23lBID0RAMillabykmky5xkHZ6FDVnAbODHKlY0Ile
    3bhu+JmNHy/CWLfgYG0S/Asw3FhcdRtfSwMrJ8Dtj28WQXw4Kl4RmzpemE2w
X-ME-Proxy: <xmx:IRGSalpfLho20ButCMAU6PuNZTaDkBLTLuYRTyk_BpcccZuRn-c5bA>
    <xmx:IRGSagnzJ6x2bvir8RwR6R7Usyy15Jjj6HQJ20ezidwly-rbMzVCrA>
    <xmx:IRGSakJ8QKmBm8gIprKw4D9sXh1eMcYbDQ9y1GfS20nLD2nVy9jraw>
    <xmx:IRGSatzmhKQJyIAZIdS0hBJZ8CoTMOQirtZ0zPCCuTlFJOKmBPPJDg>
    <xmx:IRGSagKWCTtDd-Vl0Omc27bx4rEfH-Mju1qFSYiV1ENwmZBzkhBupjnD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 18:52:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 6/8] checkout: restructure switch, restore, and checkout entrypoints
Date: Fri, 28 Aug 2026 15:52:04 -0700
Message-ID: <20260828225206.310500-7-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260828225206.310500-1-gitster@pobox.com>
References: <xmqqh5kd3lm3.fsf@gitster.g>
 <20260828225206.310500-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cmd_switch(), cmd_restore(), and cmd_checkout() pass their options
to checkout_main(), which parses options and configuration,
validates and dispatches to checkout_branch() or checkout_paths().

Now that option initialization, validation, and branch setup have been
split into dedicated helper functions, restructure cmd_switch(),
cmd_restore(), and cmd_checkout() to invoke these helpers directly and
dispatch to checkout_branch() or checkout_paths().

In cmd_restore(), handle the --staged default from_treeish = "HEAD" and
resolve opts.from_treeish into new_branch_info and opts.source_tree.

This allows us to remove checkout_main() and enum checkout_command
as they are no longer needed.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/checkout.c | 297 +++++++++++++++++++++++----------------------
 1 file changed, 149 insertions(+), 148 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2edaca5539..b18515ac7f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1341,12 +1341,6 @@ static void setup_new_branch_info_and_source_tree(
 }
 
 
-enum checkout_command {
-	CHECKOUT_CHECKOUT = 1,
-	CHECKOUT_SWITCH = 2,
-	CHECKOUT_RESTORE = 3,
-};
-
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
@@ -1989,19 +1983,25 @@ static int setup_branch_name_and_info(int argc, const char **argv,
 	return 0;
 }
 
-static int checkout_main(int argc, const char **argv, const char *prefix,
-			 struct checkout_opts *opts, struct option *options,
-			 enum checkout_command which_command)
+int cmd_switch(int argc,
+	       const char **argv,
+	       const char *prefix,
+	       struct repository *repo UNUSED)
 {
-	int parseopt_flags = 0;
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
+	struct option *options = NULL;
 	struct branch_info new_branch_info = { 0 };
 	int ret;
-	char cb_option = (which_command == CHECKOUT_SWITCH) ? 'c' : 'b';
-
-	static const char * const checkout_usage[] = {
-		N_("git checkout [<options>] <branch>"),
-		N_("git checkout [<options>] [<branch>] -- <file>..."),
-		NULL,
+	struct option switch_options[] = {
+		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
+			   N_("create and switch to a new branch")),
+		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
+			   N_("create/reset and switch to a branch")),
+		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
+			 N_("second guess 'git switch <no-such-branch>'")),
+		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
+			 N_("throw away local modifications")),
+		OPT_END()
 	};
 
 	static const char * const switch_branch_usage[] = {
@@ -2009,103 +2009,125 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		NULL,
 	};
 
+	opts.dwim_new_local_branch = 1;
+	opts.accept_ref = 1;
+	opts.accept_pathspec = 0;
+	opts.switch_branch_doing_nothing_is_ok = 0;
+	opts.only_merge_on_switching_branches = 1;
+	opts.implicit_detach = 0;
+	opts.can_switch_when_in_progress = 0;
+	opts.orphan_from_empty_tree = 1;
+	opts.overlay_mode = -1;
+
+	init_checkout_opts(&opts, prefix);
+
+	options = parse_options_dup(switch_options);
+	options = add_common_options(&opts, options);
+	options = add_common_switch_branch_options(&opts, options);
+
+	argc = parse_options(argc, argv, prefix, options,
+			     switch_branch_usage, 0);
+
+	prepare_common_options(&opts);
+	setup_branch_name_and_info(argc, argv, &opts, &new_branch_info, 'c');
+
+	ret = checkout_branch(&opts, &new_branch_info);
+
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts.pathspec);
+	free(opts.pathspec_from_file);
+	free(options);
+
+	return ret;
+}
+
+int cmd_restore(int argc,
+		const char **argv,
+		const char *prefix,
+		struct repository *repo UNUSED)
+{
+	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
+	struct option *options;
+	struct branch_info new_branch_info = { 0 };
+	int ret;
+	struct option restore_options[] = {
+		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
+			   N_("which tree-ish to checkout from")),
+		OPT_BOOL('S', "staged", &opts.checkout_index,
+			   N_("restore the index")),
+		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
+			   N_("restore the working tree (default)")),
+		OPT_BOOL(0, "ignore-unmerged", &opts.ignore_unmerged,
+			 N_("ignore unmerged entries")),
+		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
+		OPT_END()
+	};
+
 	static const char * const restore_usage[] = {
 		N_("git restore [<options>] [--source=<branch>] <file>..."),
 		NULL,
 	};
 
-	const char * const *usagestr;
-
-	switch (which_command) {
-	case CHECKOUT_CHECKOUT:
-		usagestr = checkout_usage;
-		break;
-	case CHECKOUT_SWITCH:
-		usagestr = switch_branch_usage;
-		break;
-	case CHECKOUT_RESTORE:
-		usagestr = restore_usage;
-		break;
-	default:
-		BUG("no such checkout variant %d", which_command);
-	}
+	opts.accept_ref = 0;
+	opts.accept_pathspec = 1;
+	opts.empty_pathspec_ok = 0;
+	opts.overlay_mode = 0;
+	opts.checkout_index = -1;    /* default off */
+	opts.checkout_worktree = -2; /* default on */
+	opts.ignore_unmerged_opt = "--ignore-unmerged";
 
-	init_checkout_opts(opts, prefix);
+	init_checkout_opts(&opts, prefix);
 
-	if (!opts->accept_pathspec && !opts->accept_ref)
-		BUG("make up your mind, you need to take _something_");
-	if (opts->accept_pathspec && opts->accept_ref)
-		parseopt_flags = PARSE_OPT_KEEP_DASHDASH;
+	options = parse_options_dup(restore_options);
+	options = add_common_options(&opts, options);
+	options = add_checkout_path_options(&opts, options);
 
 	argc = parse_options(argc, argv, prefix, options,
-			     usagestr, parseopt_flags);
+			     restore_usage, 0);
 
-	validate_path_options(opts);
-	prepare_common_options(opts);
+	validate_path_options(&opts);
+	prepare_common_options(&opts);
 
 	/*
 	 * convenient shortcut: "git restore --staged [--worktree]" equals
 	 * "git restore --staged [--worktree] --source HEAD"
 	 */
-	if (!opts->from_treeish && opts->checkout_index)
-		opts->from_treeish = "HEAD";
-
-	if (opts->accept_ref) {
-		int n = setup_branch_name_and_info(argc, argv, opts,
-						   &new_branch_info, cb_option);
-		argv += n;
-		argc -= n;
-	} else if (!opts->accept_ref && opts->from_treeish) {
+	if (!opts.from_treeish && opts.checkout_index)
+		opts.from_treeish = "HEAD";
+
+	if (opts.from_treeish) {
 		struct object_id rev;
 
-		if (repo_get_oid_mb(the_repository, opts->from_treeish, &rev))
-			die(_("could not resolve '%s'"), opts->from_treeish);
+		if (repo_get_oid_mb(the_repository, opts.from_treeish, &rev))
+			die(_("could not resolve '%s'"), opts.from_treeish);
 
 		setup_new_branch_info_and_source_tree(&new_branch_info,
-						      opts, &rev,
-						      opts->from_treeish);
+						      &opts, &rev,
+						      opts.from_treeish);
 
-		if (!opts->source_tree)
-			die(_("reference is not a tree: %s"), opts->from_treeish);
+		if (!opts.source_tree)
+			die(_("reference is not a tree: %s"), opts.from_treeish);
 	}
 
 	if (argc) {
-		parse_pathspec(&opts->pathspec, 0,
-			       opts->patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
+		parse_pathspec(&opts.pathspec, 0,
+			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
 			       prefix, argv);
 
-		if (!opts->pathspec.nr)
+		if (!opts.pathspec.nr)
 			die(_("invalid path specification"));
-
-		/*
-		 * Try to give more helpful suggestion.
-		 * new_branch && argc > 1 will be caught later.
-		 */
-		if (opts->new_branch && argc == 1 && !new_branch_info.commit)
-			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
-				argv[0], opts->new_branch);
-
-		if (opts->force_detach)
-			die(_("git checkout: --detach does not take a path argument '%s'"),
-			    argv[0]);
 	}
 
-	parse_pathspec_from_file_options(opts, prefix);
+	parse_pathspec_from_file_options(&opts, prefix);
 
-	if (!opts->pathspec.nr) {
-		if (opts->accept_pathspec && !opts->empty_pathspec_ok &&
-		    !opts->patch_mode)	/* patch mode is special */
-			die(_("you must specify path(s) to restore"));
-	}
+	if (!opts.pathspec.nr && !opts.patch_mode)
+		die(_("you must specify path(s) to restore"));
 
-	if (opts->patch_mode || opts->pathspec.nr)
-		ret = checkout_paths(opts, &new_branch_info);
-	else
-		ret = checkout_branch(opts, &new_branch_info);
+	ret = checkout_paths(&opts, &new_branch_info);
 
 	branch_info_release(&new_branch_info);
-	clear_pathspec(&opts->pathspec);
-	free(opts->pathspec_from_file);
+	clear_pathspec(&opts.pathspec);
+	free(opts.pathspec_from_file);
 	free(options);
 
 	return ret;
@@ -2118,6 +2140,8 @@ int cmd_checkout(int argc,
 {
 	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
 	struct option *options;
+	struct branch_info new_branch_info = { 0 };
+	int ret, n;
 	struct option checkout_options[] = {
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
 			   N_("create and checkout a new branch")),
@@ -2132,6 +2156,12 @@ int cmd_checkout(int argc,
 		OPT_END()
 	};
 
+	static const char * const checkout_usage[] = {
+		N_("git checkout [<options>] <branch>"),
+		N_("git checkout [<options>] [<branch>] -- <file>..."),
+		NULL,
+	};
+
 	opts.dwim_new_local_branch = 1;
 	opts.switch_branch_doing_nothing_is_ok = 1;
 	opts.only_merge_on_switching_branches = 0;
@@ -2154,84 +2184,55 @@ int cmd_checkout(int argc,
 		opts.only_merge_on_switching_branches = 1;
 	}
 
+	init_checkout_opts(&opts, prefix);
+
 	options = parse_options_dup(checkout_options);
 	options = add_common_options(&opts, options);
 	options = add_common_switch_branch_options(&opts, options);
 	options = add_checkout_path_options(&opts, options);
 
-	return checkout_main(argc, argv, prefix, &opts, options,
-			     CHECKOUT_CHECKOUT);
-}
+	argc = parse_options(argc, argv, prefix, options,
+			     checkout_usage, PARSE_OPT_KEEP_DASHDASH);
 
-int cmd_switch(int argc,
-	       const char **argv,
-	       const char *prefix,
-	       struct repository *repo UNUSED)
-{
-	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
-	struct option *options = NULL;
-	struct option switch_options[] = {
-		OPT_STRING('c', "create", &opts.new_branch, N_("branch"),
-			   N_("create and switch to a new branch")),
-		OPT_STRING('C', "force-create", &opts.new_branch_force, N_("branch"),
-			   N_("create/reset and switch to a branch")),
-		OPT_BOOL(0, "guess", &opts.dwim_new_local_branch,
-			 N_("second guess 'git switch <no-such-branch>'")),
-		OPT_BOOL(0, "discard-changes", &opts.discard_changes,
-			 N_("throw away local modifications")),
-		OPT_END()
-	};
+	validate_path_options(&opts);
+	prepare_common_options(&opts);
 
-	opts.dwim_new_local_branch = 1;
-	opts.accept_ref = 1;
-	opts.accept_pathspec = 0;
-	opts.switch_branch_doing_nothing_is_ok = 0;
-	opts.only_merge_on_switching_branches = 1;
-	opts.implicit_detach = 0;
-	opts.can_switch_when_in_progress = 0;
-	opts.orphan_from_empty_tree = 1;
-	opts.overlay_mode = -1;
+	n = setup_branch_name_and_info(argc, argv, &opts, &new_branch_info, 'b');
+	argv += n;
+	argc -= n;
 
-	options = parse_options_dup(switch_options);
-	options = add_common_options(&opts, options);
-	options = add_common_switch_branch_options(&opts, options);
+	if (argc) {
+		parse_pathspec(&opts.pathspec, 0,
+			       opts.patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0,
+			       prefix, argv);
 
-	return checkout_main(argc, argv, prefix, &opts, options,
-			     CHECKOUT_SWITCH);
-}
+		if (!opts.pathspec.nr)
+			die(_("invalid path specification"));
 
-int cmd_restore(int argc,
-		const char **argv,
-		const char *prefix,
-		struct repository *repo UNUSED)
-{
-	struct checkout_opts opts = CHECKOUT_OPTS_INIT;
-	struct option *options;
-	struct option restore_options[] = {
-		OPT_STRING('s', "source", &opts.from_treeish, "<tree-ish>",
-			   N_("which tree-ish to checkout from")),
-		OPT_BOOL('S', "staged", &opts.checkout_index,
-			   N_("restore the index")),
-		OPT_BOOL('W', "worktree", &opts.checkout_worktree,
-			   N_("restore the working tree (default)")),
-		OPT_BOOL(0, "ignore-unmerged", &opts.ignore_unmerged,
-			 N_("ignore unmerged entries")),
-		OPT_BOOL(0, "overlay", &opts.overlay_mode, N_("use overlay mode")),
-		OPT_END()
-	};
+		/*
+		 * Try to give more helpful suggestion.
+		 * new_branch && argc > 1 will be caught later.
+		 */
+		if (opts.new_branch && argc == 1 && !new_branch_info.commit)
+			die(_("'%s' is not a commit and a branch '%s' cannot be created from it"),
+				argv[0], opts.new_branch);
 
-	opts.accept_ref = 0;
-	opts.accept_pathspec = 1;
-	opts.empty_pathspec_ok = 0;
-	opts.overlay_mode = 0;
-	opts.checkout_index = -1;    /* default off */
-	opts.checkout_worktree = -2; /* default on */
-	opts.ignore_unmerged_opt = "--ignore-unmerged";
+		if (opts.force_detach)
+			die(_("git checkout: --detach does not take a path argument '%s'"),
+			    argv[0]);
+	}
 
-	options = parse_options_dup(restore_options);
-	options = add_common_options(&opts, options);
-	options = add_checkout_path_options(&opts, options);
+	parse_pathspec_from_file_options(&opts, prefix);
 
-	return checkout_main(argc, argv, prefix, &opts, options,
-			     CHECKOUT_RESTORE);
+	if (opts.patch_mode || opts.pathspec.nr)
+		ret = checkout_paths(&opts, &new_branch_info);
+	else
+		ret = checkout_branch(&opts, &new_branch_info);
+
+	branch_info_release(&new_branch_info);
+	clear_pathspec(&opts.pathspec);
+	free(opts.pathspec_from_file);
+	free(options);
+
+	return ret;
 }
-- 
2.55.0-884-g76cf8659c2

