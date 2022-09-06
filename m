Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90041ECAAD5
	for <git@archiver.kernel.org>; Tue,  6 Sep 2022 13:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbiIFNLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Sep 2022 09:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbiIFNLH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2022 09:11:07 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A1654643
        for <git@vger.kernel.org>; Tue,  6 Sep 2022 06:11:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t7so10362478wrm.10
        for <git@vger.kernel.org>; Tue, 06 Sep 2022 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=LPxA02xsCDQAB3TcDUT8RDFcilJzx4uECgiMG1fubMs=;
        b=p820Dvcop+U+a9DaXahneCb5y6E2N8FX/zePYouKG471V5fYWfeyGh2Te95DMZaKfq
         fO9alP9bgfaZLTs7WaAFvZRCa4RKvG+SEq8hOCflAGthHg72sbwHIv8RojESZlfC45M5
         ihDHRR29qzxMudqUbR01572Q8EC5btVj9cvBiItPFnfeLEYINlDaY8ISpxPhdNZTKPEA
         +6TxFXKtnwJSuTZx758DdiZzCVYjgn5FC/gd6BS/wl5ct0aRQjnxDf5leaHjzkH7wJE7
         8KGwKIMWSZX2s3e1VrOcqStBWlgNbTDVSsHW9Z6pZUahjb2I/Uh9NMYKGxNpFQMWRoCJ
         otug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LPxA02xsCDQAB3TcDUT8RDFcilJzx4uECgiMG1fubMs=;
        b=QEq9/TnLMxv+qEJdcfbdj91KoV7LVAfbuo9PsdJP1g/b0mQjDQHv9T9J/yu3ekNYdX
         wVCO8s6fEjcXVveW3TnYjv/OmcH2uspOzQjvqumWbmfS8WXYJPZs4zR1ldP1cjW/NMlB
         2AfWH1rrbTYpin/8EjNHVENxK3NY69jI6xzRbBI1cMBit9tAJYZmkNrHBGtDHrJLPcH+
         bT0fcTRSxrT4In6VjRmzV54J6p3aRQoB8iI0sf0o9O3rSI4FSIZc37FyrHfPrVZOwsNy
         B0HtNI32X6xMOpAsCTo36rEgWtXvDA5+FIWlm1Jau4AZznJIWmy07GojEwhYEh9hU4IG
         rJGQ==
X-Gm-Message-State: ACgBeo1PR32mtmLuFG0YRhqrGyEKR46x9TsttD9jqYCAU5VvISRcc57G
        0zWI/Flj+LgS6Qh5wrS06CxSFusvLdI=
X-Google-Smtp-Source: AA6agR7aA7WBNIzDlcfzL0ReCv/vMY299IccKVnR0ijm+9GirqjopvtM2uZktyUofuQy9+JkJrr0Yg==
X-Received: by 2002:adf:d209:0:b0:228:6298:f288 with SMTP id j9-20020adfd209000000b002286298f288mr7836813wrh.386.1662469860035;
        Tue, 06 Sep 2022 06:11:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk16-20020a0560001d9000b002258235bda3sm12448500wrb.61.2022.09.06.06.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 06:10:59 -0700 (PDT)
