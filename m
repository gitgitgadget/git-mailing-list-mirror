Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B2D11F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbfAQNLo (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:11:44 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34366 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfAQNLo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:11:44 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so4452714pga.1
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IKcV7+MeiqW4JXvStwGnEHx4Ism5X7NfOe/eDknFyqg=;
        b=Qe2N+efWgwoYoq8jG610vMNc3NCvRrV8KXzN9Gwrfmix5PTe0GPnL/vZQBSI9cenUH
         SGX3lk6Lx7sKc0vEEYvz73cXVoyLXizOZUEgMfY3wuc8ng7jjGwpPrK0QqSKfzybp5GW
         eiWWETCZr8z5eGmsaBkw8RyPF/m+yBGNWDpECrD8+AWCGHzB53bUQc1k++ohYW38XBo5
         Ad/E7gLB/MfGNGR0r0z6x58Au/rZtv4TlwD//oDKnvhlgiWgPIvfzMoJW3QWTNPCdq2S
         C+UF3Czn3UIukImDBNywTpFCBd+hnLKlQHYw07FQzep2PTwhniqlV+Re+/xUcjjDWr+q
         SEKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IKcV7+MeiqW4JXvStwGnEHx4Ism5X7NfOe/eDknFyqg=;
        b=DEaSlMMXreRq//12/10jreW8Z8fnc6UUHOrDzKx8ydWrAzlvQLqPT6DjjAWLZyR+Ar
         ssbfPaEOh53WwpQHaOtYbCugfRyPMR41x4I6G7WfWxQm5bDvECT5/pts9VkYbF3pmf5u
         fv/owBZD1Ln2wYGAuHqLd5LnCf+3ISUSdub6zBGS83B2q+sb0JH8a6Asg9gatvb94I4Y
         wFBZYcIeCZ1flEtgg9vM2/puFIFvKmWQWNKVt4uwlaGhI/2uZxFBNAqCQPeJGvMBm6MJ
         0gM2kp47ZrwMy9JOjBGr4MSYcmTpN26IEBUi1E288a/fCg6jY7maAFy5dyaRSpQruSBH
         qg/Q==
X-Gm-Message-State: AJcUukfm5k18iiNwmyDQqPibEwXWVJUOWVx+I/0/qfSiebs/3VCC5qlb
        n54fBAWKuudZYqlWmTT33/ovSdyx
X-Google-Smtp-Source: ALg8bN5SusJHPEUqh+/LtPJl9002aP9B9Vc/GNhdSnUt1g9dd8F1+Peiota0MhBIyOm9YFImHIn1XQ==
X-Received: by 2002:a62:1f9d:: with SMTP id l29mr14887576pfj.14.1547730702981;
        Thu, 17 Jan 2019 05:11:42 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id 184sm2672769pfe.106.2019.01.17.05.11.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:11:42 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:11:37 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 63/76] diff.c: convert -O
Date:   Thu, 17 Jan 2019 20:06:02 +0700
Message-Id: <20190117130615.18732-64-pclouds@gmail.com>
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
 diff.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index ae993f5551..4e004a2195 100644
--- a/diff.c
+++ b/diff.c
@@ -5401,6 +5401,8 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
 			  N_("treat <string> in -S as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
+		OPT_FILENAME('O', NULL, &options->orderfile,
+			     N_("override diff.orderFile configuration variable")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5453,10 +5455,7 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = short_opt('O', av, &optarg))) {
-		options->orderfile = prefix_filename(prefix, optarg);
-		return argcount;
-	} else if (skip_prefix(arg, "--find-object=", &arg))
+	else if (skip_prefix(arg, "--find-object=", &arg))
 		return parse_objfind_opt(options, arg);
 	else if ((argcount = parse_long_opt("diff-filter", av, &optarg))) {
 		int offending = parse_diff_filter_opt(optarg, options);
-- 
2.20.0.482.g66447595a7

