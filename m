Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57D992013D
	for <e@80x24.org>; Tue, 14 Feb 2017 05:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbdBNFOH (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 00:14:07 -0500
Received: from cloud.peff.net ([104.130.231.41]:54859 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdBNFOG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 00:14:06 -0500
Received: (qmail 7621 invoked by uid 109); 14 Feb 2017 05:14:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 05:14:06 +0000
Received: (qmail 340 invoked by uid 111); 14 Feb 2017 05:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 00:14:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 00:14:03 -0500
Date:   Tue, 14 Feb 2017 00:14:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Arif Khokar <arif.i.khokar@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Arif Khokar <arif_khokar@hotmail.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        "meta@public-inbox.org" <meta@public-inbox.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Eric Wong <e@80x24.org>
Subject: Re: Working with public-inbox.org [Was: [PATCH] rev-parse: respect
 core.hooksPath in --git-path]
Message-ID: <20170214051403.jwqpxfyyi5mviah2@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1608181430280.4924@virtualbox>
 <20160819150340.725bejnps6474u2e@sigill.intra.peff.net>
 <46a5b9b6-f3f6-7650-8a5b-b0b52223e375@gmail.com>
 <DM5PR17MB1353EFB1F6FE3B05EFDF86DCD3EB0@DM5PR17MB1353.namprd17.prod.outlook.com>
 <alpine.DEB.2.20.1608241509200.4924@virtualbox>
 <alpine.DEB.2.20.1702101707060.3496@virtualbox>
 <d16546a4-25be-7b85-3191-e9393fda1164@hotmail.com>
 <xmqqefz1ew1h.fsf@gitster.mtv.corp.google.com>
 <acac96da-2404-4f7e-a83d-7648ca448d31@hotmail.com>
 <xmqqlgt99yeo.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgt99yeo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 13, 2017 at 08:41:51PM -0800, Junio C Hamano wrote:

> Arif Khokar <arif.i.khokar@gmail.com> writes:
> 
> > One concern I have regarding this idea is whether or not SMTP servers
> > typically replace a Message-Id header set by the client.
> 
> The clients are supposed to give Message-IDs, but because some
> clients fail to do so, SMTP server implementations are allowed to
> add an ID to avoid leaving a message nameless (IIRC, 6.3 in
> RFC2821).  So "replace" would be in violation.
> 
> But some parts of the world ignore RFCs, so...

I know there are some terrible servers out there, but I think we can
discount any such server as horribly broken. Rewriting message-ids would
cause threading problems any time the sender referred to their own
messages. So "format-patch --thread" would fail to work, and even
replying to your own message from your "sent" folder would fail.

-Peff
