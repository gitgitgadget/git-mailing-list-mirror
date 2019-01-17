Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB041F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbfAQNMT (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:12:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44084 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbfAQNMT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:12:19 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4806868pfh.11
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IJ7oqCTtIxTG4SioUu0slbogbr4HUrkRgF0l0CylQkc=;
        b=ogqhMVNS23rooyO1wvBDreNlwh6NPf7ceBrueWIGgAIuLOii4rpNFfT13GIr8BNgJD
         VQu1wZ6UmGipZErsWu8yOMxBrUyQWqiIqMm/CrWpPjnMGweP0iOYIgjHIJOUnCzQoyCG
         bjW9w8HG/xtgigP759Ji/sfjP23VdCaQO3grYaLunyBALCfT5cLgnkjir8fCvibMsSg6
         EyCMxMy1Sp0a6kLkTzVCEaSSGPsjYUj/Sq+1DyQNCUkxj5R/v6LVqjAZ/RGYVVnrGxZw
         /wQSrEH68lBfXBvMDcLkkpjY2RG8DTtguDqWlW5v5usEx2YGxvnOgyY9vQYiHDdUzVVg
         p0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IJ7oqCTtIxTG4SioUu0slbogbr4HUrkRgF0l0CylQkc=;
        b=DvLwwByvNIv/Mtd135St1ak5phHd6w+8dtb+V2K1GoX3IItfsAJFQmDQRy5AR/yde+
         9lb46ZfeBxiP8aMOAAdz+bJDgj4HpSeEDUcJV9ycFapRqz8Rsom0DFM4WOOztPvhdPEE
         g8Gb6RddQFP0I4yGlIXNldBC+dZov6PsDSjF8DV5XZGqFjrFLHHHnLxmg3ZHNw9bXeJt
         EAQQmgKV8JhmjioDxQcCvTs6wVG2lFjAS6PkDlIHrqu8eCtjOAtmwrpd3wbvc+8avGF+
         UZ6UwMsT22lOuQPl7csSmmUa0pg62CWaoKK/cgmB8PWnWwECJ2XSHcKnHZLqHLCTWEZn
         bYnQ==
X-Gm-Message-State: AJcUukfUWscT8Jb8RVUpJXZhr/YwEl51nf7vbZQ92vSIsrVd2aFbmYj7
        ErlNrpCyvAiF61pQCEb8VJnjKFur
X-Google-Smtp-Source: ALg8bN7smAiSV/2tr2PYeGJbg+89uDdZe+SvFymdaOkmjpGTGL0EOlk4rkRi13V9EetOxb+b9fckxw==
X-Received: by 2002:a63:111c:: with SMTP id g28mr13228176pgl.85.1547730738372;
        Thu, 17 Jan 2019 05:12:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id x28sm7620598pge.66.2019.01.17.05.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:12:17 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:12:13 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 70/76] diff.c: convert --inter-hunk-context
Date:   Thu, 17 Jan 2019 20:06:09 +0700
Message-Id: <20190117130615.18732-71-pclouds@gmail.com>
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
 diff.c          | 6 +++---
 parse-options.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 3e7c36524d..cc10b27df0 100644
--- a/diff.c
+++ b/diff.c
@@ -5311,6 +5311,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
 			       N_("no not show any source or destination prefix"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
+		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
+			      N_("show context between diff hunks up to the specified number of lines"),
+			      PARSE_OPT_NONEG),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5503,9 +5506,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if (opt_arg(arg, '\0', "inter-hunk-context",
-			 &options->interhunkcontext))
-		;
 	else
 		return 0;
 	return 1;
diff --git a/parse-options.h b/parse-options.h
index c95cbe26f0..cca64d04cb 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -137,6 +137,7 @@ struct option {
 #define OPT_CALLBACK_F(s, l, v, a, h, f, cb)			\
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), (f), (cb) }
 #define OPT_STRING_F(s, l, v, a, h, f)   { OPTION_STRING,  (s), (l), (v), (a), (h), (f) }
+#define OPT_INTEGER_F(s, l, v, h, f)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h), (f) }
 
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
@@ -155,7 +156,7 @@ struct option {
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
 #define OPT_CMDMODE(s, l, v, h, i)  { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
-#define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
+#define OPT_INTEGER(s, l, v, h)     OPT_INTEGER_F(s, l, v, h, 0)
 #define OPT_MAGNITUDE(s, l, v, h)   { OPTION_MAGNITUDE, (s), (l), (v), \
 				      N_("n"), (h), PARSE_OPT_NONEG }
 #define OPT_STRING(s, l, v, a, h)   OPT_STRING_F(s, l, v, a, h, 0)
-- 
2.20.0.482.g66447595a7

