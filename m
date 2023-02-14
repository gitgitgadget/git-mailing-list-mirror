Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B79BC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjBNVkj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:40:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjBNVke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:40:34 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021632943A
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:24 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a2so17187333wrd.6
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHSruV1/LrYZ1piYSzOvRpovFm29NEa57/Dw90cROe0=;
        b=EtOwqHGrMMwBdeFvOZKfPJ06NjcVo6zYs1uuh1yQm4pta071JR8Y4fjxgz/F3n+4zs
         ZariiIVj4HpYOlhV4jDzJys9X6Fkxlbkj86JA3HLM31j5TDGwoAmG+ZkgQQTVuY4prTa
         mGmvMkAj4Zio7yks//3/o8h2P/ZgBPocuODJFoJ4rBIv+ls4CvxWFrUeL0BncA7O7BTO
         eMkRwtfV9op6RFpLKKJUQQqeFhy1ZvR6rg7uSOXjAgEgf04F3XJkbYiLQbhmlSxfzAdi
         XLXimKZHfOG+DzYKlhjTnE8jbo1BucKFBas3237XrqdhFQ19yp7PGeO804IhB+hw410V
         jgeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHSruV1/LrYZ1piYSzOvRpovFm29NEa57/Dw90cROe0=;
        b=pyACihe/ntzuR/J8+7rvOpQ+TVdkCkGHJYEjTYDPjeNEoBSAZnTAhmHEaPLI0zcno5
         HKR8iOrT8wP4tpglzAXlJXFS/mz2mcMCdpfv3SEKiolRpGAW8Q3PlcRJ5O3zCToYvLip
         MwtoI3/PbDaxfz9N5gL5OUCe7NKX2L0gnx4kUDFwPqgOQNwkZkw3PuLfjjYm+KTN5MRN
         ZCYJ5gr526TkKFj0KODKr5vhhd09n3Kti1FBJFScLEZ7kzm234WMYPXrzL90HglSudxK
         /lH34BaozthYHfRtqC2io2zcmqCPG9pItH+CPLTvIP5obRiGoQw0cCA3PfPkkCfC7+iC
         Tl8g==
X-Gm-Message-State: AO0yUKWeNg0ivGai1E0KKzGJZTMpjuhOM3MtJZnEl4pYlNrLmZTw5T8H
        Xx2g8QwPO7VfnT2rAsXZPI6M74UDivQ=
X-Google-Smtp-Source: AK7set//Kw+0zUasyT7hPapGOPSiu3XEgwY223iFp2x1Yv0xTNhJfQio5IzZj4m8pYToz7bXx6ICgA==
X-Received: by 2002:adf:e686:0:b0:2c5:4dbb:678d with SMTP id r6-20020adfe686000000b002c54dbb678dmr2986688wrm.40.1676410822191;
        Tue, 14 Feb 2023 13:40:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d58e6000000b002c54c7153f0sm11072075wrd.1.2023.02.14.13.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:40:21 -0800 (PST)
Message-Id: <cb0305631496eb4c2d51e5b586ac0ca8580c7dc1.1676410819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
        <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Feb 2023 21:40:19 +0000
Subject: [PATCH v2 2/2] diff: teach diff to read gitattribute diff-algorithm
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

It can be useful to specify diff algorithms per file type. For example,
one may want to use the minimal diff algorithm for .json files, another
for .c files, etc.

Teach the diff machinery to check attributes for a diff driver. Also
teach the diff driver parser a new type "algorithm" to look for in the
config, which will be used if a driver has been specified through the
attributes.

Enforce precedence of diff algorithm by favoring the command line option,
then looking at the driver attributes & config combination, then finally
the diff.algorithm config.

To enforce precedence order, use the `xdl_opts_command_line` member
during options pasing to indicate the diff algorithm was set via command
line args.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/gitattributes.txt | 41 ++++++++++++++++++++++++++++++++-
 diff.c                          | 25 +++++++++++++-------
 diff.h                          |  2 ++
 t/lib-diff-alternative.sh       | 38 +++++++++++++++++++++++++++++-
 userdiff.c                      |  4 +++-
 userdiff.h                      |  1 +
 6 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c19e64ea0ef..7e69f509d0a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -736,7 +736,6 @@ String::
 	by the configuration variables in the "diff.foo" section of the
 	Git config file.
 
-
 Defining an external diff driver
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
@@ -758,6 +757,46 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+Setting the internal diff algorithm
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The diff algorithm can be set through the `diff.algorithm` config key, but
+sometimes it may be helpful to set the diff algorithm by path. For example, one
+might wish to set a diff algorithm automatically for all `.json` files such that
+the user would not need to pass in a separate command line `--diff-algorithm` flag each
+time.
+
+First, in `.gitattributes`, you would assign the `diff` attribute for paths.
+
+*Git attributes*
+------------------------
+*.json diff=<name>
+------------------------
+
+Then, you would define a "diff.<name>.algorithm" configuration to specify the
+diff algorithm, choosing from `meyers`, `patience`, `minimal`, and `histogram`.
+
+*Git config*
+
+----------------------------------------------------------------
+[diff "<name>"]
+  algorithm = histogram
+----------------------------------------------------------------
+
+This diff algorithm applies to git-diff(1), including the `--stat` output.
+
+NOTE: If the `command` key also exists, then Git will treat this as an external
+diff and attempt to use the value set for `command` as an external program. For
+instance, the following config, combined with the above `.gitattributes` file,
+will result in `command` favored over `algorithm`.
+
+*Git config*
+
+----------------------------------------------------------------
+[diff "<name>"]
+  command = j-c-diff
+  algorithm = histogram
+----------------------------------------------------------------
 
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/diff.c b/diff.c
index 92a0eab942e..24da439e56f 100644
--- a/diff.c
+++ b/diff.c
@@ -4456,15 +4456,11 @@ static void run_diff_cmd(const char *pgm,
 	const char *xfrm_msg = NULL;
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
 	int must_show_header = 0;
+	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, attr_path);
 
