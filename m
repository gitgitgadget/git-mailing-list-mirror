Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 552971F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbfAQNMK (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37636 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNMJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:09 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so4747648plr.4
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jFjHi7SdKwQroMXiWMK5F+UH8uSba7+v86LC5Ju1Xtw=;
        b=ti69CF5LDxpoLb3beJZT5A4ESLWafpaJTWUdbcL8vhX7pUGdlnXTpnHsUHJdIPKfKi
         T6BvfjLeUJ/HHqrM3qaILC9cmed9SUQtmLRYAdjRicxCoiPl+60w4bTxaTrg/3S/H7CF
         mc0P/9g20BiWIEGiQepK4vm3Ew5HL8kScNwduif4ZVxVWNeBYP5SWgKa53SOb6QcaIMW
         Rxa94XVfKc7wUJraPQRjKt+6zVbNj1qYF7eiPPn/IwBjX6uFhXPOwg8t6lFLRaFU1qOh
         AlMMvGZ2Vs2vTGZRR2RnlCbm7Eidww/VWYZGDN/A8CpRbGXFzAkSZv+LMDGctarB3iCe
         ab+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jFjHi7SdKwQroMXiWMK5F+UH8uSba7+v86LC5Ju1Xtw=;
        b=iRRbex4YrL/bT/VBuA+HTUlxCI5qYWmKVMglMza5KkTVIY4Jhh7NzHf5anWSRP5U21
         2mLvyqn0DuHn1qMVfFbuun/eRYNbZnxuBIcDxa0Tkqsuj6lSaSgmm7FbEmKWDCRWcbw7
         irSCwVUilcJWJX/eeK3HITTe+xU4/OOTifelnHW+xslHALkl7yIlC01GxAoBW8tUQWol
         1Uk0SJDUWpvLFcK0Wk8XH962ZCLfRly2WyNXrQaco4z3p1ykeZ4CaADl/O/r1cnYk03m
         SMjJu8VaLO6Kf5YEgr4t74jz7Sc6im4/9qK23oUQpas2lO7gogLZjhlNT8hEBqKdyFR2
         f3vg==
X-Gm-Message-State: AJcUukdwTPEvMfszZR2/8TzrOQmNNdFlPnk8906kLto87Qa/DGt+EcYj
        aiPruy/MYhLCWnXYcQQXs4XtlN/o
X-Google-Smtp-Source: ALg8bN7NfHAu/VG585EzskXFpI8YP4TqeJYevDKySyXJUWFVsTbvFe6vh2WrDQaE7t3tT13o0x55lA==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11mr14864464plq.84.1547730728535;
        Thu, 17 Jan 2019 05:12:08 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l74sm3616511pfb.145.2019.01.17.05.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:07 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:04 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 68/76] diff.c: convert --line-prefix
Date:   Thu, 17 Jan 2019 20:06:07 +0700
Message-Id: <20190117130615.18732-69-pclouds@gmail.com>
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
 diff.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 0d66497851..25c386b04c 100644
--- a/diff.c
+++ b/diff.c
@@ -5030,6 +5030,18 @@ static int diff_opt_ignore_submodules(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_line_prefix(const struct option *opt,
+				const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->line_prefix = optarg;
+	options->line_prefix_length = strlen(options->line_prefix);
+	graph_setup_line_prefix(options);
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5281,6 +5293,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_STRING_F(0, "dst-prefix", &options->b_prefix, N_("<prefix>"),
 			     N_("show the given source prefix instead of \"b/\""),
 			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
+			       N_("prepend an additional prefix to every line of output"),
+			       PARSE_OPT_NONEG, diff_opt_line_prefix),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5438,8 +5453,6 @@ int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
 	const char *arg = av[0];
-	const char *optarg;
-	int argcount;
 
 	if (!prefix)
 		prefix = "";
@@ -5475,12 +5488,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
-		options->line_prefix = optarg;
-		options->line_prefix_length = strlen(options->line_prefix);
-		graph_setup_line_prefix(options);
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
-- 
2.20.0.482.g66447595a7

