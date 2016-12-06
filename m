Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5DDA20259
	for <e@80x24.org>; Tue,  6 Dec 2016 09:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbcLFJjo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 04:39:44 -0500
Received: from continuum.iocl.org ([217.140.74.2]:52897 "EHLO
        continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751569AbcLFJjl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 04:39:41 -0500
Received: (from krey@localhost)
        by continuum.iocl.org (8.11.3/8.9.3) id uB69dUd07075;
        Tue, 6 Dec 2016 10:39:30 +0100
Date:   Tue, 6 Dec 2016 10:39:30 +0100
From:   Andreas Krey <a.krey@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] commit: make --only --allow-empty work without paths
Message-ID: <20161206093930.GE16188@inner.h.apk.li>
References: <20161202221513.GA5370@inner.h.apk.li> <20161203043254.7ozjyucfn6uivnsh@sigill.intra.peff.net> <20161203065949.GG19570@inner.h.apk.li> <20161203162318.uv27n4uhylobegto@sigill.intra.peff.net> <xmqqh96i3ygs.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh96i3ygs.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 05 Dec 2016 12:36:19 +0000, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > On Sat, Dec 03, 2016 at 07:59:49AM +0100, Andreas Krey wrote:
...
> >> Tool: git commit --allow-empty -m 'FIX: A-123'
> >
> > OK. I think "tool" is slightly funny here, but I get that is part of the
> > real world works. Thanks for illustrating.
> 
> I am not sure if I understand.  Why isn't the FIX: thing added to
> the commit being pulled by amending it?

Because we don't allow push -f on our blessed repo (bitbucket).
(Oops, answer to wrong question. But the integrators don't want
to meddle with dev's commits, either.)

This has multiple reasons:

- The percentage of people who can and would be willing
  to do rebase -i is small. (Not that they are likely to
  increase under this policy.)

- Our build tool record builds by commit id, and when
  you rebase (even if only for commit message edits)
  you lose your (simple) build history.

> Would the convention be for
> the responder of a pull-request to fetch and drop the tip commit?

No, they need to keep it as there is automation hinging on the FIX line.

I would much prefer people to do rebases/amends instead of this crutch,
but that's not for now.

Hmm, it just occurred to me that we might allow force pushes for specific
users to keep the foot-shooting ratio low.

- Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
