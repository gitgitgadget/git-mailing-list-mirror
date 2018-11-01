Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AFBE1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 18:42:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeKBDqb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 23:46:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:36788 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726190AbeKBDqa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 23:46:30 -0400
Received: (qmail 32464 invoked by uid 109); 1 Nov 2018 18:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 01 Nov 2018 18:42:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27121 invoked by uid 111); 1 Nov 2018 18:41:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 01 Nov 2018 14:41:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Nov 2018 14:42:19 -0400
Date:   Thu, 1 Nov 2018 14:42:19 -0400
From:   Jeff King <peff@peff.net>
To:     Anders Waldenborg <anders@0x63.nu>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] pretty: Add %(trailer:X) to display single trailer
Message-ID: <20181101184219.GA2918@sigill.intra.peff.net>
References: <20181028125025.30952-1-anders@0x63.nu>
 <20181029141402.GA17668@sigill.intra.peff.net>
 <CADsOX3Cbn7jjqFERptxMm59mn0qYnkf9bmFvJS20VBPedZHwqQ@mail.gmail.com>
 <20181031202708.GA13021@sigill.intra.peff.net>
 <87a7mtlnzr.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7mtlnzr.fsf@0x63.nu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 01, 2018 at 12:01:28AM +0100, Anders Waldenborg wrote:

> Jeff King writes:
> 
> > On the other hand, if the rule were not "this affects the next
> > placeholder" but had a true ending mark, then we could make a real
> > parse-tree out of it, and format chunks of placeholders. E.g.:
> >
> >   %(format:lpad=30,filename)%(subject) %(authordate)%(end)
> >
> > would pad and format the whole string with two placeholders. I know that
> > going down this road eventually involves reinventing XML, but I think
> > having an actual tree structure may not be an unreasonable thing to
> > shoot for.
> 
> Yes. I'm thinking that with [] for formatting specifiers and () for
> placeholders, {} would be available for nesting. E.g:
> 
>    %[lpad=30,mangle]{%(subject) %ad%}

Hmm. That's kind of ugly, but probably not really any uglier than any of
the things I showed. And it has the advantage that we could implement
%[] now, and later extend it (well, I guess we'd want to make sure that
"%[lpad=30]{foo}" does not treat the curly braces literally, since we'd
eventually make them syntactically significant).

> I'm planning to work on the initial "trailer:key=" part later this
> week. Maybe I can play around with different formatting options and see
> how it affects the parser.

Great! Thanks for working on this.

-Peff
