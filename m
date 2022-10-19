Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF7C433FE
	for <git@archiver.kernel.org>; Wed, 19 Oct 2022 17:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiJSRG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 Oct 2022 13:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbiJSRG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Oct 2022 13:06:26 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426ED192D94
        for <git@vger.kernel.org>; Wed, 19 Oct 2022 10:06:22 -0700 (PDT)
Received: (qmail 3010 invoked by uid 109); 19 Oct 2022 17:06:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 Oct 2022 17:06:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6880 invoked by uid 111); 19 Oct 2022 17:06:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 Oct 2022 13:06:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 Oct 2022 13:06:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v2 00/10] run-command API: add run_command_{l,sv}_opt()
Message-ID: <Y1AujKKPUJFepph5@coredump.intra.peff.net>
References: <cover-00.10-00000000000-20221014T153426Z-avarab@gmail.com>
 <cover-v2-00.10-00000000000-20221017T170316Z-avarab@gmail.com>
 <xmqq4jw1wl6z.fsf@gitster.g>
 <221018.86a65ti70m.gmgdl@evledraar.gmail.com>
 <Y08P0G1Be+5hCVML@coredump.intra.peff.net>
 <xmqq7d0vu8cw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7d0vu8cw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 19, 2022 at 08:43:43AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I do think Junio saying "consensus" may have been premature. I expressed
> > my opinion and he agreed, but I think that is as far as it got. :)
> 
> Maybe.  This is a tangent, but as far as I am concerned, when Réne
> writes something that looks to me very straight-forward and correct,
> and it passes your taste buds, then that is enough consensus to move
> ahead.  As Linus often said and I concur, some people got good
> taste, that is hard to quantify and probably hard to teach, and
> there are a handful folks here with good taste.  And when two who
> have demonstrated they are with good taste agrees, that is good
> enough to me.

I pretty much agree with that worldview, but I try hard not to assume
"my taste is good" when going into a technical discussion. If only
because I've embarrassed myself a sufficient number of times. :)

> >> I don't see how *_l_opt() is particularly error prone, I just had a
> >> stupid think-o in v1 of this, but that if/else if bug is something that
> >> could have snuck in with run_command() given the same stupidity :)
> >
> > I don't think it's error-prone. It just seems like it complicates an API
> > for little gain, and causes us to have a lot of boilerplate mapping
> > RUN_* flags into cmd.* fields.
> 
> True. run_command() needs the RUN_* flags twiddling, too, so it is
> not a point against _l_opt() variant.

Did you mean run_command_v() here? If so, then yes, it requires the
flags. But if we are going to drop it in favor of just run_command(),
then those flags go away (and moving to the _l() variant is a step in
the opposite direction).

-Peff
