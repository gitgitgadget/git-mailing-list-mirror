Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEC4C64E8A
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33A3221F9
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 01:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727748AbgLBB6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:58:06 -0500
Received: from cloud.peff.net ([104.130.231.41]:48218 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgLBB6G (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 20:58:06 -0500
Received: (qmail 29795 invoked by uid 109); 2 Dec 2020 01:57:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Dec 2020 01:57:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2827 invoked by uid 111); 2 Dec 2020 01:57:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 20:57:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 20:57:25 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        emilyshaffer@google.com
Subject: Re: [PATCH v2] builtin/bugreport.c: use thread-safe localtime_r()
Message-ID: <X8b0he9VVI5s1log@coredump.intra.peff.net>
References: <27fc158339c91f56210f00dae9015da1d6c781ec.1606777520.git.me@ttaylorr.com>
 <73eb4965807ea2fdf94f815a8f8a2b036296ecca.1606782566.git.me@ttaylorr.com>
 <X8WqFynk23yWT6E3@coredump.intra.peff.net>
 <xmqqlfehqt4n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfehqt4n.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 10:27:20AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We might also want to do this on top:
> >
> > -- >8 --
> > Subject: [PATCH] banned.h: mark non-reentrant gmtime, etc as banned
> 
> I see the patch does more than what subject describes.  
> 
> I am not opposed to banning ctime_r() and asctime_r(), but I do not
> want to see our future readers wonder why they are banned by the
> commit whose title clearly states that we refuse non-reentrant ones
> in our codebase.

Well, not more than the overall commit message describes. :)

But yeah, the split in what you re-sent is just fine with me. Thanks for
saving a round-trip. I see you already fixed up the typo in the second
one pointed out by Eric, but I think there is another:

  s/stftime/strftime/

-Peff
