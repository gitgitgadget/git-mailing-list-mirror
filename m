Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B5EB1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 23:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbdBPXdH (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 18:33:07 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34811 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933744AbdBPXdE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 18:33:04 -0500
Received: by mail-lf0-f68.google.com with SMTP id q89so2587249lfi.1
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 15:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Sy2LjwiGwFIOTssNpfhqBnmkFPH9s5ulXKla4gY0+sA=;
        b=u17uxAx5x8CvOwuCeX8DcaXL0DjySJ/kDSsgffgBLzYI3LspxcjVJowlEbNP0Yf8Uq
         0uES2p160+h7BqMvchOmZ8ebjteGfA/1JC/URj31acAg04UEqP2FDGaMAf8lq05HXI9w
         GPgGTJi84e73wzwOVINu4NPO0FynO1uuTN0yBAmaj8bhXuq233KWPDePkqD7FxsGmbCP
         x7qRO9hgkCLed4vw4n2H/QuiqUzWVyfgQRSgX4hm0rBXhkN2ZndXfYsl6pelecC8OjMW
         erQLD6bkjv0g4gQ2dnQF1MX70dhRVmAdvkxAg+rlqn052ifToLn40ElboJ9bkORHQDvt
         UjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Sy2LjwiGwFIOTssNpfhqBnmkFPH9s5ulXKla4gY0+sA=;
        b=fDyppt8YwS/7++v07ah0gZS5RejDa69v1AReM/Nu3WoW0f2P/9aAszSrymUHTamikp
         5CD46097cSzY9qhGxePv87+8Oco520EKm8G0aBV77M9kqXighmlqq4MdM4S5Qrl6Zy0y
         87a8h/AN0DGAdzTI3RRZj2chGCC0ZMXLXMUFpJi25id3ZdTojLmEuAwVv8de1YaYqWLF
         fEgIyh2rTREfZcTlYNjOQ08Ohr/V+9nndoHRU8ooRJCQ7G/q9AOqfpZC28fekAdDkjP0
         0abrgfr8iD+t5FVkNat372GI7F0QvHZo/Yk0WE2dbtpZXYFLfadHUqqWNkPxkyngiL/O
         o6Vw==
X-Gm-Message-State: AMke39kQbcbkTLGqDLb9YMYO9VyQfzZ2y9VVzg2geetuU6AYC077tJx1Rk/eXtp5PhuOjg==
X-Received: by 10.25.156.14 with SMTP id f14mr1548397lfe.77.1487287983056;
        Thu, 16 Feb 2017 15:33:03 -0800 (PST)
Received: from localhost.localdomain ([2001:470:1f0b:8fc:eda1:2dcd:3a83:adeb])
        by smtp.gmail.com with ESMTPSA id k127sm2071074lfg.10.2017.02.16.15.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 15:33:02 -0800 (PST)
From:   Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jonathantanmy@google.com,
        Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Subject: [PATCH v3 2/2] stop_progress_msg(): simplification function
Date:   Fri, 17 Feb 2017 02:32:49 +0300
Message-Id: <20170216233249.24757-3-franchesko.salias.hudro.pedros@gmail.com>
X-Mailer: git-send-email 2.11.1
In-Reply-To: <20170216233249.24757-1-franchesko.salias.hudro.pedros@gmail.com>
References: <20170216233249.24757-1-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

stop_progress_msg() is rarely used and is not demanding to
performance. Use dynamically allocates memory.

Signed-off-by: Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
---
 progress.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/progress.c b/progress.c
index 76a88c573..29378caa0 100644
--- a/progress.c
+++ b/progress.c
@@ -243,21 +243,18 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
 	*p_progress = NULL;
 	if (progress->last_value != -1) {
 		/* Force the last update */
-		char buf[128], *bufp;
-		size_t len = strlen(msg) + 5;
+		char *buf;
 		struct throughput *tp = progress->throughput;
 
-		bufp = (len < sizeof(buf)) ? buf : xmallocz(len);
 		if (tp) {
 			unsigned int rate = !tp->avg_misecs ? 0 :
 					tp->avg_bytes / tp->avg_misecs;
 			throughput_string(&tp->display, tp->curr_total, rate);
 		}
 		progress_update = 1;
-		xsnprintf(bufp, len + 1, ", %s.\n", msg);
-		display(progress, progress->last_value, bufp);
-		if (buf != bufp)
-			free(bufp);
+		buf = xstrfmt(", %s.\n", msg);
+		display(progress, progress->last_value, buf);
+		free(buf);
 	}
 	clear_progress_signal();
 	if (progress->throughput)
-- 
2.11.1

