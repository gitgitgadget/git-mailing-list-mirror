Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0E3C636D6
	for <git@archiver.kernel.org>; Fri, 17 Feb 2023 20:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjBQUVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Feb 2023 15:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBQUVa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2023 15:21:30 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598905F812
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:21:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l8so2051858wrv.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2023 12:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VD7c4H43cC7QFtVZIU8sHpEkzbvRGmYxytP3lIp5DIU=;
        b=mo+/X07kyL0AonkbVK6bOY8el3oIbyMxh7jzOxoMg4DXBeJ6013VbSN/98oiqiILwU
         fejR43DheS6XLB7mSbChNDDExY0ky3IHDbdgBau9m6txELswk50EkAq5PgcPnjHQgjU1
         Fg+yTOhrzwfVCnwA4tNe+99HU1vlr9eIl+CeRUPPJea8Um1ss4WDc0x9tdTwNsLsAWok
         wXQ7n6cy6YOtjIo3vU0CJnDGgoyH3euBmCLCvekPPFi+mBqsDVYwNruX6m62eOKRaMpS
         4n3TsrMENneO9QOitReLF5biKVPgQoXgN0dUXFkndNdxNiU0rmPL4nNwJs10Dm0MyyQU
         w2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VD7c4H43cC7QFtVZIU8sHpEkzbvRGmYxytP3lIp5DIU=;
        b=sbagHLPRq9TU03PPKtKLu3eeyfLeaBKe/F3fHCtWYZAXvnonIYHTVSvOByWAhsq505
         zF6C7HUEIvMiY360T8jKaouzkD1umkbNw5N0UZxIttHB3h+2sLz/9HzVM74M86ZNHkzZ
         DdthKmuJK+NqeABMpzRupemTRMdeZXJVwcF14YlhccldlXUQLRIdczVjA2erPOXl73Pz
         a75UYPxJRxJsh9d2i7AdUHGtlE9/zHiIwTjZk9xaL+/my2ATL6mOYBNToQaLFnSndN/p
         zP4IYI9uKoPqw6hIUl3sHqPlsGeIX7zpi/CXNi77K3ShjiYgA/lQoFWaHgk9/0uC1LlB
         kYyA==
X-Gm-Message-State: AO0yUKW9cVNKzaiPykavlP0iZ5UTKGHfQlDtm35853kUepzaaflXyJsi
        nHO3vcxoS1ZuWr+BbxwuKUDbltpCqp0=
X-Google-Smtp-Source: AK7set8lN2Hwtmdh5ecMBijKv/21yefnKwEFMle/5t7ovW4hA4PXmBVgxD+IkleHUXjSDDAIW4eB8w==
X-Received: by 2002:a5d:6882:0:b0:2c3:fb3e:ae85 with SMTP id h2-20020a5d6882000000b002c3fb3eae85mr10579160wru.44.1676665286306;
        Fri, 17 Feb 2023 12:21:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s5-20020adfeb05000000b002c54c0a5aa9sm5169385wrn.74.2023.02.17.12.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:21:25 -0800 (PST)
Message-Id: <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Feb 2023 20:21:23 +0000
Subject: [PATCH v3 0/2] Teach diff to honor diff algorithms set through git attributes
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

Teach the diff machinery to check gitattributes when diffing files by using
the existing diff. scheme, and add an "algorithm" type to the external
driver config.

Changes since V2:

 * minor clean up and variable renaming
 * avoid parsing attribute files for the driver if the diff algorithm is set
   through the command line

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
  diff: teach diff to read algorithm from diff driver

 Documentation/gitattributes.txt | 37 ++++++++++++++
 diff.c                          | 90 ++++++++++++++++++++++++---------
 diff.h                          |  1 +
 t/lib-diff-alternative.sh       | 38 +++++++++++++-
 userdiff.c                      |  4 +-
 userdiff.h                      |  1 +
 6 files changed, 146 insertions(+), 25 deletions(-)


base-commit: c867e4fa180bec4750e9b54eb10f459030dbebfd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1452%2Fjohn-cai%2Fjc%2Fattr-diff-algo-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1452/john-cai/jc/attr-diff-algo-v3
Pull-Request: https://github.com/git/git/pull/1452

