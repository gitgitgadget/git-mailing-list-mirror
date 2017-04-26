Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3021A207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966177AbdDZTVr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:21:47 -0400
Received: from mout.gmx.net ([212.227.17.22]:52862 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966069AbdDZTVp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:21:45 -0400
Received: from virtualbox ([95.208.59.152]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MZwYd-1dP7ia0jAl-00LovK; Wed, 26
 Apr 2017 21:21:35 +0200
Date:   Wed, 26 Apr 2017 21:20:43 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v6 0/8] Introduce timestamp_t for timestamps
In-Reply-To: <cover.1493042239.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1493234408.git.johannes.schindelin@gmx.de>
References: <cover.1493042239.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:jpHnlCN+HJeyENdMwcQZBSgvxVG8GaJbBpPZTD4qyrwwrATVKPs
 eKxRl2OSz9Z3OzCSQIg/yyR1XE/TVO7PNF94JQd5pDJFF1Z2VWpkKOSFjXBOJPRN1M/PMNv
 xT4hYgx/UrhdTCfN2TkpwMvZ/xM5rOYsaFK/G6HBotw93gJ0DoBDnE94qXEGSUZ8boWXgAi
 SPmFnkBSGOsfvt+C6gEYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eV3m58sedBc=:zk4bQ9kzcvHakMfYT+trf2
 hUaBG563/PvcSJQCq1zdPjALRANBazinaX9OeROfFSo4dEs+tVYrv6h8GX2aen21bcy9zdYha
 kNLrCO/ALyrwfNKwIaQtIDW0s3nUkSy00H7/sy2nCmd+L7PkLXrV+SWEbKZN9AmNBCry8LkVu
 I1q382XC1eNhQH13Bz6MRixp2z8CF9YS0UZTxRzzTvwCL0Y/yVXwOxm23/ksX8Q+UfyD8aD2d
 hswt79cAJMr7KtCvy7qFeXbcVw2YLHxdicKQxIgw5XsBK3GC6cd/5A+ovEehFniUuhlz1q+HX
 tDNGLSYOOEn/mpDriYzsLTum8fXAur70g+n1wu4c7MX/FzFRAG4HO5F2Ri5SUbdZ4UoByoW+Q
 WL/JqJ4iVe6/s9eRL6kPbzROAmTEE5AgXpjkA3MdafCD6X4t7I5IeuyKd159dFeADNLJeZ/kE
 kGqQZm5N7CQ5VtUv+RYvWZc4tAowu7H7gZJvDidrio4O/cFMFwxq5EN50p6PyAp71rSoj2CzD
 v5WrwFCf+3v5A+5qW6mJWLn3ykIIWsJK0pPtAfjMQIztVWx2nCuI5U+GIGsEhxlBh89XeWxvx
 6SsTm6BxDaYfoYwzcMu3wggLrAkROOUols32WS9HfsHyI7rtJHA13Fm44nb5Cm74Iv1SGN9wD
 avdQdnjm+dW+BKmWgfrQ9RB4uc1ER8J2tVxmrjRXvCa506DoR5lmj9/XBOw0klckXs7nv3toD
 G/ltpGBapWf2Ukz77fVmulJIRsG0oDbRn0E3jyhUJUHbHIOwWRpSSQ6XbXw5ccbzOWVseoT9X
 TeD3flF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git v2.9.2 was released in a hurry to accomodate for platforms like
Windows, where the `unsigned long` data type is 32-bit even for 64-bit
setups.

The quick fix was to simply disable all the testing with "absurd" future
dates.

However, we can do much better than that, as we already make use of
64-bit data types internally. There is no good reason why we should not
use the same for timestamps. Hence, let's use uintmax_t for timestamps.

Note: while the `time_t` data type exists and is meant to be used for
timestamps, on 32-bit Linux it is *still* 32-bit. An earlier iteration
used `time_t` for that reason, but it came with a few serious downsides:
as `time_t` can be signed (and indeed, on Windows it is an int64_t),
Git's expectation that 0 is the minimal value would no longer hold true,
introducing its own set of interesting challenges. Besides, if we *can*
handle far in the future timestamps (except for formatting them using
the system libraries), it is more consistent to do so.

The upside of using `uintmax_t` for timestamps is that we do a much
better job to support far in the future timestamps across all platforms,
including 32-bit ones. The downside is that those platforms that use a
32-bit `time_t` will barf when parsing or formatting those timestamps.

Hannes Sixt found two more improvements which I incorporated into this
iteration.

Changes since v5:

- use UINTMAX_MAX as TIME_MAX instead of rolling funny ULLONG_MAX games
  (thanks Hannes Sixt)

- mark the large constant in archive-tar.c as unsigned long long, as we
  cannot know that unsigned long is large enough (again, thanks Hannes
  Sixt)


Johannes Schindelin (8):
  ref-filter: avoid using `unsigned long` for catch-all data type
  t0006 & t5000: prepare for 64-bit timestamps
  t0006 & t5000: skip "far in the future" test when time_t is too
    limited
  Specify explicitly where we parse timestamps
  Introduce a new "printf format" for timestamps
  Introduce a new data type for timestamps
  Abort if the system time cannot handle one of our timestamps
  Use uintmax_t for timestamps

 Documentation/technical/api-parse-options.txt |   8 +-
 archive-tar.c                                 |   7 +-
 archive-zip.c                                 |  12 ++-
 archive.h                                     |   2 +-
 builtin/am.c                                  |   4 +-
 builtin/blame.c                               |  14 ++--
 builtin/fsck.c                                |   6 +-
 builtin/gc.c                                  |   2 +-
 builtin/log.c                                 |   4 +-
 builtin/merge-base.c                          |   2 +-
 builtin/name-rev.c                            |   6 +-
 builtin/pack-objects.c                        |   4 +-
 builtin/prune.c                               |   4 +-
 builtin/receive-pack.c                        |  14 ++--
 builtin/reflog.c                              |  24 +++---
 builtin/rev-list.c                            |   2 +-
 builtin/rev-parse.c                           |   2 +-
 builtin/show-branch.c                         |   4 +-
 builtin/worktree.c                            |   4 +-
 bundle.c                                      |   4 +-
 cache.h                                       |  14 ++--
 commit.c                                      |  18 ++--
 commit.h                                      |   2 +-
 config.c                                      |   2 +-
 credential-cache--daemon.c                    |  12 +--
 date.c                                        | 113 ++++++++++++++------------
 fetch-pack.c                                  |   8 +-
 fsck.c                                        |   2 +-
 git-compat-util.h                             |   5 ++
 http-backend.c                                |   4 +-
 parse-options-cb.c                            |   4 +-
 pretty.c                                      |   4 +-
 reachable.c                                   |   9 +-
 reachable.h                                   |   4 +-
 ref-filter.c                                  |  22 ++---
 reflog-walk.c                                 |   8 +-
 refs.c                                        |  14 ++--
 refs.h                                        |   8 +-
 refs/files-backend.c                          |   8 +-
 revision.c                                    |   6 +-
 revision.h                                    |   4 +-
 sha1_name.c                                   |   6 +-
 t/helper/test-date.c                          |  18 ++--
 t/helper/test-parse-options.c                 |   4 +-
 t/helper/test-ref-store.c                     |   4 +-
 t/t0006-date.sh                               |   4 +-
 t/t5000-tar-tree.sh                           |   6 +-
 t/test-lib.sh                                 |   3 +
 tag.c                                         |   6 +-
 tag.h                                         |   2 +-
 upload-pack.c                                 |   8 +-
 vcs-svn/fast_export.c                         |   8 +-
 vcs-svn/fast_export.h                         |   4 +-
 vcs-svn/svndump.c                             |   2 +-
 wt-status.c                                   |   2 +-
 55 files changed, 257 insertions(+), 220 deletions(-)


base-commit: e2cb6ab84c94f147f1259260961513b40c36108a
Published-As: https://github.com/dscho/git/releases/tag/time_t-may-be-int64-v6
Fetch-It-Via: git fetch https://github.com/dscho/git time_t-may-be-int64-v6

Interdiff vs v5:

 diff --git a/archive-tar.c b/archive-tar.c
 index 695339a2369..319a5b1c7cd 100644
 --- a/archive-tar.c
 +++ b/archive-tar.c
 @@ -28,7 +28,7 @@ static int write_tar_filter_archive(const struct archiver *ar,
  #if ULONG_MAX == 0xFFFFFFFF
  #define USTAR_MAX_SIZE ULONG_MAX
  #else
 -#define USTAR_MAX_SIZE 077777777777UL
 +#define USTAR_MAX_SIZE 077777777777ULL
  #endif
  #if TIME_MAX == 0xFFFFFFFF
  #define USTAR_MAX_MTIME TIME_MAX
 diff --git a/git-compat-util.h b/git-compat-util.h
 index b66995685af..f366180f4b9 100644
 --- a/git-compat-util.h
 +++ b/git-compat-util.h
 @@ -322,11 +322,7 @@ extern char *gitdirname(char *);
  typedef uintmax_t timestamp_t;
  #define PRItime PRIuMAX
  #define parse_timestamp strtoumax
 -#ifdef ULLONG_MAX
 -#define TIME_MAX ULLONG_MAX
 -#else
 -#define TIME_MAX ULONG_MAX
 -#endif
 +#define TIME_MAX UINTMAX_MAX
  
  #ifndef PATH_SEP
  #define PATH_SEP ':'

-- 
2.12.2.windows.2.406.gd14a8f8640f

