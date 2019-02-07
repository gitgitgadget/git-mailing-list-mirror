Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82A6E1F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfBGKfa (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:35:30 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34331 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGKfa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:35:30 -0500
Received: by mail-pf1-f196.google.com with SMTP id j18so173538pfe.1
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVU5At1fx3n88eB0Uv7C68+/cF+FPdVIMVZ+6TdFeus=;
        b=tmxWOPPktNq1usT7sfdmCqijyojorvTDB6BnHW6PFUoroJgDud1S6GjXUjsru1LbjK
         kgG7GSc3V0BF1tN387yU88oyPj+SpeCmOlVSWS2EXXgjWZLnatRDETEEHAOsM4KRjNRf
         Xqesieegbpua2NDejHmICJGyJ6mDSEkE4tcM4gm6pLgR6CNY2SZ17bHBUjOxg+RlGpm/
         xnAmOJ414lmmAEvBtinQfzLR4TM1VBMioEJl7bNDF9bceioneAIRIU0kgJQPM1k7+y6v
         dgzXaOa+yFUggFPsK+a5SjUjDzNJ9BvRxTzEMjQ3cq9FFNBGBQAba1N6Xp6V6ErLE57j
         vxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVU5At1fx3n88eB0Uv7C68+/cF+FPdVIMVZ+6TdFeus=;
        b=qBf2X5keNTDVsJ0eHTqehDsQ01vNLIPBrrWVKIwT67Onnaip/9QSPpBAqLqwJ9cuTM
         a+dNWXHmK8Q+js2xn1ZKAqvbY1/ZLf3KtO04wpVNj0MFZZbqwqAVww0A47CcFX9luFpw
         cCRyl9stnhQXbTuSYazz7Dt10Gcm5gl+VbhCM69Y3lrmRoYOPTspjmC3gD1H55NQmGCp
         Bz/Il1hT80Pjmut2S55pCLOJk/po6fZ6JhdSNf8r2v6udYHiAu9LwIYppb+qlW7L/Lhe
         CpZt2EIz7VPJW9pHcg6Am1SAfEm/oe6QvApbZ72ZP8khncy/Erek2afgdqaAPFJ9V/2C
         zsJw==
X-Gm-Message-State: AHQUAuY0S3D0hC4TINEG7NKbvjjJHYGW6xNsRZO1OG0NlcVTEWfSnwfI
        Zp8czjEKf2W+RfYaHJjG+cxFqhYb
X-Google-Smtp-Source: AHgI3Ia5cm02AmDltNdrXmSjzm4w9wqus9HDOspZw29IY6eFbMitJRqA168+y1D7/lIW/Il2VmOSaQ==
X-Received: by 2002:a63:521d:: with SMTP id g29mr14255340pgb.236.1549535729211;
        Thu, 07 Feb 2019 02:35:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l81sm4020494pfg.100.2019.02.07.02.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:35:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:35:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 21/21] diff.c: convert --ignore-some-changes
Date:   Thu,  7 Feb 2019 17:33:26 +0700
Message-Id: <20190207103326.10693-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 33492e754f..a63ee4a44d 100644
--- a/diff.c
+++ b/diff.c
@@ -5109,6 +5109,21 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT(0, "minimal", &options->xdl_opts,
 			N_("produce the smallest possible diff"),
 			XDF_NEED_MINIMAL),
+		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
+			  N_("ignore whitespace when comparing lines"),
+			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
+		OPT_BIT_F('b', "ignore-space-change", &options->xdl_opts,
+			  N_("ignore changes in amount of whitespace"),
+			  XDF_IGNORE_WHITESPACE_CHANGE, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-space-at-eol", &options->xdl_opts,
+			  N_("ignore changes in whitespace at EOL"),
+			  XDF_IGNORE_WHITESPACE_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-cr-at-eol", &options->xdl_opts,
+			  N_("ignore carrier-return at the end of line"),
+			  XDF_IGNORE_CR_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
+			  N_("ignore changes whose lines are all blank"),
+			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5147,17 +5162,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
-	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
-	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
-	else if (!strcmp(arg, "--ignore-cr-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
-	else if (!strcmp(arg, "--ignore-blank-lines"))
-		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic"))
+	if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-- 
2.20.1.682.gd5861c6d90

