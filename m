Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25F28C47092
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEAFD61057
	for <git@archiver.kernel.org>; Sun, 30 May 2021 21:36:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbhE3Vhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 17:37:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:41500 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229816AbhE3Vhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 17:37:45 -0400
Received: (qmail 18909 invoked by uid 109); 30 May 2021 21:36:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 May 2021 21:36:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22051 invoked by uid 111); 30 May 2021 21:36:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 May 2021 17:36:07 -0400
Authentication-Results: peff.net; auth=none
Date:   Sun, 30 May 2021 17:36:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Message-ID: <YLQFRU2avYFBfdPu@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <xmqqy2bv3ovf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2bv3ovf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 31, 2021 at 06:15:00AM +0900, Junio C Hamano wrote:

> There however is one curious thing about this.  The log message of
> the original commit that introduced this optimization does use the
> batch-check and batch-all-objects at the same time.  Was this
> breakage not there when the original was written and we broke it in
> a later update?  If so, with what commit?  Can that commit have
> broken other places in cat-file in a similar manner?

The subtlety here is that it is broken with --batch, not --batch-check.
Only the former calls print_object_or_die(), which is after all the
difference between the two. :)

> [...]

Everything else you noted was quite reasonable, but I think we can get
further at the root of the issue; see my other email.

-Peff
