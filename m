Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05F8F20248
	for <e@80x24.org>; Wed, 13 Mar 2019 12:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfCMMYm (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 08:24:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46463 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbfCMMYm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 08:24:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id 33so1751665wrb.13
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gmCQElg1jcz1HeyaXsQRruFTpCAnxGFcJHXVWUEp10=;
        b=UNCL0h79E4IfglFFXAgbtWZJ2brfzXTizXZ1NUZRKmm2XI3qLnfuLkUWVEBu7wX5Pb
         6i144aZzVtoi+xrmuLIeKJoOjlZsMYAHaBGfbmLePJsrSZ2YgL0iFLZ4AqalH59e3WhL
         bFO/FR27g2cFdWCahlNnSTAjSRRw42WFuXpanpMa4lFx/dmdmNgu1TDnJ/QtuX/V3DyL
         RtLBOU4VxMC9Lz4x8DfSnDdsEt9sRLRodur0YZNgH2zAW+BAF5NzJSKX3KRCIkV2tq2s
         tuLUFNRWUp85DtiPtsUh3Qo3DnTT+hzXkr9ojLoj7omNZ9ABxZrKXZBgC+6g882pjd1g
         4Mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6gmCQElg1jcz1HeyaXsQRruFTpCAnxGFcJHXVWUEp10=;
        b=S6LH6kmrDkljgcwbHw4fcXgUtwESDzX8uqI0SfCb+M5UwHuxdQwgz1ndc533x3CUF3
         LSh3p2T9igUBd3tOfyU/NhRW/CHOG5rg7wxufGPcxuZo8iizxA6g/e2HPKDlGwVHOXIu
         +WcOtDbsbIv+UOFtPTcDUvnyAZosKtLijO9QiqBz6RHRp3OhAJ1JywnBiJ4k58nKkCy9
         7a524aWB67dC8TWl7G6obP+JofjlGPlm5ihf5a1nXwW7QWXXSMg5sndu7Pvv2di4pWyR
         omxnSoMfYt1elh6oexuNbSWyIMYmeQBwqrNh2HcJFMDot0uiQYDp61IaGil9IiNTMyrJ
         00Mw==
X-Gm-Message-State: APjAAAV9JagYCVZkuWpo2IEBsp0P1gRX5GnSi1Us/O6JlXz8G4AmG0vI
        2H3EpJGMgsggctvlF15pjfMNcnUQ
X-Google-Smtp-Source: APXvYqxXpctjeSdbowyUfL9WJZGrqTZSRGLaaxzLHPVu1Ndr1pCmNL5rak/y0A0YFiupGs6MVRGtbg==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr20357028wrs.307.1552479879046;
        Wed, 13 Mar 2019 05:24:39 -0700 (PDT)
Received: from localhost.localdomain (x4d0c2b66.dyn.telefonica.de. [77.12.43.102])
        by smtp.gmail.com with ESMTPSA id t2sm8348287wra.9.2019.03.13.05.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Mar 2019 05:24:38 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Luke Diamand <luke@diamand.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 00/11] tests: introduce 'test_atexit'
Date:   Wed, 13 Mar 2019 13:24:08 +0100
Message-Id: <20190313122419.2210-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.21.0.499.g4d310c7a8e.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce the 'test_atexit' helper function to run cleanup commands
unconditionally at the end of a test script, mainly to reliably stop
daemon processes.  'test_atexit' provides a shorter, simpler, more
consistent, and more robust way to accomplish that compared to the
current situation where tests and test libraries manually register
cleanup commands on trap on EXIT.


Dscho had the first stab at 'test_atexit' as part of an early version
of his Azure Pipelines CI patch series:

  https://public-inbox.org/git/12d6137f8d2ccc2041bed8d56d88a09b1db0fd77.1539598316.git.gitgitgadget@gmail.com/

but he dropped those three patches from later versions, and we agreed
that I take them over.


01/11 test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'

  This was a fun puzzle to piece together...

02/11 t/lib-git-daemon: make sure to kill the 'git-daemon' process

  I'm not sure whether this is the right thing to do, and have the
  nagging feeling that the issue this patch fixes/works around might
  be a symptom of something more fundamental, but I didn't look into
  how the main git "wrapper" and dashed external commands interact.

