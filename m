Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F2FC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5171060FD8
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 09:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbhDOJiX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 05:38:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:53178 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230260AbhDOJiW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 05:38:22 -0400
Received: (qmail 9981 invoked by uid 109); 15 Apr 2021 09:37:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Apr 2021 09:37:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14681 invoked by uid 111); 15 Apr 2021 09:38:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Apr 2021 05:38:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 15 Apr 2021 05:37:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: What's cooking (draft for #4's issue this month)
Message-ID: <YHgJdtF4X2LQCuZ0@coredump.intra.peff.net>
References: <xmqqmtu1zn3o.fsf@gitster.g>
 <YHa5NE3tj/R5kF8N@ncase>
 <xmqqeefcy35i.fsf@gitster.g>
 <xmqqv98own1s.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv98own1s.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 14, 2021 at 02:53:19PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >> The following patch fixes this, which
> >> I'll include in my next reroll of this series.
> 
> Hmph, I am not sure if that is wise.  The offending "-1 no longer is
> accepted" comes from a topic that is not even in 'next', so you may
> not want to depend on it.
> 
> It turns out that the two-argument form that passes -1 to the
> function we see below as the preimage in your fix-up patch comes
> from my conflict resolution.  Your original has
> 
> 	type_from_string_gently(v0, -1, 1);
> 
> and the other topic wants to make two unrelated changes to the API,
> i.e. making -1 no longer a valid "please count, as it is pointless
> to force callers to always count" option, and drops "is this asking
> to be gentle?" parameter.  It may be better to just update what is
> recorded in my conflict resolution machinery, without making it
> 
> 	type_from_string_gently(v0, strlen(v0), 1);
> 
> as it would be necessary to adjust when both topics are merged
> anyway.

Heh. I wonder if I was too optimistic in my review at:

  https://lore.kernel.org/git/YHCYfeRsHU34ZF%2Fl@coredump.intra.peff.net/

-Peff
