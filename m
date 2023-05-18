Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1713DC77B73
	for <git@archiver.kernel.org>; Thu, 18 May 2023 20:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjERUDw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjERUDj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 16:03:39 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E694E6E
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30935d343f7so2342957f8f.1
        for <git@vger.kernel.org>; Thu, 18 May 2023 13:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684440211; x=1687032211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZeyAUxP0YQ+Twk+BoFK5f2bDuViEiM4oRGCtNifMPK4=;
        b=RpsSNhkyMPjde0MyddT7KBt7F8jyHwyN5cVw/o/lAioCUjx14e1lf/zY3Bn3BdUCTu
         Iq/E6xxsDEFWkp+32fuJZGKgcrv2J8RaX/J8msqJY7yFOncg9cvyJOrA2wr/uLWKhURd
         RlSPxUpUsj2PmuGoax1LhpdsGHjfVCsNObXSL42wdJX18A2G4chaecPB1yDHEdpzIWF2
         FvfhjXaHt8umOvs/s73sgd72LVFKeAn3pGlCSMzzC7ctLzRomqGZvOFOfl04+0vYrSoh
         i4Buo/wzCC3cPTnDp8Kjn5CbohDQLcnPi4AmSQfC0oEO1FGjKxI5qjSjNgble94veyvj
         Euuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684440211; x=1687032211;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZeyAUxP0YQ+Twk+BoFK5f2bDuViEiM4oRGCtNifMPK4=;
        b=J5t8pGnuRMAOJHlLWN2iQqxOtlqwXHLisBgsJOkaOnZVkbsoaxq1Y9hBWeYxJ4IxCD
         R2xx6foTn1UUP5o+l8O/OaME73JvhsRth4GLDD5Wluj/PN4/IemwtDo1IEb/ImNvvbJk
         oVfSdrwrLAWUgsUaafdD0tLDcmdv1MPh3bIoZPYsLhmxS3fF1h2gHwOkLzlV7jzfQIw6
         Ku4H615pRXKjosNMLQJu+XacajVm4J73YfCc4FyV4sOJjwPa0Uhnf5dTavrF6Ki6dg5Q
         LtaT/CYA4Md8os3Ca/N/EnOn8jWdS5vYbc7uO+BfV22fxzUnundnrRBcDcyInenY9GZx
         nREw==
X-Gm-Message-State: AC+VfDzAq8gEZwREbN7a4QcwtkDACGR2OZUxmXShFqYVQzP8644rfcr0
        5oBnX23X5EaYxwloBgKXnv7k9jLZEr8=
X-Google-Smtp-Source: ACHHUZ60Dvcmg9yn6x6jItZpYsK8SHvGNoQNoLt5zroMUrZ7XTBNRaflwaHpUdAIEjwtrrMmLLX2pg==
X-Received: by 2002:a5d:68c1:0:b0:307:8694:44e0 with SMTP id p1-20020a5d68c1000000b00307869444e0mr2830801wrw.55.1684440210425;
        Thu, 18 May 2023 13:03:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003f42ceb3bf4sm197180wmj.32.2023.05.18.13.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 13:03:30 -0700 (PDT)
Message-Id: <7fba1d22053f514b2defafed24b6eb5808cda1de.1684440205.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
References: <pull.1513.git.git.1684440205.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 May 2023 20:03:10 +0000
Subject: [PATCH 05/20] t1002-read-tree-m-u-2way: modernize test format
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

Some tests are still using the older four space indent format. Update
these to use tabs.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t1002-read-tree-m-u-2way.sh | 589 +++++++++++++++++-----------------
 1 file changed, 293 insertions(+), 296 deletions(-)

diff --git a/t/t1002-read-tree-m-u-2way.sh b/t/t1002-read-tree-m-u-2way.sh
index cdc077ce12d..a7c2ed0d7c0 100755
--- a/t/t1002-read-tree-m-u-2way.sh
+++ b/t/t1002-read-tree-m-u-2way.sh
@@ -37,315 +37,312 @@ check_cache_at () {
 	esac
 }
 
