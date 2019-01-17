Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50D691F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbfAQNIT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:19 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33684 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:19 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so4747970plo.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0kapXo0GMfqcSgpVvl70nAs+rzHeAh5vmoq3vEvhpM=;
        b=QtpFmJLMY2l4B4k8ncI3sH4jmHvi/kigzMUEJjI3YE88sAloqiv7Pw9qxsgMyVuPxX
         Y+6RaxmfiPSF943oow8f0m9bfkoR1B3k4j1sq7TM2OvQd9PhpUql7LvLT1tN4C+d37GA
         +HwHXcY9bGBSA80ezQwAarx2xvSdTX6xS7OSZ3lN25J2Ka/4wlEHPCZWdPozuLNriQJq
         Ix2c/kLPzVQPF+vC/tmX0OAacVr/ez/upixkP97Pyk26XpejdMOmXwzBOJkYbqlx62O7
         s1IPPdazgY5B6Qe4xeNz5wPxcdMcH+RjQpvJ6qIvlAJmTpKNL6pi5+HpjeBT1yeEI3sz
         OYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0kapXo0GMfqcSgpVvl70nAs+rzHeAh5vmoq3vEvhpM=;
        b=P1OmTzVyj5g/T1735lv+R8c5kfokvaLnVWv9mwAkjCOfRzyecfvne8Li173K7KN+pg
         2e1fq5jrkFxY0eJJlGYQRa7BtbhCveI9LJJbqyp4C/rYNAe8W60HaJPABeRlSD2tBgAZ
         rX1ApMJINekhqH8V6GaxE94ECRHA3tYFl7XXtZyz5hdYAPJe6qzyLym3gXrX6gl6KnkG
         vCpXJjQndK+SLfn+7r62UdZ5QMx4MamoIf60/kBzCHkod2IX0evBnGPfeofSwh43sldw
         qBeemikANdmrma/DNNoKwkQnoGAzZBuJsXI8ooLib5RNamYk7VF69dv9XNKqkahJDRx1
         +vYA==
X-Gm-Message-State: AJcUuke+vy4tPG8S5D4Kb9Ye/H1tzLUxtHWQ/IYY1wssv9T16lOSEspY
        CNj0AXnN4S86h3UIoPfgFR/gYyRP
X-Google-Smtp-Source: ALg8bN5Gcoyx99oBXy8Kj8KNQ2PJwtry7B1/0K5OI3YP5Dtg+l1t8QU0yUHv9gJpaFsp3D5vIZNG5g==
X-Received: by 2002:a17:902:7896:: with SMTP id q22mr15133648pll.280.1547730498076;
        Thu, 17 Jan 2019 05:08:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r80sm2852945pfa.111.2019.01.17.05.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/76] diff.c: convert --patch-with-stat
Date:   Thu, 17 Jan 2019 20:05:20 +0700
Message-Id: <20190117130615.18732-22-pclouds@gmail.com>
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
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 73fbe5b265..2ab3d68d9c 100644
--- a/diff.c
+++ b/diff.c
@@ -4919,6 +4919,10 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BITOP(0, "patch-with-stat", &options->output_format,
+			  N_("synonym for '-p --stat'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_BIT_F(0, "numstat", &options->output_format,
 			  N_("machine friendly --stat"),
 			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
@@ -4971,10 +4975,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-stat")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--name-only"))
+	if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-- 
2.20.0.482.g66447595a7

