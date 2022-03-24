Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C65C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349919AbiCXQvZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCXQvX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D828EB5D
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:50 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id p189so3097458wmp.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wGagqyvscsyJOWH96Z65sMb1p/Y5fXapPo+ryMWScfQ=;
        b=ImB5SjhyOx0liy4zGcP9BEFAxma5rpzixTFeUlnBkS2QdVdsg+PpCzKItQaLue9PVQ
         /VcpLihRpwpQ6cWupoQcW5/EKmcJS4+DVpMvsQnAq3Ql27JA/xhM2ye6QCncTCgfHZZR
         ApPRggPkenFWNU3jVzcbOWcUMCyqy/iMBrQoaVaHlt+BtF3khKqvhE9ejX3rn54LoaHP
         PBGhNy9yAipWxRduAAHGm+TJk9T5yIICw25/MvIoRp9PVKzTtHVdtDeR/UctRH0eK4/2
         NYvIHQVNxbWfA1j0H+q5/C7+REuvzFZXcmKfPtXpzTofYxcyvaRNx76TK1ljLrJ2JDUR
         LWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wGagqyvscsyJOWH96Z65sMb1p/Y5fXapPo+ryMWScfQ=;
        b=dbfElVQVfvATBQeN2g7+vIPmh7kWiDn+Nodf/m1dCiLb2hiPfWsBKuBTCGuyh6KB61
         AgylEK4L9Gpj6+ZQuI9SZ8Ee/6WAZ7hmRLcOc98cmjtAeAE/dz/03NyGTCfDPM9STFi7
         6B0vQExz0jGmnaLru7PZxzeVFmJ1G08zzo5ysUiY7u6WPNHnI2QmrwkY4J3JHUjsCURQ
         RNKCeHm8M04o/ITXEr6DVIipwHAHyiNaxvHkW/Q7QaUteOHkgGJj5Lu4JRfLS+q/4mW3
         BcCZEK4Tnk28yyCDFtLPK4f+c9/xitvKLBjgRrWq6MQweOwykQEWHqD7swz7EIuI/eND
         pZBA==
X-Gm-Message-State: AOAM533RLFRTralUDKRxOUxlCGVE36wPVEW7u2oGfBmHiWcKJAJnXHeN
        Z9J9IBjNkybPhY8IJRsYo+/JhUuwcjE=
X-Google-Smtp-Source: ABdhPJxIqOo7qgP7h+2qxfLIbYiaJ7x2I3CCR4LYgTDs4rmt7bs8G6o1OaS6Eq+uVQeWkn8y1vQIFQ==
X-Received: by 2002:a05:600c:190e:b0:38c:b1ea:f4ac with SMTP id j14-20020a05600c190e00b0038cb1eaf4acmr5613891wmq.70.1648140588414;
        Thu, 24 Mar 2022 09:49:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i10-20020a0560001aca00b00203daf3759asm3278253wry.68.2022.03.24.09.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:49:47 -0700 (PDT)
Message-Id: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:16 +0000
Subject: [PATCH v8 00/30] Builtin FSMonitor Part 2
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is V8 of Part 2 of my builtin FSMonitor series. This contains last
minute comments on V7. I'll also send an updated version of Part 3 that
builds upon this version.

Here is a range-diff from V7 to V8 relative to 715d08a9e5 (The eighth batch,
2022-02-25). Changes since V7 can be summarized as:

 * [] Improved arg checking in start_daemon() in t7527.
 * [] Switch start_daemon() args to use double-dash keywords.
 * [] Split out coding style changes in p7519 into separate commit from
   speed up changes.
 * [] Disabled some of the matrix tests in t7527 concerning the untracked
   cache.
 * [] Other minor style cleanups.

 1:  e98373f997 =  1:  e98373f997 fsmonitor: enhance existing comments, clarify trivial response handling
 2:  ab68b94417 =  2:  ab68b94417 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
 3:  e04c7301f2 =  3:  e04c7301f2 fsmonitor: config settings are repository-specific
 4:  ea02ba25d8 =  4:  ea02ba25d8 fsmonitor: use IPC to query the builtin FSMonitor daemon
 5:  6ab7db9cb7 =  5:  6ab7db9cb7 fsmonitor: document builtin fsmonitor
 6:  0ce8ae3f2c =  6:  0ce8ae3f2c fsmonitor--daemon: add a built-in fsmonitor daemon
 7:  4624ce2fa4 =  7:  4624ce2fa4 fsmonitor--daemon: implement 'stop' and 'status' commands
 8:  a29fe7266a =  8:  a29fe7266a compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
 9:  2f8a42fdb9 =  9:  2f8a42fdb9 compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
