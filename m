Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4AAC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjERUE2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjERUEK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:04:10 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E94171B
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:42 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307a8386946so1658440f8f.2
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440220; x=1687032220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGe7of0EMY/DyGk0Fz10EMfPLyHGckPtyRCDUQo1G70=;
        b=SKmmp+3i1AiNI5d+AopEFgsn/ApoSWo7RrLaoHj41utF7sMiuPv05Y/H1FnnLrZg6H
         lVizqrOXQ0Uiu3kmbzidZc9IJ7S7w6v+LnhJNMT4jKNfP89nTPLSptWreMrz7mkchvVz
         OpQPCQrtUqCiwJKqD6NUTUobPIaD2EPqs9luBZsGlcTNZW8T+CvTsZOk9vwiuFt+INJ0
         j7IL1ZPMOLpwsqwOVVDrpEkzHphJPxczPuPrXYBgwOz4Fvsgil7qqVerY8gJSQTKKfQu
         n50rltrTsyZvySBEwi8gHU0NUP7GiwVbzvJxsFOX+2q5MaPnRekSMhc9S1mejsIi3Uk8
         FHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440220; x=1687032220;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LGe7of0EMY/DyGk0Fz10EMfPLyHGckPtyRCDUQo1G70=;
        b=UMNVqV4VeANJw4wpBpm+T9LJoEgK1qFz8020lKOhU7AjzmocCOJDMnFI8Sv/vgFeHe
         CbZYQ7wItKQmjY/dHZYXr7S3gafYPmtbLTYRE1SM8j3u1Hz0vErc2GpRN3kozI812N6M
         yT9pShVn/dCnhtdkSav2A6COwzRXKu6IJa35EDx1LaxbHP4G/vfRrVodzfe49yyPrXOZ
         SAxfiwVz7wLTnhQIi3Do7+oilDBfZUYaQq1VFi0vXyOKnoTtPHEVWIYOr2CeYbK42Tpu
         TqNkzP8AG0RHCvWdyI5SGeasJyKlAKbSKFzERo48f/7iLDmtw6ZevT3KWRyiOuKC2Cze
         vkCg==
X-Gm-Message-State: AC+VfDzotthmRBepItQsOpVJ/05TUELELonsuLvSIu1vOumGhGaLCT6X
        KNoCLpz1VR2VoOduBjkTM8c3xS2AGhU=
X-Google-Smtp-Source: ACHHUZ4Y3oGQXrYd8/paLPJr/S1h+nsKamrpdwbxWerMUOulj+UTDw2D+yOwvUXfTfqIcTF0BVEAAw==
X-Received: by 2002:adf:f186:0:b0:306:3435:f85c with SMTP id h6-20020adff186000000b003063435f85cmr3335529wro.30.1684440219915;
        Thu, 18 May 2023 13:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b00307c0afc030sm3070900wrq.4.2023.05.18.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:39 -0700 (PDT)
Message-Id: <cb7716a0e1395c1488f3ebb6eda3c0f9da83615a.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:25 +0000
Subject: [PATCH 20/20] t7101-reset-empty-subdirs: modernize test format
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
 t/t7101-reset-empty-subdirs.sh | 48 +++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/t/t7101-reset-empty-subdirs.sh b/t/t7101-reset-empty-subdirs.sh
index 638bb04e217..89cf98b30c8 100755
--- a/t/t7101-reset-empty-subdirs.sh
+++ b/t/t7101-reset-empty-subdirs.sh
@@ -10,57 +10,57 @@ TEST_PASSES_SANITIZE_LEAK=true
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
 test_expect_success 'creating initial files' '
-     mkdir path0 &&
-     COPYING_test_data >path0/COPYING &&
-     git add path0/COPYING &&
-     git commit -m add -a
+	mkdir path0 &&
+	COPYING_test_data >path0/COPYING &&
+	git add path0/COPYING &&
+	git commit -m add -a
 '
 
 test_expect_success 'creating second files' '
-     mkdir path1 &&
-     mkdir path1/path2 &&
-     COPYING_test_data >path1/path2/COPYING &&
-     COPYING_test_data >path1/COPYING &&
-     COPYING_test_data >COPYING &&
-     COPYING_test_data >path0/COPYING-TOO &&
-     git add path1/path2/COPYING &&
-     git add path1/COPYING &&
-     git add COPYING &&
-     git add path0/COPYING-TOO &&
-     git commit -m change -a
+	mkdir path1 &&
+	mkdir path1/path2 &&
+	COPYING_test_data >path1/path2/COPYING &&
+	COPYING_test_data >path1/COPYING &&
+	COPYING_test_data >COPYING &&
+	COPYING_test_data >path0/COPYING-TOO &&
+	git add path1/path2/COPYING &&
+	git add path1/COPYING &&
+	git add COPYING &&
+	git add path0/COPYING-TOO &&
+	git commit -m change -a
 '
 
 test_expect_success 'resetting tree HEAD^' '
-     git reset --hard HEAD^
+	git reset --hard HEAD^
 '
 
 test_expect_success 'checking initial files exist after rewind' '
-     test -d path0 &&
-     test -f path0/COPYING
+	test -d path0 &&
+	test -f path0/COPYING
 '
 
 test_expect_success 'checking lack of path1/path2/COPYING' '
-    ! test -f path1/path2/COPYING
+	! test -f path1/path2/COPYING
 '
 
 test_expect_success 'checking lack of path1/COPYING' '
-    ! test -f path1/COPYING
+	! test -f path1/COPYING
 '
 
 test_expect_success 'checking lack of COPYING' '
-     ! test -f COPYING
+	! test -f COPYING
 '
 
 test_expect_success 'checking checking lack of path1/COPYING-TOO' '
-     ! test -f path0/COPYING-TOO
+	! test -f path0/COPYING-TOO
 '
 
 test_expect_success 'checking lack of path1/path2' '
-     ! test -d path1/path2
+	! test -d path1/path2
 '
 
 test_expect_success 'checking lack of path1' '
-     ! test -d path1
+	! test -d path1
 '
 
 test_done
-- 
gitgitgadget
