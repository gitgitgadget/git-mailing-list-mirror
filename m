Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D6FC61DA3
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 06:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBXGeY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 01:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjBXGeX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 01:34:23 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F6E12F36
        for <git@vger.kernel.org>; Thu, 23 Feb 2023 22:34:22 -0800 (PST)
Received: (qmail 3645 invoked by uid 109); 24 Feb 2023 06:34:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Feb 2023 06:34:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31035 invoked by uid 111); 24 Feb 2023 06:34:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Feb 2023 01:34:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Feb 2023 01:34:21 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/21] more -Wunused-parameter fixes
Message-ID: <Y/habYJxDRJQg/kJ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've been sitting on this series for a while, waiting for a moment when
I didn't have a backlog of other topics I ought to be reviewing. But it
seems like that never happens, so I thought I'd just send it. :) Nothing
urgent, of course, but this takes us a few steps closer to being able to
turn on -Wunused-parameter all the time.

I've tried to float the more interesting patches to the top. The later
ones are mostly "yep, this callback needs to marked with UNUSED".

-Peff

  [01/21]: ref-filter: drop unused atom parameter from get_worktree_path()
  [02/21]: ls-refs: drop config caching
  [03/21]: serve: use repository pointer to get config
  [04/21]: serve: mark unused parameters in virtual functions
  [05/21]: object-name: mark unused parameters in disambiguate callbacks
  [06/21]: http-backend: mark argc/argv unused
  [07/21]: http-backend: mark unused parameters in virtual functions
  [08/21]: ref-filter: mark unused callback parameters
  [09/21]: mark "pointless" data pointers in callbacks
  [10/21]: run-command: mark error routine parameters as unused
  [11/21]: mark unused parameters in signal handlers
  [12/21]: list-objects: mark unused callback parameters
  [13/21]: for_each_object: mark unused callback parameters
  [14/21]: prio-queue: mark unused parameters in comparison functions
  [15/21]: notes: mark unused callback parameters
  [16/21]: fetch-pack: mark unused parameter in callback function
  [17/21]: rewrite_parents(): mark unused callback parameter
  [18/21]: for_each_commit_graft(): mark unused callback parameter
  [19/21]: userformat_want_item(): mark unused parameter
  [20/21]: run_processes_parallel: mark unused callback parameters
  [21/21]: help: mark unused parameter in git_unknown_cmd_config()

 builtin/cat-file.c          |  8 ++---
 builtin/count-objects.c     |  6 ++--
 builtin/fast-import.c       |  2 +-
 builtin/fetch.c             |  6 ++--
 builtin/fsck.c              | 25 +++++++-------
 builtin/gc.c                | 14 ++++----
 builtin/log.c               |  2 +-
 builtin/notes.c             |  5 +--
 builtin/pack-objects.c      | 26 ++++++++-------
 builtin/prune.c             |  6 ++--
 builtin/repack.c            |  5 +--
 builtin/rev-list.c          | 13 ++++----
 builtin/submodule--helper.c |  4 +--
 bundle-uri.c                |  2 +-
 commit.c                    |  6 ++--
 daemon.c                    |  2 +-
 diagnose.c                  |  3 +-
 fetch-pack.c                |  2 +-
 help.c                      |  3 +-
 hook.c                      | 12 +++----
 http-backend.c              |  8 ++---
 line-log.c                  |  3 +-
 log-tree.c                  |  3 +-
 ls-refs.c                   | 36 ++++++++------------
 midx.c                      |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     | 11 ++++---
 object-file.c               |  3 +-
 object-name.c               | 14 ++++----
 pack-bitmap.c               |  6 ++--
 packfile.c                  |  4 +--
 path.c                      |  3 +-
 pretty.c                    |  3 +-
 progress.c                  |  2 +-
 reachable.c                 | 15 +++++----
 ref-filter.c                | 66 +++++++++++++++++++++++--------------
 revision.c                  |  6 ++--
 run-command.c               |  6 ++--
 serve.c                     | 12 +++----
 submodule.c                 |  4 +--
 t/helper/test-prio-queue.c  |  2 +-
 t/helper/test-run-command.c | 14 ++++----
 upload-pack.c               | 10 +++---
 43 files changed, 211 insertions(+), 176 deletions(-)

