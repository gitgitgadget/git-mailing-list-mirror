Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24BE2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755103AbcIOTiL (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 15:38:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:43894 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755084AbcIOTiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 15:38:09 -0400
Received: (qmail 24720 invoked by uid 109); 15 Sep 2016 19:38:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 19:38:08 +0000
Received: (qmail 11930 invoked by uid 111); 15 Sep 2016 19:38:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Sep 2016 15:38:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Sep 2016 12:38:04 -0700
Date:   Thu, 15 Sep 2016 12:38:04 -0700
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] use strbuf_addstr() for adding constant strings to a
 strbuf, part 2
Message-ID: <20160915193804.d2mmmeard2rj6vye@sigill.intra.peff.net>
References: <f7294ac5-8302-03fb-d756-81a1c029a813@web.de>
 <20160915184448.awipvg2kmlq7weei@sigill.intra.peff.net>
 <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbmzpnex4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 15, 2016 at 12:25:43PM -0700, Junio C Hamano wrote:

> >> Silly question: Is there a natural language that uses percent signs
> >> as letters or e.g. instead of commas? :)
> >
> > I don't know, but if they do, they'd better get used to escaping them.
> > :)
> 
> I do not know either, but I am curious where that question comes
> from.  I stared at this patch for a few minutes but couldn't guess.

My initial thought is that the next step after picking this low-hanging
fruit would be to find cases where the strings do not contain "%", and
thus we do not have to care about formatting. But a case like:

  strbuf_addf(&buf, "this does not have any percents!", foo);

is simply broken (albeit in a way that we ignore foo, so it's just ugly
code, not a real bug).

So I dunno. I too am curious.

-Peff
