Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DC3C433EF
	for <git@archiver.kernel.org>; Sat, 21 May 2022 14:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355378AbiEUOt6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 May 2022 10:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355351AbiEUOta (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 May 2022 10:49:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B206D186
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:27 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o12-20020a1c4d0c000000b00393fbe2973dso8307335wmh.2
        for <git@vger.kernel.org>; Sat, 21 May 2022 07:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GteBg2+Y1zMQghDuakrZG4uzNScXheViXbmGzF4Gshc=;
        b=BplVoXOkROFpNcURdNd/i022xi0HOoWbq4ff6GJJgc8Pa+Rz8B2tYJgkRISPCups9m
         0lRULPZ3PORU9pUoEWqYsgkEf3aDrCAO2kC8vn0zYDAOpAthTQs6rllnsGIPiltg9tTE
         S6IeT7CQXYJVZs8y9cIoNfLWyp7Lt7QhdhjWSdewH0hp3ioe/oAthOe4zI/9dlnVhXF7
         bPeoiLWcej0h/bY+4DOOueJnBF3CrshfBZ13hobYB8L6hjeT2Ojl5Krvih2lJO+25HJX
         JZWoalIHWx5BWbqe+Tgh1hsMVCji7kR1y0boF5D/+yb4U1saFgWkFXz+6GnVFVzjgrUa
         Ly0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GteBg2+Y1zMQghDuakrZG4uzNScXheViXbmGzF4Gshc=;
        b=XTxcHKJGDGyUrRHGSjQOknk7CFLU/Fn0uQcRyUYQihTC7DsZc4yyO36H3Fl+8izrjw
         Mq2juKhQWzEc68TbRE4JUFH/v63l3ozstz8dUlL+boBAz9WrU4uAs/GHlp5fUo16Gism
         Zssr+dSzMt4GJEQ0MKd1jUnA/RepH1VY30tYxnABOhEx80MvOvDrgPgfZEsPz8eHoZFg
         lN9/rt+/sThQit6sz70rH5+qDqxpNa5TGZDMNOIH6GCJ54ug5IxvyPqqlv0qjLGM6SBC
         2A4cUBwntnI+i6V1Ago8nOZO1YLAEq07eLVSp3MXndcaN9GJJ/37jBNpqsOfdIr9/Fw0
         e+Dw==
X-Gm-Message-State: AOAM531bbafeApj8DDj3fKyaCC4h2SrKQr1kw2WQmxBKzxrD+19CI6B5
        aBJ9BoZVBAWkUQAHeqKJUh3Wg+WvXF0=
X-Google-Smtp-Source: ABdhPJyJdMRcu147hU4o02PS4ULr2WsA/kIp6djIEIhcAVgv6PwahGTYWabenGR4DWl70yGgqSmdKg==
X-Received: by 2002:a05:600c:4fd4:b0:394:8e96:6d3b with SMTP id o20-20020a05600c4fd400b003948e966d3bmr12686551wmq.180.1653144565567;
        Sat, 21 May 2022 07:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u25-20020adfae59000000b0020d106c0386sm5350789wrd.89.2022.05.21.07.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 May 2022 07:49:24 -0700 (PDT)
Message-Id: <8f8d2ba0fe41583716419645ed74c3ffb0f85d77.1653144546.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
References: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
        <pull.1132.v3.git.1653144546.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 21 May 2022 14:49:06 +0000
Subject: [PATCH v3 15/15] bisect: no longer try to clean up left-over
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
index 9e6a2b7f201..8f46c3813ce 100644
--- a/bisect.c
+++ b/bisect.c
@@ -474,7 +474,6 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
-static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1173,8 +1172,6 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
-	/* Cleanup head-name if it got left by an old version of git-bisect */
-	unlink_or_warn(git_path_head_name());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 0cacbf1469a..d4846ca4de1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -990,7 +990,6 @@ test_expect_success 'git bisect reset cleans bisection state properly' '
 	test_path_is_missing ".git/BISECT_LOG" &&
 	test_path_is_missing ".git/BISECT_RUN" &&
 	test_path_is_missing ".git/BISECT_TERMS" &&
-	test_path_is_missing ".git/head-name" &&
 	test_path_is_missing ".git/BISECT_HEAD" &&
 	test_path_is_missing ".git/BISECT_START"
 '
-- 
gitgitgadget
