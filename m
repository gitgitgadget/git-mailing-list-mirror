Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76390C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCYT2g convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 25 Mar 2022 15:28:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiCYT22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:28:28 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E3189A1A
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:02:07 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 22PJ26RV008420
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 25 Mar 2022 15:02:06 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Jeff Hostetler via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
Cc:     "'Bagas Sanjaya'" <bagasdotme@gmail.com>,
        "=?UTF-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>, "'Jeff Hostetler'" <git@jeffhostetler.com>,
        "'Eric Sunshine'" <sunshine@sunshineco.com>,
        "'Johannes Schindelin'" <Johannes.Schindelin@gmx.de>,
        "'Tao Klerks'" <tao@klerks.biz>,
        "'Jeff Hostetler'" <jeffhost@microsoft.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com> <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
Subject: RE: [PATCH v9 00/30] Builtin FSMonitor Part 2
Date:   Fri, 25 Mar 2022 15:02:01 -0400
Organization: Nexbridge Inc.
Message-ID: <001701d8407a$d2a29dd0$77e7d970$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHHL5OMMySUzlHIlO7O33CvKM2rTwGYe3BmrOXSMXA=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On March 25, 2022 2:03 PM, Jeff Hostetler wrote:
>Here is V9 of Part 2 of my builtin FSMonitor series. This version addresses bash
>style issues in t7527 raised on V8. These changes do not require a new version of
>Part 3.
>
>Here is a range-diff from V8 to V9 relative to 715d08a9e5 (The eighth batch, 2022-
>02-25).
>
> 1:  e98373f997 =  1:  e98373f997 fsmonitor: enhance existing comments, clarify
>trivial response handling
> 2:  ab68b94417 =  2:  ab68b94417 fsmonitor-ipc: create client routines for git-
>fsmonitor--daemon
> 3:  e04c7301f2 =  3:  e04c7301f2 fsmonitor: config settings are repository-specific
> 4:  ea02ba25d8 =  4:  ea02ba25d8 fsmonitor: use IPC to query the builtin FSMonitor
>daemon
> 5:  6ab7db9cb7 =  5:  6ab7db9cb7 fsmonitor: document builtin fsmonitor
> 6:  0ce8ae3f2c =  6:  0ce8ae3f2c fsmonitor--daemon: add a built-in fsmonitor
>daemon
> 7:  4624ce2fa4 =  7:  4624ce2fa4 fsmonitor--daemon: implement 'stop' and 'status'
>commands
> 8:  a29fe7266a =  8:  a29fe7266a compat/fsmonitor/fsm-listen-win32: stub in
>backend for Windows
> 9:  2f8a42fdb9 =  9:  2f8a42fdb9 compat/fsmonitor/fsm-listen-darwin: stub in
>backend for Darwin
>10:  f07800690e = 10:  f07800690e fsmonitor--daemon: implement 'run' command
>11:  a6a39a3306 = 11:  a6a39a3306 fsmonitor--daemon: implement 'start' command
>12:  d62e338d00 = 12:  d62e338d00 fsmonitor--daemon: add pathname
>classification
>13:  53e06b4ae5 = 13:  53e06b4ae5 fsmonitor--daemon: define token-ids
>14:  39f43fabe0 = 14:  39f43fabe0 fsmonitor--daemon: create token-based
>changed path cache
>15:  239558e34f = 15:  239558e34f compat/fsmonitor/fsm-listen-win32: implement
>FSMonitor backend on Windows
>16:  14b775e9d8 = 16:  14b775e9d8 compat/fsmonitor/fsm-listen-darwin: add
>MacOS header files for FSEvent
>17:  55bd7aee06 = 17:  55bd7aee06 compat/fsmonitor/fsm-listen-darwin:
>implement FSEvent listener on MacOS
>18:  c43009124f = 18:  c43009124f fsmonitor--daemon: implement handle_client
>callback
>19:  ed338777b5 = 19:  ed338777b5 help: include fsmonitor--daemon feature flag in
>version info
>20:  c99bac29d4 = 20:  c99bac29d4 t/helper/fsmonitor-client: create IPC client to
>talk to FSMonitor Daemon
>21:  c8709da945 ! 21:  bc94e379b0 t7527: create test for fsmonitor--daemon
>    @@ Commit message
>         t7527: create test for fsmonitor--daemon
>
>         Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>      ## t/t7527-builtin-fsmonitor.sh (new) ##
>     @@
>    @@ t/t7527-builtin-fsmonitor.sh (new)
>     +    rm -rf $1
>     +}
>     +
>    -+is_value () {
>    -+    test -n "$1" && test "${1::1}" != "-"
>    -+}
>    -+
>     +start_daemon () {
>    -+    r= &&
>    -+    tf= &&
>    -+    t2= &&
>    -+    tk= &&
>    ++    r= tf= t2= tk= &&
>     +
>     +    while test "$#" -ne 0
>     +    do
>     +        case "$1" in
>     +        -C)
>    -+            shift;
>    -+            is_value $1 || BUG "error: -C requires value"
>    -+            r="-C $1"
>    ++            r="-C ${2?}"
>     +            shift
>     +            ;;
>     +        --tf)
>    -+            shift;
>    -+            is_value $1 || BUG "error: --tf requires value"
>    -+            tf="$1"
>    ++            tf="${2?}"
>     +            shift
>     +            ;;
>     +        --t2)
>    -+            shift;
>    -+            is_value $1 || BUG "error: --t2 requires value"
>    -+            t2="$1"
>    ++            t2="${2?}"
>     +            shift
>     +            ;;
>     +        --tk)
>    -+            shift;
>    -+            is_value $1 || BUG "error: --tk requires value"
>    -+            tk="$1"
>    ++            tk="${2?}"
>     +            shift
>     +            ;;
>    -+        *)
>    ++        -*)
>     +            BUG "error: unknown option: '$1'"
>     +            ;;
>    ++        *)
>    ++            BUG "error: unbound argument: '$1'"
>    ++            ;;
>     +        esac
>    ++        shift
>     +    done &&
>     +
>     +    (
>22:  cc39ecf10a = 22:  06d56d3a73 t/perf: avoid copying builtin fsmonitor files into
>test repo
>23:  2bb3eb8476 = 23:  2dd0215127 t/helper/test-chmtime: skip directories on
>Windows
>24:  bab9a9b080 = 24:  bb88cddc13 t/perf/p7519: fix coding style
>25:  2dd06ad2f7 = 25:  50c2afaa49 t/perf/p7519: speed up test on Windows
>26:  6eaa5765ae = 26:  5b18e3b692 t/perf/p7519: add fsmonitor--daemon test
>cases
>27:  30957f3930 = 27:  899c23f63c fsmonitor--daemon: periodically truncate list of
>modified files
>28:  c8ca2a1727 = 28:  597a7192f9 fsmonitor--daemon: use a cookie file to sync with
>file system
>29:  4caf1d89b8 = 29:  68a05fd289 fsmonitor: force update index after large
>responses
>30:  f87a1eba69 = 30:  5eb696daba t7527: test status with untracked-cache and
>fsmonitor--daemon
>
>
>Jeff Hostetler (30):
>  fsmonitor: enhance existing comments, clarify trivial response
>    handling
>  fsmonitor-ipc: create client routines for git-fsmonitor--daemon
>  fsmonitor: config settings are repository-specific
>  fsmonitor: use IPC to query the builtin FSMonitor daemon
>  fsmonitor: document builtin fsmonitor
>  fsmonitor--daemon: add a built-in fsmonitor daemon
>  fsmonitor--daemon: implement 'stop' and 'status' commands
>  compat/fsmonitor/fsm-listen-win32: stub in backend for Windows
>  compat/fsmonitor/fsm-listen-darwin: stub in backend for Darwin
>  fsmonitor--daemon: implement 'run' command
>  fsmonitor--daemon: implement 'start' command
>  fsmonitor--daemon: add pathname classification
>  fsmonitor--daemon: define token-ids
>  fsmonitor--daemon: create token-based changed path cache
>  compat/fsmonitor/fsm-listen-win32: implement FSMonitor backend on
>    Windows
>  compat/fsmonitor/fsm-listen-darwin: add MacOS header files for FSEvent
>  compat/fsmonitor/fsm-listen-darwin: implement FSEvent listener on
>    MacOS
>  fsmonitor--daemon: implement handle_client callback
>  help: include fsmonitor--daemon feature flag in version info
>  t/helper/fsmonitor-client: create IPC client to talk to FSMonitor
>    Daemon
>  t7527: create test for fsmonitor--daemon
>  t/perf: avoid copying builtin fsmonitor files into test repo
>  t/helper/test-chmtime: skip directories on Windows
>  t/perf/p7519: fix coding style
>  t/perf/p7519: speed up test on Windows
>  t/perf/p7519: add fsmonitor--daemon test cases
>  fsmonitor--daemon: periodically truncate list of modified files
>  fsmonitor--daemon: use a cookie file to sync with file system
>  fsmonitor: force update index after large responses
>  t7527: test status with untracked-cache and fsmonitor--daemon
>
> .gitignore                              |    1 +
> Documentation/config/core.txt           |   60 +-
> Documentation/git-fsmonitor--daemon.txt |   75 ++
> Documentation/git-update-index.txt      |    8 +-
> Makefile                                |   17 +
> builtin.h                               |    1 +
> builtin/fsmonitor--daemon.c             | 1479 +++++++++++++++++++++++
> builtin/update-index.c                  |    7 +-
> cache.h                                 |    1 -
> compat/fsmonitor/fsm-darwin-gcc.h       |   92 ++
> compat/fsmonitor/fsm-listen-darwin.c    |  427 +++++++
> compat/fsmonitor/fsm-listen-win32.c     |  586 +++++++++
> compat/fsmonitor/fsm-listen.h           |   49 +
> config.c                                |   14 -
> config.h                                |    1 -
> config.mak.uname                        |   20 +
> contrib/buildsystems/CMakeLists.txt     |   10 +
> environment.c                           |    1 -
> fsmonitor--daemon.h                     |  166 +++
> fsmonitor-ipc.c                         |  171 +++
> fsmonitor-ipc.h                         |   48 +
> fsmonitor-settings.c                    |  114 ++
> fsmonitor-settings.h                    |   21 +
> fsmonitor.c                             |  216 +++-
> fsmonitor.h                             |   15 +-
> git.c                                   |    1 +
> help.c                                  |    4 +
> repo-settings.c                         |    1 +
> repository.h                            |    3 +
> t/README                                |    4 +-
> t/helper/test-chmtime.c                 |   15 +
> t/helper/test-fsmonitor-client.c        |  116 ++
> t/helper/test-tool.c                    |    1 +
> t/helper/test-tool.h                    |    1 +
> t/perf/p7519-fsmonitor.sh               |   68 +-
> t/perf/perf-lib.sh                      |    2 +-
> t/t7527-builtin-fsmonitor.sh            |  609 ++++++++++
> t/test-lib.sh                           |    7 +
> 38 files changed, 4326 insertions(+), 106 deletions(-)  create mode 100644
>Documentation/git-fsmonitor--daemon.txt
> create mode 100644 builtin/fsmonitor--daemon.c  create mode 100644
>compat/fsmonitor/fsm-darwin-gcc.h  create mode 100644 compat/fsmonitor/fsm-
>listen-darwin.c
> create mode 100644 compat/fsmonitor/fsm-listen-win32.c
> create mode 100644 compat/fsmonitor/fsm-listen.h  create mode 100644
>fsmonitor--daemon.h  create mode 100644 fsmonitor-ipc.c  create mode 100644
>fsmonitor-ipc.h  create mode 100644 fsmonitor-settings.c  create mode 100644
>fsmonitor-settings.h  create mode 100644 t/helper/test-fsmonitor-client.c  create
>mode 100755 t/t7527-builtin-fsmonitor.sh
>
>
>base-commit: 715d08a9e51251ad8290b181b6ac3b9e1f9719d7
>Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-
>1041%2Fjeffhostetler%2Fbuiltin-fsmonitor-part2-v9
>Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-
>1041/jeffhostetler/builtin-fsmonitor-part2-v9
>Pull-Request: https://github.com/gitgitgadget/git/pull/1041
>
>Range-diff vs v8:
>
>  1:  e98373f997f =  1:  e98373f997f fsmonitor: enhance existing comments, clarify
>trivial response handling
>  2:  ab68b944173 =  2:  ab68b944173 fsmonitor-ipc: create client routines for git-
>fsmonitor--daemon
>  3:  e04c7301f24 =  3:  e04c7301f24 fsmonitor: config settings are repository-
>specific
>  4:  ea02ba25d8f =  4:  ea02ba25d8f fsmonitor: use IPC to query the builtin
>FSMonitor daemon
>  5:  6ab7db9cb76 =  5:  6ab7db9cb76 fsmonitor: document builtin fsmonitor
>  6:  0ce8ae3f2cf =  6:  0ce8ae3f2cf fsmonitor--daemon: add a built-in fsmonitor
>daemon
>  7:  4624ce2fa47 =  7:  4624ce2fa47 fsmonitor--daemon: implement 'stop' and
>'status' commands
>  8:  a29fe7266a4 =  8:  a29fe7266a4 compat/fsmonitor/fsm-listen-win32: stub in
>backend for Windows
>  9:  2f8a42fdb93 =  9:  2f8a42fdb93 compat/fsmonitor/fsm-listen-darwin: stub in
>backend for Darwin
> 10:  f07800690ee = 10:  f07800690ee fsmonitor--daemon: implement 'run'
>command
> 11:  a6a39a3306d = 11:  a6a39a3306d fsmonitor--daemon: implement 'start'
>command
> 12:  d62e338d008 = 12:  d62e338d008 fsmonitor--daemon: add pathname
>classification
> 13:  53e06b4ae5d = 13:  53e06b4ae5d fsmonitor--daemon: define token-ids
> 14:  39f43fabe02 = 14:  39f43fabe02 fsmonitor--daemon: create token-based
>changed path cache
> 15:  239558e34ff = 15:  239558e34ff compat/fsmonitor/fsm-listen-win32:
>implement FSMonitor backend on Windows
> 16:  14b775e9d8b = 16:  14b775e9d8b compat/fsmonitor/fsm-listen-darwin: add
>MacOS header files for FSEvent
> 17:  55bd7aee06c = 17:  55bd7aee06c compat/fsmonitor/fsm-listen-darwin:
>implement FSEvent listener on MacOS
> 18:  c43009124fb = 18:  c43009124fb fsmonitor--daemon: implement handle_client
>callback
> 19:  ed338777b56 = 19:  ed338777b56 help: include fsmonitor--daemon feature
>flag in version info
> 20:  c99bac29d42 = 20:  c99bac29d42 t/helper/fsmonitor-client: create IPC client to
>talk to FSMonitor Daemon
> 21:  c8709da9457 ! 21:  bc94e379b03 t7527: create test for fsmonitor--daemon
>     @@ Commit message
>          t7527: create test for fsmonitor--daemon
>
>          Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
>     -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
>       ## t/t7527-builtin-fsmonitor.sh (new) ##
>      @@
>     @@ t/t7527-builtin-fsmonitor.sh (new)
>      +	rm -rf $1
>      +}
>      +
>     -+is_value () {
>     -+	test -n "$1" && test "${1::1}" != "-"
>     -+}
>     -+
>      +start_daemon () {
>     -+	r= &&
>     -+	tf= &&
>     -+	t2= &&
>     -+	tk= &&
>     ++	r= tf= t2= tk= &&
>      +
>      +	while test "$#" -ne 0
>      +	do
>      +		case "$1" in
>      +		-C)
>     -+			shift;
>     -+			is_value $1 || BUG "error: -C requires value"
>     -+			r="-C $1"
>     ++			r="-C ${2?}"
>      +			shift
>      +			;;
>      +		--tf)
>     -+			shift;
>     -+			is_value $1 || BUG "error: --tf requires value"
>     -+			tf="$1"
>     ++			tf="${2?}"
>      +			shift
>      +			;;
>      +		--t2)
>     -+			shift;
>     -+			is_value $1 || BUG "error: --t2 requires value"
>     -+			t2="$1"
>     ++			t2="${2?}"
>      +			shift
>      +			;;
>      +		--tk)
>     -+			shift;
>     -+			is_value $1 || BUG "error: --tk requires value"
>     -+			tk="$1"
>     ++			tk="${2?}"
>      +			shift
>      +			;;
>     -+		*)
>     ++		-*)
>      +			BUG "error: unknown option: '$1'"
>      +			;;
>     ++		*)
>     ++			BUG "error: unbound argument: '$1'"
>     ++			;;
>      +		esac
>     ++		shift
>      +	done &&
>      +
>      +	(
> 22:  cc39ecf10ae = 22:  06d56d3a733 t/perf: avoid copying builtin fsmonitor files
>into test repo
> 23:  2bb3eb84767 = 23:  2dd02151278 t/helper/test-chmtime: skip directories on
>Windows
> 24:  bab9a9b0802 = 24:  bb88cddc137 t/perf/p7519: fix coding style
> 25:  2dd06ad2f71 = 25:  50c2afaa49e t/perf/p7519: speed up test on Windows
> 26:  6eaa5765ae1 = 26:  5b18e3b6926 t/perf/p7519: add fsmonitor--daemon test
>cases
> 27:  30957f3930e = 27:  899c23f63c3 fsmonitor--daemon: periodically truncate list
>of modified files
> 28:  c8ca2a17277 = 28:  597a7192f94 fsmonitor--daemon: use a cookie file to sync
>with file system
> 29:  4caf1d89b84 = 29:  68a05fd2892 fsmonitor: force update index after large
>responses
> 30:  f87a1eba693 = 30:  5eb696daba2 t7527: test status with untracked-cache and
>fsmonitor--daemon

So that we can plan for next time, would you mind giving some thought to what would be required for Linux and whether it makes sense to extend this. No urgency, but I would not mind participating - assuming my $DAYJOB lets me. I have a backlog for git that I need to get done first anyway.

Kind Regards,
Randall

