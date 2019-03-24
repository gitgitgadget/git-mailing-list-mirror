Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AAF520248
	for <e@80x24.org>; Sun, 24 Mar 2019 08:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfCXIWP (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 04:22:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34069 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbfCXIWP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 04:22:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id v12so4373145pgq.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 01:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SyB9w5DiUlYAJ/xuAkWi2w4PhWQCA1weyTbmvD+Hnbk=;
        b=gm3Sn5GGF+zVdQEQ6N/6JYTi/4Vzl+Dhwbx1b3dgeWimIIjG9xsiwM433z7iWCYNkn
         Rw+tnJqFD37iHNjCTJxBvV7WS1gYTdKl/Moh8t/p/w3/w17KQ0ky/e9fY+sp3jAGUsKT
         m/aj82JE9hivpLKVzjLwg3tB6vIMcSwd/UHNPwffenXemC+Xq6M5v3hBI1N5YL2rM208
         eNi8OJ2OAeEGR6u27TZqB2vNXjIqw8xKlhmZ3JafNqAGVAaAzEaIrGlos0H6IKgipCD8
         ELU6rEofiC+yZ7GrjP9MtYFhlSTPoHhArItGB0z1EbnBt9qPwQeo8/DJIbarsdmC14WC
         Dfbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SyB9w5DiUlYAJ/xuAkWi2w4PhWQCA1weyTbmvD+Hnbk=;
        b=AKdxJ93fHi0npqGKYY+/SZtE7ppvKwfaudgzAMlkkta5HxQ26iKO8DHaSIePTgWUlD
         GHmeIunGVTpWzLBoOMHMkHdHPelWgV/mE7NVpBUBpMJkO3cVU7xxmpaAGS/nnW/PztM2
         h9ntnI+B04MbwreekRjkf0RSNhVHQUhj5aGBmCO+6S2KTOWSlZmPNgROKNDHO1lxB3DD
         Nub8RGRRd0wlovmn51Y4KPnE3lCsw2mLJYaAhdI0Z0/QFuYINcOSX/BV3lcn64FPWK2Z
         VVLEKlUI9Wyj6gsx3y2fr4BOsw0v0h277Juybd3a/nqKBOMXvZhdyhQRn5x63Qf7BQ7U
         RDkg==
X-Gm-Message-State: APjAAAUcsdKCEFSBmHR/1K88qZ7vIMoKr5DPJduf1SgI2aLPxkqWH/Zg
        sWArzRQ98w9bSp3g0gXM79R8xcvG
X-Google-Smtp-Source: APXvYqyRkWQQW2+LIBBER1sXZaMQ2qiiqrA65XIl47tYbwwrnML3pvakGeILM7OGA/4jDXQZKSO4kg==
X-Received: by 2002:a65:6299:: with SMTP id f25mr17773892pgv.376.1553415734394;
        Sun, 24 Mar 2019 01:22:14 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 17sm17604497pgt.0.2019.03.24.01.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 01:22:13 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 24 Mar 2019 15:22:09 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 12/20] diff-parseopt: convert --line-prefix
Date:   Sun, 24 Mar 2019 15:20:06 +0700
Message-Id: <20190324082014.2041-13-pclouds@gmail.com>
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
 diff.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 574fc511ff..e1675a32ec 100644
--- a/diff.c
+++ b/diff.c
@@ -5010,6 +5010,18 @@ static int diff_opt_ignore_submodules(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_line_prefix(const struct option *opt,
+				const char *optarg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	options->line_prefix = optarg;
+	options->line_prefix_length = strlen(options->line_prefix);
+	graph_setup_line_prefix(options);
+	return 0;
+}
+
 static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 					     const struct option *opt,
 					     const char *arg, int unset)
@@ -5261,6 +5273,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_STRING_F(0, "dst-prefix", &options->b_prefix, N_("<prefix>"),
 			     N_("show the given source prefix instead of \"b/\""),
 			     PARSE_OPT_NONEG),
+		OPT_CALLBACK_F(0, "line-prefix", options, N_("<prefix>"),
+			       N_("prepend an additional prefix to every line of output"),
+			       PARSE_OPT_NONEG, diff_opt_line_prefix),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5418,8 +5433,6 @@ int diff_opt_parse(struct diff_options *options,
 		   const char **av, int ac, const char *prefix)
 {
 	const char *arg = av[0];
-	const char *optarg;
-	int argcount;
 
 	if (!prefix)
 		prefix = "";
@@ -5455,12 +5468,6 @@ int diff_opt_parse(struct diff_options *options,
 	}
 
 	/* misc options */
-	else if ((argcount = parse_long_opt("line-prefix", av, &optarg))) {
-		options->line_prefix = optarg;
-		options->line_prefix_length = strlen(options->line_prefix);
-		graph_setup_line_prefix(options);
-		return argcount;
-	}
 	else if (!strcmp(arg, "--no-prefix"))
 		options->a_prefix = options->b_prefix = "";
 	else if (opt_arg(arg, '\0', "inter-hunk-context",
-- 
2.21.0.548.gd3c7d92dc2

