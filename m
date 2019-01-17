Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B58D1F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfAQNJb (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:09:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32841 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfAQNJa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:09:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so4834908pfb.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNaIjwE3e4ZL/7dDyKyQ7abSC8vpi1qotTttTqd2XEQ=;
        b=WGOa9DuegNKxzU0rIikmunbMRlveQdBu+jHpq5F0NSrGGXDgf23qhtH/J28UEBmcwz
         bZPjiJf03B0uoEnJUlonMdcVOIndBAiq8T7Y42usSWUaE47QYBg87QD9qbTdsAlS/zsO
         8p7f9QoRQyUXk4GKmDBjQjkClgmVdt8VeckHKGoPy7LgJ0Z6h9WbAkyd+IhWisaLN1YH
         Vavud3q1sUGYNmG+mh0bhtnZSexUj+K90om6TtcmNIh2AK7EHakfv2eFNVoClkO49szX
         8slxIBw0PUSPJstqtq9fj1kdOUGYkIGWrY/IDyRlqSgM2mFvWhoWdlcBoKa0K0rvUQFJ
         IyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNaIjwE3e4ZL/7dDyKyQ7abSC8vpi1qotTttTqd2XEQ=;
        b=pVdGacttA6xjL9+VP/1eBVTiahODBpKZQZOEsTptt1lK8nccIRU0nsOOMqhJEGWkNU
         jgfJ/qRi4MnyVS3hkdvFmCMjvsATLIwKayJX95UWkEXrhLmOWNmd6mkv1xzbZzT+9sO2
         r5awzqTiUW5QRNEWD9212GGhcqzR5BNl5+2N/VpZHODzgkHKbcvMQreVN9A6gT+gqVLj
         0+I51UGWeB5zgHJzXD0wWG9nGUTXJ2WlcsgZ31D/LXqF4EJ7es4BgZv8YDx71JaAWqC2
         zYWr4wedhBTFnhQ0N0LO5FzwuKuaCmJ6VdAVBoBluC7Ovu9dZ5BsIUXz52sFgxdt1Orq
         zzoQ==
X-Gm-Message-State: AJcUukcc6rjhQ/mSEQKK3SZ0kDMp0klQ6QEVO8LNc1hacmqXEG6BY2/D
        5LmFDHFkLfEsao23wAUOKxxXU377
X-Google-Smtp-Source: ALg8bN6OSpkHlaL3nTUxMQzyFqn2jICBA/w/jtuuvTUPxY0xXsaJZX2zEXjZQjuI21DA17VJBxzP9g==
X-Received: by 2002:a63:a84a:: with SMTP id i10mr13599990pgp.263.1547730570154;
        Thu, 17 Jan 2019 05:09:30 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id t13sm2023615pgr.42.2019.01.17.05.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:09:29 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:25 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 36/76] diff.c: convert --ignore-some-changes
Date:   Thu, 17 Jan 2019 20:05:35 +0700
Message-Id: <20190117130615.18732-37-pclouds@gmail.com>
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
 diff.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 67b701d522..d8b5c7b7d8 100644
--- a/diff.c
+++ b/diff.c
@@ -5113,6 +5113,21 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_BIT(0, "minimal", &options->xdl_opts,
 			N_("produce the smallest possible diff"),
 			XDF_NEED_MINIMAL),
+		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
+			  N_("ignore whitespace when comparing lines"),
+			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
+		OPT_BIT_F('b', "ignore-space-change", &options->xdl_opts,
+			  N_("ignore changes in amount of whitespace"),
+			  XDF_IGNORE_WHITESPACE_CHANGE, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-space-at-eol", &options->xdl_opts,
+			  N_("ignore changes in whitespace at EOL"),
+			  XDF_IGNORE_WHITESPACE_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-cr-at-eol", &options->xdl_opts,
+			  N_("ignore carrier-return at the end of line"),
+			  XDF_IGNORE_CR_AT_EOL, PARSE_OPT_NONEG),
+		OPT_BIT_F(0, "ignore-blank-lines", &options->xdl_opts,
+			  N_("ignore changes whose lines are all blank"),
+			  XDF_IGNORE_BLANK_LINES, PARSE_OPT_NONEG),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5151,17 +5166,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* xdiff options */
-	if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE);
-	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_CHANGE);
-	else if (!strcmp(arg, "--ignore-space-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_WHITESPACE_AT_EOL);
-	else if (!strcmp(arg, "--ignore-cr-at-eol"))
-		DIFF_XDL_SET(options, IGNORE_CR_AT_EOL);
-	else if (!strcmp(arg, "--ignore-blank-lines"))
-		DIFF_XDL_SET(options, IGNORE_BLANK_LINES);
-	else if (!strcmp(arg, "--indent-heuristic"))
+	if (!strcmp(arg, "--indent-heuristic"))
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 	else if (!strcmp(arg, "--no-indent-heuristic"))
 		DIFF_XDL_CLR(options, INDENT_HEURISTIC);
-- 
2.20.0.482.g66447595a7

