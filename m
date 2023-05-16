Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943DBC77B75
	for <git@archiver.kernel.org>; Tue, 16 May 2023 06:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjEPGe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 May 2023 02:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbjEPGeY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2023 02:34:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1A21FFF
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:21 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-306281edf15so12936730f8f.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684218860; x=1686810860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JV2g52nHkEGLslr8QmsykAvFXscZR0Jgzoc2KzZfxW0=;
        b=N8anYhfLt5Z12Pflw3RoFDTDf1JlH0051hbt0KtXwKdWABcXPYNSVsvJuggmaOVgK8
         SNMl5qyaf2B0DhhyIZPbQ0D6nA2yA9aGHBi/VZNr6M0aUX+6Y7wFru1TerhbBnG9IJhX
         ir4aHmCXqu8HtTNF9f8K1bJItbxqJiqUm7bhH0GinwsdR8JQuHkadk5FebCUqNnQcGEe
         +WqqPV7ipyLWg/PzDiWYGFqtg32EHZaSS5oCuZH1axbX4brwP+tNgey9AKzNeE79ZXuB
         V3njecWBzOTQz0HQeeLWswVnuaDG5He9IqrsP/OsKE9BstQB2mrOXcrrw5bcONF5kx2A
         6ERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684218860; x=1686810860;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JV2g52nHkEGLslr8QmsykAvFXscZR0Jgzoc2KzZfxW0=;
        b=X68AHuTGD4nxwus3fVtxlxd0OTflwq/aJiihQz62r0YcFEMKs4YOiZfEit/Ap/0dL3
         0fzXRHPt3QqkEipkRFZoLArBDeqB6z+Ajn5BQEfhc/nvlxrdGSK5r3/KaTIs/a7PsNf2
         STKMsk0E2q0fRTHsWb/fZGoiOFnyR+Lw52Zx3Gd9VjEoJomtNNpvpl+FOCcAW1xtBGpf
         Ppb2+QCz5yHf9281aIjzfGpIQBv5dPnx0feHSuk4UNUdlS8XjP+sDWzNYNJcGMIoEdf4
         JhVTD+qQQKtsm6Br6IenM1gg7EJl7V0GtPxCrYRYXTZLplqikO6jcPdoT2clFWcTsHuf
         5aMg==
X-Gm-Message-State: AC+VfDxsKKQzD0Lfgx/CGji5+UjRNSHc8Wj95ptP6IaXEsPc5tRcTPp6
        zFuDVLvJbG489AdgIw/IZqgOOkkjMao=
X-Google-Smtp-Source: ACHHUZ5hgnA/QQCO6TQkWZvZBpRSTAX5qE6YgV5DoL8cVCeb3CQrWKIVAzkQpU/oJJ2g/Uud6bOL4A==
X-Received: by 2002:a5d:4004:0:b0:301:8551:446a with SMTP id n4-20020a5d4004000000b003018551446amr26707901wrp.2.1684218859516;
        Mon, 15 May 2023 23:34:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d4108000000b003077f3dfcc8sm1404495wrp.32.2023.05.15.23.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 23:34:19 -0700 (PDT)
Message-Id: <5b39c530f2a0edf3b1492fa13a1132d622a0678e.1684218850.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
References: <pull.1525.v2.git.1683875068.gitgitgadget@gmail.com>
        <pull.1525.v3.git.1684218848.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 May 2023 06:33:41 +0000
Subject: [PATCH v3 01/28] init-db: document existing bug with core.bare in
 template config
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>, Jeff King <peff@peff.net>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
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
index aef40361052..87a7021c3ca 100644
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
+	 * expanding the right hand side:
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

