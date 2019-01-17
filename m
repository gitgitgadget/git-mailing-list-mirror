Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C541F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbfAQNJx (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43745 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id gn14so4723665plb.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qZdiCJQB4nJRYya4dU2CpGZB49Tr+8MiIPHDeFJ9B7Y=;
        b=behc6kF3YILC6+Vk09ELlYdpKr94wVSDMp0mt2pTNdEky/v8end98qmMMmP8jnQwnG
         YeJ7JOn/DFIvHLnua3JKWn9bWAXpUmE0pXvRrlL8P9QczXt5hJvPy2KmDG5w60O9OGY3
         TdlmF/+BrEBWuNFOQ+/ZJy3I1OH7q8ndzkAB1SGYMQ26fk1VA8nknV5VOzwxu9MYsg8C
         fmfcEA2mVJo2nFzzW0qbhMmht2wcJPoJ1RTzdfasnrFuSWButFBMRc80eghFruM/SPCO
         TibwLZk3Qv9umTx5DQSq6ld8xlNmLHU0CvEBP2oM2swIjRnLcaycQ3wiJ9OLXL4guubQ
         HArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qZdiCJQB4nJRYya4dU2CpGZB49Tr+8MiIPHDeFJ9B7Y=;
        b=O5Bi1k2hRj6QC8z93XrOG58vhtaojdTFxVLVcH2Xk6daqrU3hVPZkv3dTpK6DiYSrf
         jeJpMXrvC2CgihWt8wq33LFEbrH3NKGLX453zBs+jA4PL3EyH6lcgwXszDgN8pLGjqUW
         zC5Vi+2eCXUVgs28Lu5AXqKpBbH797MlOx1rQYRtpNvAoVoiNAZF3BIyyXMa6aLZxtjs
         1a7lLBZ/zOhesHXfYlYgbMTq/FH7PByn/h7otLEpC4hwFiFHIarwNpwMdFsxoUt600VF
         06xBRsK4BZmMq8E1M7B5V72yOyuRlHB0KRtnOIDJRgTaiamwO1wTZ8brj5tDrEVEGjZU
         OB6A==
X-Gm-Message-State: AJcUukdPyAcXL40Se9vLFGWrdHr+t0sdgFtQevytQI1yv9e9xhcBtFdE
        s6960e+0rQRPZ3jTIXYTACdr/utt
X-Google-Smtp-Source: ALg8bN7dzW9UnwYs9OaOjwyGBxO2/yhF+cHCCmGrL+PIezRqNUBDGY42idfnUCvKMDYtj003koHAAQ==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr15007340pld.8.1547730590981;
        Thu, 17 Jan 2019 05:09:50 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l22sm2556935pfj.179.2019.01.17.05.09.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:50 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:45 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 40/76] diff.c: convert --diff-algorithm
Date:   Thu, 17 Jan 2019 20:05:39 +0700
Message-Id: <20190117130615.18732-41-pclouds@gmail.com>
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
 diff.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index ca3f448a8d..2b93f08958 100644
--- a/diff.c
+++ b/diff.c
@@ -4895,6 +4895,24 @@ static int diff_opt_compact_summary(const struct option *opt,
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
@@ -5158,6 +5176,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP(0, "histogram", &options->xdl_opts,
 			  N_("generate diff using the \"histogram diff\" algorithm"),
 			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
+		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
+			       N_("choose a diff algorithm"),
+			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5196,17 +5217,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

