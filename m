Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A507020226
	for <e@80x24.org>; Thu,  4 Aug 2016 07:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbcHDHNi (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 03:13:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:54592 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750790AbcHDHNh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 03:13:37 -0400
Received: (qmail 11363 invoked by uid 102); 4 Aug 2016 07:13:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:13:39 -0400
Received: (qmail 10506 invoked by uid 107); 4 Aug 2016 07:14:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Aug 2016 03:14:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Aug 2016 03:13:34 -0400
Date:	Thu, 4 Aug 2016 03:13:34 -0400
From:	Jeff King <peff@peff.net>
To:	Stefan Beller <sbeller@google.com>
Cc:	Michael Haggerty <mhagger@alum.mit.edu>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 2/8] xdl_change_compact(): clarify code
Message-ID: <20160804071333.xs4ns7q7o4ykw7y3@sigill.intra.peff.net>
References: <cover.1470259583.git.mhagger@alum.mit.edu>
 <f4ce27f389b64c9ae503152c66d183c4a4a970f1.1470259583.git.mhagger@alum.mit.edu>
 <CAGZ79kZk+XW+Bwcx_fvOLVBDse_iUSjEa_K=eJqm4PpTsTAcPA@mail.gmail.com>
 <57715dee-ca73-c1bb-ee79-2813d7873649@alum.mit.edu>
 <CAGZ79kbyCRDTt4u+Fje819mNZZf3GkZtYVurwOMPXRfXqO-YEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kbyCRDTt4u+Fje819mNZZf3GkZtYVurwOMPXRfXqO-YEw@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 04:50:46PM -0700, Stefan Beller wrote:

> I was not asking for undoing these, but giving short cryptic answers myself. ;)
> While I agree the variable names are way better than before, the use of while
> instead of for (and then doing another final ++ after the loop) extended some
> one liners to about 5. I am totally fine with that as they are easier
> to read for me as I understand them as Git style, hence easier to read.

One thing I try to do with loops is to use "for" loops only when I truly
want an iteration from point A to point B. If I care about the value of
the iterator _after_ the loop, I prefer a "while" loop.

Not everybody necessarily has the same taste, but I assume Michael does,
since that's what's happening in this hunk:

> -               start = i;
> -               for (i++; rchg[i]; i++);
> -               for (; rchgo[io]; io++);
> +               start = i++;
> +
> +               while (rchg[i])
> +                       i++;
> +
> +               while (rchgo[io])
> +                      io++;

-Peff
