Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21FC41F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbfBGKeU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:20 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35051 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfBGKeU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so4319920pgs.2
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N+BJGWsLlURjrxyK7dPHBr/MxOJIO1TbQQP5mAnYrQM=;
        b=twyMByX+mL/0kJnOg0NstHjL/ylbZBjB8hKrHpK1XmalTEGq89VjCTH25NfalIRHpF
         +xH8xLFBwo+KUpGhRGAqfV1EagiOu2m6C8LyejZtluQByG5Yd6plEJwOImEs6RxivOHk
         886DL/v44raZJzcZSwacb40MA/L094G+D1No5AuO8ZeWIDm4Q3fQ6RYsAU1/IBQDMHT+
         N/9+pLqSDXDZwX9iFu9CP9Pnx5k71vWlN8wCmJlsjhUSibXxdyewfYnK2MiEKYOC2irQ
         wFp+dOMUigzltkT5/0IV346+hRFmyNpYghgxNtum9LC9Boto76LuOOmEMmHvAvY/48zP
         jqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N+BJGWsLlURjrxyK7dPHBr/MxOJIO1TbQQP5mAnYrQM=;
        b=I09sqIexSz/sWhxTygYOwYpF3eJiEtDuITP2hCT2tYsVk2ZVDGiEJ4/6EJRcbweCvm
         6sE0/dCEeZjcLKhk3EFvdFqCSNp4/LGnQqCNQH8nlcBGDD1XhtZBdOVGGpN2qyKS5R8p
         iHnDzJgoXZ6gRCp1nrUPPzLSg9WbLyDuaNxsws10c34EPaT8w4Dd049Od4XL1iM/T9Kv
         /PtU1tj+QPpgNQquqY9n2rGwfFtIQE6kvW1WO/RgeWF6fwNctDNv6zlSiNVYG+4OQb0U
         CQWmeYDzeMAh8HFQesiAmS/pWRB6g9UGQe5r1jOUHfJIP6UukvPMm321tsHTcSStszSH
         DV6g==
X-Gm-Message-State: AHQUAuYuQBOVw+5JFfnDy7gwovlvx7tguNz/BpW2SydEilYkbeCeCZp2
        +HIOkwPZAdaEaNlwrQtYrXQ+LuQf
X-Google-Smtp-Source: AHgI3IaEpnr+NFSlvxKo3BLuscMs8yX1vqi1jwjm6jaPyUfcp3g47Jw/lLyFAOYfHLTlnn9pC1cJtg==
X-Received: by 2002:a63:bf4c:: with SMTP id i12mr10043284pgo.382.1549535659313;
        Thu, 07 Feb 2019 02:34:19 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l8sm20823456pfb.68.2019.02.07.02.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 07/21] diff.c: convert --name-only
Date:   Thu,  7 Feb 2019 17:33:12 +0700
Message-Id: <20190207103326.10693-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.682.gd5861c6d90
In-Reply-To: <20190207103326.10693-1-pclouds@gmail.com>
References: <20190207103326.10693-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
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
2.20.1.682.gd5861c6d90

