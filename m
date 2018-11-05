Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD8A1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 18:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbeKFEKC (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 23:10:02 -0500
Received: from cloud.peff.net ([104.130.231.41]:41112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728858AbeKFEKC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 23:10:02 -0500
Received: (qmail 18740 invoked by uid 109); 5 Nov 2018 18:49:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 18:49:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21826 invoked by uid 111); 5 Nov 2018 18:48:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 13:48:20 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 13:49:00 -0500
Date:   Mon, 5 Nov 2018 13:49:00 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/13] parseopt fixes from -Wunused-parameters
Message-ID: <20181105184900.GA30690@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
 <CACsJy8Dz5Meu2fnNOiFXcw4LTROxBAn05OSZhYBih7ac0jQFzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Dz5Meu2fnNOiFXcw4LTROxBAn05OSZhYBih7ac0jQFzA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 05, 2018 at 05:51:07PM +0100, Duy Nguyen wrote:

> On Mon, Nov 5, 2018 at 7:39 AM Jeff King <peff@peff.net> wrote:
> >
> > Continuing my exploration of what -Wunused-parameters can show us, here
> > are some bug-fixes related to parse-options callbacks.
> >
> > This is the last of the actual bug-fixes I've found. After this, I have
> > about 60 patches worth of cleanups (i.e., dropping the unused
> > parameters), and then I have a series to annotate parameters that must
> > be unused (e.g., for functions that must conform to callback
> > interfaces). After we can start compiling with -Wunused-parameters,
> > assuming we don't find the annotations too cumbersome.
> 
> Another good thing from this series is there are fewer --no-options to complete.
> 
> About the annotating unused parameters related to segfault bug fixes
> in this series. Should we just add something like
> 
>  if (unset)
>     BUG("This code does not support --no-stuff");
> 
> which could be done in the same patches that fix the segfault, and it
> extends the diff context a bit to see what these callbacks do without
> opening up the editor, and also serves as a kind of annotation?

That's done in the final patch. I did originally do it alongside the
actual segfault fixes, but since it needs doing in so many other
callbacks, too, it made sense to me to do it all together.

-Peff
