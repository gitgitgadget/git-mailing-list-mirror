Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AF6B1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 22:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbeL3Ws2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 17:48:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52315 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbeL3Ws2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 17:48:28 -0500
Received: by mail-wm1-f68.google.com with SMTP id m1so22562338wml.2
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 14:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RcplEN6gHP19lC1uYrAeWx/SiH+isfirJRHS77Wa0rs=;
        b=LL9czvr7/f2c8xZ6qWD2hqSVwEku45wiwulYh/cHgclu/uR4XWqrmEDdN9qvTpvQ7G
         r6T9uRuUG6hxPMy3klK+NPWvWnQB09KGCc4DOTr+yCHaaNV2BItLOQ33SgPuodrjhHVe
         hNa5flp+xAYCS6NrKJ8/rzV0Cw9wZchyhu2LisJZM8JVDfNQOWlTQ8L/qv0s9Hnpm2To
         RtxHxqyEp8al8HYWnnx4Ul78KXTRBUfSISVQu03LaVMjFzlF/bWkUuM6xi60lB8Xhms3
         at5Y1AZmJs8xknzWhSEW2H1cKwPyT5nZwOZk1wVh6giHm/tApL+KHFe3yb/LY+5rbI+d
         WAiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RcplEN6gHP19lC1uYrAeWx/SiH+isfirJRHS77Wa0rs=;
        b=RWF/d50JbLkPCsx2l5PckJ5Uiq0bP3q+B35CDQhVuv4o2fQ1MsOFrD07/oJnA16zOV
         8ZiDIcq03a5PedLFEtIo9eYzw42TAHmcfo1mjhdJOpgAie/bHzzFB0sbxjxkYN2GXOcY
         4J6EjQmIabpYuo5x1/vf8rBBzWHDn8HCkwcSw7W8cDN14xQ+UvltOqovD8ZVFUR7G6gJ
         O7YgpREUD6t3ZSqEs0kWxJu/cK1mTqGekN9A9wTcrW+JMHGvG9h9o4TIl7dKXTfWrU5h
         HCuTE+szWC6HsTM5khVUcqEcx/SrzAx+1ZIuNFifQKKWn+oUhauQBt7scqpOSWa0xhIO
         +xYQ==
X-Gm-Message-State: AA+aEWaNjcmn4yChouiSN7eWYZmnBhzOUMX8A+jsKpMscjBszIdPzQ+M
        EDdqRUeJ48M+JnFv68iWQf8=
X-Google-Smtp-Source: AFSGD/X1YWgeAUuIWR1BaYYQ8gXZio+A6yKTexbOx/yxWmnrTB0rpVEeZAyJsb+EOTLaXF27VG5GvQ==
X-Received: by 2002:a1c:c87:: with SMTP id 129mr28315375wmm.116.1546210106152;
        Sun, 30 Dec 2018 14:48:26 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id y12sm27719740wmi.7.2018.12.30.14.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 14:48:25 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3.1 5/8] test-lib: set $TRASH_DIRECTORY earlier
Date:   Sun, 30 Dec 2018 23:48:22 +0100
Message-Id: <20181230224822.18762-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230224453.GC6120@szeder.dev>
References: <20181230224453.GC6120@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later patch in this series will need to know the path to the trash
directory early in 'test-lib.sh', but $TRASH_DIRECTORY is set much
later.

Set $TRASH_DIRECTORY earlier, where the other test-specific path
variables are set.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Updated the commit message, the diff is the same.

 t/test-lib.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 41457d1dcf..2b88ba2de1 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -186,6 +186,12 @@ fi
 TEST_NAME="$(basename "$0" .sh)"
 TEST_RESULTS_DIR="$TEST_OUTPUT_DIRECTORY/test-results"
 TEST_RESULTS_BASE="$TEST_RESULTS_DIR/$TEST_NAME"
+TRASH_DIRECTORY="trash directory.$TEST_NAME"
+test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
+case "$TRASH_DIRECTORY" in
+/*) ;; # absolute path is good
+ *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
+esac
 
 # if --tee was passed, write the output not only to the terminal, but
 # additionally to the file test-results/$BASENAME.out, too.
@@ -1046,12 +1052,6 @@ then
 fi
 
 # Test repository
-TRASH_DIRECTORY="trash directory.$TEST_NAME"
-test -n "$root" && TRASH_DIRECTORY="$root/$TRASH_DIRECTORY"
-case "$TRASH_DIRECTORY" in
-/*) ;; # absolute path is good
- *) TRASH_DIRECTORY="$TEST_OUTPUT_DIRECTORY/$TRASH_DIRECTORY" ;;
-esac
 rm -fr "$TRASH_DIRECTORY" || {
 	GIT_EXIT_OK=t
 	echo >&5 "FATAL: Cannot prepare test area"
-- 
2.20.1.151.gec613c4b75

