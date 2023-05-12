Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F55C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 07:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbjELHE5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 03:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239968AbjELHEm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 03:04:42 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34ED65B9
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-307d58b3efbso411301f8f.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683875079; x=1686467079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpqZ2sQMAdg06dr+THRbqUeL26JH5GsqiyjOxvJSsr8=;
        b=qPvvfcPN1xB7L74tUZDYPRg6ZcMpjGa2rRy9iRfwirQDiKg9oI47WjaSbXfre8ujQc
         vjbatUsxGFlaDSzw7OE1ygSBC5gGlllh2siFZaTH2TuC/2IZIESSvN4ZKHBTDZE5DzWm
         18iaVlsjF995YB2I05efNyHY9XzLmaBMnGTnWm2nTjH1Hb7Sue6baak6xmSi3yP66oiM
         Mg5R6Ww020C2yoweLEa05Nrm4G+qbJdQG/Nd1QjviYUkIwO8P4jaj6t5uS4sar6HemEK
         qC6462rX6QsO5EPrJpSLJBRBxIUUOZqhKBcGJ7OaUtZkKdKalsRwU+NB9rkrAqGPHugs
         WRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683875079; x=1686467079;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpqZ2sQMAdg06dr+THRbqUeL26JH5GsqiyjOxvJSsr8=;
        b=cTUAsaaZNxmzhpMDrlzIwIjTz5DJdr4IPj4SmJOcEOZ1uUxABn7Yq2yR0ggpTJ1F3n
         wALuI3jW6C+52OnIq/UG2gz5H5jWCUD7nkTCQ8aHvba6fz8xiL9sv+8l9XCAydi385Ub
         xXJLFlRdQS11PRg12LQz+hwaUgUU9nVzlBzb1BQC6oe7x9h9uswXtQhuWIDc7nRu85dG
         u5MbF4T6S8R0P3OYmmGfQU2nGT9w6BA7VdJoLyEbCtamf/aJtuPFRsKsMicoSGlBfq/s
         MiBGyRNqMaax841YCf24fELCQLskZ8HH230wFNUfm8KdWq/xjJVStMcMYck7XgdPNf+8
         g/Ew==
X-Gm-Message-State: AC+VfDyvoM5h+JzqDSiV7tkm7Hy4bpvXk8iZb8fvlDvKCVRlIYwcnH/B
        9qk80pSRNO1UoBoPmQ/Dw4sQvOpCqTo=
X-Google-Smtp-Source: ACHHUZ4W8ey8pa5jf5umZZ2BT3oBDkBBwxLs+YEPszeo6iz0FaZRd0e+3c0ZUgdgA9C2yy9LZX4FCA==
X-Received: by 2002:adf:f04b:0:b0:2ee:da1c:381a with SMTP id t11-20020adff04b000000b002eeda1c381amr16560020wro.69.1683875078857;
        Fri, 12 May 2023 00:04:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003f1958eeadcsm9482398wmj.17.2023.05.12.00.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 00:04:38 -0700 (PDT)
Message-Id: <f7ee69e7e687e8cbdead070df644c5bca23d7578.1683875070.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
        <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 07:04:02 +0000
Subject: [PATCH v2 01/27] init-db: document existing bug with core.bare in
 template config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The comments in create_default_files() talks about reading config from
the config file in the specified `--templates` directory, which leads to
the question of whether core.bare could be set in such a config file and
thus whether the code is doing the right thing.  It turns out, that it
doesn't; it unconditionally ignores core.bare in the config file in any
--templates directory.  It is not clear to me that fixing it can be done
within this function; it seems to occur too late:
  * create_default_files() is called by init_db()
  * init_db() is called by both builtin/{clone.c,init-db.c}
  * both callers of init_db() call set_git_work_tree() before init_db()
and in order to actual affect whether a repository is bear, we'd need to
somewhere reset these values, not just the is_bare_repository_cfg
setting.

I do not want to open this can of worms at this time; I'm trying to
clean up some headers, for which I need to move some functions, for
which I need to clean up some globals, and that's far enough down the
rabbit hole.  So, simply document the issue with a careful TODO comment
and a few testcases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/init-db.c        | 29 ++++++++++++++++++++++++++++-
 t/t1301-shared-repo.sh   | 22 ++++++++++++++++++++++
 t/t5606-clone-options.sh | 10 ++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index aef40361052..715e94befa0 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -231,9 +231,36 @@ static int create_default_files(const char *template_path,
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
 	 */
-	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	/*
+	 * TODO: heed core.bare from config file in templates if no
+	 *       command-line override given
+	 */
+	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
+	/* TODO (continued):
+	 *
+	 * Unfortunately, the line above is equivalent to
+	 *    is_bare_repository_cfg = !work_tree;
+	 * which ignores the config entirely even if no `--[no-]bare`
+	 * command line option was present.
+	 *
+	 * To see why, note that before this function, there was this call:
+	 *    init_is_bare_repository = is_bare_repository()
+	 * expanding the right hande side:
+	 *                 = is_bare_repository_cfg && !get_git_work_tree()
+	 *                 = is_bare_repository_cfg && !work_tree
+	 * note that the last simplification above is valid because nothing
+	 * calls repo_init() or set_git_work_tree() between any of the
+	 * relevant calls in the code, and thus the !get_git_work_tree()
+	 * calls will return the same result each time.  So, what we are
+	 * interested in computing is the right hand side of the line of
+	 * code just above this comment:
+	 *     init_is_bare_repository || !work_tree
+	 *        = is_bare_repository_cfg && !work_tree || !work_tree
+	 *        = !work_tree
+	 * because "A && !B || !B == !B" for all boolean values of A & B.
+	 */
 
 	/*
 	 * We would have created the above under user's umask -- under
diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 1b6437ec079..c02fd64793b 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -52,6 +52,28 @@ test_expect_success 'shared=all' '
 	test 2 = $(git config core.sharedrepository)
 '
 
+test_expect_failure 'template can set core.bare' '
+	test_when_finished "rm -rf subdir" &&
+	test_when_finished "rm -rf templates" &&
+	test_config core.bare true &&
+	umask 0022 &&
+	mkdir -p templates/ &&
+	cp .git/config templates/config &&
+	git init --template=templates subdir &&
+	test_path_exists subdir/HEAD
+'
+
+test_expect_success 'template can set core.bare but overridden by command line' '
+	test_when_finished "rm -rf subdir" &&
+	test_when_finished "rm -rf templates" &&
+	test_config core.bare true &&
+	umask 0022 &&
+	mkdir -p templates/ &&
+	cp .git/config templates/config &&
+	git init --no-bare --template=templates subdir &&
+	test_path_exists subdir/.git/HEAD
+'
+
 test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository' '
 	: > a1 &&
 	git add a1 &&
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index 27f9f776389..5890319b97b 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -120,6 +120,16 @@ test_expect_success 'prefers -c config over --template config' '
 
 '
 
+test_expect_failure 'prefers --template config even for core.bare' '
+
+	template="$TRASH_DIRECTORY/template-with-bare-config" &&
+	mkdir "$template" &&
+	git config --file "$template/config" core.bare true &&
+	git clone "--template=$template" parent clone-bare-config &&
+	test "$(git -C clone-bare-config config --local core.bare)" = "true" &&
+	test_path_is_file clone-bare-config/HEAD
+'
+
 test_expect_success 'prefers config "clone.defaultRemoteName" over default' '
 
 	test_config_global clone.defaultRemoteName from_config &&
-- 
gitgitgadget

