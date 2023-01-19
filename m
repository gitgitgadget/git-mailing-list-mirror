Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70514C00A5A
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 05:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjASFxp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 00:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjASFxn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 00:53:43 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14028C7
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 21:53:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id bj3so1401407pjb.0
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 21:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIHBvUMRGevOmrKefu8416alR2st0L/9ke8gFkn/LXI=;
        b=N5EY+RDUlGZmT2FWgefiUhYnmA4v6jYOrOaMaiRmlpQftIPKGN9hzswFJVOBhAxk0Y
         i/Exs+htRKsudj6dx0nJXDIjdGkPDpheWDEW0lf6zzBmRll2a6EtIeRndhzD/A5UsO0n
         Mc9PEM3uwXBNtjHyaz3MjynkYzjij2ntnwqQo4FTh2qT/SFV4LbGWUscL0tmmpWX0kRe
         ndWOChNA/sCOqnzcaitqXepT78R9mGT2/cKi6f3QRAb426/MazSPWhve+o0qN/JDf9CN
         0uwvHNPRU6KS2NqpMd14xFuJYSQNx4U0w9A5duLkuMb3OXiHq9AhEWpatllrDjbVZlXe
         XvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nIHBvUMRGevOmrKefu8416alR2st0L/9ke8gFkn/LXI=;
        b=1G/ALLkyauqhqI8M2I6aYxYtBC/MzHucw3GJgewaU8VTokS8CsFxggEhjYRUdtQWjn
         Ux4zt1oIByQ4MRKBRtt/nZ4MgkiWEXGgS5aBEYiWDyeKsW5fcZC55fbp2akIxMzUjZEg
         6wKVm9a1qjLpEUVoy8hirT9fujxye5f9WPWX3vf51gK00UifY/qOJtK4iiY36rLFVA0U
         u5rfduo1LIScjCHt5BuekIymuv6woAFlVDvo67kEtMLC2nswR6wsDvqMoW+R3AkLcWCI
         mfiUYZEoNkcDxGO4wwhhwTHuzYDqHW8mIJAS5h4wkZRYXd5gtk7mrx5n8zzPwufRzQKD
         bjUQ==
X-Gm-Message-State: AFqh2krksp08YuYzei+EJchxrEL9Yawrajc4wst6VxTwuDSxxH/foSTW
        x561L73JqEZGcq3DKWoKbV1x4WMbo4c=
X-Google-Smtp-Source: AMrXdXsnbaa3gr5jqE4b4QN2WkOHC1BfSz7z8p8LF+i4AI+u1rIig+I167kDSnVyeAArcUf0JeKfhQ==
X-Received: by 2002:a17:902:e8c1:b0:192:ac33:7f91 with SMTP id v1-20020a170902e8c100b00192ac337f91mr7981617plg.69.1674107621214;
        Wed, 18 Jan 2023 21:53:41 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id z15-20020a170903018f00b00189f2fdc178sm24125214plg.177.2023.01.18.21.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 21:53:40 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] checkout/switch: disallow checking out same branch in multiple worktrees
Date:   Wed, 18 Jan 2023 21:53:24 -0800
Message-Id: <20230119055325.1013-1-carenas@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230118061527.76218-1-carenas@gmail.com>
References: <20230118061527.76218-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commands `git switch -C` and `git checkout -B` neglect to check whether
the provided branch is already checked out in some other worktree, as
shown by the following:

  $ git worktree list
  .../foo    beefb00f [main]
  $ git worktree add ../other
  Preparing worktree (new branch 'other')
  HEAD is now at beefb00f first
  $ cd ../other
  $ git switch -C main
  Switched to and reset branch 'main'
  $ git worktree list
  .../foo    beefb00f [main]
  .../other  beefb00f [main]

Fix this problem by teaching `git switch -C` and `git checkout -B` to
check whether the branch in question is already checked out elsewhere
by expanding on the existing checks that are being used by their non
force variants.

Unlike what it is done for `git switch` and `git checkout`, that have
an historical exception to ignore other workspaces if the branch to
check is the current one (as required when called as part of other
tools), the logic implemented is more strict and will require the user
to invoke the command with `--ignore-other-worktrees` to explicitly
indicate they want the risky behaviour.

