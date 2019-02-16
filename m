Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A9D1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfBPLhg (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:36 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45036 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:36 -0500
Received: by mail-pf1-f194.google.com with SMTP id u6so6123682pfh.11
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=504YtP9c1Vs48gl3br293hIlq3E4PGdQAmXfEyWhldU=;
        b=TZHiidAVOtL3NIDTcqHzSWmqrFo9TH2AM53N6VE57xSuYzXUYKmgV3P9CgyZ2RooZu
         x67gew0JZWDl2jBKbZOgoP2iHpF0JsGsQnD8wMkLaD+RVk3OFtrN0EMoUc0x/Jea04J9
         pAxInUTfIDxnWHDBJ6VqjMf3bOckcoLeBE0bCj2eBIcRLs7D8ghFR9ox6mEvJHJjp/DF
         x9Jwa0lmyvemBgXJBHOmqoDfaxUmstTrnviu8+WCKykX2j/E64SiloOKSr77PrZ43mEo
         z2d4D/2o76KjogGY8YFUa1rfLk1JRRZ/KUtStHPP7QJ5cNlNdSmphFhOdts/yS7F3sA+
         IEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=504YtP9c1Vs48gl3br293hIlq3E4PGdQAmXfEyWhldU=;
        b=j9RhOh0ovm4QwDbHiyglvz0WL7FjvIXMGSIlfYjVe0/l9QVfDeh2L9X889fOKGZUeA
         lgW0pi9vUZKXEhg+rGLF01wT/HgP7qmlVMwo/hLdGSvb42EWs7naeQRhE7vRESbFSlSC
         TcH1+SJD58bJYvFvl6kOiyUxDtppeVOTbtZZ+n9JBfO6A1RWho157HEs+GAXisgfu5cs
         t/5RHclbo3jgptQAY8ucq3a37OBDGVahDJnzoUUeJWLNX2Sj2Tm3QeomINA3yWJLKwPh
         vv8re0IR+Bz1JkmUiq5rDtoxyJM/bPvobDK3E1E6YkvDhl2QdjcHcuBk0PgyIulF259J
         qs5A==
X-Gm-Message-State: AHQUAuaFGY8aJTKru48lHDfZfMh2nfpIwn1PGmrlOrGvT4P6ZsNA7z/g
        End34+4Ey3ChBg4neGTPID0=
X-Google-Smtp-Source: AHgI3IaK4ryKrDyqvZ44JOw8Lbm9frToWOT/D8zXbBwrPbpADilFCISZoorpv/++wUaFbLh3m8wCjQ==
X-Received: by 2002:a63:d5f:: with SMTP id 31mr9742578pgn.274.1550317055198;
        Sat, 16 Feb 2019 03:37:35 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id s71sm18138235pfa.122.2019.02.16.03.37.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:34 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 05/21] diff-parseopt: convert --summary
Date:   Sat, 16 Feb 2019 18:36:39 +0700
Message-Id: <20190216113655.25728-6-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113655.25728-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113655.25728-1-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5e16082091..0276f25200 100644
--- a/diff.c
+++ b/diff.c
@@ -4942,6 +4942,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
 			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "summary", &options->output_format,
+			  N_("condensed summary such as creations, renames and mode changes"),
+			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4970,9 +4973,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--summary"))
-		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat")) {
+	if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--name-only"))
-- 
2.21.0.rc0.328.g0e39304f8d