-test_expect_success \
-    setup \
-    'echo frotz >frotz &&
-     echo nitfol >nitfol &&
-     echo bozbar >bozbar &&
-     echo rezrov >rezrov &&
-     git update-index --add nitfol bozbar rezrov &&
-     treeH=$(git write-tree) &&
-     echo treeH $treeH &&
-     git ls-tree $treeH &&
-
-     echo gnusto >bozbar &&
-     git update-index --add frotz bozbar --force-remove rezrov &&
-     git ls-files --stage >M.out &&
-     treeM=$(git write-tree) &&
-     echo treeM $treeM &&
-     git ls-tree $treeM &&
-     cp bozbar bozbar.M &&
-     cp frotz frotz.M &&
-     cp nitfol nitfol.M &&
-     git diff-tree $treeH $treeM'
-
-test_expect_success \
-    '1, 2, 3 - no carry forward' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >1-3.out &&
-     cmp M.out 1-3.out &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol &&
-     check_cache_at bozbar clean &&
-     check_cache_at frotz clean &&
-     check_cache_at nitfol clean'
-
-test_expect_success \
-    '4 - carry forward local addition.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo "+100644 X 0	yomin" >expected &&
-     echo yomin >yomin &&
-     git update-index --add yomin &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >4.out &&
-     test_might_fail git diff -U0 --no-index M.out 4.out >4diff.out &&
-     compare_change 4diff.out expected &&
-     check_cache_at yomin clean &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol &&
-     echo yomin >yomin1 &&
-     diff yomin yomin1 &&
-     rm -f yomin1'
-
-test_expect_success \
-    '5 - carry forward local addition.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     read_tree_u_must_succeed -m -u $treeH &&
-     echo yomin >yomin &&
-     git update-index --add yomin &&
-     echo yomin yomin >yomin &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >5.out &&
-     test_might_fail git diff -U0 --no-index M.out 5.out >5diff.out &&
-     compare_change 5diff.out expected &&
-     check_cache_at yomin dirty &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol &&
-     : dirty index should have prevented -u from checking it out. &&
-     echo yomin yomin >yomin1 &&
-     diff yomin yomin1 &&
-     rm -f yomin1'
-
-test_expect_success \
-    '6 - local addition already has the same.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo frotz >frotz &&
-     git update-index --add frotz &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >6.out &&
-     test_cmp M.out 6.out &&
-     check_cache_at frotz clean &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol &&
-     echo frotz >frotz1 &&
-     diff frotz frotz1 &&
-     rm -f frotz1'
-
-test_expect_success \
-    '7 - local addition already has the same.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo frotz >frotz &&
-     git update-index --add frotz &&
-     echo frotz frotz >frotz &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >7.out &&
-     test_cmp M.out 7.out &&
-     check_cache_at frotz dirty &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp nitfol.M nitfol &&
-     : dirty index should have prevented -u from checking it out. &&
-     echo frotz frotz >frotz1 &&
-     diff frotz frotz1 &&
-     rm -f frotz1'
-
-test_expect_success \
-    '8 - conflicting addition.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo frotz frotz >frotz &&
-     git update-index --add frotz &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
-
-test_expect_success \
-    '9 - conflicting addition.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo frotz frotz >frotz &&
-     git update-index --add frotz &&
-     echo frotz >frotz &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
-
-test_expect_success \
-    '10 - path removed.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo rezrov >rezrov &&
-     git update-index --add rezrov &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >10.out &&
-     cmp M.out 10.out &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol
+test_expect_success setup '
+	echo frotz >frotz &&
+	echo nitfol >nitfol &&
+	echo bozbar >bozbar &&
+	echo rezrov >rezrov &&
+	git update-index --add nitfol bozbar rezrov &&
+	treeH=$(git write-tree) &&
+	echo treeH $treeH &&
+	git ls-tree $treeH &&
+
+	echo gnusto >bozbar &&
+	git update-index --add frotz bozbar --force-remove rezrov &&
+	git ls-files --stage >M.out &&
+	treeM=$(git write-tree) &&
+	echo treeM $treeM &&
+	git ls-tree $treeM &&
+	cp bozbar bozbar.M &&
+	cp frotz frotz.M &&
+	cp nitfol nitfol.M &&
+	git diff-tree $treeH $treeM
 '
 
