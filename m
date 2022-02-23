Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A362C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 01:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiBWBmW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 20:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbiBWBmW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 20:42:22 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E9506D8
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 17:41:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id bq11so20025504edb.2
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 17:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hI1Q/BMoaFVAnFuchtlqMF7N8nR/9nzPuGMRytWUIyY=;
        b=WoQbNvpurpz54ULWpg76+S5PXEvn+R2CUdwcS8YgUQ9ACvJi9rga7Nkcj0qnY9eZxM
         zj+KQA+icKeEhRM6G1DQoqCRe68JulCGF9usvdDVwpuDXafzDvsWECgVLDiuBFlpl+wO
         XIVBKUYfY4abS9VaQreNFLQmw/wCosNy4Lj98GOKWSuBYVy6TWeYGw/vk3Y5krBIYgcp
         RM0RdikHYlHJ90d2nt0Vf9dd6owry4LJ4H2HfFUFxx3yQdwY4o2NoxMuV8YFbCO8eX75
         rcGpDjiNc7Ccf5QkjPwgRGlq9oDoJEqIC0J2aRXeWGcRNEto3+pH36AOZvgXiSp3JCAE
         xuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hI1Q/BMoaFVAnFuchtlqMF7N8nR/9nzPuGMRytWUIyY=;
        b=QLj+2esw5FQ43v0ghFCWuGLivNqLF7jolXy9Q9PCbxddcYhdXlTqOsoj7jHOZXatyL
         3V2oRmALVKN/3t/PDsacoKQdS27xT7joP9sbjcYa2EfihYfC52P+iXJlNgrSP640yp8v
         rMzgFP97ljybbHgrJzsb0ziQhQjkAr3kapWG3Vj/OcV2iTUIjYEnMnK/EQL84Iyp7HBE
         isF9CnmLyq/ZecRuAkxVlCWbpCaOSHq83FVaiiCVLpTX6wtQTaZ84M8dhS5wzLNFGi8e
         EUOu1OvjTaKV3Mjwx3vaaSIIiac1c16Vo57NNf6IMsPKGRJ/nQ/aXAjQW2LpvDUg/4D3
         e3qg==
X-Gm-Message-State: AOAM532Kg7BIp5ouy9MWL5G0Vf1QJreYIeOkrJhygifyRsZJRyLrXbY/
        GOX3Kxuz3ERwxv+Ez7WYhS8agu2m+WHVE1GdnOs=
X-Google-Smtp-Source: ABdhPJwYR0BrVVAe95DvOjWBskd2/emc2PvGjWgRIDeCNb2BGszcqMETQMmM+Sk4HtdELGLuKm1Iuj0HCsye3LAaGtQ=
X-Received: by 2002:a05:6402:11cd:b0:410:d432:2e30 with SMTP id
 j13-20020a05640211cd00b00410d4322e30mr29107418edw.119.1645580513216; Tue, 22
 Feb 2022 17:41:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com> <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Feb 2022 17:41:41 -0800
