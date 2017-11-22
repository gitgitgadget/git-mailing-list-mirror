Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C83E20954
	for <e@80x24.org>; Wed, 22 Nov 2017 22:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753399AbdKVW3A (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 17:29:00 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:42118 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753391AbdKVW26 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 17:28:58 -0500
Received: by mail-wm0-f68.google.com with SMTP id l188so11540392wma.1
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 14:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/UA6VSVv6j55f3eFKu9qgaqOEdLTqNp+tEUSOV+9W7U=;
        b=AoIU0nBg1PMBpGOlPcfo+DnlcRhFJytGknpjxeMdvcHve/nt+nMAzB33ZfZx0Zrq5L
         m/abjZo8TLDXAtTApZ/o2PtVLac0/nrWr3eVkiF4utjJJ0rEA0G6nmh0fQhBrsuoZ8UU
         sJC5xqLHC4iZ8V5JzzIvO+zklI1ohqwTG8t9yqP+3qWufdwuUfwX0G4NuvJ9cdEmi9fa
         qUV9qT0b+NTkI6hgg72iLs246VBDuTNkNqCpH08Pt8ZVGRkWmGHRED8hp3pZVD0mUu/n
         XToyMwap5XxgeW1q571dZKtAT7jcoZIyf1jN5f+hG3y9SQMx7SwkJLkwClEsF/sckISf
         qv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/UA6VSVv6j55f3eFKu9qgaqOEdLTqNp+tEUSOV+9W7U=;
        b=VqD0LSGiELiijjKbFZzHZe66L13+OAUcWOHs9COBLYY4SgUqrsbRyj+7VdL7JvhZAG
         a6AHs9bEz7BjBbJR0zghWSFENZp2YhJ4f5YIGooQTFNUOO7UAAaRrjHE6egHkSOlEhmh
         FW+8ErUqcpWf9By/zEXPKOlyvxRWPxMfqbRXqnpMLiBhbJrS03Obib7NnCz+OgqXFx76
         u0q9NRv3MQJ3qBbYHQLQl4CNA9eNK/o5Xb8GIGksfaNFQMf3ZRF7IhxjcgfeB32iCPc0
         bjeYBfORB62GfG7Mn4MtEZNKtJ8/hccf9zGQVVKWTreAAuGgEbgTMf1PxT6pijI57sye
         vgJw==
X-Gm-Message-State: AJaThX6L6cimErcWJeF3lfCkh93nKB3SYnVnE+cUfYU57RWJozuA+WDV
        uc34up95KeOG2gywtpoyYqQbWj/R
X-Google-Smtp-Source: AGs4zMbmRNF2YhDPtI1wlt98ETn0hl2jsQFUxKeUXC6NWTl+eyazfJ5lNEYsmYNUkL6Bevog4ARscQ==
X-Received: by 10.28.90.65 with SMTP id o62mr4945396wmb.16.1511389737070;
        Wed, 22 Nov 2017 14:28:57 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id y78sm15270686wrb.51.2017.11.22.14.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Nov 2017 14:28:56 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 4/4] worktree: make add <path> dwim
Date:   Wed, 22 Nov 2017 22:30:20 +0000
Message-Id: <20171122223020.2780-5-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.345.gf926f18f3
In-Reply-To: <20171122223020.2780-1-t.gummerer@gmail.com>
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
 <20171122223020.2780-1-t.gummerer@gmail.com>
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
 Documentation/git-worktree.txt | 14 ++++++++++++--
 builtin/worktree.c             |  7 +++++++
 t/t2025-worktree-add.sh        | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 45642d3b7f..abc8f1f50d 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -60,8 +60,18 @@ $ git worktree add --track -b <branch> <path> <remote>/<branch>
 ------------
 +
 If `<branch>` is omitted and neither `-b` nor `-B` nor `--detach` used,
-then, as a convenience, a new branch based at HEAD is created automatically,
-as if `-b $(basename <path>)` was specified.
+then, as a convenience, if there exists a tracking branch in exactly
+one remote (call it `<remote>`) matching the basename of the path
+(call it `<branch>`), treat it as equivalent to
+------------
+$ git worktree add --track -b <branch> <path> <remote>/<branch>
+------------
+If no tracking branch exists in exactly one remote, `<branch>` is
+created based on HEAD, as if `-b $(basename <path>)` was specified.
++
+To disable the behaviour of trying to match the basename of <path> to
+a remote, and always create a new branch from HEAD, the `--no-track`
+flag can be passed to `git worktree add`.
 
 list::
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index e9cc3f3872..cbcceb0385 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -389,6 +389,13 @@ static int add(int ac, const char **av, const char *prefix)
 		int n;
 		const char *s = worktree_basename(path, &n);
 		opts.new_branch = xstrndup(s, n);
+		if (!opt_track || strcmp(opt_track, "--no-track")) {
+			struct object_id oid;
+			const char *remote =
+				unique_tracking_name(opts.new_branch, &oid);
+			if (remote)
+				branch = remote;
+		}
 	}
 
 	if (ac == 2 && !opts.new_branch && !opts.detach) {
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index ea144938a9..6fd3da4036 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -390,4 +390,36 @@ test_expect_success '"add" <path> <branch> dwims' '
 	)
 '
 
+test_expect_success 'git worktree add --no-track does not set up tracking' '
+	test_when_finished rm -rf repo_a repo_b foo &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git worktree add --no-track ../foo
+	) &&
+	(
+		cd foo &&
+		! test_branch_upstream foo repo_a foo &&
+		git rev-parse repo_a/foo >expect &&
+		git rev-parse foo >actual &&
+		! test_cmp expect actual
+	)
+'
+
+test_expect_success 'git worktree add sets up tracking' '
+	test_when_finished rm -rf repo_a repo_b &&
+	setup_remote_repo repo_a repo_b &&
+	(
+		cd repo_b &&
+		git worktree add ../foo
+	) &&
+	(
+		cd foo &&
+		test_branch_upstream foo repo_a foo &&
+		git rev-parse repo_a/foo >expect &&
+		git rev-parse foo >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.15.0.345.gf926f18f3