This matches the current behaviour of `git branch -f` and is safer, for
more details see the tests in t2400.

Reported-by: Jinwook Jeong <vustthat@gmail.com>
Helped-by: Rubén Justo <rjusto@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v2
* A leak free implementation
* More details in commit as suggested by Junio

Changes since v1
* A much better commit message
* Changes to the tests as suggested by Eric
* Changes to the logic as suggested by Rubén

 builtin/checkout.c      | 31 +++++++++++++++++++++++--------
 t/t2400-worktree-add.sh | 18 ++++++++++++++++--
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 5963e1b74b..467e194701 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1476,7 +1476,8 @@ static void die_if_some_operation_in_progress(void)
 }
 
 static int checkout_branch(struct checkout_opts *opts,
-			   struct branch_info *new_branch_info)
+			   struct branch_info *new_branch_info,
+			   char *check_branch_path)
 {
 	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
@@ -1535,15 +1536,15 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (!opts->can_switch_when_in_progress)
 		die_if_some_operation_in_progress();
 
-	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
-	    !opts->ignore_other_worktrees) {
+	if (check_branch_path && !opts->force_detach && !opts->ignore_other_worktrees) {
 		int flag;
 		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
-		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
-			die_if_checked_out(new_branch_info->path, 1);
+		if (opts->new_branch_force || (head_ref &&
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_path))))
+			die_if_checked_out(check_branch_path, 1);
 		free(head_ref);
 	}
+	free(check_branch_path);
 
 	if (!new_branch_info->commit && opts->new_branch) {
 		struct object_id rev;
@@ -1630,6 +1631,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct branch_info *new_branch_info)
 {
 	int parseopt_flags = 0;
+	char *check_branch_path = NULL;
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1741,6 +1743,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
 					     new_branch_info, opts, &rev);
+		check_branch_path = xstrdup_or_null(new_branch_info->path);
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1753,8 +1756,18 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 						      opts, &rev,
 						      opts->from_treeish);
 
+		check_branch_path = xstrdup_or_null(new_branch_info->path);
 		if (!opts->source_tree)
 			die(_("reference is not a tree: %s"), opts->from_treeish);
+	} else if (opts->new_branch && !opts->ignore_other_worktrees) {
+		struct object_id rev;
+
+		if (!get_oid_mb(opts->new_branch, &rev)) {
+			struct strbuf buf = STRBUF_INIT;
+			strbuf_branchname(&buf, opts->new_branch, INTERPRET_BRANCH_LOCAL);
+			strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
+			check_branch_path = strbuf_detach(&buf, NULL);
+		}
 	}
 
 	if (argc) {
@@ -1818,10 +1831,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		strbuf_release(&buf);
 	}
 
-	if (opts->patch_mode || opts->pathspec.nr)
+	if (opts->patch_mode || opts->pathspec.nr) {
+		free(check_branch_path);
 		return checkout_paths(opts, new_branch_info);
+	}
 	else
-		return checkout_branch(opts, new_branch_info);
+		return checkout_branch(opts, new_branch_info, check_branch_path);
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..a66f9bb30c 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -121,7 +121,10 @@ test_expect_success '"add" worktree creating new branch' '
 test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
-		test_must_fail git checkout newmain
+		test_must_fail git checkout newmain &&
+		test_must_fail git checkout -B newmain &&
+		test_must_fail git switch newmain &&
+		test_must_fail git switch -C newmain
 	)
 '
 
@@ -143,7 +146,18 @@ test_expect_success 'not die the same branch is already checked out' '
 test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
-		git checkout newmain
+		git checkout newmain &&
+		git switch newmain
+	)
+'
+
+test_expect_success 'but die if using force without --ignore-other-worktrees' '
+	(
+		cd there &&
+		test_must_fail git checkout -B newmain &&
+		test_must_fail git switch -C newmain &&
+		git checkout --ignore-other-worktrees -B newmain &&
+		git switch --ignore-other-worktrees -C newmain
 	)
 '
 
-- 
2.37.1 (Apple Git-137.1)

