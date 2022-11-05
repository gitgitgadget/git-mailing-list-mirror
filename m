Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E5C43217
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKERD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKERDy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:03:54 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD8FDFA3
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:03:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o7so7069504pjj.1
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7NfocSaPnYGuQMMVwi1RWHvn0AGPIF0n8S7d88rf8k=;
        b=mSRAyGNHhvx65YMWSTOUXTH1hxnfq1O5TJGdqr3novap7x9tyuNeWWLPAJx7xFfUxL
         48jrqIl5x3WCBELXVOJGM3b9Gp/QA8J/rJznygSpSJHwfFZLz/TFngyKWJa0rljNw1RR
         LTi2qXDXD1ntIi+yvHMpVR5DIil4J0gtnIwJVzVNz/9qL6lMvfY4hc9twPLPGKoegieK
         yYM20FYVAMkKNv+JaUBEy9wvs9UAL7qqVpVHpWqGFs3yx34VyMbRuFqi34R7BxAG0mzT
         NVqhDvtpErKePWnm1EuTIDgOysB7D6WbYR1kwO0hC8K1aq90+VhVblfWx4F/qvZVMBAR
         YpLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7NfocSaPnYGuQMMVwi1RWHvn0AGPIF0n8S7d88rf8k=;
        b=PUJ1D9GlU1AA1HgXZQNX81ESgj7ppa9h/sNXFORWNWzTfFuyxmEpST9XY5mPiWiiNA
         T5VP5iNeDQ6P8DzTBrfHUA4+9R7QClo3XMV3BfXeoy90CXWZa9t8MCxXrEywn70YAqyc
         20aRKactYG1kd8PqweVYNtHvO2BRc61KZA85ycfTQfKUf5c6LLWOG7dOoQna3s340FJP
         tnSx5SrGF+eZAgi/QNdBDglVxpDOl30vxzNy3E/gXng1QZkzRMxER5eEFRXe9XwWOfXw
         yVu8JIQyiMtzIDjJFzDOoR0IwOmsSkzjOveNi0CSY/pL8If38xxLs7vJvHPQsK6xYKAu
         EmCg==
X-Gm-Message-State: ACrzQf0/GeksGnwNpGBgV4CGQ/KLXjmletdaLmV86nDyV3U9KbBAyl/8
        BnlQ8/nwEVCGI3cUe3ZBF4jlLzjDC+I=
X-Google-Smtp-Source: AMsMyM4yfh0dg6+h8ivYbryvPwpHCM31Facd3qbp52JMUCi4zbn1ehDT46UDbc6z7wT4/CQkNOiLcw==
X-Received: by 2002:a17:90a:24b:b0:213:9da2:5c98 with SMTP id t11-20020a17090a024b00b002139da25c98mr42664422pje.123.1667667832549;
        Sat, 05 Nov 2022 10:03:52 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id jb14-20020a170903258e00b0016c0c82e85csm1910789plb.75.2022.11.05.10.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:03:51 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] Convert git-bisect--helper to OPT_SUBCOMMAND
Date:   Sun,  6 Nov 2022 00:03:33 +0700
Message-Id: <cover.1667667058.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667561761.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series aims to fix the problem that bisect--helper incorrectly consumes
"--log" when running:

	git bisect run cmd --log

This also clears a way for turning git-bisect into a built-in in a later day.

The series that convert git-bisect to builtin will be posted later as a reply
to this series

Đoàn Trần Công Danh (3):
  bisect--helper: remove unused options
  bisect--helper: move all subcommands into their own functions
  bisect--helper: parse subcommand with OPT_SUBCOMMAND

 builtin/bisect--helper.c    | 229 ++++++++++++++++++++----------------
 git-bisect.sh               |  23 +---
 t/t6030-bisect-porcelain.sh |  10 ++
 3 files changed, 142 insertions(+), 120 deletions(-)

