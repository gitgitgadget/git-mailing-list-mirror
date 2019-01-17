Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B548A1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAQNJq (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:46 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43658 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:46 -0500
Received: by mail-pf1-f196.google.com with SMTP id w73so4804334pfk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uhVHMZ88DQDUqnbqSn+OOmQa1W+jed+nEMwbgMsI4Kw=;
        b=cFIo6UkzXwUBm5RxrSuA5d0vxoRYScXeSDoMPStaLCFiNGFEHJ5F3TJP28YCdMV5bF
         z1gRStttww3F/5NWhjloxOSZhLRZe9EyM1F8dpjOToRbevAClqKbViLHPIfuVXMMFlbB
         v0FoOTS9FQwp7hLsNDS21h8XrF2T4MeW0nloaHcn6VzbCA2ZjffHi2wTf0u1Dnlf+imC
         N7M6MPJrXimsrqlqG3wraAFudzTF87vUWX9GLF6424IC57WEk/6VpxHpnGh2xdGitMty
         24MsSzAd0CUWmZmtp0FD8cmYvJ0B7pwgKrXnLAQcthr7n0+sanpqCz7Ck7Pnnco43u5c
         EGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uhVHMZ88DQDUqnbqSn+OOmQa1W+jed+nEMwbgMsI4Kw=;
        b=BwrWajxyLZ7KiElo9vOmIUTmH2lZn7OsFldjYFkhdsurWU3GVKe1CZQGahfhuWANnJ
         c0+MmlrYrW1/LR2c0jvZw56v1xMme43cv1U5Io1CXRE+V4RnMdr0HnY3MHmfHXnnkfxo
         NVpNhCUFcQZ72Pxr3Tngabr1knuEUBnTuC9bstgnftGxBtjkO0EosqTHniW2WHb6XGY5
         Pgg0Ieuxx+/AAHUdPy6V5ifu3Cm/xvbTWEDmKx2Ciu7yW4iXCL2x24LQA7QdZGkSiJJz
         hoj8fxk7t1kb+K5bZJvKbvgHtyPP6IMiyR/XSZWRKS4ROvJVHRIicpLiaNYP87pejsfW
         o4ew==
X-Gm-Message-State: AJcUukcUFNaDhkV1nWkLmGgxSAxVfox81FdRRMs5+iCX3d938aohmhLz
        AKbiqbd0l9NkcXxbFPl95IBjwxxQ
X-Google-Smtp-Source: ALg8bN5APhMTDNMcFwrexl1OHdPFNxaHftu2W9CcQPbbUcjFTn7VLhbzu9FZVH8h7VLjQLF21/l2YQ==
X-Received: by 2002:a63:61c1:: with SMTP id v184mr12642038pgb.54.1547730585399;
        Thu, 17 Jan 2019 05:09:45 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id o8sm4128655pfa.42.2019.01.17.05.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:44 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 39/76] diff.c: convert --histogram
Date:   Thu, 17 Jan 2019 20:05:38 +0700
Message-Id: <20190117130615.18732-40-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 67a88dcbd1..ca3f448a8d 100644
--- a/diff.c
+++ b/diff.c
@@ -5155,6 +5155,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("generate diff using the \"patience diff\" algorithm"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       diff_opt_patience),
+		OPT_BITOP(0, "histogram", &options->xdl_opts,
+			  N_("generate diff using the \"histogram diff\" algorithm"),
+			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5193,9 +5196,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

