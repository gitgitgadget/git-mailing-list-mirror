Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEDBB20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:30:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753122AbdKVWai (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:30:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42110 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753378AbdKVW2x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:28:53 -0500
Received: by mail-wm0-f67.google.com with SMTP id l188so11540162wma.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hxqrKnUB735mHCJwSskfvfEdRTecekAXKDO0D+b/JZo=;
        b=tdl9qB4DOLnboWe4O9DLWrkRaudgTVCxnUbcT4Tfire6c1hFqHPvhQbxAB8FT4REdX
         LA8DPoi41AwdiF+KoZDcdvfSx+x0qH136p6cEsUVX43YIcW89MHleqTn6k2AkzDjYCR6
         ZGpwvk4fOzIp98tamYBrswu1bpxyl4Fpt/Q1212hlXRpegfCyYl5eHPzljYs4AA2/DPR
         Yl2Vv4gGioagUJhiJaUVKskASb60H4i6weGvd7io5dmu7xrryvRQIbZkU4IBnsQ22xg4
         6cpliMb5VN5NCNOvXDLdZCVnOvWvATgrvp1eop2++ztLILBG9EZZOo3TjVccE6FYGX2x
         J6/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hxqrKnUB735mHCJwSskfvfEdRTecekAXKDO0D+b/JZo=;
        b=X/aFARdkPk9PpNqnm0kM1sbd7L0nlybUoNc/IFRT6WSnEp8iqhqCD8VXvGsdbD3QSh
         mCnFm6qyPCyCuN65FY5WVKpyMRC6X0Ryej+PszWmWaPIw5aneosZUTu5J7alLeW49Syz
         P6rYLFTsMR7SDyQv/lx8bp2u1D3skoV5in08iiz1J9oEppNPnE3I6jxS4JrH4fYt2wka
         7AvjmaIL0xD6wiehb5avs4vDqSOta3Ra3yOv8ew2fM/nV45bLNuS8bNUQGBs9nW+WiNn
         nDZu4yNi8qR0vnZp4hOWwPuRby+N5xr9VMEG9GWYaq9oxOWXInprxO0P8ZBZR6cOlHQq
         AhUw==
X-Gm-Message-State: AJaThX4d/t+EMkGHGs12LMLU9i5/okMVRVGPy2bsjFL/T5rlyGAAS01a
        4XHmcjCgZDEEgJUgiEKhbswSsfwp
X-Google-Smtp-Source: AGs4zMYR/lPU4iwEse9FCeVmXf9Ry89C4voW1OtzybQAaQq4VVTqaABiSC81Rm6qihYtnXPuyMX07A==
X-Received: by 10.28.160.6 with SMTP id j6mr5928738wme.125.1511389731779;
        Wed, 22 Nov 2017 14:28:51 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id t200sm3652937wmd.45.2017.11.22.14.28.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:28:50 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/4] make git worktree add dwim more
Date:   Wed, 22 Nov 2017 22:30:16 +0000
Message-Id: <20171122223020.2780-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous rounds were at
https://public-inbox.org/git/20171112134305.3949-1-t.gummerer@gmail.com/,
https://public-inbox.org/git/20171118181103.28354-1-t.gummerer@gmail.com/ and
https://public-inbox.org/git/20171118224706.13810-1-t.gummerer@gmail.com/.

Thanks Eric for the review of the previous round.

The main change is that the --[no-]track flag now works generally
instead of just disabling the new dwim mode.

Interdiff below:
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index eedead2c4c..abc8f1f50d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -56,22 +56,23 @@ If <branch> is not found, and neither `-b` nor `-B` nor `--detach` are
 used, but there does exist a tracking branch in exactly one remote
 (call it <remote>) with a matching name, treat as equivalent to
 ------------
-$ git worktree add -b <branch> <path> <remote>/<branch>
+$ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
 If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
 then, as a convenience, if there exists a tracking branch in exactly
-one remote (call it <remote>) matching the basename of the path
-(call it <branch>), treat it as equivalent to
+one remote (call it `<remote>`) matching the basename of the path
+(call it `<branch>`), treat it as equivalent to
 ------------
-$ git worktree add -b <branch> <path> <remote>/<branch>
+$ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
-If no tracking branch exists in exactly one remote, <branch> is
+If no tracking branch exists in exactly one remote, `<branch>` is
 created based on HEAD, as if `-b $(basename <path>)` was specified.
 +
 To disable the behaviour of trying to match the basename of <path> to
 a remote, and always create a new branch from HEAD, the `--no-track`
 flag can be passed to `git worktree add`.
