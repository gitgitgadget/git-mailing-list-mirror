Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303161F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbfBPLeU (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:34:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42787 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfBPLeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:34:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id b2so346563pgl.9
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EI6iADq4mEfiqdHjsFNg+D7GzxgJW4c3B/6yv7BN4jg=;
        b=UkJo580p/caoTDPqiaB11mcLbljWaPZ1hVQQaJBdcgSOV7uUQObGal+8O/mStnjMPf
         jbIj6Sq/YUlbIzJfEMW67Ol8PwU3qW4LxOw5kZM2gcx7TPPoQsuVz0+7vY21INtia9Ks
         YAztCR/QTCoPKgGiyxhEFkeusemXNfkVpRgtHvf5a3pEt4a557koEj+3yhofNQ/3XB8w
         e+R1MK+GDTRN4/hkhQ0QQKDIYNZ7xdslaqMTQvCPSACqzGaroANVZYRb2mvMP5XM3aqR
         Cly2hsA1Ks4YDU/0bV7K9rXZqSXx+IqbkvbjERTIGoFXXchLZtCAcOjTUxw0WpKaQhBU
         6f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EI6iADq4mEfiqdHjsFNg+D7GzxgJW4c3B/6yv7BN4jg=;
        b=HvZofbS0fYkkbUyMXGOY54OUEliaQUbR6mHObdCkJwVX860ziw0z84JTRVk372oL6A
         tv0db/0ICXuM0cV5O62+g2P+dNCbDq4Swbd8XLj2xvr9exnYJIY0CVTYK0e2RqZXYPg0
         mI7ktHWKe1aqZ+5zUZLHH9z5fNm/92B/RBhRdEYWvJ5XEaklsrTCjUywC1W0MiVv0Ypu
         Xia6/8JaJpCev3ZnLrQL60fyQpMVl3qHO/eKXtAQVWadrocWvOyVkSkeOnwTFH+iZgr7
         //BRIB7dyTlGoCM0mzByGeOH+MV0FYoncWY1epTqGo26vDNnBVwID2Nf5y+InsuqZuZx
         wu1A==
X-Gm-Message-State: AHQUAuao80114hxHjOK/7vHxLLgSA6XaO+rBzMNfxKNlGGz3i/iJtyqL
        /WqRv/+aAgGl64mX20w96M8=
X-Google-Smtp-Source: AHgI3IbXr3liIJM5nFbFuXCQYa8VzHyhUTvcB18dIBTwfKl2JNdGr8V7ylIv8J4M5h6+FrBjVcRdnA==
X-Received: by 2002:a63:db02:: with SMTP id e2mr9900875pgg.419.1550316858736;
        Sat, 16 Feb 2019 03:34:18 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id d13sm13100658pfd.58.2019.02.16.03.34.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:34:18 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:34:14 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/21] diff-parseopt: convert --numstat and --shortstat
Date:   Sat, 16 Feb 2019 18:33:27 +0700
Message-Id: <20190216113346.25000-3-pclouds@gmail.com>
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

