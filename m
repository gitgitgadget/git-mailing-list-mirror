Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26F6420248
	for <e@80x24.org>; Wed, 17 Apr 2019 03:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfDQDqY (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Apr 2019 23:46:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:60628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727219AbfDQDqX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Apr 2019 23:46:23 -0400
Received: (qmail 13375 invoked by uid 109); 17 Apr 2019 03:46:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 17 Apr 2019 03:46:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18126 invoked by uid 111); 17 Apr 2019 03:46:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 16 Apr 2019 23:46:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Apr 2019 23:46:21 -0400
Date:   Tue, 16 Apr 2019 23:46:21 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 7/7] Turn `git serve` into a test helper
Message-ID: <20190417034621.GA19448@sigill.intra.peff.net>
References: <pull.168.git.gitgitgadget@gmail.com>
 <411587e4b80bd4e5a1cb9b1ec438cda7a0681465.1555070430.git.gitgitgadget@gmail.com>
 <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa7grqsbt.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 15, 2019 at 11:03:02PM +0900, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
> 
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > The `git serve` built-in was introduced in ed10cb952d31 (serve:
> > introduce git-serve, 2018-03-15) as a backend to serve Git protocol v2,
> > probably originally intended to be spawned by `git upload-pack`.
> >
> > However, in the version that the protocol v2 patches made it into core
> > Git, `git upload-pack` calls the `serve()` function directly instead of
> > spawning `git serve`; The only reason in life for `git serve` to survive
> > as a built-in command is to provide a way to test the protocol v2
> > functionality.
> >
> > Meaning that it does not even have to be a built-in that is installed
> > with end-user facing Git installations, but it can be a test helper
> > instead.
> >
> > Let's make it so.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> I've excluded this step from tonight's pushout, as I would want to
> hear from the people on the other side who have (once) thought that
> this was an addition we would want to have, before we remove/demote
> it.
> 
> I do not personally think, as the design of v2 stands, a standalone
> "serve" server that "can serve anything as long as it goes over
> protocol v2" makes much sense, but perhaps those who have been doing
> the v2 work may have different ideas, in which case let's hear what
> their plans are.

I too would like to hear more definite comments from people who think
git-serve is worth keeping. In the meantime, there's some discussion
from this thread in December:

  https://public-inbox.org/git/20181211104236.GA6899@sigill.intra.peff.net/

especially this sub-thread:

  https://public-inbox.org/git/20181213195305.249059-1-jonathantanmy@google.com/

(In case you do not feel like reading the whole thing, my opinion there
is that git-serve is probably not the right direction, and we would do
well to demote it as Dscho's patch does).

-Peff
