Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 363A71F453
	for <e@80x24.org>; Thu, 17 Jan 2019 13:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbfAQNKD (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Jan 2019 08:10:03 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33331 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbfAQNKB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jan 2019 08:10:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id z11so4449153pgu.0
        for <git@vger.kernel.org>; Thu, 17 Jan 2019 05:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rn9mG0lVwHH5xiU6Y2z2jiTmEXyOHweK+MbslI34MM0=;
        b=RvZvD/J5wyOjIVDgqnnlbxe/HVC4X4Fndn4BkmlRHEQqJ846+F/hlPvxLzz3MZkzZ/
         CeO6FqsTG0e+q4EecF6oprWRqthUF7Z/jYIaRTyU/GA2GkHKXXmnPShe/SQRrXZtjSFz
         QQwYuL1WmG7s1LDrklV84KMvjb6mhsnb2dw6pOe2S1pUsiQd8lndosimwz/QSFcdSGrM
         3o2swMFIv+DWA9RgTWWXrUNJz1l+paLNDyhJtilxf6EUXvHoOwrV0lX/MFbLzxA9GXlj
         471cXmcS5cTtWr6t1/erh/Ijd95lmV5f+uEnNzzIQQHfX8kkgQ3rTcKp8r0hW0EppVCP
         wZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rn9mG0lVwHH5xiU6Y2z2jiTmEXyOHweK+MbslI34MM0=;
        b=h2+zzbv0efZdHRnQ2Jgl+qveMGzvhAqa3RdUrSb0nSfBQNf8y5IZRCoGZlj8306Pov
         fqq9c7Lx3GA2anYvPfahLl+L4V7ZOcJuZ6nmYW6l+SwS+4FyBo+WgxnVW59lHYemAY6D
         BcmLZ0IoYtO0u8Had+2iQpWecXAhyP6qwI/+Rym98OL1mRsFfT2x8Sv7Xmh7JghaYqAo
         S7hNAurMcUO+u8lPOP0Tu7uZeKTGGbPuZsNka34+Zk6d6sZfiQasBp0zz5o6okU3aaHY
         zIpoJN2/gad5lk3Oy2ZSVKM1dLnFZzF1Y9WsKKMDq75DhjPta3hl93TBFkpRfdBdvtnq
         nB8w==
X-Gm-Message-State: AJcUukfMwi242slGSbRrQRUbtzTVmyhUheGJlVDXFjK3cyQFRLz4nnIV
        t2KrnpFwy4FLK6sa4QbJQ4ejGekv
X-Google-Smtp-Source: ALg8bN6CoC0B/qe4PV/N5kU2meuNDoQbFb8PzVMFPJ2BUUf+mrcZedgVuXxHq4peUGDGm4yp/wi/2Q==
X-Received: by 2002:a62:6143:: with SMTP id v64mr14873302pfb.142.1547730600602;
        Thu, 17 Jan 2019 05:10:00 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id c4sm5683038pfm.151.2019.01.17.05.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 05:10:00 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 17 Jan 2019 20:09:56 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 42/76] diff.c: convert --binary
Date:   Thu, 17 Jan 2019 20:05:41 +0700
Message-Id: <20190117130615.18732-43-pclouds@gmail.com>
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
 Documentation/diff-options.txt |  2 +-
 diff.c                         | 21 ++++++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 4c0d40881b..08edbff503 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -425,7 +425,7 @@ endif::git-format-patch[]
 
 --binary::
 	In addition to `--full-index`, output a binary diff that
-	can be applied with `git-apply`.
+	can be applied with `git-apply`. Implies `--patch`.
 
 --abbrev[=<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/diff.c b/diff.c
index bee36fb276..0e93025af4 100644
--- a/diff.c
+++ b/diff.c
@@ -4855,6 +4855,18 @@ static int diff_opt_anchored(const struct option *opt,
 	return 0;
 }
 
+static int diff_opt_binary(const struct option *opt,
+			   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	enable_patch_output(&options->output_format);
+	options->flags.binary = 1;
+	return 0;
+}
+
 static int diff_opt_break_rewrites(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -5120,6 +5132,9 @@ static void prep_parse_options(struct diff_options *options)
 		OPT_CALLBACK_F(0, "compact-summary", options, NULL,
 			       N_("generate compact summary in diffstat"),
 			       PARSE_OPT_NOARG, diff_opt_compact_summary),
+		OPT_CALLBACK_F(0, "binary", options, NULL,
+			       N_("output a binary diff that can be applied"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_binary),
 		OPT_CALLBACK_F(0, "output-indicator-new",
 			       &options->output_indicators[OUTPUT_INDICATOR_NEW],
 			       N_("<char>"),
@@ -5233,11 +5248,7 @@ int diff_opt_parse(struct diff_options *options,
 		return ac;
 
 	/* flags options */
-	if (!strcmp(arg, "--binary")) {
-		enable_patch_output(&options->output_format);
-		options->flags.binary = 1;
-	}
-	else if (!strcmp(arg, "--full-index"))
+	if (!strcmp(arg, "--full-index"))
 		options->flags.full_index = 1;
 	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
 		options->flags.text = 1;
-- 
2.20.0.482.g66447595a7

