Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F1C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86EC322240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLp7Cmss"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgKMMKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgKMMKt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:10:49 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37D4C0617A6
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:48 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so8284390wmi.0
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NKR8/TOOCNoRIdKvR8AV7cjS9Gl1SgDrV3MY2xgjQI=;
        b=MLp7CmssfOK6F1r6SC4pbfZnIYq2DOIynDbzYoP58fPLUuq2oCiubD5c2DP2GvM5y+
         n1AtM5O1HEpGRvTCk+TG4BgOmjYQz2nZf1SVH7mpEtj31ayHTLQbdUuJJZtrnKyGkm/u
         kPRakRAu7vFaDmPaKb1sE0kz/DiJ241pFrnRbr+wKcsrTfUyXI7iggm6W5uFG+mfiVAs
         ksCUzUjxlzXlUGmNEg/4bJ2Z19WCi8h+C0/1bo9XmWYgqOBJRtRF+9XBEh5mkUdMcK85
         cnf4GjrVTcs07V+/ea17tat+kTRPY7XrYgFmK2xkqVSGI/Xa2Fv/Sz57mmoDWrXJCEdh
         ECJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7NKR8/TOOCNoRIdKvR8AV7cjS9Gl1SgDrV3MY2xgjQI=;
        b=nYHHk32FLLyIopcYM564diFDMT0RLTrZ0bKpH6JfsfcsiJGl0GlnR6mP5l3VfnaNcp
         ivvLF39OgMliSURgE4ZPIBJVGDEPDlAzw6SmfLZOhHRT3FK7mThKNFMIoEsus5K2EOY7
         sPRqu7BbbKc+OWXIiN+8MAA2n2kE+AG8gXnaV5ZCYd06jasmsTJdtnxRkUEZnM2lPi9O
         oXjuIroz8G7iSor1NYaTb8SW9xQIjLiRhuclLYr644xfLzZbtEMXnAJKIbmviGCPYbkn
         FlBLrXNMNGLSkhjx+msbnNPd5qtLExFFV09rgyNzyEQctpjeeH+gPgVuvehEwuYGqJZe
         hyhQ==
X-Gm-Message-State: AOAM533BwG7Wm+7d3pUABwZ5KYGP4Fvkl499FDOykVtA+1jagn29i/vj
        P5SFxwIrKga7fN9LAsQt3bcJi24kquk=
X-Google-Smtp-Source: ABdhPJzNQDXJvTSgztsxuPCo1obB1VAYsEZIcEb3FferJfB/LLPaNtVM5mlpBYy2O86I9nX4dZpAVQ==
X-Received: by 2002:a1c:bbc4:: with SMTP id l187mr2348576wmf.133.1605269447519;
        Fri, 13 Nov 2020 04:10:47 -0800 (PST)
Received: from ylate.lan (atoulouse-654-1-426-233.w2-6.abo.wanadoo.fr. [2.6.209.233])
        by smtp.googlemail.com with ESMTPSA id g138sm10083697wme.39.2020.11.13.04.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:10:47 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v4 01/12] t6027: modernise tests
Date:   Fri, 13 Nov 2020 12:04:17 +0100
Message-Id: <20201113110428.21265-2-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201113110428.21265-1-alban.gruin@gmail.com>
References: <20201005122646.27994-1-alban.gruin@gmail.com>
 <20201113110428.21265-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some tests in t6027 uses a if/then/else to check if a command failed or
not, but we have the `test_must_fail' function to do it correctly for us
nowadays.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 t/t6407-merge-binary.sh | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index 4e6c7cb77e..071d3f7343 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,7 +5,6 @@ test_description='ask merge-recursive to merge binary files'
 . ./test-lib.sh
 
 test_expect_success setup '
-
 	cat "$TEST_DIRECTORY"/test-binary-1.png >m &&
 	git add m &&
 	git ls-files -s | sed -e "s/ 0	/ 1	/" >E1 &&
@@ -35,33 +34,19 @@ test_expect_success setup '
 '
 
 test_expect_success resolve '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s resolve master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s resolve master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_expect_success recursive '
-
 	rm -f a* m* &&
 	git reset --hard anchor &&
-
-	if git merge -s recursive master
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		git ls-files -s >current
-		test_cmp expect current
-	fi
+	test_must_fail git merge -s recursive master &&
+	git ls-files -s >current &&
+	test_cmp expect current
 '
 
 test_done
-- 
2.20.1

