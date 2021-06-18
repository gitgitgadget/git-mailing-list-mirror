Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3448C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6ECE613EB
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 13:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbhFRN23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:28:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:59952 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233737AbhFRN22 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 09:28:28 -0400
Received: (qmail 26742 invoked by uid 109); 18 Jun 2021 13:26:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Jun 2021 13:26:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15400 invoked by uid 111); 18 Jun 2021 13:26:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Jun 2021 09:26:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 18 Jun 2021 09:26:18 -0400
From:   Jeff King <peff@peff.net>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] doc: warn people against --max-pack-size
Message-ID: <YMye+mkRPD0BkULX@coredump.intra.peff.net>
References: <776cb2f9-5fef-4486-5aef-f3ee62fcda7e@gmail.com>
 <YL8RfGijMY95miHI@coredump.intra.peff.net>
 <xmqqfsxsq1l4.fsf@gitster.g>
 <YL8bQMOAHxApjVVe@coredump.intra.peff.net>
 <d73194b2-2fc9-80d3-d13c-fb5db3757e01@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d73194b2-2fc9-80d3-d13c-fb5db3757e01@iee.email>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 17, 2021 at 06:02:27PM +0100, Philip Oakley wrote:

> On 08/06/2021 08:24, Jeff King wrote:
> > +The minimum size allowed is limited to 1 MiB. The default is unlimited.
> > +Common unit suffixes of 'k', 'm', or 'g' are supported.
> 
> Do we want to include the workaround of scaling in kibibytes (as
> originally mentioned by Bagas) for the default as 1024k? This also
> avoids the easy mistake that the size is in multiples MiB.

I'm not quite sure what you're asking. If you mean: should we tell
people that they can't use "4.9m" and should instead use "5017k"
instead, then I don't have a strong opinion.

It might help some people. But OTOH it's not clear to me that this is a
common question, so it might clutter up the documentation. Either way,
it's orthogonal to the patch in question, and should come on top if
somebody cares to work on it.

I'd also be fine with somebody actually implementing fractional unit
support (it would probably go into git_parse_signed() and
git_parse_unsigned()). It doesn't seem worth the effort to me, but if
somebody feels strongly enough to implement it cleanly, I wouldn't say
no. :)

-Peff
