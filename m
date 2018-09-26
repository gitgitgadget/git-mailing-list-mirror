Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F38F31F453
	for <e@80x24.org>; Wed, 26 Sep 2018 18:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbeI0AtI (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 20:49:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:60432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725990AbeI0AtI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 20:49:08 -0400
Received: (qmail 18180 invoked by uid 109); 26 Sep 2018 18:34:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 26 Sep 2018 18:34:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20915 invoked by uid 111); 26 Sep 2018 18:34:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 26 Sep 2018 14:34:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Sep 2018 14:34:51 -0400
Date:   Wed, 26 Sep 2018 14:34:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 1/8] sha1-array: provide oid_array_filter
Message-ID: <20180926183451.GA30680@sigill.intra.peff.net>
References: <20180921223558.65055-1-sbeller@google.com>
 <20180921223558.65055-2-sbeller@google.com>
 <87h8ihk7sl.fsf@evledraar.gmail.com>
 <CAGZ79kZCkccV=4a1cAE0DpV7hZGxuCyJuceyAEow_u0LspwYAw@mail.gmail.com>
 <20180926041517.GA2140@sigill.intra.peff.net>
 <xmqqlg7ombgt.fsf@gitster-ct.c.googlers.com>
 <87d0t0jghm.fsf@evledraar.gmail.com>
 <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0t0ktau.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 11:27:53AM -0700, Junio C Hamano wrote:

> >> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> >> index 48aa4edfbd..b54684e807 100644
> >> --- a/Documentation/CodingGuidelines
> >> +++ b/Documentation/CodingGuidelines
> >> @@ -358,7 +358,11 @@ For C programs:
> >>     string_list for sorted string lists, a hash map (mapping struct
> >>     objects) named "struct decorate", amongst other things.
> >>
> >> - - When you come up with an API, document it.
> >> + - When you come up with an API, document it.  It used to be
> >> +   encouraged to do so in Documentation/technical/, and the birds-eye
> >> +   level overview may still be more suitable there, but detailed
> >> +   function-by-function level of documentation is done by comments in
> >> +   corresponding .h files these days.
> >>
> >>   - The first #include in C files, except in platform specific compat/
> >>     implementations, must be either "git-compat-util.h", "cache.h" or
> >
> > Thanks. I had not looked at this closely and was under the false
> > impression that it was going in the other direction. Good to have it
> > clarified.
> 
> Heh, I knew people were in favor of one over the other but until
> Peff chimed in to this thread, I didn't recall which one was
> preferred, partly because I personally do not see a huge advantage
> in using in-code comments as docs for programmers, and do not like
> having to read them as in-code comments.
> 
> If somebody wants to wordsmith the text and send in a patch with
> good log message, please do so, as I myself am not sure if what I
> wrote is the consensus position.  It could be that they want to have
> even birds-eye overview in the header files.

Yes, I would say that everything should go into the header files. For
the same reason that the function descriptions should go there: by being
close to the thing being changed, it is more likely that authors will
remember to adjust the documentation. It's not exactly literate
programming, but it's a step in that direction.

That's just my opinion, of course. I've been very happy so far with the
documentation that we have transitioned. We talked a while ago about a
script to extract the comments into a "just documentation" and build it
as asciidoc, but I doubt I would use such a thing myself.

I do agree in general that mentioning this in CodingGuidelines is a good
idea.

-Peff
