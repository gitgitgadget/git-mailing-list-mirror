Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8593E20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728240AbfCEMbW (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:22 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35170 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMbW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:22 -0500
Received: by mail-pg1-f194.google.com with SMTP id e17so5557783pgd.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F7WrnDepBAr8/LypsiG9Zw/N/HDP5UJcneiSSMfzDeE=;
        b=OZCCgGnAd0By++zN955rsdUPgPbbjCHnsey4RqamvjpyAufOOpOYDO136gsYl3ngGW
         FnSsVijQpyPZc5a57ioI6Mgu41WDYS5sgl4csX0W/BU0lIiFDvXQp2gZxqXzrcAWYULb
         GtsJZILFNBTkqTOZKA/KEmOlQuYgeThU3kUlIM2DjabKLYfA9W6CQ8T1klhbfmI4yVg0
         RzMX0X89QnAxEwwjXvc2z0LI8wD8z6eLVNehuc/XZ/utAdEZ0T8/LJulD4I8j/8XiJa6
         TRcBD9MtJodCFamiTq48Wh5j5j4qQVyi0vvZEc8DhV2Bvr8fJM4XCtSee+cgCSagdq24
         k5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F7WrnDepBAr8/LypsiG9Zw/N/HDP5UJcneiSSMfzDeE=;
        b=Fmk0gShIUrTyj5ezCCITQ5lvy+hLenMRxk+HpAXXjmNgSqRieGnvbnstELeFOb6/0z
         yvTd28uRNsCeh/RIQSrLwt/DLHsE1c/zYMF/XHtO4y4wAjQbwo7Jxbxq7UjcI/fePqRf
         X8w7IAjhsfyTEHzz8z4di/THbMmgSxzsPUX6FCnhCsWj71zaPSTvia68e7knwgipcU3d
         mb5V3j2go3gpzimg1J62y5jD0IGg54Och/j+I3CYknnyz6ZKmi9wq3DVbR5Pe5TYCy/2
         cD8IeKkxoLugV+MzK1Skg5tgjD4fktBZ0Hw324qQUghHhBNFApGYNdK+copTn3nFK4eu
         8apQ==
X-Gm-Message-State: APjAAAVEcUlBwdNtRzZcxhPgArG1YTzouiJUjMOQ29dTiD3SilHwX3Ji
        TOTuuVHDEYtJpnJphCemHheg/I15
X-Google-Smtp-Source: APXvYqxOJ2joZrAAcuBPV+hgg9wY7VjL3dZ/yrJy+pxMhtG4Sak0QgR8bNgCFqQUFeJc+UIh9oKF7w==
X-Received: by 2002:a17:902:2be8:: with SMTP id l95mr1000002plb.270.1551789081589;
        Tue, 05 Mar 2019 04:31:21 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id e5sm11826364pfd.73.2019.03.05.04.31.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:21 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 08/20] diff-parseopt: convert -a|--text
Date:   Tue,  5 Mar 2019 19:30:14 +0700
Message-Id: <20190305123026.7266-9-pclouds@gmail.com>
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
index 3a13ba37fd..51d22f63fa 100644
--- a/diff.c
+++ b/diff.c
@@ -5214,6 +5214,8 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("when run from subdir, exclude changes outside and show relative paths"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_relative),
+		OPT_BOOL('a', "text", &options->flags.text,
+			 N_("treat all files as text")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5246,9 +5248,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.21.0.rc1.337.gdf7f8d0522

