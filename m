Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BB741F454
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfAQNJM (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37405 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so4744299plr.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/vGsXWe7ixmzFXnUagOltV7mzKfUISbIzMHDhEmxDkg=;
        b=UuRyfsSsVMF0rBgmuKDY/bnSjr/8PphVxrL36cYO0Rr79kfIZlVtF+4G/rrG18PkoT
         Mo7f++hSGfve1EM2bDyB8fx59YLtRKyc9ZsvvNjppmVfyk765SgqfumHqKXxHd5xz+ZU
         qJnNNLn7agcj1sD/BH236eV1B0yTosnvSoYxr4ff/FCPLhwjzRch5jYJtr8WFdOaJEv9
         I2tbMAweLSvg6FEA/6KwnICsN2TZ5NH7poTtZirpMU5s0wgLOQTi+U9c0Mp+WFkdgENY
         grg3NHic20lKAfqFb4zPHcCJ7kLpl5JdbDrwd6sSaJ+s+EbUHZkz3upcrNgga/oYldzp
         nmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vGsXWe7ixmzFXnUagOltV7mzKfUISbIzMHDhEmxDkg=;
        b=WUMB0QNgDBK7iCV0gmRzKeASuhjltHdt5mT6LgM2QYuNLNe4IRWBB40ixVp47vSmbK
         8KFkjNgutcswXawMrhwTbM4SEHYXFN1+fdFIMcCxGEvNbA30Ct8vyFxrdRwKJ4hMEz1x
         2VS9uJVB3mYpGiBbeiptiN0SRGrU/nPKmry4F1dCL1X1G7aZDvBM9NSF2G0QbtLujqi6
         X8fxdy1TKvqaTMGryEWIi4CnaLwG/qhLmclfb61/xSBDNftYwhFVl7f5HjpOUt7GtGSK
         Z0CrGP4DHAUewEjrOQLcr2+691LH2F6X3jtpUCMAxEo4Wrl/Aoq99YxVeTOhdErOr03G
         YqBg==
X-Gm-Message-State: AJcUukfnyhYN/VgMRvfnkjRrpaPyRLR0tCjCG9ic2GbHAH5MjT/TiNFa
        StbFjwSTyhWnOCL3PDG3kuNuU64+
X-Google-Smtp-Source: ALg8bN5qsZSXIly9NhWwAkI7Hjw7Vx4swCzNTPfoxGQyffcLdkJNjbYBdz15YieQoJp68YfbBI7WKQ==
X-Received: by 2002:a17:902:8f97:: with SMTP id z23mr15061154plo.283.1547730550982;
        Thu, 17 Jan 2019 05:09:10 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id g185sm2276598pfc.174.2019.01.17.05.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:10 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:06 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 32/76] diff.c: convert --find-copies-harder
Date:   Thu, 17 Jan 2019 20:05:31 +0700
Message-Id: <20190117130615.18732-33-pclouds@gmail.com>
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

--no-find-copies-harder is also added on purpose (because I don't see
why we should not have the --no- version for this)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 3b05e03284..0756612eb0 100644
--- a/diff.c
+++ b/diff.c
@@ -5089,6 +5089,8 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("detect copies"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_find_copies),
+		OPT_BOOL(0, "find-copies-harder", &options->flags.find_copies_harder,
+			 N_("use unmodified files as source to find copies")),
 
 		OPT_GROUP(N_("Diff other options")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
@@ -5195,8 +5197,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->flags.text = 1;
 	else if (!strcmp(arg, "-R"))
 		options->flags.reverse_diff = 1;
-	else if (!strcmp(arg, "--find-copies-harder"))
-		options->flags.find_copies_harder = 1;
 	else if (!strcmp(arg, "--follow"))
 		options->flags.follow_renames = 1;
 	else if (!strcmp(arg, "--no-follow")) {
-- 
2.20.0.482.g66447595a7

