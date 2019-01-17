Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FF041F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728243AbfAQNMA (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:00 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNMA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:00 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so4442275pgm.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RSEHW5FyShtPWukE6Zn/v9EQjw4bp1KczPsViVsR6CI=;
        b=o3G0vpcnEZpjbwXowFGY/EYu3BSFbgUVkgs21oFoM5gjxvQQIU90yFlbR7jY1rhZHb
         BwLPIytH24Xr6jhpXpvgtdvMwl6PM+EZxbfrRmYStB0ouDD35n/Ijh6zjyHvgq/68fCm
         Sc/MQduzPrvoaxh0R30auCDaQMIZaSfN2RWpVQxM1h2MaVvCHK56u89U05Ts46HDruOj
         fhyzj6/BbFHGdRl4D4Rbc0ELWX8HYGXMIl2/TUlF6Kc3wpnpZACyCFiid/WbD0euiXFz
         87mcsaU55v5yEHor76Irv2r+nO7xVO/U/F8N2+4xeNtIa+9hwO8vHNAJS9jIdmvHAF8g
         /sSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RSEHW5FyShtPWukE6Zn/v9EQjw4bp1KczPsViVsR6CI=;
        b=YbMT8Ncqx3V7vkQ8aXX7EQjT7xw33aFS+mRxouApdxAJBT1m1bW+D4Emh7SkpbL2Jy
         S5rJVs9zutfIl8nxRNi5fultTnwYAQtqx6IEPXPP+0iBDIQmiYj1Ozoq+7bzrPF39QCh
         nPMWVPJYWQXCXidCGJoeUf4u8oJwg2oIvJGldYLUW2/mjWlC/3n83bwxGUjeQ6/QJY/e
         L9x+/ABCGHviM1TAEmZh9s6A68L7N0UDC0DUo+AEzCnCGtWF3gzHn5HMV0xzJwKTYdEK
         h+PHXDeDmEZoMcGvXJvMGwmD+OQ4kJtSjS9nbwipI/dovzJqmJoXPvazE69ynPAqc2to
         G+Kw==
X-Gm-Message-State: AJcUukcAgalF4cfG1zTjtKyhy38qzrnFF+xyE9+m+DjcVnNnylbyJvyJ
        K+F6eAM+fO4bZdne4E72fWGB4ioO
X-Google-Smtp-Source: ALg8bN6mt6+RF7M1aE7amiCFQwP5SolUmXK08UJ7gqFU+iZfartHgj+CS5uPCGXFjUCNOBllDezdHA==
X-Received: by 2002:a63:6906:: with SMTP id e6mr13198458pgc.144.1547730719039;
        Thu, 17 Jan 2019 05:11:59 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 22sm3718561pgd.85.2019.01.17.05.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 66/76] diff.c: convert --[no-]abbrev
Date:   Thu, 17 Jan 2019 20:06:05 +0700
Message-Id: <20190117130615.18732-67-pclouds@gmail.com>
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
 diff.c             | 12 +-----------
 parse-options-cb.c |  4 ++--
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index fee45c5066..f137b7f442 100644
--- a/diff.c
+++ b/diff.c
@@ -5274,6 +5274,7 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_SET_INT('z', NULL, &options->line_termination,
 			    N_("do not munge pathnames and use NULs as output field terminators in --raw or --numstat"),
 			    0),
+		OPT__ABBREV(&options->abbrev),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5468,17 +5469,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--no-abbrev"))
-		options->abbrev = 0;
-	else if (!strcmp(arg, "--abbrev"))
-		options->abbrev = DEFAULT_ABBREV;
-	else if (skip_prefix(arg, "--abbrev=", &arg)) {
-		options->abbrev = strtoul(arg, NULL, 10);
-		if (options->abbrev < MINIMUM_ABBREV)
-			options->abbrev = MINIMUM_ABBREV;
-		else if (the_hash_algo->hexsz < options->abbrev)
-			options->abbrev = the_hash_algo->hexsz;
-	}
 	else if ((argcount = parse_long_opt("src-prefix", av, &optarg))) {
 		options->a_prefix = optarg;
 		return argcount;
diff --git a/parse-options-cb.c b/parse-options-cb.c
index 2733393546..6e2e8d6273 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -22,8 +22,8 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 				     opt->long_name);
 		if (v && v < MINIMUM_ABBREV)
 			v = MINIMUM_ABBREV;
-		else if (v > 40)
-			v = 40;
+		else if (v > the_hash_algo->hexsz)
+			v = the_hash_algo->hexsz;
 	}
 	*(int *)(opt->value) = v;
 	return 0;
-- 
2.20.0.482.g66447595a7

