Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A421F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbfAQNLi (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41567 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728230AbfAQNLi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so4722042plm.8
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QZzudpSYkIMS5djoND0iHfQNz3K8agS66MEN1Xkeuc=;
        b=Ewifc3RZUS75cFH6ihSRriZl4cc6D4Th9WnO5v9Zyn5D1Wg+S/m15IDXr/1h1koSBZ
         RIvsqZRqtVSEXdoDW+HLmV2VwiJpZoECZWjM2l6Pw0WR+fWvWZjirDRfOthRxRGcIYV3
         EKXEkmGJnNbFoyqp/PT2auOjBxFoSCcZT98iJXOFqLvMXlq+cCH9/Tcj/NNtL39b90WW
         VtyG3FikjHPIgu5Vl0H+wq7WGljdPcOHu6R4yzeOKgxTj/2t4ynZwVp84I5So/yK91eD
         ArZEpbvis5SieXVmMJBGr1EyvKthWK32Gd2uUUrhz2BZipLP9ryUQdCYRObu3THzBygl
         QM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QZzudpSYkIMS5djoND0iHfQNz3K8agS66MEN1Xkeuc=;
        b=HoaVl0QT5Y7Qd97CTrNkb77o1Fwiq0dHhhhBNyKVxzq88VZc35wXAoEDYqUSdwsJiD
         WtdiGlHqfX9HeXTV4XJxuQWHMcGMUXtlaJQaWNkWsV9f74mZIGFRh4etkln3GIYuF2V5
         kap395bwo4F40LKZJSPW1duJy2yWokEFIBbRsMErYPM/ZihFhQp1zhB06PFPDml3FCTv
         LkX7Hrdmq7fAmgKMcf2sn0U1AchP6TRnULc8WbhWDrrTLS311ie0tU4PB2ileT6B8rxL
         HpL6BWF9vN8CsHjF8e6ORW1h/5UHmlFs/yOiV5Y3vqdQJXj8zwa+OSp307N0sOeazvAU
         4EPQ==
X-Gm-Message-State: AJcUukejUm8bSqkbDuH7Ss+q7Ec43jLf4/1U38mZA9doVrcooHNaRmbM
        p/UpmHmbsy9zmTntq0qcNsHdz6f3
X-Google-Smtp-Source: ALg8bN6xWTbYrEwSMyLyssv5dj3D4r2SzbGnPds+GwARWcBWWRDo9ta6V4mxc1ggztRzqZDvfacqyA==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr14641093plq.195.1547730697449;
        Thu, 17 Jan 2019 05:11:37 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 78sm4059606pft.184.2019.01.17.05.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:36 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:33 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 62/76] diff.c: convert --pickaxe-all|--pickaxe-regex
Date:   Thu, 17 Jan 2019 20:06:01 +0700
Message-Id: <20190117130615.18732-63-pclouds@gmail.com>
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
 diff.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 832a5bcd31..ae993f5551 100644
--- a/diff.c
+++ b/diff.c
@@ -5395,6 +5395,12 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F('G', NULL, options, N_("<regex>"),
 			       N_("look for differences that change the number of occurrences of the specified regex"),
 			       0, diff_opt_pickaxe_regex),
+		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
+			  N_("show all changes in the changeset with -S or -G"),
+			  DIFF_PICKAXE_ALL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
+			  N_("treat <string> in -S as extended POSIX regular expression"),
+			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5447,10 +5453,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (!strcmp(arg, "--pickaxe-all"))
-		options->pickaxe_opts |= DIFF_PICKAXE_ALL;
-	else if (!strcmp(arg, "--pickaxe-regex"))
-		options->pickaxe_opts |= DIFF_PICKAXE_REGEX;
 	else if ((argcount = short_opt('O', av, &optarg))) {
 		options->orderfile = prefix_filename(prefix, optarg);
 		return argcount;
-- 
2.20.0.482.g66447595a7

