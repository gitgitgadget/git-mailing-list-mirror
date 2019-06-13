Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7426B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 15:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfFMPUg (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 11:20:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:53810 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732104AbfFMPUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 11:20:33 -0400
Received: (qmail 2813 invoked by uid 109); 13 Jun 2019 15:20:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 13 Jun 2019 15:20:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19115 invoked by uid 111); 13 Jun 2019 15:21:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 13 Jun 2019 11:21:17 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Jun 2019 11:20:28 -0400
Date:   Thu, 13 Jun 2019 11:20:28 -0400
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH] revision: remove stray whitespace when name empty
Message-ID: <20190613152028.GA7459@sigill.intra.peff.net>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <20190609130004.GB23555@sigill.intra.peff.net>
 <xmqqsgsho145.fsf@gitster-ct.c.googlers.com>
 <20190612193745.GB233791@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190612193745.GB233791@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 12, 2019 at 12:37:45PM -0700, Emily Shaffer wrote:

> > > Alternatively, it would be reasonable to me to have an option for
> > > "rev-list --objects" to have an option to suppress the filename (and
> > > space) entirely.
> > 
> > Yup, I think that is a more reasonable short-term change compared to
> > the patch being discussed, and ...
> 
> I like this too. Starting work on it today.

Great!

> > > I think in the longer run along those lines that "--objects" should
> > > allow cat-file style pretty-print formats, which would eliminate the
> > > need to pipe to cat-file in the first place. That makes this parsing
> > > problem go away entirely, and it's way more efficient to boot (rev-list
> > > already knows the types!).
> > 
> > ... of course this makes tons of sense.
> 
> Probably not going to start work on this now, but I will make a note to
> myself to have a look if I have some spare time soon, and keep an eye
> out for reviews in that area.

That's fine. I suspect it will be quite involved, because the format
placeholders you'd want for "objects" are going to be more like
"cat-file" ones than like the existing pretty.c ones. So I think this
really implies unifying those format systems, which is a long-term
project that Olga has been working on.

-Peff