Message-Id: <pull.1309.v2.git.1662469859.gitgitgadget@gmail.com>
In-Reply-To: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Sep 2022 13:10:56 +0000
Subject: [PATCH v2 0/2] tests: replace mingw_test_cmp with a helper in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On the heels of sending a patch to fix a performance regression due to a
mis-use of test_cmp
[https://lore.kernel.org/git/b9203ea247776332e4b6f519aa27d541207adc2f.1659097724.git.gitgitgadget@gmail.com/],
I was curious to see whether Git for Windows had the same issue. And it does
not
[https://github.com/git-for-windows/git/runs/7556381815?check_suite_focus=true#step:5:127]:
it passes t5351 in 22 seconds, even while using test_cmp to compare pack
files
[https://github.com/git-for-windows/git/blob/3922f62f0d5991e9fe0a0817ebf89a91339c7705/t/t5351-unpack-large-objects.sh#L90].

The answer is of course that a test helper written in C is much faster than
writing the same in Bash, especially on Windows. This is especially sad when
said Bash code is only used on Windows. So I pulled out this helper from the
years-long effort to let Git for Windows use BusyBox' ash to run the test
suite. The result is this patch, which has been in Git for Windows since
June 2018.

Changes since v1:

 * Fixed double "with" in the commit message.

Johannes Schindelin (2):
  t0021: use Windows-friendly `pwd`
  tests: replace mingw_test_cmp with a helper in C

 Makefile                 |  1 +
 t/helper/test-text-cmp.c | 78 ++++++++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c     |  1 +
 t/helper/test-tool.h     |  1 +
 t/t0021-conversion.sh    |  4 +--
 t/test-lib-functions.sh  | 68 +----------------------------------
 t/test-lib.sh            |  2 +-
 7 files changed, 85 insertions(+), 70 deletions(-)
 create mode 100644 t/helper/test-text-cmp.c


base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1309%2Fdscho%2Fmingw-test-cmp-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1309/dscho/mingw-test-cmp-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1309

Range-diff vs v1:

 -:  ----------- > 1:  ad7c41401ee t0021: use Windows-friendly `pwd`
 1:  eacbbc53700 ! 2:  1f5366f1379 tests: replace mingw_test_cmp with a helper in C
     @@ Commit message
          tests: replace mingw_test_cmp with a helper in C
      
          This helper is more performant than running the `mingw_test_cmp` code
     -    with with MSYS2's Bash. And a lot more readable.
     +    with MSYS2's Bash. And a lot more readable.
      
          To accommodate t1050, which wants to compare files weighing in with 3MB
          (falling outside of t1050's malloc limit of 1.5MB), we simply lift the
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Makefile ##
     -@@ Makefile: TEST_BUILTINS_OBJS += test-advise.o
     - TEST_BUILTINS_OBJS += test-bitmap.o
     - TEST_BUILTINS_OBJS += test-bloom.o
     - TEST_BUILTINS_OBJS += test-chmtime.o
     -+TEST_BUILTINS_OBJS += test-cmp.o
     - TEST_BUILTINS_OBJS += test-config.o
     - TEST_BUILTINS_OBJS += test-crontab.o
     - TEST_BUILTINS_OBJS += test-csprng.o
     +@@ Makefile: TEST_BUILTINS_OBJS += test-string-list.o
     + TEST_BUILTINS_OBJS += test-submodule-config.o
     + TEST_BUILTINS_OBJS += test-submodule-nested-repo-config.o
     + TEST_BUILTINS_OBJS += test-subprocess.o
     ++TEST_BUILTINS_OBJS += test-text-cmp.o
     + TEST_BUILTINS_OBJS += test-trace2.o
     + TEST_BUILTINS_OBJS += test-urlmatch-normalization.o
     + TEST_BUILTINS_OBJS += test-userdiff.o
      
     - ## t/helper/test-cmp.c (new) ##
     + ## t/helper/test-text-cmp.c (new) ##
      @@
      +#include "test-tool.h"
      +#include "git-compat-util.h"
     @@ t/helper/test-cmp.c (new)
      +static int run_diff(const char *path1, const char *path2)
      +{
      +	const char *argv[] = {
     -+		"diff", "--no-index", NULL, NULL, NULL
     ++		"diff", "--no-index", "--", NULL, NULL, NULL
      +	};
      +	const char *env[] = {
      +		"GIT_PAGER=cat",
     @@ t/helper/test-cmp.c (new)
      +		NULL
      +	};
      +
     -+	argv[2] = path1;
     -+	argv[3] = path2;
     ++	argv[3] = path1;
     ++	argv[4] = path2;
      +	return run_command_v_opt_cd_env(argv,
      +					RUN_COMMAND_NO_STDIN | RUN_GIT_CMD,
      +					NULL, env);
      +}
      +
     -+int cmd__cmp(int argc, const char **argv)
     ++int cmd__text_cmp(int argc, const char **argv)
      +{
      +	FILE *f0, *f1;
      +	struct strbuf b0 = STRBUF_INIT, b1 = STRBUF_INIT;
     @@ t/helper/test-cmp.c (new)
      +	if (argc != 3)
      +		die("Require exactly 2 arguments, got %d", argc);
      +
     ++	if (!strcmp(argv[1], "-") && !strcmp(argv[2], "-"))
     ++		die("only one parameter can refer to `stdin` but not both");
     ++
      +	if (!(f0 = !strcmp(argv[1], "-") ? stdin : fopen(argv[1], "r")))
      +		return error_errno("could not open '%s'", argv[1]);
      +	if (!(f1 = !strcmp(argv[2], "-") ? stdin : fopen(argv[2], "r"))) {
     @@ t/helper/test-cmp.c (new)
      +			if (r1 == EOF)
      +				return 0;
      +cmp_failed:
     -+			if (!run_diff(argv[1], argv[2]))
     ++			if (!strcmp(argv[1], "-") || !strcmp(argv[2], "-"))
     ++				warning("cannot show diff because `stdin` was already consumed");
     ++			else if (!run_diff(argv[1], argv[2]))
      +				die("Huh? 'diff --no-index %s %s' succeeded",
      +				    argv[1], argv[2]);
      +			return 1;
     @@ t/helper/test-cmp.c (new)
      
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     - 	{ "bitmap", cmd__bitmap },
     - 	{ "bloom", cmd__bloom },
     - 	{ "chmtime", cmd__chmtime },
     -+	{ "cmp", cmd__cmp },
     - 	{ "config", cmd__config },
     - 	{ "crontab", cmd__crontab },
     - 	{ "csprng", cmd__csprng },
     + 	{ "submodule-config", cmd__submodule_config },
     + 	{ "submodule-nested-repo-config", cmd__submodule_nested_repo_config },
     + 	{ "subprocess", cmd__subprocess },
     ++	{ "text-cmp", cmd__text_cmp },
     + 	{ "trace2", cmd__trace2 },
     + 	{ "userdiff", cmd__userdiff },
     + 	{ "urlmatch-normalization", cmd__urlmatch_normalization },
      
       ## t/helper/test-tool.h ##
     -@@ t/helper/test-tool.h: int cmd__advise_if_enabled(int argc, const char **argv);
     - int cmd__bitmap(int argc, const char **argv);
     - int cmd__bloom(int argc, const char **argv);
     - int cmd__chmtime(int argc, const char **argv);
     -+int cmd__cmp(int argc, const char **argv);
     - int cmd__config(int argc, const char **argv);
     - int cmd__crontab(int argc, const char **argv);
     - int cmd__csprng(int argc, const char **argv);
     +@@ t/helper/test-tool.h: int cmd__string_list(int argc, const char **argv);
     + int cmd__submodule_config(int argc, const char **argv);
     + int cmd__submodule_nested_repo_config(int argc, const char **argv);
     + int cmd__subprocess(int argc, const char **argv);
     ++int cmd__text_cmp(int argc, const char **argv);
     + int cmd__trace2(int argc, const char **argv);
     + int cmd__userdiff(int argc, const char **argv);
     + int cmd__urlmatch_normalization(int argc, const char **argv);
      
       ## t/test-lib-functions.sh ##
      @@ t/test-lib-functions.sh: test_expect_code () {
     @@ t/test-lib.sh: case $uname_s in
       	test_set_prereq GREP_STRIPS_CR
       	test_set_prereq WINDOWS
      -	GIT_TEST_CMP=mingw_test_cmp
     -+	GIT_TEST_CMP="test-tool cmp"
     ++	GIT_TEST_CMP="test-tool text-cmp"
       	;;
       *CYGWIN*)
       	test_set_prereq POSIXPERM

-- 
gitgitgadget
