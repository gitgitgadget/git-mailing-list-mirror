Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686DFA373D
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 21:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbiJXVzd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiJXVzN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 17:55:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CD58E7B3
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:10 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id o4so9603009wrq.6
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 13:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0DFd/4WwKAI4Jr4JudD/7m0+tz8oNLN9zGxWLff8cE=;
        b=WdJhk/TIQ1aLLAfoIfelBq15in7KH4gTBj58u1q8fDSdQA0aJwSk/Hm6uQNCidzuHU
         95Hud64tADG5POM4hdtmQe6v/XP7KwHhe3J4GG4UVPlLIy1HP1ycPY7EbvAUt98rkeQC
         F+gmHx+xi5MV8QnF5bHiew+vJ6Qf+decvxlBfmfutLx7yVJTjHTqO02naTDNjZC/PLE5
         UdEH7Jxq/JuUurl3oPmuW9aSRW5QngoH+yJATMIx4IemHqnHiBJgKtO+4Kh3xAEuh19B
         XJ9DWcrXi7Z3F4CmQJyMLjh5xnho4nwmRW8KETYyw5neCJR8IibvoxMo6F1cyxHVX5kO
         ZoUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c0DFd/4WwKAI4Jr4JudD/7m0+tz8oNLN9zGxWLff8cE=;
        b=6lhmGZcWedaREypOXRnkPxYAKWDS+aCYzWJRbX8CMh/C1Sz+kKIPRlkuvUPM2lypz0
         zyJlP092YwnkFtAM6Zv+zPpaQSH/SRx4E7IExFpeRKPAmxxu1vASAiNdhjxKF+TsCOh1
         lpioZ/2wch5XqIecok7V17cc8q0VYKl9HoBPC6PiTa0C1YkSF70P+r2CutgYubZdBCJl
         Tf2Zatiik6suJk4sK2Oqcnq04x5H+zwfPUkWHmEIZqwqaJvI8GIWCSEgoBPQxjVa6+I+
         HyHK4jhVjILxRjbqGrbMi4T9LQSNP35TyHF3w5776imR4HAacQcvO6ZA5jLHvHJKEb81
         Dupw==
X-Gm-Message-State: ACrzQf2wuZ+RrSKQb/ZPOmAj7ZM9Obc5dtSieaCE5cF/bvGs03llDa/X
        vCTIU+nYNPS6/qajnQSrb5aZ55+/ehc=
X-Google-Smtp-Source: AMsMyM5E6uzAljPJi31bWUFNoOQdaR/xw18rUDPhgghi90uB0g811KunrkPFuWY//kZlg0uv/6kWlg==
X-Received: by 2002:adf:e6ce:0:b0:236:76a2:fc80 with SMTP id y14-20020adfe6ce000000b0023676a2fc80mr3380904wrm.163.1666642072713;
        Mon, 24 Oct 2022 13:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k23-20020a05600c1c9700b003c6b7f5567csm91785wms.0.2022.10.24.13.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:07:52 -0700 (PDT)
Message-Id: <b160f2ae49f8906249e7690d089a1921c43b3bda.1666642065.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
References: <pull.1359.v4.git.1666307815.gitgitgadget@gmail.com>
        <pull.1359.v5.git.1666642064.gitgitgadget@gmail.com>
From:   "Jerry Zhang via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 24 Oct 2022 20:07:43 +0000
Subject: [PATCH v5 5/6] builtin: patch-id: add --verbatim as a command mode
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jerry Zhang <jerry@skydio.com>, Jerry Zhang <jerry@skydio.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jerry Zhang <jerry@skydio.com>

There are situations where the user might not want the default
setting where patch-id strips all whitespace. They might be working
in a language where white space is syntactically important, or they
might have CI testing that enforces strict whitespace linting. In
these cases, a whitespace change would result in the patch
fundamentally changing, and thus deserving of a different id.

Add a new mode that is exclusive of --stable and --unstable called
--verbatim. It also corresponds to the config
patchid.verbatim = true. In this mode, the stable algorithm is
used and whitespace is not stripped from the patch text.

