Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 933FF1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfAQNKp (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:45 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42450 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQNKp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:45 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4429538pga.9
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lsDe6mDEoAm6A4KmeW1wJoZ1N1Zg6vxyxGzpF0a5mcA=;
        b=uzoC9QtCD+HAkNR+WnPIgtZTNnKOZu4Mb94Xg2dOb9p5XeFLLvDDPpHcWWNQyEknRT
         dNxgOQUuMpXQ6C1T7YYRsPp19MF+1HzCFpXV7mVHM6n7NiO67jkQT/SKlrJrCYCQP/2e
         EdRW+ra2NrZwDbzldUb8c2Uw6fhDH5bepHeq1LOljUofnkiGtKtD/KNbhaop29FdlChM
         r3V6is/nKJoTqyAuK0ercWODqE4KsCVpffutgK4SAEGZp+r065qNCIHUoMxT5yF1xT2J
         IP5sVPiEQY/kjmS7Cb2mHc3VF7upv+NhUfK4NjYCtW/DK7F7Tv7iJhTbYvrZfWaA1oKU
         qvYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lsDe6mDEoAm6A4KmeW1wJoZ1N1Zg6vxyxGzpF0a5mcA=;
        b=EDOk/KXw2KMhq9dcGve5bWCkSgUSDI3U3/7qNsfmraiveephAPmSmx0fbkGOmFkSp/
         0VrPQpX01bOmfWuVWSAVN6dw6i+VA5s3Wr3vCHhQacrJuxL3fdWyExUiPIcbnsGSe54x
         psSS1qXh2OQGECkCKKwQtW34Noqpnt2QOjUCi0GwMoriKTBVV5Lp8Ozf7X+PjxVl06Br
         WswiHxcguuE9F9cdLU7bR5UoeSAQo5soUt70vVqVm4el4GT/tJ5h1/9jMPZNw7qZQAWQ
         WOY2MwdDY2ew1xA623r8G/K//c9Vgr9NErcR4JZm2OOvfyZGfBUtv3lAKlx6LhHrxPOE
         jDBA==
X-Gm-Message-State: AJcUukczAlk+QzJ2kUhvPuiOU8IBjPwYfcdqLkxYpSMpxQQLBHu1OcWj
        PGSPb8wTfgHsznm5vKZufK0wd28e
X-Google-Smtp-Source: ALg8bN4czPiQ97dzJ0M8ujysudrE8kxc6D1/fr2WiuNVRwRGucZk+gOe3OsoYEXVdeNZAEQyFPoFJw==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr13510747pgl.270.1547730644580;
        Thu, 17 Jan 2019 05:10:44 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id l5sm6234535pgu.86.2019.01.17.05.10.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 51/76] diff.c: convert --exit-code
Date:   Thu, 17 Jan 2019 20:05:50 +0700
Message-Id: <20190117130615.18732-52-pclouds@gmail.com>
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
 diff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 49cbf14417..888a4a4975 100644
--- a/diff.c
+++ b/diff.c
@@ -5301,6 +5301,8 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("treat all files as text")),
 		OPT_BOOL('R', NULL, &options->flags.reverse_diff,
 			 N_("swap two inputs, reverse the diff")),
+		OPT_BOOL(0, "exit-code", &options->flags.exit_with_status,
+			 N_("exit with 1 if there were differences, 0 otherwise")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5350,9 +5352,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--exit-code"))
-		options->flags.exit_with_status = 1;
-	else if (!strcmp(arg, "--quiet"))
+	} else if (!strcmp(arg, "--quiet"))
 		options->flags.quick = 1;
 	else if (!strcmp(arg, "--ext-diff"))
 		options->flags.allow_external = 1;
-- 
2.20.0.482.g66447595a7

