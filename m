Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4817FC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjERUDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjERUDf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:35 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86661E77
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:33 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3078cc99232so2344224f8f.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440212; x=1687032212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+WMk28lmX0BrTQaSGR42CvrnqaECm89fIi0dM+1ilY=;
        b=Qh7WgYosdbH96O95B731vHH8FjEwA9p6QhRiTfhsa/w+MzWazKYPzsLdN4u792P5zy
         O+WPLwwFiFlRpEtwMOm3FfnMKvWX3Q1NmPnbUf0LZGXNrAndgYOLaQuZmJcIs0YaEqQ1
         11/Ny5Ng4kSpunqp/3gKoANqZ7Az+EId+MzgjpOR5rUhoaoO1yZYC2nVar9WbfuXF1Xa
         AvlJjW6LElREcKl1ctJdAEV+GtGnRRQlx2xc6oF77iXNjOYgXYaV1VC2Imt21z4BhrDv
         PEBA4g4SSaUNSmiZFfAsETLmaBileIkDg0+CLpQOIdOUHxGlX/uCSarC8NMOSkHh/jCK
         URUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440212; x=1687032212;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+WMk28lmX0BrTQaSGR42CvrnqaECm89fIi0dM+1ilY=;
        b=T32SVBQHTh0nQlAxpIiSU4FXdvt3ybU+Jt8a19JZAWghT5AlpsRm+qtu6maxZscsJP
         BhZpcMpem50eXBu3eKHUIGaclFRLmybxlyFhpclFCo/w26XWXer6enEA5qjiFsavAozr
         CXqF6OOngGUnksW0N4Q2CtuTGGR5uPjEgUHIdoJRQA26jXsn/ePw1oqObumaiQjsgUFS
         EHrprK5invgq89vMMEPXiJ75mHrfjb93hnq2BiPi1nrS/Z51vEVygwg6eB4Yw/NA8M6J
         adAcBaXDpmOjjGw07ExsFPwxeYJyykR9w+69DDqoD7ifhvOzogu91FBwfPTSZwlAzLh/
         ysLg==
X-Gm-Message-State: AC+VfDwTNbf0dxSwtrTfTaqMjqnj8CyOOYpAKtpxN+OILU9b1Uu276RC
        jMZ7vZm5dM35QYT+sRoQoEdryqIGbQg=
X-Google-Smtp-Source: ACHHUZ5PmU38xmfgphLFsi9R9Mcggln+ww2B8cfXD2ITNnYuxMf4v1m5fCZo3Hm3jHmlwWn7XM4MZA==
X-Received: by 2002:adf:e60f:0:b0:306:2cf5:79dc with SMTP id p15-20020adfe60f000000b003062cf579dcmr2568964wrm.35.1684440211726;
        Thu, 18 May 2023 13:03:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16-20020a7bce90000000b003f4289b18a7sm241406wmj.5.2023.05.18.13.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:31 -0700 (PDT)
Message-Id: <3aa5c1650622b59b85861ced9527781f30252333.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:12 +0000
Subject: [PATCH 07/20] t3500-cherry: modernize test format
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
 t/t3500-cherry.sh | 69 +++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 36 deletions(-)

diff --git a/t/t3500-cherry.sh b/t/t3500-cherry.sh
index 0458a58b4b5..78c3eac54b5 100755
--- a/t/t3500-cherry.sh
+++ b/t/t3500-cherry.sh
@@ -16,46 +16,43 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_AUTHOR_EMAIL=bogus_email_address
 export GIT_AUTHOR_EMAIL
 
-test_expect_success \
-    'prepare repository with topic branch, and check cherry finds the 2 patches from there' \
-    'echo First > A &&
-     git update-index --add A &&
-     test_tick &&
-     git commit -m "Add A." &&
-
-     git checkout -b my-topic-branch &&
-
-     echo Second > B &&
-     git update-index --add B &&
-     test_tick &&
-     git commit -m "Add B." &&
-
-     echo AnotherSecond > C &&
-     git update-index --add C &&
-     test_tick &&
-     git commit -m "Add C." &&
-
-     git checkout -f main &&
-     rm -f B C &&
-
-     echo Third >> A &&
-     git update-index A &&
-     test_tick &&
-     git commit -m "Modify A." &&
-
-     expr "$(echo $(git cherry main my-topic-branch) )" : "+ [^ ]* + .*"
+test_expect_success 'prepare repository with topic branch, and check cherry finds the 2 patches from there' '
+	echo First > A &&
+	git update-index --add A &&
+	test_tick &&
+	git commit -m "Add A." &&
+
+	git checkout -b my-topic-branch &&
+
+	echo Second > B &&
+	git update-index --add B &&
+	test_tick &&
+	git commit -m "Add B." &&
+
+	echo AnotherSecond > C &&
+	git update-index --add C &&
+	test_tick &&
+	git commit -m "Add C." &&
+
+	git checkout -f main &&
+	rm -f B C &&
+
+	echo Third >> A &&
+	git update-index A &&
+	test_tick &&
+	git commit -m "Modify A." &&
+
+	expr "$(echo $(git cherry main my-topic-branch) )" : "+ [^ ]* + .*"
 '
 
-test_expect_success \
-    'check that cherry with limit returns only the top patch'\
-    'expr "$(echo $(git cherry main my-topic-branch my-topic-branch^1) )" : "+ [^ ]*"
+test_expect_success 'check that cherry with limit returns only the top patch' '
+	expr "$(echo $(git cherry main my-topic-branch my-topic-branch^1) )" : "+ [^ ]*"
 '
 
-test_expect_success \
-    'cherry-pick one of the 2 patches, and check cherry recognized one and only one as new' \
-    'git cherry-pick my-topic-branch^0 &&
-     echo $(git cherry main my-topic-branch) &&
-     expr "$(echo $(git cherry main my-topic-branch) )" : "+ [^ ]* - .*"
+test_expect_success 'cherry-pick one of the 2 patches, and check cherry recognized one and only one as new' '
+	git cherry-pick my-topic-branch^0 &&
+	echo $(git cherry main my-topic-branch) &&
+	expr "$(echo $(git cherry main my-topic-branch) )" : "+ [^ ]* - .*"
 '
 
 test_expect_success 'cherry ignores whitespace' '
-- 
gitgitgadget

