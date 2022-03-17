Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E52CC433F5
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 19:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiCQTzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 15:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiCQTzN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 15:55:13 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CAD21591E
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r6so8834754wrr.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 12:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ex5yvJTWqH8czVnM6+8lZK47OLOhVIj6R1HdqkFqoHk=;
        b=i5OTxedmuQokX6ecO0grvubdL7ZXk32wwy9Y9nMEg1/F2PACfX18mVieuoqvTyyCTJ
         vej0YjhVogywf0mnwtubyV/LE+Whp3ZyCJctugIYhk0GfPb5IO4Z6b0zVrTWYbcf54Mx
         YmYF8wrRFgvQRAgjiO+DJcBwxxinWRKTQJ1XeunXtjDUgQMZc3m+g5Wr2oZoAl0d2945
         foXiqbAL7ETPUvv508roYou1I1kHChFDoIVaagJt8mKKOyMQqLaCfAk5EOhmAc8OJUqr
         lPZd/Hisnofj9lGDTwxqReBUdT++tTRoi77D9BEczEGWKPbEbgTTHGUfY3qUqPq2Ate9
         MN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ex5yvJTWqH8czVnM6+8lZK47OLOhVIj6R1HdqkFqoHk=;
        b=z6M3fgrxBaojTR/QfNVdKtHdRvMCcoxNx+oBqQm+f4kN/UYShGpbSlXfkGM3k6/B2m
         Os4jgvAfoZvwSeXnOTZt8sD7RPF7Ofnm1Z4u7En/xkWi2XYNCP6UkPBVSsUM3St8nS9f
         uaqVAO3OJ6J7PBPrlyRK2nrf13NYWa2kAX36CtrSiQ26Cz9aD9ejAb5TBE8L3TiI/iMX
         13JHTqLnPpSD8Ubyj3whOQ841jOtNNdPyPp2x9v0GSIRKk6nJGI7jqGO+Urpsn/prLoV
         pDC2pFIZFMwW92yCloXpDFrxmxOyi65Gu8qcV+jcOLqewbv7hw5B0wpSwo55ZYGAub9t
         YlYQ==
X-Gm-Message-State: AOAM5311UnxCtsMULxokqF1Y5LbjZcnla47ZTju0LzEkW0/BorAaOG2N
        y6Bf/dnWRdOOnlR2cPmABkOTwq/G/f0=
X-Google-Smtp-Source: ABdhPJyxhQEWcT3pqsOFNrG0prINgSfKwRROJ8/NPyZual4UNwO2m+2E3O1FtTQ11M+/n2PuBl7jlQ==
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id e15-20020a5d6d0f000000b0020391571c48mr5390531wrq.192.1647546830902;
        Thu, 17 Mar 2022 12:53:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm4652003wrm.53.2022.03.17.12.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 12:53:50 -0700 (PDT)
Message-Id: <5c40e116eba00b5b1a64191c6adf211d326e7f96.1647546828.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
References: <pull.1226.v3.git.git.1647487001.gitgitgadget@gmail.com>
        <pull.1226.v4.git.git.1647546828.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Mar 2022 19:53:47 +0000
Subject: [PATCH v4 2/3] rebase: use test_commit helper in setup
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

To prepare for the next commit that will test rebase with oids instead
of branch names, update the rebase setup test to add a couple of tags we
can use. This uses the test_commit helper so we can replace some lines
that add a commit manually.

Setting logAllRefUpdates is not necessary because it's on by default for
repositories with a working tree.

Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t3400-rebase.sh | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 5c4073f06d6..2fb3fabe60e 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -18,10 +18,7 @@ GIT_AUTHOR_EMAIL=bogus@email@address
 export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
 
 test_expect_success 'prepare repository with topic branches' '
-	git config core.logAllRefUpdates true &&
-	echo First >A &&
-	git update-index --add A &&
-	git commit -m "Add A." &&
+	test_commit "Add A." A First First &&
 	git checkout -b force-3way &&
 	echo Dummy >Y &&
 	git update-index --add Y &&
@@ -32,17 +29,13 @@ test_expect_success 'prepare repository with topic branches' '
 	git mv A D/A &&
 	git commit -m "Move A." &&
 	git checkout -b my-topic-branch main &&
-	echo Second >B &&
-	git update-index --add B &&
-	git commit -m "Add B." &&
+	test_commit "Add B." B Second Second &&
 	git checkout -f main &&
 	echo Third >>A &&
 	git update-index A &&
 	git commit -m "Modify A." &&
 	git checkout -b side my-topic-branch &&
-	echo Side >>C &&
-	git add C &&
-	git commit -m "Add C" &&
+	test_commit --no-tag "Add C" C Side &&
 	git checkout -f my-topic-branch &&
 	git tag topic
 '
@@ -119,10 +112,7 @@ test_expect_success 'rebase off of the previous branch using "-"' '
 test_expect_success 'rebase a single mode change' '
 	git checkout main &&
 	git branch -D topic &&
-	echo 1 >X &&
-	git add X &&
-	test_tick &&
-	git commit -m prepare &&
+	test_commit prepare X 1 &&
 	git checkout -b modechange HEAD^ &&
 	echo 1 >X &&
 	git add X &&
-- 
gitgitgadget

