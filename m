Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB7520248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfCEMa7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:30:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43439 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbfCEMa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:30:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id q17so5584380pfh.10
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+A8vtr9Uuy678JAjKcR+8VWtyQ3GIetirPoUSxB1I3g=;
        b=M7Ip6GVBmVRxo3wsJOalSDvwWF4gKOAn3lGNJB+cfGEyx2pwRMb0llJw5K92Dmnwdc
         BrFmBz2MYD0/mgWfexQEbDwvyrBv3iZiAQczCIaqLGV/Vi17LNddJ/S0YbPBR9YK3hdm
         L67doZ/YVonLDX6IT6HJNlpOfTrbiBp+d+8zVMKAsofptumROZw1EzrKZq4r6muWQm8b
         EikUFV0Hg4YhUjwMLCFxG8T5cqYQpuQHVKc+vKvvX/PH2tAKz3exVKuCx3RBzr0H9MSP
         wYMQnf2iRf2a4gGFOlAlRrfYr6AkgRhVAnfhAnnBWMRS5CKK+DvtbWp3oX2rwy4h6EPj
         Mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+A8vtr9Uuy678JAjKcR+8VWtyQ3GIetirPoUSxB1I3g=;
        b=PfRirwhsnQqcCyzN8AD3fTDAjgZo9Rxt2yFkfGiLSZMswgSaCfoCeiMMvcPdhuj/+V
         lZewcIirpeXfC/85DsjNbyiqUZe19xPSUw2TWF9AhujhCvcyxEalHk4vHFo1/hYzJLsG
         cF1eC0x37H2s8vXwc1rSGIw8SKwcFDhtZvSKae+bxYOXrC9ThUHILRYybZr6P8/7pbI6
         bNyvY9MNQ40uZWep4XyXsPvDAudnn76dI+OGC+ZGfsKqorwDL10915yZ+lDEixT+jigA
         beth8S55lV5rCPuEbc8w1B6xfipuEe8wg+bHgzGLABLkIX4gxhb+aF5j/DBZZCGfL+SB
         re2g==
X-Gm-Message-State: APjAAAUgcrLaw2qvu/yN9Mt/MNW9qIK6XBbMD5AriFxjbJA/GZSvoUhC
        sSsnyxdhfYvdS+u9Ond+f9Ka1Hu6
X-Google-Smtp-Source: APXvYqznU5T5zfYxa0Lc+x3QI9Z1vR3+Hcepiahzn4Y3H8sbZtROzbGxdet8F4MaYAcgRD9zOmVshg==
X-Received: by 2002:a62:1854:: with SMTP id 81mr1591171pfy.223.1551789057634;
        Tue, 05 Mar 2019 04:30:57 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 33sm21165026pgs.81.2019.03.05.04.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:30:56 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:30:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/20] diff-parseopt: convert --histogram
Date:   Tue,  5 Mar 2019 19:30:09 +0700
Message-Id: <20190305123026.7266-4-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 7899c7cc06..7432702fd8 100644
--- a/diff.c
+++ b/diff.c
@@ -5151,6 +5151,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("generate diff using the \"patience diff\" algorithm"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       diff_opt_patience),
+		OPT_BITOP(0, "histogram", &options->xdl_opts,
+			  N_("generate diff using the \"histogram diff\" algorithm"),
+			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5189,9 +5192,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--histogram"))
-		options->xdl_opts = DIFF_WITH_ALG(options, HISTOGRAM_DIFF);
-	else if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
+	if ((argcount = parse_long_opt("diff-algorithm", av, &optarg))) {
 		long value = parse_algorithm_value(optarg);
 		if (value < 0)
 			return error("option diff-algorithm accepts \"myers\", "
-- 
2.21.0.rc1.337.gdf7f8d0522

