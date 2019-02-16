Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 605F91F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfBPLhb (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:31 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45728 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id r14so6280998pls.12
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w2j+39L0SZuLz7tH9WBUwitNrZeJ9smd07RyrGJd1u8=;
        b=sAcY+JAjX+/Rx34mkwFFWEThFNpYxZ5Z7q8N2B6vV3s4vo0B8YQgF1jK1VCqq6HBlz
         xTAoJQKeytMKnKVPXPH3YoW79huXG/3PlmoVEyAqspBsqLreGaxl9Y/rejHN4ZqzU1tL
         d5KT+vpz/z+pWp4gZG3lvwONOkmnZpScUmx1VPAIzZjkBMc69Ba1IKZFG8PO2lBmLbaE
         D3FVDobDb+D8+t9upx4RL/ZWSHT6tMJtonjSe3am38lVAdsCQSpZZvCB52eejYOriHFm
         7LBRTfQzMTpcsdA+6e2PJSW+m1Wc4iO+/Car0oNdXmWAvqbNPdsE24fOA1mtuKQeub3d
         iySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w2j+39L0SZuLz7tH9WBUwitNrZeJ9smd07RyrGJd1u8=;
        b=SJIsndkoM1TGptBkIKehOyd75jZ1FkIfgN5S/JoFK5ID+phZXlKhJWBvqmfBNV0SM5
         r5r5UAKHE0KlwLut8GC6GJgAE98X7trSayDdSzNcEOvBuDKMxawkDB9qkD7Lc9Y7NP9B
         kFJydZy6enQec9zmJ2dDUE7Q654rDH5uSpXE3Xa7Yc3qQal7HOm6rTcSDEdUWYeq+9Ga
         2rq/+SnF9gZYC4GFxQybX7UtUq6z0jpnXqNPpHHqVSScEenC9c3g6x7Jo+XMC41s3S7t
         d2RHfy083NQaE+00NHI1O0BCtKStMXS87/gSMVdDoDHPmpbslcbqbIpHjjUUC9u4M/eB
         bexw==
X-Gm-Message-State: AHQUAua64LsP7MAM8u8ll0H9HmI2v53LUwVAJ50IJ0zi0CMxVhCWvNn4
        VfcfuLwkfDTJfpzTL6v+Fht00Xsj
X-Google-Smtp-Source: AHgI3IZXEgbPwcMbhTuFwducSaINR/68h7rVRTqsccqB/poym4taoolIQHwNvYeMSY72PQh+IvKGsA==
X-Received: by 2002:a17:902:7006:: with SMTP id y6mr1406354plk.260.1550317050519;
        Sat, 16 Feb 2019 03:37:30 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id k65sm5398276pge.74.2019.02.16.03.37.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 04/21] diff-parseopt: convert --check
Date:   Sat, 16 Feb 2019 18:36:38 +0700
Message-Id: <20190216113655.25728-5-pclouds@gmail.com>
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

