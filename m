Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F0720248
	for <e@80x24.org>; Thu, 14 Mar 2019 00:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCNAVB (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 20:21:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:50004 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726656AbfCNAU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 20:20:57 -0400
Received: (qmail 30917 invoked by uid 109); 14 Mar 2019 00:20:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Mar 2019 00:20:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17694 invoked by uid 111); 14 Mar 2019 00:20:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 13 Mar 2019 20:20:02 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Mar 2019 20:19:40 -0400
Date:   Wed, 13 Mar 2019 20:19:40 -0400
From:   Jeff King <peff@peff.net>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] packfile: use extra variable to clarify code in
 use_pack()
Message-ID: <20190314001940.GD31968@sigill.intra.peff.net>
References: <a026ce9f-b825-7fc2-2ad5-c0b00bc508b4@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a026ce9f-b825-7fc2-2ad5-c0b00bc508b4@ramsayjones.plus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 09:49:58PM +0000, Ramsay Jones wrote:

> From: Jeff King <peff@peff.net>
> [...]
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>

Signed-off-by: Jeff King <peff@peff.net>

Naturally. :)

> As promised, I am forwarding a 'saved' patch from Jeff, which was
> a by-product of a long-ago discussion regarding commit 5efde212fc
> ("zlib.c: use size_t for size", 2018-10-14).
> 
> I have tested this patch on 'pu' (@6fd68134c8) and directly on top
> of commit 5efde212fc. (see branch 'mk/use-size-t-in-zlib').
> 
> However, whilst I have been waiting for the tests to finish, I have
> been looking at the code and concluded that this does not _have_ to
> be applied on top of commit 5efde212fc. (I haven't done it, but just
> tweak the context line to read 'unsigned long *left)' rather than
> 'size_t *left)' and this should apply cleanly to 'master'. Also, it
> would have _exactly_ the same effect as the current code! ;-) ).

I think it does apply, though the reasoning in the commit message of
"this is OK because 'left' is large enough" becomes a lot more
hand-wavy. The patch is not making anything _worse_, certainly, but the
fact of the matter is that "left" still might not be big enough, if it
is not a size_t.

-Peff
