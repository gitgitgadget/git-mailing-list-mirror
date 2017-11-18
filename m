Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD212036D
	for <e@80x24.org>; Sat, 18 Nov 2017 22:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947359AbdKRWpw (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 17:45:52 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:45821 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424473AbdKRWpr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 17:45:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id 9so12432176wme.4
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 14:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u5BFWfLA/RzzaZoxgRbi1Of8hTsG6Ryv/YlOMshpMEU=;
        b=AEhQeFJMPmgRh6jzU+4NLPr2AthUWxLzVuToXh8nZSaTO2ygbThbnzGcun6SKST3wr
         GPIj/JZPn/0n7FvVOMXI1tBv/tvHL6IuCcwCjBtVolBYX5IyNS1P523bGlh8smgVAYbu
         fC/18UaWK2KtKb//HX2LTzYMwjSevPB1HQeHPNVN2MveBcCP/dfaH/DMNN54vPuXRUsc
         1c4oYtp0YmbWlChI5qbfDQVgc43C2i6MBnTY3QAbRKoxEfdHo7XlkxrvD0K2L+lu9YeI
         NKM3+YeSQCBuU87f3tSPVbyyrh7LZraxDsGeIyqTvocYNGAMic+qt/aiW4K9nfPaU6XX
         Yxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u5BFWfLA/RzzaZoxgRbi1Of8hTsG6Ryv/YlOMshpMEU=;
        b=gaEakGTwGmJBNiGfgoaaP4N/mldxKxkU2MH93TlEta9OwfgLJj4PliwZz4J+ZsEuF/
         L61WoyLa4g0gx1p/kYfuLIRNqhehionJUkz/Jb2v0fE1hdH23eEzol+TGpwVq3fZZern
         SEyN8+X0A8RQ52ZzERdTmqpVSzM1I5JB1CTMGGaW/EmL6KEjkemS3K4yUJ1qtgNtJZk2
         d6/Tn1cCReE0+sUT/AMovfWaM+eP0uQkbUn7hRlxvOoD1W5w5x1zTTFiwLOLsbRJ6PC9
         mJNnet+Q+9kh6kb32fdxaDSCTnfiEPykgGMZmAVlmIIWeU3nJTqsc2L4sfM7ntI/8uer
         AP8Q==
X-Gm-Message-State: AJaThX6avJe9h8S4Y6HmluHzL8P+vq20TGyyF9lXMZksW3IKGxo1lCYS
        a9qBzThtsg7pLcj+IhbxMXbtb4/u
X-Google-Smtp-Source: AGs4zMYGFUEc4W+JSi1/YLgHgVrbZ5KePJksgqiuSQk8VmYlCFpC40G42HzyfagTlbC/pAsLyb/B/w==
X-Received: by 10.28.135.135 with SMTP id j129mr6983656wmd.144.1511045145443;
        Sat, 18 Nov 2017 14:45:45 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id v18sm157832wrv.37.2017.11.18.14.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 14:45:44 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/3] worktree: make add <path> dwim
Date:   Sat, 18 Nov 2017 22:47:06 +0000
Message-Id: <20171118224706.13810-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171118224706.13810-1-t.gummerer@gmail.com>
References: <20171118181103.28354-1-t.gummerer@gmail.com>
 <20171118224706.13810-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git worktree add <path>' creates a new branch named after the
basename of the <path>, that matches the HEAD of whichever worktree we
were on when calling "git worktree add <path>".

Make 'git worktree add <path> behave more like the dwim machinery in
'git checkout <new-branch>', i.e. check if the new branch name uniquely
matches the branch name of a remote tracking branch, and if so check out
that branch and set the upstream to the remote tracking branch.

This is a change of behaviour compared to the current behaviour, where
we create a new branch matching HEAD.  However as 'git worktree' is
still an experimental feature, and it's easy to notice/correct the
behaviour in case it's not what the user desired it's probably okay to
break existing behaviour here.

In order to also satisfy users who want the current behaviour of
creating a new branch from HEAD, add a '--no-track' flag, which disables
the new behaviour, and keeps the old behaviour of creating a new branch
from the head of the current worktree.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-worktree.txt | 15 ++++++++---
 builtin/worktree.c             |  9 +++++++
 t/t2025-worktree-add.sh        | 60 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index abf48fecb8..eedead2c4c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -60,9 +60,18 @@ $ git worktree add -b <branch> <path> <remote>/<branch>
 ------------
 +
 If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, a new branch based at HEAD is created automatically,
-as if `-b $(basename <path>)` was specified.
-
+then, as a convenience, if there exists a tracking branch in exactly
+one remote (call it <remote>) matching the basename of the path
+(call it <branch>), treat it as equivalent to
+------------
+$ git worktree add -b <branch> <path> <remote>/<branch>
+------------
+If no tracking branch exists in exactly one remote, <branch> is
+created based on HEAD, as if `-b $(basename <path>)` was specified.
++
+To disable the behaviour of trying to match the basename of <path> to
+a remote, and always create a new branch from HEAD, the `--no-track`
+flag can be passed to `git worktree add`.
 list::
 
 List details of each worktree.  The main worktree is listed first, followed by
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 05fc902bcc..b2a6dd020c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -342,6 +342,7 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	int track_dwim = 1;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -351,6 +352,7 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_BOOL(0, "track", &track_dwim, N_("checkout upstream branch if there's a unique match")),
 		OPT_END()
 	};
 
@@ -385,6 +387,13 @@ static int add(int ac, const char **av, const char *prefix)
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
+		if (track_dwim) {
+			struct object_id oid;
+			const char *remote =
+				unique_tracking_name(opts.new_branch, &oid);
+			if (remote)
+				branch = remote;
+		}
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index e3fc60dd1c..87e233f812 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -360,4 +360,64 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success 'git worktree add --no-track does not set up tracking' '
+	test_when_finished rm -rf repo_a &&
+	test_when_finished rm -rf repo_b &&
+	test_when_finished rm -rf foo &&
+	git init repo_a &&
+	(
+		cd repo_a &&
+		test_commit a_master &&
+		git checkout -b foo &&
+		test_commit a_foo
+	) &&
+	git init repo_b &&
+	(
+		cd repo_b &&
+		test_commit b_master &&
+		git remote add repo_a ../repo_a &&
+		git config remote.repo_a.fetch \
+			"+refs/heads/*:refs/remotes/other_a/*" &&
+		git fetch --all &&
+		git worktree add --no-track ../foo
+	) &&
+	(
+		cd foo &&
+		! test_branch_upstream foo repo_a foo &&
+		git rev-parse other_a/foo >expect &&
+		git rev-parse foo >actual &&
+		! test_cmp expect actual
+	)
+'
+
+test_expect_success 'git worktree add sets up tracking' '
+	test_when_finished rm -rf repo_a &&
+	test_when_finished rm -rf repo_b &&
+	test_when_finished rm -rf foo &&
+	git init repo_a &&
+	(
+		cd repo_a &&
+		test_commit a_master &&
+		git checkout -b foo &&
+		test_commit a_foo
+	) &&
+	git init repo_b &&
+	(
+		cd repo_b &&
+		test_commit b_master &&
+		git remote add repo_a ../repo_a &&
+		git config remote.repo_a.fetch \
+			"+refs/heads/*:refs/remotes/other_a/*" &&
+		git fetch --all &&
+		git worktree add ../foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_a foo &&
+		git rev-parse other_a/foo >expect &&
+		git rev-parse foo >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.15.0.345.gf926f18f3

