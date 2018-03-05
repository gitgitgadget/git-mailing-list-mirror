Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C0C601F404
	for <e@80x24.org>; Mon,  5 Mar 2018 18:43:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeCESnZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 13:43:25 -0500
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36705 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCESnY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 13:43:24 -0500
Received: by mail-pg0-f49.google.com with SMTP id i14so7185235pgv.3
        for <git@vger.kernel.org>; Mon, 05 Mar 2018 10:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFTdHxnlh6jS6AVGq7U7q/oP6IK7elqSpF2TZKEfQdU=;
        b=BML7wH6tYdAPmtVznT+62tP3gkT69BzJLDceNYSk9JXsAqKPOw4b5ZnUvCRZaUU4JC
         LehtCmSZ5gaaPAd2C7/GZfexJ2V9AWBWygFQvoUsIkMywoEJV/AgWFdrNJDqUMYMLETX
         eBtsHW1YkXsaTTu3FQ08BU+XlUpyIdvZxTVrfiO39z1m0v1ORa4QQEf4xLhtMn/vPq9C
         1RqOl+JUM0AsaB54zljwvuae5ZiMILFp8uppkuPHcfWojlOq+cFUPxfO9qZopAxajPUx
         ED52JMYWBFSlgqGlATb7AH9MuVC0bVswZxO9BDqae2c1cEGzvv6COB8INccu/K88Ctav
         xZ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFTdHxnlh6jS6AVGq7U7q/oP6IK7elqSpF2TZKEfQdU=;
        b=dkLOYB2j4lGGc4Ic+SegvnXFuyj4xdyeQ+pHV0iSXGIaCvQx79uPn8HQa1ltTZyc6o
         eGxArUm4OPxNw1PyXXoUDFhi+Lkykq+1ZcHm3lK2wjA3xIqhV1V67H1p8FVnTQkmqoX2
         /PjLuhvMkRTSYJKomvNAB6VU2PLU1H3rvS4c8Mdvo4RUF3B026bJDFh0WSisc2oGnPId
         iltF73sQnkB1yX8I5bi/v70OSPrdf3tnx3EYWc6Cc3Mp2VcSAjt+HdlkuYrg6CQ7JopI
         k6S0mMRZr9w0lcJnp/KI1o4nSOwTdNdC25MYN0FOOoOiKNUdXIa2RQqaYvRq96By4zCV
         mgLw==
X-Gm-Message-State: APf1xPA1FNXlQziggRahevqz5l14AmhXaCEfNvajzzGJ0ze5WoFALPI3
        hcCXk4JlJDZ6Z6ov0T8kUac+2A==
X-Google-Smtp-Source: AG47ELu9TKv9aqNxFduJXxBjQOSfywMsN741PUHvrRo9slm3uRHF+R380N346IdqNL+0Yho5syjn9w==
X-Received: by 10.98.162.26 with SMTP id m26mr16262578pff.217.1520275403118;
        Mon, 05 Mar 2018 10:43:23 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 191sm26109887pfv.167.2018.03.05.10.43.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Mar 2018 10:43:22 -0800 (PST)
Date:   Mon, 5 Mar 2018 10:43:21 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com
Subject: Re: [PATCH v3 12/35] serve: introduce git-serve
Message-ID: <20180305184321.GC72475@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-13-bmwill@google.com>
 <20180222093327.GA12442@sigill.intra.peff.net>
 <20180223214557.GF234838@google.com>
 <20180303043338.GC27689@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180303043338.GC27689@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/02, Jeff King wrote:
> On Fri, Feb 23, 2018 at 01:45:57PM -0800, Brandon Williams wrote:
> 
> > I think this is the price of extending the protocol in a backward
> > compatible way.  If we don't want to be backwards compatible (allowing
> > for graceful fallback to v1) then we could design this differently.
> > Even so we're not completely out of luck just yet.
> > 
> > Back when I introduced the GIT_PROTOCOL side-channel I was able to
> > demonstrate that arbitrary data could be sent to the server and it would
> > only respect the stuff it knows about.  This means that we can do a
> > follow up to v2 at some point to introduce an optimization where we can
> > stuff a request into GIT_PROTOCOL and short-circuit the first round-trip
> > if the server supports it.
> 
> If that's our end-game, it does make me wonder if we'd be happier just
> jumping to that at first. Before you started the v2 protocol work, I had
> a rough patch series passing what I called "early capabilities". The
> idea was to let the client speak a few optional capabilities before the
> ref advertisement, and be ready for the server to ignore them
> completely. That doesn't clean up all the warts with the v0 protocol,
> but it handles the major one (allowing more efficient ref
> advertisements).

I didn't really want to get to that just yet, simply because I want to
try and keep the scope of this smaller while still being able to fix
most of the issues we have with v0.

> I dunno. There's a lot more going on here in v2 and I'm not sure I've
> fully digested it.

I tried to keep it similar enough to v0 such that it wouldn't be that
big of a leap (small steps).  For example negotiation is really done the
same as it is in v0 during fetch (a next step would be to actually
improve that).  We can definitely talk about all this in more detail
later this week too.

> 
> > The great thing about this is that from the POV of the git-client, it
> > doesn't care if its speaking using the git://, ssh://, file://, or
> > http:// transport; it's all the same protocol.  In my next re-roll I'll
> > even drop the "# service" bit from the http server response and then the
> > responses will truly be identical in all cases.
> 
> This part has me a little confused still. The big difference between
> http and the other protocols is that the other ones are full-duplex, and
> http is a series of stateless request/response pairs.
> 
> Are the other protocols becoming stateless request/response pairs, too?
> Or will they be "the same protocol" only in the sense of using the same
> transport?
> 
> (There are a lot of reasons not to like the stateless pair thing; it has
> some horrid corner cases during want/have negotiation).

Junio made a comment on the Spec in the most recent version of the
series about how I state that v2 is stateless and "MUST NOT" rely on
state being stored on the server side.  In reality I think this needs to
be tweaked a bit because when you do have a full-duplex connection you
may probably want to use that to reduce the amount of data that you send
in some cases.

In the current protocol http has a lot of additional stuff that's had to
be done to it to get it to work with a protocol that was designed to be
stateful first.  What I want is for the protocol to be designed
stateless first so that http functions essentially the same as ssh or
file or git transports and we don't have to do any hackery to get it to
work.  This also makes it very simple to implement a new feature in the
protocol because you only need to think about implementing it once
instead of twice like you kind of have to do with v0.  So in the most
recent series everything is a chain of request/response pairs even in
the non-http cases.

In a previous version of the series I had each command being able to
last any number of rounds and having a 'stateless' capability indicating
if the command needed to be run stateless.  I didn't think that was a
good design because by default you are still designing the stateful
thing first and the http (stateless) case can be an afterthought.  So
instead maybe we'll need commands which can benefit from state to have a
'stateful' feature that can be advertised when a full-duplex connection
is possible.  This still gives you the opportunity to not advertise that
and have the same behavior over ssh as http.  I actually remember
hearing someone talk about how they would like to allow for ssh
connections to their server and just have it be a proxy for http and
this would enable that.

-- 
Brandon Williams