10:  f07800690e = 10:  f07800690e fsmonitor--daemon: implement 'run' command
11:  a6a39a3306 = 11:  a6a39a3306 fsmonitor--daemon: implement 'start' command
12:  d62e338d00 = 12:  d62e338d00 fsmonitor--daemon: add pathname classification
13:  53e06b4ae5 = 13:  53e06b4ae5 fsmonitor--daemon: define token-ids
14:  39f43fabe0 = 14:  39f43fabe0 fsmonitor--daemon: create token-based changed path cache
15:  239558e34f = 15:  239558e34f compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
16:  14b775e9d8 = 16:  14b775e9d8 compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
17:  55bd7aee06 = 17:  55bd7aee06 compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
18:  1f4b5209bf ! 18:  c43009124f fsmonitor--daemon: implement handle_client callback
    @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
     +        trace2_data_intmax("fsmonitor", the_repository,
     +                   "response/trivial", 1);
     +
    -+        strbuf_release(&response_token);
    -+        strbuf_release(&requested_token_id);
    -+        return 0;
    ++        goto cleanup;
     +    }
     +
     +    /*
    @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
     +    trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
     +    trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
     +
    ++cleanup:
     +    strbuf_release(&response_token);
     +    strbuf_release(&requested_token_id);
     +    strbuf_release(&payload);
19:  8cf62c9fc6 = 19:  ed338777b5 help: include fsmonitor--daemon feature flag in version info
20:  1bd74a8159 = 20:  c99bac29d4 t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
21:  4a920d0b54 ! 21:  c8709da945 t7527: create test for fsmonitor--daemon
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +    rm -rf $1
     +}
     +
    ++is_value () {
    ++    test -n "$1" && test "${1::1}" != "-"
    ++}
    ++
     +start_daemon () {
     +    r= &&
     +    tf= &&
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +        case "$1" in
     +        -C)
     +            shift;
    -+            test "$#" -ne 0 || BUG "error: -C requires arg"
    ++            is_value $1 || BUG "error: -C requires value"
     +            r="-C $1"
     +            shift
     +            ;;
    -+        -tf)
    ++        --tf)
     +            shift;
    -+            test "$#" -ne 0 || BUG "error: -tf requires arg"
    ++            is_value $1 || BUG "error: --tf requires value"
     +            tf="$1"
     +            shift
     +            ;;
    -+        -t2)
    ++        --t2)
     +            shift;
    -+            test "$#" -ne 0 || BUG "error: -t2 requires arg"
    ++            is_value $1 || BUG "error: --t2 requires value"
     +            t2="$1"
     +            shift
     +            ;;
    -+        -tk)
    ++        --tk)
     +            shift;
    -+            test "$#" -ne 0 || BUG "error: -tk requires arg"
    ++            is_value $1 || BUG "error: --tk requires value"
     +            tk="$1"
     +            shift
     +            ;;
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'edit some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    edit_files &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'create some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    create_files &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'delete some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    delete_files &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'rename some files' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    rename_files &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'rename directory' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    mv dirtorename dirrenamed &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'file changes to directory' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    file_to_directory &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +test_expect_success 'directory changes to a file' '
     +    test_when_finished clean_up_repo_and_stop_daemon &&
     +
    -+    start_daemon -tf "$PWD/.git/trace" &&
    ++    start_daemon --tf "$PWD/.git/trace" &&
     +
     +    directory_to_file &&
     +
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +
     +    git init test_flush &&
     +
    -+    start_daemon -C test_flush -tf "$PWD/.git/trace_daemon" -tk true &&
    ++    start_daemon -C test_flush --tf "$PWD/.git/trace_daemon" --tk true &&
     +
     +    # The daemon should have an initial token with no events in _0 and
     +    # then a few (probably platform-specific number of) events in _1.
    @@ t/t7527-builtin-fsmonitor.sh (new)
     +    git -C wt-base worktree add ../wt-secondary &&
     +
     +    start_daemon -C wt-secondary \
    -+        -tf "$PWD/trace_wt_secondary" \
    -+        -t2 "$PWD/trace2_wt_secondary" &&
    ++        --tf "$PWD/trace_wt_secondary" \
    ++        --t2 "$PWD/trace2_wt_secondary" &&
     +
     +    git -C wt-secondary fsmonitor--daemon stop &&
     +    test_must_fail git -C wt-secondary fsmonitor--daemon status
22:  c925a9a745 = 22:  cc39ecf10a t/perf: avoid copying builtin fsmonitor files into test repo
23:  5b3381c223 = 23:  2bb3eb8476 t/helper/test-chmtime: skip directories on Windows
 -:  ---------- > 24:  bab9a9b080 t/perf/p7519: fix coding style
24:  803a540cc0 ! 25:  2dd06ad2f7 t/perf/p7519: speed up test on Windows
    @@ Commit message
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## t/perf/p7519-fsmonitor.sh ##
    -@@ t/perf/p7519-fsmonitor.sh: then
    -     fi
    - fi
    - 
    --trace_start() {
    -+trace_start () {
    -     if test -n "$GIT_PERF_7519_TRACE"
    -     then
    -         name="$1"
    -@@ t/perf/p7519-fsmonitor.sh: trace_start() {
    -     fi
    - }
    - 
    --trace_stop() {
    -+trace_stop () {
    -     if test -n "$GIT_PERF_7519_TRACE"
    -     then
    -         unset GIT_TRACE2_PERF
    +@@ t/perf/p7519-fsmonitor.sh: trace_stop () {
          fi
      }
      
     +touch_files () {
    -+    n=$1
    -+    d="$n"_files
    ++    n=$1 &&
    ++    d="$n"_files &&
     +
    -+    (cd $d ; test_seq 1 $n | xargs touch )
    ++    (cd $d && test_seq 1 $n | xargs touch )
     +}
     +
      test_expect_success "one time repo setup" '
    @@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
          git add 1_file 10_files 100_files 1000_files 10000_files &&
          git commit -qm "Add files" &&
      
    -@@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
    -     fi
    - '
    - 
    --setup_for_fsmonitor() {
    -+setup_for_fsmonitor () {
    -     # set INTEGRATION_SCRIPT depending on the environment
    -     if test -n "$INTEGRATION_PATH"
    -     then
    -@@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
    -     test_perf "$@"
    - }
    - 
    --test_fsmonitor_suite() {
    -+test_fsmonitor_suite () {
    -     if test -n "$INTEGRATION_SCRIPT"; then
    -         DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
    -     else
    -@@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
    +@@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite () {
      
          # Update the mtimes on upto 100k files to make status think
          # that they are dirty.  For simplicity, omit any files with
25:  d5ca2df31c = 26:  6eaa5765ae t/perf/p7519: add fsmonitor--daemon test cases
26:  42631259e8 = 27:  30957f3930 fsmonitor--daemon: periodically truncate list of modified files
27:  f256c3cbe8 = 28:  c8ca2a1727 fsmonitor--daemon: use a cookie file to sync with file system
28:  08af8296f9 = 29:  4caf1d89b8 fsmonitor: force update index after large responses
29:  e6cf84dc8e ! 30:  f87a1eba69 t7527: test status with untracked-cache and fsmonitor--daemon
    @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
     +    fsm=$2 &&
     +    fn=$3 &&
     +
    ++    if test $uc = true && test $fsm = false
    ++    then
    ++        # The untracked-cache is buggy when FSMonitor is
    ++        # DISABLED, so skip the tests for this matrix
    ++        # combination.
    ++        #
    ++        # We've observed random, occasional test failures on
    ++        # Windows and MacOS when the UC is turned on and FSM
    ++        # is turned off.  These are rare, but they do happen
    ++        # indicating that it is probably a race condition within
    ++        # the untracked cache itself.
    ++        #
    ++        # It usually happens when a test does F/D trickery and
    ++        # then the NEXT test fails because of extra status
    ++        # output from stale UC data from the previous test.
    ++        #
    ++        # Since FSMonitor is not involved in the error, skip
    ++        # the tests for this matrix combination.
    ++        #
    ++        return 0
    ++    fi &&
    ++
     +    test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
     +        matrix_clean_up_repo &&
     +        $fn &&


Jeff Hostetler (30):
  fsmonitor: enhance existing comments, clarify trivial response
    handling
  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  fsmonitor: config settings are repository-specific
  fsmonitor: use IPC to query the builtin FSMonitor daemon
  fsmonitor: document builtin fsmonitor
  fsmonitor--daemon: add a built-in fsmonitor daemon
  fsmonitor--daemon: implement 'stop' and 'status' commands
  compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
  fsmonitor--daemon: implement 'run' command
  fsmonitor--daemon: implement 'start' command
  fsmonitor--daemon: add pathname classification
  fsmonitor--daemon: define token-ids
  fsmonitor--daemon: create token-based changed path cache
  compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on
    Windows
  compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
  compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on
    MacOS
  fsmonitor--daemon: implement handle_client callback
  help: include fsmonitor--daemon feature flag in version info
  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
    Daemon
  t7527: create test for fsmonitor--daemon
  t/perf: avoid copying builtin fsmonitor files into test repo
  t/helper/test-chmtime: skip directories on Windows
  t/perf/p7519: fix coding style
  t/perf/p7519: speed up test on Windows
  t/perf/p7519: add fsmonitor--daemon test cases
  fsmonitor--daemon: periodically truncate list of modified files
  fsmonitor--daemon: use a cookie file to sync with file system
  fsmonitor: force update index after large responses
  t7527: test status with untracked-cache and fsmonitor--daemon

 .gitignore                              |    1 +
 Documentation/config/core.txt           |   60 +-
 Documentation/git-fsmonitor--daemon.txt |   75 ++
 Documentation/git-update-index.txt      |    8 +-
 Makefile                                |   17 +
 builtin.h                               |    1 +
 builtin/fsmonitor--daemon.c             | 1479 +++++++++++++++++++++++
 builtin/update-index.c                  |    7 +-
 cache.h                                 |    1 -
 compat/fsmonitor/fsm-darwin-gcc.h       |   92 ++
 compat/fsmonitor/fsm-listen-darwin.c    |  427 +++++++
 compat/fsmonitor/fsm-listen-win32.c     |  586 +++++++++
 compat/fsmonitor/fsm-listen.h           |   49 +
 config.c                                |   14 -
 config.h                                |    1 -
 config.mak.uname                        |   20 +
 contrib/buildsystems/CMakeLists.txt     |   10 +
 environment.c                           |    1 -
 fsmonitor--daemon.h                     |  166 +++
 fsmonitor-ipc.c                         |  171 +++
 fsmonitor-ipc.h                         |   48 +
 fsmonitor-settings.c                    |  114 ++
 fsmonitor-settings.h                    |   21 +
 fsmonitor.c                             |  216 +++-
 fsmonitor.h                             |   15 +-
 git.c                                   |    1 +
 help.c                                  |    4 +
 repo-settings.c                         |    1 +
 repository.h                            |    3 +
 t/README                                |    4 +-
 t/helper/test-chmtime.c                 |   15 +
 t/helper/test-fsmonitor-client.c        |  116 ++
 t/helper/test-tool.c                    |    1 +
 t/helper/test-tool.h                    |    1 +
 t/perf/p7519-fsmonitor.sh               |   68 +-
 t/perf/perf-lib.sh                      |    2 +-
 t/t7527-builtin-fsmonitor.sh            |  620 ++++++++++
 t/test-lib.sh                           |    7 +
 38 files changed, 4337 insertions(+), 106 deletions(-)
 create mode 100644 Documentation/git-fsmonitor--daemon.txt
 create mode 100644 builtin/fsmonitor--daemon.c
 create mode 100644 compat/fsmonitor/fsm-darwin-gcc.h
 create mode 100644 compat/fsmonitor/fsm-listen-darwin.c
 create mode 100644 compat/fsmonitor/fsm-listen-win32.c
 create mode 100644 compat/fsmonitor/fsm-listen.h
 create mode 100644 fsmonitor--daemon.h
 create mode 100644 fsmonitor-ipc.c
 create mode 100644 fsmonitor-ipc.h
 create mode 100644 fsmonitor-settings.c
 create mode 100644 fsmonitor-settings.h
 create mode 100644 t/helper/test-fsmonitor-client.c
 create mode 100755 t/t7527-builtin-fsmonitor.sh


base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1041/jeffhostetler/builtin-fsmonitor-part2-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/1041

Range-diff vs v7:

  1:  e98373f997f =  1:  e98373f997f fsmonitor: enhance existing comments, clarify trivial response handling
  2:  ab68b944173 =  2:  ab68b944173 fsmonitor-ipc: create client routines for git-fsmonitor--daemon
  3:  e04c7301f24 =  3:  e04c7301f24 fsmonitor: config settings are repository-specific
  4:  ea02ba25d8f =  4:  ea02ba25d8f fsmonitor: use IPC to query the builtin FSMonitor daemon
  5:  6ab7db9cb76 =  5:  6ab7db9cb76 fsmonitor: document builtin fsmonitor
  6:  0ce8ae3f2cf =  6:  0ce8ae3f2cf fsmonitor--daemon: add a built-in fsmonitor daemon
  7:  4624ce2fa47 =  7:  4624ce2fa47 fsmonitor--daemon: implement 'stop' and 'status' commands
  8:  a29fe7266a4 =  8:  a29fe7266a4 compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
  9:  2f8a42fdb93 =  9:  2f8a42fdb93 compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
 10:  f07800690ee = 10:  f07800690ee fsmonitor--daemon: implement 'run' command
 11:  a6a39a3306d = 11:  a6a39a3306d fsmonitor--daemon: implement 'start' command
 12:  d62e338d008 = 12:  d62e338d008 fsmonitor--daemon: add pathname classification
 13:  53e06b4ae5d = 13:  53e06b4ae5d fsmonitor--daemon: define token-ids
 14:  39f43fabe02 = 14:  39f43fabe02 fsmonitor--daemon: create token-based changed path cache
 15:  239558e34ff = 15:  239558e34ff compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on Windows
 16:  14b775e9d8b = 16:  14b775e9d8b compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
 17:  55bd7aee06c = 17:  55bd7aee06c compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on MacOS
 18:  1f4b5209bf6 ! 18:  c43009124fb fsmonitor--daemon: implement handle_client callback
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +		trace2_data_intmax("fsmonitor", the_repository,
      +				   "response/trivial", 1);
      +
     -+		strbuf_release(&response_token);
     -+		strbuf_release(&requested_token_id);
     -+		return 0;
     ++		goto cleanup;
      +	}
      +
      +	/*
     @@ builtin/fsmonitor--daemon.c: void fsmonitor_force_resync(struct fsmonitor_daemon
      +	trace2_data_intmax("fsmonitor", the_repository, "response/count/files", count);
      +	trace2_data_intmax("fsmonitor", the_repository, "response/count/duplicates", duplicates);
      +
     ++cleanup:
      +	strbuf_release(&response_token);
      +	strbuf_release(&requested_token_id);
      +	strbuf_release(&payload);
 19:  8cf62c9fc6f = 19:  ed338777b56 help: include fsmonitor--daemon feature flag in version info
 20:  1bd74a81593 = 20:  c99bac29d42 t/helper/fsmonitor-client: create IPC client to talk to FSMonitor Daemon
 21:  4a920d0b54a ! 21:  c8709da9457 t7527: create test for fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	rm -rf $1
      +}
      +
     ++is_value () {
     ++	test -n "$1" && test "${1::1}" != "-"
     ++}
     ++
      +start_daemon () {
      +	r= &&
      +	tf= &&
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +		case "$1" in
      +		-C)
      +			shift;
     -+			test "$#" -ne 0 || BUG "error: -C requires arg"
     ++			is_value $1 || BUG "error: -C requires value"
      +			r="-C $1"
      +			shift
      +			;;
     -+		-tf)
     ++		--tf)
      +			shift;
     -+			test "$#" -ne 0 || BUG "error: -tf requires arg"
     ++			is_value $1 || BUG "error: --tf requires value"
      +			tf="$1"
      +			shift
      +			;;
     -+		-t2)
     ++		--t2)
      +			shift;
     -+			test "$#" -ne 0 || BUG "error: -t2 requires arg"
     ++			is_value $1 || BUG "error: --t2 requires value"
      +			t2="$1"
      +			shift
      +			;;
     -+		-tk)
     ++		--tk)
      +			shift;
     -+			test "$#" -ne 0 || BUG "error: -tk requires arg"
     ++			is_value $1 || BUG "error: --tk requires value"
      +			tk="$1"
      +			shift
      +			;;
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'edit some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	edit_files &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'create some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	create_files &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'delete some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	delete_files &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'rename some files' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	rename_files &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'rename directory' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	mv dirtorename dirrenamed &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'file changes to directory' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	file_to_directory &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +test_expect_success 'directory changes to a file' '
      +	test_when_finished clean_up_repo_and_stop_daemon &&
      +
     -+	start_daemon -tf "$PWD/.git/trace" &&
     ++	start_daemon --tf "$PWD/.git/trace" &&
      +
      +	directory_to_file &&
      +
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +
      +	git init test_flush &&
      +
     -+	start_daemon -C test_flush -tf "$PWD/.git/trace_daemon" -tk true &&
     ++	start_daemon -C test_flush --tf "$PWD/.git/trace_daemon" --tk true &&
      +
      +	# The daemon should have an initial token with no events in _0 and
      +	# then a few (probably platform-specific number of) events in _1.
     @@ t/t7527-builtin-fsmonitor.sh (new)
      +	git -C wt-base worktree add ../wt-secondary &&
      +
      +	start_daemon -C wt-secondary \
     -+		-tf "$PWD/trace_wt_secondary" \
     -+		-t2 "$PWD/trace2_wt_secondary" &&
     ++		--tf "$PWD/trace_wt_secondary" \
     ++		--t2 "$PWD/trace2_wt_secondary" &&
      +
      +	git -C wt-secondary fsmonitor--daemon stop &&
      +	test_must_fail git -C wt-secondary fsmonitor--daemon status
 22:  c925a9a7459 = 22:  cc39ecf10ae t/perf: avoid copying builtin fsmonitor files into test repo
 23:  5b3381c223e = 23:  2bb3eb84767 t/helper/test-chmtime: skip directories on Windows
  -:  ----------- > 24:  bab9a9b0802 t/perf/p7519: fix coding style
 24:  803a540cc00 ! 25:  2dd06ad2f71 t/perf/p7519: speed up test on Windows
     @@ Commit message
          Signed-off-by: Junio C Hamano <gitster@pobox.com>
      
       ## t/perf/p7519-fsmonitor.sh ##
     -@@ t/perf/p7519-fsmonitor.sh: then
     - 	fi
     - fi
     - 
     --trace_start() {
     -+trace_start () {
     - 	if test -n "$GIT_PERF_7519_TRACE"
     - 	then
     - 		name="$1"
     -@@ t/perf/p7519-fsmonitor.sh: trace_start() {
     - 	fi
     - }
     - 
     --trace_stop() {
     -+trace_stop () {
     - 	if test -n "$GIT_PERF_7519_TRACE"
     - 	then
     - 		unset GIT_TRACE2_PERF
     +@@ t/perf/p7519-fsmonitor.sh: trace_stop () {
       	fi
       }
       
      +touch_files () {
     -+	n=$1
     -+	d="$n"_files
     ++	n=$1 &&
     ++	d="$n"_files &&
      +
     -+	(cd $d ; test_seq 1 $n | xargs touch )
     ++	(cd $d && test_seq 1 $n | xargs touch )
      +}
      +
       test_expect_success "one time repo setup" '
     @@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
       	git add 1_file 10_files 100_files 1000_files 10000_files &&
       	git commit -qm "Add files" &&
       
     -@@ t/perf/p7519-fsmonitor.sh: test_expect_success "one time repo setup" '
     - 	fi
     - '
     - 
     --setup_for_fsmonitor() {
     -+setup_for_fsmonitor () {
     - 	# set INTEGRATION_SCRIPT depending on the environment
     - 	if test -n "$INTEGRATION_PATH"
     - 	then
     -@@ t/perf/p7519-fsmonitor.sh: test_perf_w_drop_caches () {
     - 	test_perf "$@"
     - }
     - 
     --test_fsmonitor_suite() {
     -+test_fsmonitor_suite () {
     - 	if test -n "$INTEGRATION_SCRIPT"; then
     - 		DESC="fsmonitor=$(basename $INTEGRATION_SCRIPT)"
     - 	else
     -@@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite() {
     +@@ t/perf/p7519-fsmonitor.sh: test_fsmonitor_suite () {
       
       	# Update the mtimes on upto 100k files to make status think
       	# that they are dirty.  For simplicity, omit any files with
 25:  d5ca2df31c8 = 26:  6eaa5765ae1 t/perf/p7519: add fsmonitor--daemon test cases
 26:  42631259e89 = 27:  30957f3930e fsmonitor--daemon: periodically truncate list of modified files
 27:  f256c3cbe8b = 28:  c8ca2a17277 fsmonitor--daemon: use a cookie file to sync with file system
 28:  08af8296f96 = 29:  4caf1d89b84 fsmonitor: force update index after large responses
 29:  e6cf84dc8eb ! 30:  f87a1eba693 t7527: test status with untracked-cache and fsmonitor--daemon
     @@ t/t7527-builtin-fsmonitor.sh: test_expect_success 'cleanup worktrees' '
      +	fsm=$2 &&
      +	fn=$3 &&
      +
     ++	if test $uc = true && test $fsm = false
     ++	then
     ++		# The untracked-cache is buggy when FSMonitor is
     ++		# DISABLED, so skip the tests for this matrix
     ++		# combination.
     ++		#
     ++		# We've observed random, occasional test failures on
     ++		# Windows and MacOS when the UC is turned on and FSM
     ++		# is turned off.  These are rare, but they do happen
     ++		# indicating that it is probably a race condition within
     ++		# the untracked cache itself.
     ++		#
     ++		# It usually happens when a test does F/D trickery and
     ++		# then the NEXT test fails because of extra status
     ++		# output from stale UC data from the previous test.
     ++		#
     ++		# Since FSMonitor is not involved in the error, skip
     ++		# the tests for this matrix combination.
     ++		#
     ++		return 0
     ++	fi &&
     ++
      +	test_expect_success "Matrix[uc:$uc][fsm:$fsm] $fn" '
      +		matrix_clean_up_repo &&
      +		$fn &&

-- 
gitgitgadget
