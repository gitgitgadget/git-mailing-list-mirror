Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90581F597
	for <e@80x24.org>; Fri,  3 Aug 2018 21:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbeHCXgY (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 19:36:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:42330 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729985AbeHCXgY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 19:36:24 -0400
Received: (qmail 23697 invoked by uid 109); 3 Aug 2018 21:38:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Aug 2018 21:38:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8544 invoked by uid 111); 3 Aug 2018 21:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 03 Aug 2018 17:38:21 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Aug 2018 17:38:19 -0400
Date:   Fri, 3 Aug 2018 17:38:19 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a script to diff rendered documentation
Message-ID: <20180803213819.GA4650@sigill.intra.peff.net>
References: <20180803205204.GA3790@sigill.intra.peff.net>
 <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cSDM4vjuhwfuapuPpjjOmXbrhz-i0eVhtShp+nOYReLnA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 03, 2018 at 05:33:17PM -0400, Eric Sunshine wrote:

> > +OPTIONS_SPEC="\
> > +doc-diff <from> <to> [-- diff options]
> 
> Should this be?
> 
>     doc-diff [<options>] <from> <to> [-- <diff-options>]

I suppose so. Frankly I only added that line to appease git-sh-options
anyway.

> > +--
> > +j      parallel argument to pass to make
> > +f      force rebuild; do not rely on cached results
> > +"
> 
> Should "j" and "f" be "-j" and "-f", respectively?

No, they're input to "rev-parse --parseopt".

> > +while test $# -gt 0
> > +do
> > +       case "$1" in
> > +       -j)
> > +               parallel=${1#-j} ;;
> > +       -f)
> > +               force=t ;;
> > +       --)
> > +               shift; break ;;
> > +       *)
> > +               usage ;;
> 
> There doesn't seem to a usage() function defined anywhere (and
> OPTIONS_SPEC doesn't seem to be used).

It's git-sh-setup automagic. Try "./doc-diff --foo"

> > +# We'll do both builds in a single worktree, which lets make reuse
> > +# results that don't differ between the two trees.
> 
> "which lets make reuse"?

As in, lets the tool "make" reuse results...

-Peff
