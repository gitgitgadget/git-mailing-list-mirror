Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16AF71F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAQNI3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:29 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:34320 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:28 -0500
Received: by mail-pf1-f175.google.com with SMTP id h3so4831318pfg.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34EYu6s44WmKiU9es2g+d10DIzLnlfP0XCo2vAPXts8=;
        b=TfQYKlRXw5rPwT2FBHvJzwKsMB8ZQ/c1EWxNlBjbQ/F03OFD7GHMeGQXvhAiel+ZFh
         acFGD/W/gNTUS3q32CI1RXEpyQ2fm5wjJ20joW7InHgP78ZHKGuTqski7UoV7nTbixdR
         WuyuRSA5ecry+Ng67ZtbQVu0/I0fke+iH+dyjk/aze/J5PVWfGoB24GOA+Z/iRscG/V4
         RZ6osqBLLa+cvzoOgMh/gRawsj3rcMx+GV33JVzqCmBMBniO//4/MmAiTtq6Cp2+OqzA
         YpfwhORkkOYrJ8fxHapwod7zDWVj0Cl7VTcr/7wXCjDDrJfVut52MwS3hTzfCAYCR67b
         fJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34EYu6s44WmKiU9es2g+d10DIzLnlfP0XCo2vAPXts8=;
        b=bmD0eEt0/YayYGZA0HQkJC5xF9lkoii6R3RouBUKVtNmRk+A1Z14Byy4MHJEFTg3VL
         yrCmy3lOnFa0dIFlaYIS4MZCeFQg9ud10a9xwec08j24VqcrscAzhmTjvVVqMdkIoK1g
         iESmn1GD3rQz9z4wfiqsdLvnD53eV5Qi0GtpF1Ku7QggJG+qngmQf/bCGby/H/RlF40L
         KT00Yz88cfWIs3NaiCmlPVCoiX8G69xNgISZDUSZdFCxRgrAlTtUmteiNWHI5VDO7Cbh
         /GGqU9Qjsvdghxo1dL7ChXCESpcns7yot1Ymsa1zsDrq0Fqddr9MD8vHW35/z0A4wsXf
         JARQ==
X-Gm-Message-State: AJcUuketDNbbXC74xgEpMQmLBRKdN+B2CMgMZNAxx/Ff2BmvixcyuMlG
        HhE37GHzyxrkfLXGWcDJcUPhRN6u
X-Google-Smtp-Source: ALg8bN5ZY1JnMgC8imkZGxTt4duTK3IdJIihhCHDe/ZX2y6ny2WIJnic7I3yzdRXJ7AyQbel0oGEKQ==
X-Received: by 2002:a62:8dd9:: with SMTP id p86mr14691111pfk.143.1547730507899;
        Thu, 17 Jan 2019 05:08:27 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g185sm2274588pfc.174.2019.01.17.05.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 23/76] diff.c: convert --name-status
Date:   Thu, 17 Jan 2019 20:05:22 +0700
Message-Id: <20190117130615.18732-24-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 056b766264..e685356e3e 100644
--- a/diff.c
+++ b/diff.c
@@ -4950,6 +4950,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "name-only", &options->output_format,
 			  N_("show only names of changed files"),
 			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-status", &options->output_format,
+			  N_("show only names and status of changed files"),
+			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4978,9 +4981,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-status"))
-		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
+	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-- 
2.20.0.482.g66447595a7

