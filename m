Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13993C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjBNVk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjBNVk1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:40:27 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83BC92B0A3
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:22 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so17159776wrb.11
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G9GtL/Oj41fr2e0cD6T5DFJehyqOzJT8qSl4Iv142So=;
        b=D08hQ1C0tBU0JCL9xfLzTL9raPVFs96m0ra3Zq3kVLK1QCD4GKE07Om7k/axsPG3AN
         MCvTG7QtvHAOuOPspO4kcA2yxTbHWoKmRCQLvDcAOCucPqIzmev3xSIKUthhUZKk2YxV
         M1nWBQQKKCHP8cL9m0nvmClW8fQOl0i8dvpBu8McvaZ9SNUnqqKT4ohqqU/NdnLqnQ0V
         cS5EazTQliMTuGj3/yPD8xHGo9uuZVURIP86b4gMwMZCKocJ5hkXqJOS1ioRpQszO9gR
         SMpVXMErCu6SMg1GRKpoVB6As3mYAXwzIKGcW3Znt1PC7gn8V/2+s3YzKCs879oVHyVK
         XpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G9GtL/Oj41fr2e0cD6T5DFJehyqOzJT8qSl4Iv142So=;
        b=YdhNbVbTl/HnjkpERI7Widz9kL1ltwN5dwzhBfnRkSxQA4kroZrQeGID/GZGCVdUSh
         hQfTXogDptZDdzNnCjQLEDvMqWmMaanHap3kh0UBMBGbZN/eXKN0E1uae2obK1jwqQ+8
         UwVcpSP78Q+5Jy/k4bW3OJA5OOjcfo370oR67IqhQp4u4cEYEugRv3djODWgADPK26Xi
         JDVeOSxvVJYGuEOpk+yRhrdFd92+HLyhZyTEaT4QYVuSOOhCKzOb8rtQGuuMx0MaQ1yc
         zBo3NjMxHEWdgTNsMIZXG+K1svOpszKk37a6TJcP1St5fH4mR3DOf5WcFhD2Do/9seY/
         PrIA==
X-Gm-Message-State: AO0yUKUXRMpE0mYMaL/Ky4WNPxrqfE0Q2rKw6sEwVGHLDrfBMTQ2UJHy
        0K+QyJXFRbpWL0FC1tx7+TMH0qEnu9Q=
X-Google-Smtp-Source: AK7set9GZXeyxoUOJlKWQpTfwgq6c1FskU9a3G5VQMvZtcvALlm+U/2PaHNYmuQ2jjotm+m0zkn9ZA==
X-Received: by 2002:adf:f547:0:b0:2c5:4c32:92c5 with SMTP id j7-20020adff547000000b002c54c3292c5mr2965534wrp.25.1676410820736;
        Tue, 14 Feb 2023 13:40:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020adff445000000b002c53f5b13f9sm13847890wrp.0.2023.02.14.13.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 13:40:20 -0800 (PST)
Message-Id: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Feb 2023 21:40:17 +0000
Subject: [PATCH v2 0/2] Teach diff to honor diff algorithms set through git attributes
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
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a repository contains different kinds of files, it may be desirable to
use different algorithms based on file type. This is currently not feasible
through the command line or using git configs. However, we can leverage the
fact that gitattributes are path aware.

Teach the diff machinery to check gitattributes when diffing files.

Changes since V1:

 * utilize the existing diff.<driver>.* scheme where the driver is defined
   in gitattributes, but the algorithm is defined in the gitconfig.

To address some of the performance concerns in the previous series, a
benchmark shows that a performance penalty is no longer incurred, now that
we are no longer adding an additional attributes parsing call:

$ hyperfine -r 5 -L a bin-wrappers/git,git '{a} diff v2.0.0 v2.28.0'
Benchmark 1: git-bin-wrapper diff v2.0.0 v2.28.0 Time (mean ± σ): 1.072 s ±
0.289 s [User: 0.626 s, System: 0.081 s] Range (min … max): 0.772 s … 1.537
s 5 runs

Benchmark 2: git diff v2.0.0 v2.28.0 Time (mean ± σ): 1.003 s ± 0.065 s
[User: 0.684 s, System: 0.067 s] Range (min … max): 0.914 s … 1.091 s 5 runs

Summary 'git diff v2.0.0 v2.28.0' ran 1.07 ± 0.30 times faster than
'git-bin-wrapper diff v2.0.0 v2.28.0'

