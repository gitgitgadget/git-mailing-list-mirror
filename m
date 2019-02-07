Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B83C1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfBGKek (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44835 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGKej (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:39 -0500
Received: by mail-pl1-f195.google.com with SMTP id p4so4568278plq.11
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nGbkbYtZSa7mWbxq4jeHLbAlnsNkn76OlTjRrf9IMyQ=;
        b=IdH2b9Z+U5xCr8g0t+EcxQHitjRlZPN04Crz8kDab/NRls3+38+df5ninLzCtieMVO
         tKfrMugMeMbw6y6m59HKsB4MmlfdN7nTGo04v6wCN7ueswCyshfCbv4E1VQifyqjSVoH
         z1AAHUlucHnDoccXa4hitf7ABo8uvwRIC5IQmXhHZn0MXoUtIcaQE5rDOrbb2QHX0QJ6
         FsSYjjAye3O4ZIll7HFixONdcEq5obFgrwftF1+RAf7+NnQ7odlN+Ge3yBRz6NBmgaF3
         GqiccvwfdJWy485gelohXJTCXLS7PHLacf0RK9Qhf/XPuhFETa9N108AbPcFHEGtnZ2a
         dA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nGbkbYtZSa7mWbxq4jeHLbAlnsNkn76OlTjRrf9IMyQ=;
        b=hoLbPZkSwfqlV5bMtc2F9xt2hurpeL3Cpaxb7XeUYjNVHNfjmNOizMPPzMiWuH11ri
         D5KC8+vSGxd8WuhDToxeB0H2qRZr74LTQ3rNQ00VNNFhX8dH79suX17b1akttfNiczCq
         FgGCaAcmgU1l+UcSI3c31lwzS9PpOMLOtinbfvb8m6HZcFWeGd09umlIAhN8XHhGE00L
         ubNgCSRVTL870GFsTGQezpbjo5xQtpLXOih0hGMDFWZCcdRI5ErrXswDSAYtbePf7ljK
         uviVvnYCALLBrB2GHXxItHcQr3MO6zytW68nfPoj+lxKnAjdZSVOmsm5XIyreslSdx3x
         lP1A==
X-Gm-Message-State: AHQUAuZQ5T6RneEhgNYt3n6REdfwyQbB1s1BD5azZ6Vlo48SwWQGEZqn
        2zbO1VVahjNX6HP2H1gKNiZYoxfK
X-Google-Smtp-Source: AHgI3IaxHj3FeNJhVJ+Z5xJBY1M5KvdjJiR3bv4IJ0SpRXXH8FCqA/fyfMRym3Jpz5Zjnexyl520/Q==
X-Received: by 2002:a17:902:bc3:: with SMTP id 61mr15880422plr.15.1549535678981;
        Thu, 07 Feb 2019 02:34:38 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l82sm24137203pfg.127.2019.02.07.02.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:38 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 11/21] diff.c: convert --[no-]compact-summary
Date:   Thu,  7 Feb 2019 17:33:16 +0700
Message-Id: <20190207103326.10693-12-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 1feb13deb3..b24f6825a1 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,21 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_compact_summary(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.stat_with_summary = 0;
+	} else {
+		options->flags.stat_with_summary = 1;
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
+	return 0;
+}
+
 static int diff_opt_dirstat(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4947,6 +4962,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "stat-count", options, N_("<count>"),
 			       N_("generate diffstat with limited lines"),
 			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
+			       N_("generate compact summary in diffstat"),
+			       PARSE_OPT_NOARG, diff_opt_compact_summary),
 		OPT_END()
 	};
 
@@ -4975,12 +4993,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--compact-summary")) {
-		 options->flags.stat_with_summary = 1;
-		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--no-compact-summary"))
-		 options->flags.stat_with_summary = 0;
-	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+	if (skip_prefix(arg, "--output-indicator-new=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
 	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
-- 
2.20.1.682.gd5861c6d90

