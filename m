Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FA920229
	for <e@80x24.org>; Sat, 12 Nov 2016 07:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935649AbcKLHGW (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Nov 2016 02:06:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:42190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932401AbcKLHGW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2016 02:06:22 -0500
Received: (qmail 4974 invoked by uid 109); 12 Nov 2016 07:06:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 12 Nov 2016 07:06:20 +0000
Received: (qmail 19886 invoked by uid 111); 12 Nov 2016 07:06:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 12 Nov 2016 02:06:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 12 Nov 2016 02:06:19 -0500
Date:   Sat, 12 Nov 2016 02:06:19 -0500
From:   Jeff King <peff@peff.net>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
Message-ID: <20161112070619.hto3lehbyh6oamql@sigill.intra.peff.net>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
 <xmqqinrt1zcx.fsf@gitster.mtv.corp.google.com>
 <1478931094.12153.3.camel@kaarsemaker.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478931094.12153.3.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 12, 2016 at 07:11:34AM +0100, Dennis Kaarsemaker wrote:

> >  * If normal "diff" that follows symlinks by default has an option
> >    to disable it, then it is OK to also add --no-follow-symlinks
> >    that is only valid in the --no-index mode, so that we can mimick
> >    it better (I do not think this is the case, though).
> 
> It does not, so no new option.

There is "--no-dereference", but it is not that helpful:

  $ echo one >1
  $ echo two >2
  $ ln -s 1 sl1
  $ ln -s 2 sl2
  $ diff --no-dereference sl1 sl2
  Symbolic links sl1 and sl2 differ
  $ diff --no-dereference sl1 2
  File sl1 is a symbolic link while file 2 is a regular file

So it does do the thing we are talking about here, but diff's handling
of non-file content is not nearly as useful as git's.

That said, I have no problem with proceeding without it and waiting
until somebody actually shows up who really _wants_ --no-dereference. I
won't be surprised if that never happens.

-Peff
