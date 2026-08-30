Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6100930DEB2
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788122928; cv=none; b=ZmdKVi8lnnpFFNvg5fcnZrHv1GfqYTDQlWESyAqNmpsdcvOe60Nj2lK2+6ufNSITT3R9rv3cjpxIkjDrB/09yazYY2NrFvraz2jMMQ6+dBmYTpKUOGYTYxAeOn4EUYmFST2iK1Zf+Efk3d8T644hmBP67I1M7r23xw96GRFAyBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788122928; c=relaxed/simple;
	bh=Fw0Rzq1t38650gwWtBRGWB0r/YTvcHDWLObdibLAVFw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qYt92ykNKI1wGitvu/nc9q5vZK+lJISX/WwQyg77yDtkBm3P+ka50kMd7ULc6Yn4hR3CO/w91UBbONC1rsrvAUug0RaGFk8N4yRE3UJIAvGi1xoo7cGOx+Tw547hoGMno8m5yYvnwYtRAGe0T4Gsqem45hGKT9iz2Gfy6qXZ83I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mJdM4a7U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hwuYpOII; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mJdM4a7U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hwuYpOII"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 76CDEEC0141;
	Sun, 30 Aug 2026 16:48:45 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 30 Aug 2026 16:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1788122925; x=
	1788209325; bh=xWrl071sxjLh2zYw5FAekW2K27c2q69snEd+LyaoB+k=; b=m
	JdM4a7UlvXGM9KAgZQ7GVOZ81vTR9Q6wFDAhgbn/LV9h+mpDe/cviPb2EjMN6hr2
	belgrl3Xkw4VyNW+WqqDBG3F0myd4LI+u1K/XXpvYVF0G9SQQvn7yhLvwsfyJg3S
	qJ+VkJ+UioKiePuYy3tFoTkdFdYJik+YgnwBdYs0PJ0g3uzMg3j8KNT1WDONtdCD
	uYjvp7OvvdLcumr+9OC5JUyg2njW2kUjQ6/0ioOxdPXk9w5tB243HWtb4rrw/sUD
	Phdam185ag8q4N+WOpgmW+p9gmeSwuiCNBMIy4AHaMTJeOYvUANHRe2nHPSXZhJJ
	5ycMdUu2EQQuWiKFaYWIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1788122925; x=1788209325; bh=xWrl071sxjLh2zYw5FAekW2K27c2
	q69snEd+LyaoB+k=; b=hwuYpOIIRx0Ob1QnirqYu4DcjHjXRN4KfZI49emdwEU5
	qpLaRc3hQ28/n9KinTolvNw82vRXDO4KsoQDr1fdI4l+Ms+h46lEFquM32bD/JTO
	0DQ0hb5q+NyAVPQ2RUaHXDcCJPw5FQoTkgt8V65+GJj64ZDVYrBid3DJW3D/dzJv
	URdMT5C+5uSBz0KcoNI0fzMyP8rM46yc1AMNkyYw/FigG9A5lerB2Ntmm8QMr3yw
	alEPKkDvlvjxsttkicEr9HYsSt4qRr0M+s5/AkXF6jcCqjnciEmZ3xmm5zBIMSTT
	F5fZFncNUw+kyqiAImo2kzWCoqCw+6zEpXol406n7Q==
X-ME-Sender: <xms:LZeUaoZD6z6_4pZgOwc8Xz4fOT_GZt_nsHIaTWKtns7zMWHlDouhAQ>
    <xme:LZeUapbD8XRLZncsd3HmH1kMCb5yVZSH1BOYVvud473MAx3vVvVeiO7HoS9zMVqBO
    KCvK42dco4Wsla9LILa7WLWUJn2AFsLP3iMZo0y3wpeNKM7sqY9Pbg>
X-ME-Received: <xmr:LZeUagkBOpdJr3OSM3wkAzz6VfdxJwfDAbwUieZZ7FturFaudVOmaIbn75R4iIDxGvhs-UGFY-hjhgrJgQdcZ8U8Ei5ikoQgSg>
X-ME-Proxy-Cause: dmFkZTFZrZ4/YHoTiEKVOP2LQxsWKbgG9qkzPDEPShznCE2ZB2YXWBn0jExWXtoksCc4kq
    Bv4FVHqzmqy4pfs8epobcSU6jMBJJG0WpacNb7sisGfeif8ChpZ18YMJFViLqi2v3rWfID
    lACML8wwBwD68VXggiFFLwyB8Z/jcZrPUU+rgDF6CZu3++OvAsBhLtOIQk5SJi80rpfE77
    TtDu0VJDBw+OROl0h440P+QaHfukc/m7iJN+5y0hD0LK3Iv+cMjqXgi7uHIefwVdwvrU9R
    xytEVlZ95JYGwQDrOlanp8RJG5frMb88S5PHAMtlv1+CKvZZgWgpwnFQqmZugbg9KghMKe
    yGRrAdh+nrijOTYsFNYPhHwTL6m6E4zBth5I8JuoFj6oLkDmbK8MJqRCkX5uJlhTJUZFCS
    4xwkprCj3PJOWJjpbPbDYOPmYfVbZuKNjdwtmD/GLETLZ0WpAYlkjhBfIHQSgYwn7N7i9Y
    vO9Nu3LC9YlV9AqC/mXws0YMtuspDJoHFzG4+Z+XSxxRXQpbxAJEAEKHvaRJnJBdvoIlJW
    kc+e075yLvjN+lGWVanlveaubMzpw3OVLqgedhj2qxCdt3svhz2LnwLt7Z17JSl9efma6Q
    4nJU+HkZclrY7aN5LKXDZtVicovFUJ34xRjxCdNY4bpAY16irLs8utIRgkpw
X-ME-Proxy: <xmx:LZeUatzPxmqloE_vDiuGKUshUC8I-svAffOdGB9-opaE5qb8GdMGeQ>
    <xmx:LZeUamOm_GUp9L31y4h5l0Mw9iIhGfnCi3lzxC_bVxxDPyi-mqx8YQ>
    <xmx:LZeUapS160TDYA4OLMxLPO0qOm1X_vWWy8e_42GdPanJtcZlmABrog>
    <xmx:LZeUasb6g7XYZKlqOs83TPUvCSzCP8w0w0dyrhJKcWjgAA5m033SCA>
    <xmx:LZeUaryMNvvTU94CEjvfq4z781PmTNnNulwybTwIfipep_K3dxVTMoDb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 30 Aug 2026 16:48:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 6/8] checkout: restructure switch, restore, and checkout entrypoints
Date: Sun, 30 Aug 2026 13:48:33 -0700
Message-ID: <20260830204835.1040408-7-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-884-g76cf8659c2
In-Reply-To: <20260830204835.1040408-1-gitster@pobox.com>
References: <20260828225206.310500-1-gitster@pobox.com>
 <20260830204835.1040408-1-gitster@pobox.com>
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

