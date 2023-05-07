Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C9D0C77B7C
	for <git@archiver.kernel.org>; Sun,  7 May 2023 03:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjEGDqB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 23:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEGDp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 23:45:58 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C5A35AE
        for <git@vger.kernel.org>; Sat,  6 May 2023 20:45:57 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f423ac6e2dso180075e9.2
        for <git@vger.kernel.org>; Sat, 06 May 2023 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683431155; x=1686023155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6GjrErlaIuZtE+byzqGC8PHXX+f2pm3wQZrzQOnH5Qo=;
        b=dVwhRobkAxZH1TtJadNopfifANmTtVWJuGvfQKFZ21vjqSjYXACuHSlIuMLHH/T/3b
         09A8PCYPxsDbFXRm6Gyhk4S1Bg3OH91XiN1tfn032GfQ8ZITfdhXQQxXdwnOg06q8FwZ
         TTQVF+jayayB2FCxWtXdxJBj30Y0JtU6vekL90d2KFSN5CuqySz6aD47eAc2s+IHDYEv
         Mk39bn0Zo5Y0uP0kdBAkI2VJhvPa2O2dWVmDBvcsgBChw8P68p7iviPTgiFTA+EJIg87
         wj0dJuKYM7d6UOgh/iVAWgASURlyxNeVzWuUPNVx7JXNd0hLg98OB2uB4Fu2Nfi0DOuu
         r5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683431155; x=1686023155;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6GjrErlaIuZtE+byzqGC8PHXX+f2pm3wQZrzQOnH5Qo=;
        b=WsnqAALG65Azg/UaQFdhGz3te5iuvNanKKMJuTt3zRatQcAP+eOh4L+uHh/TmABVQV
         N85ZNC+QID3RO7RD0Ex/xyFDkjy8+tVlO1Oy0XQ37UfDMPsNtXlVEpenBj3UHd9riwzW
         b/SaMKqyreTvp0BVhFE28H5cPBtJwEx9qcbST7lcQ3vylf6zi+B1r4lN0WMi21RhbgTo
         MRh+olcDncuE3WQBZmCqm0gP7O6F68/bkPv6vOZu5bXPqzHwLph05j8YijXywMt2DDXj
         IgLUemIfQqY7bVDJCF4t1odiF6fwVBa7cOVHlA+MIuO3KouDaDlJeE6ydEzTF1zWPa9O
         2K5w==
X-Gm-Message-State: AC+VfDws6ShoWXetGNKXu17QfvZihiifXRwMqK0p86wb+7a1JkqfJIT+
        2MvsTJBUMdSplpOElGU/VLH1Wz5iusc=
X-Google-Smtp-Source: ACHHUZ5keG4klVFRgLKNWJ0hzLWE21GeQU1M+68W/emeqk+pC0Nc1POVHoUYRk0WyPpjDMKXTJjwbw==
X-Received: by 2002:a5d:4b06:0:b0:2f6:b273:a2fa with SMTP id v6-20020a5d4b06000000b002f6b273a2famr4176859wrq.34.1683431155358;
        Sat, 06 May 2023 20:45:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a6-20020a1cf006000000b003f0aefcc457sm12480909wmb.45.2023.05.06.20.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 20:45:55 -0700 (PDT)
Message-Id: <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
References: <pull.1525.git.1683431149.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 May 2023 03:45:26 +0000
Subject: [PATCH 01/24] init-db: remove unnecessary global variable & document
 existing bug
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This commit was prompted by a desire to move the functions which
builtin/init-db.c and builtin/clone.c share out of the former file and
into setup.c.  One issue that made it difficult was the
init_is_bare_repository global variable.

init_is_bare_repository is actually not very useful.  It merely stores
the return value from is_bare_repository() and only for the duration of
a few additional function calls before its value is checked, and none of
those functions do anything that could change is_bare_repository()'s
return value.  So, we can simply dispense with the global by replacing
it with is_bare_repository().

However, the intervening code does talk about reading config from the
config file in the specified `--templates` directory, so touching this
code does lead to the question of whether core.bare could be set in such
a config file and thus whether the code is doing the right thing.  Long
story short is that the templates directory might have a config file
with core.bare set, but it has always been unconditionally ignored.
While fixing that might be nice, it looks to be a can of worms, and
cannot be fixed within this function anyway.  Instead of opening that
can of worms, document the problem with a TODO comment and a couple
test_expect_failure testcases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/init-db.c        | 20 ++++++++++++++++----
 t/t1301-shared-repo.sh   | 22 ++++++++++++++++++++++
 t/t5606-clone-options.sh | 10 ++++++++++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/builtin/init-db.c b/builtin/init-db.c
index aef40361052..18733ef05aa 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -31,7 +31,6 @@
 
 #define GIT_DEFAULT_HASH_ENVIRONMENT "GIT_DEFAULT_HASH"
 
-static int init_is_bare_repository = 0;
 static int init_shared_repository = -1;
 
 static void copy_templates_1(struct strbuf *path, struct strbuf *template_path,
@@ -231,9 +230,24 @@ static int create_default_files(const char *template_path,
 	 * We must make sure command-line options continue to override any
 	 * values we might have just re-read from the config.
 	 */
-	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
 	if (init_shared_repository != -1)
 		set_shared_repository(init_shared_repository);
+	/*
+	 * TODO: heed core.bare from config file in templates if no
+	 *       command-line override given
+	 *
+	 * Unfortunately, this location in the code is far too late to
+	 * allow this to happen; both builtin/init.db and
+	 * builtin/clone.c setup the new repository and call
+	 * set_git_work_tree() before this point.  (Note that both do
+	 * that repository setup before calling init_db(), which in
+	 * turn calls create_default_files().)  Fixing it would
+	 * require too much refactoring, and no one seems to have
+	 * wanted this behavior in 15+ years, so we'll continue
+	 * ignoring the config for now and just override
+	 * is_bare_repository_cfg unconditionally.
+	 */
+	is_bare_repository_cfg = is_bare_repository() || !work_tree;
 
 	/*
 	 * We would have created the above under user's umask -- under
@@ -422,8 +436,6 @@ int init_db(const char *git_dir, const char *real_git_dir,
 
 	safe_create_dir(git_dir, 0);
 
-	init_is_bare_repository = is_bare_repository();
-
 	/* Check to see if the repository version is right.
 	 * Note that a newly created repository does not have
 	 * config file, so this will not fail.  What we are catching
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