-
-	if (o->flags.allow_external) {
-		struct userdiff_driver *drv;
-
-		drv = userdiff_find_by_path(o->repo->index, attr_path);
+	if (o->flags.allow_external)
 		if (drv && drv->external)
 			pgm = drv->external;
-	}
 
 	if (msg) {
 		/*
@@ -4481,12 +4477,17 @@ static void run_diff_cmd(const char *pgm,
 		run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
 		return;
 	}
-	if (one && two)
+	if (one && two) {
+		if (!o->xdl_opts_command_line)
+			if (drv && drv->algorithm)
+				set_diff_algorithm(o, drv->algorithm);
+
 		builtin_diff(name, other ? other : name,
 			     one, two, xfrm_msg, must_show_header,
 			     o, complete_rewrite);
-	else
+	} else {
 		fprintf(o->file, "* Unmerged path %s\n", name);
+	}
 }
 
 static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
@@ -4583,6 +4584,10 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	const char *name;
 	const char *other;
 
+	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
+	if (drv && drv->algorithm)
+		set_diff_algorithm(o, drv->algorithm);
+
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
 		builtin_diffstat(p->one->path, NULL, NULL, NULL,
@@ -5130,6 +5135,8 @@ static int diff_opt_diff_algorithm(const struct option *opt,
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
+	options->xdl_opts_command_line = 1;
+
 	return 0;
 }
 
@@ -5157,6 +5164,8 @@ static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
 		BUG("available diff algorithms include \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\"");
 
+	options->xdl_opts_command_line = 1;
+
 	return 0;
 }
 
diff --git a/diff.h b/diff.h
index 41eb2c3d428..46b565abfd4 100644
--- a/diff.h
+++ b/diff.h
@@ -333,6 +333,8 @@ struct diff_options {
 	int prefix_length;
 	const char *stat_sep;
 	int xdl_opts;
+	/* If xdl_opts has been set via the command line. */
+	int xdl_opts_command_line;
 
 	/* see Documentation/diff-options.txt */
 	char **anchors;
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 8d1e408bb58..2dc02bca873 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -105,10 +105,46 @@ index $file1..$file2 100644
  }
 EOF
 
+	cat >expect_diffstat <<EOF
+ file1 => file2 | 21 ++++++++++-----------
+ 1 file changed, 10 insertions(+), 11 deletions(-)
+EOF
+
 	STRATEGY=$1
 
+	test_expect_success "$STRATEGY diff from attributes" '
+		echo "file* diff=driver" >.gitattributes &&
+		git config diff.driver.algorithm "$STRATEGY" &&
+		test_must_fail git diff --no-index file1 file2 > output &&
+		cat expect &&
+		cat output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
+		echo "file* diff=driver" >.gitattributes &&
+		git config diff.driver.algorithm "$STRATEGY" &&
+		test_must_fail git diff --stat --no-index file1 file2 > output &&
+		test_cmp expect_diffstat output
+	'
+
 	test_expect_success "$STRATEGY diff" '
-		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
+		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "$STRATEGY diff command line precedence before attributes" '
+		echo "file* diff=driver" >.gitattributes &&
+		git config diff.driver.algorithm meyers &&
+		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "$STRATEGY diff attributes precedence before config" '
+		git config diff.algorithm default &&
+		echo "file* diff=driver" >.gitattributes &&
+		git config diff.driver.algorithm "$STRATEGY" &&
+		test_must_fail git diff --no-index file1 file2 > output &&
 		test_cmp expect output
 	'
 
diff --git a/userdiff.c b/userdiff.c
index d71b82feb74..ff25cfc4b4c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -293,7 +293,7 @@ PATTERNS("scheme",
 	 "|([^][)(}{[ \t])+"),
 PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
 	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
-{ "default", NULL, -1, { NULL, 0 } },
+{ "default", NULL, NULL, -1, { NULL, 0 } },
 };
 #undef PATTERNS
 #undef IPATTERN
@@ -394,6 +394,8 @@ int userdiff_config(const char *k, const char *v)
 		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
 		return git_config_string(&drv->word_regex, k, v);
+	if (!strcmp(type, "algorithm"))
+		return git_config_string(&drv->algorithm, k, v);
 
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index aee91bc77e6..24419db6973 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -14,6 +14,7 @@ struct userdiff_funcname {
 struct userdiff_driver {
 	const char *name;
 	const char *external;
+	const char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
 	const char *word_regex;
-- 
gitgitgadget
