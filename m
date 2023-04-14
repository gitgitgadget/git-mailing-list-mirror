Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2697C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjDNVpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDNVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:45:13 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF9510FA
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:45:11 -0700 (PDT)
Received: (qmail 23613 invoked by uid 109); 14 Apr 2023 21:45:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 14 Apr 2023 21:45:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31901 invoked by uid 111); 14 Apr 2023 21:45:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Apr 2023 17:45:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 14 Apr 2023 17:45:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] doc: set actual revdate for manpages
Message-ID: <20230414214508.GB640081@coredump.intra.peff.net>
References: <20230413074722.71260-1-felipe.contreras@gmail.com>
 <20230414070449.GA540206@coredump.intra.peff.net>
 <643949a57396c_5b7e62948d@chronos.notmuch>
 <xmqqildys97o.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqildys97o.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 09:46:19AM -0700, Junio C Hamano wrote:

> So, I "wasted" (not really---this was a fruitful validation that is
> a part of a review process) some time to play with this on top of

The word "wasted" is appearing in a lot of people's emails in this
thread. ;) So let me just clarify that in the original I meant that I
spent time puzzling over why it was not working, which was a waste
because Felipe had already said it required the other patch.

It definitely would have helped if he had explained _why_ the other
patch was necessary. But to be fair, the fault was at least as much mine
for not heeding what he did say.

But reviewers reproducing and tinkering is most certainly not a waste of
time in general, and I didn't mean to imply it was (or that the patch
itself was a waste of time).

> Formatted output from a repository working tree changes from
> "04/14/2023" to "2023-04-13".  The value change may be intended, but
> I am not sure if the format change was intended or even welcome.  If
> we want to correct the date format, it can totally be done in a
> separate patch, or a separate series even, with some justification
> in the proposed log message, I think.

I think the change is welcome and intended. I would not mind seeing the
two changes (format change, and using commit date versus "now")
conceptually split, but I think it's much more tangled. Asciidoctor is
already producing y-m-d dates, and python asciidoc is using m/d/y.
Changing the latter requires passing in not just a format but the actual
date. If we want it to be the current date, then we have to get that
from somewhere, which may introduce portability questions (e.g., can we
rely on "date"?).

So doing it all in one patch, though this conversation may indicate that
the commit message could do a better job of explaining the goal and
implications.

-Peff
