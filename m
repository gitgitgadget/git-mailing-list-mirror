Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EDA81F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbcHISzJ (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:55:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:52236 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932367AbcHISzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:55:09 -0400
Received: (qmail 21368 invoked by uid 109); 9 Aug 2016 18:55:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 18:55:08 +0000
Received: (qmail 23750 invoked by uid 111); 9 Aug 2016 18:55:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 09 Aug 2016 14:55:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Aug 2016 14:55:05 -0400
Date:	Tue, 9 Aug 2016 14:55:05 -0400
From:	Jeff King <peff@peff.net>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Richard Ipsum <richard.ipsum@codethink.co.uk>,
	Eric Wong <e@80x24.org>, Josh Triplett <josh@joshtriplett.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
Message-ID: <20160809185505.fjrbid4rxatxrqfl@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox>
 <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
 <6c937f79-2b82-619d-51fe-adccbe09bd66@alum.mit.edu>
 <xmqqshuedh1i.fsf@gitster.mtv.corp.google.com>
 <3055f063-c9c1-0bf5-99bd-08256c253d33@alum.mit.edu>
 <20160809113703.57irthzzpg6j3dmv@sigill.intra.peff.net>
 <CACsJy8ARtg5KUceogNaeB+Fgh-u-TxfkAWdOk68_sEA-c0y6vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8ARtg5KUceogNaeB+Fgh-u-TxfkAWdOk68_sEA-c0y6vg@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 09, 2016 at 08:43:59PM +0200, Duy Nguyen wrote:

> On Tue, Aug 9, 2016 at 1:37 PM, Jeff King <peff@peff.net> wrote:
> >    That's (relatively) easy for me to script via mutt (grab
> >    these patches, apply them).
> 
> Could you share your mutt set up pleaaase? I've been wanting this for
> a long time, but never used mutt long enough to bother with a proper
> setup like this (I blame gmail).

It's actually pretty simple. The relevant config from my .muttrc is:

   macro pager,index D '<shell-escape>rm -f $HOME/patch<enter>'
   macro pager,index A '<copy-message>~/patch<enter><enter>'

I use "~/patch" as a rendezvous point, and then "git am ~/patch" from my
other terminal. That avoids mutt having to know which repo to apply to,
and keeps the "am" process in its own terminal (which is handy if it
runs into conflicts, for example).

So generally I would "D" to clear out the contents of ~/patch, and then
"A" whichever patches I want to apply. I often use mutt's aggregate
selection for that. My bindings are:

  bind index \; tag-pattern
  bind index a tag-prefix

which I think come from pine (which I used for many years before
switching to mutt probably 15 years ago). I don't recall the default
keybindings.

Anyway, you can either tag using a pattern (with ";"), or tag mails
individually (using "t", the default), and then "a-A" to apply the "A"
to all of them (if you are in the habit of tagging all of them and then
doing "A" in one swoop, you could also get rid of the separate "D"
command and just make "A" imply it).

-Peff