Message-ID: <CABPp-BEOX+zxR9-yyx-EaiOV-Z9yD0YP_Kwvu4iGB8enz40XXQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/14] Finish converting git bisect into a built-in
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 22, 2022 at 8:30 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> After three GSoC/Outreachy students spent an incredible effort on this, it
> is finally time to put a neat little bow on it.
>
> Changes since v1:
>
>  * Added a regression test to "bisect run: fix the error message".
>  * Added a patch to address an error message that double-single-quoted the
>    command.
>  * Reworked the logic in "bisect--helper: make --bisect-state optional" to
>    delay showing the usage upon an unknown command, which should make the
>    code a lot less confusing.
>  * Split out the change that moved the BISECT_STATE case to the end of the
>    switch block.
>  * Added a patch that replaces the return error() calls in
>    cmd_bisect_helper() with die() calls, to avoid returning -1 as an exit
>    code.
>  * Dropped the use of parse_options() for the single purpose of handling -h;
>    This is now done explicitly.
>  * Simplified the diff of "bisect: move even the option parsing to
>    bisect--helper" by modifying argc and argv instead of modifying all the
>    function calls using those variables.
>  * In the "Turn git bisect into a full built-in" patch, changed the name of
>    the variable holding the usage to use the builtin_ prefix used in other
>    built-ins, too.
>  * Removed the trailing dot from the commit message of "Turn git bisect into
>    a full built-in".
>
> Johannes Schindelin (14):
>   bisect run: fix the error message
>   bisect: avoid double-quoting when printing the failed command
>   bisect--helper: retire the --no-log option
>   bisect--helper: really retire --bisect-next-check
>   bisect--helper: really retire `--bisect-autostart`
>   bisect--helper: using `--bisect-state` without an argument is a bug
>   bisect--helper: align the sub-command order with git-bisect.sh
>   bisect--helper: make `--bisect-state` optional
>   bisect--helper: move the `BISECT_STATE` case to the end
>   bisect--helper: return only correct exit codes in `cmd_*()`
>   bisect: move even the option parsing to `bisect--helper`
>   Turn `git bisect` into a full built-in
>   bisect: remove Cogito-related code
>   bisect: no longer try to clean up left-over `.git/head-name` files
>
>  Makefile                               |   3 +-
>  bisect.c                               |   3 -
>  builtin.h                              |   2 +-
>  builtin/{bisect--helper.c => bisect.c} | 189 ++++++++++---------------
>  git-bisect.sh                          |  84 -----------
>  git.c                                  |   2 +-
>  t/t6030-bisect-porcelain.sh            |  11 +-
>  7 files changed, 88 insertions(+), 206 deletions(-)
>  rename builtin/{bisect--helper.c => bisect.c} (88%)
>  delete mode 100755 git-bisect.sh
>
>
> base-commit: 89bece5c8c96f0b962cfc89e63f82d603fd60bed
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2Fdscho%2Fbisect-in-c-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho/bisect-in-c-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1132
>
> Range-diff vs v1:
>
>   1:  93d19d85ee3 !  1:  81ca0d68cde bisect run: fix the error message
>      @@ Commit message
>           was "good" or "bad", but used a bogus (because non-populated) `args`
>           variable for it.
>
>      +    Helped-by: Elijah Newren <newren@gmail.com>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>        ## builtin/bisect--helper.c ##
>      @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
>                 strvec_clear(&run_args);
>                 return res;
>         }
>      +
>      + ## t/t6030-bisect-porcelain.sh ##
>      +@@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect visualize with a filename with dash and space' '
>      +  git bisect visualize -p -- "-hello 2"
>      + '
>      +
>      ++test_expect_success 'testing' '
>      ++ git bisect reset &&
>      ++ git bisect start $HASH4 $HASH1 &&
>      ++ write_script test_script.sh <<-\EOF &&
>      ++ rm .git/BISECT*
>      ++ EOF
>      ++ test_must_fail git bisect run ./test_script.sh 2>error &&
>      ++ grep "git bisect good.*exited with error code" error
>      ++'
>      ++
>      + test_done
>   -:  ----------- >  2:  4320101f2e0 bisect: avoid double-quoting when printing the failed command
>   2:  8e0e5559980 =  3:  88d7173c86b bisect--helper: retire the --no-log option
>   3:  996a7099bf8 =  4:  b914fe64dda bisect--helper: really retire --bisect-next-check
>   4:  3de4c48b66d =  5:  0d3db63bda6 bisect--helper: really retire `--bisect-autostart`
>   8:  1b14ed3d797 =  6:  a345cf3e0e4 bisect--helper: using `--bisect-state` without an argument is a bug
>   5:  6afc6e0eece =  7:  0487701220b bisect--helper: align the sub-command order with git-bisect.sh
>   6:  eddbdde222a !  8:  d8b2767c148 bisect--helper: make `--bisect-state` optional
>      @@ Commit message
>           `git bisect--helper bad`, i.e. do not require the `--bisect-state`
>           option to be passed explicitly.
>
>      -    To prepare for converting `bisect--helper` to a full built-in
>      -    implementation of `git bisect` (which must not require the
>      -    `--bisect-state` option to be specified at all), let's move the handling
>      -    toward the end of the `switch (cmdmode)` block.
>      -
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>        ## builtin/bisect--helper.c ##
>      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, co
>                              git_bisect_helper_usage,
>                              PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
>
>      -+ if (!cmdmode && argc > 0) {
>      -+         set_terms(&terms, "bad", "good");
>      -+         get_terms(&terms);
>      -+         if (!check_and_set_terms(&terms, argv[0]))
>      -+                 cmdmode = BISECT_STATE;
>      -+ }
>      -+
>      -  if (!cmdmode)
>      -          usage_with_options(git_bisect_helper_usage, options);
>      -
>      -@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>      +- if (!cmdmode)
>      +-         usage_with_options(git_bisect_helper_usage, options);
>      +-
>      +- switch (cmdmode) {
>      ++ switch (cmdmode ? cmdmode : BISECT_STATE) {
>      +  case BISECT_START:
>                 set_terms(&terms, "bad", "good");
>                 res = bisect_start(&terms, argv, argc);
>      -          break;
>      -- case BISECT_STATE:
>      --         set_terms(&terms, "bad", "good");
>      --         get_terms(&terms);
>      --         res = bisect_state(&terms, argv, argc);
>      --         break;
>      -  case BISECT_TERMS:
>      -          if (argc > 1)
>      -                  return error(_("--bisect-terms requires 0 or 1 argument"));
>       @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>      +  case BISECT_STATE:
>      +          set_terms(&terms, "bad", "good");
>                 get_terms(&terms);
>      -          res = bisect_run(&terms, argv, argc);
>      -          break;
>      -+ case BISECT_STATE:
>      -+         if (!terms.term_good) {
>      -+                 set_terms(&terms, "bad", "good");
>      -+                 get_terms(&terms);
>      ++         if (!cmdmode &&
>      ++             (!argc || check_and_set_terms(&terms, argv[0]))) {
>      ++                 char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
>      ++                 usage_msg_opt(msg, git_bisect_helper_usage, options);
>       +         }
>      -+         res = bisect_state(&terms, argv, argc);
>      -+         break;
>      -  default:
>      -          BUG("unknown subcommand %d", cmdmode);
>      -  }
>      +          res = bisect_state(&terms, argv, argc);
>      +          break;
>      +  case BISECT_TERMS:
>      +
>      + ## git-bisect.sh ##
>      +@@ git-bisect.sh: case "$#" in
>      +  start)
>      +          git bisect--helper --bisect-start "$@" ;;
>      +  bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>      +-         git bisect--helper --bisect-state "$cmd" "$@" ;;
>      ++         git bisect--helper "$cmd" "$@" ;;
>      +  skip)
>      +          git bisect--helper --bisect-skip "$@" || exit;;
>      +  next)
>   -:  ----------- >  9:  e8904db81c5 bisect--helper: move the `BISECT_STATE` case to the end
>   -:  ----------- > 10:  208f8fa4851 bisect--helper: return only correct exit codes in `cmd_*()`
>   7:  515e86e2075 ! 11:  dc04b06206b bisect: move even the option parsing to `bisect--helper`
>      @@ Commit message
>           together. So it would appear as if a lot of work would have to be done
>           just to be able to use `parse_options()` just to parse the sub-command,
>           instead of a simple `if...else if` chain, the latter being a
>      -    dramatically simpler implementation. Therefore, we now keep the
>      -    `parse_options()` call primarily to support `-h` and little else.
>      +    dramatically simpler implementation.
>
>           Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>
>      @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
>       - argc = parse_options(argc, argv, prefix, options,
>       -                      git_bisect_helper_usage,
>       -                      PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
>      -+ /* Handle -h and invalid options */
>      -+ parse_options(argc - 1, argv + 1, prefix, options,
>      -+               git_bisect_usage,
>      -+               PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN |
>      -+               PARSE_OPT_ONE_SHOT | PARSE_OPT_STOP_AT_NON_OPTION);
>      -
>      -- if (!cmdmode && argc > 0) {
>      -+ if (!strcmp("help", command))
>      ++ if (!strcmp("-h", command) || !strcmp("help", command))
>       +         usage_with_options(git_bisect_usage, options);
>      -+ else if (!strcmp("start", command)) {
>      -          set_terms(&terms, "bad", "good");
>      --         get_terms(&terms);
>      --         if (!check_and_set_terms(&terms, argv[0]))
>      --                 cmdmode = BISECT_STATE;
>      -- }
>      --
>      -- if (!cmdmode)
>      --         usage_with_options(git_bisect_helper_usage, options);
>      --
>      -- switch (cmdmode) {
>      +
>      +- switch (cmdmode ? cmdmode : BISECT_STATE) {
>       - case BISECT_START:
>      --         set_terms(&terms, "bad", "good");
>      --         res = bisect_start(&terms, argv, argc);
>      ++ argc -= 2;
>      ++ argv += 2;
>      ++
>      ++ if (!strcmp("start", command)) {
>      +          set_terms(&terms, "bad", "good");
>      +          res = bisect_start(&terms, argv, argc);
>       -         break;
>       - case BISECT_TERMS:
>      --         if (argc > 1)
>      --                 return error(_("--bisect-terms requires 0 or 1 argument"));
>      --         res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
>      ++ } else if (!strcmp("terms", command)) {
>      +          if (argc > 1)
>      +-                 die(_("--bisect-terms requires 0 or 1 argument"));
>      ++                 die(_("'terms' requires 0 or 1 argument"));
>      +          res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
>       -         break;
>       - case BISECT_SKIP:
>      -+         res = bisect_start(&terms, argv + 2, argc - 2);
>      -+ } else if (!strcmp("terms", command)) {
>      -+         if (argc > 3)
>      -+                 return error(_("'terms' requires 0 or 1 argument"));
>      -+         res = bisect_terms(&terms, argc == 3 ? argv[2] : NULL);
>       + } else if (!strcmp("skip", command)) {
>                 set_terms(&terms, "bad", "good");
>                 get_terms(&terms);
>      --         res = bisect_skip(&terms, argv, argc);
>      +          res = bisect_skip(&terms, argv, argc);
>       -         break;
>       - case BISECT_NEXT:
>      --         if (argc)
>      --                 return error(_("--bisect-next requires 0 arguments"));
>      -+         res = bisect_skip(&terms, argv + 2, argc - 2);
>       + } else if (!strcmp("next", command)) {
>      -+         if (argc != 2)
>      -+                 return error(_("'next' requires 0 arguments"));
>      +          if (argc)
>      +-                 die(_("--bisect-next requires 0 arguments"));
>      ++                 die(_("'next' requires 0 arguments"));
>                 get_terms(&terms);
>                 res = bisect_next(&terms, prefix);
>       -         break;
>       - case BISECT_RESET:
>      --         if (argc > 1)
>      --                 return error(_("--bisect-reset requires either no argument or a commit"));
>      --         res = bisect_reset(argc ? argv[0] : NULL);
>      ++ } else if (!strcmp("reset", command)) {
>      +          if (argc > 1)
>      +-                 die(_("--bisect-reset requires either no argument or a commit"));
>      ++                 die(_("'reset' requires either no argument or a commit"));
>      +          res = bisect_reset(argc ? argv[0] : NULL);
>       -         break;
>       - case BISECT_VISUALIZE:
>      -+ } else if (!strcmp("reset", command)) {
>      -+         if (argc > 3)
>      -+                 return error(_("'reset' requires either no argument or a commit"));
>      -+         res = bisect_reset(argc > 2 ? argv[2] : NULL);
>       + } else if (one_of(command, "visualize", "view", NULL)) {
>                 get_terms(&terms);
>      --         res = bisect_visualize(&terms, argv, argc);
>      +          res = bisect_visualize(&terms, argv, argc);
>       -         break;
>       - case BISECT_REPLAY:
>      --         if (argc != 1)
>      -+         res = bisect_visualize(&terms, argv + 2, argc - 2);
>       + } else if (!strcmp("replay", command)) {
>      -+         if (argc != 3)
>      -                  return error(_("no logfile given"));
>      +          if (argc != 1)
>      +                  die(_("no logfile given"));
>                 set_terms(&terms, "bad", "good");
>      --         res = bisect_replay(&terms, argv[0]);
>      +          res = bisect_replay(&terms, argv[0]);
>       -         break;
>       - case BISECT_LOG:
>      --         if (argc)
>      --                 return error(_("--bisect-log requires 0 arguments"));
>      -+         res = bisect_replay(&terms, argv[2]);
>       + } else if (!strcmp("log", command)) {
>      -+         if (argc > 2)
>      -+                 return error(_("'log' requires 0 arguments"));
>      +          if (argc)
>      +-                 die(_("--bisect-log requires 0 arguments"));
>      ++                 die(_("'log' requires 0 arguments"));
>                 res = bisect_log();
>       -         break;
>       - case BISECT_RUN:
>      --         if (!argc)
>       + } else if (!strcmp("run", command)) {
>      -+         if (argc < 3)
>      -                  return error(_("bisect run failed: no command provided."));
>      +          if (!argc)
>      +                  die(_("bisect run failed: no command provided."));
>                 get_terms(&terms);
>      --         res = bisect_run(&terms, argv, argc);
>      +          res = bisect_run(&terms, argv, argc);
>       -         break;
>       - case BISECT_STATE:
>      --         if (!terms.term_good) {
>      --                 set_terms(&terms, "bad", "good");
>      --                 get_terms(&terms);
>      -+         res = bisect_run(&terms, argv + 2, argc - 2);
>       + } else {
>      -+         set_terms(&terms, "bad", "good");
>      -+         get_terms(&terms);
>      -+         if (!check_and_set_terms(&terms, command))
>      -+                 res = bisect_state(&terms, argv + 1, argc - 1);
>      -+         else {
>      +          set_terms(&terms, "bad", "good");
>      +          get_terms(&terms);
>      +-         if (!cmdmode &&
>      +-             (!argc || check_and_set_terms(&terms, argv[0]))) {
>      +-                 char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
>      +-                 usage_msg_opt(msg, git_bisect_helper_usage, options);
>      ++         if (check_and_set_terms(&terms, command)) {
>       +                 char *msg = xstrfmt(_("unknown command: '%s'"), command);
>       +                 usage_msg_opt(msg, git_bisect_usage, options);
>                 }
>      --         res = bisect_state(&terms, argv, argc);
>      ++         /* shift the `command` back in */
>      ++         argc++;
>      ++         argv--;
>      +          res = bisect_state(&terms, argv, argc);
>       -         break;
>       - default:
>       -         BUG("unknown subcommand %d", cmdmode);
>      @@ git-bisect.sh: Please use "git help bisect" to get the full man page.'
>       - start)
>       -         git bisect--helper --bisect-start "$@" ;;
>       - bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
>      --         git bisect--helper --bisect-state "$cmd" "$@" ;;
>      +-         git bisect--helper "$cmd" "$@" ;;
>       - skip)
>       -         git bisect--helper --bisect-skip "$@" || exit;;
>       - next)
>   9:  1c0bd8a326f ! 12:  7db4b03b668 Turn `git bisect` into a full built-in.
>      @@ Metadata
>       Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
>        ## Commit message ##
>      -    Turn `git bisect` into a full built-in.
>      +    Turn `git bisect` into a full built-in
>
>           Now that the shell script hands off to the `bisect--helper` to do
>           _anything_ (except to show the help), it is but a tiny step to let the
>      @@ builtin.h: int cmd_am(int argc, const char **argv, const char *prefix);
>        int cmd_bugreport(int argc, const char **argv, const char *prefix);
>
>        ## builtin/bisect--helper.c => builtin/bisect.c ##
>      +@@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>      + static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
>      + static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
>      +
>      +-static const char * const git_bisect_usage[] = {
>      ++static const char * const builtin_bisect_usage[] = {
>      +  N_("git bisect help\n"
>      +     "\tprint this long help message."),
>      +  N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]\n"
>       @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
>         }
>        }
>      @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, const char *
>        {
>         int res = 0;
>         struct option options[] = {
>      +@@ builtin/bisect.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>      +  const char *command = argc > 1 ? argv[1] : "help";
>      +
>      +  if (!strcmp("-h", command) || !strcmp("help", command))
>      +-         usage_with_options(git_bisect_usage, options);
>      ++         usage_with_options(builtin_bisect_usage, options);
>      +
>      +  argc -= 2;
>      +  argv += 2;
>      +@@ builtin/bisect.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>      +          get_terms(&terms);
>      +          if (check_and_set_terms(&terms, command)) {
>      +                  char *msg = xstrfmt(_("unknown command: '%s'"), command);
>      +-                 usage_msg_opt(msg, git_bisect_usage, options);
>      ++                 usage_msg_opt(msg, builtin_bisect_usage, options);
>      +          }
>      +          /* shift the `command` back in */
>      +          argc++;
>
>        ## git-bisect.sh (deleted) ##
>       @@
>  10:  cce533486db = 13:  0611d16f772 bisect: remove Cogito-related code
>  11:  dc77297c676 = 14:  e2fa11a819e bisect: no longer try to clean up left-over `.git/head-name` files
>
> --
> gitgitgadget

You've addressed all my feedback from v1, and I've looked over the
changes and they look good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
