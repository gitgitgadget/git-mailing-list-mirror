Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2F7C05027
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjBQUVf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBQUVb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:21:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926445FC4B
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:21:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r25so3181064wrr.5
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:21:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1mp0SFekpMfUDY+W4d4UWkCXFAFpUX9TWaDFOZzNP8=;
        b=dom7kZs/eALPFY8CLBPoQpdnh+I2dnJ+GcIgA/NP7Gz55xxjL7Vu4xwijI6ZjnMSJf
         m02fmB8rHHQrwJK/ZEHwo+YRol/ImMGxnt3wCa4eomBIBaAzR+grXvlh+IIK7nCtA+Oz
         cLk2NLdM5SelOKHFvZAql1AT9C7LHtvu6ekK/HT9FB61N+wtGCjPNamFaup2t5Uv1Q37
         K+cL8Krj60aKaVfPSaHh5tiL5NEAygTDHS5YFo2yo55Z07V0vvnqatTUybE8Xt8SzAMq
         KopQVvxuoEAC533QNzKfgDHjdf4+5+8hncnucQs7F8rxv51AL0X7GnHFnnpjmFzrUALP
         IACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d1mp0SFekpMfUDY+W4d4UWkCXFAFpUX9TWaDFOZzNP8=;
        b=ShVWC56Pj3gG+Q5B3dp/iXYM7xYm8exQDGzupAFGncLQieGO0L1m/Zf9Y9O2+t+h0X
         HmnrsxWGR95bwQyUhC8zn6cx5Bconz+Ny4+mAXLRD3MN1NRcxeETF1YybExDWPfnEIo2
         9VH+8yUVP3ZP4nxj+N+lz1glDkkUnrl22IG65/SoIJcyTtd7Jm4Ssm8EdTg2dAmf+e5O
         qMcrE4LaDYz1hsSF4OIuK94HVpAypjferi5B0NoalmrMS+gkOKb3AMjkEgDGcmhkjMyI
         n8OW/8k8E1ziCbq9q6u1heb9nCki2lAI8yS1ZKSKC7DFMzHk2RTn0FCMeW+TnPKOvZVy
         n5qw==
X-Gm-Message-State: AO0yUKWQaKW03IXUSSHMkLuWQX30NUucEgcNYcNtx4d80m9EHfuPUgao
        TFlbM5XeBRS9xzoGedME3hmCdoLhLhs=
X-Google-Smtp-Source: AK7set8mKm982SAQcWt7rJpVq/VBXdUhseCwMOhNmC3lwB92FRecrQL7N5lMNWetRSF6LQZZi1RNgA==
X-Received: by 2002:adf:ee50:0:b0:2c5:7eb5:9797 with SMTP id w16-20020adfee50000000b002c57eb59797mr5286868wro.8.1676665287963;
        Fri, 17 Feb 2023 12:21:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020adff3c9000000b002c54d8b89efsm5233351wrp.26.2023.02.17.12.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:21:27 -0800 (PST)
Message-Id: <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
        <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Feb 2023 20:21:25 +0000
Subject: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
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
during options pasing to indicate the diff algorithm was set via command
line args.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/gitattributes.txt | 37 ++++++++++++++++++++++++++++++++
 diff.c                          | 33 ++++++++++++++++++++--------
 diff.h                          |  1 +
 t/lib-diff-alternative.sh       | 38 ++++++++++++++++++++++++++++++++-
 userdiff.c                      |  4 +++-
 userdiff.h                      |  1 +
 6 files changed, 103 insertions(+), 11 deletions(-)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c19e64ea0ef..f212079a131 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -758,6 +758,43 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+Setting the internal diff algorithm
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The diff algorithm can be set through the `diff.algorithm` config key, but
+sometimes it may be helpful to set the diff algorithm by path. For example, one
+might wish to set a diff algorithm automatically for all `.json` files such that
+the user would not need to pass in a separate command line `--diff-algorithm`
+flag each time.
+
+First, in `.gitattributes`, assign the `diff` attribute for paths.
+
+------------------------
+*.json diff=<name>
+------------------------
+
+Then, define a "diff.<name>.algorithm" configuration to specify the diff
+algorithm, choosing from `meyers`, `patience`, `minimal`, or `histogram`.
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
+NOTE: If the `command` key also exists, then Git will treat this as an external
+diff and attempt to use the value set for `command` as an external program. For
+instance, the following config, combined with the above `.gitattributes` file,
+will result in `command` favored over `algorithm`.
+
+----------------------------------------------------------------
+[diff "<name>"]
+  command = j-c-diff
+  algorithm = histogram
+----------------------------------------------------------------
 
 Defining a custom hunk-header
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/diff.c b/diff.c
index 5efc22ca06b..04469da6d34 100644
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
+		if (drv && !o->ignore_driver_algorithm && drv->algorithm)
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
+		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
+
+		if (drv && drv->algorithm) {
+			set_diff_algorithm(o, drv->algorithm);
+		}
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
