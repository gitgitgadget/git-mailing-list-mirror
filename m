Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 44AE01F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbfBPLeP (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40982 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfBPLeO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so724328plk.8
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1L6nnZ0CQOEd8nqEx0K4c9mVLDHGNdTtVO2eemjkX9A=;
        b=uFdX/XR0eHYLTg+2tnebvRBvB237CtxDqJtzodBGb/sp9x8red04uTNN56bkcQLyXx
         tFbmx7ZxBuCfcfxvXfVbpCqhlkioN1ixHXe/3bODyk0nacXKYclaTQPpZjnxziQIJfqY
         evu8L1p+CIioKExWBvlbFZU6f33DEwh8UnR3mZTZL6e3B/0ZOXw37qZ4mW7q2Tfc33TE
         ttFC+erqYH6cENH3/1bcdkashT2rzU34rH4TmZTnhE3hgDKbAegx6yXSNhINb+FH7ep5
         LEiQAfEk6a5cj5D1Sz+0IFitS/mVc+l0nRxvLNnjeey/NU/W/BVFgOMkBNrSB/POZ2Fa
         oDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1L6nnZ0CQOEd8nqEx0K4c9mVLDHGNdTtVO2eemjkX9A=;
        b=g8FgBBZoknk3sRQOr7AXGE9FcJA6GexiDQ9er/ZeqmikC03fmgmx89f/uxC0MHawmi
         ale3Nr6nxPlfPUuL7CCwzUQbwR7XL10pvxhEptXrLRTDHtq4rd4x0LWRurYYFSjwUk2y
         mErimcqxtMyXop2x1VvvYC3mjDXor2DDTD3wyZ9Y7qRlt12fw/pfUkGZFwKIrWJ9laM2
         0NVrrlkvYCGy91hoPVPAt6GWuyH6Y3NLHPG9rYyt5SbIodZMb7nRSnDFDbTjADOs/Jb2
         uhPQz6B7exM517sZYTuEV9dCNDQ3oFG+fFQCppgejNo282qlTHiaRw5WYfcqFB1ipIAD
         lXug==
X-Gm-Message-State: AHQUAubU6rbR08ZGxz64Qh2GFgJXhNmjnXrJ39pzT/Dsu1RfJD9OZDsl
        4xQJICOPCaX3vrSR5aEclzQ=
X-Google-Smtp-Source: AHgI3IZs5zPkqZjaypHVxH1xR1MV4Tvd/nKZIR0dPuMRY+aGlN3+kC7IB5O11jdhON3gbnAd0y1bSw==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr15262283plb.101.1550316854127;
        Sat, 16 Feb 2019 03:34:14 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id q28sm23233865pgl.35.2019.02.16.03.34.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:13 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 01/21] diff-parseopt: convert --patch-with-raw
Date:   Sat, 16 Feb 2019 18:33:26 +0700
Message-Id: <20190216113346.25000-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113346.25000-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113346.25000-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 4bc9df7362..12e333c67f 100644
--- a/diff.c
+++ b/diff.c
@@ -4901,6 +4901,10 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "raw", &options->output_format,
 			  N_("generate the diff in raw format"),
 			  DIFF_FORMAT_RAW, PARSE_OPT_NONEG),
+		OPT_BITOP(0, "patch-with-raw", &options->output_format,
+			  N_("synonym for '-p --raw'"),
+			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
+			  DIFF_FORMAT_NO_OUTPUT),
 		OPT_END()
 	};
 
@@ -4929,10 +4933,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--patch-with-raw")) {
-		enable_patch_output(&options->output_format);
-		options->output_format |= DIFF_FORMAT_RAW;
-	} else if (!strcmp(arg, "--numstat"))
+	if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
 	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-- 
2.21.0.rc0.328.g0e39304f8d

