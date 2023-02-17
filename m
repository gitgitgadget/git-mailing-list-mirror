Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B719C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjBQUVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBQUVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:21:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32555FC49
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:21:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id t6-20020a7bc3c6000000b003dc57ea0dfeso1777926wmj.0
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUoQ+5Na3Y/7Nf95s0l9O6HuawoCJR3L4MSNvkV1rS8=;
        b=jF6Ze4xNfuhdcwrslFLUR5OatrJt+ZuBQ/BHOsxWw1JSQlG09XD5UWxGLX4VOKgde4
         k4NYsmm5RUJNlKIcKcVR7O8GCcOW94pQaeTYQezIZ5GHgKurkrL1fpXyh4Ba6uRd5j8Q
         sHnIQVpONee5eK7S13xnQ8b/jcjCOUSv2o5l8CAkQBHFFzBUlmtBuay19a4JLNqIaTtM
         mmOtvnRd1W9UFbaN64iJI3hYvfK7QnlxJuahDAQk/9TIHBvr+eoHHgrq6aIpM6XL7YXw
         ceOKBAThTd8gvQU0EZOOWjpDFX4T1PqPgMLBdncmFeOCNiAojSlFubIcQ9nK3Pa2fiMA
         DmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUoQ+5Na3Y/7Nf95s0l9O6HuawoCJR3L4MSNvkV1rS8=;
        b=LucUkFtTycv+Qd/MOaEtNp83auZ4cu2N5vnrZ8ok8W0Fts+BJ2QXMDbAVAHMvU5Ror
         A/lUAu91tuUQ/zdDRuJt3BG6PrlCdIUHn+vrrzvmu2MyJp3H8yj1Evqvs0r65xrqMfr+
         TiyJI298cN+XTExGcVAuWHcqaXCpNWSpuLJ3kqgI+tAgp+IIA5+8T/LRDGvBzFMo+p8n
         eRvalmwih4u2qcDxFTi09kqLhsu7r79JZlAJ4uEgq+iV+DpGXIMJYyUR9ALZJk0Pbxj4
         HCcaDV4+xl1fLV8744TK2i4G4u47snDtIzixHP+b/EdEaI1noYO8AO19Z8kxzjQJJJhu
         89Ag==
X-Gm-Message-State: AO0yUKXsIqWdpv31ysA78yeibQWhZ9b9Ar6TbFWiCmZ2nG5ibTpwzhvL
        2gG6VIMTPUgoaCzqV0mkGKQKUFbKeDg=
X-Google-Smtp-Source: AK7set+7lkKuM2zlQgJBmYwGxo4cYuomPW7JdfmOXNkB+0I2xehKB0r7Q8BfwFDKHDvFUMVApBjqCw==
X-Received: by 2002:a05:600c:180a:b0:3df:e41f:8396 with SMTP id n10-20020a05600c180a00b003dfe41f8396mr1024206wmp.37.1676665287138;
        Fri, 17 Feb 2023 12:21:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ip24-20020a05600ca69800b003e223fe0a3asm2668582wmb.27.2023.02.17.12.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:21:26 -0800 (PST)
Message-Id: <816c47aa414586e99aa762604396bd8be4fb11f4.1676665285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Feb 2023 20:21:24 +0000
Subject: [PATCH v3 1/2] diff: consolidate diff algorithm option parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

A subsequent commit will need the ability to tell if the diff algorithm
was set through the command line through setting a new member of
diff_options. While this logic can be added to the
diff_opt_diff_algorithm() callback, the `--minimal` and `--histogram`
options are handled via OPT_BIT without a callback.

Remedy this by consolidating the options parsing logic for --minimal and
--histogram into one callback. This way we can modify `diff_options` in
that function.

As an additional refactor, the logic that sets the diff algorithm in
diff_opt_diff_algorithm() can be refactored into a helper that will
allow multiple callsites to set the diff algorithm.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 diff.c | 57 +++++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 329eebf16a0..5efc22ca06b 100644
--- a/diff.c
+++ b/diff.c
@@ -3437,6 +3437,22 @@ static int diff_filepair_is_phoney(struct diff_filespec *one,
 	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
 }
 
+static int set_diff_algorithm(struct diff_options *opts,
+			      const char *alg)
+{
+	long value = parse_algorithm_value(alg);
+
+	if (value < 0)
+		return -1;
+
+	/* clear out previous settings */
+	DIFF_XDL_CLR(opts, NEED_MINIMAL);
+	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+	opts->xdl_opts |= value;
+
+	return 0;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -5107,17 +5123,28 @@ static int diff_opt_diff_algorithm(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
-	long value = parse_algorithm_value(arg);
 
 	BUG_ON_OPT_NEG(unset);
-	if (value < 0)
+
+	if (set_diff_algorithm(options, arg))
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
-	/* clear out previous settings */
-	DIFF_XDL_CLR(options, NEED_MINIMAL);
-	options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
-	options->xdl_opts |= value;
+	return 0;
+}
+
+static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	if (set_diff_algorithm(options, opt->long_name))
+		BUG("available diff algorithms include \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\"");
+
 	return 0;
 }
 
@@ -5250,7 +5277,6 @@ static int diff_opt_patience(const struct option *opt,
 
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
 	/*
 	 * Both --patience and --anchored use PATIENCE_DIFF
 	 * internally, so remove any anchors previously
@@ -5259,7 +5285,8 @@ static int diff_opt_patience(const struct option *opt,
 	for (i = 0; i < options->anchors_nr; i++)
 		free(options->anchors[i]);
 	options->anchors_nr = 0;
-	return 0;
+
+	return set_diff_algorithm(options, "patience");
 }
 
 static int diff_opt_ignore_regex(const struct option *opt,
@@ -5562,9 +5589,10 @@ struct option *add_diff_options(const struct option *opts,
 			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
 
 		OPT_GROUP(N_("Diff algorithm options")),
-		OPT_BIT(0, "minimal", &options->xdl_opts,
-			N_("produce the smallest possible diff"),
-			XDF_NEED_MINIMAL),
+		OPT_CALLBACK_F(0, "minimal", options, NULL,
+			       N_("produce the smallest possible diff"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_diff_algorithm_no_arg),
 		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
 			  N_("ignore whitespace when comparing lines"),
 			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
@@ -5590,9 +5618,10 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("generate diff using the \"patience diff\" algorithm"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       diff_opt_patience),
-		OPT_BITOP(0, "histogram", &options->xdl_opts,
-			  N_("generate diff using the \"histogram diff\" algorithm"),
-			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
+		OPT_CALLBACK_F(0, "histogram", options, NULL,
+			       N_("generate diff using the \"histogram diff\" algorithm"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_diff_algorithm_no_arg),
 		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
 			       N_("choose a diff algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
-- 
gitgitgadget

