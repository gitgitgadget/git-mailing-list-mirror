Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A31A31F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfBPLhV (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37206 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id q206so6091142pgq.4
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EI6iADq4mEfiqdHjsFNg+D7GzxgJW4c3B/6yv7BN4jg=;
        b=gTvMTX0UthFCMrpQ0Z93QEbglwDbG0UCAJ/KC2j+Gpepq4ExFA4dNIXndke+dqT1V9
         yehlhQRNEjfgPoZxpSaGiLZ3cGjmGiLEL8f+GnqYJ5zNrcqSLRGCU9Q5t2kyDypGufDV
         aw5xBlv5S4Hu5kIlg+1BHq/a/YCMkvLg28RT2IH4zJdwoOSy9l3JKgNVAnWYG9IjB3g7
         ISspZfz8fRI0uLQmeCJ2EpUytxQEWxlrSpGaumVrV/VbY8TIarlJ4/GVWtwh+3G8BzRa
         3hcnQmSpA/iE91GYjtx2QeHsA3O5L3msRGZu7GmjtD7txo81xUef3PR0Qhuy1d4yi2g0
         bRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI6iADq4mEfiqdHjsFNg+D7GzxgJW4c3B/6yv7BN4jg=;
        b=gZB+ggv+lEyVV7v4Vx1u7glkDlSaiRnxC1ndw7QoiZ9FaclTKTRVX8cZnNmwfpqEIj
         t2phLpHps+VqY4EbzTd9WRJUyhJUHmWC5KGzgjay9a5HJdVKRb9hHaQBowkEjH263MWx
         17/tfk3VmZA3rrQcY31Ief+5OuSZWRcA6/vVTLDZW0EplYCT7pEuPaFEJyBtRuBx5SQ/
         ke6r3lYqZoBvTXEp35fth/b++QlaOSmufMHSRLmZZ0veUh7aJIGW/4bhVkAi6GBSab8D
         3qAU7+1D5h9Or6GhCUp2oQiDqQ8eIdQb0lFmB17Kt0y3CO8lD9722j87/vso4l/UPU2n
         sRjA==
X-Gm-Message-State: AHQUAuZTkTHYf9Eel86FnBSv1sJTeAaLK+3c83LHGjdIZ+KXOqX5t18I
        nx+zb5cWi09Lw5CSAfiXEfA=
X-Google-Smtp-Source: AHgI3Ibf1jAILJApJ+Ky/MDgvVYweVS8LnlIItJi21DCut5R4QLqC0b4lDr6tvH5PbdBqNH0KTBQLA==
X-Received: by 2002:a63:f141:: with SMTP id o1mr9949705pgk.134.1550317040561;
        Sat, 16 Feb 2019 03:37:20 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c23sm9385724pgh.73.2019.02.16.03.37.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:19 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 02/21] diff-parseopt: convert --numstat and --shortstat
Date:   Sat, 16 Feb 2019 18:36:36 +0700
Message-Id: <20190216113655.25728-3-pclouds@gmail.com>
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
 diff.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 12e333c67f..419b6ac4ae 100644
--- a/diff.c
+++ b/diff.c
@@ -4905,6 +4905,12 @@ static void prep_parse_options(struct diff_options *options)
 			  N_("synonym for '-p --raw'"),
 			  DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW,
 			  DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F(0, "numstat", &options->output_format,
+			  N_("machine friendly --stat"),
+			  DIFF_FORMAT_NUMSTAT, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "shortstat", &options->output_format,
+			  N_("output only the last line of --stat"),
+			  DIFF_FORMAT_SHORTSTAT, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4933,11 +4939,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--numstat"))
-		options->output_format |= DIFF_FORMAT_NUMSTAT;
-	else if (!strcmp(arg, "--shortstat"))
-		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	else if (skip_prefix(arg, "-X", &arg) ||
+	if (skip_prefix(arg, "-X", &arg) ||
 		 skip_to_optional_arg(arg, "--dirstat", &arg))
 		return parse_dirstat_opt(options, arg);
 	else if (!strcmp(arg, "--cumulative"))
-- 
2.21.0.rc0.328.g0e39304f8d

