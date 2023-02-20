Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE5DC6379F
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 21:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjBTVEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 16:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjBTVEu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 16:04:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF84CA0E
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:04:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p3-20020a05600c358300b003e206711347so1747194wmq.0
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 13:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6nwgUMSQjMP+td8+6pnC+G87kTNkBgdRShmjgjcdTs=;
        b=NUeLHg3JvHR81oqD1upc2eVRYpnd6zcBXd/xSKbRRM5Lk9+hkKNiWbwdkgU/0U77kd
         K3Ob4+Cbi2UrJ7Fk5fDnWGyXsBmuWEVLlE1hDZDr98ZAem66XR98xVBpuSfyvhUEKKPb
         nELc+nhUaKNIVfvvPT8oDsgfnivNMAQUQo10be7bhfR4z+CN1zvLy08GTrq7wK1qKTNV
         5pvTJHCUgvApvYzvsfu/r28axoXxpAqXnLXKly7j0swwcnabqd24K8755DboT6hL1R9Q
         7Xn9bTjaACajumrJl35fYGNbwZ7E/gQ9zfrAQmDezegUN47nx+4Htb7zCBYda2t0zoDy
         n10g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v6nwgUMSQjMP+td8+6pnC+G87kTNkBgdRShmjgjcdTs=;
        b=S7KklQF7E3TyHsqHSQhwccNjJmqpwlplovuxTVmEiM6Qg079WOgsUOoCPNP/dlrxEM
         cxuf/HYc4z0NjNUlU2gynwyGzTYofCvy17eZy9dQJ4gBn9hZ+VV4xi3SeWc05mYnWd9T
         MIGAIopb+ReqD8QbdaVEajhKY//NLZZ8mN6kEFRjMkRU+sUczk2sa0LJNRmXo5HYkHml
         mc6Cj8xedEmNhg/YQ3rJcFNfo5ZcRKBjo3Vc7inho30gZdWoi8yVz+tmPxxzsrdie7ON
         f9DOZNMxkrFTrtLQgJW9+6eYKnsv6Qhk5pfjCIs/9oJqybPBfiMjWixVvfSjEIeura5G
         QkRA==
X-Gm-Message-State: AO0yUKVCItGCQmZQB4AwnxcSXUirkb0cldQU1kMiQrVyqR+CUHKbiuXL
        ybB8yaKivutGYs6nm2+PQX3Dqtl8nWM=
X-Google-Smtp-Source: AK7set+6QSGdysxgyXUNNBPi091jw8Vv9fjQ+NB5Li4XkYk7mpVWfoJI+yCquDKCvz7o/+ZEi2o+MQ==
X-Received: by 2002:a05:600c:43c9:b0:3dc:58a2:3900 with SMTP id f9-20020a05600c43c900b003dc58a23900mr6516111wmn.29.1676927086151;
        Mon, 20 Feb 2023 13:04:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2-20020a7bc442000000b003e1f319b87bsm1101508wmi.24.2023.02.20.13.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 13:04:45 -0800 (PST)
Message-Id: <77e66ab98fc53d8089a53f537427b5cf74b9ed2c.1676927082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com>
References: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
        <pull.1452.v4.git.git.1676927082.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Feb 2023 21:04:42 +0000
Subject: [PATCH v4 2/2] diff: teach diff to read algorithm from diff driver
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

The diff machinery already checks attributes for a diff driver. Teach
the diff driver parser a new type "algorithm" to look for in the
config, which will be used if a driver has been specified through the
attributes.

Enforce precedence of the diff algorithm by favoring the command line
option, then looking at the driver attributes & config combination, then
finally the diff.algorithm config.

