Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4693020248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfCTLr4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:47:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40412 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727673AbfCTLr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:47:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id c207so1758745pfc.7
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kK8ChyJmFBjAel14d7U+O4YZM/azRlI/kEK6OTFPwY=;
        b=JO4+yDEqFDnmCqUjmLQFtITseKqb9quE1LDPgHcps4JU9kMgPiK3P3DQ+U2Ch4A+mx
         zLgA7PJh4QSxG7A3jA6iWpyPuVB8vuDdSp6gsnrZcSyUn+zyaFJo7WbofCH8Pol0gFku
         0Nw7NC+gKJl4Emt6S8HvTDc76gdSkOXXs8aUfdDMMxVzRyLaOU3D2ebdcwJzTDZ22a2a
         rqtrWYjNN8CV+2Ii/L2C1UW+ypqZbf2pGZhqrup4/mFid6GMHZwFzBEwry9DIKKP1+KS
         ZolMxqV00mQDtC9EZfABEk6KywnNSU95Xm5+rO1S3yppL923nPUCENJj14dDRlw4yxOV
         /b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kK8ChyJmFBjAel14d7U+O4YZM/azRlI/kEK6OTFPwY=;
        b=UnIpgb7pW8RHzEavPpr44jzOL4n7loPtrXJHboy8PxMd/5jTZq10w2aVNy2+ed744Q
         nYXMVr7ZnctbsYvUW7oGqIiwMaW9/ctq5D8wDi4+tCWQmfdtIPJxU2zWSkD7zlSyzgKF
         vMEIBwMAGLJql6Y1jyCizFcFssZsD9m/naSqe2iEqyG+xK4tdE8Q4kwvdx7zTCnrOhjd
         3E/ThhOdBDqLCEBHjFd+UuXPEAKenOd1E0mwIYvDwUH2Pl+dS7yy883ub9KuJ3m4PVtd
         x1l3mkAhV5CMI9pPYiwkN1itTU5eh0FEX1mBZ3fvOjfGpYABJK6I6n1BP3/GG4Pu/UJ0
         5kYw==
X-Gm-Message-State: APjAAAUmJCjpHByglHLiHjpnxawanKhdLjB8vZHiRpQrkzDMG4OyJGwt
        CoF2CLEiPihnwUoe06QsE9wFAkqH
X-Google-Smtp-Source: APXvYqwSpviwDy+6pW0MRk+buAw5kO5MqcUC0ZXtQubkjEHTezyyV56tc0LyAO1LnudrTo5wDMopSQ==
X-Received: by 2002:a62:f24e:: with SMTP id y14mr7305779pfl.209.1553082475282;
        Wed, 20 Mar 2019 04:47:55 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id v5sm6544024pgr.4.2019.03.20.04.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:47:54 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:47:50 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/20] diff-parseopt: convert --diff-filter
Date:   Wed, 20 Mar 2019 18:46:52 +0700
Message-Id: <20190320114703.18659-10-pclouds@gmail.com>
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

while at it, mark one more string for translation

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index 694f32148c..6e84af1cce 100644
--- a/diff.c
+++ b/diff.c
@@ -4736,10 +4736,13 @@ static unsigned filter_bit_tst(char status, const struct diff_options *opt)
 	return opt->filter & filter_bit[(int) status];
 }
 
-static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
+static int diff_opt_diff_filter(const struct option *option,
+				const char *optarg, int unset)
 {
+	struct diff_options *opt = option->value;
 	int i, optch;
 
+	BUG_ON_OPT_NEG(unset);
 	prepare_filter_bits();
 
 	/*
@@ -4770,7 +4773,8 @@ static int parse_diff_filter_opt(const char *optarg, struct diff_options *opt)
 
 		bit = (0 <= optch && optch <= 'Z') ? filter_bit[optch] : 0;
 		if (!bit)
-			return optarg[i];
+			return error(_("unknown change class '%c' in --diff-filter=%s"),
+				     optarg[i], optarg);
 		if (negate)
 			opt->filter &= ~bit;
 		else
@@ -5389,6 +5393,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "find-object", options, N_("<object-id>"),
 			       N_("look for differences that change the number of occurrences of the specified object"),
 			       PARSE_OPT_NONEG, diff_opt_find_object),
+		OPT_CALLBACK_F(0, "diff-filter", options, N_("[(A|C|D|M|R|T|U|X|B)...[*]]"),
+			       N_("select files by diff type"),
+			       PARSE_OPT_NONEG, diff_opt_diff_filter),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5441,13 +5448,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
-		int offending = parse_diff_filter_opt(optarg, options);
-		if (offending)
-			die("unknown change class '%c' in --diff-filter=%s",
-			    offending, optarg);
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-abbrev"))
 		options->abbrev = 0;
 	else if (!strcmp(arg, "--abbrev"))
-- 
2.21.0.548.gd3c7d92dc2

