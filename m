Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0F541F97E
	for <e@80x24.org>; Mon, 15 Oct 2018 00:01:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeJOHoc (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 03:44:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:40248 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725792AbeJOHoc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 03:44:32 -0400
Received: (qmail 8919 invoked by uid 109); 15 Oct 2018 00:01:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Oct 2018 00:01:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27569 invoked by uid 111); 15 Oct 2018 00:00:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 14 Oct 2018 20:00:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Oct 2018 20:01:47 -0400
Date:   Sun, 14 Oct 2018 20:01:47 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] zlib.c: use size_t for size
Message-ID: <20181015000147.GB13510@sigill.intra.peff.net>
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
 <20181012204229.11890-1-tboegi@web.de>
 <20181012222234.GF19800@szeder.dev>
 <20181013050057.GA6805@tor.lan>
 <fb6367b3-975b-1bc6-e95b-a457fb9e3a33@ramsayjones.plus.com>
 <20181014025207.GA1527@sigill.intra.peff.net>
 <1e3233f4-ea40-6fff-0951-6b4885f88445@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1e3233f4-ea40-6fff-0951-6b4885f88445@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 14, 2018 at 04:03:48PM +0100, Ramsay Jones wrote:

> > So I kind of wonder if a comment would be better than xsize_t here.
> > Something like:
> > 
> >   if (avail > len) {
> > 	/*
> > 	 * This can never truncate because we know that len is smaller
> > 	 * than avail, which is already a size_t.
> > 	 */
> > 	avail = (size_t)len;
> >   }
> 
> Heh, you are, of course, correct! (that will learn me[1]). :-D
> 
> Hmm, let's see if I can muster the enthusiasm to do all that
> testing again!

For the record, I am not opposed to including the comment _and_ using
xsize_t() to do the cast, giving us an assertion that the comment is
correct.

-Peff
