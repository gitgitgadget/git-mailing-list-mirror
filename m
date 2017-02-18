Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8743B201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 20:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753555AbdBRUBk (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 15:01:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:58122 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753412AbdBRUBj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 15:01:39 -0500
Received: (qmail 16364 invoked by uid 109); 18 Feb 2017 20:01:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 20:01:39 +0000
Received: (qmail 15621 invoked by uid 111); 18 Feb 2017 20:01:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Feb 2017 15:01:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Feb 2017 15:01:37 -0500
Date:   Sat, 18 Feb 2017 15:01:37 -0500
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/19] builtin/diff-tree: convert to struct object_id
Message-ID: <20170218200136.qj22ve6d23ncu66e@sigill.intra.peff.net>
References: <20170218000652.375129-1-sandals@crustytoothpaste.net>
 <20170218000652.375129-3-sandals@crustytoothpaste.net>
 <3630da01-5af3-bc02-3a8c-1e3495512279@ramsayjones.plus.com>
 <20170218012607.kdisudmmponvts35@genre.crustytoothpaste.net>
 <20170218014217.sil4jyukkbqguxfz@sigill.intra.peff.net>
 <20170218031530.2bhlnjcukl4ybt6h@sigill.intra.peff.net>
 <20170218191217.thn3c2bympv2g7pm@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170218191217.thn3c2bympv2g7pm@genre.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 18, 2017 at 07:12:18PM +0000, brian m. carlson wrote:

> On Fri, Feb 17, 2017 at 10:15:31PM -0500, Jeff King wrote:
> > So for this case, something like the patch below.
> > 
> > Incidentally, there's an off-by-one in the original loop of
> > stdin_diff_commit that reads past the end of the trailing NUL for the
> > final sha1 on the line. The problem is the:
> > 
> >   pos += GIT_SHA1_HEXSZ + 1;
> > 
> > which assumes we're slurping up the trailing space. This works in
> > practice because the caller will only permit a string which had a
> > newline (which it converted into a NUL).
> > 
> > I suspect that function could be more aggressive about complaining about
> > nonsense on the line, rather than silently ignoring it.
> 
> I'd come to basically the same patch, but I did pick up a few niceties
> from your patch, like avoiding the off-by-one issue you mentioned above.
> Can I place your sign-off on the resulting change?

Absolutely. Thanks for taking a look.

-Peff
