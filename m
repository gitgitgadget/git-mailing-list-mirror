Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CCE1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 15:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752210AbeBHP5W (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 10:57:22 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34332 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbeBHP5O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 10:57:14 -0500
Received: by mail-wm0-f67.google.com with SMTP id j21so30421wmh.1
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 07:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrURhfgizHgTy/ChyIOYwJFAaKU05XH39yiuko4BHvY=;
        b=QTlaPhncZVgGCIo6qDlAI/eA8E6v9xXxmML4VwUwFnC4tdv1uKwUlhJvOrEbxupv1U
         j2mYeGhjOgscPgXn4MS+K7MJH9IJIhLx5aYUs89sFHD97A7VoHp1FIj8fKaoRbr3m+/O
         zCNnVvI/LGMsUh7Y9PEtFsiN/cCGcmsZGN4zsakpFJp5HojkkdtzaQwPcAUYPbHF3pnr
         5dWQWpTbyVWS1dkkGZqOTmvmq691wEamKN2KCnwsWRF0vvkHSKb+DX5qJAi5uP2sdisn
         6NDqtNDRT09dXGLlqDQSethGN9z959StFvQZfAR1Hw3EROe3rjPY0sfTxUXxHaVJRZAp
         3HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrURhfgizHgTy/ChyIOYwJFAaKU05XH39yiuko4BHvY=;
        b=dcZo/fMVAsV0erSKOIWsSo3DOcWkzubh4CbQJOb3nUHQxkcjzXR//NMqWDZ2Qng0ac
         RLQVzUf+fkC2eKlzM2mlD4wmVxv7ixs0R3/9g7L2MN7VACBrI2kw0NNB1Xp2+VZV0tgd
         hQOoEn8Hj6QkIZ0dwoJDwN/rsCGnkI+QktdTWqgGEEFzGMfrvNCki4mQNnvSrvKUhnpm
         oIYT5QHufHBYF+5dPuVKAvQDUUcY5u1tU/VA8i/6xR2UY1Sr2RBVe8byRp63DHpA02G/
         kwYfu0STBKfe7Hs97ZzhgAHw9p5xgt47tBBbQvcwfZTLFBWW9GmLDafstL18lkhhM74F
         8r6Q==
X-Gm-Message-State: APf1xPCa+iCaJXCB7epEr0Bi2iGuA6vO7FHkUPUuA3uqE56hpawBK/+v
        +dWNkLL1LdiORRQKI5+HRKQ=
X-Google-Smtp-Source: AH8x226DzxcU3BSjf99+gFJtVdI6xn7EvOFhYC4L3ybNTsEdPGED/6hGQfkvIgIKvCe3b8r74Urlkg==
X-Received: by 10.28.194.137 with SMTP id s131mr1635408wmf.3.1518105433314;
        Thu, 08 Feb 2018 07:57:13 -0800 (PST)
Received: from localhost.localdomain (x4db2a6c8.dyn.telefonica.de. [77.178.166.200])
        by smtp.gmail.com with ESMTPSA id p14sm308880wrg.42.2018.02.08.07.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Feb 2018 07:57:12 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 6/9] t5536: let 'test_i18ngrep' read the file without redirection
Date:   Thu,  8 Feb 2018 16:56:53 +0100
Message-Id: <20180208155656.9831-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.1.158.ge6451079d
In-Reply-To: <20180208155656.9831-1-szeder.dev@gmail.com>
References: <20180126123708.21722-1-szeder.dev@gmail.com>
 <20180208155656.9831-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Redirecting 'test_i18ngrep's standard input from a file will interfere
with the linting that will be added in a later patch.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t5536-fetch-conflicts.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5536-fetch-conflicts.sh b/t/t5536-fetch-conflicts.sh
index 2e42cf3316..644736b8a3 100755
--- a/t/t5536-fetch-conflicts.sh
+++ b/t/t5536-fetch-conflicts.sh
@@ -22,7 +22,7 @@ verify_stderr () {
 	cat >expected &&
 	# We're not interested in the error
 	# "fatal: The remote end hung up unexpectedly":
-	test_i18ngrep -E '^(fatal|warning):' <error | grep -v 'hung up' >actual | sort &&
+	test_i18ngrep -E '^(fatal|warning):' error | grep -v 'hung up' >actual | sort &&
 	test_i18ncmp expected actual
 }
 
-- 
2.16.1.158.ge6451079d

