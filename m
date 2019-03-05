Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98CED20248
	for <e@80x24.org>; Tue,  5 Mar 2019 12:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfCEMbu (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 07:31:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728152AbfCEMbu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 07:31:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id i130so5555170pgd.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2019 04:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7Wf4mhH2fN8+p7lgC0SrE13HSzAkaGlM9HOnmyKJ/pQ=;
        b=vTos16W1r5E8RoXaD12QiD8yEFH9KosvgAoNMtlsCAKvKu+qFu1+6J8MMQdmYSA7te
         2wk4LOULMVm6EE4oX9AATh3qCAUSDboPP0xzb0YGIoTa+ny0Qg2tQl42g8YkbHU4o2TI
         G2N9zQwf468pv1vrCOZ9MJIcQoY3epmVfYQ11qnWD0p30Q9LaaLOoSzU4SX9I3Tug3BL
         oD+pU1hfrQhfsXXbnHZSUOA4Yvc7DMBmlknBj5T9mIcuA7VXk0JhkJMPLWHUYfmt1MW6
         A9miAT0ljXsTbyd87yhIiM+FbOojuWsFsWumCstDBCFgoSaLH7cC1mQxkgCaYvmw8+3s
         vfKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7Wf4mhH2fN8+p7lgC0SrE13HSzAkaGlM9HOnmyKJ/pQ=;
        b=iSg1HoU8O0dD8xOm65WHmG8/v6QTXpW4i17BdQ6eOE1yVbN9bZsKCeGAY0ThHzWUwF
         DEQwxuT0d4zWmPirgRqi7q2MVKbahYGse7M5bXMyauCV/kGm+LSFw8amAAidc+y3tOiZ
         Eij1lAkN/+zHuXjoCqajZ95u4ZeT3itgdnvkMJxj1anf3E2p9M/InlPkCX97sSTT5fuG
         dFDWDx8AwqhxKovLez290hA8TXXjQ/pAQ9IkP/bS0BhpLcb9RRhIaMZWIbrv8iW9s4+/
         Umbaho4GZDAFGp71Oxe+SD/MnahjyhuSfnsLZICbKYC0NlJqYIFc0SfLSVU0PHe+O4H2
         0N6Q==
X-Gm-Message-State: APjAAAX2P6FjzWn7TOkI0sXjyjnfaZpKJ4yPlpopaZDyyA/Ntx7YzE4N
        hjWcSwSOvn3P4CUXrzRx+LyE734y
X-Google-Smtp-Source: APXvYqxnmjXK97rWtJcrHXEbuiDvGZykdPfCd92xT+JtiprimmrSHgpmqC+wnVNMN29zaFDkzT59bg==
X-Received: by 2002:a17:902:8217:: with SMTP id x23mr1004679pln.332.1551789109192;
        Tue, 05 Mar 2019 04:31:49 -0800 (PST)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id h63sm22160473pfd.148.2019.03.05.04.31.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Mar 2019 04:31:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 05 Mar 2019 19:31:44 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 14/20] diff-parseopt: convert --color-words
Date:   Tue,  5 Mar 2019 19:30:20 +0700
Message-Id: <20190305123026.7266-15-pclouds@gmail.com>
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
 diff.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 634981723b..5180c2f5a9 100644
--- a/diff.c
+++ b/diff.c
@@ -4901,6 +4901,18 @@ static int diff_opt_char(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_words(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->use_color = 1;
+	options->word_diff = DIFF_WORDS_COLOR;
+	options->word_regex = arg;
+	return 0;
+}
+
 static int diff_opt_compact_summary(const struct option *opt,
 				    const char *arg, int unset)
 {
@@ -5272,6 +5284,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "word-diff-regex", options, N_("<regex>"),
 			       N_("use <regex> to decide what a word is"),
 			       PARSE_OPT_NONEG, diff_opt_word_diff_regex),
+		OPT_CALLBACK_F(0, "color-words", options, N_("<regex>"),
+			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
+			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5331,11 +5346,7 @@ int diff_opt_parse(struct diff_options *options,
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
 		options->color_moved_ws_handling = cm;
-	} else if (skip_to_optional_arg_default(arg, "--color-words", &options->word_regex, NULL)) {
-		options->use_color = 1;
-		options->word_diff = DIFF_WORDS_COLOR;
-	}
-	else if (!strcmp(arg, "--exit-code"))
+	} else if (!strcmp(arg, "--exit-code"))
 		options->flags.exit_with_status = 1;
 	else if (!strcmp(arg, "--quiet"))
 		options->flags.quick = 1;
-- 
2.21.0.rc1.337.gdf7f8d0522

