Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DC0C77B61
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 05:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjDYFws (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 01:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDYFwr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 01:52:47 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E48D7
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 22:52:46 -0700 (PDT)
Received: (qmail 21746 invoked by uid 109); 25 Apr 2023 05:52:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Apr 2023 05:52:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 848 invoked by uid 111); 25 Apr 2023 05:52:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Apr 2023 01:52:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 25 Apr 2023 01:52:44 -0400
From:   Jeff King <peff@peff.net>
To:     Thomas Bock <bockthom@cs.uni-saarland.de>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH v2 0/3] fixing some parse_commit() timestamp corner cases
Message-ID: <20230425055244.GA4014505@coredump.intra.peff.net>
References: <7728e059-d58d-cce7-c011-fbc16eb22fb9@cs.uni-saarland.de>
 <20230415085207.GA656008@coredump.intra.peff.net>
 <xmqqa5z6q1jl.fsf@gitster.g>
 <20230418041253.GD60552@coredump.intra.peff.net>
 <7bbcfbc0-f9da-09ef-9441-5e4b13780841@github.com>
 <1153e31d-2f89-c9dc-8551-adf4d3822487@cs.uni-saarland.de>
 <20230422134150.GA3516940@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230422134150.GA3516940@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a v2 of my series. The behavior should be identical, but I've
incorporated some comment and small code tweaks based on feedback from
the first round.

I also added a fourth patch which adds a new comment explaining some of
the cases that were alluded to in the earlier round's patch 3.

  [1/4]: t4212: avoid putting git on left-hand side of pipe
  [2/4]: parse_commit(): parse timestamp from end of line
  [3/4]: parse_commit(): handle broken whitespace-only timestamp
  [4/4]: parse_commit(): describe more date-parsing failure modes

 commit.c               | 47 +++++++++++++++++++++++++++++++++++-------
 t/t4212-log-corrupt.sh | 39 +++++++++++++++++++++++++++++++++--
 2 files changed, 76 insertions(+), 10 deletions(-)

-Peff
