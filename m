Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0FDC433ED
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8053361221
	for <git@archiver.kernel.org>; Wed, 12 May 2021 00:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhELAgm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 20:36:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:51608 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229637AbhELAgm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 20:36:42 -0400
Received: (qmail 25195 invoked by uid 109); 12 May 2021 00:35:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 May 2021 00:35:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30636 invoked by uid 111); 12 May 2021 00:35:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 May 2021 20:35:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 May 2021 20:35:34 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Gregory Anders <greg@gpanders.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] git-send-email: use ! to indicate relative path to
 command
Message-ID: <YJsi1jbtNFDRKXmq@coredump.intra.peff.net>
References: <20210511204044.69047-1-greg@gpanders.com>
 <20210511234935.65147-1-greg@gpanders.com>
 <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJsas0d4XPsYYpI7@camp.crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 12, 2021 at 12:00:51AM +0000, brian m. carlson wrote:

> > +	specify a sendmail-like program instead, either by a full
> > +	path-name or by prefixing the program name with `!`.  The
> > +	program must support the `-i` option.  Default value can be
> > +	specified by the `sendemail.smtpServer` configuration option;
> > +	the built-in default is to search for `sendmail` in `/usr/sbin`,
> > +	`/usr/lib` and $PATH if such program is available, falling back
> > +	to `localhost` otherwise.
> 
> Elsewhere we use the ! syntax we invoke the shell, and I would suggest
> that we do the same here.  That means we'll get PATH functionality by
> default and we'll let people do a modicum of scripting if they like.

Thanks for bringing that up. I agree it makes things more consistent
with other uses of "!", and certainly it's more flexible. It does
introduce an inconsistency with the absolute-path form, as I mentioned
in https://lore.kernel.org/git/YJsiKDNbKclFU00b@coredump.intra.peff.net/.

I don't know if that's a show-stopper or not. Certainly the
documentation can explain the difference, but it's nice to keep the
rules as simple as possible.

(My gut feeling is that consistency with other "!" places is more
important than consistency with the absolute-path form).

-Peff
