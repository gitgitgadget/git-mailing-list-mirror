Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9CDDC43219
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 08:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiJMImz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 04:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiJMImx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 04:42:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4348411C245
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a3so1798004wrt.0
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 01:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7faw4EUCXSCyKuXe8/STylGCsukVPYq05BacxCx1390=;
        b=Gc9kemrMPSvLKJEIAOSqqREPI4ZdTB2IlRTDMgZKjIxzMXrNexO+qLbhyrVbT378WB
         +cpaUwFtWDLAS84cHMrWXIhksYkZA+RbPW22B2EOZBGbvLe+DvAvrEdjPRfmUvIR/sBE
         7u4JV60aoRR0AqAXsW57Du44en4xR54zNGF+OYuzTKKE5qREySqWQKYWw12ZHzf6UQCS
         /DcAMq67zoUPjlfmHnR4S/Lfhjk4mDZsKiZ2o8+8RhJHLDGY+/Rv+EHj2OsNJH4Tb+ih
         8NbHWMXcDogyo1HSXGbGY9wfZ50gugB+QY6Z6jHqhXGCv1yBe2gcZy7vaI2EsodPd2zs
         nWVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7faw4EUCXSCyKuXe8/STylGCsukVPYq05BacxCx1390=;
        b=F8UCrHlNUrcNuJQ8VFhYZlZj9Rkbd+r8U2lRvGpxizyG5HZTOQoiOhEMhklMq7IYJN
         lGjcYTm6A+/xqMnQM/oQcK5cwYsrLUitGIOsGSh2ND+DIl/pOz8cZ2EjllMIJuEtCJDf
         nxh7KcG2zG70CZalMVFENF5V0GdDENAII9mNZVh5XTS5Lh+2hKEae8BK0M1Y1P1q1KYj
         p2KHliFQmdOMEwjwXlZFW9o+Gj3meKc8uyoo/Q1o5c6+XRwOGQbz8FzIeeer2n4E1AfJ
         ZPcn9X+w13ypz140W4dyJWGvSq4mUO4LiW+FFJ+tj7fMNNrNbkOlqSgSn8cFeE1Bm5F3
         l37w==
X-Gm-Message-State: ACrzQf1/WEma7CbIxtJQvPg97aJfPeqmIdpP8fEg/enBlTv6ZoB+Mfh9
        wVpcRF8dLaY5kjGFdU1rcqnmgokiAwI=
X-Google-Smtp-Source: AMsMyM532BCFBiS6z8EFqYSNzOoc09a2wLmAysKE/8U92UAAyR4ZQ0iRZ7VizZdBIw+dvoiSbz1AQw==
X-Received: by 2002:adf:f00b:0:b0:22e:3439:cff2 with SMTP id j11-20020adff00b000000b0022e3439cff2mr21339826wro.719.1665650570643;
        Thu, 13 Oct 2022 01:42:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m16-20020a5d6250000000b0022da3977ec5sm1449533wrv.113.2022.10.13.01.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 01:42:49 -0700 (PDT)
Message-Id: <d6f2f716c77cbd0a19b3b6032f69f6dd9b257e96.1665650564.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
References: <pull.1323.v2.git.1662561470.gitgitgadget@gmail.com>
        <pull.1323.v3.git.1665650564.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 08:42:38 +0000
Subject: [PATCH v3 2/8] t3416: set $EDITOR in subshell
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As $EDITOR is exported, setting it in one test affects all subsequent
tests. Avoid this by always setting it in a subshell. Also remove a
couple of unnecessary call to set_fake_editor where the editor does
not change the todo list.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3416-rebase-onto-threedots.sh | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index dc67d2308f3..01eb9513d6c 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -79,8 +79,10 @@ test_expect_success 'rebase -i --onto main...topic' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
-	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto main...topic F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --onto main...topic F
+	) &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
@@ -90,8 +92,10 @@ test_expect_success 'rebase -i --onto main...' '
 	git reset --hard &&
 	git checkout topic &&
 	git reset --hard G &&
-	set_fake_editor &&
-	EXPECT_COUNT=1 git rebase -i --onto main... F &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=1 git rebase -i --onto main... F
+	) &&
 	git rev-parse HEAD^1 >actual &&
 	git rev-parse C^0 >expect &&
 	test_cmp expect actual
@@ -102,7 +106,6 @@ test_expect_success 'rebase --onto main...side requires a single merge-base' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --onto main...side J 2>err &&
 	grep "need exactly one merge base" err
 '
@@ -157,8 +160,10 @@ test_expect_success 'rebase -i --keep-base main from topic' '
 	git checkout topic &&
 	git reset --hard G &&
 
-	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base main &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base main
+	) &&
 	git rev-parse C >base.expect &&
 	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
@@ -172,8 +177,10 @@ test_expect_success 'rebase -i --keep-base main topic from main' '
 	git checkout main &&
 	git branch -f topic G &&
 
-	set_fake_editor &&
-	EXPECT_COUNT=2 git rebase -i --keep-base main topic &&
+	(
+		set_fake_editor &&
+		EXPECT_COUNT=2 git rebase -i --keep-base main topic
+	) &&
 	git rev-parse C >base.expect &&
 	git merge-base main HEAD >base.actual &&
 	test_cmp base.expect base.actual &&
@@ -188,9 +195,13 @@ test_expect_success 'rebase --keep-base requires a single merge base' '
 	git checkout side &&
 	git reset --hard K &&
 
-	set_fake_editor &&
 	test_must_fail git rebase -i --keep-base main 2>err &&
 	grep "need exactly one merge base with branch" err
 '
 
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
-- 
gitgitgadget

