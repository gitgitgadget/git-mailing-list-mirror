Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5661F206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 12:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750999AbcLLMPy (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 07:15:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:55119 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750712AbcLLMPx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 07:15:53 -0500
Received: (qmail 3704 invoked by uid 109); 12 Dec 2016 12:15:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 12:15:52 +0000
Received: (qmail 5760 invoked by uid 111); 12 Dec 2016 12:16:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Dec 2016 07:16:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Dec 2016 07:15:49 -0500
Date:   Mon, 12 Dec 2016 07:15:49 -0500
From:   Jeff King <peff@peff.net>
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v8 18/19] branch: use ref-filter printing APIs
Message-ID: <20161212121548.aj2ptnmrqt67anlc@sigill.intra.peff.net>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
 <20161207153627.1468-19-Karthik.188@gmail.com>
 <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net>
 <CAOLa=ZSPDLwziGEvyixebAkS2M1JMYidQNHfDbnmYarFCjn80A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSPDLwziGEvyixebAkS2M1JMYidQNHfDbnmYarFCjn80A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 04:50:20PM +0530, Karthik Nayak wrote:

> > This caller never stores the return value, and it ends up leaking. So I
> > wonder if you wanted "static struct strbuf" in the first place (and that
> > would explain the strbuf_reset() in your function).
> 
> Ah! Yes this should be 'static struct strbuf' indeed, I blindly copied Junio's
> suggestion.
> 
> strbuf_detach() is also a better way to go.

One of the other, though. If it's static, then you _don't_ want to
detach.

-Peff
