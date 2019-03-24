Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46D6120248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbfCXIWg (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:36 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34539 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfCXIWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so2921199pfd.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCGsr2ZQ6uQ8MBfgTTePhHiE9iA2BhAP7Fwp0I89j2g=;
        b=lSfBL96BeMXM6kaSJH1HdbrCQY3oH88eVJ6gEfjH+tpdgwCQLaSoUO0qw/yDSiUB+t
         9PVIS7uMTjuEwM2GuxJ27EQyyWrlYG75NTxPwtceAYwnYeAXVuB3eXsFemWrI3RbL/yw
         AB4AQffIJTRLv0qlcGb0ahfvJnrCU0NiLtviHknpv4IP8ZNVSAKGVdyRCcfCYQCVmLhU
         VZ6c1CCWshvMQrKmpR0E72tKN5036SV/Gry88h4Jzet1fGd9FDkj32Y44a9CbriD8i58
         TnJiANsx7KhF4DyY2vr75hkjmSscyNT5MSCL8EYCMAo0cbtbdHjTdJjsATAiPHTlPUzs
         e1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCGsr2ZQ6uQ8MBfgTTePhHiE9iA2BhAP7Fwp0I89j2g=;
        b=rZDGFF3L/S5HzTL1jq3LUuG/zX6aAHeG+orvgyKC0qy9LeAJ/BU+rEFnAk8vHtau8G
         kw9bvWLedNRNfA03hpOxL1RLPt3ebL2PjoctjdqfW/clq1RPoWwmVtY6zxJJNrq65bVx
         vnqce94ebk3ApzpYUsPxppxPCPynv7NVWL5UmugUdP3ybLoIh0l6gA4juozyp634eRvq
         OnHl6+dVCr0QpVaHcaAdxtvsD9HzgGpQoN6tA7fWYcAivyfLFGjJbucwDSpRkAnnAHfN
         gt9Kcg04YmWOgjLiaVqQ15xA0dgmdKFZ0XGx9MorxSOnPM34u6KI/cuKTUiD0FH4Gju0
         lQsw==
X-Gm-Message-State: APjAAAUH2ccVevRGDsjwaiZLugEEK63xtsIeJ+c8vS+sC0wJURPCu5XC
        elzrc2EK0c+Sz2JKLfk4sS0zMYCI
X-Google-Smtp-Source: APXvYqwa4je8xwnxTZuQEdCIg0kqBt8eLJDLbm9mq8K2FGhU1Or5Tg/BWUGFZDttZoYvMSFSUSSQ5g==
X-Received: by 2002:a65:628f:: with SMTP id f15mr17802327pgv.410.1553415755543;
        Sun, 24 Mar 2019 01:22:35 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id l7sm41068169pfj.162.2019.03.24.01.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:34 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 16/20] diff-parseopt: convert --color-moved-ws
Date:   Sun, 24 Mar 2019 15:20:10 +0700
Message-Id: <20190324082014.2041-17-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190324082014.2041-1-pclouds@gmail.com>
References: <20190320114703.18659-1-pclouds@gmail.com>
 <20190324082014.2041-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 diff.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/diff.c b/diff.c
index de6c09e95a..1a24bbfb69 100644
--- a/diff.c
+++ b/diff.c
@@ -4862,6 +4862,20 @@ static int diff_opt_color_moved(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_color_moved_ws(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+	unsigned cm;
+
+	BUG_ON_OPT_NEG(unset);
+	cm = parse_color_moved_ws(arg);
+	if (cm & COLOR_MOVED_WS_ERROR)
+		return error(_("invalid mode '%s' in --color-moved-ws"), arg);
+	options->color_moved_ws_handling = cm;
+	return 0;
+}
+
 static int diff_opt_color_words(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -5363,6 +5377,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "color-moved", options, N_("<mode>"),
 			       N_("move lines of code are colored differently"),
 			       PARSE_OPT_OPTARG, diff_opt_color_moved),
+		OPT_CALLBACK_F(0, "color-moved-ws", options, N_("<mode>"),
+			       N_("how white spaces are ignored in --color-moved"),
+			       PARSE_OPT_NONEG, diff_opt_color_moved_ws),
 
 		OPT_GROUP(N_("Diff other options")),
 		OPT_CALLBACK_F(0, "relative", options, N_("<prefix>"),
@@ -5430,8 +5447,6 @@ static void prep_parse_options(struct diff_options *options)
 int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
-	const char *arg = av[0];
-
 	if (!prefix)
 		prefix = "";
 
@@ -5442,21 +5457,7 @@ int diff_opt_parse(struct diff_options *options,
 			   PARSE_OPT_ONE_SHOT |
 			   PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (ac)
-		return ac;
-
-	/* flags options */
-	if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
-		unsigned cm = parse_color_moved_ws(arg);
-		if (cm & COLOR_MOVED_WS_ERROR)
-			return -1;
-		options->color_moved_ws_handling = cm;
-	}
-
-	/* misc options */
-	else
-		return 0;
-	return 1;
+	return ac;
 }
 
 int parse_rename_score(const char **cp_p)
-- 
2.21.0.548.gd3c7d92dc2

