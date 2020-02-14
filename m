Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB96FC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB9602187F
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 16:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393197AbgBNQn7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:43:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:43560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2392317AbgBNQn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 11:43:58 -0500
Received: (qmail 22314 invoked by uid 109); 14 Feb 2020 16:43:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Feb 2020 16:43:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22660 invoked by uid 111); 14 Feb 2020 16:52:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Feb 2020 11:52:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Feb 2020 11:43:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Subject: Re: How to force configure script to use curl ?
Message-ID: <20200214164357.GA652734@coredump.intra.peff.net>
References: <A0910AA2-D24B-4DF5-8D39-8E2D8B56955B@gmail.com>
 <20200214061714.GA605125@coredump.intra.peff.net>
 <xmqqh7ztp1tz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh7ztp1tz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 14, 2020 at 08:31:52AM -0800, Junio C Hamano wrote:

> > Either of those will override the NO_CURL setting done by the configure
> > script (you can see the full list of knobs set by configure in
> > config.mak.autogen).
> 
> Heh, I didn't even know that things were expected to work if you
> further tweak ./configure generated settings.

I always assume the order of includes was intentional to provide a
priority from low to high:

  - platform defaults in config.mak.uname

  - auto-detected defaults in config.mak.autogen

  - explict user-provided settings in config.mak

  - command-line overrides when you're trying to debug something. ;)

The last one is due to "make" being sensible, but the rest come from our
order in the Makefile.

-Peff
