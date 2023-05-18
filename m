Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F7CC7EE2A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjERUDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjERUDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:35 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA1E75
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:32 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-306f2b42a86so1636327f8f.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440211; x=1687032211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SreFwZYXaILufm/HM+cYTh0jFdRtvkmtVL8YxBx7So=;
        b=mZDifNZw6eA1SbWLmRPPtLHZLZy4AmzhJ4Em3aGheyqzxS5Wc5p6//dMgbbeYwjpeu
         dTJNqySL1nrTCbM+zHNLqZFhS3UeuPUWbSbpK9/NJJVBMx+ZVLuSx/r4cT9mdy3uRqGU
         IFGDHF7TaynPQkzpOJIGPeKbORwwLUnDrqGhI9Ou5z7jV5ubdEUvMlEAmaXGFYmBtQBv
         K7n7ftNSDPtjlosv4lD3pLsDxyVX4pa+pYVzLzU+Aq6G+Nv6E9+M8wLZsoGFcn24gUxc
         ZgqhJmwOq4cDqdlAsSMkNKZ2SxYkJAiIfw98MNdmndhfOeiUr2ffOW88WgYvO2QH/ixk
         qLgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440211; x=1687032211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SreFwZYXaILufm/HM+cYTh0jFdRtvkmtVL8YxBx7So=;
        b=RlFeop8Ag+VMx7Xe71jnOpiyrH6MdLXWX5CWcQZ95gSOExSQIR9d+79CnlD0dy5GeW
         Bci+W4j1tFsKOIKImWfFLaVNB7OChZCVEkz4cZk9Ypxl/sAG6Px+qNRf3tEeFhTfeO4q
         W7LGQaCRy4TVNnxXg/vKZfaP/Ie0oAJL8qmqew+zcL7itibv/dAFNS7Bg+0gFvH4OH+Y
         rLfBrUKQ5GfO+5hyxeNv0IZhFLYGSZB542F4Sn5/M75G/StknLG1SEaCXLqH5dgug8fW
         wPIX2NocAXCaxwVO6vSCwqQc/SEGh1EWGkYuZ2UivWW2ohxCGWb3WhgteHu2YwKST/AZ
         erEg==
X-Gm-Message-State: AC+VfDyxN2thO0vcfcn5PmP05GvY9uqeV5phJaIFB1IgchW+9oPwD/wn
        fMemA0y/LvYxJ0AWPYzWT0hxtePsZoE=
X-Google-Smtp-Source: ACHHUZ6ONKip32Nlvck8Nbn4CbepKDaa3o+vsTEzCbShkkLXe3C2Kj3/VSG/9ddL03V3yL/QljqfHg==
X-Received: by 2002:a5d:4484:0:b0:309:4988:7f83 with SMTP id j4-20020a5d4484000000b0030949887f83mr19932wrq.20.1684440210973;
        Thu, 18 May 2023 13:03:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b003062b57ffd1sm3080118wrp.50.2023.05.18.13.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:30 -0700 (PDT)
Message-Id: <21d3a2e2025e4add8744ec250f1b65fbd228a315.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:11 +0000
Subject: [PATCH 06/20] t1006-cat-file: modernize test format
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

Some tests in t1006-cat-file.sh used the older four space indent format.
Update these to use tabs.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1006-cat-file.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 8eac74b59c2..2e70490a30d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -351,30 +351,30 @@ do
 done
 
 test_expect_success "--batch-check for a non-existent named object" '
-    test "foobar42 missing
+	test "foobar42 missing
 foobar84 missing" = \
-    "$( ( echo foobar42 && echo_without_newline foobar84 ) | git cat-file --batch-check)"
+	"$( ( echo foobar42 && echo_without_newline foobar84 ) | git cat-file --batch-check)"
 '
 
 test_expect_success "--batch-check for a non-existent hash" '
-    test "0000000000000000000000000000000000000042 missing
+	test "0000000000000000000000000000000000000042 missing
 0000000000000000000000000000000000000084 missing" = \
     "$( ( echo 0000000000000000000000000000000000000042 &&
 	 echo_without_newline 0000000000000000000000000000000000000084 ) |
-       git cat-file --batch-check)"
+	git cat-file --batch-check)"
 '
 
 test_expect_success "--batch for an existent and a non-existent hash" '
-    test "$tag_sha1 tag $tag_size
+	test "$tag_sha1 tag $tag_size
 $tag_content
 0000000000000000000000000000000000000000 missing" = \
-    "$( ( echo $tag_sha1 &&
-	 echo_without_newline 0000000000000000000000000000000000000000 ) |
-       git cat-file --batch)"
+	"$( ( echo $tag_sha1 &&
+	echo_without_newline 0000000000000000000000000000000000000000 ) |
+	git cat-file --batch)"
 '
 
 test_expect_success "--batch-check for an empty line" '
-    test " missing" = "$(echo | git cat-file --batch-check)"
+	test " missing" = "$(echo | git cat-file --batch-check)"
 '
 
 test_expect_success 'empty --batch-check notices missing object' '
@@ -425,13 +425,13 @@ deadbeef missing
  missing"
 
 test_expect_success "--batch-check with multiple sha1s gives correct format" '
-    test "$batch_check_output" = \
-    "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
+	test "$batch_check_output" = \
+	"$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
 '
 
 test_expect_success "--batch-check, -z with multiple sha1s gives correct format" '
-    echo_without_newline_nul "$batch_check_input" >in &&
-    test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"
+	echo_without_newline_nul "$batch_check_input" >in &&
+	test "$batch_check_output" = "$(git cat-file --batch-check -z <in)"
 '
 
 test_expect_success FUNNYNAMES '--batch-check, -z with newline in input' '
-- 
gitgitgadget

