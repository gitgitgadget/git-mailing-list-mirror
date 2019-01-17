Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EBE61F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbfAQNKu (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:50 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43753 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbfAQNKu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so4805627pfk.10
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xWBNNlFSE65DIZZ2gGHvNw391fjrMogTgpaMh9LOCdk=;
        b=PlrLYh9LtvkBBazjv7e/jfskAMbJKhCqfZpbuJSjN7dQSPZr0OodGmlWMz9KeMopfQ
         osiAVoObYdT8e5fIuPwTVsDaB916o0HnQFg/gJMFqT/wsfdGm44I6lyIeRwuqhmXfAEh
         U+1qKUZdEKS+mncY03aFucKpCo5r6qt8PmcAhBFrC0Mv/0chSTm9Ul0UM00NChvBW5rt
         YdgQVQ8k4g9UaGuTu3Zd7g/Gsjm5hNlRhiTkOj5C5Wblg0Fh3Shr2ejwxLBK6JkAoBcF
         279NRwvOZXlAO1BX9bx9PFYqeDzrnjiHBGai1KIEUwvhLD0v7LpIcG49H2dmPcpJL2jV
         vfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xWBNNlFSE65DIZZ2gGHvNw391fjrMogTgpaMh9LOCdk=;
        b=rRvmZALMcDtMrl0ldR93MzzdJcsIUKOHQ2NPgoR3t/OO5I+tM3113lOa9EpHuBTYBB
         UYSYJrujhwankFZ1SmFNCWdGr1Xe97YBfsICzWKwT5MCVtqXF3stMeGte16BoPk4WAHO
         gadcPAySv9Enj12OwupGJALct3Tf6ix3akWyUTmlnIzgDPpd6068xNg9or50Vv4wbZpM
         Ts3tNitgHx7a+AMRiumoBUsYLZG7GYJVvt4tKEwe+4Zlm/rxcDJfJZy5Rv+zn/XwGzag
         aZQ0FrdBID8SIgkBQVtlKcAoEKKXcQnebTBKWHDar6PgoMREx2vQK1R9oYY2uk6YE33v
         bFgg==
X-Gm-Message-State: AJcUukd9x3Ik3//3KV2mPK5X6c2MphowE+jCqgxsW1cg657GKIMx4oQI
        +wPKgGqC6dlS4uAgiPzdlkIO7VIo
X-Google-Smtp-Source: ALg8bN7b/fXsVrMEcWVoHdO/7oEHIrwR5MrF7AqPqcCIVM6HOZFnkVlp91EIH7IHxPaznJsBa/2l4A==
X-Received: by 2002:a65:50c1:: with SMTP id s1mr13097528pgp.350.1547730649357;
        Thu, 17 Jan 2019 05:10:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id h128sm2798438pgc.15.2019.01.17.05.10.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:10:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 52/76] diff.c: convert --quiet
Date:   Thu, 17 Jan 2019 20:05:51 +0700
Message-Id: <20190117130615.18732-53-pclouds@gmail.com>
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
index 888a4a4975..eb81a95e89 100644
--- a/diff.c
+++ b/diff.c
@@ -5303,6 +5303,8 @@ static void prep_parse_options(struct diff_options *options)
 			 N_("swap two inputs, reverse the diff")),
 		OPT_BOOL(0, "exit-code", &options->flags.exit_with_status,
 			 N_("exit with 1 if there were differences, 0 otherwise")),
+		OPT_BOOL(0, "quiet", &options->flags.quick,
+			 N_("disable all output of the program")),
 		{ OPTION_CALLBACK, 0, "output", options, N_("<file>"),
 		  N_("Output to a specific file"),
 		  PARSE_OPT_NONEG, NULL, 0, diff_opt_output },
@@ -5352,9 +5354,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (!strcmp(arg, "--quiet"))
-		options->flags.quick = 1;
-	else if (!strcmp(arg, "--ext-diff"))
+	} else if (!strcmp(arg, "--ext-diff"))
 		options->flags.allow_external = 1;
 	else if (!strcmp(arg, "--no-ext-diff"))
 		options->flags.allow_external = 0;
-- 
2.20.0.482.g66447595a7

