Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B3BC38A30
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05472075A
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 04:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgDVE5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 00:57:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:35488 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725808AbgDVE5D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 00:57:03 -0400
Received: (qmail 2975 invoked by uid 109); 22 Apr 2020 04:57:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 04:57:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26495 invoked by uid 111); 22 Apr 2020 05:08:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 01:08:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 00:57:02 -0400
From:   Jeff King <peff@peff.net>
To:     Michael =?utf-8?Q?F=2E_Sch=C3=B6nitzer?= via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Michael =?utf-8?Q?F=2E_Sch=C3=B6nitzer?= <michi4@schoenitzer.de>,
        Michael =?utf-8?Q?F=2E_Sch=C3=B6nitzer?= <michael@schoenitzer.de>
Subject: Re: [PATCH] docs: fix minor glitch in illustration
Message-ID: <20200422045702.GE3559880@coredump.intra.peff.net>
References: <pull.762.git.git.1587490505031.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.762.git.git.1587490505031.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 21, 2020 at 05:35:04PM +0000, Michael F. Schönitzer via GitGitGadget wrote:

> In the example by Jon Loeliger the selector 'A^2' was duplicated. This
> might confuse readers.
> 
> Signed-off-by: Michael F. Schönitzer <michael@schoenitzer.de>
> ---
>     fix minor glitch in an illustration in the documentation
>     
>     In the example by Jon Loeliger the selector 'A^2' was duplicated. Since
>     it is the only duplicate and doesn't fix in the structure I assume it is
>     there by incident and since it can confuse readers this patch removes
>     it.

This extra explanation could probably go into the commit message. :)

> diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
> index 97f995e5a9a..1ad95065c1f 100644
> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -233,7 +233,7 @@ G   H   I   J
>  
>      A =      = A^0
>      B = A^   = A^1     = A~1
> -    C = A^2  = A^2
> +    C =      = A^2
>      D = A^^  = A^1^1   = A~2

OK, so this is describing this diagram:

     D   E   F
      \  |  / \
       \ | /   |
        \|/    |
         B     C
          \   /
           \ /
            A

For "B" we can express A^ as a shorthand for A^1. But for C, a second
parent, there is no such shorthand. We _must_ say A^2. But there's not
much point in saying it twice.

We could just say "C = A^2", but it makes sense to keep A^2 aligned with
the A^1 from the "B" line to make the comparison obvious.

So this patch makes sense to me.

>      E = B^2  = A^^2

Curiously E goes right for B^2. It could be:

  E =    = B^2 = A^^2

or something if we really wanted to make a giant table where all the
possible names were grouped, but I don't think there's much point in
doing so.

-Peff
