Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D1FAC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiKJQhL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiKJQhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:01 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E5932B88
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:59 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 136so2344442pga.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxkJQWL96qVvoMtOYiWufX1Sr+Qrb3A9aH79Qmp0cLA=;
        b=AJdOmd3j5mXElmUeJpOBzfByWcAZGLXUcjASTEh7FjB72vuxwNokBLKX0NuZootcpk
         mbFiA6PeSrkCOHWtWRKJhnWidaFiq9j3SPQ/tpqqWB8CBUclXAroYxSM7ErGXShWY9bY
         lgPBJn5Rla9sqTtOFblJc+7SSKMvaQ6lkdMkG3yiIkrvzYggKNS2hC4/NjGyEoNGTZFk
         8x1KlhKu/15sLedjNtQTZIzbXz80rUniih1VJvOcSLtGL6INWE1ZBYPvbaYGXgPe5nOQ
         njMyQckkyx0i4kaB/5lHl1elCMBc82AflUBd3dvwrYarSRizBmkPYTAPngfXsZl1w2Mq
         FomQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxkJQWL96qVvoMtOYiWufX1Sr+Qrb3A9aH79Qmp0cLA=;
        b=blAcDGWpkhsjUl8HikRi0Q8KpdsdtuhfsYHOPd1ej2VbK31dQ/foz2qwjb4i4+qBLH
         HwF+MWYpCil22F3dT81kEnC113B0PGFObJCEH4GSFYsVc05XgVbexZUP5dO9Q2rJNP2l
         JyL4C8ywqVyVlyJHlTTWKIaqkuHNdUbPuvAiUNIKIHCgqmzZAhHNteXKHZulJ6ptvzsG
         EUZ5bqjyIMdxlIRPBi6CfvOkEADPIE+2Q/MC1StFVXb2HJl0UcoMi1rkHL5Kd4+zzB1M
         h1yKNhzNDCNenPTMfWVkUOw67UHa3Lv3NZS3algfblw3qIWY6RgjziMmvAQfff6F2eIR
         ICkw==
X-Gm-Message-State: ACrzQf1eGQ/NijWdgCaur0ishDZb+kLI2bFnnQBsQF+TqiAROtMPoux6
        r6IWfbcXVpBFltvwcmLerq09auBC4VU=
X-Google-Smtp-Source: AMsMyM5aK5X9z7FNbAcmtp3Slzm1M3ysP2BFvn36pOnOTX4FalXnspn8qNZI4tOVctK2ZvJI5q2YUg==
X-Received: by 2002:a63:6a09:0:b0:43a:20d4:85fe with SMTP id f9-20020a636a09000000b0043a20d485femr54381991pgc.625.1668098218870;
        Thu, 10 Nov 2022 08:36:58 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:36:58 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] Turn git-bisect to be builtin
Date:   Thu, 10 Nov 2022 23:36:35 +0700
Message-Id: <cover.1668097962.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097286.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series finish the git-bisect porting from shell script into a C builtin.

This series can't be applied cleaned on master, it needs to be applied on top
of the series posted at:
https://lore.kernel.org/git/cover.1668097286.git.congdanhqx@gmail.com/
AND the series rs/no-more-run-command-v, which has been integrated to next.

Johannes Schindelin (2):
  bisect--helper: handle states directly
  Turn `git bisect` into a full built-in

Ævar Arnfjörð Bjarmason (4):
  bisect tests: test for v2.30.0 "bisect run" regressions
  bisect: refactor bisect_run() to match CodingGuidelines
  bisect test: test exit codes on bad usage
  bisect--helper: emit usage for "git bisect"

Đoàn Trần Công Danh (5):
  bisect: fix output regressions in v2.30.0
  bisect run: keep some of the post-v2.30.0 output
  bisect-run: verify_good: account for non-negative exit status
  bisect--helper: identify as bisect when report error
  bisect--helper: log: allow arbitrary number of arguments

 Makefile                               |   3 +-
 builtin.h                              |   2 +-
 builtin/{bisect--helper.c => bisect.c} | 126 ++++++++++++---------
 git-bisect.sh                          |   4 -
 git.c                                  |   2 +-
 t/t6030-bisect-porcelain.sh            | 148 +++++++++++++++++++++++++
 6 files changed, 225 insertions(+), 60 deletions(-)
 rename builtin/{bisect--helper.c => bisect.c} (92%)

