Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F7051FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 21:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757028AbcK2Vq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 16:46:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:48770 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754834AbcK2VqG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 16:46:06 -0500
Received: (qmail 17768 invoked by uid 109); 29 Nov 2016 21:46:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 21:46:06 +0000
Received: (qmail 15676 invoked by uid 111); 29 Nov 2016 21:46:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 29 Nov 2016 16:46:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Nov 2016 16:46:04 -0500
Date:   Tue, 29 Nov 2016 16:46:04 -0500
From:   Jeff King <peff@peff.net>
To:     Eli Barzilay <eli@barzilay.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: gitconfig includes
Message-ID: <20161129214604.c5xcw3d2a5ydpx42@sigill.intra.peff.net>
References: <CALO-gutW80d6RLdXAtYA2m2GWOchAjNNPy3YCsr31_fCss512g@mail.gmail.com>
 <xmqq7f7mf4rs.fsf@gitster.mtv.corp.google.com>
 <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALO-gutJbM=LA3q8vdmbQJLoeCFAJWfPHFo8f1vz-5KJHVxJ6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 02:53:08PM -0500, Eli Barzilay wrote:

> > This already is documented, and I think it is clear enough.
> >
> >        --[no-]includes
> >                   Respect include.* directives in config files when
> >                   looking up values.  Defaults to off when a specific
> >                   file is given (e.g., using --file, --global, etc)
> >                   and on when searching all config files.
> 
> Yeah, that's clear, sorry for not checking the latest.
> 
> [I'd expect/wish it to be on by default though...  Any reason for the
> default being off in these cases?]

It definitely needs to default to off for "-f", as we would not want
surprises when accessing files like ".gitmodules" that come from
untrusted sources.

I think it's arguable whether "--global" should behave the same. It
makes the rule simple: "if you specify a single file, includes default
to off". But I don't think there would be any particular harm. The
existing default was mostly chosen for simplicity and least-surprise
with respect to backwards compatibility.

There's a little more discussion in 9b25a0b52 (config: add include
directive, 2012-02-06).

-Peff
