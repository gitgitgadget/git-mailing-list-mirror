Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8265C433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B418A64D5D
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 01:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhBWBtL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 20:49:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:40992 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230318AbhBWBtK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 20:49:10 -0500
Received: (qmail 22676 invoked by uid 109); 23 Feb 2021 01:48:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 01:48:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21289 invoked by uid 111); 23 Feb 2021 01:48:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 20:48:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 20:48:28 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wang Yugui <wangyugui@e16-tech.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs/format-patch: mention handling of merges
Message-ID: <YDRe7AAOnHPmAhp4@coredump.intra.peff.net>
References: <20210222211621.0C5D.409509F4@e16-tech.com>
 <YDQ27qbbblPfLCpU@coredump.intra.peff.net>
 <YDQ5YIeXGiR5nvLH@coredump.intra.peff.net>
 <xmqqv9aj65na.fsf@gitster.g>
 <YDRA6RJdnFne2EBw@coredump.intra.peff.net>
 <xmqqblcb60fz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblcb60fz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 05:24:16PM -0800, Junio C Hamano wrote:

> > I think one could argue that any merge information (including conflict
> > resolution) works against the root notion of format-patch, which is a
> > set of changes that can be applied on a range of basesa.
> 
> That's true and it was the primary motive for omiting merges.
> 
> > But even that I
> > would be hesitant to commit to (since --base exists now).
> 
> I am not quite sure what --base has to throw into the equation.  The
> information --base gives is often useful when I want to learn where
> the patches were taken from, but that does not restrict where the
> patches are actually applied to in any meaningful way (iow, "on a
> range of bases" part is not affected).

What I meant is that without "--base", telling somebody "here is the
merge you should replay on top of these other patches" is virtually
meaningless. You cannot know what the merge base would be! So you might
be merging in other random crap, and you might or might not see the same
conflicts.

But in a world with --base, I can imagine some people recreating whole
sequences of the history graph by using "--base" along with some (to be
invented) format for representing a merge via email. That mode would
certainly not be the default, but at least at that point it is
conceivably useful. Sort of like a bundle, but more human-readable (it
would also need committer info to recreate the commit ids perfectly, of
course).

All of which meant only to argue that "it is not possible or not useful
to represent a merge in an email" is something that could change in the
future. :)

-Peff
