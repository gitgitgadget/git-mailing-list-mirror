Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C8171F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfAQNHt (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:07:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36634 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfAQNHt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:07:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so4437705pgm.3
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUEpIQF+VNHwF1UihhGmU4zvzgmfUC2LYExeAf4PW6A=;
        b=jSfowZnGwaikELC4BCyimwyyrUkKaf64h0De6URb/uz71OBK2lTYatDtKoamPmhGZY
         VR+XuFCQGdG9aU5lD0x2tryRe3nanrpSv2ljkywoDFSwBOCphDBJmDvHOgBGfxZDAkvp
         HFG1CGSIGBRLE5ha5GGtT6plpzTExbd0YRdyYx8k6s3x+SFSVHRTiAs336p6s0v4cI7t
         CGdNevix2+Q2ZN7GE0eWNe/zUP9kYV4pJEOJeSfVqarHY2qU8Rq9g7D1w7Dtrf+hMIXv
         C2Kg9gENGxzMiu0cyA1z7Ld1PTMaI4vicecYZe9SFVPd41Tqyrp4VcFQ1INYZvA9ACdF
         FchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUEpIQF+VNHwF1UihhGmU4zvzgmfUC2LYExeAf4PW6A=;
        b=NgmlYRmEbdSxN7qjVaDuWy2G6TPOud5lIhX1L0IiUvJEnU3OnzVOkSvwt/frynEWXJ
         dt69xm7LKe5mWbIvLX7OvcWt8R7JaC+VGPiFlzNFZUk0yeHdrSZYbp9fiaSdkKhzvVxi
         Xh8McTy1e5MZXoEsrBA1tzJL0sUMsXTfcVBhesPTA0930UV6pRdDEPpMIcqaaQ8jrWEt
         /ksDqnCZ7mOXz6rDvKa6HcfBJiFUKAdAnazM0v7NoTDB0j10wrJYHOPBYzI5AXY2hllg
         0Lt/eA1P1WCZmYHO4wMLylzhdCJcN0N3FI9NWeXDv8MNpeEejWxdNKrcfKvVpH4rhstl
         CL8Q==
X-Gm-Message-State: AJcUukfnS6OJ3WMLeMQ07o/VspEN1p02hEVSX4PxYfCRDhSkUuZ60nyE
        qwP9xmfh4WkRrSdnJoeWztDbKp1f
X-Google-Smtp-Source: ALg8bN5wCnEbvEScfDvom+jxhvUOaqMZxBrAfqDAVwcjgRfGnPf7os5RuDuZEJphLlJI8vNa8BFqGg==
X-Received: by 2002:a63:34c3:: with SMTP id b186mr13063870pga.184.1547730468501;
        Thu, 17 Jan 2019 05:07:48 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id p7sm3171479pfa.22.2019.01.17.05.07.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:07:47 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:07:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/76] diff.c: convert --raw
Date:   Thu, 17 Jan 2019 20:05:14 +0700
Message-Id: <20190117130615.18732-16-pclouds@gmail.com>
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
index db8cf7df87..2ebe9b23c5 100644
--- a/diff.c
+++ b/diff.c
@@ -4896,6 +4896,9 @@ static void prep_parse_options(struct diff_options *options)
 			       PARSE_OPT_NONEG, diff_opt_unified),
 		OPT_BOOL('W', "function-context", &options->flags.funccontext,
 			 N_("generate diffs with <n> lines context")),
+		OPT_BIT_F(0, "raw", &options->output_format,
+			  N_("generate the diff in raw format"),
+			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4924,9 +4927,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--raw"))
-		options->output_format |= DIFF_FORMAT_RAW;
-	else if (!strcmp(arg, "--patch-with-raw")) {
+	if (!strcmp(arg, "--patch-with-raw")) {
 		enable_patch_output(&options->output_format);
 		options->output_format |= DIFF_FORMAT_RAW;
 	} else if (!strcmp(arg, "--numstat"))
-- 
2.20.0.482.g66447595a7

