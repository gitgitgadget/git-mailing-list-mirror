Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974CAC433DB
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4509964F21
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 20:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbhCQU5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 16:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbhCQU4h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 16:56:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62260C06175F
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso2125466wmi.0
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 13:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9lRePL16n1cjKLtpr7G4rLpbGtaunYe7FfO4+GIWbc4=;
        b=FpnS6R/A5XpcqcU8wSzGzpJC5TK7rUWslLMDmUUsjO/9D3RuOH260ss3EGjABqlFD8
         z2tSD5spxOBxfJ1K+kppfHAkMSMidRvlLcWq+F0IJiVtzsmcAas6iEWipKDZkvH5TPBd
         ut5QI78vNMoxrZ+MxEgXkoydUB0jmzCak29MLxKDQBNqXKIU4BMJkxi23iJKU2j0NhzK
         bxrMguJ11Iz8EjBp4MYdG4AkjHmWKLHRUCk3rearLdNMMe3eLS6M0lLfNGd1b9FzOWkA
         V9Wh4f2NU/cIQV/TCYRwF/pt5vufgftW7EyRVnQdG4FU6Z9vnifPCOVMgbLNL08sjmdU
         4TCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9lRePL16n1cjKLtpr7G4rLpbGtaunYe7FfO4+GIWbc4=;
        b=Yq4ihQLWOV9aKpbO1SsWQyn6cAPPY3FJUvs6Nq8NP0hdVxdTL+hcfiVSIAqRvcBV/6
         pRRIP1U76hK6tB+/LGJzY4q88EbmQcqK1BxCVI0JoSR2UIoSQZcC1LEkO2UVNHv+RtA4
         8lyHs1wWpaFdh68wui/Puyf0inaBF43CGUWmQVMgDheOwYnqC1nNW3mI1eDoSvGWdd41
         StxkiBQHtxvpVE7U5SgJt/3wD/4OX6sjo5TpknUsH0Q2uPDOFKhIpy139PUvCBtKrpUM
         TvqS7EuyUVe2rKRTEtwxhs/iBzHl6TkYfWSoMM2yVZkobeyeqjUF5jcfvD7oTA3T7BeZ
         xTjA==
X-Gm-Message-State: AOAM5310dzC4sl1e/JYtlMOCFytjvJJVKNSS/lzc9lln1U0zd49WU3Z8
        OKIX2dV5cu61DN4ewUZEdziEBqK3Qis=
X-Google-Smtp-Source: ABdhPJyqNbuxbWXEUGkd0zHbQY0K5IJZEdJb40j/MbavDRHBSCUCCSHWtpJtnZUkWUxDO9oloOf2BA==
X-Received: by 2002:a7b:cd15:: with SMTP id f21mr554076wmj.43.1616014595123;
        Wed, 17 Mar 2021 13:56:35 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-299-135.w86-199.abo.wanadoo.fr. [86.199.82.135])
        by smtp.googlemail.com with ESMTPSA id g5sm158452wrq.30.2021.03.17.13.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 13:56:34 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v7 01/15] t6407: modernise tests
Date:   Wed, 17 Mar 2021 21:49:25 +0100
Message-Id: <20210317204939.17890-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210317204939.17890-1-alban.gruin@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t6407 uses a if/then/else to check if a command failed or
not, but we have the `test_must_fail' function to do it correctly for us
nowadays.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6407-merge-binary.sh | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index d4273f2575..bd2696367b 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -8,7 +8,6 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success setup '
-
 	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
 	git add m &&
 	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
@@ -38,33 +37,19 @@ test_expect_success setup '
 '
 
 test_expect_success resolve '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s resolve main
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s resolve main &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_expect_success recursive '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s recursive main
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s recursive main &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_done
-- 
2.31.0

