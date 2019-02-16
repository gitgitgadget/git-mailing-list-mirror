Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7727A1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728304AbfBPLhp (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:45 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36115 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:45 -0500
Received: by mail-pg1-f194.google.com with SMTP id r124so6089688pgr.3
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R7hVXdNFGsVdkpaFkisKK5nLKKpIGH0TOjyXb5UstIY=;
        b=UEgUuPeQQ3f+Mqai8ACfRRsPLv1RkA0ecltkyqxtFTkuUiAISXE+VKp+1i7nkFSCHh
         uEx1sM2epFwt8Glo/NBrFByWFgBNNWE5ZpPVxA/PsmlApmIoSdM+TO+i0i+BP3N+8OOj
         feJQ2nlSncneqelASTkuxOq8TfKqm3HdChS1dCeBiizS3QW3PtssIY+atL6szLjz4WhU
         bjDG8/MYMfjVk5cx85R5afDcPzrPfRRW+KrveoQ/ILvMdj1WmuqwdMhrRkuDvXht0RKh
         p8VA1V4HQ+zr41QSE2DflM1jCeGjrlbm6XJUwJH9kMZTraa09FKKYBP4PsWHpw9xQrl7
         CPCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R7hVXdNFGsVdkpaFkisKK5nLKKpIGH0TOjyXb5UstIY=;
        b=OKFHrWNWzD6XPN4+sVeU46A7exiTH/RBQkTQotcZpJMyZ4QkIwImnwOhoF1Hfsiycq
         3CEbcPBH72uV+X/4jxOAe2Xs2SFVo9rTIXBPn3a2MHMDU/Y5FrmDF7G2yfgyKCWkFE7W
         /8aPpJ7Te8TAaXoxdNDslzwDSogtOXqwoiqbCsBCzLsOXqef86o/rzR8lEyJ5LXtwn0N
         RI7BWrSdSemg7NcNVO4se6QOXlcGhXLSZFEDCuHcmC7Y6G/bPPd8mAhZ701mFFU+ZbSc
         dkJ9EfcmTbNe9QlYyxuOA2JRNSKolxsxDFuZJDG2OLfMLQCE0vmNjNyID22xFO9FYLEN
         EtrQ==
X-Gm-Message-State: AHQUAubc3OGjtP/ZzHT3MITjAaggz2PYU3LTtpL1NHbBSMmX39wPZDpR
        toLRGC+hY/HjNRgG7nVNYPY=
X-Google-Smtp-Source: AHgI3Ib5mu133T2yQNRtYmQavqtvmGJBS+WCXMzmG6hEL3MbnYNHF3As9ut9n8takz4U25fiJu34eQ==
X-Received: by 2002:a62:4b4d:: with SMTP id y74mr14305933pfa.186.1550317064535;
        Sat, 16 Feb 2019 03:37:44 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id n186sm10485222pfn.137.2019.02.16.03.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 07/21] diff-parseopt: convert --name-only
Date:   Sat, 16 Feb 2019 18:36:41 +0700
Message-Id: <20190216113655.25728-8-pclouds@gmail.com>
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
index b9811aefef..7ea308814f 100644
--- a/diff.c
+++ b/diff.c
@@ -4949,6 +4949,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "summary", &options->output_format,
 			  N_("condensed summary such as creations, renames and mode changes"),
 			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-only", &options->output_format,
+			  N_("show only names of changed files"),
+			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4977,9 +4980,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-only"))
-		options->output_format |= DIFF_FORMAT_NAME;
-	else if (!strcmp(arg, "--name-status"))
+	if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-- 
2.21.0.rc0.328.g0e39304f8d

