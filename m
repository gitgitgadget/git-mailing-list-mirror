Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19C8420248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbfCTLrr (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46832 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLrq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:46 -0400
Received: by mail-pf1-f193.google.com with SMTP id 9so1511970pfj.13
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IWx4TK7SvmgrPfkxrrsRevfFq0UxYrwUkSqzRNSYpM=;
        b=piU0pN6HeTXqDT9vF3FIYHP2gynJB4eJ/79K2hoYZHoDkJ32TzpQUHCkU8roBeyUJ/
         XESt9TQaVREfzRTdGQWAt5rSVdYCLyH4rSDN21YanVJ56iRQ96YxtW/Wdz1+1ZKyr06J
         MmNYVMlCLTE20Iqo3M/0frbcvzSY8NUNQbh6KHuD2zb5I3TMnDnf5klEZKJuwTvQQrGy
         buzKjPbMJW13BfDH3lApbky4VTXCfQoCklcANYS5rYhL4SnxTK/IWgjIMg/0/ZbRKGBk
         1RsHdAXicSayCCYhHQqh3lIQwgFCRXoLK4Gm4QlflskwnonSuDbgbLrJkAp0x65xx5hO
         rA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IWx4TK7SvmgrPfkxrrsRevfFq0UxYrwUkSqzRNSYpM=;
        b=hO+OcAEsRt3gNntxNqMhR5LiNlLmsUDQiY/0szvtC5+qtrYaDSGgS/zVm9u3yzm+qB
         /f5tjBNSQi89x9pl/Co8NnLRxFvM+U7nlIEfPL+mI0zVvgHg2cGsTdYocaGDLRqgl4/0
         aNNZOA1Kfw9hlXfbXmaU9x7FWmtfNbwsMhENqkJndUQTLfXzXa8p3H0SO/TA77c4Xc8Z
         0IBf7uvwpedB8j4zfPoJieTrBQjQd7EM8tt8te54nsOTom0lMI2Q2aIn71e30EfHY7l/
         OPnmWd9oQTHTlpsNOGdsoZIH7oC8BGizT75wed7JN7mD9lpTr6aGsZgw04N0NGwDcAFx
         HuQw==
X-Gm-Message-State: APjAAAVtipbyjt+p3HWXOzwNy5bxgMRa03CDW8AYKrcr6EbzY+KEHKGy
        fmxXAnI6CNjtBP2o0YdMQRc5ZXEk
X-Google-Smtp-Source: APXvYqxRVSgtTg2jR5ZYeamkjW0dSD5fxB9Z4LDqFj475LYi9wBtokzBmO4AO025ORxp+qnkAnmdLg==
X-Received: by 2002:a17:902:f01:: with SMTP id 1mr7401128ply.41.1553082466131;
        Wed, 20 Mar 2019 04:47:46 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id r82sm4524599pfa.161.2019.03.20.04.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:45 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:41 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/20] diff-parseopt: convert -O
Date:   Wed, 20 Mar 2019 18:46:50 +0700
Message-Id: <20190320114703.18659-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 639b166c79..21c7a6b1a1 100644
--- a/diff.c
+++ b/diff.c
@@ -4617,22 +4617,6 @@ static int opt_arg(const char *arg, int arg_short, const char *arg_long, int *va
 	return 1;
 }
 
-static inline int short_opt(char opt, const char **argv,
-			    const char **optarg)
-{
-	const char *arg = argv[0];
-	if (arg[0] != '-' || arg[1] != opt)
-		return 0;
-	if (arg[2] != '\0') {
-		*optarg = arg + 2;
-		return 1;
-	}
-	if (!argv[1])
-		die("Option '%c' requires a value", opt);
-	*optarg = argv[1];
-	return 2;
-}
-
 int parse_long_opt(const char *opt, const char **argv,
 		   const char **optarg)
 {
@@ -5397,6 +5381,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
 			  N_("treat <string> in -S as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
+		OPT_FILENAME('O', NULL, &options->orderfile,
+			     N_("override diff.orderFile configuration variable")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5449,10 +5435,7 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = short_opt('O', av, &optarg))) {
-		options->orderfile = prefix_filename(prefix, optarg);
-		return argcount;
-	} else if (skip_prefix(arg, "--find-object=", &arg))
+	else if (skip_prefix(arg, "--find-object=", &arg))
 		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
-- 
2.21.0.548.gd3c7d92dc2

