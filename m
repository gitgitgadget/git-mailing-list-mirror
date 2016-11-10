Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9DC20229
	for <e@80x24.org>; Thu, 10 Nov 2016 16:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934807AbcKJQIU (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Nov 2016 11:08:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:41154 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934781AbcKJQIM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2016 11:08:12 -0500
Received: (qmail 24160 invoked by uid 109); 10 Nov 2016 16:08:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 16:08:11 +0000
Received: (qmail 5245 invoked by uid 111); 10 Nov 2016 16:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 10 Nov 2016 11:08:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Nov 2016 11:08:09 -0500
Date:   Thu, 10 Nov 2016 11:08:09 -0500
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>, me@ttaylorr.com
Subject: Re: [RFC] Add way to make Git credentials accessible from
 clean/smudge filter
Message-ID: <20161110160809.2gvf67rlnvounulf@sigill.intra.peff.net>
References: <4C8C5650-7221-4F62-A9CC-81AE01EF6DC7@gmail.com>
 <vpqoa1n1qom.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpqoa1n1qom.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 10, 2016 at 01:10:17PM +0100, Matthieu Moy wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
> > I haven't looked at an implemenation approach at all. I wonder if this could
> > be OK from a conceptional point of view or if there are obvious security 
> > problems that I am missing.
> 
> Did you consider just running "git credential" from the filter? It may
> not be the perfect solution, but it should work. I already used it to
> get credential from a remote-helper (git-remote-mediawiki). When
> prompting credentials interactively, it grabs the terminal directly, so
> it work even if stdin/stdout are used for the protocol.

Yeah, that is the solution I was going to suggest. The credentials are
totally orthogonal to the filters, and I would rather not shove them
into the protocol. It's an extra process, but with the new multi-use
smudge filter, it's one per git invocation, not one per file.

-Peff
