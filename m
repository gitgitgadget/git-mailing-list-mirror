Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1844CC43217
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F4197611ED
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 20:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhJTUvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:51:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:43076 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230317AbhJTUvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 16:51:14 -0400
Received: (qmail 10572 invoked by uid 109); 20 Oct 2021 20:48:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 20 Oct 2021 20:48:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29390 invoked by uid 111); 20 Oct 2021 20:48:57 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 20 Oct 2021 16:48:57 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 20 Oct 2021 16:48:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] for-each-ref: delay parsing of --sort=<atom> options
Message-ID: <YXCAuAwZenM6EPug@coredump.intra.peff.net>
References: <xmqqv91uw5dl.fsf@gitster.g>
 <YW9EP5UNX0f+eOke@coredump.intra.peff.net>
 <xmqq4k9bssr7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4k9bssr7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 20, 2021 at 06:58:04AM -0700, Junio C Hamano wrote:

> However, it is tricky to arrange, as the command already takes
> multiple --sort keys, and the laster ones are taken as more
> significant sort order, so it is tricky to come up with two keys A
> and B such that --sort=A --no-sort --sort=B will produce one order,
> while --sort=A --sort=B will produce another different order.

Yeah, I faced something similar with 7c5045fc18 (ref-filter: apply
fallback refname sort only after all user sorts, 2020-05-03). I suspect
you could use the same keys as those tests, though I am OK if we simply
leave it as a quietly-fixed bug.

-Peff
