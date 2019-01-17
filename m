Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8107E1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfAQNJV (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:21 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46865 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so4796681pfe.13
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AkHPv/ZuEac0F02Ne7ZDaUQlvHD6+1y/LvCZ6lgUMd4=;
        b=rLV/PhzV+kExP59U16I/ivk/wDOxrSm01FmFNe8zi73zRsQzmiYqa7YJbJJj8cQmwr
         fOFLUi7WUSMMUKrH1cmIlatiYeVNsofVVbOgWTziB/u8a8EsQQUVKNw0Rm8lgnA/GcLw
         PXjWH3MTHayfhAD3Bu2QCzlKxvYtUJdV5AhkN/TVyFctuXuV8pR/V5QujlgTo8iGv75J
         L1TGMJc2EEWNzWqpMvDxNfzF4IzSkZNvIwx7ppmTvWZkBYfJ4AfhRhgJ61HK00TABGYu
         9lEwcBOQkEwP9iQwA2aPpTO++vKj2dr93X8BP/at3UujByHKuBtMcGWhK+hY0021LW7S
         DNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AkHPv/ZuEac0F02Ne7ZDaUQlvHD6+1y/LvCZ6lgUMd4=;
        b=c5Z4/KmsbUPcNQmVRVJ+VyGNCMS7gEY3RY4TmN38/vSEC3NKWvtXta55wTpkDIpd0t
         ARa6mAGsUfhsIgEnohBMOFcEeYU/jz743N+TsT4tzLqLwYiIh9CGVBh0fOhuqVuPvoOn
         ul5ZreZczIKNnFCaLJwY34T8JT0BskiqJdyDrWIt+sH12HFKpbmhQapXusO9to7k5Z7i
         +Hhfso/zmmWog95QLKyJNWz0TS3/9MPzk4B243XbgWH2oTbLOYWkxIr202G2vgk+ynIS
         BI9T56WWpX5Ml09ipnrg8RKoElsbHFSRmw89iR7g0rWyC6YxhTtr/Uj+yHbAOh2WkYM3
         IMMg==
X-Gm-Message-State: AJcUukfzDlF+cOH6JQcwVWsXbiU2wsQ31RD2m4ZaaN3a5TlgFLXn0gyr
        Hm7KzMd1Q/er+7CtDHjZx49ErG+g
X-Google-Smtp-Source: ALg8bN4jAJ/10AYs6G8hNjmZgZL7aoWp4i/FNGGE4Dd56l8/5wQ1cl4TC2fMmnR/P+mmiXFHW7w45Q==
X-Received: by 2002:a62:345:: with SMTP id 66mr14775207pfd.189.1547730560678;
        Thu, 17 Jan 2019 05:09:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b202sm4609562pfb.88.2019.01.17.05.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:20 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 34/76] diff.c: convert --relative
Date:   Thu, 17 Jan 2019 20:05:33 +0700
Message-Id: <20190117130615.18732-35-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index fa666ced61..66a9f2ef48 100644
--- a/diff.c
+++ b/diff.c
@@ -4964,6 +4964,18 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
+static int diff_opt_relative(const struct option *opt,
+			     const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->flags.relative_name = 1;
+	if (arg)
+		options->prefix = arg;
+	return 0;
+}
+
 static int diff_opt_unified(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -5098,6 +5110,10 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("use empty blobs as rename source")),
 
 		OPT_GROUP(N_("Diff other options")),
+		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
+			       N_("when run from subdir, exclude changes outside and show relative paths"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
+			       diff_opt_relative),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5129,15 +5145,8 @@ int diff_opt_parse(struct diff_options *options,
 	if (ac)
 		return ac;
 
-	/* renames options */
-	if (skip_to_optional_arg_default(arg, "--relative", &arg, NULL)) {
-		options->flags.relative_name = 1;
-		if (arg)
-			options->prefix = arg;
-	}
-
 	/* xdiff options */
-	else if (!strcmp(arg, "--minimal"))
+	if (!strcmp(arg, "--minimal"))
 		DIFF_XDL_SET(options, NEED_MINIMAL);
 	else if (!strcmp(arg, "--no-minimal"))
 		DIFF_XDL_CLR(options, NEED_MINIMAL);
-- 
2.20.0.482.g66447595a7

