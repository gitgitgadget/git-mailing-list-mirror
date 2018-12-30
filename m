Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88ADB1F770
	for <e@80x24.org>; Sun, 30 Dec 2018 19:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeL3TRA (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Dec 2018 14:17:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36212 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbeL3TQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Dec 2018 14:16:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so25099185wrp.3
        for <git@vger.kernel.org>; Sun, 30 Dec 2018 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W22rQ0lb2f4bIjQpoBRCrV/fuKAsCLdkSflV1PQYXwA=;
        b=AwR4phgW7PU8ZLaQIBRjVu3XVWKsNHy839G/rwJ+tIGSZjYL6HX/7c8BFnUIgFJ3OR
         rkaCOcccsFmC/kAgHqp7W7E7sL/u/2OsLsDmtIM+t/Hp/ZMRnw06jhVTpZ1UduDahlSK
         xy4FyWbnFB6CqWHn0Oc0HgUS38m1cdXbG13fYDZsOm9FlcLec2k3B2ugARxKfJEbLHmu
         jIz2hTSQifeTo8bi2ErIaWj4757xe5TY4o2s6D/4aR5eDq1yqHMWtfeYfLaoELUz2QWc
         fbWEQrYu8gxrhWjVxs45tY5JPDq5tS2rLq5kiAZc5+HL4ijQKNHYd2L3eiEfyZU3qKR6
         pYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W22rQ0lb2f4bIjQpoBRCrV/fuKAsCLdkSflV1PQYXwA=;
        b=BUYvRMlIYkAQmM1IuUsRR177JLY5BWvpjKgCENQCVaZG9NF+KESISeZ1xVb6wcY+0D
         WC7sPEWTBuv1tqTWjw2kBENTtY1O5Nfb0Y7uT7BhKi5ci+2NevwucToYBF6wjzMridCw
         Yc7H0rmn/bZmeF2kafxG95z3bk40nhhbvubrArQBdOK3rNvwPah9E5kwi9wKikaIoLlq
         SoL9vj2HExJuj3hE1x0Ir6d6XmX3/6LcfJKHs7S6jPZC8vRFxuLR21Vk273DPUTGXhVy
         IzOcpfam5RmqO4CUxiVAknL065kflTE0pFe+PdSDSXnQGSyDnRkNvz58FwSCT46W0dg5
         M/BA==
X-Gm-Message-State: AJcUukf0nkd7x+20/0Iqee0ObJtNbGY8q/kkaXmRTtuLDkpPQbPoVQc2
        BGnqMwUTfhvdyc8g0wXMAVs=
X-Google-Smtp-Source: ALg8bN40uSVHG9esSoTWSxuc/4b0Pn/MSGuRtf6gwO4uLO/q88cRiiUFQ+2JXrJhbgc8yQrOF2Ce5g==
X-Received: by 2002:adf:f052:: with SMTP id t18mr33103039wro.112.1546197416973;
        Sun, 30 Dec 2018 11:16:56 -0800 (PST)
Received: from localhost.localdomain (84-236-109-65.pool.digikabel.hu. [84.236.109.65])
        by smtp.gmail.com with ESMTPSA id h62sm28954226wmf.11.2018.12.30.11.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 30 Dec 2018 11:16:56 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 5/8] test-lib: set $TRASH_DIRECTORY earlier
Date:   Sun, 30 Dec 2018 20:16:26 +0100
Message-Id: <20181230191629.3232-6-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.20.1.151.gec613c4b75
In-Reply-To: <20181230191629.3232-1-szeder.dev@gmail.com>
References: <20181209225628.22216-1-szeder.dev@gmail.com>
 <20181230191629.3232-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A later patch in this series will need to know the path to the trash
directory early in 'test-lib.sh', but $TRASH_DIRECTORY is set much
later.  Furthermore, the path to the trash directory depends on the
'--root=<path>' option, which, too, is parsed too late.

Move parsing '--root=...' to the early option parsing loop, and set
$TRASH_DIRECTORY where the other test-specific path variables are set.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
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