Users of --unstable mainly care about compatibility with old git
versions, which unstripping the whitespace would break. Thus there
isn't a usecase for the combination of --verbatim and --unstable,
and we don't expose this so as to not add maintainence burden.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
fixes https://github.com/Skydio/revup/issues/2
---
 Documentation/git-patch-id.txt | 24 +++++++----
 builtin/patch-id.c             | 73 ++++++++++++++++++++++------------
 t/t4204-patch-id.sh            | 66 +++++++++++++++++++++++++++---
 3 files changed, 124 insertions(+), 39 deletions(-)

diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index 442caff8a9c..1d15fa45d51 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -8,18 +8,18 @@ git-patch-id - Compute unique ID for a patch
 SYNOPSIS
 --------
 [verse]
-'git patch-id' [--stable | --unstable]
+'git patch-id' [--stable | --unstable | --verbatim]
 
 DESCRIPTION
 -----------
 Read a patch from the standard input and compute the patch ID for it.
 
 A "patch ID" is nothing but a sum of SHA-1 of the file diffs associated with a
-patch, with whitespace and line numbers ignored.  As such, it's "reasonably
-stable", but at the same time also reasonably unique, i.e., two patches that
-have the same "patch ID" are almost guaranteed to be the same thing.
+patch, with line numbers ignored.  As such, it's "reasonably stable", but at
+the same time also reasonably unique, i.e., two patches that have the same
+"patch ID" are almost guaranteed to be the same thing.
 
-IOW, you can use this thing to look for likely duplicate commits.
+The main usecase for this command is to look for likely duplicate commits.
 
 When dealing with 'git diff-tree' output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
@@ -30,6 +30,12 @@ This can be used to make a mapping from patch ID to commit ID.
 OPTIONS
 -------
 
+--verbatim::
+	Calculate the patch-id of the input as it is given, do not strip
+	any whitespace.
+
+	This is the default if patchid.verbatim is true.
+
 --stable::
 	Use a "stable" sum of hashes as the patch ID. With this option:
 	 - Reordering file diffs that make up a patch does not affect the ID.
@@ -45,14 +51,16 @@ OPTIONS
 	   of "-O<orderfile>", thereby making existing databases storing such
 	   "unstable" or historical patch-ids unusable.
 
+	 - All whitespace within the patch is ignored and does not affect the id.
+
 	This is the default if patchid.stable is set to true.
 
 --unstable::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
-	by git 1.9 and older.  Users with pre-existing databases storing
-	patch-ids produced by git 1.9 and older (who do not deal with reordered
-	patches) may want to use this option.
+	by git 1.9 and older and whitespace is ignored.  Users with pre-existing
+	databases storing patch-ids produced by git 1.9 and older (who do not deal
+	with reordered patches) may want to use this option.
 
 	This is the default.
 
diff --git a/builtin/patch-id.c b/builtin/patch-id.c
index e7a31123142..afdd472369f 100644
--- a/builtin/patch-id.c
+++ b/builtin/patch-id.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "diff.h"
+#include "parse-options.h"
 
 static void flush_current_id(int patchlen, struct object_id *id, struct object_id *result)
 {
@@ -57,7 +58,7 @@ static int scan_hunk_header(const char *p, int *p_before, int *p_after)
 }
 
 static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
-			   struct strbuf *line_buf, int stable)
+			   struct strbuf *line_buf, int stable, int verbatim)
 {
 	int patchlen = 0, found_next = 0;
 	int before = -1, after = -1;
@@ -76,8 +77,11 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		if (!skip_prefix(line, "diff-tree ", &p) &&
 		    !skip_prefix(line, "commit ", &p) &&
 		    !skip_prefix(line, "From ", &p) &&
-		    starts_with(line, "\\ ") && 12 < strlen(line))
+		    starts_with(line, "\\ ") && 12 < strlen(line)) {
+			if (verbatim)
+				the_hash_algo->update_fn(&ctx, line, strlen(line));
 			continue;
+		}
 
 		if (!get_oid_hex(p, next_oid)) {
 			found_next = 1;
@@ -152,8 +156,8 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 		if (line[0] == '+' || line[0] == ' ')
 			after--;
 
-		/* Compute the sha without whitespace */
-		len = remove_space(line);
+		/* Add line to hash algo (possibly removing whitespace) */
+		len = verbatim ? strlen(line) : remove_space(line);
 		patchlen += len;
 		the_hash_algo->update_fn(&ctx, line, len);
 	}
