Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8983420248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbfCEMbD (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42475 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfCEMbD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:03 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so5589866pfi.9
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dJnaHbLK7MWEonIsU/zSneSfXYpWf1RdJ+KwLO9tlzA=;
        b=dMB3TSuiOVAufiP1DzOl/pH469ZLO17LPH7s7sUkRM7Y9Mvv547iNpOFspTjl97OeL
         hxdC6TLhd3wn3r+fTiye7FVMXsz5W7wYkachByszo8ee+FhxOmkXNOmF899v9RaiZgl7
         7SlsYVT9z/cyuGalb5QiH2iCto07Re4VTbPL3rHIYcZewCo4cqGfxYpJAmYw8GAJMQzN
         Z61uyna0cv7mK3ZfaIX3iWxImts2C0AgpAmbV6MQRu+WqsDqXr0X8dYIq9IXfziwVTVj
         8Vi+vnQ16PjqRLFFpX9OMdfcxLl0s/5Af+S6B8HwK64odjxa+NuPsWYgw/rE+FRuiHZr
         sPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dJnaHbLK7MWEonIsU/zSneSfXYpWf1RdJ+KwLO9tlzA=;
        b=kKOEa1+lzqEQkOFONw6iOp+x9DIwgriuMbNx8eWnnuhx/U4WKGGfhg7tZOvkW5DWlQ
         crvaE3vvLGQTc+kgm5lNIH/6kJuq2np3eeLoend++dHPTUqXzzFZZNBtg0MgTURba1Ye
         wFqgKySbB+Yq5SuOXXKEve4ybo2D9pheW6NK3wwXAwj1UOw34mZuxwSG03ONc26/uJ0A
         U809jHlR4MC3beFbMVhQcqZVmCTqI9mq91nLN0RP0yNqi+lE/Z6lJWwEIkK2TgKPRuMb
         Y3GJ5LmAnGX9QoHzDUKcqykGsCl/neQjB6vRgBz209c1cmfjoSrk7PwyGco5sqZNivjA
         9IqQ==
X-Gm-Message-State: APjAAAUmRPiplT8zJnCzmWZsnWmPQvlhLv4rP945b+x8X0NgcGF1mVg1
        W7WL2H+h050yuIq7ijvSJWfAF6Ja
X-Google-Smtp-Source: APXvYqw05byM7ex/N8fr+QEl1sFNbWBCETQpwfHFW4vWIvBvm8/UZ1TX4wxIZWYnUTszjCGsvXuoKg==
X-Received: by 2002:a62:574d:: with SMTP id l74mr1656265pfb.9.1551789062326;
        Tue, 05 Mar 2019 04:31:02 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id i14sm24266122pgt.82.2019.03.05.04.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:01 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:30:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/20] diff-parseopt: convert --diff-algorithm
Date:   Tue,  5 Mar 2019 19:30:10 +0700
Message-Id: <20190305123026.7266-5-pclouds@gmail.com>
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
 diff.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 7432702fd8..8d08795f9c 100644
--- a/diff.c
+++ b/diff.c
@@ -4891,6 +4891,24 @@ static int diff_opt_compact_summary(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_diff_algorithm(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	long value = parse_algorithm_value(arg);
+
+	BUG_ON_OPT_NEG(unset);
+	if (value < 0)
+		return error(_("option diff-algorithm accepts \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
+	/* clear out previous settings */
+	DIFF_XDL_CLR(options, NEED_MINIMAL);
+	options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+	options->xdl_opts |= value;
+	return 0;
+}
+
 static int diff_opt_dirstat(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5154,6 +5172,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP(0, "histogram", &options->xdl_opts,
 			  N_("generate diff using the \"histogram diff\" algorithm"),
 			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
+		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
+			       N_("choose a diff algorithm"),
+			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5192,17 +5213,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
-		long value = parse_algorithm_value(optarg);
-		if (value < 0)
-			return error("option diff-algorithm accepts \"myers\", "
-				     "\"minimal\", \"patience\" and \"histogram\"");
-		/* clear out previous settings */
-		DIFF_XDL_CLR(options, NEED_MINIMAL);
-		options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
-		options->xdl_opts |= value;
-		return argcount;
-	} else if (skip_prefix(arg, "--anchored=", &arg)) {
+	if (skip_prefix(arg, "--anchored=", &arg)) {
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 		ALLOC_GROW(options->anchors, options->anchors_nr + 1,
 			   options->anchors_alloc);
-- 
2.21.0.rc1.337.gdf7f8d0522

