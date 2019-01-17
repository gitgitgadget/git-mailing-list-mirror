Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BD301F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728274AbfAQNM3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:29 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42222 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfAQNM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so4729845plp.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CM4omMFxNYrSxgSYKSWhscv9Qjz3Uvtm1RiQpJD9p+I=;
        b=vPw4Zh2f+p0XnZ6ZffLx4dsdGEXYQ/82z8dHVXDkUmbTTjom427zNMfZN64pAYTaeM
         JGzaQSn+2Fp+Jf6TlZ6qyv5P/RSLklhFcUkTU1Mfp9L0JfwGg7ZksRO7QjvPPch6iG5y
         ShoRSVY07XkVQJYaoLhr8SzKqkzBVkbsia1y5bc7ZrxY1w22MuBQHhn7T/9wQBZk5gbk
         7nmsg5NVfY94F+IWALq1viIkkm1ieDvCziKcn4wTS4F/5PbloKMu3qJvqqFh1LGMj+g+
         uLJlsy9DdG8Ulzj1uc7PcYe+l9aTdBCmg9nAr2QeHuF//AVqqoQPQH4Mp9JCV1u03YwE
         naKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CM4omMFxNYrSxgSYKSWhscv9Qjz3Uvtm1RiQpJD9p+I=;
        b=OFvEpg2d1ifzjoLkPe5+soHbw5CtxSz1oYpXX5sqT/kGPVJVjLS9oEhKsXD2Yl8Qlj
         J2XeLmoGTegckG48Jpe4Vde6ethizyP3yuYQTMxJrz5PFzdwZ7mnpa29adkd59yxt8np
         1Oiz4xYEQDvwVi/T7JhKi7idkBLIj1Esqu86Q15++HKL/8XDyXISfiJ/FaI2uvpVigBf
         c8+jKUJ5DLBsmuPHg+c9fByeKpkk8r+kgxW+HsHkYw54R0LeHzpmLiayr6wfz1fETR4W
         fBSHgeAfbUPHlg8OhsWJwGtpm8GxFdHh0BmGHi5adO2M1v1Od33E1443XyWnx8BHJRM8
         PXFw==
X-Gm-Message-State: AJcUukdomtyzxPiB6MLaew/l298OuOoQR7t+m9isYJaILn/BUm3CAM3j
        zepXBDRubihwM8xUstn+TATYExhE
X-Google-Smtp-Source: ALg8bN7FcWwSS7+ql1x7DzwweP2dHfSxcaaRYp8qu0uaS+MI7ZA1XlhHnxUy0LdopLuf2oXzfAByBg==
X-Received: by 2002:a17:902:82c2:: with SMTP id u2mr14944559plz.110.1547730748080;
        Thu, 17 Jan 2019 05:12:28 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d13sm3140101pfd.58.2019.01.17.05.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:23 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 72/76] diff.c: convert --color-moved-ws
Date:   Thu, 17 Jan 2019 20:06:11 +0700
Message-Id: <20190117130615.18732-73-pclouds@gmail.com>
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
 diff.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index 5403351466..e79a72cde9 100644
--- a/diff.c
+++ b/diff.c
@@ -4926,6 +4926,20 @@ static int diff_opt_color_moved(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_moved_ws(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	unsigned cm;
+
+	BUG_ON_OPT_NEG(unset);
+	cm = parse_color_moved_ws(arg);
+	if (cm & COLOR_MOVED_WS_ERROR)
+		return error(_("invalid mode '%s' in --color-moved-ws"), arg);
+	options->color_moved_ws_handling = cm;
+	return 0;
+}
+
 static int diff_opt_color_words(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5427,6 +5441,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
 			       N_("move lines of code are colored differently"),
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
+		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
+			       N_("how white spaces are ignored in --color-moved"),
+			       PARSE_OPT_NONEG, diff_opt_color_moved_ws),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5494,8 +5511,6 @@ static void prep_parse_options(struct diff_options *options)
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
-	const char *arg = av[0];
-
 	if (!prefix)
 		prefix = "";
 
@@ -5506,21 +5521,7 @@ int diff_opt_parse(struct diff_options *options,
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (ac)
-		return ac;
-
-	/* flags options */
-	if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
-		unsigned cm = parse_color_moved_ws(arg);
-		if (cm & COLOR_MOVED_WS_ERROR)
-			return -1;
-		options->color_moved_ws_handling = cm;
-	}
-
-	/* misc options */
-	else
-		return 0;
-	return 1;
+	return ac;
 }
 
 int parse_rename_score(const char **cp_p)
-- 
2.20.0.482.g66447595a7