Range-diff vs v2:

 1:  0c5e1fc6c26 ! 1:  816c47aa414 diff: consolidate diff algorithm option parsing
     @@ Metadata
       ## Commit message ##
          diff: consolidate diff algorithm option parsing
      
     -    The diff option parsing for --minimal, --patience, --histgoram can all
     -    be consolidated into one function. This is a preparatory step for the
     -    subsequent commit which teaches diff to keep track of whether or not a
     -    diff algorithm has been set via the command line.
     +    A subsequent commit will need the ability to tell if the diff algorithm
     +    was set through the command line through setting a new member of
     +    diff_options. While this logic can be added to the
     +    diff_opt_diff_algorithm() callback, the `--minimal` and `--histogram`
     +    options are handled via OPT_BIT without a callback.
      
     -    Additionally, the logic that sets the diff algorithm in
     -    diff_opt_diff_algorithm() can  be refactored into a helper that will
     +    Remedy this by consolidating the options parsing logic for --minimal and
     +    --histogram into one callback. This way we can modify `diff_options` in
     +    that function.
     +
     +    As an additional refactor, the logic that sets the diff algorithm in
     +    diff_opt_diff_algorithm() can be refactored into a helper that will
          allow multiple callsites to set the diff algorithm.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
     @@ diff.c: static int diff_filepair_is_phoney(struct diff_filespec *one,
      +	long value = parse_algorithm_value(alg);
      +
      +	if (value < 0)
     -+		return 1;
     ++		return -1;
      +
      +	/* clear out previous settings */
      +	DIFF_XDL_CLR(opts, NEED_MINIMAL);
     @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
      +	BUG_ON_OPT_NEG(unset);
      +	BUG_ON_OPT_ARG(arg);
      +
     -+	if (!strcmp(opt->long_name, "patience")) {
     -+		size_t i;
     -+		/*
     -+		 * Both --patience and --anchored use PATIENCE_DIFF
     -+		 * internally, so remove any anchors previously
     -+		 * specified.
     -+		 */
     -+		for (i = 0; i < options->anchors_nr; i++)
     -+			free(options->anchors[i]);
     -+		options->anchors_nr = 0;
     -+	}
     -+
      +	if (set_diff_algorithm(options, opt->long_name))
      +		BUG("available diff algorithms include \"myers\", "
      +			       "\"minimal\", \"patience\" and \"histogram\"");
     @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
       	return 0;
       }
       
     -@@ diff.c: static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
     - 	return 0;
     - }
     +@@ diff.c: static int diff_opt_patience(const struct option *opt,
       
     --static int diff_opt_patience(const struct option *opt,
     --			     const char *arg, int unset)
     --{
     --	struct diff_options *options = opt->value;
     --	int i;
     --
     --	BUG_ON_OPT_NEG(unset);
     --	BUG_ON_OPT_ARG(arg);
     + 	BUG_ON_OPT_NEG(unset);
     + 	BUG_ON_OPT_ARG(arg);
      -	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
     --	/*
     --	 * Both --patience and --anchored use PATIENCE_DIFF
     --	 * internally, so remove any anchors previously
     --	 * specified.
     --	 */
     --	for (i = 0; i < options->anchors_nr; i++)
     --		free(options->anchors[i]);
     --	options->anchors_nr = 0;
     + 	/*
     + 	 * Both --patience and --anchored use PATIENCE_DIFF
     + 	 * internally, so remove any anchors previously
     +@@ diff.c: static int diff_opt_patience(const struct option *opt,
     + 	for (i = 0; i < options->anchors_nr; i++)
     + 		free(options->anchors[i]);
     + 	options->anchors_nr = 0;
      -	return 0;
     --}
     --
     ++
     ++	return set_diff_algorithm(options, "patience");
     + }
     + 
       static int diff_opt_ignore_regex(const struct option *opt,
     - 				 const char *arg, int unset)
     - {
      @@ diff.c: struct option *add_diff_options(const struct option *opts,
       			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
       
     @@ diff.c: struct option *add_diff_options(const struct option *opts,
       			  N_("ignore whitespace when comparing lines"),
       			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
      @@ diff.c: struct option *add_diff_options(const struct option *opts,
     - 		OPT_CALLBACK_F(0, "patience", options, NULL,
       			       N_("generate diff using the \"patience diff\" algorithm"),
       			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
     --			       diff_opt_patience),
     + 			       diff_opt_patience),
      -		OPT_BITOP(0, "histogram", &options->xdl_opts,
      -			  N_("generate diff using the \"histogram diff\" algorithm"),
      -			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
     -+			       diff_opt_diff_algorithm_no_arg),
      +		OPT_CALLBACK_F(0, "histogram", options, NULL,
      +			       N_("generate diff using the \"histogram diff\" algorithm"),
      +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 2:  cb030563149 ! 2:  b330222ce83 diff: teach diff to read gitattribute diff-algorithm
     @@ Metadata
      Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
     -    diff: teach diff to read gitattribute diff-algorithm
     +    diff: teach diff to read algorithm from diff driver
      
          It can be useful to specify diff algorithms per file type. For example,
          one may want to use the minimal diff algorithm for .json files, another
          for .c files, etc.
      
     -    Teach the diff machinery to check attributes for a diff driver. Also
     -    teach the diff driver parser a new type "algorithm" to look for in the
     +    The diff machinery already checks attributes for a diff driver. Teach
     +    the diff driver parser a new type "algorithm" to look for in the
          config, which will be used if a driver has been specified through the
          attributes.
      
     -    Enforce precedence of diff algorithm by favoring the command line option,
     -    then looking at the driver attributes & config combination, then finally
     -    the diff.algorithm config.
     +    Enforce precedence of the diff algorithm by favoring the command line
     +    option, then looking at the driver attributes & config combination, then
     +    finally the diff.algorithm config.
      
     -    To enforce precedence order, use the `xdl_opts_command_line` member
     +    To enforce precedence order, use a new `ignore_driver_algorithm` member
          during options pasing to indicate the diff algorithm was set via command
          line args.
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/gitattributes.txt ##
     -@@ Documentation/gitattributes.txt: String::
     - 	by the configuration variables in the "diff.foo" section of the
     - 	Git config file.
     - 
     --
     - Defining an external diff driver
     - ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     - 
      @@ Documentation/gitattributes.txt: with the above configuration, i.e. `j-c-diff`, with 7
       parameters, just like `GIT_EXTERNAL_DIFF` program is called.
       See linkgit:git[1] for details.
     @@ Documentation/gitattributes.txt: with the above configuration, i.e. `j-c-diff`,
      +The diff algorithm can be set through the `diff.algorithm` config key, but
      +sometimes it may be helpful to set the diff algorithm by path. For example, one
      +might wish to set a diff algorithm automatically for all `.json` files such that
     -+the user would not need to pass in a separate command line `--diff-algorithm` flag each
     -+time.
     ++the user would not need to pass in a separate command line `--diff-algorithm`
     ++flag each time.
      +
     -+First, in `.gitattributes`, you would assign the `diff` attribute for paths.
     ++First, in `.gitattributes`, assign the `diff` attribute for paths.
      +
     -+*Git attributes*
      +------------------------
      +*.json diff=<name>
      +------------------------
      +
     -+Then, you would define a "diff.<name>.algorithm" configuration to specify the
     -+diff algorithm, choosing from `meyers`, `patience`, `minimal`, and `histogram`.
     -+
     -+*Git config*
     ++Then, define a "diff.<name>.algorithm" configuration to specify the diff
     ++algorithm, choosing from `meyers`, `patience`, `minimal`, or `histogram`.
      +
      +----------------------------------------------------------------
      +[diff "<name>"]
      +  algorithm = histogram
      +----------------------------------------------------------------
      +
     -+This diff algorithm applies to git-diff(1), including the `--stat` output.
     ++This diff algorithm applies to user facing diff output like git-diff(1),
     ++git-show(1) and is used for the `--stat` output as well. The merge machinery
     ++will not use the diff algorithm set through this method.
      +
      +NOTE: If the `command` key also exists, then Git will treat this as an external
      +diff and attempt to use the value set for `command` as an external program. For
      +instance, the following config, combined with the above `.gitattributes` file,
      +will result in `command` favored over `algorithm`.
      +
     -+*Git config*
     -+
      +----------------------------------------------------------------
      +[diff "<name>"]
      +  command = j-c-diff
     @@ diff.c: static void run_diff_cmd(const char *pgm,
       	const char *xfrm_msg = NULL;
       	int complete_rewrite = (p->status == DIFF_STATUS_MODIFIED) && p->score;
       	int must_show_header = 0;
     -+	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, attr_path);
     ++	struct userdiff_driver *drv = NULL;
       
      -
      -	if (o->flags.allow_external) {
      -		struct userdiff_driver *drv;
      -
     --		drv = userdiff_find_by_path(o->repo->index, attr_path);
     -+	if (o->flags.allow_external)
     - 		if (drv && drv->external)
     - 			pgm = drv->external;
     ++	if (o->flags.allow_external || !o->ignore_driver_algorithm)
     + 		drv = userdiff_find_by_path(o->repo->index, attr_path);
     +-		if (drv && drv->external)
     +-			pgm = drv->external;
      -	}
     ++
     ++	if (o->flags.allow_external && drv && drv->external)
     ++		pgm = drv->external;
       
       	if (msg) {
       		/*
     @@ diff.c: static void run_diff_cmd(const char *pgm,
       	}
      -	if (one && two)
      +	if (one && two) {
     -+		if (!o->xdl_opts_command_line)
     -+			if (drv && drv->algorithm)
     -+				set_diff_algorithm(o, drv->algorithm);
     ++		if (drv && !o->ignore_driver_algorithm && drv->algorithm)
     ++			set_diff_algorithm(o, drv->algorithm);
      +
       		builtin_diff(name, other ? other : name,
       			     one, two, xfrm_msg, must_show_header,
     @@ diff.c: static void run_diffstat(struct diff_filepair *p, struct diff_options *o
       	const char *name;
       	const char *other;
       
     -+	struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
     -+	if (drv && drv->algorithm)
     -+		set_diff_algorithm(o, drv->algorithm);
     ++	if (!o->ignore_driver_algorithm) {
     ++		struct userdiff_driver *drv = userdiff_find_by_path(o->repo->index, p->one->path);
     ++
     ++		if (drv && drv->algorithm) {
     ++			set_diff_algorithm(o, drv->algorithm);
     ++		}
     ++	}
      +
       	if (DIFF_PAIR_UNMERGED(p)) {
       		/* unmerged */
     @@ diff.c: static int diff_opt_diff_algorithm(const struct option *opt,
       		return error(_("option diff-algorithm accepts \"myers\", "
       			       "\"minimal\", \"patience\" and \"histogram\""));
       
     -+	options->xdl_opts_command_line = 1;
     ++	options->ignore_driver_algorithm = 1;
      +
       	return 0;
       }
     @@ diff.c: static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
       		BUG("available diff algorithms include \"myers\", "
       			       "\"minimal\", \"patience\" and \"histogram\"");
       
     -+	options->xdl_opts_command_line = 1;
     ++	options->ignore_driver_algorithm = 1;
      +
       	return 0;
       }
       
     +@@ diff.c: static int diff_opt_patience(const struct option *opt,
     + 	for (i = 0; i < options->anchors_nr; i++)
     + 		free(options->anchors[i]);
     + 	options->anchors_nr = 0;
     ++	options->ignore_driver_algorithm = 1;
     + 
     + 	return set_diff_algorithm(options, "patience");
     + }
      
       ## diff.h ##
      @@ diff.h: struct diff_options {
       	int prefix_length;
       	const char *stat_sep;
       	int xdl_opts;
     -+	/* If xdl_opts has been set via the command line. */
     -+	int xdl_opts_command_line;
     ++	int ignore_driver_algorithm;
       
       	/* see Documentation/diff-options.txt */
       	char **anchors;

-- 
gitgitgadget