-test_expect_success \
-    '11 - dirty path removed.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo rezrov >rezrov &&
-     git update-index --add rezrov &&
-     echo rezrov rezrov >rezrov &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
-
-test_expect_success \
-    '12 - unmatching local changes being removed.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo rezrov rezrov >rezrov &&
-     git update-index --add rezrov &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
-
-test_expect_success \
-    '13 - unmatching local changes being removed.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo rezrov rezrov >rezrov &&
-     git update-index --add rezrov &&
-     echo rezrov >rezrov &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
+test_expect_success '1, 2, 3 - no carry forward' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >1-3.out &&
+	cmp M.out 1-3.out &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol &&
+	check_cache_at bozbar clean &&
+	check_cache_at frotz clean &&
+	check_cache_at nitfol clean
+'
+
+test_expect_success '4 - carry forward local addition.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo "+100644 X 0	yomin" >expected &&
+	echo yomin >yomin &&
+	git update-index --add yomin &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >4.out &&
+	test_might_fail git diff -U0 --no-index M.out 4.out >4diff.out &&
+	compare_change 4diff.out expected &&
+	check_cache_at yomin clean &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol &&
+	echo yomin >yomin1 &&
+	diff yomin yomin1 &&
+	rm -f yomin1
+'
+
+test_expect_success '5 - carry forward local addition.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	read_tree_u_must_succeed -m -u $treeH &&
+	echo yomin >yomin &&
+	git update-index --add yomin &&
+	echo yomin yomin >yomin &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >5.out &&
+	test_might_fail git diff -U0 --no-index M.out 5.out >5diff.out &&
+	compare_change 5diff.out expected &&
+	check_cache_at yomin dirty &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol &&
+	: dirty index should have prevented -u from checking it out. &&
+	echo yomin yomin >yomin1 &&
+	diff yomin yomin1 &&
+	rm -f yomin1
+'
+
+test_expect_success '6 - local addition already has the same.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo frotz >frotz &&
+	git update-index --add frotz &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >6.out &&
+	test_cmp M.out 6.out &&
+	check_cache_at frotz clean &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol &&
+	echo frotz >frotz1 &&
+	diff frotz frotz1 &&
+	rm -f frotz1
+'
+
+test_expect_success '7 - local addition already has the same.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo frotz >frotz &&
+	git update-index --add frotz &&
+	echo frotz frotz >frotz &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >7.out &&
+	test_cmp M.out 7.out &&
+	check_cache_at frotz dirty &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp nitfol.M nitfol &&
+	: dirty index should have prevented -u from checking it out. &&
+	echo frotz frotz >frotz1 &&
+	diff frotz frotz1 &&
+	rm -f frotz1
+'
+
+test_expect_success '8 - conflicting addition.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo frotz frotz >frotz &&
+	git update-index --add frotz &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
+
+test_expect_success '9 - conflicting addition.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo frotz frotz >frotz &&
+	git update-index --add frotz &&
+	echo frotz >frotz &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
+
+test_expect_success '10 - path removed.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo rezrov >rezrov &&
+	git update-index --add rezrov &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >10.out &&
+	cmp M.out 10.out &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol
+'
+
+test_expect_success '11 - dirty path removed.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo rezrov >rezrov &&
+	git update-index --add rezrov &&
+	echo rezrov rezrov >rezrov &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
+
+test_expect_success '12 - unmatching local changes being removed.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo rezrov rezrov >rezrov &&
+	git update-index --add rezrov &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
+
+test_expect_success '13 - unmatching local changes being removed.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo rezrov rezrov >rezrov &&
+	git update-index --add rezrov &&
+	echo rezrov >rezrov &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
 
 cat >expected <<EOF
 -100644 X 0	nitfol
 +100644 X 0	nitfol
 EOF
 
