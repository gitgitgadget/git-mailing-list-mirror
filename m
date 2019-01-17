Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A51811F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbfAQNLz (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35938 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so4442199pgm.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M2kBe2SWtNY+RYB86nSYZtLY0VoW8fHC1YzyKkFTDbI=;
        b=Pu1hN4IkjJ0+i65sl7ZPdaFP4rW37/v1zeOcsajiGTkv3esECjdjb37PoxBjnovePo
         ySjQAKgDGGQIM+Hmao1ail4z7duTpbjsxDqy8/7IovTWq5OA4t5jQWdRAiu59AHmxFG/
         2FpymkyPqzeqw9CtuzkN4T7h60GzxfXA6Vd+pVzbEvsIoq34k/cwwdCX76K4TiznzaF1
         EQTICYUKRiDTJ1WiYzOiS6ZJ9f1IRpiMrjiZxBZxOw1BAJm6xft1HTUhhrUUepWvQ+32
         Vx+eLh13suES9Jj28OgP0oWiseX7BZh8yF9YgyKNGuigjIj9+tN8AqZq0Y13Bpp5j1GM
         8U3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M2kBe2SWtNY+RYB86nSYZtLY0VoW8fHC1YzyKkFTDbI=;
        b=ova2T6tSJv9QKJKjgSSkglc922boyIodIJcWn4b8XG/wkODBO3lnzAJMUxzShMu9Yc
         PGTsclnZiS89SyO609NKWV3xthwWDqDm17J+wSd/RKb73APCfllmobuKpesNDdB3h93F
         gaNeTglyoZ+pXF+3anShdm16qMvUhbYhK4NvKY8kH8RAtYFSa67apCyPuISm44KBYzD9
         Q3+yRfbNOnNC3pQhF+zIdrYG4r3qhVrpP4wUcIJMbsU6YTAWd6/KwO7LIA0e9ogyeQfY
         eY0pk/ND48L7+69aElm7aGvmZo1CjYO4SdF5D+dZw0rM3MsibfH7/zVHBL+g62mdUBG6
         xQvQ==
X-Gm-Message-State: AJcUukdSkMs1L0/W6TVzmKGX+F0mTeuU65gPWKtDxvqmKH6Jh9mhN04M
        s2YNIAPAZ+exBFIKoZUIcJF2LuVV
X-Google-Smtp-Source: ALg8bN63ej1SMNMP9mlnoFNxaEcjlYywOojtISGJh7KOJDXlsYT+1aqyYjwUr0XFlGRxoizvSN0Xeg==
X-Received: by 2002:a63:ef47:: with SMTP id c7mr13567887pgk.386.1547730714268;
        Thu, 17 Jan 2019 05:11:54 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id z13sm7382362pgf.84.2019.01.17.05.11.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:53 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:49 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 65/76] diff.c: convert --diff-filter
Date:   Thu, 17 Jan 2019 20:06:04 +0700
Message-Id: <20190117130615.18732-66-pclouds@gmail.com>
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
 diff.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 2a943d47fd..fee45c5066 100644
--- a/diff.c
+++ b/diff.c
@@ -4756,10 +4756,13 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
 	return opt->filter & filter_bit[(int) status];
 }
 
-static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
+static int diff_opt_diff_filter(const struct option *option,
+				const char *optarg, int unset)
 {
+	struct diff_options *opt = option->value;
 	int i, optch;
 
+	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
 
 	/*
@@ -4790,7 +4793,8 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 
 		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
 		if (!bit)
-			return optarg[i];
+			return error(_("unknown change class '%c' in --diff-filter=%s"),
+				     optarg[i], optarg);
 		if (negate)
 			opt->filter &= ~bit;
 		else
@@ -5409,6 +5413,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
 			       N_("look for differences that change the number of occurrences of the specified object"),
 			       PARSE_OPT_NONEG, diff_opt_find_object),
+		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
+			       N_("select files by diff type"),
+			       PARSE_OPT_NONEG, diff_opt_diff_filter),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5461,13 +5468,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
-		int offending = parse_diff_filter_opt(optarg, options);
-		if (offending)
-			die("unknown change class '%c' in --diff-filter=%s",
-			    offending, optarg);
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-abbrev"))
 		options->abbrev = 0;
 	else if (!strcmp(arg, "--abbrev"))
-- 
2.20.0.482.g66447595a7

