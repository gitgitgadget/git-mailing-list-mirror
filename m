Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 998581F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:22:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932221AbeFZUWr (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:22:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:55954 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754751AbeFZUWr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:22:47 -0400
Received: (qmail 3682 invoked by uid 109); 26 Jun 2018 20:22:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 26 Jun 2018 20:22:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1312 invoked by uid 111); 26 Jun 2018 20:23:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 26 Jun 2018 16:23:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Jun 2018 16:22:45 -0400
Date:   Tue, 26 Jun 2018 16:22:45 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 29/29] t/test-lib: teach --chain-lint to detect broken
 &&-chains in subshells
Message-ID: <20180626202244.GB2341@sigill.intra.peff.net>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
 <20180626073001.6555-30-sunshine@sunshineco.com>
 <xmqqwouljr5e.fsf@gitster-ct.c.googlers.com>
 <CAPig+cSLyie8mr+u8Thv9cJ0J12nCA+RU6Mg3S5F8U68q1+nzQ@mail.gmail.com>
 <20180626201708.GA2341@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180626201708.GA2341@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 26, 2018 at 04:17:08PM -0400, Jeff King wrote:

> I'm not sure if there's a good solution, though. Even if you retained
> the subshells and instead did a chain-lint inside each subshell, like
> this:

So obviously that means "I don't think there's a good solution with this
approach".

That whole final patch simultaneously impresses and nauseates me. Your
commit message says "no attempt is made at properly parsing shell code",
but we come pretty darn close. I almost wonder if we'd be better off
just parsing some heuristic subset and making sure (via review or
linting) that our tests conform.

Another option is to not enable this slightly-more-dangerous linting by
default. But that would probably rob it of its usefulness, since it
would just fall to some brave soul to later crank up the linting and fix
everybody else's mistakes.

-Peff
