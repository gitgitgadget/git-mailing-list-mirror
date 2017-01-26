Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF04A1F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752791AbdAZOc4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 09:32:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:45321 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752757AbdAZOcz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 09:32:55 -0500
Received: (qmail 4813 invoked by uid 109); 26 Jan 2017 14:32:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 14:32:55 +0000
Received: (qmail 23402 invoked by uid 111); 26 Jan 2017 14:32:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 Jan 2017 09:32:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 Jan 2017 09:32:53 -0500
Date:   Thu, 26 Jan 2017 09:32:53 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Aguilar <davvid@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: Fixing the warning about warning(""); was: Re: [PATCH]
 difftool.c: mark a file-local symbol with static
Message-ID: <20170126143252.ne533mcv3n2ksbai@sigill.intra.peff.net>
References: <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
 <20170122052608.tpr5pihfgafhoynj@gmail.com>
 <20170124142346.u3d7l6772mtkgpcf@sigill.intra.peff.net>
 <xmqqlgu0ceia.fsf@gitster.mtv.corp.google.com>
 <20170124230500.h3fasbvutjkkke5h@sigill.intra.peff.net>
 <alpine.DEB.2.20.1701251135090.3469@virtualbox>
 <20170125183542.pe5qolexqqx6jhsi@sigill.intra.peff.net>
 <xmqq7f5iakxw.fsf@gitster.mtv.corp.google.com>
 <20170125220101.et67ebkumsqosaku@sigill.intra.peff.net>
 <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <546179e0-1d6e-86f7-00cf-e13218b76de1@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 26, 2017 at 07:39:55AM +0100, Johannes Sixt wrote:

> Am 25.01.2017 um 23:01 schrieb Jeff King:
> > +#pragma GCC diagnostic ignored "-Wformat-zero-length"
> 
> Last time I used #pragma GCC in a cross-platform project, it triggered an
> "unknown pragma" warning for MSVC. (It was the C++ compiler, I don't know if
> the C compiler would also warn.) It would have to be spelled like this:
> 
> #pragma warning(disable: 4068)   /* MSVC: unknown pragma */
> #pragma GCC diagnostic ignored "-Wformat-zero-length"
> 
> Dscho mentioned that he's compiling with MSVC. It would do him a favor.

Bleh. The point of #pragma is to ignore ones you don't know about.

It would be easy to wrap it in an #ifdef for __GNUC__ (there is already
a similar pragma with similar wrapping in the code base).

Anyway. I do not want to make life harder for anyone. I think there are
several options floating around now, so I will let Junio decide which
one he wants to pick up.

-Peff
