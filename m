Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAA31F4C1
	for <e@80x24.org>; Wed, 23 Oct 2019 01:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfJWB4a (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 21:56:30 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:48336 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727582AbfJWB4a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 21:56:30 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id CF6C91F4C0;
        Wed, 23 Oct 2019 01:56:29 +0000 (UTC)
Date:   Wed, 23 Oct 2019 01:56:29 +0000
From:   Eric Wong <e@80x24.org>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC/WIP] range-diff: show old/new blob OIDs in comments
Message-ID: <20191023015629.GA15495@dcvr>
References: <20191017121045.GA15364@dcvr>
 <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910222111430.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi Eric,
> 
> 
> On Thu, 17 Oct 2019, Eric Wong wrote:
> 
> > (WIP, mostly stream-of-concious notes + reasoning)
> >
> > When using "git format-patch --range-diff", the pre and
> > post-image blob OIDs are in each email, while the exact
> > commit OIDs are rarely shared via emails (only the tip
> > commit from "git request-pull").
> >
> > These blob OIDs make it easy to search for or lookup the
> > full emails which create them, or the blob itself once
> > it's fetched via git.
> >
> > public-inbox indexes and allows querying specifically for blob
> > OIDs via dfpre:/dfpost: since June 2017.  As of Jan 2019,
> > public-inbox also supports recreating blobs out of patch emails
> > (querying internally with dfpre:/dfpost: and doing "git apply")
> >
> > Searching on these blob OIDs also makes it easier to find
> > previous versions of the patch sets using any mail search
> > engine.
> >
> > Future changes to public-inbox may allow generating custom
> > diffs out of any blobs it can find or recreate.
> >
> > Most of this is pretty public-inbox-specific and would've
> > made some future changes to public-inbox much easier....
> > (if we had this from the start of range-diff).
> >
> > Unfortunately, it won't help with cases where range-diffs
> > are already published, but range-diff isn't too old.
> 
> I guess your patch won't hurt.

Cool, will update tests and resend.

> As to recreating blobs from mails: Wow. That's quite a length you're
> going, and I think it is a shame that you have to. If only every
 contribution came accompanied with a pullable branch in a public
> repository.

What Konstantin said about git repos being transient.
It wasn't too much work to recreate those blobs from
scratch since git-apply has done it since 2005.
Just add search :)

We could get around transient repos with automatic mirroring
bots which never deletes or overwrites anything published.
That includes preserving pre-force-push data in case of
force pushes.

> Instead, we will have to rely on your centralized, non-distributed
> service...

I'm curious how you came to believe that, since that's the
opposite of what public-inbox has always been intended to be.

The only thing that's centralized and not reproducible by
mirrors is the domain name (and I also have Tor .onion mirrors
with no dependency on ICAAN).  Memorable naming is a tricky
problem in decentralized systems, though...
