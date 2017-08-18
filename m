Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C80D91F667
	for <e@80x24.org>; Fri, 18 Aug 2017 11:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750949AbdHRLuU (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 07:50:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:42572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750808AbdHRLuT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 07:50:19 -0400
Received: (qmail 3946 invoked by uid 109); 18 Aug 2017 11:50:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 11:50:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1575 invoked by uid 111); 18 Aug 2017 11:50:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 Aug 2017 07:50:45 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Aug 2017 07:50:17 -0400
Date:   Fri, 18 Aug 2017 07:50:17 -0400
From:   Jeff King <peff@peff.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 2/4] commit: replace the raw buffer with strbuf in
 read_graft_line
Message-ID: <20170818115017.cji4r5nrdetumtqo@sigill.intra.peff.net>
References: <cover.1503020338.git.patryk.obara@gmail.com>
 <65f84c5eb94e8b6f5cbce31f56810fdb71a58bf9.1503020338.git.patryk.obara@gmail.com>
 <20170818062929.f4zitbtaeii4xiko@sigill.intra.peff.net>
 <CAJfL8+TRZQrfF9Y9PdBZTptEf_O9u9irVRzb0bBVAnTRga2xmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJfL8+TRZQrfF9Y9PdBZTptEf_O9u9irVRzb0bBVAnTRga2xmw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 18, 2017 at 12:12:37PM +0200, Patryk Obara wrote:

> Jeff King <peff@peff.net> wrote:
> 
> > AFAICT this is only here to avoid having to s/buf/line->buf/ in the rest
> > of the function. But I think we should just make that change (you
> > already did in some of the spots). And IMHO we should do the same for
> > line->len. When there are two names for the same value, it increases the
> > chances of a bug where the two end up diverging.
> 
> My motivation was rather to keep patch(es) as small as possible because every
> line using buf will be replaced in a later patch in series. But it will make
> commit better (it will stand on its own), so why not to do it? :)

Ah, I didn't notice those lines went away. That does make it less bad,
but I do think it's easier to review if each commit stands on its own.

In some cases, if it's really painful to do the intermediate cleanup, I
might say something in the commit message like "this leaves X that is
not ideal, but we'll be getting rid of it soon anyway". But in this case
I think just creating that intermediate state is simple enough.

> Ah, I only replaced comparison to NULL terminator with length check because
> I thought it better shows intention of the code and I didn't notice, that
> reversing order will result in better code overall.
> 
> I will include both changes in v4.

Thanks.

-Peff
