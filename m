Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E618C433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13B7520936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 20:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgIPUSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 16:18:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:58990 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728364AbgIPUSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 16:18:34 -0400
Received: (qmail 26508 invoked by uid 109); 16 Sep 2020 20:18:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 20:18:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32358 invoked by uid 111); 16 Sep 2020 20:18:31 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 16:18:31 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 16:18:30 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Riesen <alexander.riesen@cetitec.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200916201830.GA44969@coredump.intra.peff.net>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 01:14:08PM -0700, Junio C Hamano wrote:

> Alex Riesen <alexander.riesen@cetitec.com> writes:
> 
> > Affecting the transfers caused by git-fetch, the
> > option allows to control network operations similar
> > to --ipv4 and --ipv6 options.
> > ...
> > Something like this?
> 
> Good start.
> [...]

A lot of your comments apply to the "something like this" suggestion I
just posted, so I wanted to save a round-trip and say: yes, I agree with
all of your suggestions here.

Adding a command-line option for "all" is a good idea, but will probably
mean needing to add the "unset" sentinel value I mentioned in the other
email.

> Would we regret to choose 'ipversion' as the variable name, by the
> way?  On the command line side, --transfer-protocol-family=ipv4
> makes it clear that we leave room to support protocols outside the
> Internet protocol family, and existing --ipv4 is grandfathered in
> by making it a synonym to --transfer-protocol-family=ipv4.  Calling
> the variable "transfer.ipversion" and still allowing future protocols
> outside the Internet protocol family is rather awkward.
> 
> Calling "transfer.protocolFamily" would not have such a problem,
> though.

I agree that's a better name. I'm still on the fence about "transfer"
versus "core".

-Peff
