Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D56C6FD1D
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 22:23:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjCQWWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjCQWWM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 18:22:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D9277987
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 15:22:09 -0700 (PDT)
Received: (qmail 27717 invoked by uid 109); 17 Mar 2023 22:22:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Mar 2023 22:22:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29362 invoked by uid 111); 17 Mar 2023 22:22:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Mar 2023 18:22:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 17 Mar 2023 18:22:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git_connect(): fix corner cases in downgrading v2 to v0
Message-ID: <ZBToEJVQ6W6vTxK5@coredump.intra.peff.net>
References: <ZBS6wwWXcEBwGBm/@coredump.intra.peff.net>
 <xmqqr0tnf2i2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqr0tnf2i2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 03:15:49PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's code in git_connect() that checks whether we are doing a push
> > with protocol_v2, and if so, drops us to protocol_v0 (since we only know
> > how to do v0 for fetches).
> 
> I had to read this three times to make sense out of it, and then
> after reading the NEEDSWORK comment at the beginning of
> git_connect(), started to suspect that there is a bit of typo there
> that made it confusing to me.  Either "(since we only know how to do
> v2 for fetches)", or "(since we only know how to push via v0)",
> perhaps.

No matter how many times I proofread... :)

Yes, it should be "we only know how to do v2 for fetches".

> Other than that, superb reasoning and a very clear solution.  Will
> apply.  Thanks.

Thanks. Looks like you already fixed up s/v0/v2/ in what you queued.

-Peff
