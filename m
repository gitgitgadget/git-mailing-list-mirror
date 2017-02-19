Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B81BD201A9
	for <e@80x24.org>; Sun, 19 Feb 2017 11:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751670AbdBSLKR (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 06:10:17 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36465 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdBSLKQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 06:10:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id r18so9597721wmd.3
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 03:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2CVKDyO6xH2KUwNnTi6RXsWYbCgguFXHHxg97d+G4fY=;
        b=gDLUDMR3BhXGHlBQ546QaK2FAP2WbSMpujvgPX0yJkrXF11rI09klL+DtgDHAHWjVb
         XL2i4W4c8a1BdfTFU/B/0TtAkILCEHob8cGQKEKtet96zfIdwb8tlJZSYch9M4qoQFIH
         u3wrc7c4ov7IJ6qiWb4PXTbNnq5Nb5qprl8ac3JnujqViwWjswrxb19ynNqb/it99FTr
         upVMjHiYWIJ/hR3qQQbmd+P46cgD4vCrlfAos5yf+9a5XCj+kcxcEBrnOudnosB8EkEZ
         fZMJYWnE5AuzJrAgrb6SReuELZT2CRB7vPbsM3lvyubTdu5/SL1N1/d5Ag2pO3RcEPpy
         Lmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2CVKDyO6xH2KUwNnTi6RXsWYbCgguFXHHxg97d+G4fY=;
        b=UDrB1VtEqv8j9epNrRcQT6U/bAKAdE8oooitO49m8DGJ7X2p76H5Ys22dsZ66HUlVq
         Lg+wkMZ8HyWelC2KkoTNA9iLs0w9Wev8yFftcNiRcJvljhMEIR+NeqZ1Njq7n6ViMc4X
         Z0Sz93i87UngaPTgRE2UtDgQd7apjm2zENwLqT/uAP2P22GWA1yHJ9wMXd+KXGYVnWcw
         aIf0pMjPK5DsmDkI+4xqlTwp2f3oO78YsXf0brXfSukjGtMZzTlE7H2Qwds9e5wLKW8q
         z6uPSPmCStF1+aV7HscQUR0IRB5OtJOrqgXR+z1oeXFuV1CFEZFM0re30TPpMIJkDNVm
         An1w==
X-Gm-Message-State: AMke39lSxi8Ix4Eb+1YZb36GXK52Ox0+N1+fEkD7pQMZcFwjnK3Xk/XNNF3qQnRYIKyJwQ==
X-Received: by 10.28.94.2 with SMTP id s2mr6967473wmb.127.1487502189335;
        Sun, 19 Feb 2017 03:03:09 -0800 (PST)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id 10sm9054145wmi.23.2017.02.19.03.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 Feb 2017 03:03:08 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98yvind=20A=2E=20Holm?= <sunny@sunbase.org>,
        =?UTF-8?q?Jakub=20Nar=C4=99bski?= <jnareb@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v6 2/6] stash: add test for the create command line arguments
Date:   Sun, 19 Feb 2017 11:03:09 +0000
Message-Id: <20170219110313.24070-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.12.0.rc2.399.g0ca89a282
In-Reply-To: <20170219110313.24070-1-t.gummerer@gmail.com>
References: <20170217224141.19183-1-t.gummerer@gmail.com>
 <20170219110313.24070-1-t.gummerer@gmail.com>
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
2.12.0.rc2.399.g0ca89a282

