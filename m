Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB39D20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfCEMbR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:17 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44716 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728234AbfCEMbR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:17 -0500
Received: by mail-pf1-f196.google.com with SMTP id a3so5582967pff.11
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a37T+dMdJ6T4LszHzCAaz9F8J8lcumUvWPBIk3Xw0Q4=;
        b=h2CQQvWvOYmTEOKN65lM4z/o6sTIyOApRgxm6h+GEp9Aw0lUs7bq6iNd5//nx5IfEJ
         +8JRU6a9BjwnpoQVWNE4ou8QVKxYndL09bUP7J26mHJPChkp0ixzceDGBMP5bRqxTb62
         KOrwfglU6SJSGkj3typlCpQxV5s15T+sLHYiVRK1MeeOMhJauYQmwRwID6S5lXBflC/H
         SD7h1BFGJbzNevk1XB58fLUPj/9vFXUYv3A6yjcOo2LRXIbRa4IsMTgwP+OxX6YAPspg
         8OiOj9LqUoCPJQ4D1lzCrYCS97YBSN6SWmdAEfufojjvNBu7+m2cVVw9atFpPjg5j2BF
         lQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a37T+dMdJ6T4LszHzCAaz9F8J8lcumUvWPBIk3Xw0Q4=;
        b=dqa/kj0qoJBcksMy+0r5fPMcdVddpPHndyH58pmUK+y+bEWDTzaMMs/FX9KS5PSLQA
         IKZDSV4JiRzwx65d6ZgiNMqTiNJXN57WKJt+wDrzVBmrWFw5h/lX8hCLP6Mpo975mDly
         Ewr0T+Pib6SqsMsZghQqc603daVDkIIdysEEIcy7mJZM8JweuhMTMAeHYSF/LmbuYC1b
         pB2h3WSpLlL+vqeIw3BW9LCBOu21gwMTvuOYitI/119uHelZ+MvVilEtf+7relP6f89i
         3psNjjExglRVzjBO/XsUVpNupM8vLfRUQam6AmwB2fJ8LFN0wjL1cmx8Wdi4c1jWbYzB
         N88Q==
X-Gm-Message-State: APjAAAW/y/LRM4CRJKCz8SFVCiBkuWuvenTH1s8twBYhaybFloh2x3rG
        D9s3U56t2hZynJrR3aIs4TXj95r4
X-Google-Smtp-Source: APXvYqzZ4dJE4Mrm+AZRUOrBjIu8qe+Cpqk9QFGpaOljinR4+6/Qtu7l5eXpG9G/37rbcE4stOa33A==
X-Received: by 2002:a63:ce:: with SMTP id 197mr1205994pga.212.1551789076457;
        Tue, 05 Mar 2019 04:31:16 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id s37sm22523684pgk.36.2019.03.05.04.31.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:15 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:12 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/20] diff-parseopt: convert --full-index
Date:   Tue,  5 Mar 2019 19:30:13 +0700
Message-Id: <20190305123026.7266-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 214728c892..3a13ba37fd 100644
--- a/diff.c
+++ b/diff.c
@@ -5131,6 +5131,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "binary", options, NULL,
 			       N_("output a binary diff that can be applied"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
+		OPT_BOOL(0, "full-index", &options->flags.full_index,
+			 N_("show full pre- and post-image object names on the \"index\" lines")),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5244,9 +5246,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--full-index"))
-		options->flags.full_index = 1;
-	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
+	if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
 		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
-- 
2.21.0.rc1.337.gdf7f8d0522

