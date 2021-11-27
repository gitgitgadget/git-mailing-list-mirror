Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85010C433EF
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 05:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbhK0FKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 00:10:25 -0500
Received: from cloud.peff.net ([104.130.231.41]:38638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229450AbhK0FIY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 00:08:24 -0500
Received: (qmail 16971 invoked by uid 109); 27 Nov 2021 05:05:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Nov 2021 05:05:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10357 invoked by uid 111); 27 Nov 2021 05:05:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 27 Nov 2021 00:05:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 27 Nov 2021 00:05:05 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Dmitry Marakasov <amdmi3@amdmi3.ru>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: pull.rebase config option broken in 2.33.1
Message-ID: <YaG8gUnikxtQs5zx@coredump.intra.peff.net>
References: <YYFEE/2g3SiM04zx@hades.panopticon>
 <YYFJEASSimMhEsYz@coredump.intra.peff.net>
 <YaEh+k2q+9LoLXNh@hades.panopticon>
 <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
 <YaFViM1tTTAc48ZG@coredump.intra.peff.net>
 <CABPp-BGC5DrArqWMiwwpJQgK8WucVcAxj0Ptgpi+_KRb7V7Nwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BGC5DrArqWMiwwpJQgK8WucVcAxj0Ptgpi+_KRb7V7Nwg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 02:43:44PM -0800, Elijah Newren wrote:

> On Fri, Nov 26, 2021 at 1:45 PM Jeff King <peff@peff.net> wrote:
> >
> > On Fri, Nov 26, 2021 at 04:44:52PM -0500, Jeff King wrote:
> >
> > > +cc Alex and Elijah from the original 3d5fc24dae (pull: abort if
> > > --ff-only is given and fast-forwarding is impossible, 2021-07-21) in
> > > case they have further thoughts, but I _think_ this is working as
> > > designed.
> >
> > Whoops, forgot the cc. Original message in full below.
> 
> I believe this was already fixed in 2.34.1 in commit ea1954af77
> ("pull: should be noop when already-up-to-date", 2021-11-17).

I thought that at first, too, but this case is a bit different:

> > > In the bug I linked (and what got fixed in 2.34.1), the issue is that
> > > when the local branch is ahead of the remote, we don't say "up to date",
> > > but complain about fast-forwards.
> > >
> > > It's hard to tell from the output above, but it looks like you have a
> > > case where there are new commits both locally and on the remote? In
> > > which case a rebase would work just fine.

I think the key thing here is that (AFAICT) the behavior is unchanged
unless the user has set pull.ff=only explicitly.

-Peff
