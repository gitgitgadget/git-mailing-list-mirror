Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1E8E71D33
	for <git@archiver.kernel.org>; Fri, 29 Sep 2023 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjI2UdO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Sep 2023 16:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232985AbjI2UdM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Sep 2023 16:33:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E67A1B0
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:05 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406609df1a6so7938375e9.3
        for <git@vger.kernel.org>; Fri, 29 Sep 2023 13:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696019584; x=1696624384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdC+bsPVckJYi/Zh4cZeAa88NrJBCRi7MTAopCnpxcc=;
        b=cD2frsXM1vK7x0cqewkZI6yMEEDKz/PfgK8a4eHHlBaYkgCkUl21an9Eolse8xcj+x
         Q/e0J/LRsyARbfy74JpDC1mAx8Ca4Vjtfsi1/3hmRJB35NfB8Ds47/Ptv4Rf3qA75X3a
         dIViEQrIGu4Zab4Rlcfgp4tKJ+u72VsOSh4aY0A/yuT0JV6+gWI5b40Lu79mTOnpSowY
         2o1BI4TomSjMDI8LRZcvp43WcOs9gROMsJDd9ga4cI4jW6Mg2PDBebw8zmqtmUNTwewx
         40nPaqdvCR4Z6OtdUun6lJXL2D54EvqnL9K+BmLusaF00DwP9dHySOT8rq//cKGSZFo4
         t/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696019584; x=1696624384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdC+bsPVckJYi/Zh4cZeAa88NrJBCRi7MTAopCnpxcc=;
        b=uIMpNUwbYt07y1Ud78SlbPe9KNd1LOVK1WS/u7yx4fXFYDzMbj6EzAKm4WUsekMBJn
         Mc6Ho66BjWu6vuFmlRa1lllki8zc9rG8vfKNZpDXKpqcgJUmDDR6XO01SgZ2PdlDH8gu
         mJKqMIcfMbaSIk4/5afNb4uG7fKpNMQfNK+bzg8zkMnHSD3ctMUOzj/Oe1q/Wk7iejhS
         rIJayCNi2e5qLxgShDtdyHHHTH0QeecAHhx/2JT3ydG/TYZRd+bO+Ml1MQceXcCB/qyp
         eSGsbrs4FJF34HmYLy3xvxxVs3JeS+5pjcn+/U9qPfUs9spuV712RQQDt2OT1h3JD2cd
         GOqA==
X-Gm-Message-State: AOJu0YyYMCav5n92MJxU+o/QVb/jJ6muMXxOKMW3hVvrsplPw852N7JW
        2gy840KciZo18Af79R+8bjK23i3fJzo=
X-Google-Smtp-Source: AGHT+IE+eFuLXJFC0U03cSXIFUnDPm2jSm6/73cxum9d0hf28Uv79Dz5qZ8tY1jIBslDGrswB0RC6w==
X-Received: by 2002:a7b:c397:0:b0:3fe:3004:1ffd with SMTP id s23-20020a7bc397000000b003fe30041ffdmr4700571wmj.4.1696019583799;
        Fri, 29 Sep 2023 13:33:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x16-20020a05600c2a5000b003fe23b10fdfsm2124219wme.36.2023.09.29.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 13:33:03 -0700 (PDT)
Message-ID: <eff8bfcc04278eeae658ffbff8317f822edb9b20.1696019580.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
References: <pull.1587.v2.git.1695399920.gitgitgadget@gmail.com>
        <pull.1587.v3.git.1696019580.gitgitgadget@gmail.com>
From:   "Zach FettersMoore via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Sep 2023 20:33:00 +0000
Subject: [PATCH v3 3/3] subtree: adding test to validate fix
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Zach FettersMoore <zach.fetters@apollographql.com>,
        Zach FettersMoore <zach.fetters@apollographql.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Zach FettersMoore <zach.fetters@apollographql.com>

Adding a test to validate that the proposed fix
solves the issue.

The test accomplishes this by checking the output
of the split command to ensure the output from
the progress of 'process_split_commit' function
that represents the 'extracount' of commits
processed does not increment.

This was tested against the original functionality
to show the test failed, and then with this fix
to show the test passes.

This illustrated that when using multiple subtrees,
A and B, when doing a split on subtree B, the
processing does not traverse the entire history
of subtree A which is unnecessary and would cause
the 'extracount' of processed commits to climb
based on the number of commits in the history of
subtree A.

Signed-off-by: Zach FettersMoore <zach.fetters@apollographql.com>
---
 contrib/subtree/t/t7900-subtree.sh | 41 ++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index 49a21dd7c9c..57c12e9f924 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -385,6 +385,47 @@ test_expect_success 'split sub dir/ with --rejoin' '
 	)
 '
 
+test_expect_success 'split with multiple subtrees' '
+	subtree_test_create_repo "$test_count" &&
+	subtree_test_create_repo "$test_count/subA" &&
+	subtree_test_create_repo "$test_count/subB" &&
+	test_create_commit "$test_count" main1 &&
+	test_create_commit "$test_count/subA" subA1 &&
+	test_create_commit "$test_count/subA" subA2 &&
+	test_create_commit "$test_count/subA" subA3 &&
+	test_create_commit "$test_count/subB" subB1 &&
+	(
+		cd "$test_count" &&
+		git fetch ./subA HEAD &&
+		git subtree add --prefix=subADir FETCH_HEAD
+	) &&
+	(
+		cd "$test_count" &&
+		git fetch ./subB HEAD &&
+		git subtree add --prefix=subBDir FETCH_HEAD
+	) &&
+	test_create_commit "$test_count" subADir/main-subA1 &&
+	test_create_commit "$test_count" subBDir/main-subB1 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 1"
+	) &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subBDir --squash --rejoin -m "Sub B Split 1"
+	) &&
+	test_create_commit "$test_count" subADir/main-subA2 &&
+	test_create_commit "$test_count" subBDir/main-subB2 &&
+	(
+		cd "$test_count" &&
+		git subtree split --prefix=subADir --squash --rejoin -m "Sub A Split 2"
+	) &&
+	(
+		cd "$test_count" &&
+		test "$(git subtree split --prefix=subBDir --squash --rejoin -d -m "Sub B Split 1" 2>&1 | grep -w "\[1\]")" = ""
+	)
+'
+
 test_expect_success 'split sub dir/ with --rejoin from scratch' '
 	subtree_test_create_repo "$test_count" &&
 	test_create_commit "$test_count" main1 &&
-- 
gitgitgadget
