Return-Path: <SRS0=6EDX=DO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDE8C4363C
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D05DC2168B
	for <git@archiver.kernel.org>; Wed,  7 Oct 2020 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgJGSRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Oct 2020 14:17:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:52618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbgJGSRJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Oct 2020 14:17:09 -0400
Received: (qmail 21229 invoked by uid 109); 7 Oct 2020 18:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 07 Oct 2020 18:17:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14871 invoked by uid 111); 7 Oct 2020 18:17:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 07 Oct 2020 14:17:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 7 Oct 2020 14:17:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: [PATCH 0/3] jt/threaded-inex-pack leftovers
Message-ID: <20201007181708.GA222564@coredump.intra.peff.net>
References: <xmqqa6x070tn.fsf@gitster.c.googlers.com>
 <20201007153947.GA181281@coredump.intra.peff.net>
 <20201007154533.GA186764@coredump.intra.peff.net>
 <xmqqlfgi2axr.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlfgi2axr.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 07, 2020 at 10:38:40AM -0700, Junio C Hamano wrote:

> > That _seems_ to work fine, but I'm not sure why it was removed in the
> > first place (for a good reason, or simply as an accident when rewriting
> > the variable declarations at the top of the loop?).
> 
> The above looks like an obvious and trivial fix to go back closer to
> the original.

Yeah. I'd still like to get an ack from Jonathan, but having looked at
it more deeply, I'm pretty sure it's the right thing.

> We seem to have removed find_unresolved_deltas() helper function in
> that series, but there remains a mention to it in a comment, which
> we would probably should rethink (it just may be the matter of
> removing the mention, or if "just like in ..." may have been the
> last example of doing what the comment suggests all code to do, it
> may reveal a need for larger clean-up---I dunno).

I think the code just moved around and we can update the reference,
though I admit I haven't fully thought through whether there are any
other subtleties.

I also noticed one other small cleanup related to the series. So here
are a few patches on top of jt/threaded-index-pack.

  [1/3]: index-pack: restore "resolving deltas" progress meter
  [2/3]: index-pack: drop type_cas mutex
  [3/3]: index-pack: stop mentioning find_unresolved_deltas()

 builtin/index-pack.c  | 12 +++++-------
 t/t5302-pack-index.sh |  7 +++++++
 2 files changed, 12 insertions(+), 7 deletions(-)

-Peff
