Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29861F516
	for <e@80x24.org>; Fri, 22 Jun 2018 09:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeFVJXa (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 05:23:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:51748 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751325AbeFVJX3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 05:23:29 -0400
Received: (qmail 3829 invoked by uid 109); 22 Jun 2018 09:23:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 22 Jun 2018 09:23:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16614 invoked by uid 111); 22 Jun 2018 09:23:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 22 Jun 2018 05:23:47 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jun 2018 05:23:27 -0400
Date:   Fri, 22 Jun 2018 05:23:27 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2 0/4] branch -l deprecation revisited
Message-ID: <20180622092327.GA8361@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series replaces the contents of jk/branch-l-0-deprecation,
jk/branch-l-1-removal, and jk/branch-l-2-reincarnation.

It implements the idea discussed in the subthread in:

  https://public-inbox.org/git/xmqqzi0hety4.fsf@gitster-ct.c.googlers.com/

Namely that "branch -l" would warn about deprecation only when we're not
in list mode, and then we'll eventually jump straight to repurposing
"-l" as "--list".

This gets us to the end result faster, without the annoying "-l doesn't
mean anything" step in between, and without useless warnings on "git
branch -l". It also sidesteps any pager issues since list mode will not
print the warning.

The first 3 patches would become jk/branch-l-0-deprecate, and then the
final one would become jk/branch-l-1-repurpose or similar. No third step
required.

  [1/4]: t3200: unset core.logallrefupdates when testing reflog creation
  [2/4]: t: switch "branch -l" to "branch --create-reflog"
  [3/4]: branch: deprecate "-l" option
  [4/4]: branch: make "-l" a synonym for "--list"

 Documentation/git-branch.txt |  2 +-
 builtin/branch.c             |  4 ++--
 t/t1410-reflog.sh            |  4 ++--
 t/t3200-branch.sh            | 34 +++++++++++++++++-----------------
 4 files changed, 22 insertions(+), 22 deletions(-)

-Peff
