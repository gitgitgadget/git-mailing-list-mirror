Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB97DC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbjEHS77 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 14:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbjEHS74 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 14:59:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620A6618A
        for <git@vger.kernel.org>; Mon,  8 May 2023 11:59:54 -0700 (PDT)
Received: (qmail 13858 invoked by uid 109); 8 May 2023 18:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 May 2023 18:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3584 invoked by uid 111); 8 May 2023 18:59:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 May 2023 14:59:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 8 May 2023 14:59:53 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/3] dropping "verbose" test helper function
Message-ID: <20230508185953.GA2108869@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I happened across an instance of the "verbose" helper function in a
test recently. I think it's clear we prefer the "-x" tracing to it these
days, and we've been slowly removing instances. This series gets rid of
the last few.

The actual change (and rationale) is in patch 3. Patch 1 just fixes pipe
problems on lines we'll be touching patch 3, and patch 2 is a cute
optimization enabled by patch 1. I don't think any of it should be very
controversial, but it can all be split up if need be.

  [1/3]: t7001: avoid git on upstream of pipe
  [2/3]: t7001: use "ls-files --format" instead of "cut"
  [3/3]: t: drop "verbose" helper function

 t/t0020-crlf.sh            | 38 +++++++++++++++++++-------------------
 t/t1301-shared-repo.sh     |  4 ++--
 t/t3427-rebase-subtree.sh  | 12 ++++++------
 t/t4022-diff-rewrite.sh    |  2 +-
 t/t4062-diff-pickaxe.sh    |  2 +-
 t/t5304-prune.sh           | 16 ++++++++--------
 t/t6006-rev-list-format.sh |  2 +-
 t/t6501-freshen-objects.sh |  2 +-
 t/t7001-mv.sh              | 37 +++++++++++++++++++++----------------
 t/t7300-clean.sh           |  4 ++--
 t/t9902-completion.sh      | 30 +++++++++++++++---------------
 t/test-lib-functions.sh    |  9 ---------
 12 files changed, 77 insertions(+), 81 deletions(-)

-Peff
