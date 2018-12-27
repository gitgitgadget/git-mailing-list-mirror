Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C269211BB
	for <e@80x24.org>; Thu, 27 Dec 2018 16:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731080AbeL0Q0I (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Dec 2018 11:26:08 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39866 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729380AbeL0Q0C (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Dec 2018 11:26:02 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so16665245ljh.6
        for <git@vger.kernel.org>; Thu, 27 Dec 2018 08:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bZHrnM16Gvmag53Ixw50qiqI8MjHL1pNMog/JTgGrTA=;
        b=LJOYroXFPgvmFfIDqGHbrvMzU9BuwCtOPeeuwZXxktPrTMvQUC4ClfCv2Jtk3b6bD3
         NLHMLbsJhoECJ2Z1Wq1qn/j3wnZJU8rHI1ApIlYcK6YRaP0Qx09IEW2K8TelPqbxpN9+
         2N7CEcTRcbbWjrE2UAm6Ui5ZB76CEOKVuofm9FMKb7/fhA6IzoADHKtsQwoaVK9W/lqk
         lXfY5+0EJo59iIe2bLWyPSsRqcBsu0mQ/uiR0UcHSM6sSRPGf95oJ65bcwuJRgL+Z6Kz
         07ek7HleeaTukRdAVLgKH/YrTn4bOPKI6nSICEQ1A6ag403YWn2s/Nu13mrEy4TUTrVT
         DQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bZHrnM16Gvmag53Ixw50qiqI8MjHL1pNMog/JTgGrTA=;
        b=MRluAU46+ejO98TLbecGGgT+UrDQGf8R/wTWVpjI2jCWNQtrFwnYaFomOUVHlEMsYj
         wti+5XHD+MD/VaVMTQeMXzYmqWMvYCBgHn6BjB49HkJYRDzud1ES+mR1DE3mxiVjWQSn
         6ZnFMYfJ3uDrzhe0rrmzPURMXEFUfvFie8evm4XuPQK02Ev7yRpYcU27m1eGlTqaZ7uK
         9T0PrhOhAq1mxLCoQse79N/eANBwWxZDXjeGtHjyktb2NsN9SvclJ3s+MwQo9o/oyISV
         zwsGXAzsLZOj7Ml3Cpwe67AN3e3XyKBgfxGay1hVXT2iEIQDLGIm0vb5jmvLgYQZ/Wft
         x2HQ==
X-Gm-Message-State: AJcUukfNkorQN5dvxYH96ugafGiqfqWvpGv8mxNteEqGaEk1KXIbo2sM
        elRubeiYUQROQC2qOkCQIWwJTJ1U
X-Google-Smtp-Source: AFSGD/WsHUk1lq+r2etzT4f3Ml8bSRpIJHxmD0ubQhRVZ0zCyp/76Od9iNyYOdF4Rooqzu2vCXe/iQ==
X-Received: by 2002:a2e:7c13:: with SMTP id x19-v6mr14278674ljc.83.1545927960224;
        Thu, 27 Dec 2018 08:26:00 -0800 (PST)
Received: from localhost.localdomain (c80-216-2-165.bredband.comhem.se. [80.216.2.165])
        by smtp.gmail.com with ESMTPSA id a127sm7643106lfe.73.2018.12.27.08.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Dec 2018 08:25:59 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 73/75] range-diff: use parse_options() instead of diff_opt_parse()
Date:   Thu, 27 Dec 2018 17:25:34 +0100
Message-Id: <20181227162536.15895-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.0.482.g66447595a7
In-Reply-To: <20181227162536.15895-1-pclouds@gmail.com>
References: <20181227162536.15895-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diff's internal option parsing is now done with 'struct option', which
makes it possible to combine all diff options to range-diff and parse
everything all at once. Parsing code becomes simpler, and we get a
looong 'git range-diff -h'

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/range-diff.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index f01a0be851..784bd19321 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -16,42 +16,27 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	int simple_color = -1;
-	struct option options[] = {
+	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
 		OPT_END()
 	};
-	int i, j, res = 0;
+	struct option *options;
+	int res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	repo_diff_setup(the_repository, &diffopt);
 
+	options = parse_options_concat(range_diff_options, diffopt.parseopts);
 	argc = parse_options(argc, argv, NULL, options,
-			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
-
-	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
-		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+			     builtin_range_diff_usage, 0);
 
-		if (!c)
-			argv[j++] = argv[i++];
-		else
-			i += c;
-	}
-	while (i < argc)
-		argv[j++] = argv[i++];
-	argc = j;
 	diff_setup_done(&diffopt);
 
-	/* Make sure that there are no unparsed options */
-	argc = parse_options(argc, argv, NULL,
-			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
-			     builtin_range_diff_usage, 0);
-
 	/* force color when --dual-color was used */
 	if (!simple_color)
 		diffopt.use_color = 1;
@@ -90,6 +75,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		error(_("need two commit ranges"));
 		usage_with_options(builtin_range_diff_usage, options);
 	}
+	FREE_AND_NULL(options);
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
 			      simple_color < 1, &diffopt);
-- 
2.20.0.482.g66447595a7

