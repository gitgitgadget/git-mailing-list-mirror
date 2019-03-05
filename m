Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D824620248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfCEMbq (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:46 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33616 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbfCEMbp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id i19so5602544pfd.0
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8fqGB09blgykRBus+afatKi1AIlVlxvUigS04ouYP6I=;
        b=hEmMa8xY0cnSp1xARQEwSamx3oBqpj8hwl8c4+7Qh8DelndMp5W/HMrmyv9URDKdMh
         HkQVnGP6yzitMJNVB2hsEoipHBI1eboPDB2e2xvisrRWNAnAmHE7cq9DT0WiIPNABHWQ
         iSZ7iw4vkMBlw+XFzzOH45Qy1y872ZJkSn1n4o3pPuDU4ECdEobWmlO44jxBZ9hm0Xlh
         gPI158/J3m4M7hGaJ9D06U8MchV1J22LAEQSid/54oSsNO0noC3ZGC2kub0KXWNiQmKx
         ebkeEgoNxWhuLHHuXYhItm8B8wT6jW1GxQXUlD6ZMnKCgKHQQ+pueN3/Cf7sRDAxvhGk
         XBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fqGB09blgykRBus+afatKi1AIlVlxvUigS04ouYP6I=;
        b=KP+lH5iLaVSe/12D9VMyvKIoNvFzdvSjjZSqlQKQ7nxAN19rwsJaf1Mys9zc6jYlnB
         fRJOH+C/FyMomlCpNAkxxBn5n4RWFEAKif+PMu8G1QWynRhRDPynHGQQumuGSFcL2WMk
         dfvdZuaks2zpM9i+JX+YQf3fCI2pNe0wj+TY2DT1JDnYQ4cYkw/scNkuEyNFAarChPnT
         XEfoh/nGLdNj120ipU/3SztkeIoMNJY25CdnPGlpsJQiGbVvml10COuBllcV5921/m/O
         CLvXSJsls+PsY/UvPyQKQT5hKGAda45xjKqem2yZlDICZDvKoGRkfSa1qhfR/V5OLM0v
         WuZQ==
X-Gm-Message-State: APjAAAU9QfOTv/EXo0L/cpsgR8eWowu0K+W2sZjnSJoJr/LeQyu0+LG4
        WWOVu2fQbROgNL21iZ9xArOAwB7P
X-Google-Smtp-Source: APXvYqy5D7sJgdb5jYSE1sNf24CFH3CViAa+9KcitTtXffP7Ls27ZCuvvaMn0MgTKuAz4OEdcEbeiQ==
X-Received: by 2002:a17:902:b413:: with SMTP id x19mr994345plr.256.1551789104628;
        Tue, 05 Mar 2019 04:31:44 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id p86sm18363863pfa.104.2019.03.05.04.31.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:43 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:40 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 13/20] diff-parseopt: convert --word-diff-regex
Date:   Tue,  5 Mar 2019 19:30:19 +0700
Message-Id: <20190305123026.7266-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc1.337.gdf7f8d0522
In-Reply-To: <20190305123026.7266-1-pclouds@gmail.com>
References: <20190305123026.7266-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 14c057f3df..634981723b 100644
--- a/diff.c
+++ b/diff.c
@@ -5092,6 +5092,18 @@ static int diff_opt_word_diff(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_word_diff_regex(const struct option *opt,
+				    const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	if (options->word_diff == DIFF_WORDS_NONE)
+		options->word_diff = DIFF_WORDS_PLAIN;
+	options->word_regex = arg;
+	return 0;
+}
+
 static void prep_parse_options(struct diff_options *options)
 {
 	struct option parseopts[] = {
@@ -5257,6 +5269,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "word-diff", options, N_("<mode>"),
 			       N_("show word diff, using <mode> to delimit changed words"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_word_diff),
+		OPT_CALLBACK_F(0, "word-diff-regex", options, N_("<regex>"),
+			       N_("use <regex> to decide what a word is"),
+			       PARSE_OPT_NONEG, diff_opt_word_diff_regex),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5320,12 +5335,6 @@ int diff_opt_parse(struct diff_options *options,
 		options->use_color = 1;
 		options->word_diff = DIFF_WORDS_COLOR;
 	}
-	else if ((argcount = parse_long_opt("word-diff-regex", av, &optarg))) {
-		if (options->word_diff == DIFF_WORDS_NONE)
-			options->word_diff = DIFF_WORDS_PLAIN;
-		options->word_regex = optarg;
-		return argcount;
-	}
 	else if (!strcmp(arg, "--exit-code"))
 		options->flags.exit_with_status = 1;
 	else if (!strcmp(arg, "--quiet"))
-- 
2.21.0.rc1.337.gdf7f8d0522

