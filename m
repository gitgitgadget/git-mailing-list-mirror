Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A77220248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbfCMMYz (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46003 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfCMMYz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id h99so1747171wrh.12
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kYKeMp7VkKvBzJWCgJpwdq3ON6BDApzSolSrPceG49c=;
        b=ozuENRBUmtB85Tvo0VDQhSrSn4maUA7vxghsJjT+0ehDZvacUyhnYJ8WCxKNh3ewkt
         RLIiP9goJgPpvvfAhGYmmrTcyqa7wiutLoqEoA3yJGTL3D1/m3uiGlCEDV69dXiLuDfn
         N2G3I8Vu+sQqoOU0J4CKYJqRnCIDiRdqRZV257J2QK5JW9q1CCXRJ8/yM7+8+EDch8wX
         eydNSrctJMe+4lOZhRkkqC2uEXES5EXZP/Yo55nSZJHSgob0Gr4HPhsEZOsxyQOzFfLx
         ebx/SLtwGQjT02p6fRxaXR9eHBWGCDOdsNEA2jHJE4OXbaQyuH9rb1JlbLRCyngoK0xJ
         90ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kYKeMp7VkKvBzJWCgJpwdq3ON6BDApzSolSrPceG49c=;
        b=DkgINA91zdr5itNZnhIEO4U1Q0pXQnA/xyp/QpZulRwfKzSUuhwuP5LYvdVip+M3NW
         DtIGuTzO0/Q43PDmfjI+A31/ttzUuB5kr5iCyr1zhhdLoHLa4IaJuPq73u5IVEyUugCd
         fCdEz+LwDu9Kf2eMWjgXF4mbviM3bv/oVXPGA0SQECgYgRnbiNcc54NIAstZQtrGIAee
         XE+XdnlMzViyPbUI4QfE9jBuZKrvKLmEcCzLmw0Ku0MUocsN5sQuPvfjiNuD5kCEFzTV
         4sDG12K1pgn10FZkAevgrv8HB7y0JYU2hwZbVT76WWjdG+MvXkR6t6vT5AasdsQLVgb7
         fCTA==
X-Gm-Message-State: APjAAAU84ApyYaTjt2bTKmzRZkBQGpPhUzbgySgbVuMF7KZBK+7rbTeO
        ris0ZB4x48FR/U4tTlwcmw1tDFQO
X-Google-Smtp-Source: APXvYqz+TadLahekSuKTJudc2XxUuMiMFTbigKlgJ9OeU6JHu6ON+th2o9K21YgUSmXIEWagQNO74w==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr20357746wrs.307.1552479893014;
        Wed, 13 Mar 2019 05:24:53 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:52 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 10/11] git p4 test: disable '-x' tracing in the p4d watchdog loop
Date:   Wed, 13 Mar 2019 13:24:18 +0100
Message-Id: <20190313122419.2210-11-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
In-Reply-To: <20190313122419.2210-1-szeder.dev@gmail.com>
References: <20190313122419.2210-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

According to the comments in 't/lib-git-p4.sh', sometimes 'p4d' seems
to hang, and to deal with that 'start_p4d' starts a watchdog process
to kill it after a long-enough timeout ($P4D_TIMEOUT, defaults to
300s).  This watchdog process is implemented as a background subshell
loop iterating once every second until the timeout expires, producing
a few lines of trace output on each iteration when the test script is
run with '-x' tracing enabled.  The watchdog loop's trace gets
intermixed with the real test output and trace, and makes that harder
to read.

Send the trace output of this loop to /dev/null to avoid polluting the
real test output.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-git-p4.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index c18f85082f..547b9f88e1 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -106,7 +106,7 @@ start_p4d () {
 		fi
 		sleep 1
 		nr_tries_left=$(($nr_tries_left - 1))
-	done &
+	done 2>/dev/null 4>&2 &
 	watchdog_pid=$!
 
 	ready=
-- 
2.21.0.499.g4d310c7a8e.dirty