Range-diff against v1:
1:  abe480d1c9 ! 1:  6b80fd9398 bisect--helper: remove unused options
    @@ Metadata
      ## Commit message ##
         bisect--helper: remove unused options
     
    +    'git-bisect.sh' used to have a 'bisect_next_check' to check if we have
    +    both good/bad, old/new terms set or not.  In commit 129a6cf344
    +    (bisect--helper: `bisect_next_check` shell function in C, 2019-01-02),
    +    a subcommand for bisect--helper was introduced to port the check to C.
    +    Since d1bbbe45df (bisect--helper: reimplement `bisect_run` shell
    +    function in C, 2021-09-13), all users of 'bisect_next_check' was
    +    re-implemented in C, this subcommand was no longer used but we forgot
    +    to remove '--bisect-next-check'.
    +
    +    'git-bisect.sh' also used to have a 'bisect_write' function, whose
    +    third positional parameter was a "nolog" flag.  This flag was only used
    +    when 'bisect_start' invoked 'bisect_write' to write the starting good
    +    and bad revisions.  Then 0f30233a11 (bisect--helper: `bisect_write`
    +    shell function in C, 2019-01-02) ported it to C as a command mode of
    +    'bisect--helper', which (incorrectly) added the '--no-log' option,
    +    and convert the only place ('bisect_start') that call 'bisect_write'
    +    with 'nolog' to 'git bisect--helper --bisect-write' with 'nolog'
    +    instead of '--no-log', since 'bisect--helper' has command modes not
    +    subcommands, all other command modes see and handle that option as well.
    +    This bogus state didn't last long, however, because in the same patch
    +    series 06f5608c14 (bisect--helper: `bisect_start` shell function
    +    partially in C, 2019-01-02) the C reimplementation of bisect_start()
    +    started calling the bisect_write() C function, this time with the
    +    right 'nolog' function parameter. From then on there was no need for
    +    the '--no-log' option in 'bisect--helper'. Eventually all bisect
    +    subcommands were ported to C as 'bisect--helper' command modes, each
    +    calling the bisect_write() C function instead, but when the
    +    '--bisect-write' command mode was removed in 68efed8c8a
    +    (bisect--helper: retire `--bisect-write` subcommand, 2021-02-03) it
    +    forgot to remove that '--no-log' option.
    +    '--no-log' option had never been used and it's unused now.
    +
    +    Let's remove --bisect-next-check and --no-log from option parsing.
    +
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## builtin/bisect--helper.c ##
2:  94ac8cb999 = 2:  9d8a3cdd7a bisect--helper: move all subcommands into their own functions
3:  ae967cacd3 ! 3:  a62ac72e24 bisect--helper: parse subcommand with OPT_SUBCOMMAND
    @@ builtin/bisect--helper.c: static int cmd_bisect__run(int argc, const char **argv
     -			 N_("visualize the bisection"), BISECT_VISUALIZE),
     -		OPT_CMDMODE(0, "bisect-run", &cmdmode,
     -			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
    -+		OPT_SUBCOMMAND("bisect-reset", &fn, cmd_bisect__reset),
    -+		OPT_SUBCOMMAND("bisect-terms", &fn, cmd_bisect__terms),
    -+		OPT_SUBCOMMAND("bisect-start", &fn, cmd_bisect__start),
    -+		OPT_SUBCOMMAND("bisect-next", &fn, cmd_bisect__next),
    -+		OPT_SUBCOMMAND("bisect-state", &fn, cmd_bisect__state),
    -+		OPT_SUBCOMMAND("bisect-log", &fn, cmd_bisect__log),
    -+		OPT_SUBCOMMAND("bisect-replay", &fn, cmd_bisect__replay),
    -+		OPT_SUBCOMMAND("bisect-skip", &fn, cmd_bisect__skip),
    -+		OPT_SUBCOMMAND("bisect-visualize", &fn, cmd_bisect__visualize),
    -+		OPT_SUBCOMMAND("bisect-run", &fn, cmd_bisect__run),
    ++		OPT_SUBCOMMAND("reset", &fn, cmd_bisect__reset),
    ++		OPT_SUBCOMMAND("terms", &fn, cmd_bisect__terms),
    ++		OPT_SUBCOMMAND("start", &fn, cmd_bisect__start),
    ++		OPT_SUBCOMMAND("next", &fn, cmd_bisect__next),
    ++		OPT_SUBCOMMAND("state", &fn, cmd_bisect__state),
    ++		OPT_SUBCOMMAND("log", &fn, cmd_bisect__log),
    ++		OPT_SUBCOMMAND("replay", &fn, cmd_bisect__replay),
    ++		OPT_SUBCOMMAND("skip", &fn, cmd_bisect__skip),
    ++		OPT_SUBCOMMAND("visualize", &fn, cmd_bisect__visualize),
    ++		OPT_SUBCOMMAND("view", &fn, cmd_bisect__visualize),
    ++		OPT_SUBCOMMAND("run", &fn, cmd_bisect__run),
      		OPT_END()
      	};
      	argc = parse_options(argc, argv, prefix, options,
    @@ builtin/bisect--helper.c: static int cmd_bisect__run(int argc, const char **argv
     
      ## git-bisect.sh ##
     @@ git-bisect.sh: case "$#" in
    + 	case "$cmd" in
      	help)
      		git bisect -h ;;
    - 	start)
    +-	start)
     -		git bisect--helper --bisect-start "$@" ;;
    -+		git bisect--helper bisect-start "$@" ;;
      	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
     -		git bisect--helper --bisect-state "$cmd" "$@" ;;
    -+		git bisect--helper bisect-state "$cmd" "$@" ;;
    - 	skip)
    +-	skip)
     -		git bisect--helper --bisect-skip "$@" || exit;;
    -+		git bisect--helper bisect-skip "$@" || exit;;
    - 	next)
    - 		# Not sure we want "next" at the UI level anymore.
    +-	next)
    +-		# Not sure we want "next" at the UI level anymore.
     -		git bisect--helper --bisect-next "$@" || exit ;;
    -+		git bisect--helper bisect-next "$@" || exit ;;
    - 	visualize|view)
    +-	visualize|view)
     -		git bisect--helper --bisect-visualize "$@" || exit;;
    -+		git bisect--helper bisect-visualize "$@" || exit;;
    - 	reset)
    +-	reset)
     -		git bisect--helper --bisect-reset "$@" ;;
    -+		git bisect--helper bisect-reset "$@" ;;
    - 	replay)
    +-	replay)
     -		git bisect--helper --bisect-replay "$@" || exit;;
    -+		git bisect--helper bisect-replay "$@" || exit;;
    ++		git bisect--helper state "$cmd" "$@" ;;
      	log)
     -		git bisect--helper --bisect-log || exit ;;
    -+		git bisect--helper bisect-log || exit ;;
    - 	run)
    +-	run)
     -		git bisect--helper --bisect-run "$@" || exit;;
    -+		git bisect--helper bisect-run "$@" || exit;;
    - 	terms)
    +-	terms)
     -		git bisect--helper --bisect-terms "$@" || exit;;
    -+		git bisect--helper bisect-terms "$@" || exit;;
    ++		git bisect--helper log || exit ;;
      	*)
    - 		usage ;;
    +-		usage ;;
    ++		git bisect--helper "$cmd" "$@" ;;
      	esac
    + esac
     
      ## t/t6030-bisect-porcelain.sh ##
     @@ t/t6030-bisect-porcelain.sh: test_expect_success '"git bisect run" simple case' '
      	git bisect reset
      '
      
    -+# We want to make sure --log is not eaten
    ++# We want to make sure no arguments has been eaten
     +test_expect_success '"git bisect run" simple case' '
     +	git bisect start &&
     +	git bisect good $HASH1 &&
     +	git bisect bad $HASH4 &&
    -+	git bisect run printf "%s\n" --log >my_bisect_log.txt &&
    -+	grep -e --log my_bisect_log.txt &&
    ++	git bisect run printf "%s %s\n" reset --bisect-skip >my_bisect_log.txt &&
    ++	grep -e "reset --bisect-skip" my_bisect_log.txt &&
     +	git bisect reset
     +'
     +
-- 
2.38.1.157.gedabe22e0a

