Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2871F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfAQNJg (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:36 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39155 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:35 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so4434848pgl.6
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3a6iqbunrQiK2hK46BHnJn7Z+dhtlI125XeTlXTbraI=;
        b=lAOSVbjaPkF21Q5irKjTZjpUTVqUESzs/4ml/AtvxyteyAXVW2d801eoZmbJrh0gMC
         GO1beMtMp40ry7iubJg4sRdZ5/ni7IiPS7FbwBw15c6S2R7DP2K6A+eXLVCWer1XugRn
         glDz1R7jM9UC6CGBmxP6VN8qjMbL/FwHUmlVoOHaPjYb4UfBTbs1dqq1cuiprjHIKfGg
         FueFtOiUfY8WZiaFHlplfRG0AKzlh5Ow1fVUG06pRGHkCnt4RrQYDeC5f8AvqGNnM+GB
         dEMqKZQtdwYst8D52XTwVwoWhDYLUq7lFKOgnIIVFI6aj3Z0Tc7jOciKecf7h9DpbNCn
         XWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3a6iqbunrQiK2hK46BHnJn7Z+dhtlI125XeTlXTbraI=;
        b=RwjRxnf2aiDMKgCrsxkod84uspqOfl6OAIuPCh3Ke/UEDsThZDbmvIgiaohciDqa3M
         RAv53gHtYD65bx35qhBi5w2/aA1WkNCq+1JLiTr5DSaOssSY/R8KPybLAG3YCVVHzTEo
         BLksYZgm/emgO+CTSgwLT+87hz61e4N597AA76rYkY60Ds3xeWwCinA6R4F8O8uxJhRO
         WwKWtrkP+Eeralpipx2gfoBJqbSzTxqVLfID5B3cbmBlnBamcrk7XYQJPNZR5LagrG+5
         G3zzw/QpYtTAuWP0D3pltpMtsBv+oghwUxoEBGZDYuR2hQL72BqFFkYAPguOYBKNid7m
         o5zA==
X-Gm-Message-State: AJcUukesj6f4m/vw7E8oUCKpeiiAw4OZjxIzrMCArIs/vhbyFW6mkFLm
        LMpCD7RYpjjsGwx0oziacJ+u6r6/
X-Google-Smtp-Source: ALg8bN53B1MWNCEuMcW1zLR1NUFdpRfb8rCNW8FUtCCXIJaFtK2bF9zqdnlGiv4X7TvfgHa1Fq3JRQ==
X-Received: by 2002:a63:d547:: with SMTP id v7mr13199592pgi.339.1547730574974;
        Thu, 17 Jan 2019 05:09:34 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id r6sm5377251pgk.91.2019.01.17.05.09.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 37/76] diff.c: convert --[no-]indent-heuristic
Date:   Thu, 17 Jan 2019 20:05:36 +0700
Message-Id: <20190117130615.18732-38-pclouds@gmail.com>
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
 diff.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index d8b5c7b7d8..166ac8b6e5 100644
--- a/diff.c
+++ b/diff.c
@@ -5128,6 +5128,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
 			  N_("ignore changes whose lines are all blank"),
 			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
+		OPT_BIT(0, "indent-heuristic", &options->xdl_opts,
+			N_("heuristic to shift diff hunk boundaries for easy reading"),
+			XDF_INDENT_HEURISTIC),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5166,11 +5169,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "--indent-heuristic"))
-		DIFF_XDL_SET(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--no-indent-heuristic"))
-		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-	else if (!strcmp(arg, "--patience")) {
+	if (!strcmp(arg, "--patience")) {
 		int i;
 		options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 		/*
-- 
2.20.0.482.g66447595a7

