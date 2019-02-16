Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55B581F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfBPLe3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42797 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfBPLe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:29 -0500
Received: by mail-pg1-f196.google.com with SMTP id b2so346649pgl.9
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2j+39L0SZuLz7tH9WBUwitNrZeJ9smd07RyrGJd1u8=;
        b=qahrJK4NX3wrh2t2QEqV4NZO+/1+jJ64SeOon258LgtqHwggXTR9ju9fTh71MMjRha
         UBQN22hlFbEv2Xz5RYnFj2plsp260UQbAeoL/XjzFB7RXw/71XfEsi3au7yardvLertp
         viEZymir8Sta7yFkOJ8OepGa5Ui/+cZi/Dx+u9EQ7u1fDLX4Vs3p4jS1G/NqFODer0Op
         K+uH1njaFn2/z8IaNDSb+OGMCDNV+sJryFSexUbhpNKImELotQ/OU+mnhTxWBeuAqpis
         tj/zP52APVcs42/HxMJy4o70cxUuuVI0xuiYf15xH+zDBVU4q5/JdoBGg4QBbLNevjJ7
         UelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2j+39L0SZuLz7tH9WBUwitNrZeJ9smd07RyrGJd1u8=;
        b=cCzkftht5/QAW7ft0zD/+EUB6MuLDvAxeAF9HaICBfdxHjXmFSPpEwLlXqzPeWD+CC
         +qG++8pr8Lwln1xRfp36JIppjoTdDeSO9fKSnr7EbRI+/bTnfF7oWpy+Kb3t5xSfF8yB
         4bwS3O1faPqBTQXF2EGYyZs43ajq0aLITBP3IqvOLtU6KvazKcVOKRVs7TTLKUsxtDHQ
         18FDp430hzWkjSXlJ0mbPh5KRaCulXmfTqfPTshyHF/HOWM+spSQkX8MmrXoRm4mr6Np
         tsU+jf6WHJl5ia1JbgKZtSHvrQYxHYcs4CsCIyYh7tIr21c3ZXcmlzc6oStcFTXYle0e
         T6XA==
X-Gm-Message-State: AHQUAuYQR2TB61H4Lc1PJ3z6PyKX1ZRHfQW6V8IJW4UI976rBnfB3ft/
        SmV5Esl1/H5zNEhHtxuVXAuaF8Br
X-Google-Smtp-Source: AHgI3IaovhQ1MxPJSI0Q/HEZLuRkyqbF+NLxzlcTfX2NzoikhfK6mfCZ4JX1qZ1e2/57kXUeUdgrrg==
X-Received: by 2002:a65:620a:: with SMTP id d10mr9529164pgv.75.1550316868461;
        Sat, 16 Feb 2019 03:34:28 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 4sm7914389pft.96.2019.02.16.03.34.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:27 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 04/21] diff-parseopt: convert --check
Date:   Sat, 16 Feb 2019 18:33:29 +0700
Message-Id: <20190216113346.25000-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190216113346.25000-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
 <20190216113346.25000-1-pclouds@gmail.com>
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
index 1cdbe8e688..5e16082091 100644
--- a/diff.c
+++ b/diff.c
@@ -4939,6 +4939,9 @@ static void prep_parse_options(struct diff_options *options)
 			       N_("synonym for --dirstat=files,param1,param2..."),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG,
 			       diff_opt_dirstat),
+		OPT_BIT_F(0, "check", &options->output_format,
+			  N_("warn if changes introduce conflict markers or whitespace errors"),
+			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4967,9 +4970,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--check"))
-		options->output_format |= DIFF_FORMAT_CHECKDIFF;
-	else if (!strcmp(arg, "--summary"))
+	if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
 	else if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
-- 
2.21.0.rc0.328.g0e39304f8d

