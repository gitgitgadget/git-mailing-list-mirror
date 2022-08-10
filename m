Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B008C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 21:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiHJU7i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 16:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiHJU7g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 16:59:36 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C59A79EDE
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 13:59:35 -0700 (PDT)
Received: (qmail 6829 invoked by uid 109); 10 Aug 2022 20:59:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 10 Aug 2022 20:59:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15510 invoked by uid 111); 10 Aug 2022 20:59:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 10 Aug 2022 16:59:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 10 Aug 2022 16:59:34 -0400
From:   Jeff King <peff@peff.net>
To:     Xavier Morel <xavier.morel@masklinn.net>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/3] actually detect bad file modes in fsck
Message-ID: <YvQcNpizy9uOZiAz@coredump.intra.peff.net>
References: <B3488A12-BCE3-48C8-915C-E2AC4E71ECD2@masklinn.net>
 <YvLkU3X9lBsG8wXp@coredump.intra.peff.net>
 <YvLttyyaZWm4pitu@coredump.intra.peff.net>
 <6688857F-B899-4253-933B-0DFE25155D13@masklinn.net>
 <YvQPQUuC+IxO0uo4@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvQPQUuC+IxO0uo4@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 10, 2022 at 04:04:17PM -0400, Jeff King wrote:

> > Maybe downgrade to info or ignore by default then? It might still be
> > an issue for people who wilfully upgraded the diagnostic to error
> > hoping to catch the, but hopefully if they did that they'd rather get
> > the notice later than never?
> 
> Yeah, that may be a sensible resolution. All things being equal I think
> "warning" is the right level, but out of caution and the historical
> precedent, maybe downgrading it to "info" is justified.
> 
> It should be easy to work that into the patch I showed earlier.

OK, so here are cleaned-up patches to do that.

  [1/3]: tree-walk: add a mechanism for getting non-canonicalized modes
  [2/3]: fsck: actually detect bad file modes in trees
  [3/3]: fsck: downgrade tree badFilemode to "info"

 fsck.c                          |  4 ++--
 fsck.h                          |  2 +-
 packfile.c                      |  2 +-
 t/t1450-fsck.sh                 | 14 ++++++++++++++
 t/t5504-fetch-receive-strict.sh | 17 +++++++++++++++++
 tree-walk.c                     | 14 +++++++++-----
 tree-walk.h                     |  8 +++++++-
 7 files changed, 51 insertions(+), 10 deletions(-)

-Peff
