Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59AC020248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbfCEMay (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:30:54 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34789 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbfCEMay (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:30:54 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so5553537pgd.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l/Jch/r6hkm+AVQAa4uKNuURqUGzv2jr2kdrudca9Ho=;
        b=EtoPV1oB93UcgDU0AQzOqfmUm2b6HMulBhZj2ZMB+i+vE3qQE2wjvvFrsq9dtLELUP
         +MaoYMhUqWdVzKsKmQ9UdunVoUzU3sd6enAAgw0jJpUqdtyU9K8zZptU1h+Gh98D1fW4
         iySi+1tzmKXJ03+FFnvr+WPAy9QsmG7NWU77Plkb+s4e71GZwdT27KH4w7IE7GTFl8XC
         xypA6mMinECg05QAnfUlLfnSl1QK1USka3ZXcPVi7XChdJxzkyfsHtprt9HGGqssrESy
         uAlmhcSx75eZmRkmTl3Jr89brXcoF02mJDvRj6ZuhRoXrhWVEXLyyUieg5r6bxl5FacA
         ztkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l/Jch/r6hkm+AVQAa4uKNuURqUGzv2jr2kdrudca9Ho=;
        b=I5d1x0fCwmUyPX1uE2D5yYTz9AGoe2RBwMMEg32Tjaoa8VZGAwoHVF1MWpwd1OQUZs
         v52qjOTf1NgzRrRPUF8VzCR2QP0bgULmJRMjX2huRyxhzZzGg6JjLoA/qYfjbZMW47yo
         /SXNaiznYfyRLKh915NzCEJDNqjZvTaA+2+/cvdyZiWv0mWhiqdxjuBXmmEw/PqGQbY6
         Gopu/7CoGlMG+NaSpF2g2KQb9bc8ZaThU+M97B3gSJ/yGA/6HTgknGn4b/DhQskvnjZV
         vDzqXQPhR0qSkdimVCApF6tPugwq+33ly+3pF4x4NrNTLL/alniqGAvU0YjJmXyK4BGu
         e/5g==
X-Gm-Message-State: APjAAAV81Pdzc6BJiNsQeiTCECALgoybFY0xdPq+t8k5MSC3HJe+Bx5x
        EmngIxwxv9yTGhew2TvJb4z/ND0/
X-Google-Smtp-Source: APXvYqxm7Y1CPLfEX/iZ4fNYk5TBQWJiHE0jO0y2e8D0fODu2qhGaEeplPyjALm+ZSkHeTFmDu0ltQ==
X-Received: by 2002:a63:7e0e:: with SMTP id z14mr1207637pgc.436.1551789052959;
        Tue, 05 Mar 2019 04:30:52 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id g3sm11929943pfo.125.2019.03.05.04.30.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:30:52 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:30:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 02/20] diff-parseopt: convert --patience
Date:   Tue,  5 Mar 2019 19:30:08 +0700
Message-Id: <20190305123026.7266-3-pclouds@gmail.com>
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
 diff.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index c4cd84f1b3..7899c7cc06 100644
--- a/diff.c
+++ b/diff.c
@@ -4960,6 +4960,26 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int diff_opt_patience(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	int i;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
+	/*
+	 * Both --patience and --anchored use PATIENCE_DIFF
+	 * internally, so remove any anchors previously
+	 * specified.
+	 */
+	for (i = 0; i < options->anchors_nr; i++)
+		free(options->anchors[i]);
+	options->anchors_nr = 0;
+	return 0;
+}
+
 static int diff_opt_relative(const struct option *opt,
 			     const char *arg, int unset)
 {
@@ -5127,6 +5147,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
 			N_("heuristic to shift diff hunk boundaries for easy reading"),
 			XDF_INDENT_HEURISTIC),
+		OPT_CALLBACK_F(0, "patience", options, NULL,
+			       N_("generate diff using the \"patience diff\" algorithm"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_patience),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5165,18 +5189,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--patience")) {
-		int i;
-		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-		/*
-		 * Both --patience and --anchored use PATIENCE_DIFF
-		 * internally, so remove any anchors previously
-		 * specified.
-		 */
-		for (i = 0; i < options->anchors_nr; i++)
-			free(options->anchors[i]);
-		options->anchors_nr = 0;
-	} else if (!strcmp(arg, "--histogram"))
+	if (!strcmp(arg, "--histogram"))
 		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
 	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
 		long value = parse_algorithm_value(optarg);
-- 
2.21.0.rc1.337.gdf7f8d0522

