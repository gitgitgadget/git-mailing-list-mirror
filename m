Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 72D7E203BD
	for <e@80x24.org>; Wed, 26 Oct 2016 20:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934256AbcJZUUb (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:20:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:34510 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933805AbcJZUUb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:20:31 -0400
Received: (qmail 31071 invoked by uid 109); 26 Oct 2016 20:20:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 20:20:30 +0000
Received: (qmail 13802 invoked by uid 111); 26 Oct 2016 20:20:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 26 Oct 2016 16:20:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 26 Oct 2016 16:20:28 -0400
Date:   Wed, 26 Oct 2016 16:20:28 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
Message-ID: <20161026202027.ct6elljwzp46p2vc@sigill.intra.peff.net>
References: <20161022233225.8883-1-sbeller@google.com>
 <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox>
 <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
 <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net>
 <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 12:51:02PM -0700, Stefan Beller wrote:

> > I seem to recall this does not work on Windows, where the pthread
> > functions are thin wrappers over CRITICAL_SECTION. Other threaded code
> > in git does an explicit setup step before entering threaded sections.
> > E.g., see start_threads() in builtin/grep.c.
> >
> 
> I wonder if we can have a similar thing as
> http://stackoverflow.com/a/9490113 in compat/win32/pthread.{h.c} as it is
> very convenient to not have to explicitly initialize mutexes?

I agree it would be much more convenient and get rid of some repetitive
boilerplate code. I'll leave it to Windows folks to decide if they are
OK with that approach or not (I do not offhand know of any reason it
would not work).

-Peff
