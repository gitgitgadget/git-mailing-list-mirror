Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F6C433F5
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 14:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242105AbhK3ORp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 09:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbhK3ORj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 09:17:39 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8FFC06174A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:14:19 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i5so44760604wrb.2
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 06:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yGRRYQzEVzjy3h0CZFiNBgbb6cyRWhxcsQ3SK7vh6RI=;
        b=aWEiu74uuCLJF92PEF4z3JvwEAI6ITe76/AWx4Io6GQ5buMyMGNrSemwTNiE9CvI22
         eS54OMLCScciUd5VHtBdoSz4HBVki/5Ir87rFkDsiZTKP2JbvDxeUD093okCO59TlvRx
         jfuw1gu3ce/1KXW2lWeEAhLWplBfeajtTzlskqY/ky6YQhRTpm4iFB8y5ZAYDKRYSDiu
         dYe2YICpEJdX+GyVEgmIL0reQohudXPXh2Ge9HkSVFA/aIfh2ut5TUmaWME44Ltjeggj
         XtepmHxlIUQF9kQzqA3xtWYE9qeOTlKFaV6KwtI+QvcbY4KtJ+XI7nQix/YZQ6llKqcK
         zs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yGRRYQzEVzjy3h0CZFiNBgbb6cyRWhxcsQ3SK7vh6RI=;
        b=X1GFTwDNEAJUJ8h7l3tM2+CmsG9WqodeTrBfSrv+v3n2G/S/yaJqkjw0nzIENmt+bE
         vLKykNvFP0jPSlQCOi8i+Jjy+zhNy0oAVj5Rd3/2nxDdS9OIzRKhBbYR5LEtVgDfY5eD
         fpT/0em9WfD4Bll1s4K2sOdD8zunr74TOYfWrYy3vGIIjuMPy21dgZMpJK0F50zMMLL/
         ln1+yL0YinRzagKePaXlHxY8PlKMqPgxRXAQN6MJuNM69qJZ325AKhYXZGwYSuqD2/bN
         s77/Hzz2b37m7sLfHg+NjdvGqVsRsSMqbGVZwpJX1Zl9fCTIjY/Zo45E8VguBjsYxCd3
         kbOw==
X-Gm-Message-State: AOAM532OopzFKl02mLAdZraDYuBLzGIrBfQJI0eaKSbsfJ9acBJ3ZqUi
        ETGADNOvkSO9wKv4FPXwyC1Yg4jQrSQ=
X-Google-Smtp-Source: ABdhPJzrSz+ZD4ihUL92RJUFl5isvkL86fk4abbLc4Mza3zJv/ZzyDWM+Kxcma3Y/sB6iahXB+Y1pQ==
X-Received: by 2002:adf:e68f:: with SMTP id r15mr40203555wrm.359.1638281658058;
        Tue, 30 Nov 2021 06:14:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j40sm2751116wms.19.2021.11.30.06.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 06:14:17 -0800 (PST)
Message-Id: <84824918ae4564a9194a1a55124ee8694f210437.1638281655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
References: <pull.1087.git.1638281655.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Nov 2021 14:14:15 +0000
Subject: [PATCH 2/2] add -i: default to the built-in implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Slavica =?UTF-8?Q?=C4=90uki=C4=87?= <slawica92@hotmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 9a5315edfdf (Merge branch 'js/patch-mode-in-others-in-c',
2020-02-05), Git acquired a built-in implementation of `git add`'s
interactive mode that could be turned on via the config option
`add.interactive.useBuiltin`.

The first official Git version to support this knob was v2.26.0.

In 2df2d81ddd0 (add -i: use the built-in version when
feature.experimental is set, 2020-09-08), this built-in implementation
was also enabled via `feature.experimental`. The first version with this
change was v2.29.0.

More than a year (and very few bug reports) later, it is time to declare
the built-in implementation mature and to turn it on by default.

We specifically leave the `add.interactive.useBuiltin` configuration in
place, to give users an "escape hatch" in the unexpected case should
they encounter a previously undetected bug in that implementation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/add.txt |  6 +++---
 builtin/add.c                | 15 +++++----------
 ci/run-build-and-tests.sh    |  2 +-
 t/README                     |  2 +-
 t/t2016-checkout-patch.sh    |  2 +-
 5 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/add.txt b/Documentation/config/add.txt
index c9f748f81cb..3e859f34197 100644
--- a/Documentation/config/add.txt
+++ b/Documentation/config/add.txt
@@ -7,6 +7,6 @@ add.ignore-errors (deprecated)::
 	variables.
 
 add.interactive.useBuiltin::
-	[EXPERIMENTAL] Set to `true` to use the experimental built-in
-	implementation of the interactive version of linkgit:git-add[1]
-	instead of the Perl script version. Is `false` by default.
+	Set to `false` to fall back to the original Perl implementation of
+	the interactive version of linkgit:git-add[1] instead of the built-in
+	version. Is `true` by default.
diff --git a/builtin/add.c b/builtin/add.c
index ef6b619c45e..8ef230a345b 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -237,17 +237,12 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	int use_builtin_add_i =
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
 
-	if (use_builtin_add_i < 0) {
-		int experimental;
-		if (!git_config_get_bool("add.interactive.usebuiltin",
-					 &use_builtin_add_i))
-			; /* ok */
-		else if (!git_config_get_bool("feature.experimental", &experimental) &&
-			 experimental)
-			use_builtin_add_i = 1;
-	}
+	if (use_builtin_add_i < 0 &&
+	    git_config_get_bool("add.interactive.usebuiltin",
+				&use_builtin_add_i))
+		use_builtin_add_i = 1;
 
-	if (use_builtin_add_i == 1) {
+	if (use_builtin_add_i != 0) {
 		enum add_p_mode mode;
 
 		if (!patch_mode)
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index cc62616d806..660ebe8d108 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -29,7 +29,7 @@ linux-gcc)
 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
 	export GIT_TEST_MULTI_PACK_INDEX=1
 	export GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=1
-	export GIT_TEST_ADD_I_USE_BUILTIN=1
+	export GIT_TEST_ADD_I_USE_BUILTIN=0
 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
 	export GIT_TEST_WRITE_REV_INDEX=1
 	export GIT_TEST_CHECKOUT_WORKERS=2
diff --git a/t/README b/t/README
index 29f72354bf1..2c22337d6e7 100644
--- a/t/README
+++ b/t/README
@@ -419,7 +419,7 @@ the --sparse command-line argument.
 GIT_TEST_PRELOAD_INDEX=<boolean> exercises the preload-index code path
 by overriding the minimum number of cache entries required per thread.
 
-GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when true, enables the
+GIT_TEST_ADD_I_USE_BUILTIN=<boolean>, when false, disables the
 built-in version of git add -i. See 'add.interactive.useBuiltin' in
 git-config(1).
 
diff --git a/t/t2016-checkout-patch.sh b/t/t2016-checkout-patch.sh
index 71c5a15be00..bc3f69b4b1d 100755
--- a/t/t2016-checkout-patch.sh
+++ b/t/t2016-checkout-patch.sh
@@ -4,7 +4,7 @@ test_description='git checkout --patch'
 
 . ./lib-patch-mode.sh
 
-if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN false && ! test_have_prereq PERL
+if ! test_bool_env GIT_TEST_ADD_I_USE_BUILTIN true && ! test_have_prereq PERL
 then
 	skip_all='skipping interactive add tests, PERL not set'
 	test_done
-- 
gitgitgadget
