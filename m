Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 316731F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfAQNHo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42207 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfAQNHn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:43 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4426151pga.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wd+KmyKOlmsuPVKrQ5k65mAM92S0lRXo16of4StXpxg=;
        b=nrxEyofzk6a7aNW+xIi5UsNT+qzYKqsYpdIigOBIGaSVLK+MWa6k20Tmfweg2uK2hS
         c9SPdMAWVzuSS3Ly4B9DUtUqrVIWYPb+3kpZS5vKNLHOV7eB9Yu1x+W8Iaw4GQ0KgPOF
         jvE4X5I52iYBM46jcxsOUGjqkAAhjW1Q13drx1V58AJU8yBcNy9nQAVmrK2kKebOSaIR
         aBgyLn3BsQhEaApUP0P5wm2NiyUHgNZ5vamX0ZRZwLz97Y1PXXFJg3dnMNj/MHFPywJA
         dBLPjpcszo24tALj6k9+OH4nvs+XXJWe+uJqQ4eX7fWd/7iYWbsFVsmjcbcYRj6DpGQH
         csFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wd+KmyKOlmsuPVKrQ5k65mAM92S0lRXo16of4StXpxg=;
        b=Y5rmtHadkTm517vfCqtrCe+KKgnn5RX3eyZVIkVOXutXQG9ptTngw68qTTnL9tPr6H
         b9ccjT+4sI667wHl5EnqS4oz5Acg9e+RCykL7WPb2xiz+V3hNpJpMiN6ILuELwJDA1tM
         uInX99Ycw10hYZrSQ+on25VXvxeGXaPJeQXZIqe8Ld+XAz2zYwWLFefRuVCyOKoWslll
         N81oRjB3KXbTBkE7I0HuHjt1kUUgyPMmIjA8Ad/pT64Axw7ODj7kofkxwlVHjhynRt/u
         oYgd11fYDnk5EApzEvQxzVdvRwaH8tD4kR6erUTgsEStIrzx9NnBSG6FkraaRDFNu2EK
         as7w==
X-Gm-Message-State: AJcUukf5C8/9bQpPhKn3mJNLfxZkGOe9SkKJusNJeE/ahu38PUipFFHg
        /pILOUYHqH8L/2pwnRBh+H0PtuVD
X-Google-Smtp-Source: ALg8bN66XPv7m82fqCZ7nGm2ef9WYk+UIZStpi4H2CBFeOBRNfnitMkdS5E5pVUiTuXRPKLfRgFAQQ==
X-Received: by 2002:a63:6c48:: with SMTP id h69mr12866227pgc.139.1547730462893;
        Thu, 17 Jan 2019 05:07:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s37sm1669178pgm.19.2019.01.17.05.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/76] diff.c: convert -W|--[no-]function-context
Date:   Thu, 17 Jan 2019 20:05:13 +0700
Message-Id: <20190117130615.18732-15-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20190117130615.18732-1-pclouds@gmail.com>
References: <20190117130615.18732-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 5e31b95426..db8cf7df87 100644
--- a/diff.c
+++ b/diff.c
@@ -4894,6 +4894,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F('U', "unified", options, N_("<n>"),
 			       N_("generate diffs with <n> lines context"),
 			       PARSE_OPT_NONEG, diff_opt_unified),
+		OPT_BOOL('W', "function-context", &options->flags.funccontext,
+			 N_("generate diffs with <n> lines context")),
 		OPT_END()
 	};
 
@@ -5210,12 +5212,6 @@ int diff_opt_parse(struct diff_options *options,
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
 			 &options->interhunkcontext))
 		;
-	else if (!strcmp(arg, "-W"))
-		options->flags.funccontext = 1;
-	else if (!strcmp(arg, "--function-context"))
-		options->flags.funccontext = 1;
-	else if (!strcmp(arg, "--no-function-context"))
-		options->flags.funccontext = 0;
 	else if ((argcount = parse_long_opt("output", av, &optarg))) {
 		char *path = prefix_filename(prefix, optarg);
 		options->file = xfopen(path, "w");
-- 
2.20.0.482.g66447595a7

