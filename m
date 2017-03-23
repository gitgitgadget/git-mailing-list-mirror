Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5C020958
	for <e@80x24.org>; Thu, 23 Mar 2017 19:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754298AbdCWTjh (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 15:39:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:50515 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756036AbdCWTj1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 15:39:27 -0400
Received: (qmail 14859 invoked by uid 109); 23 Mar 2017 19:39:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 19:39:21 +0000
Received: (qmail 10063 invoked by uid 111); 23 Mar 2017 19:39:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Mar 2017 15:39:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Mar 2017 15:39:19 -0400
Date:   Thu, 23 Mar 2017 15:39:19 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] refs.c: use skip_prefix() in prettify_refname()
Message-ID: <20170323193919.twwfwdoulo2hjz24@sigill.intra.peff.net>
References: <20170323155012.6148-1-szeder.dev@gmail.com>
 <4382e211-63f6-811f-6f33-1cf5d2c087a8@web.de>
 <20170323192313.ytr56pjpnillnh63@sigill.intra.peff.net>
 <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqvaqzbxfx.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2017 at 12:33:06PM -0700, Junio C Hamano wrote:

> >> Nice, but why add the "if" when it's doing nothing?
> >
> > It's short-circuiting in the conditional.
> 
> I think René meant this:
> 
>      /* just for side effects */
>      skip_prefix(name, "refs/heads/", &name) ||
>      skip_prefix(name, "refs/tags/", &name) ||
>      skip_prefix(name, "refs/remotes/", &name);
> 
>      return name;
> 
> which still short-sircuits, even though I do think it looks
> strange; "correct but strange".

And it causes the compiler to complain that the value is not used.

-Peff
