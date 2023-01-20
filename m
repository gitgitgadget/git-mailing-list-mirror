Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF24C05027
	for <git@archiver.kernel.org>; Fri, 20 Jan 2023 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjATLgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Jan 2023 06:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjATLgL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2023 06:36:11 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790E8537A
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 03:36:09 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z20so3100949plc.2
        for <git@vger.kernel.org>; Fri, 20 Jan 2023 03:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1FZ+0BdZgXnWL6pJXbcOJS4gEey0byk6S2JHxwoB/8=;
        b=h0GRJ6oqrJ4Rifgy2O7RieJxpq3iAURZuHgErtil1vDxF6TYZnhGXohJXML805DL93
         5cF1c9XiM3ta2poCniCWFVdWAGh46nezczqSvEElHnmiA0ut987fTEenQZrwEniY4VI0
         kxRTAcrsokvzqhFZgOO50ourHsy5idynkJUobvMQCnj0WHYU6QqgmQaVAETI0WQd8RZ6
         GOvGTZYlGIlgVEY81WER/dNWUbWyCvGfaOacvVavUBWtg3XjiV+N/uCQvpDTQb8r/Ctq
         YhYUmZnzNA7SVuKvzpHKKO/dsqmB7IC3g11W5nWxDZdIOr0I7y7ammuHyATi/zISnjcT
         0wCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1FZ+0BdZgXnWL6pJXbcOJS4gEey0byk6S2JHxwoB/8=;
        b=Pa/p7WdoRKAO28VccBn0b1kM+GqrHw9rMwdZjumi4CVP7kKJqb8kwNQGLTg5QLlUoH
         4L/rSPzp/tsHJ2fKvnB+xgafrWbJliG3axThoBuYMIqvGCY8oxbX65IiLhiTxnKBoMGd
         qMNPNfB2UIaaAIUS9gMXmaKLaS3UM4BMbngtLx8JobdB3xhXc//PcOSsuH5oJ+W3yXaG
         TbzT2n5ywWrnpGn9C7gbJ0H1SCHWzxRwWj1nTQXslnyQAVae1Dj0acwbUKb6/i94eP/m
         QqjKrkLi6MH3Mu3ShscsAdHi9oHgN3oImS2ws83ymwsP//pJ7cTZt1sHiUO2CGJj5nuG
         aXCw==
X-Gm-Message-State: AFqh2kqXyv7XNj8+wBSfzw4TX6ZPhTLQ6TPMWDMZmks4tq6YqhNzvhYD
        +nseDrfDhFJHVG9bW/HTNTEZgQIHdko=
X-Google-Smtp-Source: AMrXdXulcPU5R8yKbE8gyS8RpICuEbjbFL0wWva3vMlHbEcp+ZIeSJ8Vipqzm+to9EU02qG/17NAtA==
X-Received: by 2002:a17:90a:f612:b0:225:e88c:33c2 with SMTP id bw18-20020a17090af61200b00225e88c33c2mr15264783pjb.7.1674214568088;
        Fri, 20 Jan 2023 03:36:08 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id h1-20020a17090ac38100b0022908f1398dsm1296425pjt.32.2023.01.20.03.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 03:36:07 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jinwook Jeong <vustthat@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v4] checkout/switch: disallow checking out same branch in multiple worktrees
Date:   Fri, 20 Jan 2023 03:35:53 -0800
Message-Id: <20230120113553.24655-1-carenas@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230119055325.1013-1-carenas@gmail.com>
References: <20230119055325.1013-1-carenas@gmail.com>
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
check whether the branch in question is already checked out elsewhere.

Unlike what it is done for `git switch` and `git checkout`, that have
an historical exception to ignore other worktrees if the branch to
check is the current one (as required when called as part of other
tools), the logic implemented is more strict and will require the user
to invoke the command with `--ignore-other-worktrees` to explicitly
indicate they want the risky behaviour.

This matches the current behaviour of `git branch -f` and is safer; for
more details see the tests in t2400.

Reported-by: Jinwook Jeong <vustthat@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Rubén Justo <rjusto@gmail.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v3
* Code and Tests improvements as suggested by Phillip
* Disable unreliable test that triggers a known bug

Changes since v2
* A leak free implementation
* More details in commit as suggested by Junio

