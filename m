Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0600C1F732
	for <e@80x24.org>; Fri,  2 Aug 2019 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406890AbfHBJ5X (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 05:57:23 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37104 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406883AbfHBJ5X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 05:57:23 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so18043662ljn.4
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 02:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1zXtyV/4V4fQyVHLz8p1CSwfozW6e0zPbl0nRfqsWDQ=;
        b=itE0QSjUqafXwuc7LiL3wksg/8KlTeILxvpNvE2m472ROG8M2XBgUuQaXvp0PqQZTA
         m93/eM4ciL7pFG13VoQd3K28zd9ZclOVbA1oj4C+O+B0yvtKLgfM5tCF5kAQQtdFAQfM
         7jEPCIY4A5F1so7jfTYPVDgEAZ+VE4I9sxz2ukDNyHV+a53Nyww/7wb4Hoe2ITruCyhA
         SEhJ/yvq6ceoC8moEtGjiMl1BWFhSjcnrROmHFe//3Se/58WFSmRQivu0YdavY73wh2k
         XGIgZmMQR3Nabh/OhE5h+4phetiGXTMhh1nDl/RR4pzbwUBpss6bD4mrDJbLAtW5ju6X
         MC7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1zXtyV/4V4fQyVHLz8p1CSwfozW6e0zPbl0nRfqsWDQ=;
        b=Fk/cbqiWG5DZCnaExj7YHZzhSeXZJs5l2/bmKCtJ5IpLqNIEyKQF8GPT7FnMNlpaAe
         TRNI+cy8ekGvt9wjsPHnYUFkQ/pBUbeer52cGdjh5OIuMtuZnNEFtl8BTZEZnUfL52kn
         c6AgF/Ui0W96UYXennOr74/zPIPGfWF77lSwJRSGglHHRLu6QSBisS8fYgJR1IpI89Yv
         fG7UVg40/2FGPXh7xQEAiCKVqyVCuiE3Jaclw9LnFgx58KlgaVoxPOt2uYnBoQi05k4x
         a2Gq9nBOSAZizlgc41uRZG2qjVjJBgb9eONfToynQDkB9aWp0aMTTeELyWSZynVym4wS
         rSIQ==
X-Gm-Message-State: APjAAAVJ851GqHkJhjkjOSnboJ3Ya3nlzUAM7JKnQJ4aM8N6lcZpI64w
        6m8G50V6uP492wAOTqqBMgY=
X-Google-Smtp-Source: APXvYqyeygUf17BEGLaC2i64A5hMw6tiOwT1NA4ScY1szgEVXKnzvDVxJhE/UZaiaxWd1K6oYIIOeA==
X-Received: by 2002:a2e:9643:: with SMTP id z3mr72069614ljh.43.1564739840843;
        Fri, 02 Aug 2019 02:57:20 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id y12sm14237344lfy.36.2019.08.02.02.57.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 02:57:20 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>
Subject: [PATCH 1/5] t7503: use "&&" in "test_when_finished" rather than ";"
Date:   Fri,  2 Aug 2019 11:56:35 +0200
Message-Id: <d697767c1814ae77306d520c88f06ded19542ba4.1564737003.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc0.30.g51cf315870
In-Reply-To: <cover.1564737003.git.martin.agren@gmail.com>
References: <cover.1564695892.git.steadmon@google.com> <cover.1564737003.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index 86a375ab3e..5cc6c98375 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -162,7 +162,7 @@ test_expect_success '--no-verify with failing hook (merge)' '
 '
 
 test_expect_success POSIXPERM 'with non-executable hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks; chmod +x \"$HOOKDIR/fail.sample\"" &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
 	chmod -x "$HOOKDIR/fail.sample" &&
 	touch expected_hooks actual_hooks &&
@@ -173,7 +173,7 @@ test_expect_success POSIXPERM 'with non-executable hook' '
 '
 
 test_expect_success POSIXPERM '--no-verify with non-executable hook' '
-	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks; chmod +x \"$HOOKDIR/fail.sample\"" &&
+	test_when_finished "rm -f \"$PRECOMMIT\" expected_hooks actual_hooks && chmod +x \"$HOOKDIR/fail.sample\"" &&
 	ln -s "fail.sample" "$PRECOMMIT" &&
 	chmod -x "$HOOKDIR/fail.sample" &&
 	touch expected_hooks actual_hooks &&
-- 
2.23.0.rc0.30.g51cf315870