-test_expect_success \
-    '14 - unchanged in two heads.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo nitfol nitfol >nitfol &&
-     git update-index --add nitfol &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >14.out &&
-     test_must_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
-     compare_change 14diff.out expected &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     check_cache_at nitfol clean &&
-     echo nitfol nitfol >nitfol1 &&
-     diff nitfol nitfol1 &&
-     rm -f nitfol1'
-
-test_expect_success \
-    '15 - unchanged in two heads.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo nitfol nitfol >nitfol &&
-     git update-index --add nitfol &&
-     echo nitfol nitfol nitfol >nitfol &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >15.out &&
-     test_must_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
-     compare_change 15diff.out expected &&
-     check_cache_at nitfol dirty &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     echo nitfol nitfol nitfol >nitfol1 &&
-     diff nitfol nitfol1 &&
-     rm -f nitfol1'
-
-test_expect_success \
-    '16 - conflicting local change.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo bozbar bozbar >bozbar &&
-     git update-index --add bozbar &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
-
-test_expect_success \
-    '17 - conflicting local change.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo bozbar bozbar >bozbar &&
-     git update-index --add bozbar &&
-     echo bozbar bozbar bozbar >bozbar &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
-
-test_expect_success \
-    '18 - local change already having a good result.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo gnusto >bozbar &&
-     git update-index --add bozbar &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >18.out &&
-     test_cmp M.out 18.out &&
-     check_cache_at bozbar clean &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol
+test_expect_success '14 - unchanged in two heads.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo nitfol nitfol >nitfol &&
+	git update-index --add nitfol &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >14.out &&
+	test_must_fail git diff -U0 --no-index M.out 14.out >14diff.out &&
+	compare_change 14diff.out expected &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	check_cache_at nitfol clean &&
+	echo nitfol nitfol >nitfol1 &&
+	diff nitfol nitfol1 &&
+	rm -f nitfol1
 '
 
-test_expect_success \
-    '19 - local change already having a good result, further modified.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo gnusto >bozbar &&
-     git update-index --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >19.out &&
-     test_cmp M.out 19.out &&
-     check_cache_at bozbar dirty &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol &&
-     echo gnusto gnusto >bozbar1 &&
-     diff bozbar bozbar1 &&
-     rm -f bozbar1'
-
-test_expect_success \
-    '20 - no local change, use new tree.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo bozbar >bozbar &&
-     git update-index --add bozbar &&
-     read_tree_u_must_succeed -m -u $treeH $treeM &&
-     git ls-files --stage >20.out &&
-     test_cmp M.out 20.out &&
-     check_cache_at bozbar clean &&
-     test_cmp bozbar.M bozbar &&
-     test_cmp frotz.M frotz &&
-     test_cmp nitfol.M nitfol
+test_expect_success '15 - unchanged in two heads.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo nitfol nitfol >nitfol &&
+	git update-index --add nitfol &&
+	echo nitfol nitfol nitfol >nitfol &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >15.out &&
+	test_must_fail git diff -U0 --no-index M.out 15.out >15diff.out &&
+	compare_change 15diff.out expected &&
+	check_cache_at nitfol dirty &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	echo nitfol nitfol nitfol >nitfol1 &&
+	diff nitfol nitfol1 &&
+	rm -f nitfol1
 '
 
