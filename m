Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97495C4742C
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D5B2076E
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 14:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgKJOVZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 09:21:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:52824 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJOVY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 09:21:24 -0500
Received: (qmail 7926 invoked by uid 109); 10 Nov 2020 14:21:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 14:21:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1545 invoked by uid 111); 10 Nov 2020 14:21:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 09:21:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 09:21:22 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Daniel Gurney <dgurney99@gmail.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v2] compat/bswap.h: simplify MSVC endianness detection
Message-ID: <20201110142122.GA1311261@coredump.intra.peff.net>
References: <20201107234751.10661-1-dgurney99@gmail.com>
 <20201108095739.23144-1-dgurney99@gmail.com>
 <20201110003127.GA1268480@coredump.intra.peff.net>
 <20201110023620.GH6252@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110023620.GH6252@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 10, 2020 at 02:36:20AM +0000, brian m. carlson wrote:

> > > Modern MSVC or Windows versions don't support big-endian, so it's
> > > unnecessary to consider architectures when using it.
> > 
> > This made me wonder if we support any non-modern versions (which would
> > be negatively impacted).
> 
> I'm pretty sure we don't.  As I said, we're using several C99 features
> and that version precedes the C99 standard (and 1999).

Your response was much more thorough than I anticipated. What I was
really going for in the commit message was just laying out "modern" a
bit more clearly, like:

  No version of MSVC or Windows has supported a big-endian platform
  since the mid-90's. Git wouldn't build with these pre-C99 compilers
  these days anyway, so we can assume that MSVC is always little-endian.

> I'm fine leaving the commit message as it stands, given the brevity of
> the patch and that in the technology field, the affected versions are
> not in any way "modern," but of course I wouldn't object to a reroll.
> It's fine, should that happen, to include any of this email in the
> commit message.

I often find that the briefer the patch, the more I need to revisit the
assumptions of the author (myself included!). :)

But I am also OK either way; when commit messages are insufficient, I
often go back to the list archive to get more details, and now it's well
documented here.

-Peff
