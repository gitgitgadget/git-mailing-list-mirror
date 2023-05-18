Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD00C77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbjERUEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjERUDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F5710EC
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42d937d2eso15519375e9.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440216; x=1687032216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxJsDxdZGwZ154kis2C/LN3+sQEvzZKL7/V13pRIBK4=;
        b=KIaVdYy2VVw38xYb2TIyKDq5kBnEVZs8d2Eh2AwfU3shyvqYbWasO9EL2fOkwRTDBW
         6UeRdsd5BKpyqdAlkxLZ+CW/hIC/aE3fkOTNV0iJzXj1fB+e8og6oGlLsWuyZes/3Q+e
         BkAUSXsNjjLs4VM56F7yf8qhH/ZOMuoXqmCC9C9q/Yg6voNAWacyg4j7p++MHPEGI+R5
         y2JPG24sdxOOwMiPedxMABC6I4AJA+Ocq7CFWyElAJd+idR7CDB7/h6WDAwXo/zjGg+n
         gyGDpf0xWJaiCBGD0OHrPg7dZ9T0DOlT5+xg9UHO1BR0Kqh8ZDU+hKyHBjCgR4/dP6Sf
         S80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440216; x=1687032216;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxJsDxdZGwZ154kis2C/LN3+sQEvzZKL7/V13pRIBK4=;
        b=gn/jlprt05EiGM36i7z3T4nLbAbIUknW17xvxcNsnPyaegG/rQjnFYc3CIPgXY2Rj0
         kSTU8jhJUuybiNtkG8GQIW+iU3N9EqBg8pecc3fjihLuMcRmFS2mP88vS0c06RH3d+qh
         PXI8LpPHGLx9iv7ipINPGDevPlfFKsWGrSpEG9VJGd60G5DcFl7p+bj5ZvtiMV09XImR
         5GP41fY44+10yWBJsJakX3lM6FGM6k86LbS+R+1Iss0eqMfXTZDmIOZz+P+fp0hv5VIw
         /xJUXHJu/mKA1r2DH5817vp1Ac7/bB5UgVxwaqlsQLzQF0Xt0tfpLSEJ2djk2f54EMRe
         9PAA==
X-Gm-Message-State: AC+VfDxfLxyc/iC/v0cmbJl+Sl8GMNqYnIdlobHVzekhMU0HdiqLbzx9
        kbhqPUPfnYxL7OGe7pA1DUskxVaZzo4=
X-Google-Smtp-Source: ACHHUZ5MDgkQ6OSdf7ZQFlwMSHm3AwRHxJPOCXvhNK1KoLMtt4JAliHcSq7neBiFVThF0KmsXo8C/A==
X-Received: by 2002:a7b:c012:0:b0:3f1:662a:93d0 with SMTP id c18-20020a7bc012000000b003f1662a93d0mr2592719wmb.15.1684440215767;
        Thu, 18 May 2023 13:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1-20020a1cf601000000b003f4e3ed98ffsm195173wmc.35.2023.05.18.13.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:35 -0700 (PDT)
Message-Id: <75a6b73d1bb196be2e4f3800c458e730b6f71237.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:19 +0000
Subject: [PATCH 14/20] t4206-log-follow-harder-copies: modernize test format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Some tests still use the old format with four spaces indentation.
Standardize the tests to the new format with tab indentation.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t4206-log-follow-harder-copies.sh | 36 ++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t4206-log-follow-harder-copies.sh b/t/t4206-log-follow-harder-copies.sh
index 33ecf82c7f9..9167b0351f2 100755
--- a/t/t4206-log-follow-harder-copies.sh
+++ b/t/t4206-log-follow-harder-copies.sh
@@ -16,29 +16,29 @@ Line 2
 Line 3
 '
 
-test_expect_success \
-    'add a file path0 and commit.' \
-    'git add path0 &&
-     git commit -m "Add path0"'
+test_expect_success 'add a file path0 and commit.' '
+	git add path0 &&
+	git commit -m "Add path0"
+'
 
 echo >path0 'New line 1
 New line 2
 New line 3
 '
-test_expect_success \
-    'Change path0.' \
-    'git add path0 &&
-     git commit -m "Change path0"'
+test_expect_success 'Change path0.' '
+	git add path0 &&
+	git commit -m "Change path0"
+'
 
 cat <path0 >path1
-test_expect_success \
-    'copy path0 to path1.' \
-    'git add path1 &&
-     git commit -m "Copy path1 from path0"'
+test_expect_success 'copy path0 to path1.' '
+	git add path1 &&
+	git commit -m "Copy path1 from path0"
+'
 
-test_expect_success \
-    'find the copy path0 -> path1 harder' \
-    'git log --follow --name-status --pretty="format:%s"  path1 > current'
+test_expect_success 'find the copy path0 -> path1 harder' '
+	git log --follow --name-status --pretty="format:%s"  path1 > current
+'
 
 cat >expected <<\EOF
 Copy path1 from path0
@@ -51,8 +51,8 @@ Add path0
 A	path0
 EOF
 
-test_expect_success \
-    'validate the output.' \
-    'compare_diff_patch current expected'
+test_expect_success 'validate the output.' '
+	compare_diff_patch current expected
+'
 
 test_done
-- 
gitgitgadget

