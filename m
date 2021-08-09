Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E286EC4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45DC60EE7
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 18:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhHISm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:42:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:42690 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232130AbhHISmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 14:42:25 -0400
Received: (qmail 2278 invoked by uid 109); 9 Aug 2021 18:42:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Aug 2021 18:42:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1814 invoked by uid 111); 9 Aug 2021 18:42:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Aug 2021 14:42:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Aug 2021 14:42:03 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Aug 2021, #03; Fri, 6)
Message-ID: <YRF2+7RqTAJ+/KZ3@coredump.intra.peff.net>
References: <xmqqzgtuf6r0.fsf@gitster.g>
 <CABPp-BFOusrK6E6n91XSXcKP8kin-8RX8L_HXdKRjS790HkwHQ@mail.gmail.com>
 <xmqqlf5afsgs.fsf@gitster.g>
 <CABPp-BHen70xN8fHZr_s61ix17qLq2iw3SFjP-GJmmEuMMF6rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHen70xN8fHZr_s61ix17qLq2iw3SFjP-GJmmEuMMF6rw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 09, 2021 at 11:39:57AM -0700, Elijah Newren wrote:

> On Mon, Aug 9, 2021 at 10:17 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> writes:
> >
> > > On Fri, Aug 6, 2021 at 6:26 PM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > >> * jt/push-negotiation-fixes (2021-07-15) 3 commits
> > >>  - fetch: die on invalid --negotiation-tip hash
> > >>  - send-pack: fix push nego. when remote has refs
> > >>  - send-pack: fix push.negotiate with remote helper
> > >>
> > >>  Bugfix for common ancestor negotiation recently introduced in "git
> > >>  push" codepath.
> > >>
> > >>  Needs review.
> > >
> > > I decided to take a look.
> [...]
> >
> > I am mostly worried about the lack of response to comments on [2/3],
> > especially to Peff's "Wouldn't this also be a problem for
> > multi-round fetch?".
> 
> Oh, I read Peff's comments[1] to mean that he thought Jonathan's
> patches behaved no worse than the existing code in the face of
> simultaneously running gc's, and thus that Ævar's concerns shouldn't
> hold up Jonathan's patches.  But, it's totally possible I
> misunderstood his intent -- as I mentioned, I'm not at all familiar
> with this area of the code.  Maybe Peff or Jonathan can clarify.

Yep, that's what I meant. I think Jonathan's adjacent response to Ævar
agrees with that, too.

(I haven't actually thought hard about _other_ possible issues with push
negotiation at this point, though).

-Peff