+
 list::
 
 List details of each worktree.  The main worktree is listed first, followed by
@@ -123,6 +124,12 @@ OPTIONS
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--[no-]track::
+	With `--track` `<branch>` is set as "tracking" branch for
+	`<new-branch>`.  This is the default if `<branch>` is a remote
+	tracking branch, and can be suppressed with `--no-track`.  See
+	also linkgit:git-branch[1].
+
 --lock::
 	Keep the working tree locked after creation. This is the
 	equivalent of `git worktree lock` after `git worktree add`,
diff --git a/builtin/worktree.c b/builtin/worktree.c
index b2a6dd020c..cbcceb0385 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -342,7 +342,7 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
-	int track_dwim = 1;
+	const char *opt_track = NULL;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -352,7 +352,9 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
-		OPT_BOOL(0, "track", &track_dwim, N_("checkout upstream branch if there's a unique match")),
+		OPT_PASSTHRU(0, "track", &opt_track, NULL,
+			     N_("set up tracking mode (see git-branch(1))"),
+			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
 		OPT_END()
 	};
 
@@ -387,7 +389,7 @@ static int add(int ac, const char **av, const char *prefix)
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
-		if (track_dwim) {
+		if (!opt_track || strcmp(opt_track, "--no-track")) {
 			struct object_id oid;
 			const char *remote =
 				unique_tracking_name(opts.new_branch, &oid);
@@ -402,11 +404,12 @@ static int add(int ac, const char **av, const char *prefix)
 		const char *remote;
 
 		commit = lookup_commit_reference_by_name(branch);
-		if (!commit)
+		if (!commit) {
 			remote = unique_tracking_name(branch, &oid);
-		if (!commit && remote) {
-			opts.new_branch = branch;
-			branch = remote;
+			if (remote) {
+				opts.new_branch = branch;
+				branch = remote;
+			}
 		}
 	}
 
@@ -418,9 +421,13 @@ static int add(int ac, const char **av, const char *prefix)
 			argv_array_push(&cp.args, "--force");
 		argv_array_push(&cp.args, opts.new_branch);
 		argv_array_push(&cp.args, branch);
+		if (opt_track)
+			argv_array_push(&cp.args, opt_track);
 		if (run_command(&cp))
 			return -1;
 		branch = opts.new_branch;
+	} else if (opt_track) {
+		die(_("--[no-]track can only be used if a new branch is created"));
 	}
 
 	UNLEAK(path);
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 87e233f812..6fd3da4036 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -6,16 +6,6 @@ test_description='test git worktree add'
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
-# Is branch "refs/heads/$1" set to pull from "$2/$3"?
-test_branch_upstream () {
-	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
-	{
-		git config "branch.$1.remote" &&
-		git config "branch.$1.merge"
-	} >actual.upstream &&
-	test_cmp expect.upstream actual.upstream
-}
-
 test_expect_success 'setup' '
 	test_commit init
 '
@@ -323,32 +313,72 @@ test_expect_success 'checkout a branch under bisect' '
 test_expect_success 'rename a branch under bisect not allowed' '
 	test_must_fail git branch -M under-bisect bisect-with-new-name
 '
+# Is branch "refs/heads/$1" set to pull from "$2/$3"?
+test_branch_upstream () {
+	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
+	{
+		git config "branch.$1.remote" &&
+		git config "branch.$1.merge"
+	} >actual.upstream &&
+	test_cmp expect.upstream actual.upstream
+}
 
-test_expect_success '"add" <path> <non-existent-branch> fails' '
-	test_must_fail git worktree add foo non-existent
+test_expect_success '--track sets up tracking' '
+	test_when_finished rm -rf track &&
+	git worktree add --track -b track track master &&
+	git config "branch.track.merge" &&
+	(
+		test_branch_upstream track . master
+	)
 '
 
-test_expect_success '"add" <path> <branch> dwims' '
-	test_when_finished rm -rf repo_upstream &&
-	test_when_finished rm -rf repo_dwim &&
-	test_when_finished rm -rf foo &&
-	git init repo_upstream &&
+# setup remote repository $1 and repository $2 with $1 set up as
+# remote.  The remote has two branches, master and foo.
+setup_remote_repo () {
+	git init $1 &&
 	(
-		cd repo_upstream &&
-		test_commit upstream_master &&
+		cd $1 &&
+		test_commit $1_master &&
 		git checkout -b foo &&
-		test_commit a_foo
+		test_commit upstream_foo
 	) &&
+	git init $2 &&
+	(
+		cd $2 &&
+		test_commit $2_master &&
+		git remote add $1 ../$1 &&
+		git config remote.$1.fetch \
+			"refs/heads/*:refs/remotes/$1/*" &&
+		git fetch --all
+	)
+}
+
+test_expect_success '--no-track avoids setting up tracking' '
+	test_when_finished rm -rf repo_upstream repo_local foo &&
+	setup_remote_repo repo_upstream repo_local &&
+	(
+		cd repo_local &&
+		git worktree add --no-track -b foo ../foo repo_upstream/foo
+	) &&
+	(
+		cd foo &&
+		! test_branch_upstream foo repo_upstream foo &&
+		git rev-parse repo_upstream/foo >expect &&
+		git rev-parse foo >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success '"add" <path> <non-existent-branch> fails' '
+	test_must_fail git worktree add foo non-existent
+'
+
+test_expect_success '"add" <path> <branch> dwims' '
+	test_when_finished rm -rf repo_upstream repo_dwim foo &&
+	setup_remote_repo repo_upstream repo_dwim &&
 	git init repo_dwim &&
 	(
 		cd repo_dwim &&
-		test_commit dwim_master &&
-		git remote add repo_upstream ../repo_upstream &&
-		git config remote.repo_upstream.fetch \
-			  "refs/heads/*:refs/remotes/repo_upstream/*" &&
-		git fetch --all &&
-		test_must_fail git worktree add -b foo ../foo foo &&
-		test_must_fail git worktree add --detach ../foo foo &&
 		git worktree add ../foo foo
 	) &&
 	(
@@ -361,60 +391,32 @@ test_expect_success '"add" <path> <branch> dwims' '
 '
 
 test_expect_success 'git worktree add --no-track does not set up tracking' '
-	test_when_finished rm -rf repo_a &&
-	test_when_finished rm -rf repo_b &&
-	test_when_finished rm -rf foo &&
-	git init repo_a &&
-	(
-		cd repo_a &&
-		test_commit a_master &&
-		git checkout -b foo &&
-		test_commit a_foo
-	) &&
-	git init repo_b &&
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
 	(
 		cd repo_b &&
-		test_commit b_master &&
-		git remote add repo_a ../repo_a &&
-		git config remote.repo_a.fetch \
-			"+refs/heads/*:refs/remotes/other_a/*" &&
-		git fetch --all &&
 		git worktree add --no-track ../foo
 	) &&
 	(
 		cd foo &&
 		! test_branch_upstream foo repo_a foo &&
-		git rev-parse other_a/foo >expect &&
+		git rev-parse repo_a/foo >expect &&
 		git rev-parse foo >actual &&
 		! test_cmp expect actual
 	)
 '
 
 test_expect_success 'git worktree add sets up tracking' '
-	test_when_finished rm -rf repo_a &&
-	test_when_finished rm -rf repo_b &&
-	test_when_finished rm -rf foo &&
-	git init repo_a &&
-	(
-		cd repo_a &&
-		test_commit a_master &&
-		git checkout -b foo &&
-		test_commit a_foo
-	) &&
-	git init repo_b &&
+	test_when_finished rm -rf repo_a repo_b &&
+	setup_remote_repo repo_a repo_b &&
 	(
 		cd repo_b &&
-		test_commit b_master &&
-		git remote add repo_a ../repo_a &&
-		git config remote.repo_a.fetch \
-			"+refs/heads/*:refs/remotes/other_a/*" &&
-		git fetch --all &&
 		git worktree add ../foo
 	) &&
 	(
 		cd foo &&
 		test_branch_upstream foo repo_a foo &&
-		git rev-parse other_a/foo >expect &&
+		git rev-parse repo_a/foo >expect &&
 		git rev-parse foo >actual &&
 		test_cmp expect actual
 	)


Thomas Gummerer (4):
  checkout: factor out functions to new lib file
  worktree: add --[no-]track option to the add subcommand
  worktree: make add <path> <branch> dwim
  worktree: make add <path> dwim

 Documentation/git-worktree.txt |  27 ++++++++++-
 Makefile                       |   1 +
 builtin/checkout.c             |  41 +---------------
 builtin/worktree.c             |  31 ++++++++++++
 checkout.c                     |  42 ++++++++++++++++
 checkout.h                     |  13 +++++
 t/t2025-worktree-add.sh        | 108 +++++++++++++++++++++++++++++++++++++++++
 7 files changed, 221 insertions(+), 42 deletions(-)
 create mode 100644 checkout.c
 create mode 100644 checkout.h

-- 
2.15.0.345.gf926f18f3

