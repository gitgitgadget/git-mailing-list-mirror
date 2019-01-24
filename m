Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD80A1F453
	for <e@80x24.org>; Thu, 24 Jan 2019 13:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfAXNLH (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 08:11:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:47172 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726105AbfAXNLH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 08:11:07 -0500
Received: (qmail 27375 invoked by uid 109); 24 Jan 2019 13:11:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 13:11:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28203 invoked by uid 111); 24 Jan 2019 13:11:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 08:11:11 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 08:11:05 -0500
Date:   Thu, 24 Jan 2019 08:11:05 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 0/9] drop some unused parameters
Message-ID: <20190124131104.GA24017@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I've mentioned before that I have a series which compiles cleanly with
-Wunused-parameters. I split this work roughly into three groups:

  1. Patches that fix bugs (i.e., we should have been using the
     parameter but didn't).

  2. Patches that drop unused parameters (i.e., code cleanup).

  3. Patches that annotate undroppable parameters (e.g., ones that are
     present due to a callback interface).

All of the patches from group 1 have been merged already. So this series
starts us off on group 2. There are about 50 patches in that group.
Given that none of them are urgent, I plan to feed them in batches to
avoid overwhelming reviewers. I'm also ordering them to avoid conflicts
with other topics in flight (this batch has no conflicts with 'next',
and only one minor textual conflict with 'pu').

The patches themselves are pretty much independent from each other. I
based these on master. They're cleanup which _could_ go to maint, and I
suspect they'd apply there, too (most of these are pretty old), but
again, I don't think there's a particular urgency to this.

  [1/8]: match-trees: drop unused path parameter from score functions
  [2/8]: apply: drop unused "def" parameter from find_name_gnu()
  [3/8]: create_bundle(): drop unused "header" parameter
  [4/8]: column: drop unused "opts" parameter in item_length()
  [5/8]: show_date_relative(): drop unused "tz" parameter
  [6/8]: config: drop unused parameter from maybe_remove_section()
  [7/8]: convert: drop len parameter from conversion checks
  [8/8]: convert: drop path parameter from actual conversion functions

 apply.c              |  5 ++---
 builtin/bundle.c     |  3 +--
 bundle.c             |  4 ++--
 bundle.h             |  4 ++--
 cache.h              |  2 +-
 column.c             |  4 ++--
 config.c             |  3 +--
 convert.c            | 28 ++++++++++++++--------------
 date.c               |  8 ++++----
 match-trees.c        | 16 +++++++---------
 t/helper/test-date.c |  2 +-
 11 files changed, 37 insertions(+), 42 deletions(-)

