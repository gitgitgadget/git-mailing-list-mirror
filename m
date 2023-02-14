Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5B2C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjBNVka (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232761AbjBNVk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:40:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E98D30193
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:23 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id l2so553036wry.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zC9Lz3W+wPjIoeflnVod6IDOM/pZtd24CxLkiuJf1aM=;
        b=j9bs/Zh4UNtanh6g4gxT1/NqUrafUD/aan/9UM/4rCNTYacroVc/akRJUuZTmP8V/O
         Ee5/2+pZuxjCwLHfQ3RLT6XMfBW3TCT70E8/8J1pw405Zu+NqEXrWfLL6faagWs95jK9
         DFjxam5WPuheSG/yvxUOshGjD+6b9MvGN9PzFbGuv7XOEjW/4be2tdF0tQNdyn49J9lC
         iU4AX9REzYdgkE7uT50mVp+QlFXo0X276mNVAwlLuBJFBUm/3fZsHKqx/XCEH4LtiV3D
         hBIIEp0piq+y6U0BalqKTZ0FHYzApCVRhD836sGSxvYW+Pg5hQ7kpPWSb5B80CiqPLad
         fSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zC9Lz3W+wPjIoeflnVod6IDOM/pZtd24CxLkiuJf1aM=;
        b=MDa0DKaJakjMyEWykZaaaL8ZELt9z3pRR2nKUSLdGR8KtBt801VeQuSetAnaMDFJ/4
         5JUJIR0nFgzsm5iMBmeQVT2H5IPrPCR174oiTeB84S1f4UV/sGLM7dBrtWHbfoy0mRFq
         0i7YKAnF17gcjkd0ZxC1OmHPgbsOWFb6o822gfn9IbhBmC/mN6m0aWr8OWUpnOg8ORPu
         w6rvYLK9EMEgS+TPvk4kQzQ+iiMp0pR/CF9gwufZEfzjn4qJXJoDavjhBhcBwCaP+weW
         d67Xv0PyOaQ2hfP2N0bdIYnThY7wZSehs+zfzBlrEZ1P6trVH6Gb1/J05wUqfLMMzpIO
         ZlGA==
X-Gm-Message-State: AO0yUKWfjItyirp9h6qHqt3DlH4W5BLwFUW/VZLiTIXgJ9cOcF1tGYUA
        dDvYKSwZLz3d+oRExR0oLCAjLOOoQ9c=
X-Google-Smtp-Source: AK7set9HpCSNSl26tfPzvRACNgtu7oh8m6yl7uEpBQQiQeiZH66QXai/d2yS6PwGGFa6pfXZNKR14g==
X-Received: by 2002:a5d:5345:0:b0:2c5:5bc0:e7b1 with SMTP id t5-20020a5d5345000000b002c55bc0e7b1mr2985512wrv.1.1676410821459;
        Tue, 14 Feb 2023 13:40:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c218c00b003de8a1b06c0sm82782wme.7.2023.02.14.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:40:21 -0800 (PST)
Message-Id: <0c5e1fc6c2651e39bcefa27ee0976c9519671969.1676410819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Feb 2023 21:40:18 +0000
Subject: [PATCH v2 1/2] diff: consolidate diff algorithm option parsing
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

The diff option parsing for --minimal, --patience, --histgoram can all
be consolidated into one function. This is a preparatory step for the
subsequent commit which teaches diff to keep track of whether or not a
diff algorithm has been set via the command line.

Additionally, the logic that sets the diff algorithm in
diff_opt_diff_algorithm() can  be refactored into a helper that will
allow multiple callsites to set the diff algorithm.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 diff.c | 87 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 329eebf16a0..92a0eab942e 100644
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
+		return 1;
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
@@ -5107,17 +5123,40 @@ static int diff_opt_diff_algorithm(const struct option *opt,
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
+	if (!strcmp(opt->long_name, "patience")) {
+		size_t i;
+		/*
+		 * Both --patience and --anchored use PATIENCE_DIFF
+		 * internally, so remove any anchors previously
+		 * specified.
+		 */
+		for (i = 0; i < options->anchors_nr; i++)
+			free(options->anchors[i]);
+		options->anchors_nr = 0;
+	}
+
+	if (set_diff_algorithm(options, opt->long_name))
+		BUG("available diff algorithms include \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\"");
+
 	return 0;
 }
 
@@ -5242,26 +5281,6 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
-static int diff_opt_patience(const struct option *opt,
-			     const char *arg, int unset)
-{
-	struct diff_options *options = opt->value;
-	int i;
-
-	BUG_ON_OPT_NEG(unset);
-	BUG_ON_OPT_ARG(arg);
-	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-	/*
-	 * Both --patience and --anchored use PATIENCE_DIFF
-	 * internally, so remove any anchors previously
-	 * specified.
-	 */
-	for (i = 0; i < options->anchors_nr; i++)
-		free(options->anchors[i]);
-	options->anchors_nr = 0;
-	return 0;
-}
-
 static int diff_opt_ignore_regex(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -5562,9 +5581,10 @@ struct option *add_diff_options(const struct option *opts,
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
@@ -5589,10 +5609,11 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "patience", options, NULL,
 			       N_("generate diff using the \"patience diff\" algorithm"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			       diff_opt_patience),
-		OPT_BITOP(0, "histogram", &options->xdl_opts,
-			  N_("generate diff using the \"histogram diff\" algorithm"),
-			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
+			       diff_opt_diff_algorithm_no_arg),
+		OPT_CALLBACK_F(0, "histogram", options, NULL,
+			       N_("generate diff using the \"histogram diff\" algorithm"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_diff_algorithm_no_arg),
 		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
 			       N_("choose a diff algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
-- 
gitgitgadget

