Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99F9E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727686AbfAQNKL (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:11 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46958 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfAQNKL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:11 -0500
Received: by mail-pl1-f195.google.com with SMTP id t13so4717589ply.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q3nV6i5gSPc+oi2iW89A/ipoWswHkbytsclPPS5cH3I=;
        b=OO5yy9IIhOp2lZ9LvX9mBT3G0KfCbKZIwGD88CNwhVZ4RCqWf5i2lAdAmeYa/miMSd
         nrtF43ISALEwsKygWQCsDfu8uxoE+4vAOvdKuJTfc8Myn0AyKgVnwHXn7SKXxndAu95g
         Lypxu68qS5D4kcJ0LhdOGxZdiDYf5jFFKmsulq+2vLNOM+Ht0jGx0sexRpcfdZsd+JN9
         ttZedG59RFQe7uN1D+6E9DUZAACZpwPMdkhgXQcveP+RTKXjUuyuzmiJpJ7LYzr2wMPw
         kkuL8aGF3iEn81d3KqyPrzQ7BnTbPhPak5TJ99VKHMIlCjwbQfa4RXZ8a1aGW+vFD0Us
         4M3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q3nV6i5gSPc+oi2iW89A/ipoWswHkbytsclPPS5cH3I=;
        b=pqovf6+WGOI2340GVNAs6m8JD2NRp7C7ncwH9b46LtunBt35SY3iX+i1l4Yk/Lal8q
         bPZ5e+o51g+TI4gNEC8IWZR+HS7oL/4Cic/wrk9wmcj1MNofeAQUA+rI7JwdlkBRqI7i
         2NE2dHBd05PhTeLr1KhmUEDvHimZIqZ1T1A9Ede9tX8NxZmRQL5vg7wcE/bMbvInHXJZ
         q8MFNxkqKAHPSGSk4gP+pKvsSJTE1Mor7GkrndqDTvQedCaBTvdBXDsWvsfQ4PbGxz1Z
         Mi9QMU0wx+FFv7ncwqahGElbQaF6/IWfViWaMJ/RM4DdEULdnvP5qTFmgMZitySgpE3d
         /Nuw==
X-Gm-Message-State: AJcUukft1miJOVtAy/ur+SqRApL/bBohVQ/iCQRF+9G2mx6CTM6pGn1S
        tzUcUIwzsONMQlpmSbF7IFYpYpC6
X-Google-Smtp-Source: ALg8bN4588VbUBQAZsenz4CAJSYFcT1qKGjpGlsRXapkJQ9x7CSXJM2gh9FR8uUJeRfVuaHLJwq0xw==
X-Received: by 2002:a17:902:a5c3:: with SMTP id t3mr14698502plq.117.1547730610495;
        Thu, 17 Jan 2019 05:10:10 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i72sm2883837pfe.181.2019.01.17.05.10.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:09 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:05 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 44/76] diff.c: convert -a|--text
Date:   Thu, 17 Jan 2019 20:05:43 +0700
Message-Id: <20190117130615.18732-45-pclouds@gmail.com>
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
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 0b70def840..d342d06399 100644
--- a/diff.c
+++ b/diff.c
@@ -5218,6 +5218,8 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_relative),
+		OPT_BOOL('a', "text", &options->flags.text,
+			 N_("treat all files as text")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5250,9 +5252,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
-		options->flags.text = 1;
-	else if (!strcmp(arg, "-R"))
+	if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
 	else if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
-- 
2.20.0.482.g66447595a7

