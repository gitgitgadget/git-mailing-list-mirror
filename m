Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD11720248
	for <e@80x24.org>; Wed, 20 Mar 2019 11:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbfCTLsX (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 07:48:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44611 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbfCTLsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 07:48:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id i2so1612845pgj.11
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 04:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEdc+TLMQta/9G9RdwgLqc6bxNNB5pITbowTKdj97y0=;
        b=QGCCaT2LgJo2Ht/x8VhyFq44pM2NMYecFtp/I8qF0cuHsMxa+YneBQxHXUtJynRzGi
         A+fPny6c88DrRVFD0y/0/I9cnv441SNtyp/ByXy0L1xoRiiviXWhuH8lEOJ+uFVTyiVG
         6KiYl4G7F97lvpmpdgsm/rdYLnf7IB9BGX28tI7lCsCNJnwsynw+hSZ0/uITZZE4cWGv
         RL1YYKBjvLZSeqb6LQzEYoMtriSw0mnZlHZE4gUXDknqNepGD8QATskFg/eG+cEP2zfi
         7Sc/k7OnaQDMNg6vwTht2PsZghwN+7w+pXrhU1efxzWSuGce+PiQaQXvSWAT0DSrapQu
         wDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEdc+TLMQta/9G9RdwgLqc6bxNNB5pITbowTKdj97y0=;
        b=uBwMyHAztSE21eir0GYpslr3lqqEqDtaAiNhvFXRllYY/orsQH6sCqcIFyPgEwD+vh
         /9VQnDnUuyEKQV+RdJhZK0AOdOSlBatA54XdFuvRbPzYSwb72cWmOIevGJl6wsKyQopB
         kZYzWqdsQQ1sRagRWwIaFc3Mr7UD3juRe9yax25J/81rasfxKGpwVljOa/lg70xQnv84
         AX9QAfO/JqBIG5oldhhdfFPJROxNYQjZ7eg0tbaiFRjC5WYah4xs94qXakdxR10CxEnX
         X/SWAY0bxeCIevl6og1/hgjJZNlEmeVDJLfiy7PXvUfNnhmEQTsSvqVHb6zZKViJC/DR
         /WtQ==
X-Gm-Message-State: APjAAAV9I8JSnXSfxV9TWcej+rBWdgYmmMrLnJPiGL5cD0In7fgl2MeT
        GK3pkRaMkD8o3C8UJUcmfaNLcKi4
X-Google-Smtp-Source: APXvYqyAHb/qCgNJFx7q7A0SPV0XTxqHflTFh8atE5UckaoQhwYySlPU9EoiqASQH/SNWKIojZl/fw==
X-Received: by 2002:aa7:9397:: with SMTP id t23mr1019424pfe.238.1553082502943;
        Wed, 20 Mar 2019 04:48:22 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 185sm2612925pfd.128.2019.03.20.04.48.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 04:48:22 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 20 Mar 2019 18:48:18 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 15/20] diff-parseopt: convert --[no-]color-moved
Date:   Wed, 20 Mar 2019 18:46:58 +0700
Message-Id: <20190320114703.18659-16-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190320114703.18659-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mark one more string for translation while at there

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index e2f515a7da..df4303de4e 100644
--- a/diff.c
+++ b/diff.c
@@ -4841,6 +4841,27 @@ static int diff_opt_char(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_moved(const struct option *opt,
+				const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	if (unset) {
+		options->color_moved = COLOR_MOVED_NO;
+	} else if (!arg) {
+		if (diff_color_moved_default)
+			options->color_moved = diff_color_moved_default;
+		if (options->color_moved == COLOR_MOVED_NO)
+			options->color_moved = COLOR_MOVED_DEFAULT;
+	} else {
+		int cm = parse_color_moved(arg);
+		if (cm < 0)
+			return error(_("bad --color-moved argument: %s"), arg);
+		options->color_moved = cm;
+	}
+	return 0;
+}
+
 static int diff_opt_color_words(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5339,6 +5360,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "color-words", options, N_("<regex>"),
 			       N_("equivalent to --word-diff=color --word-diff-regex=<regex>"),
 			       PARSE_OPT_NONEG | PARSE_OPT_OPTARG, diff_opt_color_words),
+		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
+			       N_("move lines of code are colored differently"),
+			       PARSE_OPT_OPTARG, diff_opt_color_moved),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5422,19 +5446,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--color-moved")) {
-		if (diff_color_moved_default)
-			options->color_moved = diff_color_moved_default;
-		if (options->color_moved == COLOR_MOVED_NO)
-			options->color_moved = COLOR_MOVED_DEFAULT;
-	} else if (!strcmp(arg, "--no-color-moved"))
-		options->color_moved = COLOR_MOVED_NO;
-	else if (skip_prefix(arg, "--color-moved=", &arg)) {
-		int cm = parse_color_moved(arg);
-		if (cm < 0)
-			return error("bad --color-moved argument: %s", arg);
-		options->color_moved = cm;
-	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
+	if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
 		unsigned cm = parse_color_moved_ws(arg);
 		if (cm & COLOR_MOVED_WS_ERROR)
 			return -1;
-- 
2.21.0.548.gd3c7d92dc2

