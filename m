Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4812520960
	for <e@80x24.org>; Thu, 13 Apr 2017 18:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755275AbdDMSMS (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 14:12:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:33055 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752153AbdDMSMR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 14:12:17 -0400
Received: (qmail 26599 invoked by uid 109); 13 Apr 2017 18:12:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 18:12:15 +0000
Received: (qmail 25480 invoked by uid 111); 13 Apr 2017 18:12:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Apr 2017 14:12:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Apr 2017 14:12:12 -0400
Date:   Thu, 13 Apr 2017 14:12:12 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCHv2.1] t6500: wait for detached auto gc at the end of the
 test script
Message-ID: <20170413181211.kxrw76fgm5fbrwav@sigill.intra.peff.net>
References: <20170412220717.7357-1-szeder.dev@gmail.com>
 <20170413103138.12717-1-szeder.dev@gmail.com>
 <20170413164451.quvt7xdzsm64lntp@sigill.intra.peff.net>
 <CAM0VKjkA3O9YB5QpT+hBwt13FtQXOwiW5Fh3goSbi42V8rTzjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0VKjkA3O9YB5QpT+hBwt13FtQXOwiW5Fh3goSbi42V8rTzjQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2017 at 08:08:12PM +0200, SZEDER Gábor wrote:

> On Thu, Apr 13, 2017 at 6:44 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Apr 13, 2017 at 12:31:38PM +0200, SZEDER Gábor wrote:
> 
> > I did wonder what will happen if Windows learns to daemonize() the
> > auto-gc. I don't think we'll get an immediate test failure, but this
> > test will become racy again. But this time we'll actually notice the
> > racy failure, because the "ls" will report extra packs if it runs before
> > the background gc does. At which point we can revisit this.
> 
> Dscho said that it would take significant effort to make daemonize()
> work on Windows, so I guess it will take a while before we'll have to
> revisit this.

Yeah, that's what I figured. I mostly just didn't want to leave a
time-bomb for future developers.

> > I guess we could probably grep for the "in the background" message from
> > the parent gc. OTOH, maybe it is not even worth it.
> 
> That wouldn't work at the moment, because auto gc says that it will go
> to the background even on Windows.

Ah, OK. Let's not worry about it, then. I think the way your test is
constructed we should get a racy failure not long after the change, and
your comments would lead people to realize what is going on.

-Peff
