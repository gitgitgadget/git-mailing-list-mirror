Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E10C77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjERUD7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjERUDp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:45 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD51310D4
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:35 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-306f2b42a86so1636348f8f.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440214; x=1687032214;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7wRuqfO3Uw51tuCAMtwwo2rpZx9lYo0sTc2HiSreAs=;
        b=kYXg+JblLhuMrz1qvVe3FLppnZGS7BhUVm3rvKBQ3Oj7ExX50WmZE9j54eCIcgYzcV
         L3WRzZxaucXDLFPib4AGveWdBbXM2L7WqHQwOviaDUXKKY5I0M+JIMJ2oEqP1JjGwCQz
         ppXLEN34RFeu3CTxnJu0HZ11QxIha4b/4NTFgKIOKZIaMEHlJ9aBBuMqeQztwyjC+hk6
         RQ3tltti/n1qnMjXCecupteHpf67bp8gLJGe4WWTQRZ0cdJjdoUJOwkGXyP2suD+ihRl
         eTPXDQQVX0/2ubApIQAy7HN9wuRvo7L/heLvvgMAYEh2e+w2HWvYEgqx+Ew7hb4FfRB5
         1Rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440214; x=1687032214;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f7wRuqfO3Uw51tuCAMtwwo2rpZx9lYo0sTc2HiSreAs=;
        b=Klvooq3k3CwwlpKb04ZOyfgNlq9l7PlP6ebHxssuW7C2tLioQ42hLAm5ZAvNhfIvzy
         1OcGSw5KOJ8fAO9qPAR5RZd3v2xlah0Q8DJ+vTyXtWocdFjCSugpecoXbGBEzavmLsDv
         ssw4ktJvf8zX+5iclnKeptLzpvKNO7CGshbZMvEhyaQQUaX847c9jAVIWy6MRGvUHyHm
         Oc5C3ZYaKRzSI9c8baZbykMd1bQJAdMuB8f9fyKts2CcREXVPUmnsIg/o8gm0mYhHeVf
         ocII5d3u3amhs0ANBLcxpf7E25Jnz1zv2uYNdzogEAhOphaN9n/IiM8prT6JFYeOfAcA
         GiSw==
X-Gm-Message-State: AC+VfDxMZOxlF36oz2ugM8RJMC7irilHJ1FCBcuO3VZycRLThEVvCcpa
        RTqD0gNPCoyoDFGjCU9ZwBWGLJ6Pnlk=
X-Google-Smtp-Source: ACHHUZ4Ddz2ih5NQoSr2stie/Ysn7xQ5OO5qfcNsMQD1AxkS7tgQgb4kM3BMcVoeYxv53+Tzzfvsew==
X-Received: by 2002:a05:6000:1147:b0:306:3da7:f33c with SMTP id d7-20020a056000114700b003063da7f33cmr2580050wrx.63.1684440213851;
        Thu, 18 May 2023 13:03:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020adfe784000000b003063a92bbf5sm3154048wrm.70.2023.05.18.13.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:33 -0700 (PDT)
Message-Id: <bb9abb10c6ed11a6ab528e09fca67cf1b0e29a18.1684440206.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:16 +0000
Subject: [PATCH 11/20] t4003-diff-rename-1: modernize test format
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
 t/t4003-diff-rename-1.sh | 62 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/t/t4003-diff-rename-1.sh b/t/t4003-diff-rename-1.sh
index 181e9683a79..ebe091828c8 100755
--- a/t/t4003-diff-rename-1.sh
+++ b/t/t4003-diff-rename-1.sh
@@ -11,20 +11,20 @@ TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
-test_expect_success \
-    'prepare reference tree' \
-    'COPYING_test_data >COPYING &&
-     echo frotz >rezrov &&
-    git update-index --add COPYING rezrov &&
-    tree=$(git write-tree) &&
-    echo $tree'
-
-test_expect_success \
-    'prepare work tree' \
-    'sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
-    sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
-    rm -f COPYING &&
-    git update-index --add --remove COPYING COPYING.?'
+test_expect_success 'prepare reference tree' '
+	COPYING_test_data >COPYING &&
+	echo frotz >rezrov &&
+	git update-index --add COPYING rezrov &&
+	tree=$(git write-tree) &&
+	echo $tree
+'
+
+test_expect_success 'prepare work tree' '
+	sed -e 's/HOWEVER/However/' <COPYING >COPYING.1 &&
+	sed -e 's/GPL/G.P.L/g' <COPYING >COPYING.2 &&
+	rm -f COPYING &&
+	git update-index --add --remove COPYING COPYING.?
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING.1 and COPYING.2,
 # both are slightly edited, and unchanged rezrov.  So we say you
@@ -57,14 +57,14 @@ rename to COPYING.2
 +	This file is licensed under the G.P.L v2, or a later version
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#1)' \
-    'compare_diff_patch current expected'
+test_expect_success 'validate output from rename/copy detection (#1)' '
+	compare_diff_patch current expected
+'
 
-test_expect_success \
-    'prepare work tree again' \
-    'mv COPYING.2 COPYING &&
-     git update-index --add --remove COPYING COPYING.1 COPYING.2'
+test_expect_success 'prepare work tree again' '
+	mv COPYING.2 COPYING &&
+	git update-index --add --remove COPYING COPYING.1 COPYING.2
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 # both are slightly edited, and unchanged rezrov.  So we say you
@@ -95,14 +95,14 @@ copy to COPYING.1
 + However, in order to allow a migration to GPLv3 if that seems like
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#2)' \
-    'compare_diff_patch current expected'
+test_expect_success 'validate output from rename/copy detection (#2)' '
+	compare_diff_patch current expected
+'
 
-test_expect_success \
-    'prepare work tree once again' \
-    'COPYING_test_data >COPYING &&
-     git update-index --add --remove COPYING COPYING.1'
+test_expect_success 'prepare work tree once again' '
+	COPYING_test_data >COPYING &&
+	git update-index --add --remove COPYING COPYING.1
+'
 
 # tree has COPYING and rezrov.  work tree has COPYING and COPYING.1,
 # but COPYING is not edited.  We say you copy-and-edit COPYING.1; this
@@ -123,8 +123,8 @@ copy to COPYING.1
 + However, in order to allow a migration to GPLv3 if that seems like
 EOF
 
-test_expect_success \
-    'validate output from rename/copy detection (#3)' \
-    'compare_diff_patch current expected'
+test_expect_success 'validate output from rename/copy detection (#3)' '
+	compare_diff_patch current expected
+'
 
 test_done
-- 
gitgitgadget

