Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6DEC203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 17:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755984AbdGXRIV (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 13:08:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:47138 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755976AbdGXRIP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 13:08:15 -0400
Received: (qmail 6118 invoked by uid 109); 24 Jul 2017 17:08:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 17:08:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10194 invoked by uid 111); 24 Jul 2017 17:08:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 13:08:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 13:08:13 -0400
Date:   Mon, 24 Jul 2017 13:08:13 -0400
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>, gitster@pobox.com,
        git@vger.kernel.org, j6t@kdbg.org, l.s.r@web.de,
        schwab@linux-m68k.org
Subject: Re: [PATCH] objects: scope count variable to loop
Message-ID: <20170724170813.scceigybl5d3fvdd@sigill.intra.peff.net>
References: <xmqq8tjqrfq4.fsf@gitster.mtv.corp.google.com>
 <20170719181956.15845-1-sbeller@google.com>
 <20170719182342.GA158344@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170719182342.GA158344@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 19, 2017 at 11:23:42AM -0700, Brandon Williams wrote:

> > object.c: In function ‘object_array_remove_duplicates’:
> > object.c:404:2: error: ‘for’ loop initial declarations are only allowed in C99 mode
> >   for (unsigned src = 0; src < nr; src++) {
> >   ^
> > object.c:404:2: note: use option -std=c99 or -std=gnu99 to compile your code
> > 
> > Using -std=c99 works for me.
> 
> This would need a change to the makefile then wouldn't it?

Actually, it complicates things even more, I'd think. We probably can't
just blindly add "-std=c99" to CFLAGS, as not all compilers would
support it (even if they _do_ support this construct).

Interestingly I have no problems compiling it here. I wonder if Stefan's
config.mak is supplying -std=c89 or some other restrictive flag. Or if
his compiler is a different version (though I tried with gcc-6, gcc-4.9,
and clang-3.8).

-Peff