-test_expect_success \
-    '21 - no local change, dirty cache.' \
-    'rm -f .git/index nitfol bozbar rezrov frotz &&
-     read_tree_u_must_succeed --reset -u $treeH &&
-     echo bozbar >bozbar &&
-     git update-index --add bozbar &&
-     echo gnusto gnusto >bozbar &&
-     ! read_tree_u_must_succeed -m -u $treeH $treeM'
+test_expect_success '16 - conflicting local change.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo bozbar bozbar >bozbar &&
+	git update-index --add bozbar &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
+
+test_expect_success '17 - conflicting local change.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo bozbar bozbar >bozbar &&
+	git update-index --add bozbar &&
+	echo bozbar bozbar bozbar >bozbar &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
+
+test_expect_success '18 - local change already having a good result.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo gnusto >bozbar &&
+	git update-index --add bozbar &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >18.out &&
+	test_cmp M.out 18.out &&
+	check_cache_at bozbar clean &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol
+'
+
+test_expect_success '19 - local change already having a good result, further modified.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo gnusto >bozbar &&
+	git update-index --add bozbar &&
+	echo gnusto gnusto >bozbar &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >19.out &&
+	test_cmp M.out 19.out &&
+	check_cache_at bozbar dirty &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol &&
+	echo gnusto gnusto >bozbar1 &&
+	diff bozbar bozbar1 &&
+	rm -f bozbar1
+'
+
+test_expect_success '20 - no local change, use new tree.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo bozbar >bozbar &&
+	git update-index --add bozbar &&
+	read_tree_u_must_succeed -m -u $treeH $treeM &&
+	git ls-files --stage >20.out &&
+	test_cmp M.out 20.out &&
+	check_cache_at bozbar clean &&
+	test_cmp bozbar.M bozbar &&
+	test_cmp frotz.M frotz &&
+	test_cmp nitfol.M nitfol
+'
+
+test_expect_success '21 - no local change, dirty cache.' '
+	rm -f .git/index nitfol bozbar rezrov frotz &&
+	read_tree_u_must_succeed --reset -u $treeH &&
+	echo bozbar >bozbar &&
+	git update-index --add bozbar &&
+	echo gnusto gnusto >bozbar &&
+	! read_tree_u_must_succeed -m -u $treeH $treeM
+'
 
 # Also make sure we did not break DF vs DF/DF case.
-test_expect_success \
-    'DF vs DF/DF case setup.' \
-    'rm -f .git/index &&
-     echo DF >DF &&
-     git update-index --add DF &&
-     treeDF=$(git write-tree) &&
-     echo treeDF $treeDF &&
-     git ls-tree $treeDF &&
-
-     rm -f DF &&
-     mkdir DF &&
-     echo DF/DF >DF/DF &&
-     git update-index --add --remove DF DF/DF &&
-     treeDFDF=$(git write-tree) &&
-     echo treeDFDF $treeDFDF &&
-     git ls-tree $treeDFDF &&
-     git ls-files --stage >DFDF.out'
-
-test_expect_success \
-    'DF vs DF/DF case test.' \
-    'rm -f .git/index &&
-     rm -fr DF &&
-     echo DF >DF &&
-     git update-index --add DF &&
-     read_tree_u_must_succeed -m -u $treeDF $treeDFDF &&
-     git ls-files --stage >DFDFcheck.out &&
-     test_cmp DFDF.out DFDFcheck.out &&
-     check_cache_at DF/DF clean'
+test_expect_success 'DF vs DF/DF case setup.' '
+	rm -f .git/index &&
+	echo DF >DF &&
+	git update-index --add DF &&
+	treeDF=$(git write-tree) &&
+	echo treeDF $treeDF &&
+	git ls-tree $treeDF &&
+
+	rm -f DF &&
+	mkdir DF &&
+	echo DF/DF >DF/DF &&
+	git update-index --add --remove DF DF/DF &&
+	treeDFDF=$(git write-tree) &&
+	echo treeDFDF $treeDFDF &&
+	git ls-tree $treeDFDF &&
+	git ls-files --stage >DFDF.out
+'
+
+test_expect_success 'DF vs DF/DF case test.' '
+	rm -f .git/index &&
+	rm -fr DF &&
+	echo DF >DF &&
+	git update-index --add DF &&
+	read_tree_u_must_succeed -m -u $treeDF $treeDFDF &&
+	git ls-files --stage >DFDFcheck.out &&
+	test_cmp DFDF.out DFDFcheck.out &&
+	check_cache_at DF/DF clean
+'
 
 test_done
-- 
gitgitgadget