Range-diff against v1:
 1:  5571bc36b8 !  1:  b6fd4ecd66 bisect tests: test for v2.30.0 "bisect run" regressions
    @@ Commit message
         with 127. That edge case is a bit too insane to preserve, so let's not
         add it to these regression tests.
     
    +    There was another regression that 'git bisect' consumed some options
    +    that was meant to passed down to program run with 'git bisect run'.
    +    Since that regression is breaking user's expectation, it has been fixed
    +    earlier without this patch queued.
    +
         1. 0a4cb1f1f2f (Merge branch 'mr/bisect-in-c-4', 2021-09-23)
         2. d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell
            function in C, 2021-09-13)
    @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect skip: with commit both
     +	test_cmp expect.args actual.args
     +}
     +
    -+test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' '
    -+	test_bisect_run_args <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
    ++test_expect_failure 'git bisect run: args, stdout and stderr with no arguments' "
    ++	test_bisect_run_args <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
     +	EOF_ARGS
     +	running ./run.sh
     +	$HASH4 is the first bad commit
     +	bisect run success
     +	EOF_OUT
     +	EOF_ERR
    -+'
    ++"
     +
    -+test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' '
    -+	test_bisect_run_args -- <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
    ++test_expect_failure 'git bisect run: args, stdout and stderr: "--" argument' "
    ++	test_bisect_run_args -- <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
     +	<-->
     +	EOF_ARGS
     +	running ./run.sh --
    @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect skip: with commit both
     +	bisect run success
     +	EOF_OUT
     +	EOF_ERR
    -+'
    ++"
     +
    -+test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' '
    -+	test_bisect_run_args --log foo --no-log bar <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
    ++test_expect_failure 'git bisect run: args, stdout and stderr: "--log foo --no-log bar" arguments' "
    ++	test_bisect_run_args --log foo --no-log bar <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
     +	<--log>
     +	<foo>
     +	<--no-log>
    @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect skip: with commit both
     +	bisect run success
     +	EOF_OUT
     +	EOF_ERR
    -+'
    ++"
     +
    -+test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' '
    -+	test_bisect_run_args --bisect-start <<-\EOF_ARGS 6<<-EOF_OUT 7<<-\EOF_ERR
    ++test_expect_failure 'git bisect run: args, stdout and stderr: "--bisect-start" argument' "
    ++	test_bisect_run_args --bisect-start <<-'EOF_ARGS' 6<<-EOF_OUT 7<<-'EOF_ERR'
     +	<--bisect-start>
     +	EOF_ARGS
     +	running ./run.sh --bisect-start
    @@ t/t6030-bisect-porcelain.sh: test_expect_success 'bisect skip: with commit both
     +	bisect run success
     +	EOF_OUT
     +	EOF_ERR
    -+'
    ++"
     +
      # We want to automatically find the commit that
      # added "Another" into hello.
 2:  dc6ed4c453 =  2:  d82c7eaabf bisect: refactor bisect_run() to match CodingGuidelines
 3:  8a815e2311 <  -:  ---------- bisect--helper: pass arg[cv] down to do_bisect_run
 4:  31cd78f538 <  -:  ---------- bisect: fix output regressions in v2.30.0
 5:  5ba3bafdd4 <  -:  ---------- bisect run: keep some of the post-v2.30.0 output
 6:  32ad47ddc5 <  -:  ---------- bisect--helper: remove unused arguments from do_bisect_run
 -:  ---------- >  3:  912f32ceda bisect: fix output regressions in v2.30.0
 -:  ---------- >  4:  17bef3e951 bisect run: keep some of the post-v2.30.0 output
 -:  ---------- >  5:  d6c57af9cc bisect-run: verify_good: account for non-negative exit status
 7:  f212e64288 !  6:  8039b010c8 bisect--helper: pretend we're real bisect when report error
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    bisect--helper: pretend we're real bisect when report error
    +    bisect--helper: identify as bisect when report error
     
         In a later change, we will convert the bisect--helper to be builtin
    -    bisect. Let's start by pretending it's the real bisect when reporting
    +    bisect. Let's start by self-identifying it's the real bisect when reporting
         error.
     
    +    This change is safe since 'git bisect--helper' is an implementation
    +    detail, users aren't expected to call 'git bisect--helper'.
    +
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## builtin/bisect--helper.c ##
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
      }
      
     @@ builtin/bisect--helper.c: static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNU
    - 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    + 	struct bisect_terms terms = { 0 };
      
      	if (argc > 1)
     -		return error(_("--bisect-terms requires 0 or 1 argument"));
    @@ builtin/bisect--helper.c: static int cmd_bisect__terms(int argc, const char **ar
      	free_terms(&terms);
      	return res;
     @@ builtin/bisect--helper.c: static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
    - 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    + 	struct bisect_terms terms = { 0 };
      
      	if (argc)
     -		return error(_("--bisect-next requires 0 arguments"));
    @@ builtin/bisect--helper.c: static int cmd_bisect__state(int argc, const char **ar
      }
      
     @@ builtin/bisect--helper.c: static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSE
    - 	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    + 	struct bisect_terms terms = { 0 };
      
      	if (!argc)
     -		return error(_("bisect run failed: no command provided."));
 8:  4c1beb8bf8 =  7:  7c43abfcef bisect test: test exit codes on bad usage
 9:  b494a4cf4e =  8:  4500867d56 bisect--helper: emit usage for "git bisect"
10:  a53e0c61ca !  9:  3752c0348b bisect--helper: make `state` optional
    @@ Metadata
     Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
     
      ## Commit message ##
    -    bisect--helper: make `state` optional
    +    bisect--helper: handle states directly
     
         In preparation for making `git bisect` a real built-in, let's prepare
         the `bisect--helper` built-in to handle `git bisect--helper good` and
    -    `git bisect--helper bad`, i.e. do not require the `state` subcommand to
    -    be passed explicitly.
    +    `git bisect--helper bad`, i.e. eliminate the need of `state` subcommand.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/bisect--helper.c ##
    +@@ builtin/bisect--helper.c: static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
    + 	return res;
    + }
    + 
    +-static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNUSED)
    +-{
    +-	int res;
    +-	struct bisect_terms terms = { 0 };
    +-
    +-	set_terms(&terms, "bad", "good");
    +-	get_terms(&terms);
    +-	res = bisect_state(&terms, argv, argc);
    +-	free_terms(&terms);
    +-	return res;
    +-}
    +-
    + static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
    + {
    + 	if (argc)
    +@@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
    + 		OPT_SUBCOMMAND("terms", &fn, cmd_bisect__terms),
    + 		OPT_SUBCOMMAND("start", &fn, cmd_bisect__start),
    + 		OPT_SUBCOMMAND("next", &fn, cmd_bisect__next),
    +-		OPT_SUBCOMMAND("state", &fn, cmd_bisect__state),
    + 		OPT_SUBCOMMAND("log", &fn, cmd_bisect__log),
    + 		OPT_SUBCOMMAND("replay", &fn, cmd_bisect__replay),
    + 		OPT_SUBCOMMAND("skip", &fn, cmd_bisect__skip),
     @@ builtin/bisect--helper.c: int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
      		OPT_SUBCOMMAND("run", &fn, cmd_bisect__run),
      		OPT_END()
11:  8037667da0 <  -:  ---------- bisect--helper: remove subcommand state
12:  3b13350977 = 10:  de3075eff9 bisect--helper: log: allow arbitrary number of arguments
13:  0441cf2554 = 11:  dadca7adbe Turn `git bisect` into a full built-in
-- 
2.38.1.157.gedabe22e0a

