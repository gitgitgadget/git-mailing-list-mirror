Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D612FECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiH3Svf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiH3Suy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 334DA52FE4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:41 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so6672650wmb.4
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=2Kg7YV2cLc0sPso95VWf/nMyuinQpxkpBHDw1baPYHk=;
        b=DSHFG8MxgmzC7Zh9R5uBfteCuidvC6GdcxLQDDdqxwsaYVkt5z7zFqZ3qPtg2Tk9jH
         dCbGqnzjBXEq69li0hbjeqYZxvzZ59htviLWFEMOgyuecyYqlrYg69SmkopibO3A/YeI
         LkxecApK9AN5RmNdQ6mYPQpITV71QPu0/yI/Ii/D6ILryhZaFP3QDSfVq5o/CgaFmBXl
         6pXmyVOMMBPBEoun1m6f6cnuIWfAKfbe+YbHV+7u2d02dZKpFwu5yI/BHZDVGUG0Rqie
         wmhBiaP1eUcjyosuXcu9Uc6sLiogfQLlNE5C7518xdc7oiqThMsSdfFFglpfoX8muebr
         7Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=2Kg7YV2cLc0sPso95VWf/nMyuinQpxkpBHDw1baPYHk=;
        b=LfMn2s7Ep7HHcDQhhuiuaR6HYO3hGKajmxeOq5nLi6TdW+j0/t/9mq0jJLojdqt0oD
         HiArta0iVD2vAs8W33cwaMeFpELDg3240q/CTFuH4UBS5fjJiKONriEglHf0MHNe8ooa
         ymHt5JRPvdxcBEx9wPGYQ1LLYE7Yc11/Y8hu4b8qdNfO968Zq/wsr2Ehqdr/Pnei75mb
         v4nbizr4xFPjjBmLSL8Gag5kFOWqHFLxDYhG/a0YvmKYcMS5I3Di+2hHYH6YbY+i+g3/
         Ejlcaf7CdUKw2SsTL+TDFok+y8qLkIKQaead0d2cqzM98Q1+SmoGdEkif/yqtsZujfGy
         hhFQ==
X-Gm-Message-State: ACgBeo3w9VUBVYykeywg3Rjfox9hM5mERmWWAKY9OGae97ga7z0GVSHf
        +85MYf66jIv3iAop6ON0ByyH9oPX/8g=
X-Google-Smtp-Source: AA6agR51wXfJ34fuOWPk6g07jC601Hc+9UaZU5EWxLxWMR2zji3MZ9I9hQy4DG7Wdv5VfD5JzbZU7A==
X-Received: by 2002:a1c:3842:0:b0:3a6:8c16:e239 with SMTP id f63-20020a1c3842000000b003a68c16e239mr10750776wma.80.1661885439447;
        Tue, 30 Aug 2022 11:50:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q3-20020adff943000000b0021efc75914esm10424244wrr.79.2022.08.30.11.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:38 -0700 (PDT)
Message-Id: <4f93692e071cf316fd391344b5dbbc995c162232.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:19 +0000
Subject: [PATCH v6 16/16] bisect: no longer try to clean up left-over
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
