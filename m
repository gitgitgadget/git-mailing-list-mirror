Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29821C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F4622BED
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgHCSI0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:08:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:46342 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCSI0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:08:26 -0400
Received: (qmail 28114 invoked by uid 109); 3 Aug 2020 18:08:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 03 Aug 2020 18:08:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2187 invoked by uid 111); 3 Aug 2020 18:08:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 03 Aug 2020 14:08:25 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 3 Aug 2020 14:08:24 -0400
From:   Jeff King <peff@peff.net>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
Message-ID: <20200803180824.GA2711830@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
 <20200729201002.GA2989059@coredump.intra.peff.net>
 <871rku3soc.fsf@osv.gnss.ru>
 <20200731230858.GA1461090@coredump.intra.peff.net>
 <87mu3drynx.fsf@osv.gnss.ru>
 <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
 <87o8nrybnb.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o8nrybnb.fsf@osv.gnss.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 06:47:20PM +0300, Sergey Organov wrote:

> > A command line option that takes _optional_ argument is evil; it
> > hurts teachability (e.g. "why does this option always require
> > "--opt=val" and refuses '--opt val'?").
> 
> Yeah, I sympathize.

Sorry, the optional argument was my suggestion. I don't think they're
that evil, but I agree they require extra knowledge for the user. I
don't mind avoiding them when possible (and it's definitely possible
here).

> > Introduce --diff-parent=(none|<parent-number>|c|cc|all) that is
> > different from --diff-merges, and -m and --[no-]diff-merges can be
> > defined in terms of that, at which point we can gradually deprecate
> > them if we wanted to, no?
> 
> Sounds great, I only hoped we can do it right now, with this new
> --diff-merges option, maybe as a pre-requisite to the patches in
> question, but Jeff said it's too late, dunno why.

It's too late for "-m" to change semantics (we could do a long
deprecation, but I don't see much point in doing so). But --diff-merges
is definitely still changeable until we release v2.29. My resistance was
mostly that I didn't want to complicate my series by adding new
elements. But we could do something on top.

-Peff
