Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75CC51F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbdB0SIc (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:08:32 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33337 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751506AbdB0SI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:08:27 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so14648817wmv.0
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RHnroYSOCsH2MYQjZEGObxscflYM3xWu7DT5wY94Iyw=;
        b=YAaYJ25z89vWXywwe8a0zN6uVWPKGeNWaqRKsKhOmwmjfVDsH8yVYqOGhgUVDvN84I
         zflI+zSeTIzbAkRMhy4b07Roev/h1pmnrYcK4nlXhkVPE7wa3VNeW5yIj8gR1pvd/wIq
         lpD6pYGTQF6EbQ1sayCGbznwVq618b/Ju5DzALWQoUogOW1UAFX1Va3+L6c34ogEb5tU
         yvk7yiwkSnqKmaMJvHh3MgWViqIZ3h/iit3Xjyd9YksBHoDTAkc5q74ztSVe8NDnaby3
         xqoWqEQzxlZfv13+Bu+9EqWRWijp7Fa7FUXlwB3/n0lHSgU7qsapD/so6b9N1WDL5b0B
         e/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RHnroYSOCsH2MYQjZEGObxscflYM3xWu7DT5wY94Iyw=;
        b=EQ7HKsThFD1ahhWF83eecLX5NHmbtqLii+xp8wmULlAnrY/66SbHTh40W/+fMjlD4f
         iOBROoMZneBgK/v2xoYa6zoaD2FB4ldsH4IfU1HbhXgNzJuqdvs0boI8aU3oAcO4psCp
         Pb6FoMZKSY8ez7Z10rS1PvDKDWVruKfJixllUkkZ3f5q9D6yRZ8WWwirx9mnNrOB6X3Q
         uOFjPtSWaWSQdErcIpZlj0syHTcAXzvHMP2R5q6J+/WGxmjuJ0tBELmUWouT7K0RJRyT
         WFIB4G67Ct3vl44gLluRfqVdwc/Gob2WnuxwfOEvLv2FxuvnsZEVMQTcSoqAQUbVGc05
         KGWg==
X-Gm-Message-State: AMke39m+JnVrFqS1UkSkg9qkwQ7j1J1T9SpoRiJWiCqlUcHOvGWJ3Y8nAqzxereVKPK52Q==
X-Received: by 10.28.143.204 with SMTP id r195mr14905176wmd.32.1488218453719;
        Mon, 27 Feb 2017 10:00:53 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:52 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 12/22] t1700: add tests for splitIndex.maxPercentChange
Date:   Mon, 27 Feb 2017 19:00:09 +0100
Message-Id: <20170227180019.18666-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t1700-split-index.sh | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index df19b812fd..21f43903f8 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -238,4 +238,76 @@ test_expect_success 'set core.splitIndex config variable to false' '
 	test_cmp expect actual
 '
 
+test_expect_success 'set core.splitIndex config variable to true' '
+	git config core.splitIndex true &&
+	: >three &&
+	git update-index --add three &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	: >four &&
+	git update-index --add four &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	four
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check behavior with splitIndex.maxPercentChange unset' '
+	git config --unset splitIndex.maxPercentChange &&
+	: >five &&
+	git update-index --add five &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	: >six &&
+	git update-index --add six &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	six
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check splitIndex.maxPercentChange set to 0' '
+	git config splitIndex.maxPercentChange 0 &&
+	: >seven &&
+	git update-index --add seven &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual &&
+	: >eight &&
+	git update-index --add eight &&
+	BASE=$(test-dump-split-index .git/index | grep "^base") &&
+	test-dump-split-index .git/index | sed "/^own/d" >actual &&
+	cat >expect <<-EOF &&
+	$BASE
+	replacements:
+	deletions:
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.22.g0672473d40

