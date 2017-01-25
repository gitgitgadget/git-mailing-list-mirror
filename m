Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB24B1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 18:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbdAYSjc (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 13:39:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:44613 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752384AbdAYSjb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 13:39:31 -0500
Received: (qmail 25067 invoked by uid 109); 25 Jan 2017 18:39:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 18:39:26 +0000
Received: (qmail 14166 invoked by uid 111); 25 Jan 2017 18:39:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Jan 2017 13:39:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jan 2017 13:39:24 -0500
Date:   Wed, 25 Jan 2017 13:39:24 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2017, #04; Mon, 23)
Message-ID: <20170125183924.6yclcjl4ggcu42yp@sigill.intra.peff.net>
References: <xmqqo9yxpaxk.fsf@gitster.mtv.corp.google.com>
 <0D956B23-E655-4C28-A205-14CCC0A7DEA2@gmail.com>
 <20170124132749.l3ezupyitvxe4t2l@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251800120.3469@virtualbox>
 <20170125173958.pg546a6w33dirp5k@sigill.intra.peff.net>
 <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4m0nc8dz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 10:16:40AM -0800, Junio C Hamano wrote:

> > But whatever the cause, I think the workaround I posted is
> > easy enough to do.
> 
> Or spelling it explicitly as "/bin/mv" (forgetting systems that does
> not have it in /bin but as /usr/bin/mv) would also defeat alias if
> that were the cause.

Yes, but I think it's less tricky and unportable to write "mv -f" than
"/bin/mv". So even if it _is_ a funny alias thing, I think my patch is
the right fix.

> One downside of working it around like your patch does, or spelling
> it out as "/bin/mv", is that we'd need to worry about all the uses
> of "mv" in our scripts.  If this were _only_ happening in the Travis
> environment, I'd prefer to see why it happens only there and fix that
> instead.

I would be curious to know whether it is a funny thing in the Travis
environment, or if some version of macOS "mv" really is that braindead
(and it is just the case that Travis has that version and Lars's
computer doesn't). I just didn't want to waste anybody's time digging
into it if it won't affect our patch.

I guess the way to dig would be to add a test that looks at the output
of "type mv" or something, push it to a Travis-hooked branch, and then
wait for the output

-Peff
