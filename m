Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EABA1FAF4
	for <e@80x24.org>; Sun,  5 Feb 2017 20:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754009AbdBEU0a (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Feb 2017 15:26:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35921 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753034AbdBEU0W (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2017 15:26:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id r18so17899230wmd.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2017 12:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V7+0qvsC1938WuIUsSDJJ1lvEIGH8pKKoXrOePQti+w=;
        b=TnEpx/+4LhpzK7B8Rr1c183Uhr3LIqU9tqoJ1LiLGxLcFxV0QYN4hTBZI2mqIlxLrr
         ggycICwn9lDfu6SCnOtI28a0TBjfI5V4bgPTPqC8Dz3nRHpEe8ALcKAOD07TZuRiedLH
         Zwese7WI1lvTJVpVtQbSbqL5vFcOlCuWSRBlfj8keHplqwzt7N9kfLNdQyjGSr9/pk+z
         kwTGqgCYhOc03Mfr9yvB3oHgiiA6k7lJU19rm66qQmbcnlRzO0WBwktB9od8LMgE0+lh
         moXiX3csxwGxAPjfLnKFPAlE3+LqwQnATa/nktqwPKsMO0ytG4sLeT7QJGQQ7WRCKiRK
         hxvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V7+0qvsC1938WuIUsSDJJ1lvEIGH8pKKoXrOePQti+w=;
        b=oWCFl1Wtzum6EEj6I/osDN8IhCZzjanCPV2r+9DERluxt74GVcD7rDt0zksFeKPx8S
         wmV5M+xsocsMU13DpGWx4Ln867rBi7j35JdYuL30AeEyX/3hL8RbbLz5z2ar1pXH7mbU
         V2FfzIJ8+Ik2EZQ6vU1lSl+JzOobv/sbj3TAsUcbt/eGJh/hL76QtEyTEa9LHkcarBDd
         z9bzvoaNm5A31Ub4kPnazvTDyMIWUpI6Qx4pisH3ovzJxX1mCn0Z3Qjg1jfmit0jnXIN
         2hcjcbDnCUlqhh7ponavCcuY6vCpOWX9FuZkxz7nAokNbndcBHp3ieXrTUImMf9gyV28
         sOiA==
X-Gm-Message-State: AIkVDXL6hvi4J7dDtGBdumkVEmxDV1qypiV/c+EW1HfBoz+oe+9EUe3CkLuGI6NQkF8J5A==
X-Received: by 10.223.154.109 with SMTP id z100mr6294124wrb.145.1486326381257;
        Sun, 05 Feb 2017 12:26:21 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id l10sm56754520wrb.44.2017.02.05.12.26.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2017 12:26:20 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Stephan Beyer <s-beyer@gmx.net>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/5] stash: add test for the create command line arguments
Date:   Sun,  5 Feb 2017 20:26:40 +0000
Message-Id: <20170205202642.14216-4-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc0.208.g81c5d00b20.dirty
In-Reply-To: <20170205202642.14216-1-t.gummerer@gmail.com>
References: <20170129201604.30445-1-t.gummerer@gmail.com>
 <20170205202642.14216-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no test showing the expected behaviour of git stash
create's command line arguments.  Add a test for that to show the
current expected behaviour and to make sure future refactorings don't
break those expectations.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 0171b824c9..21cb70dc74 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -784,4 +784,22 @@ test_expect_success 'push -m shows right message' '
 	test_cmp expect actual
 '
 
+test_expect_success 'create stores correct message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create "create test message") &&
+	echo "On master: create test message" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create with multiple arguments for the message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create test untracked) &&
+	echo "On master: test untracked" >expect &&
+	git show --pretty=%s ${STASH_ID} | head -n1 >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.12.0.rc0.208.g81c5d00b20.dirty

