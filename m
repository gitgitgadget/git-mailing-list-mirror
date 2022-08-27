Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCAC0502A
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbiH0MrX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbiH0Mo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:56 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA35FCD
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso2125826wmr.3
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=2Kg7YV2cLc0sPso95VWf/nMyuinQpxkpBHDw1baPYHk=;
        b=X1mB6CZwiDKyGoue96TDBcQbaVB81qRvAfMFpjbGWahyoDxbfD973VxmZO8/pkvNzg
         L8SPunMPRgLtZqF2nxzdsQIvFAk+dLajlULf4W7Tflrg9BvcqXTvLGe9cml9BTUF2j0m
         vTy54PjCOJ96WXgfLUh8OV+8roslc06x9NLyyKVTWXaDaOt4jqkGUUQ597lpuViRVZr+
         d/1t5P02ku/BR4/ba5u7n3UCj/a7lmHrTqnSMq+IhQ+8vSE9asAFuyihtSy8uRWVnIAM
         NlXehF6m3vyLJthn9vytSgQE26J5zA0S/WDnw2rmYVpGrYkSWS2FEhWupLUIk7RepcSg
         beZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=2Kg7YV2cLc0sPso95VWf/nMyuinQpxkpBHDw1baPYHk=;
        b=4DBM2wKGhKMdewOD0MNQCITxchvWZ3DbyOk9Jhpf5zzA2BtfYQog0tjzT+OJAZ//wi
         ZNRsvKdC9x1myoh68amBTQRr4/U+AGnBs5ZxgOBVVjfNCWiMIts6uSPmmPzTC5tf3wNT
         Ih6itgB3sOuFXAzOrpXwObaFLmZ27PbCu6PcQ4zgvwI7Xoig05kwTd/pFfetbwJS7IM4
         uuO6xpAR6IS7BGxocD8zcxjohrZq44nZfe23f6b6F2gUGRMqMC3npPPMJZOHSlf2+JGD
         0lXdCImIMtNVmYDVbY+wi2OIxZ4aQB8eOWCZOUBmcwI5twekflqf5rIMALoA6k/oYb6g
         ioFA==
X-Gm-Message-State: ACgBeo3Vemv8rdBd2DjbFghfEMjcReqXXM3n8E2mirwX3jWC0BXT+KO5
        +NFMagYhCPk7aHUk/ErUiO7JU6lwVL4=
X-Google-Smtp-Source: AA6agR76imPlDCkvaJGmzZv7YJ6FUbvzwqEBH4QIOao+Jsvj9DNjZ1B434oJeVG+cT2ilBog3xkLZw==
X-Received: by 2002:a05:600c:2193:b0:3a5:346f:57d0 with SMTP id e19-20020a05600c219300b003a5346f57d0mr2166827wme.124.1661604287553;
        Sat, 27 Aug 2022 05:44:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020a5d58f0000000b0021e42e7c7dbsm2238190wrd.83.2022.08.27.05.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:46 -0700 (PDT)
Message-Id: <bfa7aa19f0313cfee154b3e9157e63dc5ac8f2f6.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:24 +0000
Subject: [PATCH v5 16/16] bisect: no longer try to clean up left-over
 `.git/head-name` files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

As per the code comment, the `.git/head-name` files were cleaned up for
backwards-compatibility: an old version of `git bisect` could have left
them behind.

Now, just how old would such a version be? As of 0f497e75f05 (Eliminate
confusing "won't bisect on seeked tree" failure, 2008-02-23), `git
bisect` does not write that file anymore. Which corresponds to Git
v1.5.4.4.

Even if the likelihood is non-nil that there might still be users out
there who use such an old version to start a bisection, but then decide
to continue bisecting with a current Git version, it is highly
improbable.

So let's remove that code, at long last.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 bisect.c                    | 3 ---
 t/t6030-bisect-porcelain.sh | 1 -
 2 files changed, 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index b63669cc9d7..00bd4ba581c 100644
--- a/bisect.c
+++ b/bisect.c
@@ -474,7 +474,6 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1181,8 +1180,6 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
-	/* Cleanup head-name if it got left by an old version of git-bisect */
-	unlink_or_warn(git_path_head_name());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7a76f204083..1d9cbf229e2 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1000,7 +1000,6 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing ".git/BISECT_LOG" &&
 	test_path_is_missing ".git/BISECT_RUN" &&
 	test_path_is_missing ".git/BISECT_TERMS" &&
-	test_path_is_missing ".git/head-name" &&
 	test_path_is_missing ".git/BISECT_HEAD" &&
 	test_path_is_missing ".git/BISECT_START"
 '
-- 
gitgitgadget
