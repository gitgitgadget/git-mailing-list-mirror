Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF4C01F453
	for <e@80x24.org>; Wed, 31 Oct 2018 23:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbeKAIBm (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 04:01:42 -0400
Received: from 0x63.nu ([109.74.10.199]:50578 "EHLO 0x63.nu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbeKAIBm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 04:01:42 -0400
Received: from localhost ([127.0.0.1] helo=moveme2)
        by 0x63.nu with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anders@0x63.nu>)
        id 1gHzUP-0004Id-D3; Thu, 01 Nov 2018 00:01:29 +0100
References: <20181028125025.30952-1-anders@0x63.nu> <20181029141402.GA17668@sigill.intra.peff.net> <CADsOX3Cbn7jjqFERptxMm59mn0qYnkf9bmFvJS20VBPedZHwqQ@mail.gmail.com> <20181031202708.GA13021@sigill.intra.peff.net>
User-agent: mu4e 0.9.18; emacs 26.0.91
From:   Anders Waldenborg <anders@0x63.nu>
To:     Jeff King <peff@peff.net>
Cc:     Olga Telezhnaya <olyatelezhnaya@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] pretty: Add %(trailer:X) to display single trailer
In-reply-to: <20181031202708.GA13021@sigill.intra.peff.net>
Date:   Thu, 01 Nov 2018 00:01:28 +0100
Message-ID: <87a7mtlnzr.fsf@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: anders@0x63.nu
X-SA-Exim-Scanned: No (on 0x63.nu); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff King writes:

> On the other hand, if the rule were not "this affects the next
> placeholder" but had a true ending mark, then we could make a real
> parse-tree out of it, and format chunks of placeholders. E.g.:
>
>   %(format:lpad=30,filename)%(subject) %(authordate)%(end)
>
> would pad and format the whole string with two placeholders. I know that
> going down this road eventually involves reinventing XML, but I think
> having an actual tree structure may not be an unreasonable thing to
> shoot for.

Yes. I'm thinking that with [] for formatting specifiers and () for
placeholders, {} would be available for nesting. E.g:

   %[lpad=30,mangle]{%(subject) %ad%}


> My main concern for now is to avoid introducing new
> syntax that we'll be stuck with forever, even though it may later become
> redundant (or worse, create parsing ambiguities).

Agreed.

I'm planning to work on the initial "trailer:key=" part later this
week. Maybe I can play around with different formatting options and see
how it affects the parser.
