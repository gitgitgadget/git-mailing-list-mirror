Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9318B1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbfBPLiE (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:38:04 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43792 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLiE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:38:04 -0500
Received: by mail-pf1-f194.google.com with SMTP id q17so6129011pfh.10
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3e4cwydYt1lq5ZVrvWigeNyRUPk2cI7POqoy22Zq/Tw=;
        b=F7oDrAvhGGta7W7kD37o0OCwIBbypDm4/EfsgShUGTXKDw5Zj+KXAP655oUHJtJbin
         C8xAXc8qjCMcMl7PXzytErAUZ8eu8W5xuQuWLY/iKbI8HwJF+iUhk8xuINoVS80SfGFZ
         CDg0iU/wsT4ZRfNIKUPDLjjjM3pwK1c3Gm0hwJNgCI5jlK59aZRqoTMoyaiw9n+Eet4d
         sZ0yruxGYiP4fnniPBZCObjaArvzkQHI5Kk4c9kavUuyRj5RUhPYuC2W54Raisrn3A+g
         xknQEQkwy+vQFzkF1ABr7r9C0p4Ykl0b0k5R740GPPytaPSSNorPJyvMAO8Bf6mKwNW3
         uGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3e4cwydYt1lq5ZVrvWigeNyRUPk2cI7POqoy22Zq/Tw=;
        b=SlJJE20sdDZg6MdW+nnbi3YrS1E/5KwgIcl5qpk6e2BdDk53rzfNVBgKxJ6rLFlWvi
         vh0xLxYN+ucyE4u9ZEiy/i5cPTpUrYPRyc1EPqZkN05R/UjbOzaXE4/w8U3rCVs5jYYq
         85ckyCpo5ULQEMx2JGq0LrSmYdSsP5SDgvhviV1huB32l9BBsfxgOnpKBKBXYH8vw1wc
         ltd3WAC+TTUPE3jqhlTV88gUk66EWMJ8OJq9LjBvdBCeRVfjH0yuuMkjEvReUlu9XBby
         YTnVXVKwykJZhf5Pz9xJvIH4ZivnWyDad0FVpTgiOYoklQ3D2GNM94eLfNO7gfhv0mHj
         Qn9g==
X-Gm-Message-State: AHQUAubGWVvA3nYN4lkFvTyzM0RzxQVUPSs1gV/UgxbdX+zWwUzLJe2p
        DVCgL7xkYIQXsqatFirJCjVlgNPy
X-Google-Smtp-Source: AHgI3IZ9Outkw51l54YiNoT9NDXku5JIq2Vsipz77Ru8UaJKIE0OFe7RXJargbR8yFsn1kywxgHOyA==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr9967882pgc.25.1550317083385;
        Sat, 16 Feb 2019 03:38:03 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k9sm8712403pgo.1.2019.02.16.03.38.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:38:02 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:58 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 11/21] diff-parseopt: convert --[no-]compact-summary
Date:   Sat, 16 Feb 2019 18:36:45 +0700
Message-Id: <20190216113655.25728-12-pclouds@gmail.com>
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
 diff.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 1feb13deb3..b24f6825a1 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,21 @@ static int parse_objfind_opt(struct diff_options *opt, const char *arg)
 	return 1;
 }
 
+static int diff_opt_compact_summary(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_ARG(arg);
+	if (unset) {
+		options->flags.stat_with_summary = 0;
+	} else {
+		options->flags.stat_with_summary = 1;
+		options->output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
+	return 0;
+}
+
 static int diff_opt_dirstat(const struct option *opt,
 			    const char *arg, int unset)
 {
@@ -4947,6 +4962,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "stat-count", options, N_("<count>"),
 			       N_("generate diffstat with limited lines"),
 			       PARSE_OPT_NONEG, diff_opt_stat),
+		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
+			       N_("generate compact summary in diffstat"),
+			       PARSE_OPT_NOARG, diff_opt_compact_summary),
 		OPT_END()
 	};
 
@@ -4975,12 +4993,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--compact-summary")) {
-		 options->flags.stat_with_summary = 1;
-		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
-	} else if (!strcmp(arg, "--no-compact-summary"))
-		 options->flags.stat_with_summary = 0;
-	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
+	if (skip_prefix(arg, "--output-indicator-new=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
 	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
 		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
-- 
2.21.0.rc0.328.g0e39304f8d

