Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79030201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 18:09:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424420AbdKRSJz (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 13:09:55 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37372 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030842AbdKRSJu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 13:09:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id v186so11764734wma.2
        for <git@vger.kernel.org>; Sat, 18 Nov 2017 10:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/Nup0brM2ezNvc7EhEnSGTPBmIYVRlmw0GU8/7bN24s=;
        b=seDRkBw3QH1UMcCKhiuQxyJyggjZ4qENDJZZxbe7NpK1gIv5CXPTNGdhxW/j02igU9
         yWOYGTYa8oUMh3UqnXwmhj6EVIwpbRFbOXDvJp8f5MqvUCSuKZ6EkBd0WVCXCtkzQmXS
         YxQCDrYGrK/+fw0jkMFUUcpsxZXZTLnCggctn4O8FpxSZtUM4g6jn2g+hesvYAwrrd4S
         vFF2/FNdZ9uJTFv33XQzHSZyuAcBHpyretYjt+uxZUtQTbFL7niuDtlxD6BMerxmOgzn
         WBThxiGymNIC4NSUdBOtkKxn2IHoRevP7mzcCsWTacvPNxQ5VJblrHTOmYokEFqi0zni
         M3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/Nup0brM2ezNvc7EhEnSGTPBmIYVRlmw0GU8/7bN24s=;
        b=k36Kbcol94+97UOwKZK88X8f/iCQvjPyDcsguorrP1dzxUvMvFA4tsjPz1olsP/2rK
         WlYpRjGMKl+GmJbl29EPMPEh0G+YiHg1M3EUDQSZB4dh/S/n1ASXS8gVl4ihAKD/Co+Q
         abVfeTi76Vcgzodo7bzofpinvkYRA35aeSAYGhaHjdIZGwp1nuZan6GLgSExum/JoLwy
         F16LcScsfKyZuRk0WpO+goK7w5kFeb8gSaHz42gdmTTzAsU16JqPWhdKai93sgvBn//O
         ++PnbP+gqX+mTcBidQfLlGs/4beT25G8VFN9k9MszDMyjH0lo1cXA6VZnpTT4yWd5EkY
         Hjsg==
X-Gm-Message-State: AJaThX48Xd1smD5O4NeeeQkBmGxUCIFXd0ph+uCOLnVTGRAv/3abg9KE
        3tsL1iyVnoFA2MTPL//j6mA6Rx4x
X-Google-Smtp-Source: AGs4zMZJr0kbuD1wTXjIyKWGrvrvNjLn3c6YEFeFN4RHXQp6Dk+GwvPXxH82agcLghiWALc0sI+HjQ==
X-Received: by 10.28.52.148 with SMTP id b142mr6313605wma.154.1511028588589;
        Sat, 18 Nov 2017 10:09:48 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o22sm16799474wrb.40.2017.11.18.10.09.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Nov 2017 10:09:47 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v2 3/3] worktree: make add <path> dwim
Date:   Sat, 18 Nov 2017 18:11:03 +0000
Message-Id: <20171118181103.28354-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171118181103.28354-1-t.gummerer@gmail.com>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
 <20171118181103.28354-1-t.gummerer@gmail.com>
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
I went back and forth between hiding this behing a flag, and making it
default and having a flag for getting the old behaviour back.

In the end I went for making the new behaviour the default, because
the 'worktree' feature is still experimental, and it's easy to correct
the behaviour if it's not what was desired.  I also think this is the
more intuitve behaviour, but clearly I'm biased because *I* want to it
to behave this way.

I'm happy to keep the old behaviour the default and hide the new
behaviour behind a flag if we feel this is too much of a change in
behaviour at this point.

 Documentation/git-worktree.txt | 15 ++++++++---
 builtin/worktree.c             |  9 +++++++
 t/t2025-worktree-add.sh        | 60 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 3c7c8c3cee..11cac104d9 100644
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
index 92b583ae39..82088415b8 100644
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
 
 	if (ac == 2) {
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index e5959800c0..a566d867fe 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -358,4 +358,64 @@ test_expect_success '"add" <path> <branch> dwims' '
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
2.15.0.345.gf926f18f3d

