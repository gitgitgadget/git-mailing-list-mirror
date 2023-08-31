Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 333D5C83F2B
	for <git@archiver.kernel.org>; Thu, 31 Aug 2023 07:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbjHaHJl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Aug 2023 03:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjHaHJj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Aug 2023 03:09:39 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E08B1A6
        for <git@vger.kernel.org>; Thu, 31 Aug 2023 00:09:36 -0700 (PDT)
Received: (qmail 21332 invoked by uid 109); 31 Aug 2023 07:09:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Aug 2023 07:09:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3401 invoked by uid 111); 31 Aug 2023 07:09:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Aug 2023 03:09:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 31 Aug 2023 03:09:35 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 0/8] more unused parameters in parseopt callbacks
Message-ID: <20230831070935.GA3197495@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are some more patches silencing -Wunused-parameter warnings. I've
prepared them on top of the patches queued in jk/unused-post-2.42, but
they should apply equally well directly on 'master'.

These ones are a bit more interesting than usual, because there were
some actual code changes and cleanups that seemed preferable to just
annotating.

I'm adding René to the cc based on our earlier discussion of callbacks
which ignore opt->value. See patch 3 in particular. Also some of your
recent work gets a nice shout-out in patch 2. :)

  [1/8]: merge: make xopts a strvec
  [2/8]: merge: simplify parsing of "-n" option
  [3/8]: parse-options: prefer opt->value to globals in callbacks
  [4/8]: parse-options: mark unused "opt" parameter in callbacks
  [5/8]: merge: do not pass unused opt->value parameter
  [6/8]: parse-options: add more BUG_ON() annotations
  [7/8]: interpret-trailers: mark unused "unset" parameters in option callbacks
  [8/8]: parse-options: mark unused parameters in noop callback

 builtin/add.c                |  2 ++
 builtin/checkout-index.c     |  2 +-
 builtin/describe.c           |  6 +++--
 builtin/fast-export.c        | 36 +++++++++++++++++-------------
 builtin/fetch.c              |  3 ++-
 builtin/gc.c                 |  2 +-
 builtin/interpret-trailers.c | 18 +++++++--------
 builtin/log.c                | 18 ++++++++++-----
 builtin/merge.c              | 43 +++++++++---------------------------
 builtin/pack-objects.c       | 27 ++++++++++++----------
 builtin/read-tree.c          |  2 +-
 builtin/update-index.c       |  4 ++--
 parse-options-cb.c           |  4 +++-
 13 files changed, 84 insertions(+), 83 deletions(-)

