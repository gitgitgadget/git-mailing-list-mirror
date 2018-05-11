Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 459FC1F406
	for <e@80x24.org>; Fri, 11 May 2018 12:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752829AbeEKMNh (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 May 2018 08:13:37 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46350 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeEKMNh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 May 2018 08:13:37 -0400
Received: by mail-lf0-f68.google.com with SMTP id x7-v6so7563990lff.13
        for <git@vger.kernel.org>; Fri, 11 May 2018 05:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r8lI0TI6Cvk+V1b9AmN+X/1RF26F/FStzKDfolFjjp0=;
        b=mWwzq6QiwKrmnucHzFQx8opq+JFfYX8SVcL0LuzZ16fTpHEyzbtItefGCQu27DGicM
         d6R6GLNxwp9cN9jlDklzOX/t7UZc98C5a0fBrbpey0Bui2phbN/j+ViHyLxAPLiwF/c2
         AJYLsgik4k2/+hys/SXsF1vyeG+MecqnXNtiYt4Nbkq1P8n/nYquoTY5Wca6n+rVKmz8
         TPJ+DCbEfwNCE74jeljrw9Gdq80GOweS0EEHYTO7majttkRfOrvhUQ+MEL1bah8k9QXm
         oxsqdSMK6o4a3hS50tqZZJvnC6W6t1A8Zbt5RLI4QqqQT5ErVUdkiJz0zUvqpNbo3Ulz
         npqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8lI0TI6Cvk+V1b9AmN+X/1RF26F/FStzKDfolFjjp0=;
        b=RxowKuowMbtTVdrVGtW91YYj8Ttbj2dp740D7ZVI9FbvwycsJtHY2tXuYhl6ZeHD3z
         Dh6smZYFXKhmNX/PMYNEyp8PVy91iEP4odakQcAmOAToe6kn6b5pg/1YXYgrhS5uSH/G
         QnmpHcW4baJYxUMsyPap6m9ceREE4T7N+onzGaaQHuj4OtmfKiVyIUMx20SnFndbkHa2
         AE+MOSS856Z3jzpFWWuiWLJQziPzQev9BY7gW86ocfJs5wCG4YkFfB9kUPX8fveoK6SK
         CWIKGs1WRfh889P4RmMUFlbrFOQCLt80CyBRywExnvvDfnhRqSaZo/ybX41pRhnJLCFB
         K0zA==
X-Gm-Message-State: ALKqPwfQW0kifB29aDAJAwvzZCNKfurbNUnFlXEIqoOYJnU7AmWd+xVW
        P0ZfYcosH5gghi2xaT6ZAzlfZQ==
X-Google-Smtp-Source: AB8JxZrWr+RRz704xwxR4CFB7fl5nxNcVU5CfMiFIKsd/0KO5Efje1aELZlQ1AMB1OEZBRIU6BtDYA==
X-Received: by 2002:a2e:880a:: with SMTP id x10-v6mr3860709ljh.45.1526040815381;
        Fri, 11 May 2018 05:13:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id v6-v6sm630607ljk.83.2018.05.11.05.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 May 2018 05:13:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] column: fix off-by-one default width
Date:   Fri, 11 May 2018 14:13:29 +0200
Message-Id: <20180511121329.16142-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180511092515.GA9567@sigill.intra.peff.net>
References: <20180511092515.GA9567@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

By default we want to fill the whole screen if possible, but we do not
want to use up _all_ terminal columns because the last character is
going hit the border, push the cursor over and wrap. Keep it at
default value zero, which will make print_columns() set the width at
term_columns() - 1.

This affects the test in t7004 because effective column width before
was 40 but now 39 so we need to compensate it by one or the output at
39 columns has a different layout.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/column.c | 1 -
 t/t7004-tag.sh   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/column.c b/builtin/column.c
index 0c3223d64b..5228ccf37a 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -42,7 +42,6 @@ int cmd_column(int argc, const char **argv, const char *prefix)
 		git_config(column_config, NULL);
 
 	memset(&copts, 0, sizeof(copts));
-	copts.width = term_columns();
 	copts.padding = 1;
 	argc = parse_options(argc, argv, "", options, builtin_column_usage, 0);
 	if (argc)
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index e3f1e014aa..d7b319e919 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -363,7 +363,7 @@ test_expect_success 'tag -l <pattern> -l <pattern> works, as our buggy documenta
 '
 
 test_expect_success 'listing tags in column' '
-	COLUMNS=40 git tag -l --column=row >actual &&
+	COLUMNS=41 git tag -l --column=row >actual &&
 	cat >expected <<\EOF &&
 a1      aa1     cba     t210    t211
 v0.2.1  v1.0    v1.0.1  v1.1.3
-- 
2.17.0.705.g3525833791

