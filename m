Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD92C4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554A8239D2
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 17:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUuv412Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1787086AbgJZRCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 13:02:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34933 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775649AbgJZRBy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 13:01:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id n15so13522757wrq.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 10:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=eKZPRv3w8Tguq142buKUGRuKN/QgSTIc/MTJNwMPLYQ=;
        b=WUuv412ZRxNssqacZGQi69wzQ8VPB6KF56jMtE+86WYuuTFy2Yg/SGOTvJ4JrPzwL0
         NlyaHb9b4DOpRZlNdb//KBTUnx7S1lK8A3cDqTYbDsLllDoSmkt5T2gk0hTB+v/KGioo
         aA7eHnGRs5QZgY4GvZYlKKMsqGx27sdzW9RSWyC3l8MsXqbunze2xw41JQ476EZG9fvV
         Y+ryxmNHvonLa+RVedqTQWbgsnM7s+6lwuHqsBk4MaPE55AZQ/TOSDo6acopAC3+GyDG
         K1Eb1FY1pf+iOaaFx4alsS6+lkK8pUPmLn+rmd2+MbpfLIpWJ89k3yVoTiIO+kNJTQJx
         PRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=eKZPRv3w8Tguq142buKUGRuKN/QgSTIc/MTJNwMPLYQ=;
        b=kls0Br059BsfQ6x5eAVovsOgZ0nZVJsBQBN31/n1VDYMUO1Dt6Q8PCs0ORswyZz/3w
         21twp6NWzsic8fXLP5KAnfMNHUKrDv6n2TvRW9KxMH4Luq0CcrRLujMa5n5pvvc9qmbd
         x1I8/tN/HjzIS9mgo4DGiAqcqiz7HpAjgbb77Z52MY02hnR7Q+fdafF6pcuG+0mPpK66
         QeKooOOqCx8lUf85hgQazH0EnyGYJPOAvPgu3W6+QULp2cgymzbzJVkMXVmuP3m0OFSH
         E36jDOfCTJpaOv12sWSESM8CMaadYbdtfZdLfDO4Z1TgA1DiE27E3+2HTNS9fGoRqie4
         kPPw==
X-Gm-Message-State: AOAM531cr4tIfxhJEqRYZURzG9IJMaIP4D/PPD+hzEO2K594JChDu3zf
        vuIaWMc7715LQs+jNsnGctXkwGofU4U=
X-Google-Smtp-Source: ABdhPJwD8wKkKtVyaUGY1A7MRX7E/0i+9WwjI5JFBkZS0FtUovyHfK0wxp3T64Ub9vAmmTC749s/PA==
X-Received: by 2002:adf:f4d2:: with SMTP id h18mr17924701wrp.99.1603731711563;
        Mon, 26 Oct 2020 10:01:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j7sm25296237wrn.81.2020.10.26.10.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 10:01:51 -0700 (PDT)
Message-Id: <4f32450b085c921219b4639572e8fc2d5150b719.1603731704.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
References: <pull.769.git.1603468885.gitgitgadget@gmail.com>
        <pull.769.v2.git.1603731704.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 17:01:41 +0000
Subject: [PATCH v2 6/9] merge tests: expect slight differences in output for
 recursive vs. ort
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The ort merge strategy has some slight differences in commit
descriptions (shortened hashes), stdout vs stderr, and in conflict
messages.  Also, builtin/merge.c reports usage of "ort" as "Merge made
by the 'ort' strategy" -- while it is meant as a drop in replacement for
"recursive" it is not yet treated as though it is recursive.  Update the
testcases to expect different output for the different merge backends.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6402-merge-rename.sh       | 14 ++++++++++++--
 t/t6437-submodule-merge.sh    | 25 +++++++++++++++++++++----
 t/t7602-merge-octopus-many.sh |  6 ++++++
 3 files changed, 39 insertions(+), 6 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 47d4434d64..3f64f62224 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -320,7 +320,12 @@ test_expect_success 'Rename+D/F conflict; renamed file merges but dir in way' '
 
 	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_i18ngrep "Auto-merging dir" output &&
-	test_i18ngrep "Adding as dir~HEAD instead" output &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_i18ngrep "moving it to dir~HEAD instead" output
+	else
+		test_i18ngrep "Adding as dir~HEAD instead" output
+	fi &&
 
 	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
@@ -342,7 +347,12 @@ test_expect_success 'Same as previous, but merged other way' '
 	! grep "error: refusing to lose untracked file at" errors &&
 	test_i18ngrep "CONFLICT (modify/delete): dir/file-in-the-way" output &&
 	test_i18ngrep "Auto-merging dir" output &&
-	test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output &&
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		test_i18ngrep "moving it to dir~renamed-file-has-no-conflicts instead" output
+	else
+		test_i18ngrep "Adding as dir~renamed-file-has-no-conflicts instead" output
+	fi &&
 
 	test 3 -eq "$(git ls-files -u | wc -l)" &&
 	test 2 -eq "$(git ls-files -u dir/file-in-the-way | wc -l)" &&
diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
index 6a1e5f8232..3ead2b726f 100755
--- a/t/t6437-submodule-merge.sh
+++ b/t/t6437-submodule-merge.sh
@@ -127,7 +127,12 @@ test_expect_success 'merging should conflict for non fast-forward' '
 	 git checkout -b test-nonforward b &&
 	 (cd sub &&
 	  git rev-parse sub-d > ../expect) &&
-	 test_must_fail git merge c 2> actual  &&
+	  if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	  then
+		test_must_fail git merge c >actual
+	  else
+		test_must_fail git merge c 2> actual
+	  fi &&
 	 grep $(cat expect) actual > /dev/null &&
 	 git reset --hard)
 '
@@ -138,9 +143,21 @@ test_expect_success 'merging should fail for ambiguous common parent' '
 	(cd sub &&
 	 git checkout -b ambiguous sub-b &&
 	 git merge sub-c &&
-	 git rev-parse sub-d > ../expect1 &&
-	 git rev-parse ambiguous > ../expect2) &&
-	test_must_fail git merge c 2> actual &&
+	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	 then
+		git rev-parse --short sub-d >../expect1 &&
+		git rev-parse --short ambiguous >../expect2
+	 else
+		git rev-parse sub-d > ../expect1 &&
+		git rev-parse ambiguous > ../expect2
+	 fi
+	 ) &&
+	 if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	 then
+		test_must_fail git merge c >actual
+	 else
+		test_must_fail git merge c 2> actual
+	 fi &&
 	grep $(cat expect1) actual > /dev/null &&
 	grep $(cat expect2) actual > /dev/null &&
 	git reset --hard)
diff --git a/t/t7602-merge-octopus-many.sh b/t/t7602-merge-octopus-many.sh
index 6abe441ae3..13859ec859 100755
--- a/t/t7602-merge-octopus-many.sh
+++ b/t/t7602-merge-octopus-many.sh
@@ -77,6 +77,12 @@ Merge made by the 'recursive' strategy.
 EOF
 
 test_expect_success 'merge reduces irrelevant remote heads' '
+	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
+	then
+		mv expected expected.tmp &&
+		sed s/recursive/ort/ expected.tmp >expected &&
+		rm expected.tmp
+	fi &&
 	GIT_MERGE_VERBOSITY=0 git merge c4 c5 >actual &&
 	test_i18ncmp expected actual
 '
-- 
gitgitgadget

