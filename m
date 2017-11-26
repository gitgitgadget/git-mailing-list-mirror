Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D838520A40
	for <e@80x24.org>; Sun, 26 Nov 2017 19:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751598AbdKZTm2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 14:42:28 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:38939 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751342AbdKZTm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 14:42:27 -0500
Received: by mail-wr0-f179.google.com with SMTP id 11so21125929wrb.6
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 11:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Hi5LEjQOGPCZHJJ3nd4Ca1/+icJipFcCx/sRJhbH70=;
        b=g8XzrS8ly6mwArPL7DHBqhMfneR6PxcthoNaXP31qasku9d72hne0wsahuzwE4Io9c
         jhsgLgDDGi6adlF4JMPuxUdzXm/b4qphZJeB4NmOvHTI1iZ+Q6txK88YSI0R3MF4h1de
         0g0DeJuvSDYdKI6rT/k7uZ9vhaLRwbyAYsuYlzpxL648eCJwJVUxsZ3DCZtR5Vsg8vk6
         +lPx5lK/Lb2DkyMlpLJb2ULpVREUcVw+6n0V3TA9EW4q3rl/G5gYWfJrTonP3NtWg6Ps
         pau5jXjCl69aWpIYtqzlDA2nUqkrzZaOHEYnLmpOb6I0HUxYXxr64minhSE2Ejvpdiej
         TDDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Hi5LEjQOGPCZHJJ3nd4Ca1/+icJipFcCx/sRJhbH70=;
        b=q5dKEXtY+n5ecaewo8cnDRzxnUs0Sc+BOkHajwZmZPQJdSX1UGMxBHAOPyeDaGBB5b
         iYTs4w1ZNv5ezTrURRP7HmxDnKIwm+Bl+X983pZ8WVow3jwTvpyV06rZRerGHx3QLniQ
         OOLMiQG9csOSCHgUTKSca0tKrDaMzTwkjeSwSMcvgLj+MarpM+kFAtUO5NZcMDY19lwM
         Ly0jJ/H+219oRhWRmlkWPEHIvpDJ71xldgNGkiBFacXbG4yF203oPiN0CU7rDJ4AKzBa
         c5KUVnoeL5juUhTmAjT6CFxrpHCp2yyCk+SAe45XOcZFRNLHvbGSHshw3uhgAsWjtByd
         hKVQ==
X-Gm-Message-State: AJaThX5R1VaBgJ/0ekuk5owhHWxRF3Z2e80RMyGJ3sZdR7wDth5hSht7
        UUXsYsbwqa9+1fnlF7VKhOdWfu8Y
X-Google-Smtp-Source: AGs4zMavdUejCpc2JL8em4rVBemFSXpz9ZanO9BtbMnU+/nkIFPMb2x5MCxiR1hYG4J7LvcSsr2yUg==
X-Received: by 10.223.142.193 with SMTP id q59mr30641297wrb.262.1511725345440;
        Sun, 26 Nov 2017 11:42:25 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id b66sm1093948wmh.32.2017.11.26.11.42.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Nov 2017 11:42:24 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>,
        Paul Smith <paul@mad-scientist.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 0/6] make git worktree add dwim more
Date:   Sun, 26 Nov 2017 19:43:50 +0000
Message-Id: <20171126194356.16187-1-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.426.gb06021eeb
In-Reply-To: <20171122223020.2780-1-t.gummerer@gmail.com>
References: <20171122223020.2780-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous rounds can be found at
https://public-inbox.org/git/20171112134305.3949-1-t.gummerer@gmail.com/,
https://public-inbox.org/git/20171118181103.28354-1-t.gummerer@gmail.com/,
https://public-inbox.org/git/20171118224706.13810-1-t.gummerer@gmail.com/ and
https://public-inbox.org/git/20171122223020.2780-1-t.gummerer@gmail.com/.

Thanks Junio for the review of the previous round and Randall for the
suggestion of documenting that git worktree add can take a commit-ish,
not just a branch.

The main changes in this round are hiding the new behaviour for 'git
worktree <path>' behind a flag, and adding a config option to turn the
new behaviour on by default.  It's also no longer relying on the
--[no]-track flag, but using a new --[no-]guess-remote flag instead.

Interdiff between this and the previous round below:

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5f65fa9234..4966d90ebb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -3425,3 +3425,13 @@ web.browser::
 	Specify a web browser that may be used by some commands.
 	Currently only linkgit:git-instaweb[1] and linkgit:git-help[1]
 	may use it.
+
+worktree.guessRemote::
+	With `add`, if no branch argument, and neither of `-b` nor
+	`-B` nor `--detach` are given, the command defaults to
+	creating a new branch from HEAD.  If `worktree.guessRemote` is
+	set to true, `worktree add` tries to find a remote-tracking
+	branch whose name uniquely matches the new branch name.  If
+	such a branch exists, it is checked out and set as "upstream"
+	for the new branch.  If no such match can be found, it falls
+	back to creating a new branch from the current HEAD.
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index abc8f1f50d..fd841886ef 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,7 +9,7 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<branch>]
+'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
 'git worktree list' [--porcelain]
 'git worktree lock' [--reason <string>] <worktree>
 'git worktree prune' [-n] [-v] [--expire <expire>]
