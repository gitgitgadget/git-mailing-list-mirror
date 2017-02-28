Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A667201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 20:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbdB1Ueo (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 15:34:44 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33175 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751473AbdB1Ueh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 15:34:37 -0500
Received: by mail-wr0-f193.google.com with SMTP id g10so2992160wrg.0
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 12:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dNQJwf+GM2/D+GnYEGwLPDtTUJqEdaVqfisCe5L1LlE=;
        b=ZXACC9HDCXlSC4hh8wfnW1N/jcIn88Q4XBnJU6U/ZIed209EBb+A4q9zUcKDoO49Np
         mIWrQqLDevQgqObZYRcqya5lb2bSNUIskWqFbfEcUFalyNC+muU248j+HyzICkI0kZ2d
         f0n4k3VweLYtkf81jAnBNLy9PvB5PNtbVKDDEQbNzeOxHCka41Oppe8++Xn+rYWU57mN
         Pt/ZnAxwJEt1SnhmB1K1whAUM3hmLDFz+TPEJxeaInZqOP4f4eEC2rVeFO3FqI+xeWxt
         7xQ+9JwL08y6UfU4BXntwdX324nzv/T0R0VonC0cBJmI1WtZAuVTPR3BcU+vSSMc/2pI
         h/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dNQJwf+GM2/D+GnYEGwLPDtTUJqEdaVqfisCe5L1LlE=;
        b=jbkDRXKMdQdmbftJjKNsPZ1BvXCoOaEJuzkZgBBjpMIXjnHS5DFF+lrKOnV1onve0L
         FXbZN3jsWhTG8wK2L7wdp/2l9p5ADldv86bMljh+fF41svFpM04NNgZrljRjJJVgJH9N
         7bJCDx84ahY6MIt+g16+wzW8WJUQoSnKexxRUfFjNNpaO5Kcwi9noQlwSixwpO4TxBFt
         VjRnqnlNDrVjQjo/pW7knENPTIKB5Jh40vnv6l45nPr5dacSZcnKSIy1LowtoozWmzAW
         X2NS4QII/zfj/zksnizOjQDyGBlshEwkErRxifhsxhzt5pYU5Kn0ebtvnhWSPb9CyoZt
         Ehcg==
X-Gm-Message-State: AMke39mKCJU7ZhZ1AGyQvHvzojOf6HUyMypLiPlshU6PLIjxYnzYzhD9YhH3Hk8hykQRVw==
X-Received: by 10.223.175.196 with SMTP id y4mr3868587wrd.77.1488314027290;
        Tue, 28 Feb 2017 12:33:47 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id r6sm4087047wmd.4.2017.02.28.12.33.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Feb 2017 12:33:46 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sunny@sunbase.org,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v8 2/6] stash: add test for the create command line arguments
Date:   Tue, 28 Feb 2017 20:33:36 +0000
Message-Id: <20170228203340.18723-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.428.g67fe103aa
In-Reply-To: <20170228203340.18723-1-t.gummerer@gmail.com>
References: <20170225213306.2410-1-t.gummerer@gmail.com>
 <20170228203340.18723-1-t.gummerer@gmail.com>
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
2.12.0.428.g67fe103aa

