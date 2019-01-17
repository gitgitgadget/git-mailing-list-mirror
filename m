Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C761F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfAQNIO (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:08:14 -0500
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43903 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNIO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:08:14 -0500
Received: by mail-pg1-f179.google.com with SMTP id v28so4424822pgk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5V2+KZiYd3Ml1DGTT2KJfL9+sy/a0avXhXiU3XiPvRY=;
        b=t9IFXR8DtSYAlmIOhZb9JP1zwmu53w+ILdSmIOIJFONeX8966D5hWb4kzGV+oxyzGR
         rhM40nB/SY1stpl/+Gj2NLyrXM/kICa8jWACJAqApnYoKvBvVJFhPXFUaxX0ukro9s2x
         iHZz+R7O6BUF2lo9q9hG0fCZUwGoAYGOmnDjqCf0pCQ9Wd+ozpOSKpn/6YcyKP+e0YzS
         ta9U5bQPlD134NPTSxIY6B2gtdfsA7dctqsJX/l8QkIt8uBUeEyKr4RUGoUywIQe9/Dc
         0jScSqFGttP1X07gkSIwishiJbRzqcQujkQ89yG2QusxMxNJKr9oSyiPQveSkwLD+rgT
         V/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5V2+KZiYd3Ml1DGTT2KJfL9+sy/a0avXhXiU3XiPvRY=;
        b=CzyvvkVYZ1n/+INBWpjwy9FLgKbNPlAPUIi7eHnDznpBPgOQwy9EMkAilWcOIyBYM3
         f75Fx6JyBmSbJMZe5C30hEdy6wHE3nFHjwLq+kjVqmvAUORDqOgRUCDR3hPd6+8o3fqA
         R491Jc0I/qEgCO+OiI8YS0Aht718a69r2mCYgGTe67SVQmW4fO8OdCQfVp7MDOeNjtMu
         ri0th97ukp3au+hQFZq7dab7PmSjOT7sHb0ywiKBTWe+Cd8YKUlat07Uhk7mvZbebYeS
         uWHypBf+O9e3VNsF4Q+18UTC6I/31XS4mDXOpK1axSaEHSKjh6/oOtLGJDy9siPK4R4L
         O9OA==
X-Gm-Message-State: AJcUukdQcV3cDpaE+gakmORzJE9iNIRHJhHviEP/pjL/r+TP0TYgRbUw
        3OlyVV80vFJDbtlQnYLvpbmgvGmP
X-Google-Smtp-Source: ALg8bN6IeUymI0S/HfiATPbnz6wbKS59Z1Q/lUMmK/+ph31aLjVpuipYs5kdwk1vQYyUHxiKdfPQkA==
X-Received: by 2002:a62:9fcf:: with SMTP id v76mr9326485pfk.144.1547730493419;
        Thu, 17 Jan 2019 05:08:13 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h129sm4656253pfb.110.2019.01.17.05.08.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:08:12 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:08:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/76] diff.c: convert --summary
Date:   Thu, 17 Jan 2019 20:05:19 +0700
Message-Id: <20190117130615.18732-21-pclouds@gmail.com>
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
 diff.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 07b495b686..73fbe5b265 100644
--- a/diff.c
+++ b/diff.c
@@ -4940,6 +4940,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "check", &options->output_format,
 			  N_("warn if changes introduce conflict markers or whitespace errors"),
 			  DIFF_FORMAT_CHECKDIFF, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "summary", &options->output_format,
+			  N_("condensed summary such as creations, renames and mode changes"),
+			  DIFF_FORMAT_SUMMARY, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4968,9 +4971,7 @@ int diff_opt_parse(struct diff_options *options,
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
2.20.0.482.g66447595a7

