Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0578AECAAD2
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiH0Mog (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiH0Moc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D531370
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z16so4749669wrh.10
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=0Mb7o9Yn+vZL+ZTKUzkpUMwvEYrnqwHDkRBEM25GSZc=;
        b=FjwUYhAyAQHvmcUqV60NvUJXXi1Rd4JZp4RtsFbIz2ZVUGoYOx0HAttrSfuLdxKByq
         6hYXRii3L4S7f0blc1yBMdNbp71dfhHLbtU2/EK9JV8Tu0Cti2w537PIwLKiBfs/kpeg
         +YmwMkP7rCtVqv9thbh5muluFSGDwPEpA5YfjfbGZT/28fLur0YkuhoNF2jkmrqmnHPy
         Y9aYY0B/o+JATbwANB3JtBkAfHdwcYqUEH37WzIV1OzRe+b0Ix5wR2G+2+3xR+cpDErs
         dM8m0F7mV+Pflbwd6RV/4Fm3CB2TQPjmCpfet3uNXxwzt5pBmf2QLOpYljphnq/vedUE
         CH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=0Mb7o9Yn+vZL+ZTKUzkpUMwvEYrnqwHDkRBEM25GSZc=;
        b=mbN62a9dXAVzRS16xG3LAIW+qUeWJe6tesVBjxi8lnQJyIHuTtsLNMxNpfD2sGCnak
         OrANiLG/Bnb4g9soPtthEJtOzVVUG7nwsg2JuCJ/K4obkUD4KAut0hy1SiG4BODMH7cE
         91NeHN4qGN1UwDKI5oifULfYEmofzsz+rnXbr6UuMfIwzMhKPiT5MAi7j0hXThtL40qM
         2X3AyZVxHQbFcCjfToW5Bsl32t6LHdKATysqJJxsXc81hfJ70OTnUs7YYUcc1gnQlrEh
         6BARpcPCddr30NfwvZBPUHszFiP6CufBatDONfm2g+9fSAzoAEHOPRYG2Onn6141EcbN
         0Aow==
X-Gm-Message-State: ACgBeo05SSaJqbaqjEu0GEsLvkyPVDIXbfZ87aTHSPtIMfZYrxMV1JG6
        crCPnXAeC1/BWxHLbrmpxRL0YX0xF8Q=
X-Google-Smtp-Source: AA6agR4/+WIFk2cv7RzVlWOlaLjCSpoKUG5fqGudq+upKroYgj7BOOEHK9QY2P39ePPvkqhkIh0oFQ==
X-Received: by 2002:a5d:5a16:0:b0:226:9d43:1886 with SMTP id bq22-20020a5d5a16000000b002269d431886mr2123476wrb.219.1661604267481;
        Sat, 27 Aug 2022 05:44:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q2-20020adfdfc2000000b0022588460b94sm2217768wrn.76.2022.08.27.05.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:26 -0700 (PDT)
Message-Id: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:08 +0000
Subject: [PATCH v5 00/16] Finish converting git bisect into a built-in
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After three GSoC/Outreachy students spent an incredible effort on this, it
is finally time to put a neat little bow on it, or maybe more like a big
bow, maybe even a very large one, seeing as it takes quite a while to tie
(half a year at the time of writing)...

Changes since v4:

 * rebased onto sg/parse-options-subcommand
 * migrated to OPT_SUBCOMMAND().
 * As a consequence, this patch series is now unfortunately very large. And
   the range-diff is much less useful than I'd like because of the extensive
   changes that were de facto made a precondition to moving this patch
   series further. Junio, I would have liked to keep the scope (and burden
   for the reviewers) substantially smaller, maybe you can help with the
   review?

Changes since v3:

 * Rebased because of merge conflicts with ab/plug-leak-in-revisions.
 * Fixed the bug that git bisect --bisect-terms 1 2 wanted to auto-start a
   bisection if running with a git executable built at the in-between state
   at patch "bisect: move even the command-line parsing to bisect--helper".
   Since this bug was "fixed" in v3 by the very next patch, "bisect: teach
   the bisect--helper command to show the correct usage strings", v4 avoids
   introducing this bug simply by letting these two patches trade places.
   The range-diff admittedly looks quite awful because both patches overlap
   quite a bit in the lines they modify. The end result is the same, though,
   the diff between v3's and v4's builtin/bisect.c would be empty if I
   hadn't been forced to rebase.
 * Added a test case to ensure that this bug won't be introduced again. This
   test case is the only actual difference relative to v3 of this patch
   series.

Changes since v2:

 * We're now careful to provide identical usage strings upon git bisect -h
   and git bisect bogus.
 * When a bogus command is provided, we now error out instead of trying to
   start a git bisect run.
 * Rebased onto main to avoid plenty of merge conflicts with
   rs/bisect-executable-not-found, ac/usage-string-fixups and with
   cd/bisect-messages-from-pre-flight-states.

Changes since v1:

 * Added a regression test to "bisect run: fix the error message".
 * Added a patch to address an error message that double-single-quoted the
   command.
 * Reworked the logic in "bisect--helper: make --bisect-state optional" to
   delay showing the usage upon an unknown command, which should make the
   code a lot less confusing.
 * Split out the change that moved the BISECT_STATE case to the end of the
   switch block.
 * Added a patch that replaces the return error() calls in
   cmd_bisect_helper() with die() calls, to avoid returning -1 as an exit
   code.
 * Dropped the use of parse_options() for the single purpose of handling -h;
   This is now done explicitly.
 * Simplified the diff of "bisect: move even the option parsing to
   bisect--helper" by modifying argc and argv instead of modifying all the
   function calls using those variables.
 * In the "Turn git bisect into a full built-in" patch, changed the name of
   the variable holding the usage to use the builtin_ prefix used in other
   built-ins, too.
 * Removed the trailing dot from the commit message of "Turn git bisect into
   a full built-in".

Johannes Schindelin (16):
  bisect--helper: retire the --no-log option
  bisect--helper: really retire --bisect-next-check
  bisect--helper: really retire `--bisect-autostart`
  bisect--helper: simplify exit code computation
  bisect--helper: make `terms` an explicit singleton
  bisect--helper: make the order consistently `argc, argv`
  bisect--helper: migrate to OPT_SUBCOMMAND()
  bisect: verify that a bogus option won't try to start a bisection
  bisect run: fix the error message
  bisect: avoid double-quoting when printing the failed command
  bisect--helper: calling `bisect_state()` without an argument is a bug
  bisect--helper: make `state` optional
  bisect: move even the command-line parsing to `bisect--helper`
  Turn `git bisect` into a full built-in
  bisect: remove Cogito-related code
  bisect: no longer try to clean up left-over `.git/head-name` files

 Makefile                               |   3 +-
 bisect.c                               |   3 -
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 679 ++++++++++++++-----------
 git-bisect.sh                          |  84 ---
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            |  21 +-
 7 files changed, 406 insertions(+), 388 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (67%)
 delete mode 100755 git-bisect.sh


base-commit: 8f9d80f6c06369b563c76ec46c462e740a1a2cf0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1132%2Fdscho%2Fbisect-in-c-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1132/dscho/bisect-in-c-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1132

Range-diff vs v4:

  4:  5bfaf0334c3 =  1:  05262b6a7d1 bisect--helper: retire the --no-log option
  5:  e85f236304b =  2:  1e43148864a bisect--helper: really retire --bisect-next-check
  6:  b94b7bb4fd0 =  3:  1a1649d9d0d bisect--helper: really retire `--bisect-autostart`
  -:  ----------- >  4:  9ab30552c6a bisect--helper: simplify exit code computation
  -:  ----------- >  5:  92b3b116ef8 bisect--helper: make `terms` an explicit singleton
 11:  ce508583e45 !  6:  c9dc0281e38 bisect--helper: return only correct exit codes in `cmd_*()`
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    bisect--helper: return only correct exit codes in `cmd_*()`
     +    bisect--helper: make the order consistently `argc, argv`
      
     -    Exit codes cannot be negative, but `error()` returns -1.
     +    In C, the natural order is for `argc` to come before `argv` by virtue of
     +    the `main()` function declaring the parameters in precisely that order.
      
     -    Let's just go with the common pattern and call `die()` in
     -    `cmd_bisect__helper()` when incorrect arguments were detected.
     +    It is confusing & distracting, then, when readers familiar with the C
     +    language read code where that order is switched around.
     +
     +    Let's just change the order and avoid that type of developer friction.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     +@@ builtin/bisect--helper.c: static enum bisect_error bisect_auto_next(const char *prefix)
     + 	return bisect_next(prefix);
     + }
     + 
     +-static enum bisect_error bisect_start(const char **argv, int argc)
     ++static enum bisect_error bisect_start(int argc, const char **argv)
     + {
     + 	int no_checkout = 0;
     + 	int first_parent_only = 0;
     +@@ builtin/bisect--helper.c: static int bisect_autostart(void)
     + 	yesno = git_prompt(_("Do you want me to do it for you "
     + 			     "[Y/n]? "), PROMPT_ECHO);
     + 	res = tolower(*yesno) == 'n' ?
     +-		-1 : bisect_start(empty_strvec, 0);
     ++		-1 : bisect_start(0, empty_strvec);
     + 
     + 	return res;
     + }
     + 
     +-static enum bisect_error bisect_state(const char **argv,
     +-				      int argc)
     ++static enum bisect_error bisect_state(int argc, const char **argv)
     + {
     + 	const char *state;
     + 	int i, verify_expected = 1;
     +@@ builtin/bisect--helper.c: static int process_replay_line(struct strbuf *line)
     + 		struct strvec argv = STRVEC_INIT;
     + 		int res;
     + 		sq_dequote_to_strvec(rev, &argv);
     +-		res = bisect_start(argv.v, argv.nr);
     ++		res = bisect_start(argv.nr, argv.v);
     + 		strvec_clear(&argv);
     + 		return res;
     + 	}
     +@@ builtin/bisect--helper.c: static enum bisect_error bisect_replay(const char *filename)
     + 	return bisect_auto_next(NULL);
     + }
     + 
     +-static enum bisect_error bisect_skip(const char **argv, int argc)
     ++static enum bisect_error bisect_skip(int argc, const char **argv)
     + {
     + 	int i;
     + 	enum bisect_error res;
     +@@ builtin/bisect--helper.c: static enum bisect_error bisect_skip(const char **argv, int argc)
     + 			strvec_push(&argv_state, argv[i]);
     + 		}
     + 	}
     +-	res = bisect_state(argv_state.v, argv_state.nr);
     ++	res = bisect_state(argv_state.nr, argv_state.v);
     + 
     + 	strvec_clear(&argv_state);
     + 	return res;
     + }
     + 
     +-static int bisect_visualize(const char **argv, int argc)
     ++static int bisect_visualize(int argc, const char **argv)
     + {
     + 	struct strvec args = STRVEC_INIT;
     + 	int flags = RUN_COMMAND_NO_STDIN, res = 0;
     +@@ builtin/bisect--helper.c: static int verify_good(const char **quoted_argv)
     + 	return rc;
     + }
     + 
     +-static int bisect_run(const char **argv, int argc)
     ++static int bisect_run(int argc, const char **argv)
     + {
     + 	int res = BISECT_OK;
     + 	struct strbuf command = STRBUF_INIT;
     +@@ builtin/bisect--helper.c: static int bisect_run(const char **argv, int argc)
     + 		saved_stdout = dup(1);
     + 		dup2(temporary_stdout_fd, 1);
     + 
     +-		res = bisect_state(&new_state, 1);
     ++		res = bisect_state(1, &new_state);
     + 
     + 		fflush(stdout);
     + 		dup2(saved_stdout, 1);
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
       		break;
     - 	case BISECT_TERMS:
     - 		if (argc > 1)
     --			return error(_("--bisect-terms requires 0 or 1 argument"));
     -+			die(_("--bisect-terms requires 0 or 1 argument"));
     - 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
     - 		break;
     - 	case BISECT_SKIP:
     -@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     + 	case BISECT_START:
     + 		set_terms("bad", "good");
     +-		res = bisect_start(argv, argc);
     ++		res = bisect_start(argc, argv);
       		break;
       	case BISECT_NEXT:
       		if (argc)
     --			return error(_("--bisect-next requires 0 arguments"));
     -+			die(_("--bisect-next requires 0 arguments"));
     - 		get_terms(&terms);
     - 		res = bisect_next(&terms, prefix);
     - 		break;
     - 	case BISECT_RESET:
     - 		if (argc > 1)
     --			return error(_("--bisect-reset requires either no argument or a commit"));
     -+			die(_("--bisect-reset requires either no argument or a commit"));
     - 		res = bisect_reset(argc ? argv[0] : NULL);
     - 		break;
     - 	case BISECT_VISUALIZE:
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - 		break;
     - 	case BISECT_REPLAY:
     - 		if (argc != 1)
     --			return error(_("no logfile given"));
     -+			die(_("no logfile given"));
     - 		set_terms(&terms, "bad", "good");
     - 		res = bisect_replay(&terms, argv[0]);
     + 	case BISECT_STATE:
     + 		set_terms("bad", "good");
     + 		get_terms();
     +-		res = bisect_state(argv, argc);
     ++		res = bisect_state(argc, argv);
       		break;
       	case BISECT_LOG:
       		if (argc)
     --			return error(_("--bisect-log requires 0 arguments"));
     -+			die(_("--bisect-log requires 0 arguments"));
     - 		res = bisect_log();
     +@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     + 	case BISECT_SKIP:
     + 		set_terms("bad", "good");
     + 		get_terms();
     +-		res = bisect_skip(argv, argc);
     ++		res = bisect_skip(argc, argv);
     + 		break;
     + 	case BISECT_VISUALIZE:
     + 		get_terms();
     +-		res = bisect_visualize(argv, argc);
     ++		res = bisect_visualize(argc, argv);
       		break;
       	case BISECT_RUN:
       		if (!argc)
     --			return error(_("bisect run failed: no command provided."));
     -+			die(_("bisect run failed: no command provided."));
     - 		get_terms(&terms);
     - 		res = bisect_run(&terms, argv, argc);
     + 			return error(_("bisect run failed: no command provided."));
     + 		get_terms();
     +-		res = bisect_run(argv, argc);
     ++		res = bisect_run(argc, argv);
       		break;
     + 	default:
     + 		BUG("unknown subcommand %d", cmdmode);
  -:  ----------- >  7:  5b7a3d58b4f bisect--helper: migrate to OPT_SUBCOMMAND()
  1:  30ddbd7affc =  8:  ba537af7066 bisect: verify that a bogus option won't try to start a bisection
  2:  97dd2da8f89 !  9:  409492ad830 bisect run: fix the error message
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     +@@ builtin/bisect--helper.c: static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
       			printf(_("bisect found first bad commit"));
       			res = BISECT_OK;
       		} else if (res) {
  3:  5571e0f76ff ! 10:  bc5efc8fbfe bisect: avoid double-quoting when printing the failed command
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     +@@ builtin/bisect--helper.c: static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
       
       		if (res < 0 || 128 <= res) {
       			error(_("bisect run failed: exit code %d from"
  7:  aad3c9a0850 ! 11:  8a0adfe3867 bisect--helper: using `--bisect-state` without an argument is a bug
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    bisect--helper: using `--bisect-state` without an argument is a bug
     +    bisect--helper: calling `bisect_state()` without an argument is a bug
      
     -    The `bisect--helper` command is not expected to be used directly by the
     -    user. Therefore, it is a bug if it receives no argument to the
     -    `--bisect-state` command mode, not a user error. Which means that we
     -    need to call `BUG()` instead of `die()`.
     +    The `bisect_state()` function is now a purely internal function and must
     +    be called with a valid state, everything else is a bug.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
     +@@ builtin/bisect--helper.c: static enum bisect_error bisect_state(int argc, const char **argv,
     + 	struct strbuf buf = STRBUF_INIT;
       	struct oid_array revs = OID_ARRAY_INIT;
       
     - 	if (!argc)
     --		return error(_("Please call `--bisect-state` with at least one argument"));
     ++	if (!argc)
      +		BUG("bisect_state() called without argument");
       
     - 	if (bisect_autostart(terms))
     + 	if (bisect_autostart(prefix))
       		return BISECT_FAILED;
  8:  375a46dca9f <  -:  ----------- bisect--helper: align the sub-command order with git-bisect.sh
  9:  c57f63f6a61 ! 12:  189d2b3ba46 bisect--helper: make `--bisect-state` optional
     @@ Metadata
      Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## Commit message ##
     -    bisect--helper: make `--bisect-state` optional
     +    bisect--helper: make `state` optional
      
          In preparation for making `git bisect` a real built-in, let's prepare
          the `bisect--helper` built-in to handle `git bisect--helper good` and
     -    `git bisect--helper bad`, i.e. do not require the `--bisect-state`
     -    option to be passed explicitly.
     +    `git bisect--helper bad`, i.e. do not require the `state` subcommand to
     +    be passed explicitly.
      
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static const char * const git_bisect_helper_usage[] = {
     - 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
     - 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
     - 	"git bisect--helper --bisect-next",
     --	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
     --	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
     -+	N_("git bisect--helper [--bisect-state] (bad|new) [<rev>]"),
     -+	N_("git bisect--helper [--bisect-state] (good|old) [<rev>...]"),
     - 	N_("git bisect--helper --bisect-replay <filename>"),
     - 	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
     - 	"git bisect--helper --bisect-visualize",
     -@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - 			     git_bisect_helper_usage,
     - 			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
     +@@ builtin/bisect--helper.c: static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
       
     --	if (!cmdmode)
     --		usage_with_options(git_bisect_helper_usage, options);
     --
     --	switch (cmdmode) {
     -+	switch (cmdmode ? cmdmode : BISECT_STATE) {
     - 	case BISECT_START:
     - 		set_terms(&terms, "bad", "good");
     - 		res = bisect_start(&terms, argv, argc);
     + int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     + {
     ++	struct strvec args = STRVEC_INIT;
     + 	parse_opt_subcommand_fn *fn = NULL;
     + 	int res = 0;
     + 	struct option options[] = {
      @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - 	case BISECT_STATE:
     - 		set_terms(&terms, "bad", "good");
     - 		get_terms(&terms);
     -+		if (!cmdmode &&
     -+		    (!argc || check_and_set_terms(&terms, argv[0]))) {
     -+			char *msg = xstrfmt(_("unknown command: '%s'"), argv[0]);
     -+			usage_msg_opt(msg, git_bisect_helper_usage, options);
     -+		}
     - 		res = bisect_state(&terms, argv, argc);
     - 		break;
     - 	case BISECT_TERMS:
     + 	};
     + 
     + 	argc = parse_options(argc, argv, prefix, options,
     +-			     bisect_usage, 0);
     ++			     bisect_usage, PARSE_OPT_SUBCOMMAND_OPTIONAL);
     ++
     ++	if (!fn) {
     ++		if (!argc)
     ++			usage_msg_opt(_("need a command"), bisect_usage,
     ++				      options);
     ++
     ++		set_terms("bad", "good");
     ++		get_terms();
     ++		if (check_and_set_terms(argv[0]))
     ++			usage_msg_optf(_("unknown command: '%s'"), bisect_usage,
     ++				       options, argv[0]);
     ++
     ++		strvec_push(&args, "state");
     ++		strvec_pushv(&args, argv);
     ++		argc = args.nr;
     ++		argv = args.v;
     ++		fn = cmd_bisect_state;
     ++	}
     + 
     + 	res = fn(argc, argv, prefix);
     + 	free_terms();
     ++	strvec_clear(&args);
     + 
     + 	return is_bisect_success(res) ? 0 : -res;
     + }
      
       ## git-bisect.sh ##
      @@ git-bisect.sh: case "$#" in
       	start)
     - 		git bisect--helper --bisect-start "$@" ;;
     + 		git bisect--helper start "$@" ;;
       	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
     --		git bisect--helper --bisect-state "$cmd" "$@" ;;
     +-		git bisect--helper state "$cmd" "$@" ;;
      +		git bisect--helper "$cmd" "$@" ;;
       	skip)
     - 		git bisect--helper --bisect-skip "$@" || exit;;
     + 		git bisect--helper skip "$@" || exit;;
       	next)
 10:  87f53469a72 <  -:  ----------- bisect--helper: move the `BISECT_STATE` case to the end
 12:  5dbe233e4ec <  -:  ----------- bisect: teach the `bisect--helper` command to show the correct usage strings
 13:  d56f2a14060 ! 13:  32bf74e3050 bisect: move even the command-line parsing to `bisect--helper`
     @@ Commit message
          On our journey to a fully built-in `git bisect`, this is the
          last step.
      
     -    Side note: The `parse-options` API is not at all set up to parse
     -    subcommands such as `git bisect start`, `git bisect reset`, etc.
     -    Instead of fighting an up-hill battle trying to "fix" that, we simply
     -    roll the same type of manual subcommand parsing as we already do e.g.
     -    in `builtin/bundle.c`.
     -
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## builtin/bisect--helper.c ##
     -@@ builtin/bisect--helper.c: static const char *bisect_usage =
     - 	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
     - 	   "visualize|view|replay|log|run]");
     - 
     --static const char * const bisect_long_usage[] = {
     -+static const char *bisect_long_usage =
     - 	N_("git bisect [help|start|bad|good|new|old|terms|skip|next|reset|"
     - 	   "visualize|view|replay|log|run]\n"
     - 	   "\n"
     -@@ builtin/bisect--helper.c: static const char * const bisect_long_usage[] = {
     - 	   "git bisect run <cmd>...\n"
     - 	   "\tuse <cmd>... to automatically bisect.\n"
     - 	   "\n"
     --	   "Please use \"git help bisect\" to get the full man page."),
     --	NULL
     --};
     -+	   "Please use \"git help bisect\" to get the full man page.");
     - 
     - struct add_bisect_ref_data {
     - 	struct rev_info *revs;
     -@@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     - 
     - int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     - {
     --	enum {
     --		BISECT_START = 1,
     --		BISECT_STATE,
     --		BISECT_TERMS,
     --		BISECT_SKIP,
     --		BISECT_NEXT,
     --		BISECT_RESET,
     --		BISECT_VISUALIZE,
     --		BISECT_REPLAY,
     --		BISECT_LOG,
     --		BISECT_RUN,
     --	} cmdmode = 0;
     - 	int res = 0;
     --	struct option options[] = {
     --		OPT_CMDMODE(0, "bisect-start", &cmdmode,
     --			 N_("start the bisect session"), BISECT_START),
     --		OPT_CMDMODE(0, "bisect-state", &cmdmode,
     --			 N_("mark the state of ref (or refs)"), BISECT_STATE),
     --		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
     --			 N_("print out the bisect terms"), BISECT_TERMS),
     --		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
     --			 N_("skip some commits for checkout"), BISECT_SKIP),
     --		OPT_CMDMODE(0, "bisect-next", &cmdmode,
     --			 N_("find the next bisection commit"), BISECT_NEXT),
     --		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
     --			 N_("reset the bisection state"), BISECT_RESET),
     --		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
     --			 N_("visualize the bisection"), BISECT_VISUALIZE),
     --		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
     --			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
     --		OPT_CMDMODE(0, "bisect-log", &cmdmode,
     --			 N_("list the bisection steps so far"), BISECT_LOG),
     --		OPT_CMDMODE(0, "bisect-run", &cmdmode,
     --			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
     --		OPT_END()
     --	};
     - 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
     -+	const char *command = argc > 1 ? argv[1] : "help";
     -+
     -+	if (!strcmp("-h", command) || !strcmp("help", command))
     -+		usage(bisect_long_usage);
     - 
     --	argc = parse_options(argc, argv, prefix, options,
     --			     bisect_long_usage,
     --			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
     -+	argc -= 2;
     -+	argv += 2;
     - 
     --	switch (cmdmode ? cmdmode : BISECT_STATE) {
     --	case BISECT_START:
     -+	if (!strcmp("start", command)) {
     - 		set_terms(&terms, "bad", "good");
     - 		res = bisect_start(&terms, argv, argc);
     --		break;
     --	case BISECT_TERMS:
     -+	} else if (!strcmp("terms", command)) {
     - 		if (argc > 1)
     --			die(_("--bisect-terms requires 0 or 1 argument"));
     -+			die(_("'terms' requires 0 or 1 argument"));
     - 		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
     --		break;
     --	case BISECT_SKIP:
     -+	} else if (!strcmp("skip", command)) {
     - 		set_terms(&terms, "bad", "good");
     - 		get_terms(&terms);
     - 		res = bisect_skip(&terms, argv, argc);
     --		break;
     --	case BISECT_NEXT:
     -+	} else if (!strcmp("next", command)) {
     - 		if (argc)
     --			die(_("--bisect-next requires 0 arguments"));
     -+			die(_("'next' requires 0 arguments"));
     - 		get_terms(&terms);
     - 		res = bisect_next(&terms, prefix);
     --		break;
     --	case BISECT_RESET:
     -+	} else if (!strcmp("reset", command)) {
     - 		if (argc > 1)
     --			die(_("--bisect-reset requires either no argument or a commit"));
     -+			die(_("'reset' requires either no argument or a commit"));
     - 		res = bisect_reset(argc ? argv[0] : NULL);
     --		break;
     --	case BISECT_VISUALIZE:
     -+	} else if (one_of(command, "visualize", "view", NULL)) {
     - 		get_terms(&terms);
     - 		res = bisect_visualize(&terms, argv, argc);
     --		break;
     --	case BISECT_REPLAY:
     -+	} else if (!strcmp("replay", command)) {
     - 		if (argc != 1)
     - 			die(_("no logfile given"));
     - 		set_terms(&terms, "bad", "good");
     - 		res = bisect_replay(&terms, argv[0]);
     --		break;
     --	case BISECT_LOG:
     -+	} else if (!strcmp("log", command)) {
     - 		if (argc)
     --			die(_("--bisect-log requires 0 arguments"));
     -+			die(_("'log' requires 0 arguments"));
     - 		res = bisect_log();
     --		break;
     --	case BISECT_RUN:
     -+	} else if (!strcmp("run", command)) {
     - 		if (!argc)
     - 			die(_("bisect run failed: no command provided."));
     - 		get_terms(&terms);
     - 		res = bisect_run(&terms, argv, argc);
     --		break;
     --	case BISECT_STATE:
     --		if (argc &&
     --		    !file_is_not_empty(git_path_bisect_start()) &&
     --		    !one_of(argv[0], "bad", "good", "new", "old", NULL))
     -+	} else {
     -+		if (!file_is_not_empty(git_path_bisect_start()) &&
     -+		    !one_of(command, "bad", "good", "new", "old", NULL))
     - 			usage(bisect_usage);
     - 		set_terms(&terms, "bad", "good");
     - 		get_terms(&terms);
     --		if (!cmdmode &&
     --		    (!argc || check_and_set_terms(&terms, argv[0])))
     -+		if (check_and_set_terms(&terms, command))
     - 			usage(bisect_usage);
     -+		/* shift the `command` back in */
     -+		argc++;
     -+		argv--;
     - 		res = bisect_state(&terms, argv, argc);
     --		break;
     --	default:
     --		BUG("unknown subcommand %d", cmdmode);
     - 	}
     -+
     - 	free_terms(&terms);
     - 
     - 	/*
     +@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
     + 		OPT_SUBCOMMAND("terms", &fn, cmd_bisect_terms),
     + 		OPT_SUBCOMMAND("start", &fn, cmd_bisect_start),
     + 		OPT_SUBCOMMAND("next", &fn, cmd_bisect_next),
     +-		OPT_SUBCOMMAND("state", &fn, cmd_bisect_state),
     + 		OPT_SUBCOMMAND("log", &fn, cmd_bisect_log),
     + 		OPT_SUBCOMMAND("replay", &fn, cmd_bisect_replay),
     + 		OPT_SUBCOMMAND("skip", &fn, cmd_bisect_skip),
      
       ## git-bisect.sh ##
      @@ git-bisect.sh: Please use "git help bisect" to get the full man page.'
     @@ git-bisect.sh: Please use "git help bisect" to get the full man page.'
      -	help)
      -		git bisect -h ;;
      -	start)
     --		git bisect--helper --bisect-start "$@" ;;
     +-		git bisect--helper start "$@" ;;
      -	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
      -		git bisect--helper "$cmd" "$@" ;;
      -	skip)
     --		git bisect--helper --bisect-skip "$@" || exit;;
     +-		git bisect--helper skip "$@" || exit;;
      -	next)
      -		# Not sure we want "next" at the UI level anymore.
     --		git bisect--helper --bisect-next "$@" || exit ;;
     +-		git bisect--helper next "$@" || exit ;;
      -	visualize|view)
     --		git bisect--helper --bisect-visualize "$@" || exit;;
     +-		git bisect--helper visualize "$@" || exit;;
      -	reset)
     --		git bisect--helper --bisect-reset "$@" ;;
     +-		git bisect--helper reset "$@" ;;
      -	replay)
     --		git bisect--helper --bisect-replay "$@" || exit;;
     +-		git bisect--helper replay "$@" || exit;;
      -	log)
     --		git bisect--helper --bisect-log || exit ;;
     +-		git bisect--helper log || exit ;;
      -	run)
     --		git bisect--helper --bisect-run "$@" || exit;;
     +-		git bisect--helper run "$@" || exit;;
      -	terms)
     --		git bisect--helper --bisect-terms "$@" || exit;;
     +-		git bisect--helper terms "$@" || exit;;
      -	*)
      -		usage ;;
      -	esac
 14:  378d6d22737 ! 14:  a8f08f5e0cb Turn `git bisect` into a full built-in
     @@ builtin.h: int cmd_am(int argc, const char **argv, const char *prefix);
       int cmd_bugreport(int argc, const char **argv, const char *prefix);
      
       ## builtin/bisect--helper.c => builtin/bisect.c ##
     -@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
     +@@ builtin/bisect.c: static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
       	return res;
       }
       
      -int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
      +int cmd_bisect(int argc, const char **argv, const char *prefix)
       {
     - 	int res = 0;
     - 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
     + 	struct strvec args = STRVEC_INIT;
     + 	parse_opt_subcommand_fn *fn = NULL;
      
       ## git-bisect.sh (deleted) ##
      @@
     @@ git-bisect.sh (deleted)
      
       ## git.c ##
      @@ git.c: static struct cmd_struct commands[] = {
     - 	{ "annotate", cmd_annotate, RUN_SETUP | NO_PARSEOPT },
     + 	{ "annotate", cmd_annotate, RUN_SETUP },
       	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
       	{ "archive", cmd_archive, RUN_SETUP_GENTLY },
      -	{ "bisect--helper", cmd_bisect__helper, RUN_SETUP },
 15:  33566b86d77 ! 15:  a96489310d3 bisect: remove Cogito-related code
     @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXP
       static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
       static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
       static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
     -@@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
     +@@ builtin/bisect.c: static int cmd_bisect_start(int argc, const char **argv, const char *prefix)
       			strbuf_addstr(&start_head, oid_to_hex(&head_oid));
       		} else if (!get_oid(head, &head_oid) &&
       			   skip_prefix(head, "refs/heads/", &head)) {
 16:  334664f23a8 = 16:  bfa7aa19f03 bisect: no longer try to clean up left-over `.git/head-name` files

-- 
gitgitgadget
