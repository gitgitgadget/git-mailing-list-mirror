Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67AEEC433F5
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 21:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353930AbhLCV7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 16:59:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:43328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353907AbhLCV7H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 16:59:07 -0500
Received: (qmail 25239 invoked by uid 109); 3 Dec 2021 21:55:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Dec 2021 21:55:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5688 invoked by uid 111); 3 Dec 2021 21:55:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Dec 2021 16:55:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Dec 2021 16:55:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
Message-ID: <YaqSXvp6ZxOFqeuk@coredump.intra.peff.net>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 03, 2021 at 07:01:39AM +0000, Jean-Noël Avila via GitGitGadget wrote:

> This series is a meager attempt at rationalizing a small fraction of the
> internationalized messages. Sorry in advance for the dull task of reviewing
> these insipide patches.
> 
> Doing so has some positive effects:
> 
>  * non-translatable constant strings are kept out of the way for translators
>  * messages with identical meaning are built identically
>  * the total number of messages to translate is decreased.
> 
> I'm inclined to even go a step further and turn these messages into #define
> or const strings. This would have the added benefits:
> 
>  * make sure that the messages to translate are identical
>  * create a library of message skeletons to be picked up when new messages
>    are needed
> 
> What do you think?

One slight negative of this approach is that it makes messages a bit
harder to grep for. It sometimes really nice to "git jump grep" for
specific messages you got to see where they're coming from.

I don't think that's a strong objection, though. If this is making the
translations overall more maintainable it might be worth the tradeoff.

We could also allow GIT_VERBOSE=1 or something to print the file/line of
error(), warning(), and die() messages, which solves the same problem. I
think Ævar might have had some patches in that direction.

-Peff
