Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59DBC1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeGPVls (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:41:48 -0400
Received: from cloud.peff.net ([104.130.231.41]:48522 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728359AbeGPVls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:41:48 -0400
Received: (qmail 16040 invoked by uid 109); 16 Jul 2018 21:12:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:12:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15761 invoked by uid 111); 16 Jul 2018 21:12:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:12:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:12:35 -0400
Date:   Mon, 16 Jul 2018 17:12:35 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716211234.GG25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716191923.GC11513@aiede.svl.corp.google.com>
 <CABPp-BGN4NeH2QAP0WMyuOdr2GYq+hpt9584wdn2jHHinEAgDg@mail.gmail.com>
 <20180716203539.GD25189@sigill.intra.peff.net>
 <20180716205646.GF11513@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180716205646.GF11513@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 01:56:46PM -0700, Jonathan Nieder wrote:

> I don't believe we are very good at transitively propagating freshness
> today, by the way.

Perhaps I don't understand what you mean by transitive here. But we
should be traversing from any fresh object and marking any non-fresh
ones that are reachable from it to be saved. If you know of a case where
we're not, there's a bug, and I'd be happy to look into it.

The only problem I know about is the utter lack of atomicity.

-Peff
