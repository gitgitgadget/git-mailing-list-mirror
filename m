Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1195D1F453
	for <e@80x24.org>; Thu, 27 Sep 2018 06:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbeI0M5h (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Sep 2018 08:57:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:33162 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726659AbeI0M5h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Sep 2018 08:57:37 -0400
Received: (qmail 12463 invoked by uid 109); 27 Sep 2018 06:40:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 27 Sep 2018 06:40:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28256 invoked by uid 111); 27 Sep 2018 06:40:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 27 Sep 2018 02:40:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2018 02:40:55 -0400
Date:   Thu, 27 Sep 2018 02:40:55 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: On shipping more of our technical docs as manpages
Message-ID: <20180927064055.GA2865@sigill.intra.peff.net>
References: <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
 <87a7o4je0t.fsf@evledraar.gmail.com>
 <20180926185812.GD30680@sigill.intra.peff.net>
 <878t3oj8em.fsf@evledraar.gmail.com>
 <20180927062011.GA1318@sigill.intra.peff.net>
 <20180927063404.GB220288@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180927063404.GB220288@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 11:34:04PM -0700, Jonathan Nieder wrote:

> > We already have the /** convention I mentioned above. Could we have
> > another micro-format like:
> >
> >   /** API:strbuf - working with strings */
> >
> > in each header file? That would make generating such an index pretty
> > trivial.
> 
> Can you spell out the problem for me a little more?  E.g. if we had a
> convention that the first comment in strbuf.h should say
> 
> 	/* strbuf - Git's standard string type */
> 
> or even just
> 
> 	/* Git's standard string type */
> 
> would that do the trick?

I assumed that not all header files would want to advertise themselves
as a public API, so we'd want to some way to differentiate these from
first comments in "other" header files (and I assumed we did not want a
separate list of "these are the API files to go into the index", at
which point you might as well just write "standard string type" in that
list).

But I'm happy with any convention that lets Ævar generate the index he
wants.

> > Interesting. I'm not totally opposed to putting the documentation
> > alongside the actual code. It does feel a bit cluttered to me, but I
> > think you're right that it keeps everything as close together as
> > possible.
> 
> I've experienced projects following both conventions.  One thing I like
> a lot about documentation in the header file is that it encourages
> people to make the API documentation self-contained.  That is, you
> describe the contract in a way that doesn't require reading the
> implementation for details.
> 
> It took me a while to get used to this kind of convention but now I
> really like it.  So I really do prefer to keep putting API
> documentation in the header files in Git.  (Implementation
> documentation in the source files is of course also very welcome.)

Yeah, I'd agree with all of that.

> I use kythe to get an outline view of the header files.

Looks neat. Doesn't seem to be package for Debian, though. ;)

> In Debian we just ship all the docs.  For something like
> technical/pack-heuristics, it's quite nice.  For the API docs, I think
> they belong in the headers.

Yes, I'd agree with that. About half of technical/* is design docs, etc,
that might be of use to random folks. But the internal code APIs are
really only useful if you have an actual clone of git.git.

-Peff
