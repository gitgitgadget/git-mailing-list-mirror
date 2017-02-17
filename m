Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A92E3201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964803AbdBQWlL (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:41:11 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35296 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935072AbdBQWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:41:09 -0500
Received: by mail-wm0-f66.google.com with SMTP id u63so4783367wmu.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RhdB4E6tzyT0BJoGZQ1XuW1VzTOaKy1GoRr0Z6faXx0=;
        b=qjohxmEcyyb0zeqO2WWZnoRgzO1N5zMiarOFiEBNVJIZt0cJBGpPuywfaWMPmQNxOE
         6q7kqFGQi/i0UyCPUBSONrYdDHcjJzRzN8uJ5uPOko1SUF1VfxScbaj0aCx34DdmxzLF
         Ta0XNBJiktQus60rHnpOx4MgouoKBumQhpvO2gMHA0uu8iBEfEHAwwZ/bKZH3yHC4OkT
         Kbo2bNZokvKVb4RXHWhlS/vmSWgv1nCUUnKspz2YJrZsDNdi/azPiLsvL1Prc79UnQJX
         eU8QRvZopVVDMo10R1ONNLP8SpkdMR2GnspPync+uzXzui6ZT85MBuh5FW2ViFhZVK+I
         EYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RhdB4E6tzyT0BJoGZQ1XuW1VzTOaKy1GoRr0Z6faXx0=;
        b=SzelmTQQw8k1Muk5BfCS1zqWZ4mCPG998MdkrrTV5A9MEHXPOXv0IH4+iLMeIgVlx2
         V3ZGFfQd0dZSTu/LQ8iyZlagysG5ITWzBp3BSOn0kEirrp/zK5mq1vqi7vwphaZk0zM3
         u2+pVtGVozjLY/ZaCMtKExP3Ptx3lu/vvOmlr37bcOInCEh2fRW7ZdYmwk/42vkY1pie
         qCXArS+VhC2crfauRduD7LpRCb9KYeuNooFaBuGc6pABJ/QjE7aGIYRenv7ayWrRjMWU
         KaYI6OCB9eKOdBn60HCiaBgnfg+LCQSMfKkZnliHZJ4cGRHjwAo0r8CW/TnEIz+vjIx2
         wg2A==
X-Gm-Message-State: AMke39nS1VNhNnHux51dO2PJ0zG+UmhEvJ+vF1GuBbkS4uCSdLoF7Hk7K4d9bytcoHjjeQ==
X-Received: by 10.28.229.73 with SMTP id c70mr5679072wmh.82.1487371267163;
        Fri, 17 Feb 2017 14:41:07 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id w17sm14582085wra.28.2017.02.17.14.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 Feb 2017 14:41:06 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=20=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 2/6] stash: add test for the create command line arguments
Date:   Fri, 17 Feb 2017 22:41:37 +0000
Message-Id: <20170217224141.19183-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.11.0.301.g27b9849079.dirty
In-Reply-To: <20170217224141.19183-1-t.gummerer@gmail.com>
References: <20170212215420.16701-1-t.gummerer@gmail.com>
 <20170217224141.19183-1-t.gummerer@gmail.com>
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
index 3577115807..ffe3549ea5 100755
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
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'create with multiple arguments for the message' '
+	>foo &&
+	git add foo &&
+	STASH_ID=$(git stash create test untracked) &&
+	echo "On master: test untracked" >expect &&
+	git show --pretty=%s -s ${STASH_ID} >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.11.0.301.g27b9849079.dirty

