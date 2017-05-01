Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DAF1F78F
	for <e@80x24.org>; Mon,  1 May 2017 21:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751513AbdEAV1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 17:27:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:43366 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751277AbdEAV1C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 17:27:02 -0400
Received: (qmail 26723 invoked by uid 109); 1 May 2017 21:26:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 21:26:59 +0000
Received: (qmail 6148 invoked by uid 111); 1 May 2017 21:27:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 May 2017 17:27:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 May 2017 17:26:56 -0400
Date:   Mon, 1 May 2017 17:26:56 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] cache-tree: reject entries with null sha1
Message-ID: <20170501212656.h4vhkstjolh46whe@sigill.intra.peff.net>
References: <20170421184617.lc5bioa5px6ninrj@sigill.intra.peff.net>
 <CACsJy8AAtV5KJHBqWvnYb3Mw9CVzEdG3M-UJA+jd5MR5e-UMsA@mail.gmail.com>
 <12c3312c-30a1-2cb1-8f05-63bb663bd0a0@web.de>
 <20170501192212.xy5o72tinb2hy2a3@sigill.intra.peff.net>
 <456378ba-a117-8003-eea2-69272ed9bb58@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <456378ba-a117-8003-eea2-69272ed9bb58@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 01, 2017 at 11:00:58PM +0200, René Scharfe wrote:

> Am 01.05.2017 um 21:22 schrieb Jeff King:
> > On Mon, May 01, 2017 at 01:23:28PM +0200, René Scharfe wrote:
> > > I can only get gcc and clang to call memcpy instead of inlining it by
> > > specifying -fno-builtin.  Do you use that option?  If yes, why?  (Just
> > > curious.)
> > 
> > I do my normal edit-compile cycles with -O0 because it's fast, and
> > because it makes debugging much easier.
> 
> GCC and Clang still inline memcpy with -O0 alone (at least the versions
> I tested).

I just checked the assembler output and confirmed that is the case for
my builds, even with -O0. Which probably explains why I wasn't able to
replicate Duy's valgrind error in the first place.

-Peff