To enforce precedence order, use a new `ignore_driver_algorithm` member
during options parsing to indicate the diff algorithm was set via command
line args.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/gitattributes.txt | 31 +++++++++++++++++++++++++++
 diff.c                          | 33 ++++++++++++++++++++--------
 diff.h                          |  1 +
 t/lib-diff-alternative.sh       | 38 ++++++++++++++++++++++++++++++++-
 userdiff.c                      |  4 +++-
 userdiff.h                      |  1 +
 6 files changed, 97 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c19e64ea0ef..39bfbca1ffe 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -758,6 +758,37 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+Setting the internal diff algorithm
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The diff algorithm can be set through the `diff.algorithm` config key, but
+sometimes it may be helpful to set the diff algorithm per path. For example,
+one may want to use the `minimal` diff algorithm for .json files, and the
+`histogram` for .c files, and so on without having to pass in the algorithm
+through the command line each time.
+
+First, in `.gitattributes`, assign the `diff` attribute for paths.
+
+------------------------
+*.json diff=<name>
+------------------------
+
+Then, define a "diff.<name>.algorithm" configuration to specify the diff
+algorithm, choosing from `myers`, `patience`, `minimal`, or `histogram`.
+
+----------------------------------------------------------------
+[diff "<name>"]
+  algorithm = histogram
+----------------------------------------------------------------
+
+This diff algorithm applies to user facing diff output like git-diff(1),
+git-show(1) and is used for the `--stat` output as well. The merge machinery
+will not use the diff algorithm set through this method.
+
+NOTE: If `diff.<name>.command` is defined for path with the
+`diff=<name>` attribute, it is executed as an external diff driver
+(see above), and adding `diff.<name>.algorithm` has no effect, as the
+algorithm is not passed to the external diff driver.
 
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/diff.c b/diff.c
index 5efc22ca06b..469e18aed20 100644
--- a/diff.c
+++ b/diff.c
@@ -4456,15 +4456,13 @@ static void run_diff_cmd(const char *pgm,
 	const char *xfrm_msg = NULL;
 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
 	int must_show_header = 0;
+	struct userdiff_driver *drv = NULL;
 
-
-	if (o->flags.allow_external) {
-		struct userdiff_driver *drv;
-
+	if (o->flags.allow_external || !o->ignore_driver_algorithm)
 		drv = userdiff_find_by_path(o->repo->index, attr_path);
-		if (drv && drv->external)
-			pgm = drv->external;
-	}
+
+	if (o->flags.allow_external && drv && drv->external)
+		pgm = drv->external;
 
 	if (msg) {
 		/*
@@ -4481,12 +4479,16 @@ static void run_diff_cmd(const char *pgm,
 		run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
 		return;
 	}
-	if (one && two)
+	if (one && two) {
+		if (!o->ignore_driver_algorithm && drv && drv->algorithm)
+			set_diff_algorithm(o, drv->algorithm);
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
@@ -4583,6 +4585,14 @@ static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
 	const char *name;
 	const char *other;
 
+	if (!o->ignore_driver_algorithm) {
+		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index,
+								    p->one->path);
+
+		if (drv && drv->algorithm)
+			set_diff_algorithm(o, drv->algorithm);
+	}
+
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
 		builtin_diffstat(p->one->path, NULL, NULL, NULL,
@@ -5130,6 +5140,8 @@ static int diff_opt_diff_algorithm(const struct option *opt,
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
+	options->ignore_driver_algorithm = 1;
+
 	return 0;
 }
 
@@ -5145,6 +5157,8 @@ static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
 		BUG("available diff algorithms include \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\"");
 
+	options->ignore_driver_algorithm = 1;
+
 	return 0;
 }
 
@@ -5285,6 +5299,7 @@ static int diff_opt_patience(const struct option *opt,
 	for (i = 0; i < options->anchors_nr; i++)
 		free(options->anchors[i]);
 	options->anchors_nr = 0;
+	options->ignore_driver_algorithm = 1;
 
 	return set_diff_algorithm(options, "patience");
 }
diff --git a/diff.h b/diff.h
index 41eb2c3d428..8d770b1d579 100644
--- a/diff.h
+++ b/diff.h
@@ -333,6 +333,7 @@ struct diff_options {
 	int prefix_length;
 	const char *stat_sep;
 	int xdl_opts;
+	int ignore_driver_algorithm;
 
 	/* see Documentation/diff-options.txt */
 	char **anchors;
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 8d1e408bb58..a8f5d3274a5 100644
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
+		git config diff.driver.algorithm myers &&
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
