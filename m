Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C5941F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfBPLee (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:34 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40828 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfBPLed (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:33 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so6289307plb.7
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=504YtP9c1Vs48gl3br293hIlq3E4PGdQAmXfEyWhldU=;
        b=KtfxWk4uMpfCk36ophG6WjK1FvyTRP1tQLBAjF1eSW7AKZXYNyeF/zl3xUF6tFCjag
         XUHRQkZMh0r18lJTp/luTZRASp5w5aDcohhb7py997ozqnbIImdDCuA2oMclW2NyYp1V
         gxhjbD68zgvkQNzCx8rbQpryzcTNbWUH0is304iACMO6wGRCDOY9gFkqW5/Sp0iTjTFN
         EzuOD+qr98OzRqjorS/ThBj2+Jx4HrAN+m2a+V1caZLIpiplLcjE/NyXd1uWF2XqJbDA
         hAMRpF8EMFu6SZ1v2jGUClkT6ea1Oi63y73EkQS1GkAiaxHeVeDplGxRolM4FUGXJEs/
         z9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=504YtP9c1Vs48gl3br293hIlq3E4PGdQAmXfEyWhldU=;
        b=DQ+f4IaiwVAW02LHpEI8Tpw84JoEpGeGISkYRmxwgjjcENkTuTpSyFEXPZ7mascnQc
         4oPB1pJRLNTBQkCML7R0eCA/gM099SWpAyQY/imZVfdCZxe79X/wImSHSFg5vGqX7mtE
         EAn2H+CtLnG80XaLkjqalxaCkmDIc+mtn06k6qsK1hhMKP6EH5nsw9ihUt8Eqci5WZMq
         HWK+9mZiqh+dr/+E/VuxWaf5aLafLEdTxIbeOVZBB8IWAK75KlW4n2KKJ95TWhJf8zaw
         CFkSVk9PBpXTfhm31mtRZ3f7yc4xlr6LWGgkM2yHtmSktkhceQMrnvv7gO/+2HiyfMbU
         nOGg==
X-Gm-Message-State: AHQUAub4gcGjmq9WUQz1tVAVrrx5pQJA/paHE6ta6cXQu2NAbAoIvJc+
        NdXHd7JdrT1VLW74fG6VigI=
X-Google-Smtp-Source: AHgI3IZ01JbXHfxVxN3H9UGSAnledGr7g9L2JIFX8j3Y/BIKEvRAU7JQ+xxC+I4tjAkV2Rw2xjiTUw==
X-Received: by 2002:a17:902:7882:: with SMTP id q2mr15415598pll.305.1550316873098;
        Sat, 16 Feb 2019 03:34:33 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id y21sm9532633pfe.57.2019.02.16.03.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:32 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:28 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 05/21] diff-parseopt: convert --summary
Date:   Sat, 16 Feb 2019 18:33:30 +0700
Message-Id: <20190216113346.25000-6-pclouds@gmail.com>
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
index 5e16082091..0276f25200 100644
--- a/diff.c
+++ b/diff.c
@@ -4942,6 +4942,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
 			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "summary", &options->output_format,
+			  N_("condensed summary such as creations, renames and mode changes"),
+			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4970,9 +4973,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--summary"))
-		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat")) {
+	if (!strcmp(arg, "--patch-with-stat")) {
 		enable_patch_output(&options->output_format);
 		options->output_format |= DIFF_FORMAT_DIFFSTAT;
 	} else if (!strcmp(arg, "--name-only"))
-- 
2.21.0.rc0.328.g0e39304f8d

