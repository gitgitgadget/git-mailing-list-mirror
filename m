Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194D020960
	for <e@80x24.org>; Mon, 10 Apr 2017 19:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752045AbdDJTWb (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 15:22:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:59374 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdDJTWb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 15:22:31 -0400
Received: (qmail 19326 invoked by uid 109); 10 Apr 2017 19:22:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 19:22:26 +0000
Received: (qmail 27814 invoked by uid 111); 10 Apr 2017 19:22:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 10 Apr 2017 15:22:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Apr 2017 15:22:24 -0400
Date:   Mon, 10 Apr 2017 15:22:24 -0400
From:   Jeff King <peff@peff.net>
To:     Joachim Durchholz <jo@durchholz.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] test-lib: exhaustively insert non-alnum ASCII into
 the TRASH_DIRECTORY name
Message-ID: <20170410192223.dbcysbbq5ei3wglj@sigill.intra.peff.net>
References: <20170409191117.25175-3-avarab@gmail.com>
 <20170410014712.26716-1-szeder.dev@gmail.com>
 <CACBZZX6M2YnbOT6btqLf2RacNT0Th3Hx2jf5QR7g+KFS_DKtVQ@mail.gmail.com>
 <CAM0VKjnwbCgCjEBr895068k4veoSGZMf8Cu7neoH=oofgWS2Cw@mail.gmail.com>
 <CACBZZX7kMcTgKFkFN3OvVKVHU693PYhRFe6gyO4AirihNsUYmg@mail.gmail.com>
 <20170410133856.qbmcif2it2gc6kdw@sigill.intra.peff.net>
 <64121361-6f91-5988-b5e2-9278cc84067f@durchholz.org>
 <20170410165727.4lqtit5hkcxh32ew@sigill.intra.peff.net>
 <d1a71326-06bc-4133-de2b-7d42f525f7a4@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d1a71326-06bc-4133-de2b-7d42f525f7a4@durchholz.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 08:19:40PM +0200, Joachim Durchholz wrote:

> > I very much disagree with that. Git's test operate under a set of
> > assumptions, and if you violate those assumptions, then the failures are
> > not meaningful.
> 
> In that case the tests do not validate that git can properly work with
> special characters.
> That's a pretty big coverage gap.

That's not necessarily true either; there may be specific tests that
create exotic paths and check them. My point is that the outcome depends
on that paths. So you cannot just take a test which runs "git clone -s"
and expect it to work both with and without paths with newlines. You
need two tests, because there are two different outcomes, depending on
the test environment.

So if you're proposing to write a bunch of new tests that check the
proper behavior under various conditions, go for it. But I don't think
running the entire existing test suite with exotic paths tells you much.
A failure might be a bug, or it might be that the thing is untestable
given the environment.

> > Sure, and I'd encourage people who are interested to dig through the
> > results and see if they can find a real problem. I looked at several and
> > didn't find anything that wasn't an example of the "test assumptions"
> > thing above.
> 
> Don't assume that there's no risk just because you didn't find anything.

I'm not assuming that at all. Didn't I say somebody would need to dig
into all of these to find out the real answer? I'm only arguing that
blindly adding this feature to the test suite has no value. It's the
digging that has value, and you do not even need to modify the test
suite to do it (you can just use --root).

I've been trying to invite you to do that digging, if it's something you
care about.

-Peff
