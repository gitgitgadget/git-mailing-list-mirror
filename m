Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C67821FF40
	for <e@80x24.org>; Tue, 13 Dec 2016 11:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932955AbcLMLwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 06:52:23 -0500
Received: from cloud.peff.net ([104.130.231.41]:55618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932461AbcLMLwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 06:52:23 -0500
Received: (qmail 30006 invoked by uid 109); 13 Dec 2016 11:52:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 11:52:22 +0000
Received: (qmail 13790 invoked by uid 111); 13 Dec 2016 11:53:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 06:53:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 06:52:18 -0500
Date:   Tue, 13 Dec 2016 06:52:18 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Klaus Ethgen <Klaus@ethgen.ch>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] alternates: accept double-quoted paths
Message-ID: <20161213115218.7arxxatus7qjdu2m@sigill.intra.peff.net>
References: <20161212194929.bdcihf7orjabzb2h@sigill.intra.peff.net>
 <20161212195222.rxnabok6amklt2zf@sigill.intra.peff.net>
 <CACsJy8B52ZDRTUjGLqub_1wELtugv99xbDnBg1PX1LUTb6nVMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8B52ZDRTUjGLqub_1wELtugv99xbDnBg1PX1LUTb6nVMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 13, 2016 at 06:30:15PM +0700, Duy Nguyen wrote:

> On Tue, Dec 13, 2016 at 2:52 AM, Jeff King <peff@peff.net> wrote:
> > Instead, let's treat names as unquoted unless they begin
> > with a double-quote, in which case they are interpreted via
> > our usual C-stylke quoting rules. This also breaks
> > backwards-compatibility, but in a smaller way: it only
> > matters if your file has a double-quote as the very _first_
> > character in the path (whereas an escape character is a
> > problem anywhere in the path).  It's also consistent with
> > many other parts of git, which accept either a bare pathname
> > or a double-quoted one, and the sender can choose to quote
> > or not as required.
> 
> At least attr has the same problem and is going the same direction
> [1]. Cool. (I actually thought the patch was in and evidence that this
> kind of backward compatibility breaking was ok, turns out the patch
> has stayed around for years)
> 
> [1] http://public-inbox.org/git/%3C20161110203428.30512-18-sbeller@google.com%3E/

Thanks for digging that up. As soon as I came up with the idea[1], I
wanted to use the attr code as an example of a similar problem and
solution, but I couldn't find it in the code. Which makes sense if it
wasn't merged.

I do think it's a pretty reasonable approach in general, and would be OK
for the attributes code.

-Peff

[1] One could argue that I did not come up with the idea at all, but
    rather just remembered that somebody else had done so. :)
