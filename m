Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B880BC76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 09:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjDKJZI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjDKJZG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 05:25:06 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7912C194
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:25:04 -0700 (PDT)
Received: (qmail 6752 invoked by uid 109); 11 Apr 2023 09:25:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Apr 2023 09:25:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5818 invoked by uid 111); 11 Apr 2023 09:25:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Apr 2023 05:25:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 11 Apr 2023 05:25:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH] date: remove approxidate_relative()
Message-ID: <20230411092502.GA398350@coredump.intra.peff.net>
References: <f5b9a290-7cec-7a83-660b-e15494d2cdc8@web.de>
 <xmqqjzyjemji.fsf@gitster.g>
 <20230410202536.GE104097@coredump.intra.peff.net>
 <b17e05d5-deda-527f-1587-9f1cd7046a0b@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b17e05d5-deda-527f-1587-9f1cd7046a0b@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 10:52:01PM +0200, René Scharfe wrote:

> Am 10.04.23 um 22:25 schrieb Jeff King:
> >
> > I'm not sure of the least-confusing way to address a single hunk, though
> > (by line number is one option, by hunk-number within the patch is
> > another). I suspect the best workflow for a user would be to
> > interactively say "show me more context for this hunk". Some viewers
> > have support for that (e.g., GitHub's web view of a diff). But handling
> > that for a one-shot CLI program is tricky, not to mention then feeding
> > it back to format-patch to generate the output you want to send. :)
> 
> So basically you propose a format-patch --interactive mode that shows
> each hunk and allows extending its context.  This could work.  For hunks
> that span multiple screens it might be a bit iffy -- or perhaps not, if
> the scrollback buffer of the terminal or console is big enough.

Well, less proposing and more thinking out loud. :)

One thing that I think would make it awkward is that some people (well,
me at least) tend to show diffs repeatedly. So I might look at a diff
several times, and then even run format-patch multiple times as part of
my workflow of sending it. Interactively expanding the diff each time,
and then losing that result, would be annoying.

So an interactive tool that somehow output "oh, and here are some
parameters you can feed back to get the same view" would be my ideal.

-Peff
