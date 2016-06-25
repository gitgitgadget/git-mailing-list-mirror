Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A3191FE4E
	for <e@80x24.org>; Sat, 25 Jun 2016 05:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbcFYFYK (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 01:24:10 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34304 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbcFYFYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 01:24:08 -0400
Received: by mail-lf0-f65.google.com with SMTP id l184so23684349lfl.1
        for <git@vger.kernel.org>; Fri, 24 Jun 2016 22:24:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x3q38FPShs1CWih5zpSUiuNNjKkcFdQ/M3tjHMtQBqg=;
        b=FynPIOf7ct8Dh4qS932BrJfn7oeWRlo7qzaiBerjn6Edy1wuxh30AfD7ipYblfSsiP
         xD1OLMHKDnzmm0zIdJv+M9Fek7sJvmYxfSa5JtcwPvzzkbyO3qotNXjeRGvlOUS5UUlg
         3BzFwbSyfgPcFGC76QTELjn/mLKtplSz1f4g78Wk4jiHlfiib46yWxsW/wqlx1WtSNg+
         Bb13rMcOdIAEclhAbHZBfoV3nBTMze1ycWpBKT3ksugEWhi1x73HlRvYl8M8A8Yx3iXE
         6puaSy5T+v408NZoB54lgwomHhzKNN1bHtSoZNuGjxPj6b+a45yAi/PPX8NCElDM3/m6
         STfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x3q38FPShs1CWih5zpSUiuNNjKkcFdQ/M3tjHMtQBqg=;
        b=fzyZwhq45GujINlOU0Bo9gBdnJY8Z9enU3ww39CuFgafbMx0LZrRpGovqL+MhLrX99
         iKj7+WN5YdtBY/X8f6mfwZ2NjUMYzD7HIFJBhWDoT0orUVaVbVm4hJ/808q+bMtAsTi8
         KLrpMOS3M5Yn4jAFMrHMeVHv1EAKmM6jksJGj0iHS67Xp+V+euECG7qYIk23abKfB3ZO
         0ioTqrKZhs9VlgweP1n+3LP4U8QA1folrKMv7kPF+InMgMRJptEJnSz+ub5z9PBu6LnQ
         hA2O740cNTYJzN5SUzo3pvJr52Hs10BqUaRxcbXk0hnhGeBI779GEPJqGaaDCfS+BHPv
         Qdtg==
X-Gm-Message-State: ALyK8tIonV/TBWmkRvwJFcqn9/anPcRzQ0eJWVpJ+j9zbm5K5F3fvuTkWuu4KfjjgaH6GA==
X-Received: by 10.25.15.159 with SMTP id 31mr2563232lfp.123.1466832246808;
        Fri, 24 Jun 2016 22:24:06 -0700 (PDT)
Received: from duynguyen.does.not.exist (10.219.241.83.in-addr.dgcsystems.net. [83.241.219.10])
        by smtp.gmail.com with ESMTPSA id s87sm1450921lfg.46.2016.06.24.22.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Jun 2016 22:24:05 -0700 (PDT)
From:	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v2 03/12] test-regex: expose full regcomp() to the command line
Date:	Sat, 25 Jun 2016 07:22:29 +0200
Message-Id: <20160625052238.13615-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.526.g02eed6d
In-Reply-To: <20160625052238.13615-1-pclouds@gmail.com>
References: <20160623162907.23295-1-pclouds@gmail.com>
 <20160625052238.13615-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 test-regex.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 49 insertions(+), 2 deletions(-)

diff --git a/test-regex.c b/test-regex.c
index 67a1a65..eff26f5 100644
--- a/test-regex.c
+++ b/test-regex.c
@@ -1,4 +1,21 @@
 #include "git-compat-util.h"
+#include "gettext.h"
+
+struct reg_flag {
+	const char *name;
+	int flag;
+};
+
+static struct reg_flag reg_flags[] = {
+	{ "EXTENDED",	 REG_EXTENDED	},
+	{ "NEWLINE",	 REG_NEWLINE	},
+	{ "ICASE",	 REG_ICASE	},
+	{ "NOTBOL",	 REG_NOTBOL	},
+#ifdef REG_STARTEND
+	{ "STARTEND",	 REG_STARTEND	},
+#endif
+	{ NULL, 0 }
+};
 
 static int test_regex_bug(void)
 {
@@ -21,8 +38,38 @@ static int test_regex_bug(void)
 
 int main(int argc, char **argv)
 {
+	const char *pat;
+	const char *str;
+	int flags = 0;
+	regex_t r;
+	regmatch_t m[1];
+
 	if (argc == 2 && !strcmp(argv[1], "--bug"))
 		return test_regex_bug();
-	else
-		usage("test-regex --bug");
+	else if (argc < 3)
+		usage("test-regex --bug\n"
+		      "test-regex <pattern> <string> [<options>]");
+
+	argv++;
+	pat = *argv++;
+	str = *argv++;
+	while (*argv) {
+		struct reg_flag *rf;
+		for (rf = reg_flags; rf->name; rf++)
+			if (!strcmp(*argv, rf->name)) {
+				flags |= rf->flag;
+				break;
+			}
+		if (!rf->name)
+			die("do not recognize %s", *argv);
+		argv++;
+	}
+	git_setup_gettext();
+
+	if (regcomp(&r, pat, flags))
+		die("failed regcomp() for pattern '%s'", pat);
+	if (regexec(&r, str, 1, m, 0))
+		return 1;
+
+	return 0;
 }
-- 
2.8.2.526.g02eed6d

