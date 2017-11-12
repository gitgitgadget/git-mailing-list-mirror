Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF580201C8
	for <e@80x24.org>; Sun, 12 Nov 2017 13:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdKLNmT (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Nov 2017 08:42:19 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51447 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdKLNmS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Nov 2017 08:42:18 -0500
Received: by mail-wm0-f66.google.com with SMTP id b189so3564659wmd.0
        for <git@vger.kernel.org>; Sun, 12 Nov 2017 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r/mBHLPuyIXC2RBuRgVUu/53S1Q6wIuReq/pUvrwo9w=;
        b=OPMpNCCXEYb0kBRt4pmMmZ0kvSpXsybAGigUgCO3KyYpOYzERtDIpT00cWNYWfLycg
         o5J9XwH/d2hn7D8+TDUhdn6kxofnFenkqjdW1W7/5yxLak4My/hd0O3RqX96K1npA07r
         HsA0Y9emlYkkOmchv64G8/QNGNawfDKFGCbpIp5raZv4gilmdlebfB7XPL2qhQ0bY3jK
         5HgFYTBUZrH1ay/FXKEZMbnU0X8VCaU1gM5wjwRoBYv56aiogNCGJk4Qsw54+eDMyfAz
         2x6Tr2PxDGuJS5Jyuos95b9KnF7B8Y0eRb1PnAHoFhhzeyvNIsMXvWjEVx6kalDy0qaU
         mC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r/mBHLPuyIXC2RBuRgVUu/53S1Q6wIuReq/pUvrwo9w=;
        b=b0aE23MjXX4RA4Q+s90q7iwojU6SWTU6WApIL+3oVDDrXOajg94t+E5uFvMOT8emuu
         jyxlTcSvldp66rHduVkduwTNnLspIVU6AmVqwTsdSf6hH0qkC2IBflYZJgq5+KizOU4Y
         wIiQxv7kULjf909NGJxBzmf5fVtq/AH0O8XLoWeJ5aGFLWEwci3ntdxhFmVr82YxQ3Zz
         4/12etlL3lWNbxMGwS7GxiIRssMgojbUwSAXKy4gKqnhetxjzlLgPjGjnzoAMOBEVh/6
         4uLrDDlla4XcIx81CAp+WlsSYi+ziQupye4eR1vcC48c2ZG6keKcLa+WqtEgmNUlS/wn
         pWYA==
X-Gm-Message-State: AJaThX4y0OBm/+vphMhUuV3rPYZV79l89MJEYvFfllNlIK5Xcs0bBc5n
        tcRWf3OjeV9qZebzoVze0JGFsw55
X-Google-Smtp-Source: AGs4zMYZWa8aoD50Ejj8ariksFivapHiWp2yT0+34/cPn6w3qBDwezFl3k7HytJsbC1CpfbUp0LQdA==
X-Received: by 10.28.5.199 with SMTP id 190mr3989586wmf.29.1510494136682;
        Sun, 12 Nov 2017 05:42:16 -0800 (PST)
Received: from localhost ([62.189.9.199])
        by smtp.gmail.com with ESMTPSA id 80sm7004323wmk.14.2017.11.12.05.42.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Nov 2017 05:42:15 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v1 2/2] worktree: make add dwim
Date:   Sun, 12 Nov 2017 13:43:05 +0000
Message-Id: <20171112134305.3949-2-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.403.gc27cc4dac6
In-Reply-To: <20171112134305.3949-1-t.gummerer@gmail.com>
References: <20171112134305.3949-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently git worktree add creates a new branch, that matches the HEAD
of whichever worktree we were on when calling "git worktree add".

Add a --guess flag to git worktree add, that makes it behave like the
dwim machinery in 'git checkout <new-branch>', i.e. check if the new
branch name uniquely matches the branch name of a remote tracking
branch, and if so check out that branch, and set the upstream to the
remote tracking branch.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---

I'm a bit torn about hiding his behind an additional flag in git
worktree add or not.  I would like to have the feature without the
additional flag, but it might break some peoples expectations, so
dunno.

 builtin/worktree.c      | 14 +++++++++-
 t/t2025-worktree-add.sh | 70 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b9307aa58..5740d1f8a3 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "checkout.h"
 #include "config.h"
 #include "builtin.h"
 #include "dir.h"
@@ -341,6 +342,7 @@ static int add(int ac, const char **av, const char *prefix)
 	const char *new_branch_force = NULL;
 	char *path;
 	const char *branch;
+	int dwim_new_branch = 0;
 	struct option options[] = {
 		OPT__FORCE(&opts.force, N_("checkout <branch> even if already checked out in other worktree")),
 		OPT_STRING('b', NULL, &opts.new_branch, N_("branch"),
@@ -350,6 +352,7 @@ static int add(int ac, const char **av, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.detach, N_("detach HEAD at named commit")),
 		OPT_BOOL(0, "checkout", &opts.checkout, N_("populate the new working tree")),
 		OPT_BOOL(0, "lock", &opts.keep_locked, N_("keep the new working tree locked")),
+		OPT_BOOL(0, "guess", &dwim_new_branch, N_("checkout upstream branch if there's a unique match")),
 		OPT_END()
 	};
 
@@ -363,6 +366,7 @@ static int add(int ac, const char **av, const char *prefix)
 
 	path = prefix_filename(prefix, av[0]);
 	branch = ac < 2 ? "HEAD" : av[1];
+	dwim_new_branch = ac < 2 ? dwim_new_branch : 0;
 
 	if (!strcmp(branch, "-"))
 		branch = "@{-1}";
@@ -387,13 +391,21 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (opts.new_branch) {
+		struct object_id oid;
+		const char *remote;
 		struct child_process cp = CHILD_PROCESS_INIT;
+
+		remote = unique_tracking_name(opts.new_branch, &oid);
+
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
 		if (opts.force_new_branch)
 			argv_array_push(&cp.args, "--force");
 		argv_array_push(&cp.args, opts.new_branch);
-		argv_array_push(&cp.args, branch);
+		if (dwim_new_branch && remote)
+			argv_array_push(&cp.args, remote);
+		else
+			argv_array_push(&cp.args, branch);
 		if (run_command(&cp))
 			return -1;
 		branch = opts.new_branch;
diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
index b5c47ac602..b37c279787 100755
--- a/t/t2025-worktree-add.sh
+++ b/t/t2025-worktree-add.sh
@@ -6,6 +6,16 @@ test_description='test git worktree add'
 
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
+# Is branch "refs/heads/$1" set to pull from "$2/$3"?
+test_branch_upstream () {
+	printf "%s\n" "$2" "refs/heads/$3" >expect.upstream &&
+	{
+		git config "branch.$1.remote" &&
+		git config "branch.$1.merge"
+	} >actual.upstream &&
+	test_cmp expect.upstream actual.upstream
+}
+
 test_expect_success 'setup' '
 	test_commit init
 '
@@ -314,4 +324,64 @@ test_expect_success 'rename a branch under bisect not allowed' '
 	test_must_fail git branch -M under-bisect bisect-with-new-name
 '
 
+test_expect_success 'git worktree add does not dwim' '
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
+		! test_branch_upstream foo repo_a foo &&
+		git rev-parse other_a/foo >expect &&
+		git rev-parse foo >actual &&
+		! test_cmp expect actual
+	)
+'
+
+test_expect_success 'git worktree add --guess dwims' '
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
+		git worktree add --guess ../foo
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
2.15.0.403.gc27cc4dac6

