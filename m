Return-Path: <SRS0=mvrS=AI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857E3C433E0
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 03:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A42820773
	for <git@archiver.kernel.org>; Sat, 27 Jun 2020 03:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgF0DFe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 23:05:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:44476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgF0DFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 23:05:34 -0400
Received: (qmail 13880 invoked by uid 109); 27 Jun 2020 03:05:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 27 Jun 2020 03:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1224 invoked by uid 111); 27 Jun 2020 03:05:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Jun 2020 23:05:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Jun 2020 23:05:32 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek <chris.torek@gmail.com>,
        Craig H Maynard <chmaynard@me.com>, git@vger.kernel.org
Subject: Re: Regarding Git and Branch Naming
Message-ID: <20200627030532.GA1187031@coredump.intra.peff.net>
References: <B4814F42-7AF8-4D80-93D4-FAF752C72F21@me.com>
 <CAPx1GvcZk2o7f8-27xokwxUayWwO+t5qdsMjLrjBymc+WHznmw@mail.gmail.com>
 <20200626203539.GA1173768@coredump.intra.peff.net>
 <xmqq7dvth6xy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7dvth6xy.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 02:07:37PM -0700, Junio C Hamano wrote:

> >   $ git init
> >   $ git add some-files
> >   $ git commit -m whatever
> >   fatal: HEAD does not point to any branch
> >   hint: use "git checkout -b <branch>" to make commits on <branch>
> 
> ... or you could stay forever on detached HEAD state.
> 
> Very briefly in early days of Git, the envisioned use case (which
> quickly was retracted) was to use one repository per one line of
> development (so you'd pull among the repositories you have, and each
> repository does not even need to have "the default" branch---there
> was no need for any branch).  Staying forever on detached HEAD is
> pretty much in line with that.

Given the difficulties many users seem to have with understanding
detached HEADs, I think that might be even more unfriendly. :)

> > Perhaps that's not _too_ bad, but it feels a bit unfriendly (and
> > definitely more likely to cause backwards compatibility issues than
> > picking _some_ default name). There would also be a lot of corner cases
> > to cover and debug (e.g., "git checkout foo" moving away from the "no
> > branch" state should make the usual complaints if we'd have to overwrite
> > or modify index and untracked files).
> 
> I do not see much point in adding such a new set-up, only to risk
> introducing unexpected and unnecessary bugs.  Such extra engineering
> resource is better spent elsewhere, I would say.

Yeah, agreed.

-Peff