03/11 test-lib: introduce 'test_atexit'
04/11 git-daemon: use 'test_atexit` to stop 'git-daemon'
05/11 tests: use 'test_atexit' to stop httpd
06/11 t0301-credential-cache: use 'test_atexit' to stop the credentials helper
07/11 git p4 test: use 'test_atexit' to kill p4d and the watchdog process

  Introduce 'test_atexit' and use it to stop the various daemons
  involved in our tests.

08/11 git p4 test: clean up the p4d cleanup functions
09/11 git p4 test: simplify timeout handling
10/11 git p4 test: disable '-x' tracing in the p4d watchdog loop

  Various cleanups to 't/lib-git-p4.sh'.

11/11 t9811-git-p4-label-import: fix pipeline negation

  A little while-at-it portability fix that I happened to stumble
  upon.


The range-diff below is primarily for Dscho's benefit (assuming he
still remembers his old patches... :)  It was generated by comparing
this patch series to his three 'test_atexit' patches cherry-picked on
top of v2.21.0.  My modifications to his patches are mainly
documentation updates and a few minor fixes.


Johannes Schindelin (3):
  test-lib: introduce 'test_atexit'
  git-daemon: use 'test_atexit` to stop 'git-daemon'
  git p4 test: use 'test_atexit' to kill p4d and the watchdog process

SZEDER Gábor (8):
  test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'
  t/lib-git-daemon: make sure to kill the 'git-daemon' process
  tests: use 'test_atexit' to stop httpd
  t0301-credential-cache: use 'test_atexit' to stop the credentials
    helper
  git p4 test: clean up the p4d cleanup functions
  git p4 test: simplify timeout handling
  git p4 test: disable '-x' tracing in the p4d watchdog loop
  t9811-git-p4-label-import: fix pipeline negation

 t/README                                      | 20 ++++++
 t/interop/i5500-git-daemon.sh                 |  1 -
 t/lib-git-daemon.sh                           | 20 ++++--
 t/lib-git-p4.sh                               | 65 +++++++------------
 t/lib-git-svn.sh                              |  5 --
 t/lib-httpd.sh                                |  6 +-
 t/t0000-basic.sh                              | 18 +++++
 t/t0301-credential-cache.sh                   |  7 +-
 t/t0410-partial-clone.sh                      |  2 -
 t/t5500-fetch-pack.sh                         |  3 -
 t/t5510-fetch.sh                              |  2 -
 t/t5537-fetch-shallow.sh                      |  2 -
 t/t5539-fetch-http-shallow.sh                 |  1 -
 t/t5540-http-push-webdav.sh                   |  2 -
 t/t5541-http-push-smart.sh                    |  1 -
 t/t5542-push-http-shallow.sh                  |  1 -
 t/t5545-push-options.sh                       |  2 -
 t/t5550-http-fetch-dumb.sh                    |  1 -
 t/t5551-http-fetch-smart.sh                   |  1 -
 t/t5561-http-backend.sh                       |  1 -
 t/t5570-git-daemon.sh                         |  1 -
 t/t5581-http-curl-verbose.sh                  |  2 -
 t/t5601-clone.sh                              |  2 -
 t/t5616-partial-clone.sh                      |  2 -
 t/t5700-protocol-v1.sh                        |  2 -
 t/t5702-protocol-v2.sh                        |  2 -
 t/t5703-upload-pack-ref-in-want.sh            |  2 -
 t/t5812-proto-disable-http.sh                 |  1 -
 t/t9115-git-svn-dcommit-funky-renames.sh      |  2 -
 t/t9118-git-svn-funky-branch-names.sh         |  2 -
 t/t9120-git-svn-clone-with-percent-escapes.sh |  2 -
 t/t9142-git-svn-shallow-clone.sh              |  2 -
 t/t9800-git-p4-basic.sh                       |  4 --
 t/t9801-git-p4-branch.sh                      |  8 +--
 t/t9802-git-p4-filetype.sh                    |  4 --
 t/t9803-git-p4-shell-metachars.sh             |  4 --
 t/t9804-git-p4-label.sh                       |  4 --
 t/t9805-git-p4-skip-submit-edit.sh            |  4 --
 t/t9806-git-p4-options.sh                     |  5 --
 t/t9807-git-p4-submit.sh                      |  4 --
 t/t9808-git-p4-chdir.sh                       |  4 --
 t/t9809-git-p4-client-view.sh                 |  4 --
 t/t9810-git-p4-rcs.sh                         |  4 --
 t/t9811-git-p4-label-import.sh                |  7 +-
 t/t9812-git-p4-wildcards.sh                   |  4 --
 t/t9813-git-p4-preserve-users.sh              |  4 --
 t/t9814-git-p4-rename.sh                      |  4 --
 t/t9815-git-p4-submit-fail.sh                 |  4 --
 t/t9816-git-p4-locked.sh                      |  4 --
 t/t9817-git-p4-exclude.sh                     |  4 --
 t/t9818-git-p4-block.sh                       |  4 --
 t/t9819-git-p4-case-folding.sh                |  4 --
 t/t9820-git-p4-editor-handling.sh             |  4 --
 t/t9821-git-p4-path-variations.sh             |  4 --
 t/t9822-git-p4-path-encoding.sh               |  4 --
 t/t9823-git-p4-mock-lfs.sh                    |  4 --
 t/t9824-git-p4-git-lfs.sh                     |  4 --
 t/t9825-git-p4-handle-utf16-without-bom.sh    |  4 --
 t/t9826-git-p4-keep-empty-commits.sh          |  4 --
 t/t9827-git-p4-change-filetype.sh             |  4 --
 t/t9828-git-p4-map-user.sh                    |  4 --
 t/t9829-git-p4-jobs.sh                        |  4 --
 t/t9830-git-p4-symlink-dir.sh                 |  4 --
 t/t9831-git-p4-triggers.sh                    |  4 --
 t/t9832-unshelve.sh                           |  3 -
 t/t9833-errors.sh                             |  5 --
 t/test-lib-functions.sh                       | 28 ++++++++
 t/test-lib.sh                                 | 28 +++++++-
 68 files changed, 136 insertions(+), 247 deletions(-)

