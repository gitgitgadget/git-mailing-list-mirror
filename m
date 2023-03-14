Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6A8C7618D
	for <git@archiver.kernel.org>; Tue, 14 Mar 2023 01:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjCNBxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 21:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjCNBxp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 21:53:45 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D655265C71
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:53:42 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k25-20020a7bc419000000b003ed23114fa7so3416413wmi.4
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 18:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678758821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtwH0LqLFbMDIDH9+zvVsm9V2/wKnrXe+muFWgcRJiM=;
        b=cnwhVb3atAr0stdhsCWIsiIuM10sPnBmWbezseCXXV9BUbK6zFf9Cu2IWSXkDdkR3P
         OSzEciWDDHyVIoj+auotKEW0Fxh/E/mLhV3lGRgUC7SMdItAqCkg3z1CjKpuJpJsyNk3
         Xu7MabeSlnr2uRVTmB//QHpnXZVTkLycp5UjLj/1KoMSpFf5XRqaJA+A4K4r1pPD2TYY
         o/ihWT9ElctdslFOlOb+GA2kXVBR6Fp2+1pJXLVhVZSDlASR9iW2WuO7Qp03gdzsXAZQ
         ANhDsvlxdVe861VJ7bwWganv5Hvl+HoJFMDfypKhVDYFCeFJSJuopvwxNwxzWS0srku0
         bEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678758821;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XtwH0LqLFbMDIDH9+zvVsm9V2/wKnrXe+muFWgcRJiM=;
        b=XTWNVcZWD/KSkbg5tR+G20N2UqPWIK0dqeT9rPOCiv0LNR8KIw15/IdTNJ22yCa1X1
         IsrEcunYK/9hfusiIa2lbArL5bpXXx1TwGhgf6jcSx6qpJgfkJpo++WfGcYtjNyzQWnL
         zarzIcgt6Ihuu6pw97CI3T8rZb7Ux+MGaCVpRo87lJq6XKbJUf9qd74MlANeu1P0kJa7
         Ng9Bbd96RmI8c73kfzDbBcONWm3FpMDsqImsh6EpukfRgQYHvg9dJVGBtE7TWgtlrri+
         OdNDHq23F56sv3h1w31bZxE9ZoDao7K3rN1aGb9f+Bs5AIoqeUCx4SIUP4/scqQem3Wx
         uuwg==
X-Gm-Message-State: AO0yUKXq4yWKje0bDLurlmejlyisAuot5/2xBCZoe+U/1k0yGx1n57sG
        y10BZIfeVTc2JsLMWHkTuPHT8RTqKp8=
X-Google-Smtp-Source: AK7set8ESCRQloywmWLNUlI/Y+DNpijIKYuy74S5R1uG4BgvAXeaDxO1lFh7loAPSo5oFpAR4mGbyA==
X-Received: by 2002:a05:600c:1f0f:b0:3df:ef18:b0a1 with SMTP id bd15-20020a05600c1f0f00b003dfef18b0a1mr13175624wmb.12.1678758821147;
        Mon, 13 Mar 2023 18:53:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w19-20020a1cf613000000b003e0015c8618sm1304685wmc.6.2023.03.13.18.53.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 18:53:40 -0700 (PDT)
Message-Id: <bc9c2b1463a625ddab58cb72d4281f01d1f53bdb.1678758818.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
References: <pull.1459.git.git.1678758818.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Mar 2023 01:53:38 +0000
Subject: [PATCH 2/2] diff: add --attr-source to read gitattributes from a
 commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

The previous commit allows the diff machinery to read gitattributes from
HEAD when a bare repository is being used.

Some users may want to specify which commit to read gitattributes from.
Teach diff a new --attr-source that can be used to pass in a commit.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/diff-options.txt  |  4 ++++
 Documentation/gitattributes.txt |  8 ++++++--
 diff.c                          | 16 ++++++++++-----
 diff.h                          |  1 +
 t/lib-diff-alternative.sh       | 35 ++++++++++++++++++++++-----------
 t/t4018-diff-funcname.sh        | 18 +++++++++++++++++
 6 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 7d73e976d99..d3a04937dde 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -173,6 +173,10 @@ endif::git-log[]
 
 --anchored=<text>::
 	Generate a diff using the "anchored diff" algorithm.
