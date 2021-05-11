Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C8C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2663E61626
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232127AbhEKTIh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:08:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:51092 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232082AbhEKTI1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:08:27 -0400
Received: (qmail 24173 invoked by uid 109); 11 May 2021 19:07:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 May 2021 19:07:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26985 invoked by uid 111); 11 May 2021 19:07:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 15:07:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 15:07:19 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJrV52HOv0mlbJB1@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net>
 <CAN0heSp6uw7yqNZLD5w13xJUgnUtgHM0OYw9KQ6Z-FKk+x4OPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSp6uw7yqNZLD5w13xJUgnUtgHM0OYw9KQ6Z-FKk+x4OPA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 11, 2021 at 08:45:10PM +0200, Martin Ågren wrote:

> > That does make things a little less convenient; Debian stable, for
> > instance, still has 1.5.8. It's not too hard to install an updated gem,
> > but not quite as nice as using the system package (it also makes things
> > weird for building the stable Debian package itself, which would want to
> > rely only on other packages; but of course any proposed change to the
> > doc toolchain would be for new versions, and would not get backported
> > there anyway).
> 
> Right. And 1.5.8 is perfectly fine for ascidoctor *with* xmlto, i.e., as
> long as we're discussing moving away from asciidoc, not moving away from
> xmlto entirely. And soon enough, Debian stable should be at 2.12. ;-)
> (I realize Debian stable was just an example.)

Debian stable is just an example, but I also consider it a bit of a
benchmark for "reasonable". Surely there are people running RHEL6
somewhere in this world, but it's hard to care too much about them.

I think the transition you're proposing would probably take a while to
do, too. If we don't drop the python asciidoc support until close to the
end, then that buys a bit more time. Likewise, this isn't a hard limit
for OS support for users. The worst case is just making things slightly
more inconvenient for Git developers on older systems, because because
they might have to install an updated gem rather than using the system
package (you sometimes can end up in dependency hell for a gem upgrade
with versions of ruby, system libraries, etc, but I haven't found
asciidoctor particularly needy in that respect).

So I dunno. I certainly don't have a big complaint about _starting_ the
transition. If we can hold on to python asciidoc support (or even
old-asciidoctor + xmlto) for a while as a fallback, even if we know it's
slowly bitrotting, then it's possible nobody would even complain.

-Peff
