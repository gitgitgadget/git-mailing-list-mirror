Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52D4C1F453
	for <e@80x24.org>; Sat, 16 Feb 2019 11:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbfBPLhu (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Feb 2019 06:37:50 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33514 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfBPLhu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Feb 2019 06:37:50 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so6152163pfb.0
        for <git@vger.kernel.org>; Sat, 16 Feb 2019 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l0Ct8Z714Siw8wBJ1GBy9Ich8auweyrQ4QOOxtOuyeQ=;
        b=IiBWlh5An1NZ64yirJA6GIfcxjybObzHgSaQLowCW5yowRVTJnHEii2HA/TWgeAC7T
         b2LY3Qd9PQ15BkztVhROz4s1eXK/HpAMT6x3gAYiOxq9Wzv7DH4kJ9mdLJqmt6zjiv7d
         gG+6t9JW81BGe7zqdOEpyni9rIyNB/nEjxovBoMNR+SI5QdaqtOjlV/J3qM4+wkIwTX4
         IQbWQz+OpakqBiayfzQmPgbYW275AntT0yItzQQ7X6QLiAhCYH/90Lzmc1QeQzPVb7Vm
         rMEvgoleQzVItVZ+oTPzpYvc7JcmLHhgVX1peJt9PotW8ZyL2FaHLQWFZjsYO9Br+A5r
         4/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l0Ct8Z714Siw8wBJ1GBy9Ich8auweyrQ4QOOxtOuyeQ=;
        b=kB2W3nWovlYa2q9VepTdcZdIQhSBNdEkn1c1+pumdtXXNnsGydzTaWrQ9jbg3iMhgO
         kwTU4R41ADAu3oO7bicP3P6ztwjAHtmStzyRPkB8UodrumcgFYkZ8crgwbVeInnms879
         FsF5YPLw/arOxkpf87jSp0I9a3XZDwPytnxyL8Q167Pal5TK4h2wANwWQbldsyjBEUbR
         9tfVR1QLzFrqOwA8ef8eQzUYvF+EpxMVoD/pePs83fYpHz+E1P/sXl6xsdJoX5TRtMl9
         w2R+8mJ68s/ZDYcGO6aJa05QRgeBDN43Zaz03vcyklKxGfgKT4AEw12dGWI8r6AlCIeY
         Tr0g==
X-Gm-Message-State: AHQUAuZj/hT41Dmhio2BGXebmkSa/9MJ2pnY9U+QxHlYnd3R9iU5WUNA
        DDZpHQHbB5C5DKSW63KNSns=
X-Google-Smtp-Source: AHgI3IbujMBK5yLGvt+DBXd/Mk7jrsP2H41FHAdxqK7T4rVUTlVoCuRN+lluJzZ+nPOpBeQM/gtUfw==
X-Received: by 2002:a63:cc12:: with SMTP id x18mr9708731pgf.33.1550317069245;
        Sat, 16 Feb 2019 03:37:49 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id a12sm8312900pgt.58.2019.02.16.03.37.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Feb 2019 03:37:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sat, 16 Feb 2019 18:37:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v3 08/21] diff-parseopt: convert --name-status
Date:   Sat, 16 Feb 2019 18:36:42 +0700
Message-Id: <20190216113655.25728-9-pclouds@gmail.com>
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
index 7ea308814f..99047fb5fe 100644
--- a/diff.c
+++ b/diff.c
@@ -4952,6 +4952,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT_F(0, "name-only", &options->output_format,
 			  N_("show only names of changed files"),
 			  DIFF_FORMAT_NAME, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "name-status", &options->output_format,
+			  N_("show only names and status of changed files"),
+			  DIFF_FORMAT_NAME_STATUS, PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -4980,9 +4983,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* Output format options */
-	if (!strcmp(arg, "--name-status"))
-		options->output_format |= DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
+	if (!strcmp(arg, "-s") || !strcmp(arg, "--no-patch"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
 	else if (starts_with(arg, "--stat"))
 		/* --stat, --stat-width, --stat-name-width, or --stat-count */
-- 
2.21.0.rc0.328.g0e39304f8d