Changes since v1
* A much better commit message
* Changes to the tests as suggested by Eric
* Changes to the logic as suggested by Rubén


 builtin/checkout.c      | 32 ++++++++++++++++++++++++--------
 t/t2400-worktree-add.sh | 34 +++++++++++++++++++++++++++-------
 2 files changed, 51 insertions(+), 15 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3fa29a08ee..0688652f99 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1474,7 +1474,8 @@ static void die_if_some_operation_in_progress(void)
 }
 
 static int checkout_branch(struct checkout_opts *opts,
-			   struct branch_info *new_branch_info)
+			   struct branch_info *new_branch_info,
+			   char *check_branch_path)
 {
 	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
@@ -1533,13 +1534,13 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (!opts->can_switch_when_in_progress)
 		die_if_some_operation_in_progress();
 
-	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
-	    !opts->ignore_other_worktrees) {
+	if (!opts->ignore_other_worktrees && !opts->force_detach &&
+	    check_branch_path && ref_exists(check_branch_path)) {
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
 
@@ -1627,7 +1628,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			 const char * const usagestr[],
 			 struct branch_info *new_branch_info)
 {
+	int ret;
 	int parseopt_flags = 0;
+	char *check_branch_path = NULL;
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1717,6 +1720,13 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 		opts->new_branch = argv0 + 1;
 	}
 
+	if (opts->new_branch && !opts->ignore_other_worktrees) {
+		struct strbuf buf = STRBUF_INIT;
+
+		strbuf_branchname(&buf, opts->new_branch, INTERPRET_BRANCH_LOCAL);
+		strbuf_splice(&buf, 0, 0, "refs/heads/", 11);
+		check_branch_path = strbuf_detach(&buf, NULL);
+	}
 	/*
 	 * Extract branch name from command line arguments, so
 	 * all that is left is pathspecs.
@@ -1741,6 +1751,9 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 					     new_branch_info, opts, &rev);
 		argv += n;
 		argc -= n;
+
+		if (!opts->ignore_other_worktrees && !check_branch_path && new_branch_info->path)
+			check_branch_path = xstrdup(new_branch_info->path);
 	} else if (!opts->accept_ref && opts->from_treeish) {
 		struct object_id rev;
 
@@ -1817,9 +1830,12 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	}
 
 	if (opts->patch_mode || opts->pathspec.nr)
-		return checkout_paths(opts, new_branch_info);
+		ret = checkout_paths(opts, new_branch_info);
 	else
-		return checkout_branch(opts, new_branch_info);
+		ret = checkout_branch(opts, new_branch_info, check_branch_path);
+
+	free(check_branch_path);
+	return ret;
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..7ab7e87440 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -118,14 +118,17 @@ test_expect_success '"add" worktree creating new branch' '
 	)
 '
 
-test_expect_success 'die the same branch is already checked out' '
+test_expect_success 'die if the same branch is already checked out' '
 	(
 		cd here &&
-		test_must_fail git checkout newmain
+		test_must_fail git checkout newmain &&
+		test_must_fail git checkout -B newmain &&
+		test_must_fail git switch newmain &&
+		test_must_fail git switch -C newmain
 	)
 '
 
-test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
+test_expect_success SYMLINKS 'die if the same branch is already checked out (symlink)' '
 	head=$(git -C there rev-parse --git-path HEAD) &&
 	ref=$(git -C there symbolic-ref HEAD) &&
 	rm "$head" &&
@@ -133,17 +136,34 @@ test_expect_success SYMLINKS 'die the same branch is already checked out (symlin
 	test_must_fail git -C here checkout newmain
 '
 
-test_expect_success 'not die the same branch is already checked out' '
+test_expect_success 'allow creating multiple worktrees for same branch with force' '
+	git worktree add --force anothernewmain newmain
+'
+
+test_expect_success 'allow checkout/reset from the conflicted branch' '
 	(
 		cd here &&
-		git worktree add --force anothernewmain newmain
+		git checkout -b conflictedmain newmain &&
+		git checkout -B conflictedmain newmain &&
+		git switch -C conflictedmain newmain
+	)
+'
+
+test_expect_success 'and not die on re-checking out current branch even if conflicted' '
+	(
+		cd there &&
+		git checkout newmain &&
+		git switch newmain
 	)
 '
 
-test_expect_success 'not die on re-checking out current branch' '
+test_expect_failure 'unless using force without --ignore-other-worktrees' '
 	(
 		cd there &&
-		git checkout newmain
+		test_must_fail git checkout -B newmain &&
+		test_must_fail git switch -C newmain &&
+		git checkout --ignore-other-worktrees -B newmain &&
+		git switch --ignore-other-worktrees -C newmain
 	)
 '
 
-- 
2.37.1 (Apple Git-137.1)