John Cai (2):
  diff: consolidate diff algorithm option parsing
  diff: teach diff to read gitattribute diff-algorithm

 Documentation/gitattributes.txt |  41 +++++++++++-
 diff.c                          | 112 ++++++++++++++++++++------------
 diff.h                          |   2 +
 t/lib-diff-alternative.sh       |  38 ++++++++++-
 userdiff.c                      |   4 +-
 userdiff.h                      |   1 +
 6 files changed, 154 insertions(+), 44 deletions(-)


base-commit: c867e4fa180bec4750e9b54eb10f459030dbebfd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1452%2Fjohn-cai%2Fjc%2Fattr-diff-algo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1452/john-cai/jc/attr-diff-algo-v2
Pull-Request: https://github.com/git/git/pull/1452

Range-diff vs v1:

 1:  f56bd38ac3f ! 1:  0c5e1fc6c26 diff: consolidate diff algorithm option parsing
     @@
       ## Metadata ##
     -Author: John Cai <jcai@gitlab.com>
     +Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
          diff: consolidate diff algorithm option parsing
     @@ Commit message
          subsequent commit which teaches diff to keep track of whether or not a
          diff algorithm has been set via the command line.
      
     -    While we're at it, the logic that sets the diff algorithm in
     -    diff_opt_diff_algorithm() can be refactored into a helper that will
     +    Additionally, the logic that sets the diff algorithm in
     +    diff_opt_diff_algorithm() can  be refactored into a helper that will
          allow multiple callsites to set the diff algorithm.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
      +	BUG_ON_OPT_ARG(arg);
      +
      +	if (!strcmp(opt->long_name, "patience")) {
     -+		int i;
     ++		size_t i;
      +		/*
      +		 * Both --patience and --anchored use PATIENCE_DIFF
      +		 * internally, so remove any anchors previously
     @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
      +	}
      +
      +	if (set_diff_algorithm(options, opt->long_name))
     -+		return error(_("available diff algorithms include \"myers\", "
     -+			       "\"minimal\", \"patience\" and \"histogram\""));
     ++		BUG("available diff algorithms include \"myers\", "
     ++			       "\"minimal\", \"patience\" and \"histogram\"");
      +
       	return 0;
       }
 2:  8e73793b0db ! 2:  cb030563149 diff: teach diff to read gitattribute diff-algorithm
     @@ Commit message
          one may want to use the minimal diff algorithm for .json files, another
          for .c files, etc.
      
     -    Teach the diff machinery to check attributes for a diff algorithm.
     -    Enforce precedence by favoring the command line option, then looking at
     -    attributes, then finally the config.
     +    Teach the diff machinery to check attributes for a diff driver. Also
     +    teach the diff driver parser a new type "algorithm" to look for in the
     +    config, which will be used if a driver has been specified through the
     +    attributes.
      
     -    To enforce precedence order, set the `xdl_opts_command_line` member
     +    Enforce precedence of diff algorithm by favoring the command line option,
     +    then looking at the driver attributes & config combination, then finally
     +    the diff.algorithm config.
     +
     +    To enforce precedence order, use the `xdl_opts_command_line` member
          during options pasing to indicate the diff algorithm was set via command
          line args.
      
     @@ Documentation/gitattributes.txt: String::
       	by the configuration variables in the "diff.foo" section of the
       	Git config file.
       
     -+`diff-algorithm`
     -+^^^^^^^^^^^^^^^^
     -+
     -+The attribute `diff-algorithm` affects which algorithm Git uses to generate
     -+diffs. This allows defining diff algorithms per file extension. Precedence rules
     -+are as follows, in order from highest to lowest:
     +-
     + Defining an external diff driver
     + ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     + 
     +@@ Documentation/gitattributes.txt: with the above configuration, i.e. `j-c-diff`, with 7
     + parameters, just like `GIT_EXTERNAL_DIFF` program is called.
     + See linkgit:git[1] for details.
     + 
     ++Setting the internal diff algorithm
     ++^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      +
     -+*Command line option*
     ++The diff algorithm can be set through the `diff.algorithm` config key, but
     ++sometimes it may be helpful to set the diff algorithm by path. For example, one
     ++might wish to set a diff algorithm automatically for all `.json` files such that
     ++the user would not need to pass in a separate command line `--diff-algorithm` flag each
     ++time.
      +
     -+Pass in the `--diff-algorithm` command line option int git-diff(1)
     ++First, in `.gitattributes`, you would assign the `diff` attribute for paths.
      +
      +*Git attributes*
     -+
      +------------------------
     -+*.json	diff-algorithm=histogram
     ++*.json diff=<name>
      +------------------------
      +
     ++Then, you would define a "diff.<name>.algorithm" configuration to specify the
     ++diff algorithm, choosing from `meyers`, `patience`, `minimal`, and `histogram`.
     ++
     ++*Git config*
     ++
     ++----------------------------------------------------------------
     ++[diff "<name>"]
     ++  algorithm = histogram
     ++----------------------------------------------------------------
     ++
     ++This diff algorithm applies to git-diff(1), including the `--stat` output.
     ++
     ++NOTE: If the `command` key also exists, then Git will treat this as an external
     ++diff and attempt to use the value set for `command` as an external program. For
     ++instance, the following config, combined with the above `.gitattributes` file,
     ++will result in `command` favored over `algorithm`.
     ++
      +*Git config*
      +
      +----------------------------------------------------------------
     -+[diff]
     -+	algorithm = histogram
     ++[diff "<name>"]
     ++  command = j-c-diff
     ++  algorithm = histogram
      +----------------------------------------------------------------
       
     - Defining an external diff driver
     - ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     + Defining a custom hunk-header
     + ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      
       ## diff.c ##
     -@@ diff.c: static void builtin_diff(const char *name_a,
     - 		ecbdata.opt = o;
     - 		if (header.len && !o->flags.suppress_diff_headers)
     - 			ecbdata.header = &header;
     -+
     -+		if (!o->xdl_opts_command_line) {
     -+			static struct attr_check *check;
     -+			const char *one_diff_algo;
     -+			const char *two_diff_algo;
     -+
     -+			check = attr_check_alloc();
     -+			attr_check_append(check, git_attr("diff-algorithm"));
     -+
     -+			git_check_attr(the_repository->index, NULL, one->path, check);
     -+			one_diff_algo = check->items[0].value;
     -+			git_check_attr(the_repository->index, NULL, two->path, check);
     -+			two_diff_algo = check->items[0].value;
     -+
     -+			if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(two_diff_algo) &&
     -+				!strcmp(one_diff_algo, two_diff_algo))
     -+				set_diff_algorithm(o, one_diff_algo);
     -+
     -+			attr_check_free(check);
     -+		}
     -+
     - 		xpp.flags = o->xdl_opts;
     - 		xpp.ignore_regex = o->ignore_regex;
     - 		xpp.ignore_regex_nr = o->ignore_regex_nr;
     +@@ diff.c: static void run_diff_cmd(const char *pgm,
     + 	const char *xfrm_msg = NULL;
     + 	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
     + 	int must_show_header = 0;
     ++	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, attr_path);
     + 
     +-
     +-	if (o->flags.allow_external) {
     +-		struct userdiff_driver *drv;
     +-
     +-		drv = userdiff_find_by_path(o->repo->index, attr_path);
     ++	if (o->flags.allow_external)
     + 		if (drv && drv->external)
     + 			pgm = drv->external;
     +-	}
     + 
     + 	if (msg) {
     + 		/*
     +@@ diff.c: static void run_diff_cmd(const char *pgm,
     + 		run_external_diff(pgm, name, other, one, two, xfrm_msg, o);
     + 		return;
     + 	}
     +-	if (one && two)
     ++	if (one && two) {
     ++		if (!o->xdl_opts_command_line)
     ++			if (drv && drv->algorithm)
     ++				set_diff_algorithm(o, drv->algorithm);
     ++
     + 		builtin_diff(name, other ? other : name,
     + 			     one, two, xfrm_msg, must_show_header,
     + 			     o, complete_rewrite);
     +-	else
     ++	} else {
     + 		fprintf(o->file, "* Unmerged path %s\n", name);
     ++	}
     + }
     + 
     + static void diff_fill_oid_info(struct diff_filespec *one, struct index_state *istate)
     +@@ diff.c: static void run_diffstat(struct diff_filepair *p, struct diff_options *o,
     + 	const char *name;
     + 	const char *other;
     + 
     ++	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
     ++	if (drv && drv->algorithm)
     ++		set_diff_algorithm(o, drv->algorithm);
     ++
     + 	if (DIFF_PAIR_UNMERGED(p)) {
     + 		/* unmerged */
     + 		builtin_diffstat(p->one->path, NULL, NULL, NULL,
      @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
       		return error(_("option diff-algorithm accepts \"myers\", "
       			       "\"minimal\", \"patience\" and \"histogram\""));
     @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
       }
       
      @@ diff.c: static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
     - 		return error(_("available diff algorithms include \"myers\", "
     - 			       "\"minimal\", \"patience\" and \"histogram\""));
     + 		BUG("available diff algorithms include \"myers\", "
     + 			       "\"minimal\", \"patience\" and \"histogram\"");
       
      +	options->xdl_opts_command_line = 1;
      +
     @@ diff.h: struct diff_options {
       	char **anchors;
      
       ## t/lib-diff-alternative.sh ##
     -@@ t/lib-diff-alternative.sh: EOF
     +@@ t/lib-diff-alternative.sh: index $file1..$file2 100644
     +  }
     + EOF
       
     ++	cat >expect_diffstat <<EOF
     ++ file1 => file2 | 21 ++++++++++-----------
     ++ 1 file changed, 10 insertions(+), 11 deletions(-)
     ++EOF
     ++
       	STRATEGY=$1
       
      +	test_expect_success "$STRATEGY diff from attributes" '
     -+		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
     ++		echo "file* diff=driver" >.gitattributes &&
     ++		git config diff.driver.algorithm "$STRATEGY" &&
      +		test_must_fail git diff --no-index file1 file2 > output &&
     ++		cat expect &&
     ++		cat output &&
      +		test_cmp expect output
      +	'
     ++
     ++	test_expect_success "$STRATEGY diff from attributes has valid diffstat" '
     ++		echo "file* diff=driver" >.gitattributes &&
     ++		git config diff.driver.algorithm "$STRATEGY" &&
     ++		test_must_fail git diff --stat --no-index file1 file2 > output &&
     ++		test_cmp expect_diffstat output
     ++	'
      +
       	test_expect_success "$STRATEGY diff" '
      -		test_must_fail git diff --no-index "--$STRATEGY" file1 file2 > output &&
     @@ t/lib-diff-alternative.sh: EOF
      +	'
      +
      +	test_expect_success "$STRATEGY diff command line precedence before attributes" '
     -+		echo "file* diff-algorithm=meyers" >.gitattributes &&
     ++		echo "file* diff=driver" >.gitattributes &&
     ++		git config diff.driver.algorithm meyers &&
      +		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
      +		test_cmp expect output
      +	'
      +
      +	test_expect_success "$STRATEGY diff attributes precedence before config" '
      +		git config diff.algorithm default &&
     -+		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
     -+		test_must_fail git diff --no-index "--diff-algorithm=$STRATEGY" file1 file2 > output &&
     ++		echo "file* diff=driver" >.gitattributes &&
     ++		git config diff.driver.algorithm "$STRATEGY" &&
     ++		test_must_fail git diff --no-index file1 file2 > output &&
       		test_cmp expect output
       	'
       
     -@@ t/lib-diff-alternative.sh: EOF
     - 		test_must_fail git diff --no-index "--$STRATEGY" uniq1 uniq2 > output &&
     - 		test_cmp expect output
     - 	'
     -+
     -+	test_expect_success "$STRATEGY diff from attributes" '
     -+		echo "file* diff-algorithm=$STRATEGY" >.gitattributes &&
     -+		test_must_fail git diff --no-index uniq1 uniq2 > output &&
     -+		test_cmp expect output
     -+	'
     - }
     +
     + ## userdiff.c ##
     +@@ userdiff.c: PATTERNS("scheme",
     + 	 "|([^][)(}{[ \t])+"),
     + PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
     + 	 "\\\\[a-zA-Z@]+|\\\\.|[a-zA-Z0-9\x80-\xff]+"),
     +-{ "default", NULL, -1, { NULL, 0 } },
     ++{ "default", NULL, NULL, -1, { NULL, 0 } },
     + };
     + #undef PATTERNS
     + #undef IPATTERN
     +@@ userdiff.c: int userdiff_config(const char *k, const char *v)
     + 		return parse_bool(&drv->textconv_want_cache, k, v);
     + 	if (!strcmp(type, "wordregex"))
     + 		return git_config_string(&drv->word_regex, k, v);
     ++	if (!strcmp(type, "algorithm"))
     ++		return git_config_string(&drv->algorithm, k, v);
       
     + 	return 0;
     + }
     +
     + ## userdiff.h ##
     +@@ userdiff.h: struct userdiff_funcname {
     + struct userdiff_driver {
     + 	const char *name;
     + 	const char *external;
     ++	const char *algorithm;
     + 	int binary;
     + 	struct userdiff_funcname funcname;
     + 	const char *word_regex;

-- 
gitgitgadget
