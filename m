Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC41620248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbfCEMbI (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:08 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35134 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfCEMbI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id e17so5557386pgd.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ff35se/UmuEiD3pS1Mo00SSns6/2OiBoVEfkIyfpnEA=;
        b=n+ki92y1TWqxl3t1jkl+DPV6qTz3ijIKXqDJt7BH/xCn2DB0xbV4Yu+OBEUKw0GKWG
         gToAjuuvgoJHMuvOR/aruF6fWGU2Gecj4wcKsKS+I7HqMc9ERyymB4Z7X+EaleVAG40P
         vQiEkwnhG0vn7mGdQqvfoEw+mfcuzIHxjSIh8RuzMtLaa7I8bblyl5oANcmA62YsrSWp
         ZEEOhS4cThtKZZObyNNS42O/Gss7265XGNrabTrU2VN0ri/zaJTxQQq0D8bukvrymRGU
         77sgvAHBN6aBOxEY3NCj4+/5G9/GKhbWVfqDUppVrdogCJbCvssokdWTQ2iXdry8PF/0
         e3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ff35se/UmuEiD3pS1Mo00SSns6/2OiBoVEfkIyfpnEA=;
        b=eX3Ayks/8k+MkVdVyV/VSPdCc4g2niGyYPnWk4SE3SSRmYxqzLUmpjTxyWWq0N5vWb
         blY7fispzQdscdD/f/x/SEjWs1gTOFyoUeBNI0zOvOpduNAu2HwYoq/LtYlCP1V+IL0H
         UCHrxEft2BUjT2s6KadGkBsHmWFa+qY4rPsMqFNVb26U+ElY++xDK02+jvBXIqxfgdVc
         HRdpduvwpmQ7ZSAQxdtQLggZyFlwKBEHMDhIz4buO9sBX6nQVXYOuxa1QcgAXL4X0lbV
         JpRnIwk30yuKxBtPRpOna89vt3NJTXezUFpnZAvkj+gICv/2msvpooR0OY0QO5AcI/ZL
         e92g==
X-Gm-Message-State: APjAAAUcOP+zWm/lQcUhmUO2oyaRY3i8de1qFfDtX7+QMcruCy6/t3f6
        /yUp1yL1hz68VsPMiS5+hpT9rCCA
X-Google-Smtp-Source: APXvYqzYRq8/7a6eid0N2vhPyAV3LdZ7wOUg+K67cLeJEfqwwNVLQv4vTUtxOYtNwQ3JkvVgGRAOVQ==
X-Received: by 2002:a63:ea52:: with SMTP id l18mr1200590pgk.317.1551789067258;
        Tue, 05 Mar 2019 04:31:07 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 195sm22642259pfc.50.2019.03.05.04.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:06 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:02 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 05/20] diff-parseopt: convert --anchored
Date:   Tue,  5 Mar 2019 19:30:11 +0700
Message-Id: <20190305123026.7266-6-pclouds@gmail.com>
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
 diff.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 8d08795f9c..5195526db9 100644
--- a/diff.c
+++ b/diff.c
@@ -4839,6 +4839,19 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_anchored(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
+	ALLOC_GROW(options->anchors, options->anchors_nr + 1,
+		   options->anchors_alloc);
+	options->anchors[options->anchors_nr++] = xstrdup(arg);
+	return 0;
+}
+
 static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -5175,6 +5188,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
 			       N_("choose a diff algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
+		OPT_CALLBACK_F(0, "anchored", options, N_("<text>"),
+			       N_("generate diff using the \"anchored diff\" algorithm"),
+			       PARSE_OPT_NONEG, diff_opt_anchored),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5212,16 +5228,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* xdiff options */
-	if (skip_prefix(arg, "--anchored=", &arg)) {
-		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-		ALLOC_GROW(options->anchors, options->anchors_nr + 1,
-			   options->anchors_alloc);
-		options->anchors[options->anchors_nr++] = xstrdup(arg);
-	}
-
 	/* flags options */
-	else if (!strcmp(arg, "--binary")) {
+	if (!strcmp(arg, "--binary")) {
 		enable_patch_output(&options->output_format);
 		options->flags.binary = 1;
 	}
-- 
2.21.0.rc1.337.gdf7f8d0522