+
+--attr-source=<commit>::
+	Specify a commit to read gitattributes from when using a bare
+	repository when defining external drivers, or internal algorithms.
 +
 This option may be specified more than once.
 +
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 15488bd92b2..7f9451b56fa 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -758,7 +758,9 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
-When using a bare repository, the gitattributes from HEAD will be used.
+When using a bare repository, the gitattributes from HEAD will be used, unless
+the --attr-source option is used to specify a commit from which the
+gitattributes will be read.
 
 Setting the internal diff algorithm
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
@@ -787,7 +789,9 @@ This diff algorithm applies to user facing diff output like git-diff(1),
 git-show(1) and is used for the `--stat` output as well. The merge machinery
 will not use the diff algorithm set through this method.
 
-When using a bare repository, the gitattributes from HEAD will be used.
+When using a bare repository, the gitattributes from HEAD will be used, unless
+the --attr-source option is used to specify a commit from which the
+gitattributes will be read.
 
 NOTE: If `diff.<name>.command` is defined for path with the
 `diff=<name>` attribute, it is executed as an external diff driver
diff --git a/diff.c b/diff.c
index 51baf893bb0..e86cf33b7a9 100644
--- a/diff.c
+++ b/diff.c
@@ -4448,10 +4448,13 @@ static void get_userdiff(struct diff_options *o,
 			     struct userdiff_driver **drv,
 			     const char *attr_path)
 {
-	const char *commit = "HEAD";
+	const char *commit = o->attr_source;
 	struct object_id *tree_oid = NULL;
 
-	if (is_bare_repository() && o->repo->gitdir) {
+	if (!commit)
+		commit = "HEAD";
+
+	if ((o->attr_source || is_bare_repository()) && o->repo->gitdir) {
 		struct object_id oid;
 
 		if (!get_oid(commit, &oid)) {
@@ -4459,6 +4462,8 @@ static void get_userdiff(struct diff_options *o,
 
 			if (t)
 				tree_oid = &t->object.oid;
+		} else if (o->attr_source) {
+			die(_("%s is not a valid object"), commit);
 		}
 	}
 
@@ -4480,10 +4485,8 @@ static void run_diff_cmd(const char *pgm,
 	int must_show_header = 0;
 	struct userdiff_driver *drv = NULL;
 
-	if (o->flags.allow_external || !o->ignore_driver_algorithm) {
-
+	if (o->flags.allow_external || !o->ignore_driver_algorithm)
 		get_userdiff(o, &drv, attr_path);
-	}
 
 	if (o->flags.allow_external && drv && drv->external)
 		pgm = drv->external;
@@ -5699,6 +5702,9 @@ struct option *add_diff_options(const struct option *opts,
 			 N_("disable all output of the program")),
 		OPT_BOOL(0, "ext-diff", &options->flags.allow_external,
 			 N_("allow an external diff helper to be executed")),
+		OPT_STRING(0, "attr-source", &options->attr_source,
+			 N_("attributes-source"),
+			 N_("the commit to read attributes from")),
 		OPT_CALLBACK_F(0, "textconv", options, NULL,
 			       N_("run external text conversion filters when comparing binary files"),
 			       PARSE_OPT_NOARG, diff_opt_textconv),
diff --git a/diff.h b/diff.h
index 8d770b1d579..59db40f66be 100644
--- a/diff.h
+++ b/diff.h
@@ -334,6 +334,7 @@ struct diff_options {
 	const char *stat_sep;
 	int xdl_opts;
 	int ignore_driver_algorithm;
+	const char *attr_source;
 
 	/* see Documentation/diff-options.txt */
 	char **anchors;
diff --git a/t/lib-diff-alternative.sh b/t/lib-diff-alternative.sh
index 0d99af83dd2..a7cd4966749 100644
--- a/t/lib-diff-alternative.sh
+++ b/t/lib-diff-alternative.sh
@@ -112,25 +112,38 @@ EOF
 
 	STRATEGY=$1
 
-	test_expect_success "$STRATEGY diff from attributes" '
+	test_expect_success "setup attributes files for tests with $STRATEGY" '
+		git checkout -b master &&
 		echo "file* diff=driver" >.gitattributes &&
-		git config diff.driver.algorithm "$STRATEGY" &&
-		test_must_fail git diff --no-index file1 file2 > output &&
-		cat expect &&
-		cat output &&
+		git add file1 file2 .gitattributes &&
+		git commit -m "adding files" &&
+		git checkout -b branchA &&
+		echo "file* diff=driverA" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -m "adding driverA as diff driver" &&
+		git checkout master &&
+		git clone --bare --no-local . bare.git
+	'
+
+	test_expect_success "$STRATEGY diff from attributes" '
+		test_must_fail git -c diff.driver.algorithm=$STRATEGY diff --no-index file1 file2 > output &&
 		test_cmp expect output
 	'
 
 	test_expect_success "$STRATEGY diff from attributes with bare repo" '
-		echo "file* diff=driver" >.gitattributes &&
-		git add file1 file2 .gitattributes &&
-		git commit -m "adding files" &&
-		git clone --bare --no-local . bare.git &&
-		git -C bare.git config diff.driver.algorithm "$STRATEGY" &&
-		git -C bare.git diff HEAD:file1 HEAD:file2 > output &&
+		git -C bare.git -c diff.driver.algorithm=$STRATEGY diff HEAD:file1 HEAD:file2 >output &&
+		test_cmp expect output
+	'
+
+	test_expect_success "diff from attributes with bare repo when branch different than HEAD" '
+		git -C bare.git -c diff.driver.algorithm=myers -c diff.driverA.algorithm=$STRATEGY diff --attr-source branchA HEAD:file1 HEAD:file2 >output &&
 		test_cmp expect output
 	'
 
+	test_expect_success "diff from attributes with bare repo with invalid source" '
+		test_must_fail git -C bare.git diff --attr-source invalid-branch HEAD:file1 HEAD:file2
+	'
+
 	test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
 		echo "file* diff=driver" >.gitattributes &&
 		git config diff.driver.algorithm "$STRATEGY" &&
diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index 451af08c611..30babcfae91 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -63,6 +63,7 @@ do
 		test_i18ngrep ! fatal msg &&
 		test_i18ngrep ! error msg
 	'
+
 	test_expect_success "builtin $p pattern compiles on bare repo" '
 		test_when_finished "rm -rf bare.git" &&
 		echo "*.java diff=$p" >.gitattributes &&
@@ -74,6 +75,23 @@ do
 		test_i18ngrep ! fatal msg &&
 		test_i18ngrep ! error msg
 	'
+	test_expect_success "builtin $p pattern compiles on bare repo with --attr-source" '
+		test_when_finished "rm -rf bare.git" &&
+		git checkout -B master &&
+		echo "*.java diff=notexist" > .gitattributes &&
+		git add .gitattributes &&
+		git commit -am "changing gitattributes" &&
+		git checkout -B branchA &&
+		echo "*.java diff=$p" >.gitattributes &&
+		git add .gitattributes &&
+		git commit -am "changing gitattributes" &&
+		git clone --bare --no-local . bare.git &&
+		git -C bare.git symbolic-ref HEAD refs/heads/master &&
+		test_expect_code 1 git -C bare.git diff --exit-code \
+			--attr-source branchA HEAD:A.java HEAD:B.java 2>msg &&
+		test_i18ngrep ! fatal msg &&
+		test_i18ngrep ! error msg
+	'
 done
 
 test_expect_success 'last regexp must not be negated' '
-- 
gitgitgadget
