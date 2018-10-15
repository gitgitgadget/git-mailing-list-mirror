Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C5041F453
	for <e@80x24.org>; Mon, 15 Oct 2018 19:35:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbeJPDWG (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 23:22:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:41316 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726861AbeJPDWG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 23:22:06 -0400
Received: (qmail 23428 invoked by uid 109); 15 Oct 2018 19:35:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 15 Oct 2018 19:35:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2200 invoked by uid 111); 15 Oct 2018 19:34:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 15 Oct 2018 15:34:38 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2018 15:35:26 -0400
Date:   Mon, 15 Oct 2018 15:35:26 -0400
From:   Jeff King <peff@peff.net>
To:     Tao Qingyun <taoqy@ls-a.me>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        sbeller@google.com
Subject: Re: [PATCH] branch: trivial style fix
Message-ID: <20181015193525.GA8349@sigill.intra.peff.net>
References: <20181005095213.12509-1-taoqy@ls-a.me>
 <xmqqy3bcwdb4.fsf@gitster-ct.c.googlers.com>
 <87bm87x5z2.fsf@ls-a.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bm87x5z2.fsf@ls-a.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 06, 2018 at 08:40:33AM +0800, Tao Qingyun wrote:

> >> -	for (i = 0; i < argc; i++, strbuf_reset(&bname)) {
> >> +	for (i = 0; i < argc; i++) {
> >>  		char *target = NULL;
> >>  		int flags = 0;
> >>  
> >> +		strbuf_reset(&bname);
> >
> > This is not "trivial" nor "style fix", though.
> >
> > It is not "trivial" because it also changes the behaviour.  Instead
> > of resetting the strbuf each time after the loop body runs, the new
> > code resets it before the loop body, even for the 0-th iteration
> > where the strbuf hasn't even been used at all.  It is not a "style
> > fix" because we do not have a particular reason to avoid using the
> > comma operator to perform two simple expressions with side effects
> > inside a single expression.
> >
> Thank you and Jeff for your explanation. I think I get the point now.
> 
> The third part of `for` statement is normally for a step. I think it's
> improve readability even it does nothing in the first iteration.
> 
> And, should I drop this part and resend the patch? I'm a newbie :).

Sorry for the slow reply. For some reason I do not think your message
here made it to the list (but I don't see anything obviously wrong with
it).

Anyway, yes, I think it is worth dropping this hunk and re-sending the
else-if style fix as a separate patch (you may choose to re-send this
hunk as its own patch, too, if you want to argue for its inclusion, but
there is no sense in holding the actual style fix hostage).

-Peff
