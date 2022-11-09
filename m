Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3E2C433FE
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 13:18:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbiKINSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 08:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiKINSM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 08:18:12 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30389FEF
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 05:18:11 -0800 (PST)
Received: (qmail 12352 invoked by uid 109); 9 Nov 2022 13:18:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Nov 2022 13:18:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14590 invoked by uid 111); 9 Nov 2022 13:18:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Nov 2022 08:18:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Nov 2022 08:18:10 -0500
From:   Jeff King <peff@peff.net>
To:     M Hickford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH] Documentation: increase example cache timeout to 1 hour
Message-ID: <Y2uoko+ho9c5sfKf@coredump.intra.peff.net>
References: <pull.1412.git.1667989181611.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1412.git.1667989181611.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 09, 2022 at 10:19:41AM +0000, M Hickford via GitGitGadget wrote:

> From: M Hickford <mirth.hickford@gmail.com>
> 
> Previously, the example *decreased* the cache timeout compared to the
> default, nudging users to make cache less usable.

I don't mind at all changing this as your patch does. The existing
example was mostly just to illustrate the syntax. But...

> Instead, nudge users to make cache more usable. Currently many users
> choose store over cache for usability. See
> https://lore.kernel.org/git/Y2p4rhiOphuOM0VQ@coredump.intra.peff.net/

I don't see how my email argues for this. The only thing I mentioned
about credential-cache there is that it's not available on all
platforms.

But if you want my opinion on its usability, the main problem is not
that the cache timeout. It's that entering the credential at all is a
pain, either because it's a semi-automated environment that needs to
operate without user input, or because the credential itself is awkward
for the user to enter (like a long token). And that's what pushes people
to "store" over "cache".

> diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
> index 0216c18ef80..432e159d952 100644
> --- a/Documentation/git-credential-cache.txt
> +++ b/Documentation/git-credential-cache.txt
> @@ -69,10 +69,10 @@ $ git push http://example.com/repo.git
>  ------------------------------------
>  
>  You can provide options via the credential.helper configuration
> -variable (this example drops the cache time to 5 minutes):
> +variable (this example increases the cache time to 1 hour):
>  
>  -------------------------------------------------------
> -$ git config credential.helper 'cache --timeout=300'
> +$ git config credential.helper 'cache --timeout=3600'
>  -------------------------------------------------------

The patch itself is obviously correct.

-Peff