Range-diff:
 -:  ---------- >  1:  2a0aeb32f6 test-lib: fix interrupt handling with 'dash' and '--verbose-log -x'
 -:  ---------- >  2:  1dfab6cf94 t/lib-git-daemon: make sure to kill the 'git-daemon' process
 1:  b4769ffa31 !  3:  c9c3efcc7a tests: introduce `test_atexit`
    @@ -1,22 +1,83 @@
     Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     
    -    tests: introduce `test_atexit`
    +    test-lib: introduce 'test_atexit'
     
    -    When running the p4 daemon or `git daemon`, we want to kill it at the
    -    end of the test script.
    +    When running Apache, 'git daemon', or p4d, we want to kill them at the
    +    end of the test script, otherwise a leftover daemon process will keep
    +    its port open indefinitely, and thus will interfere with subsequent
    +    executions of the same test script.
     
    -    So far, we do this "manually".
    +    So far, we stop these daemon processes "manually", i.e.:
     
    -    However, in the next few commits we want to teach the test suite to
    -    optionally re-run scripts with different options, therefore we will have
    -    to have a consistent way to stop daemons.
    +      - by registering functions or commands in the trap on EXIT to stop
    +        the daemon while preserving the last seen exit code before the
    +        trap (to deal with a failure when run with '--immediate' or with
    +        interrupts by ctrl-C),
     
    -    Let's introduce `test_atexit`, which is loosely modeled after
    -    `test_when_finished` (but has a broader scope: rather than running the
    +      - and by invoking these functions/commands last thing before
    +        'test_done' (and sometimes restoring the test framework's default
    +        trap on EXIT, to prevent the daemons from being killed twice).
    +
    +    On one hand, we do this inconsistently, e.g. 'git p4' tests invoke
    +    different functions in the trap on EXIT and in the last test before
    +    'test_done', and they neither restore the test framework's default trap
    +    on EXIT nor preserve the last seen exit code.  On the other hand, this
    +    is error prone, because, as shown in a previous patch in this series,
    +    any output from the cleanup commands in the trap on EXIT can prevent a
    +    proper cleanup when a test script run with '--verbose-log' and certain
    +    shells, notably 'dash', is interrupted.
    +
    +    Let's introduce 'test_atexit', which is loosely modeled after
    +    'test_when_finished', but has a broader scope: rather than running the
         commands after the current test case, run them when the test script
    -    finishes, and also run them when the `--immediate` option is in effect).
    +    finishes, and also run them when the test is interrupted, or exits
    +    early in case of a failure while the '--immediate' option is in
    +    effect.
    +
    +    When running the cleanup commands at the end of a successful test,
    +    then they will be run in 'test_done' before it removes the trash
    +    directory, i.e. the cleanup commands will still be able to access any
    +    pidfiles or socket files in there.  When running the cleanup commands
    +    after an interrupt or failure with '--immediate', then they will be
    +    run in the trap on EXIT.  In both cases they will be run in
    +    'test_eval_', i.e. both standard error and output of all cleanup
    +    commands will go where they should according to the '-v' or
    +    '--verbose-log' options, and thus won't cause any troubles when
    +    interrupting a test script run with '--verbose-log'.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
    +
    + diff --git a/t/README b/t/README
    + --- a/t/README
    + +++ b/t/README
    +@@
    + 		...
    + 	'
    + 
    ++ - test_atexit <script>
    ++
    ++   Prepend <script> to a list of commands to run unconditionally to
    ++   clean up before the test script exits, e.g. to stop a daemon:
    ++
    ++	test_expect_success 'test git daemon' '
    ++		git daemon &
    ++		daemon_pid=$! &&
    ++		test_atexit 'kill $daemon_pid' &&
    ++		hello world
    ++	'
    ++
    ++   The commands will be executed before the trash directory is removed,
    ++   i.e. the atexit commands will still be able to access any pidfiles or
    ++   socket files.
    ++
    ++   Note that these commands will be run even when a test script run
    ++   with '--immediate' fails.  Be careful with your atexit commands to
    ++   minimize any changes to the failed state.
    ++
    +  - test_write_lines <lines>
    + 
    +    Write <lines> on standard output, one line per argument.
     
      diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
      --- a/t/t0000-basic.sh
    @@ -38,7 +99,7 @@
     +	'
     +	test_done
     +	EOF
    -+	test_path_exists dont-clean-atexit &&
    ++	test_path_is_file dont-clean-atexit &&
     +	test_path_is_missing clean-atexit &&
     +	test_path_is_missing also-clean-atexit
     +"
    @@ -60,9 +121,17 @@
     +#	test_expect_success 'test git daemon' '
     +#		git daemon &
     +#		daemon_pid=$! &&
    -+#		test_atexit "kill $daemon_pid" &&
    ++#		test_atexit 'kill $daemon_pid' &&
     +#		hello world
     +#	'
    ++#
    ++# The commands will be executed before the trash directory is removed,
    ++# i.e. the atexit commands will still be able to access any pidfiles or
    ++# socket files.
    ++#
    ++# Note that these commands will be run even when a test script run
    ++# with '--immediate' fails.  Be careful with your atexit commands to
    ++# minimize any changes to the failed state.
     +
     +test_atexit () {
     +	# We cannot detect when we are in a subshell in general, but by
    @@ -73,15 +142,6 @@
     +	test_atexit_cleanup="{ $*
     +		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
     +}
    -+
    -+test_atexit_handler () {
    -+	test : != "$test_atexit_cleanup" || return 0
    -+
    -+	setup_malloc_check
    -+	test_eval_ "$test_atexit_cleanup"
    -+	test_atexit_cleanup=:
    -+	teardown_malloc_check
    -+}
     +
      # Most tests can use the created repository, but some may need to create more.
      # Usage: test_create_repo <directory>
    @@ -94,6 +154,9 @@
      
      die () {
      	code=$?
    ++	# This is responsible for running the atexit commands even when a
    ++	# test script run with '--immediate' fails, or when the user hits
    ++	# ctrl-C, i.e. when 'test_done' is not invoked at all.
     +	test_atexit_handler || code=$?
      	if test -n "$GIT_EXIT_OK"
      	then
    @@ -103,10 +166,26 @@
      }
      
     +test_atexit_cleanup=:
    ++test_atexit_handler () {
    ++	# In a succeeding test script 'test_atexit_handler' is invoked
    ++	# twice: first from 'test_done', then from 'die' in the trap on
    ++	# EXIT.
    ++	# This condition and resetting 'test_atexit_cleanup' below makes
    ++	# sure that the registered cleanup commands are run only once.
    ++	test : != "$test_atexit_cleanup" || return 0
    ++
    ++	setup_malloc_check
    ++	test_eval_ "$test_atexit_cleanup"
    ++	test_atexit_cleanup=:
    ++	teardown_malloc_check
    ++}
    ++
      test_done () {
      	GIT_EXIT_OK=t
      
    -+	test -n "$immediate" || test_atexit_handler
    ++	# Run the atexit commands _before_ the trash directory is
    ++	# removed, so the commands can access pidfiles and socket files.
    ++	test_atexit_handler
     +
      	if test -n "$write_junit_xml" && test -n "$junit_xml_path"
      	then
 2:  39ad1480c5 !  4:  52dfb87ae3 git-daemon: use `test_atexit` in the tests
    @@ -1,12 +1,18 @@
     Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     
    -    git-daemon: use `test_atexit` in the tests
    +    git-daemon: use 'test_atexit` to stop 'git-daemon'
     
    -    This makes use of the just-introduced consistent way to specify that a
    -    long-running process needs to be terminated at the end of a test script
    -    run.
    +    Use 'test_atexit' to run cleanup commands to stop 'git-daemon' at the
    +    end of the test script or upon interrupt or failure, as it is shorter,
    +    simpler, and more robust than registering such cleanup commands in the
    +    trap on EXIT in the test scripts.
    +
    +    Note that in 't5570-git-daemon.sh' the daemon is stopped and then
    +    re-started in the middle of the test script; take care that the
    +    cleanup functions to stop the daemon are only registered once.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/t/interop/i5500-git-daemon.sh b/t/interop/i5500-git-daemon.sh
      --- a/t/interop/i5500-git-daemon.sh
    @@ -30,14 +36,46 @@
      
      test_tristate GIT_TEST_GIT_DAEMON
     @@
    + GIT_DAEMON_HOST_PORT=127.0.0.1:$LIB_GIT_DAEMON_PORT
    + GIT_DAEMON_URL=git://$GIT_DAEMON_HOST_PORT
    + 
    ++registered_stop_git_daemon_atexit_handler=
    + start_git_daemon() {
    + 	if test -n "$GIT_DAEMON_PID"
    + 	then
    +@@
      
      	mkdir -p "$GIT_DAEMON_DOCUMENT_ROOT_PATH"
      
     -	trap 'code=$?; stop_git_daemon; (exit $code); die' EXIT
    -+	test_atexit 'stop_git_daemon'
    ++	# One of the test scripts stops and then re-starts 'git daemon'.
    ++	# Don't register and then run the same atexit handlers several times.
    ++	if test -z "$registered_stop_git_daemon_atexit_handler"
    ++	then
    ++		test_atexit 'stop_git_daemon'
    ++		registered_stop_git_daemon_atexit_handler=AlreadyDone
    ++	fi
      
      	say >&3 "Starting git daemon ..."
      	mkfifo git_daemon_output
    +@@
    + 	then
    + 		kill "$GIT_DAEMON_PID"
    + 		wait "$GIT_DAEMON_PID"
    +-		trap 'die' EXIT
    ++		unset GIT_DAEMON_PID
    + 		test_skip_or_die $GIT_TEST_GIT_DAEMON \
    + 			"git daemon failed to start"
    + 	fi
    +@@
    + 		return
    + 	fi
    + 
    +-	trap 'die' EXIT
    +-
    + 	# kill git-daemon child of git
    + 	say >&3 "Stopping git daemon ..."
    + 	kill "$GIT_DAEMON_PID"
     
      diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
      --- a/t/t5570-git-daemon.sh
 -:  ---------- >  5:  32cde9101e tests: use 'test_atexit' to stop httpd
 -:  ---------- >  6:  fafad7f83d t0301-credential-cache: use 'test_atexit' to stop the credentials helper
 3:  d938232a92 !  7:  5a3cdbae15 git-p4: use `test_atexit` to kill the daemon
    @@ -1,60 +1,53 @@
     Author: Johannes Schindelin <johannes.schindelin@gmx.de>
     
    -    git-p4: use `test_atexit` to kill the daemon
    +    git p4 test: use 'test_atexit' to kill p4d and the watchdog process
     
    -    This should be more reliable than the current method, and prepares the
    -    test suite for a consistent way to clean up before re-running the tests
    -    with different options.
    +    Use 'test_atexit' to run cleanup commands to stop 'p4d' at the end of
    +    the test script or upon interrupt or failure, as it is shorter,
    +    simpler, and more robust than registering such cleanup commands in the
    +    trap on EXIT in the test scripts.
    +
    +    Note that one of the test scripts, 't9801-git-p4-branch.sh', stops and
    +    then re-starts 'p4d' twice in the middle of the script; take care that
    +    the cleanup functions to stop 'p4d' are only registered once.
    +
    +    Note also that 'git p4' tests invoke different functions in the trap
    +    on EXIT ('cleanup') and in the last test before 'test_done'
    +    ('kill_p4d').  Register both of these functions with 'test_atexit' for
    +    now, and a a later patch in this series will then clean up the
    +    redundancy.
     
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
    +    Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
      --- a/t/lib-git-p4.sh
      +++ b/t/lib-git-p4.sh
     @@
    - git="$TRASH_DIRECTORY/git"
    - pidfile="$TRASH_DIRECTORY/p4d.pid"
    - 
    --# Sometimes "prove" seems to hang on exit because p4d is still running
    --cleanup () {
    --	if test -f "$pidfile"
    --	then
    --		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
    --	fi
    --}
    --trap cleanup EXIT
    --
    - # git p4 submit generates a temp file, which will
    - # not get cleaned up if the submission fails.  Don't
    - # clutter up /tmp on the test machine.
    -@@
    - 		# p4d failed to start
    - 		return 1
    + 		kill -9 $(cat "$pidfile") 2>/dev/null && exit 255
      	fi
    -+	test_atexit kill_p4d
    - 
    - 	# build a p4 user so author@example.com has an entry
    - 	p4_add_user author
    -
    - diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
    - --- a/t/t0000-basic.sh
    - +++ b/t/t0000-basic.sh
    -@@
    - 	)
      }
    +-trap cleanup EXIT
      
    -+cat >/dev/null <<\DDD
    - test_expect_success 'pretend we have a fully passing test suite' "
    - 	run_sub_test_lib_test full-pass '3 passing tests' <<-\\EOF &&
    - 	for i in 1 2 3
    + # git p4 submit generates a temp file, which will
    + # not get cleaned up if the submission fails.  Don't
     @@
    - 	> 1..2
    - 	EOF
    - "
    -+DDD
    - 
    - test_expect_success 'test_atexit is run' "
    - 	test_must_fail run_sub_test_lib_test \
    + TMPDIR="$TRASH_DIRECTORY"
    + export TMPDIR
    + 
    ++registered_stop_p4d_atexit_handler=
    + start_p4d () {
    ++	# One of the test scripts stops and then re-starts p4d.
    ++	# Don't register and then run the same atexit handlers several times.
    ++	if test -z "$registered_stop_p4d_atexit_handler"
    ++	then
    ++		test_atexit 'kill_p4d; cleanup'
    ++		registered_stop_p4d_atexit_handler=AlreadyDone
    ++	fi
    ++
    + 	mkdir -p "$db" "$cli" "$git" &&
    + 	rm -f "$pidfile" &&
    + 	(
     
      diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
      --- a/t/t9800-git-p4-basic.sh
 -:  ---------- >  8:  ad083c6a74 git p4 test: clean up the p4d cleanup functions
 -:  ---------- >  9:  05ecee5c13 git p4 test: simplify timeout handling
 -:  ---------- > 10:  7626c0df88 git p4 test: disable '-x' tracing in the p4d watchdog loop
 -:  ---------- > 11:  53082f8ce1 t9811-git-p4-label-import: fix pipeline negation
-- 
2.21.0.499.g4d310c7a8e.dirty

