Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 308F51F453
	for <e@80x24.org>; Thu,  7 Feb 2019 10:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfBGKea (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Feb 2019 05:34:30 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32778 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfBGKe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Feb 2019 05:34:29 -0500
Received: by mail-pl1-f196.google.com with SMTP id z8so1967614plo.0
        for <git@vger.kernel.org>; Thu, 07 Feb 2019 02:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xw7jWeLS5I5fGlGJLW1DJ9YAciPymk94Y7wOM1l8mxc=;
        b=qAALKQGm1wWhkIAnMfUUvlyadqXhoLzxyhQzCYv4hozD2iuTDDA5ebn5L7x8HRzImg
         vG/iwkoDrqXK1EJYVrijC5ffCwtzP8hi1vCtuP3N1zkuJ5iEUtnaHVTpFO9IQTw+RsM3
         ujp6qR+aJpFa8/hxXQj5Drejc359+IjFKJIKm3NT1+muBHLNcIbGmHzL+uNZ5ODd493l
         ACAPJUfkESSGRJ1fnTS3So+MCFJ4QKnTzzCDlfulzuCPQSpd6sn8tIeAeEr46HKQyC/E
         m5AThaaEAV5D4IDvDve6hDUjmAhZ6ZYElIjE6EdvoqmIhPdMmjZmNoeN8syOJiK57Iuj
         AM6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xw7jWeLS5I5fGlGJLW1DJ9YAciPymk94Y7wOM1l8mxc=;
        b=ZPU8/sPYi89nScMY7GkvRImE+pZpv7o8eMnXrEMU1Sl2q7BrwPFpILcvTu7Ae6QwuT
         ZkiyhXl+iWa1JXqOGS54PuJYBQW4YUGTxEROd2EP8mSbdGlV6JACVj51B7H0wxNC+pWH
         ywzPX/tW/OCHz/zM3hCTII3uMK1iLvg26BUv1Md3iPuSSoh6S3R4eJ5xuKKpJUpi5uNu
         DCrS3ZeApT5MxkyBq9RX2DpGhIkNz6CV0GmrMtWLnOiqn/QM0Q722ayLENeegUxo0LBu
         UKHvzTKv/L5qTA5P3lhMhS6Ni6zc4Y2HMz0E+7bXucKfSHucWie+jOnMkeOJ0jNuqYna
         QXuw==
X-Gm-Message-State: AHQUAuZF7b76H5JPne4scFCYyFAJCFt0AhYyPlztxFViDlk0nhaLOSAY
        J8u0zHUjNB0KSPh6u2ZXP9eG7Xvy
X-Google-Smtp-Source: AHgI3IbEFtBCxnxfHzvQ4uN6CbtdDbh7ch+KxDS7FyFPTVChYmzha/zqj70Vd7pRhnHqhqfAy2MJQg==
X-Received: by 2002:a17:902:2ac3:: with SMTP id j61mr15761482plb.185.1549535669130;
        Thu, 07 Feb 2019 02:34:29 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id b24sm1867256pfe.136.2019.02.07.02.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:34:28 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 07 Feb 2019 17:34:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/21] diff.c: convert -s|--no-patch
Date:   Thu,  7 Feb 2019 17:33:14 +0700
Message-Id: <20190207103326.10693-10-pclouds@gmail.com>
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
index 99047fb5fe..9c8f5336bc 100644
--- a/diff.c
+++ b/diff.c
@@ -4906,6 +4906,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BITOP('p', "patch", &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
+		OPT_BIT_F('s', "no-patch", &options->output_format,
+			  N_("suppress diff output"),
+			  DIFF_FORMAT_NO_OUTPUT, PARSE_OPT_NONEG),
 		OPT_BITOP('u', NULL, &options->output_format,
 			  N_("generate patch"),
 			  DIFF_FORMAT_PATCH, DIFF_FORMAT_NO_OUTPUT),
@@ -4983,9 +4986,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
-		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	else if (starts_with(arg, "--stat"))
+	if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
 		return stat_opt(options, av);
 	else if (!strcmp(arg, "--compact-summary")) {
-- 
2.20.1.682.gd5861c6d90

