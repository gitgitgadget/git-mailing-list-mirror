Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C92991F428
	for <e@80x24.org>; Sun, 29 Apr 2018 22:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754372AbeD2WRr (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 18:17:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:54709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754343AbeD2WRq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 18:17:46 -0400
Received: from localhost.localdomain ([37.201.195.116]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MXIGf-1eq4LH3uZp-00WGNN; Mon, 30 Apr 2018 00:17:39 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/6] Finish the conversion from die("BUG: ...") to BUG()
Date:   Mon, 30 Apr 2018 00:17:34 +0200
Message-Id: <cover.1525040253.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.windows.1.36.gdf4ca5fb72a
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VN7iNsbppJExkZW2r7fj5VDTkdiUdrk7r6jGuKXMQVwNjKk3yBO
 g7cU+0lPxibRL8ctcu/w3vYyTUdCV+UGrF3t12NUyiPoeFLtWiPxpxHZxYpNY1H9xrSTJ0r
 fdesBWLG5dr7Nb8tFr2GgrVx9DTx7lEQUetRC65oJCd6ULDVzw7fdLQ/fqDxcars04uEGGW
 Psm8oVg3fPVobxmppvYjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gfVTrogrkQg=:bhMBizJhFyhEZIKZOrL14x
 6Lsaxm3GwddWcEQ72Ej7VxVzl6HLehJ4qFMN98MMuvKtP/zKznuLUhcbGx0V2kCxnUOuoivWF
 yX+jItZ29bbwUvZ59INtKue4ee6IRpKPBPP7VPZIceYnIyHIHUvqJs2j8rkMcRFDSh1aioMaS
 1BRo9j+tdccW5vGnQr20Fu3FC6mra1SbSrUNBwaaqPJhasmOtf572YbC3V9F0Caug7E9vjm4M
 tRbKAC3jF3SkgbfYWU4kclNMRUOBEo0p3eFyRpMBaNN0tbtw+CzdGna5hPHsSLuhMe6ZdpuAp
 B9ryOij3pjlxml1xlveMm6wVzDrxWgV5cStNSVg+p9vWytBBBR54wlSeZdkcTZ14ecH712n3f
 4iExm9L7iqdhRVZeG/WwtpHDbaITan1T9F+8YWclkyWLYOFGTu695iCF+wvZVmp3833XkHIi0
 2fk9bxX3blAvwfXGsxw4pm5F1KTdkfWbWFyTMFKEwB7xHL3OY/UH6lt57g4eIotBX/NzL2a3j
 /wQmC+dXM6yCww5lm3C1V/Mdr8iUsjbLZeRm55fwQnBd0tYdjDoMKEntlya9lMFi27kr04JPw
 k0c9+zb72WQmejBBWg2+/zS6/UkYFSDQIntKE5NzhNL3QRXmXN5TjOOo2zBOE5GAcLsDBl+d9
 Ke7iX5uqVhpwUW3sPasyZq1uJL9ZcR+gAiKz0MHBvN4ChY2dWvYsbg95e39WDywLqEGAJtbM7
 zsTo9xnGxjC0qSVjzXFWSxA4Q2w2gR3+XSluNm2b7Hp+dlPtXrnyDx8BFq9tLgn9Iqu+ldjQ9
 gLNi3Kr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The BUG() macro was introduced in this patch series:
https://public-inbox.org/git/20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net

The second patch in that series converted one caller from die("BUG: ")
to use the BUG() macro.

It seems that there was no concrete plan to address the same issue in
the rest of the code base.

This patch series tries to do that.

Note: I separated out 4/6 ("refs/*: report bugs using the BUG() macro")
from 5/6 ("Replace all die("BUG: ...") to keep it cuddled with the patch
2/6 that prepares t1406 for this change of refs/' behavior.

Note also: I would be very surprised if the monster commit 5/6 ("Replace
all die("BUG: ...") calls by BUG() ones") would apply cleanly on `pu` (I
develop this on top of `master`).

For that reason, the commit message contains the precise Unix shell
invocation (GNU sed semantics, not BSD sed ones, because I know that the
Git maintainer as well as the author of the patch introducing BUG() both
use Linux and not macOS or any other platform that would offer a BSD
sed). It should be straight-forward to handle merge
conflicts/non-applying patches by simply re-running that command.


Johannes Schindelin (6):
  test_must_fail: support ok=sigabrt
  t1406: prepare for the refs code to fail with BUG()
  refs/*: report bugs using the BUG() macro
  run-command: use BUG() to report bugs, not die()
  Replace all die("BUG: ...") calls by BUG() ones
  Convert remaining die*(BUG) messages

 apply.c                          |  4 ++--
 archive-tar.c                    |  2 +-
 attr.c                           | 10 +++++-----
 blame.c                          |  2 +-
 builtin/am.c                     | 20 +++++++++----------
 builtin/branch.c                 |  2 +-
 builtin/cat-file.c               |  4 ++--
 builtin/clone.c                  |  2 +-
 builtin/commit.c                 |  2 +-
 builtin/config.c                 |  2 +-
 builtin/fast-export.c            |  2 +-
 builtin/fsck.c                   |  2 +-
 builtin/index-pack.c             |  4 ++--
 builtin/init-db.c                |  2 +-
 builtin/ls-files.c               |  2 +-
 builtin/notes.c                  |  8 ++++----
 builtin/pack-objects.c           |  4 ++--
 builtin/pull.c                   |  2 +-
 builtin/receive-pack.c           |  2 +-
 builtin/replace.c                |  2 +-
 builtin/update-index.c           |  2 +-
 bulk-checkin.c                   |  2 +-
 color.c                          |  4 ++--
 column.c                         |  2 +-
 config.c                         | 12 +++++------
 date.c                           |  2 +-
 diff.c                           | 12 +++++------
 dir-iterator.c                   |  2 +-
 git-compat-util.h                |  2 +-
 grep.c                           | 16 +++++++--------
 http.c                           |  8 ++++----
 imap-send.c                      |  2 +-
 lockfile.c                       |  2 +-
 mailinfo.c                       |  2 +-
 merge-recursive.c                | 12 +++++------
 notes-merge.c                    |  4 ++--
 pack-bitmap-write.c              |  2 +-
 pack-bitmap.c                    |  6 +++---
 pack-objects.c                   |  2 +-
 packfile.c                       |  6 +++---
 pathspec.c                       | 12 +++++------
 pkt-line.c                       |  2 +-
 prio-queue.c                     |  2 +-
 ref-filter.c                     |  4 ++--
 refs.c                           | 34 ++++++++++++++++----------------
 refs/files-backend.c             | 20 +++++++++----------
 refs/iterator.c                  |  6 +++---
 refs/packed-backend.c            | 16 +++++++--------
 refs/ref-cache.c                 |  2 +-
 remote.c                         |  2 +-
 revision.c                       |  4 ++--
 run-command.c                    | 33 ++++++++++++++-----------------
 setup.c                          |  4 ++--
 sha1-lookup.c                    |  2 +-
 sha1-name.c                      |  4 ++--
 shallow.c                        |  6 +++---
 sigchain.c                       |  2 +-
 strbuf.c                         |  4 ++--
 submodule.c                      |  8 ++++----
 t/helper/test-example-decorate.c | 16 +++++++--------
 t/t1406-submodule-ref-store.sh   | 15 ++++++++------
 t/test-lib-functions.sh          |  5 ++++-
 tmp-objdir.c                     |  2 +-
 trailer.c                        |  6 +++---
 transport.c                      |  4 ++--
 unpack-trees.c                   |  2 +-
 vcs-svn/fast_export.c            |  6 ++++--
 worktree.c                       |  2 +-
 wrapper.c                        |  4 ++--
 wt-status.c                      | 20 +++++++++----------
 zlib.c                           |  4 ++--
 71 files changed, 220 insertions(+), 215 deletions(-)


base-commit: 1f1cddd558b54bb0ce19c8ace353fd07b758510d
Published-As: https://github.com/dscho/git/releases/tag/use-bug-macro-v1
Fetch-It-Via: git fetch https://github.com/dscho/git use-bug-macro-v1
-- 
2.17.0.windows.1.36.gdf4ca5fb72a