@@ -45,33 +45,24 @@ specifying `--reason` to explain why the working tree is locked.
 
 COMMANDS
 --------
-add <path> [<branch>]::
+add <path> [<commit-ish>]::
 
-Create `<path>` and checkout `<branch>` into it. The new working directory
+Create `<path>` and checkout `<commit-ish>` into it. The new working directory
 is linked to the current repository, sharing everything except working
 directory specific files such as HEAD, index, etc. `-` may also be
-specified as `<branch>`; it is synonymous with `@{-1}`.
+specified as `<commit-ish>`; it is synonymous with `@{-1}`.
 +
-If <branch> is not found, and neither `-b` nor `-B` nor `--detach` are
-used, but there does exist a tracking branch in exactly one remote
-(call it <remote>) with a matching name, treat as equivalent to
+If <commit-ish> is a branch name (call it `<branch>` and is not found,
+and neither `-b` nor `-B` nor `--detach` are used, but there does
+exist a tracking branch in exactly one remote (call it `<remote>`)
+with a matching name, treat as equivalent to
 ------------
 $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
-If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, if there exists a tracking branch in exactly
-one remote (call it `<remote>`) matching the basename of the path
-(call it `<branch>`), treat it as equivalent to
-------------
-$ git worktree add --track -b <branch> <path> <remote>/<branch>
-------------
-If no tracking branch exists in exactly one remote, `<branch>` is
-created based on HEAD, as if `-b $(basename <path>)` was specified.
-+
-To disable the behaviour of trying to match the basename of <path> to
-a remote, and always create a new branch from HEAD, the `--no-track`
-flag can be passed to `git worktree add`.
+If `<commit-ish>` is omitted and neither `-b` nor `-B` nor `--detach` used,
+then, as a convenience, a new branch based at HEAD is created automatically,
+as if `-b $(basename <path>)` was specified.
 
 list::
 
@@ -101,34 +92,44 @@ OPTIONS
 
 -f::
 --force::
-	By default, `add` refuses to create a new working tree when `<branch>`
+	By default, `add` refuses to create a new working tree when `<commit-ish>` is a branch name and
 	is already checked out by another working tree. This option overrides
 	that safeguard.
 
 -b <new-branch>::
 -B <new-branch>::
 	With `add`, create a new branch named `<new-branch>` starting at
-	`<branch>`, and check out `<new-branch>` into the new working tree.
-	If `<branch>` is omitted, it defaults to HEAD.
+	`<commit-ish>`, and check out `<new-branch>` into the new working tree.
+	If `<commit-ish>` is omitted, it defaults to HEAD.
 	By default, `-b` refuses to create a new branch if it already
 	exists. `-B` overrides this safeguard, resetting `<new-branch>` to
-	`<branch>`.
+	`<commit-ish>`.
 
 --detach::
 	With `add`, detach HEAD in the new working tree. See "DETACHED HEAD"
 	in linkgit:git-checkout[1].
 
 --[no-]checkout::
-	By default, `add` checks out `<branch>`, however, `--no-checkout` can
+	By default, `add` checks out `<commit-ish>`, however, `--no-checkout` can
 	be used to suppress checkout in order to make customizations,
 	such as configuring sparse-checkout. See "Sparse checkout"
 	in linkgit:git-read-tree[1].
 
+--[no-]guess-remote::
+	With `add`, instead of creating a new branch from HEAD when
+	`<commit-ish>` is not given, if there exists a tracking branch
+	in exactly one remote matching the basename of the path, base
+	the new branch on the remote-tracking branch, and mark the
+	remote-tracking branch as "upstream" from the new branch.
++
+This can also be set up as the default behaviour by using the
+`worktree.guessRemote` config option.
+
 --[no-]track::
-	With `--track` `<branch>` is set as "tracking" branch for
-	`<new-branch>`.  This is the default if `<branch>` is a remote
-	tracking branch, and can be suppressed with `--no-track`.  See
-	also linkgit:git-branch[1].
+	When creating a new branch, if `<commit-ish>` is a branch,
+	mark it as "upstream" from the new branch.  This is the
+	default if `<commit-ish>` is a remote-tracking branch.  See
+	"--track" in linkgit:git-branch[1] for details.
 
 --lock::
 	Keep the working tree locked after creation. This is the
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 83c73ecb0d..426aea8761 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -33,8 +33,19 @@ struct add_opts {
 
 static int show_only;
 static int verbose;
+static int guess_remote;
 static timestamp_t expire;
 
+static int git_worktree_config(const char *var, const char *value, void *cb)
+{
+	if (!strcmp(var, "worktree.guessremote")) {
+		guess_remote = git_config_bool(var, value);
+		return 0;
+	}
+
+	return 0;
+}
+
 static int prune_worktree(const char *id, struct strbuf *reason)
 {
 	struct stat st;
@@ -355,9 +366,13 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_PASSTHRU(0, "track", &opt_track, NULL,
 			     N_("set up tracking mode (see git-branch(1))"),
 			     PARSE_OPT_NOARG | PARSE_OPT_OPTARG),
+		OPT_BOOL(0, "guess-remote", &guess_remote,
+			 N_("try to match the new branch name with a remote-tracking branch")),
 		OPT_END()
 	};
 
+	git_config(git_worktree_config, NULL);
+
 	memset(&opts, 0, sizeof(opts));
 	opts.checkout = 1;
 	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
@@ -389,7 +404,7 @@ static int add(int ac, const char **av, const char *prefix)
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
-		if (!opt_track || strcmp(opt_track, "--no-track")) {
+		if (guess_remote) {
 			struct object_id oid;
 			const char *remote =
 				unique_tracking_name(opts.new_branch, &oid);
diff --git a/checkout.c b/checkout.c
index b0c744d37a..ac42630f74 100644
--- a/checkout.c
+++ b/checkout.c
@@ -1,5 +1,6 @@
 #include "cache.h"
 #include "remote.h"
+#include "checkout.h"
 
 struct tracking_name_data {
 	/* const */ char *src_ref;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index 6fd3da4036..6ce9b9c070 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -326,10 +326,7 @@ test_branch_upstream () {
 test_expect_success '--track sets up tracking' '
 	test_when_finished rm -rf track &&
 	git worktree add --track -b track track master &&
-	git config "branch.track.merge" &&
-	(
-		test_branch_upstream track . master
-	)
+	test_branch_upstream track . master
 '
 
 # setup remote repository $1 and repository $2 with $1 set up as
@@ -362,10 +359,9 @@ test_expect_success '--no-track avoids setting up tracking' '
 	) &&
 	(
 		cd foo &&
-		! test_branch_upstream foo repo_upstream foo &&
-		git rev-parse repo_upstream/foo >expect &&
-		git rev-parse foo >actual &&
-		test_cmp expect actual
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
 	)
 '
 
@@ -384,41 +380,67 @@ test_expect_success '"add" <path> <branch> dwims' '
 	(
 		cd foo &&
 		test_branch_upstream foo repo_upstream foo &&
-		git rev-parse repo_upstream/foo >expect &&
-		git rev-parse foo >actual &&
-		test_cmp expect actual
+		test_cmp_rev refs/remotes/repo_upstream/foo refs/heads/foo
 	)
 '
 
-test_expect_success 'git worktree add --no-track does not set up tracking' '
+test_expect_success 'git worktree add does not match remote' '
 	test_when_finished rm -rf repo_a repo_b foo &&
 	setup_remote_repo repo_a repo_b &&
 	(
 		cd repo_b &&
-		git worktree add --no-track ../foo
+		git worktree add ../foo
 	) &&
 	(
 		cd foo &&
-		! test_branch_upstream foo repo_a foo &&
-		git rev-parse repo_a/foo >expect &&
-		git rev-parse foo >actual &&
-		! test_cmp expect actual
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
 
-test_expect_success 'git worktree add sets up tracking' '
-	test_when_finished rm -rf repo_a repo_b &&
+test_expect_success 'git worktree add --guess-remote sets up tracking' '
+	test_when_finished rm -rf repo_a repo_b foo &&
 	setup_remote_repo repo_a repo_b &&
 	(
 		cd repo_b &&
+		git worktree add --guess-remote ../foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_a foo &&
+		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
+test_expect_success 'git worktree add with worktree.guessRemote sets up tracking' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config worktree.guessRemote true &&
 		git worktree add ../foo
 	) &&
 	(
 		cd foo &&
 		test_branch_upstream foo repo_a foo &&
-		git rev-parse repo_a/foo >expect &&
-		git rev-parse foo >actual &&
-		test_cmp expect actual
+		test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
+	)
+'
+
+test_expect_success 'git worktree --no-guess-remote option overrides config' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git config worktree.guessRemote true &&
+		git worktree add --no-guess-remote ../foo
+	) &&
+	(
+		cd foo &&
+		test_must_fail git config "branch.foo.remote" &&
+		test_must_fail git config "branch.foo.merge" &&
+		! test_cmp_rev refs/remotes/repo_a/foo refs/heads/foo
 	)
 '
 
Thomas Gummerer (6):
  checkout: factor out functions to new lib file
  worktree: add can be created from any commit-ish
  worktree: add --[no-]track option to the add subcommand
  worktree: make add <path> <branch> dwim
  worktree: add --guess-remote flag to add subcommand
  add worktree.guessRemote config option

 Documentation/config.txt       |  10 ++++
 Documentation/git-worktree.txt |  44 ++++++++++----
 Makefile                       |   1 +
 builtin/checkout.c             |  41 +------------
 builtin/worktree.c             |  46 +++++++++++++++
 checkout.c                     |  43 ++++++++++++++
 checkout.h                     |  13 +++++
 t/t2025-worktree-add.sh        | 130 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 278 insertions(+), 50 deletions(-)
 create mode 100644 checkout.c
 create mode 100644 checkout.h

-- 
2.15.0.426.gb06021eeb

