Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DAC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiF0ShM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239636AbiF0Sgb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 14:36:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2782418E05
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so6154986wmb.5
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 11:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2Kg7YV2cLc0sPso95VWf/nMyuinQpxkpBHDw1baPYHk=;
        b=Rk9zvJSy5oY5EJpcsJQ83GfqUQgDtjs6K/ceAVlNZLK6CctiVcAdRA/wEO1ypxNAck
         AW2bSZ8VTM6yz06jTQQvkRm+6Bv7+WrpbtnG3jSVDqRb/sSjrF+fbQJ38lcnF+Z2Hr2b
         sKbP4UkYOb2f2dgHLgfXLAF/bk+8aOdXOvSWZ8gb/Zy6IQh0P22OohLfh8rLopNc4LA3
         73X5/Si1dUj15j68qZnISlLs+q3PtKy0QdyApb4Y7tBGJSADTXe/CWBV6XPPGsOeFpcq
         zDCF7HgG6yrP3b8fFqtOQx0CUnVm9nBE08N9dmf2g3CLk12TFOzKKn/m69gUsbJSaSdt
         B3hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2Kg7YV2cLc0sPso95VWf/nMyuinQpxkpBHDw1baPYHk=;
        b=tUxTCGNNsTEWzHf84psjUZ/XuB65YpCCmWUouCCpb9dzrOyOkz3GwdWN+kcAzQEMOO
         uj8FZoGPWSjTE+1FBdRLrMk9Z0kwMuh992YEUbgIDaygKvN3//M2DIidTc9wmRrm8OSe
         y42oi3+POHLO4gr1FQ3Fn3WFbhEvE2dZgb2Q1OqN4Jsfw3VoVgIfZMQWREiNRhczdUAI
         D5IVYIjt6ivCKydewaEHTMRoID2ZUJgHsPijUu5NkqCopktT3yFzoihPC+k2ARqHSVUz
         hMsc5PRrddSrxbGf32RhD6FDBKQCbhgnG1g8hm3fUjDKYQkVi+wf1aLbLIyYep/zGPIj
         Ekbg==
X-Gm-Message-State: AJIora9AQ4Y94ZL8jld+HELQk+uUb3L/KZhk8veR+a1REFZD9ZVSQkwc
        XDM51nQ0e199T9uz099x4khDXsQhK61dMA==
X-Google-Smtp-Source: AGRyM1sqeSXsg2Qi5/GbEcbGutFM5UWvKBHSHLGeyvbPfozFXxNaJrAPdAy4dXMUXDfjTWOW5BxepQ==
X-Received: by 2002:a1c:29c1:0:b0:39d:86c0:3ece with SMTP id p184-20020a1c29c1000000b0039d86c03ecemr16743595wmp.138.1656354698455;
        Mon, 27 Jun 2022 11:31:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3-20020adfef03000000b0021bbd525b8esm9454564wro.45.2022.06.27.11.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 11:31:38 -0700 (PDT)
Message-Id: <334664f23a8fa5d3b0df4a00ba9c7c96772ab93b.1656354677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
        <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Jun 2022 18:31:17 +0000
Subject: [PATCH v4 16/16] bisect: no longer try to clean up left-over
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
