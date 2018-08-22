Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4551F954
	for <e@80x24.org>; Wed, 22 Aug 2018 18:13:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeHVVjp (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Aug 2018 17:39:45 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:33356 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeHVVjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Aug 2018 17:39:45 -0400
Received: by mail-wm0-f48.google.com with SMTP id i134-v6so200649wmf.0
        for <git@vger.kernel.org>; Wed, 22 Aug 2018 11:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gHV4FH7HvnSHYll6K2YKZmSntdE4maH2X4f6YOaisQk=;
        b=U22w5jMipFzcwSaK5VlUPAKHX0sX5BTIAOd0MVqxawylGr235eidGEPhzfMNzECJgi
         4SUoaNU+tcTuHuPRV6bLszIVz6ZFlMTCDLE70NXPES1RJFhmualCJ0iGUMC51ncwozg2
         vbSGuq/F08wA/XEAX9beCDQFI00FtpQfAcE8OfqRGTcj56F2SMobmlFq7LEPHiJQDGGk
         4k/7z8aitFkQYn10NgLocOFPqHLsop5e3oobB46XpHGTC1Jl0S3wPkIJZRZbWSTOt3dM
         2iD492MY6NUwo13V8vlORRPZPxQ/XgOotZkE7YAWTavCEqayQiBJP/lIseQtr8vNQFiv
         a8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gHV4FH7HvnSHYll6K2YKZmSntdE4maH2X4f6YOaisQk=;
        b=t0XebZT7pd07OWazkOTQUBzxT7CKuFub80wou8ezT/hXX3eaIlPBBRlG5mYx9e5P7t
         gRTywm/jOH/e7ZgM60HrVxw/g4HPbCVsYsxzzI8/Fowm3CAE8B9di8ykyGGifcoUYelf
         RNeqJmNK+XqBAUt2hECCsLY4ClPLwZIgE3JyqdUuWiTAIkZJB2d6hxF5CFmrkFOsAcUY
         vEj7BTJhYxvRWmh4S/F0ycwhC9DVY2B33NLcApcjIDO1dOt464STqgE3q7USa2MQZ7hC
         6l4UUjDU+VNKgWGORF0UNUO0xkPdZx22k3Pzd3TboY+0mvvbbf7ZeoR57nIZynPeSuy1
         BE9w==
X-Gm-Message-State: APzg51ALPMdNi333txBvQh1Mub/JZyLNmtHpZKx+hHd5XMt1npQGjF3q
        7sCcWUIpFuhtCqZE3Tg8DRo=
X-Google-Smtp-Source: ANB0VdZ72ahr8Nqgj4wBiqeNPwM5BCBoGWccPZSm1ypMt+l7IxAJnaMrQxCCj5Eyot/QPDiH7El+IQ==
X-Received: by 2002:a1c:be14:: with SMTP id o20-v6mr3111824wmf.73.1534961628025;
        Wed, 22 Aug 2018 11:13:48 -0700 (PDT)
Received: from localhost.localdomain (62-165-238-147.pool.digikabel.hu. [62.165.238.147])
        by smtp.gmail.com with ESMTPSA id q3-v6sm2222490wma.45.2018.08.22.11.13.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Aug 2018 11:13:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] t3420-rebase-autostash: don't try to grep non-existing files
Date:   Wed, 22 Aug 2018 20:13:20 +0200
Message-Id: <20180822181320.14055-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.136.gd2dd172e64
In-Reply-To: <20180822181320.14055-1-szeder.dev@gmail.com>
References: <20180822181320.14055-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several tests in 't3420-rebase-autostash.sh' start various rebase
processes that are expected to fail because of merge conflicts.  These
tests then run '! grep' to ensure that the autostash feature did its
job, and the dirty contents of a file is gone.  However, due to the
test repo's history and the choice of upstream branch that file
shouldn't exist in the conflicted state at all.  Consequently, this
'grep' doesn't fail as expected, because it can't find the dirty
content, but it fails because it can't open the file.

Tighten this check by using 'test_path_is_missing' instead, thereby
avoiding unexpected errors from 'grep' as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3420-rebase-autostash.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index e243700660..0c4eefec76 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -202,7 +202,7 @@ testrebase () {
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
-		! grep dirty file3 &&
+		test_path_is_missing file3 &&
 		rm -rf $dotest &&
 		git reset --hard &&
 		git checkout feature-branch
@@ -216,7 +216,7 @@ testrebase () {
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
-		! grep dirty file3 &&
+		test_path_is_missing file3 &&
 		echo "conflicting-plus-goodbye" >file2 &&
 		git add file2 &&
 		git rebase --continue &&
@@ -233,7 +233,7 @@ testrebase () {
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
-		! grep dirty file3 &&
+		test_path_is_missing file3 &&
 		git rebase --skip &&
 		test_path_is_missing $dotest/autostash &&
 		grep dirty file3 &&
@@ -248,7 +248,7 @@ testrebase () {
 		echo dirty >>file3 &&
 		test_must_fail git rebase$type related-onto-branch &&
 		test_path_is_file $dotest/autostash &&
-		! grep dirty file3 &&
+		test_path_is_missing file3 &&
 		git rebase --abort &&
 		test_path_is_missing $dotest/autostash &&
 		grep dirty file3 &&
-- 
2.19.0.rc0.136.gd2dd172e64

