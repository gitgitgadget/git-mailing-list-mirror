Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 87E8020229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756383AbcJWJ1b (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34975 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756329AbcJWJ1X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id o81so5222999wma.2
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TUKU71MHKGDLM4EJMs/H4vEJ/4PFbcxSvwbbrMmjmiQ=;
        b=adSx95V2u2S5j7AnPddltsQKzNRdnp5pRRQSp1HiL7h53TN6EX5mlvXr8vkbPGQ5Nh
         UQ9gvUatqeKG4Ggnp5N+ikTw3XEEDbKb8Buw36eEtPGoQLR1kP3K6DfAqOe8cookv8El
         JNy7DMjd9fZ8mmaOQr2BaXQQHO34Mq80zxcTIgFOhVcvnlKFqEW+2h5pngcvv/+WLzxU
         EWpjF89e0JVyYMByLOlBavfaZWSX7kcNT1w4qKy1t8scn/PwjKIhpAyq9sX9XIUFavOE
         kwo/pcWelq+kc/ZQJAmTj1BwGSU72vtmUlNXp+Fv4y0BqTMq8rnyb5IeZX2VPav9wSK5
         E70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TUKU71MHKGDLM4EJMs/H4vEJ/4PFbcxSvwbbrMmjmiQ=;
        b=NcppL2BGaGUAf2q2SOO4n7z+564S8zoWVu/fUiik/hdSpG+XCl6eDtcI66DpMBm8Nh
         7d6QfAQqU5U5jFaF5kqjEdOw7B8JaVrcH2qfIwysM/YtRf3pgP93RLvoMtknynQovQlC
         BApQPKCM+eU36CKj6mE722Z8/EIikAbhLSmy5YI+xtrYGDiFnRgfyuaWfonbOYMbLCcE
         PpZE4vmqFjo5WOGxYOtzq0J5hzeU8l6r0mhokxlpDj/CBYZ3WG4NpWFPiGKDOT724nNT
         DVt1e//4XVoHF5r7+TcdHPk2IUXOts6cwNY1/vqr0c6SVoGc3kN77cjxE5tUVPSm2kvY
         0RuQ==
X-Gm-Message-State: AA6/9RmgmEhQvxibVQBzeGAQJhF1T6Np39T75FmjBbMRY/PP0UJ4s/U1mVJM4rwndiGBJw==
X-Received: by 10.28.109.146 with SMTP id b18mr10955883wmi.108.1477214842528;
        Sun, 23 Oct 2016 02:27:22 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:21 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 11/19] t1700: add tests for splitIndex.maxPercentChange
Date:   Sun, 23 Oct 2016 11:26:40 +0200
Message-Id: <20161023092648.12086-12-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index 507a1dd..f03addf 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -238,4 +238,76 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual &&
+	: >four &&
+	git update-index --add four &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	four
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
+	git config --unset splitIndex.maxPercentChange &&
+	: >five &&
+	git update-index --add five &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual &&
+	: >six &&
+	git update-index --add six &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	six
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check splitIndex.maxPercentChange set to 0' '
+	git config splitIndex.maxPercentChange 0 &&
+	: >seven &&
+	git update-index --add seven &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual &&
+	: >eight &&
+	git update-index --add eight &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<EOF &&
+$BASE
+replacements:
+deletions:
+EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.1.462.g7e1e03a

