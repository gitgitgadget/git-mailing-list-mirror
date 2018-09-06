Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 125231F404
	for <e@80x24.org>; Thu,  6 Sep 2018 00:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbeIFF0P (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Sep 2018 01:26:15 -0400
Received: from fed1rmfepo101.cox.net ([68.230.241.143]:37816 "EHLO
        fed1rmfepo101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbeIFF0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Sep 2018 01:26:15 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo101.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180906005330.EESB4101.fed1rmfepo101.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Sep 2018 20:53:30 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id Y0tV1y00o59yGBo010tW3L; Wed, 05 Sep 2018 20:53:30 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090203.5B907A8A.0024,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Ip1uSP3g c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=kviXuzpPAAAA:8 a=v4sSVgW8i1FpXTb19_wA:9
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 9F4C129A0146;
        Wed,  5 Sep 2018 17:53:29 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/4] t7501: add test of "commit --dry-run --short"
Date:   Wed,  5 Sep 2018 17:53:28 -0700
Message-Id: <20180906005329.11277-4-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180906005329.11277-1-ischis2@cox.net>
References: <20180906005329.11277-1-ischis2@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add test for commit with --dry-run --short for a new file of zero
length.

The test demonstrates that the setting of the committable flag is
broken.

Signed-off-by: Stephen P. Smith <ischis2@cox.net>
---
 t/t7501-commit.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 4cae92804..cf2a4c539 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -682,4 +682,10 @@ test_expect_success '--dry-run with conflicts fixed from a merge' '
 	git commit -m "conflicts fixed from merge."
 '
 
+test_expect_failure '--dry-run --short' '
+	>test-file &&
+	git add test-file &&
+	git commit --dry-run --short
+'
+
 test_done
-- 
2.18.0

