Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E08A20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 10:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbeLIK1d (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 05:27:33 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44057 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeLIK1d (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 05:27:33 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so7039450lji.11
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 02:27:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czdAjUNuOUO3fl4oDheMY1oKzWHJdmCodlUmQiJIDYY=;
        b=L5xLulQXRN+BP1m4lWEJQzqSsxvlJNqaiSntemtIJG1ikf6z7DHffepU5yCAneuqT+
         JJo6HfBkasdKCbsrBOEhTDU83p6k39uCe2rEPKOeSuh2paBYAvwuJYX07OkszTYWc92T
         aF8tpqhhGk+rUo6U4q7eh0z6H2BmqjqNY2P5qVzTNlG/78/bqAcnsRK6tl9jzVg7EWB/
         Nk46QrwIfGCDTm5sWUwbBgs4qaYIJusC8wFWVyfyt4OiCDkNALjBXbOCdq/9O+8K9S6w
         j5m8bcEFr1f7h69x0SfnpQ+jSvzC8GJht1AeqTtln0RJFnvOpBvwkmJEg0gM8gA0dUH2
         6wGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czdAjUNuOUO3fl4oDheMY1oKzWHJdmCodlUmQiJIDYY=;
        b=HPyBCTRgORnCHvVRtmFNKUB2ZRixjHhEh5h8jkAfcC0big2aH7fX27b6qWk1WgzKKa
         7OKFWvvIR/C48wtVryJPmxarJvqGMS3RsdTrlpYLYk2Uvl8z3Gt2JPrJozxMmvIQ9qPx
         oM+yaD9CxMMLqEtpHZlKagaC/2nc0mSHPVNvmUHe7hHZJKIoJX27RJZ8v270Ye10UOQQ
         j62noSUGS3LEw2qOrjWx+pnGIIkEAcC9K3nyYvmejiRZV98ITFhntjPWvomsJdbSm2xT
         XqqVIPptBTvYhu8Br+uiXd2Fg8gOOYQGaxUxpnAPw6/oN5vKebKdeKXs9ieBm2+5vn9W
         nCqg==
X-Gm-Message-State: AA+aEWZ096Hoy/Oz49etXsPlinvSEi56R1HnHTP3n5qhn+F1FwLGNfzR
        bz4q8v/wunpHtya6dOr9ZgE=
X-Google-Smtp-Source: AFSGD/Vvlece3QFJ3c+Vw9XmPWsRQCFguJ0k7lzLA2oZVfLVH1/UzpebG7mDR/Vo8Tw9KefsBOi6gw==
X-Received: by 2002:a2e:8187:: with SMTP id e7-v6mr4945115ljg.50.1544351251011;
        Sun, 09 Dec 2018 02:27:31 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id m4-v6sm1525420ljb.58.2018.12.09.02.27.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 02:27:30 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH] parse-options: fix SunCC compiler warning
Date:   Sun,  9 Dec 2018 11:27:24 +0100
Message-Id: <20181209102724.8707-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.rc2.486.g9832c05c3d
In-Reply-To: <87va4cujtx.fsf@evledraar.gmail.com>
References: <87va4cujtx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The compiler reports this because show_gitcomp() never actually
returns a value:

    "parse-options.c", line 520: warning: Function has no return
    statement : show_gitcomp

The function calls exit() and will never return. Update and mark it
NORETURN.

Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 3b874a83a0..6577e52f63 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -474,8 +474,8 @@ static void show_negated_gitcomp(const struct option *opts, int nr_noopts)
 	}
 }
 
-static int show_gitcomp(struct parse_opt_ctx_t *ctx,
-			const struct option *opts)
+static void NORETURN show_gitcomp(struct parse_opt_ctx_t *ctx,
+				  const struct option *opts)
 {
 	const struct option *original_opts = opts;
 	int nr_noopts = 0;
@@ -550,7 +550,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 
 		/* lone --git-completion-helper is asked by git-completion.bash */
 		if (ctx->total == 1 && !strcmp(arg + 1, "-git-completion-helper"))
-			return show_gitcomp(ctx, options);
+			show_gitcomp(ctx, options);
 
 		if (arg[1] != '-') {
 			ctx->opt = arg + 1;
-- 
2.20.0.rc2.486.g9832c05c3d