@@ -166,7 +170,7 @@ static int get_one_patchid(struct object_id *next_oid, struct object_id *result,
 	return patchlen;
 }
 
-static void generate_id_list(int stable)
+static void generate_id_list(int stable, int verbatim)
 {
 	struct object_id oid, n, result;
 	int patchlen;
@@ -174,21 +178,32 @@ static void generate_id_list(int stable)
 
 	oidclr(&oid);
 	while (!feof(stdin)) {
-		patchlen = get_one_patchid(&n, &result, &line_buf, stable);
+		patchlen = get_one_patchid(&n, &result, &line_buf, stable, verbatim);
 		flush_current_id(patchlen, &oid, &result);
 		oidcpy(&oid, &n);
 	}
 	strbuf_release(&line_buf);
 }
 
-static const char patch_id_usage[] = "git patch-id [--stable | --unstable]";
+static const char *const patch_id_usage[] = {
+	N_("git patch-id [--stable | --unstable | --verbatim]"), NULL
+};
+
+struct patch_id_opts {
+	int stable;
+	int verbatim;
+};
 
 static int git_patch_id_config(const char *var, const char *value, void *cb)
 {
-	int *stable = cb;
+	struct patch_id_opts *opts = cb;
 
 	if (!strcmp(var, "patchid.stable")) {
-		*stable = git_config_bool(var, value);
+		opts->stable = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp(var, "patchid.verbatim")) {
+		opts->verbatim = git_config_bool(var, value);
 		return 0;
 	}
 
@@ -197,21 +212,29 @@ static int git_patch_id_config(const char *var, const char *value, void *cb)
 
 int cmd_patch_id(int argc, const char **argv, const char *prefix)
 {
-	int stable = -1;
-
-	git_config(git_patch_id_config, &stable);
-
-	/* If nothing is set, default to unstable. */
-	if (stable < 0)
-		stable = 0;
-
-	if (argc == 2 && !strcmp(argv[1], "--stable"))
-		stable = 1;
-	else if (argc == 2 && !strcmp(argv[1], "--unstable"))
-		stable = 0;
-	else if (argc != 1)
-		usage(patch_id_usage);
-
-	generate_id_list(stable);
+	/* if nothing is set, default to unstable */
+	struct patch_id_opts config = {0, 0};
+	int opts = 0;
+	struct option builtin_patch_id_options[] = {
+		OPT_CMDMODE(0, "unstable", &opts,
+		    N_("use the unstable patch-id algorithm"), 1),
+		OPT_CMDMODE(0, "stable", &opts,
+		    N_("use the stable patch-id algorithm"), 2),
+		OPT_CMDMODE(0, "verbatim", &opts,
+			N_("don't strip whitespace from the patch"), 3),
+		OPT_END()
+	};
+
+	git_config(git_patch_id_config, &config);
+
+	/* verbatim implies stable */
+	if (config.verbatim)
+		config.stable = 1;
+
+	argc = parse_options(argc, argv, prefix, builtin_patch_id_options,
+			     patch_id_usage, 0);
+
+	generate_id_list(opts ? opts > 1 : config.stable,
+			 opts ? opts == 3 : config.verbatim);
 	return 0;
 }
diff --git a/t/t4204-patch-id.sh b/t/t4204-patch-id.sh
index cdc5191aa8d..a7fa94ce0a2 100755
--- a/t/t4204-patch-id.sh
+++ b/t/t4204-patch-id.sh
@@ -8,13 +8,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-	as="a a a a a a a a" && # eight a
-	test_write_lines $as >foo &&
-	test_write_lines $as >bar &&
+	str="ab cd ef gh ij kl mn op" &&
+	test_write_lines $str >foo &&
+	test_write_lines $str >bar &&
 	git add foo bar &&
 	git commit -a -m initial &&
-	test_write_lines $as b >foo &&
-	test_write_lines $as b >bar &&
+	test_write_lines $str b >foo &&
+	test_write_lines $str b >bar &&
 	git commit -a -m first &&
 	git checkout -b same main &&
 	git commit --amend -m same-msg &&
@@ -22,8 +22,23 @@ test_expect_success 'setup' '
 	echo c >foo &&
 	echo c >bar &&
 	git commit --amend -a -m notsame-msg &&
+	git checkout -b with_space main~ &&
+	cat >foo <<-\EOF &&
+	a  b
+	c d
+	e    f
+	  g   h
+	    i   j
+	k l
+	m   n
+	op
+	EOF
+	cp foo bar &&
+	git add foo bar &&
+	git commit --amend -m "with spaces" &&
 	test_write_lines bar foo >bar-then-foo &&
 	test_write_lines foo bar >foo-then-bar
+
 '
 
 test_expect_success 'patch-id output is well-formed' '
@@ -128,9 +143,21 @@ test_patch_id_file_order () {
 	git format-patch -1 --stdout -O foo-then-bar >format-patch.output &&
 	calc_patch_id <format-patch.output "ordered-$name" "$@" &&
 	cmp_patch_id $relevant "$name" "ordered-$name"
+}
 
+test_patch_id_whitespace () {
+	relevant="$1"
+	shift
+	name="ws-${1}-$relevant"
+	shift
+	get_top_diff "main~" >top-diff.output &&
+	calc_patch_id <top-diff.output "$name" "$@" &&
+	get_top_diff "with_space" >top-diff.output &&
+	calc_patch_id <top-diff.output "ws-$name" "$@" &&
+	cmp_patch_id $relevant "$name" "ws-$name"
 }
 
+
 # combined test for options: add more tests here to make them
 # run with all options
 test_patch_id () {
@@ -146,6 +173,14 @@ test_expect_success 'file order is relevant with --unstable' '
 	test_patch_id_file_order relevant --unstable --unstable
 '
 
+test_expect_success 'whitespace is relevant with --verbatim' '
+	test_patch_id_whitespace relevant --verbatim --verbatim
+'
+
+test_expect_success 'whitespace is irrelevant without --verbatim' '
+	test_patch_id_whitespace irrelevant --stable --stable
+'
+
 #Now test various option combinations.
 test_expect_success 'default is unstable' '
 	test_patch_id relevant default
@@ -161,6 +196,17 @@ test_expect_success 'patchid.stable = false is unstable' '
 	test_patch_id relevant patchid.stable=false
 '
 
+test_expect_success 'patchid.verbatim = true is correct and stable' '
+	test_config patchid.verbatim true &&
+	test_patch_id_whitespace relevant patchid.verbatim=true &&
+	test_patch_id irrelevant patchid.verbatim=true
+'
+
+test_expect_success 'patchid.verbatim = false is unstable' '
+	test_config patchid.verbatim false &&
+	test_patch_id relevant patchid.verbatim=false
+'
+
 test_expect_success '--unstable overrides patchid.stable = true' '
 	test_config patchid.stable true &&
 	test_patch_id relevant patchid.stable=true--unstable --unstable
@@ -171,6 +217,11 @@ test_expect_success '--stable overrides patchid.stable = false' '
 	test_patch_id irrelevant patchid.stable=false--stable --stable
 '
 
+test_expect_success '--verbatim overrides patchid.stable = false' '
+	test_config patchid.stable false &&
+	test_patch_id_whitespace relevant stable=false--verbatim --verbatim
+'
+
 test_expect_success 'patch-id supports git-format-patch MIME output' '
 	get_patch_id main &&
 	git checkout same &&
@@ -225,7 +276,10 @@ test_expect_success 'patch-id handles no-nl-at-eof markers' '
 	EOF
 	calc_patch_id nonl <nonl &&
 	calc_patch_id withnl <withnl &&
-	test_cmp patch-id_nonl patch-id_withnl
+	test_cmp patch-id_nonl patch-id_withnl &&
+	calc_patch_id nonl-inc-ws --verbatim <nonl &&
+	calc_patch_id withnl-inc-ws --verbatim <withnl &&
+	! test_cmp patch-id_nonl-inc-ws patch-id_withnl-inc-ws
 '
 
 test_expect_success 'patch-id handles diffs with one line of before/after' '
-- 
gitgitgadget

