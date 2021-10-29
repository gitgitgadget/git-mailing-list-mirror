Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4903C433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D3D60FC3
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 22:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhJ2WD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 18:03:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:49920 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231173AbhJ2WD1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 18:03:27 -0400
Received: (qmail 24006 invoked by uid 109); 29 Oct 2021 22:00:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Oct 2021 22:00:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23724 invoked by uid 111); 29 Oct 2021 22:00:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 Oct 2021 18:00:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 Oct 2021 18:00:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com,
        "Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] wrapper: remove xunsetenv()
Message-ID: <YXxvGfelee1pURQ7@coredump.intra.peff.net>
References: <20211029212705.31721-1-carenas@gmail.com>
 <YXxpjLhiguq4HY6g@coredump.intra.peff.net>
 <YXxs4NZmpjhRkoYA@coredump.intra.peff.net>
 <xmqqbl37ijc7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbl37ijc7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 02:58:48PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > However, according to the unsetenv() manpage:
> >
> >   Prior to glibc 2.2.2, unsetenv() was prototyped as returning void;
> >   more recent glibc versions follow the POSIX.1-compliant prototype
> >   shown in the SYNOPSIS.
> >
> > So it is POSIX to return an int, but that gives us at least one platform
> > where unsetenv() returns void (or used to). glibc 2.2.2 is 2001-era, so
> > that may be old enough that we don't care. But it makes me wonder if
> > other older or obscure platforms will run into this.
> 
> Ahh, OK.  Well, we will hear from them soon enough.  It is not like
> this is anything urgent.

Yeah, I am OK proceeding along those lines, and seeing if anybody
screams (though perhaps dropping xunsetenv() for -rc0 makes sense in the
interim).

-Peff
