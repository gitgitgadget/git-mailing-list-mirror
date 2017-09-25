Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C316202A5
	for <e@80x24.org>; Mon, 25 Sep 2017 20:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964998AbdIYU0u (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Sep 2017 16:26:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:49574 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S934254AbdIYU0t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2017 16:26:49 -0400
Received: (qmail 2265 invoked by uid 109); 25 Sep 2017 20:26:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 20:26:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28447 invoked by uid 111); 25 Sep 2017 20:27:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 25 Sep 2017 16:27:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Sep 2017 16:26:47 -0400
Date:   Mon, 25 Sep 2017 16:26:47 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 0/7] read/write_in_full leftovers
Message-ID: <20170925202646.agsnpmar3dzocdcr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series addresses the bits leftover from the discussion two weeks
ago in:

  https://public-inbox.org/git/20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net/

and its subthread. I don't think any of these is a real problem in
practice, so this can be considered as a cleanup. I'm on the fence over
whether the final one is a good idea. See the commit message for
details.

  [1/7]: files-backend: prefer "0" for write_in_full() error check
  [2/7]: notes-merge: drop dead zero-write code
  [3/7]: read_in_full: reset errno before reading
  [4/7]: get-tar-commit-id: prefer "!=" for read_in_full() error check
  [5/7]: worktree: use xsize_t to access file size
  [6/7]: worktree: check the result of read_in_full()
  [7/7]: add xread_in_full() helper

 builtin/get-tar-commit-id.c |  5 +----
 builtin/worktree.c          | 11 ++++++++---
 bulk-checkin.c              |  4 +---
 cache.h                     |  7 +++++++
 combine-diff.c              |  8 +-------
 csum-file.c                 |  6 +-----
 notes-merge.c               |  2 --
 pack-write.c                |  3 +--
 refs/files-backend.c        |  2 +-
 wrapper.c                   | 12 ++++++++++++
 10 files changed, 33 insertions(+), 27 deletions(-)

-Peff
