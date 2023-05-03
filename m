Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E70DC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 16:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjECQn5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 12:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjECQn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 12:43:56 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A3C255A9
        for <git@vger.kernel.org>; Wed,  3 May 2023 09:43:55 -0700 (PDT)
Received: (qmail 10817 invoked by uid 109); 3 May 2023 16:43:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 May 2023 16:43:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28642 invoked by uid 111); 3 May 2023 16:43:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 May 2023 12:43:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 3 May 2023 12:43:54 -0400
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: manpage: remove maximum title length
Message-ID: <20230503164354.GC1789686@coredump.intra.peff.net>
References: <20230503052926.217219-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230503052926.217219-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 02, 2023 at 11:29:26PM -0600, Felipe Contreras wrote:

> DocBook Stylesheets limit the size of the manpage titles for some
> reason.
> 
> Even some of the longest git commands have no trouble fitting in 80
> character terminals, so it's not clear why we would want to limit titles
> to 20 characters, especially when modern terminals are much bigger.

Makes sense.

Since the manpage header shows the name twice, along with "Git Manual",
the practical limit for an 80-column terminal is somewhere around 35
characters. If it's not hard to do, it might be worth setting the value
there, but I agree that we're unlikely to exceed that anyway, so it's
probably not a big deal either way.

I could also see an argument that the truncation is worse than any
wrapping or other ugliness that the user might see on a smaller
terminal, which implies that "no limit" as you have here is the best
option.

> For example:
> 
> --- a/git-credential-cache--daemon.1
> +++ b/git-credential-cache--daemon.1
> @@ -1,4 +1,4 @@
> -GIT-CREDENTIAL-CAC(1)             Git Manual             GIT-CREDENTIAL-CAC(1)
> +GIT-CREDENTIAL-CACHE--DAEMON(1)   Git Manual   GIT-CREDENTIAL-CACHE--DAEMON(1)
> 
>  NAME
>         git-credential-cache--daemon - Temporarily store user credentials in
> @@ -24,4 +24,4 @@ DESCRIPTION
>  GIT
>         Part of the git(1) suite
> 
> -Git omitted                       2023-05-02             GIT-CREDENTIAL-CAC(1)
> +Git omitted                       2023-05-02   GIT-CREDENTIAL-CACHE--DAEMON(1)

Your patch can't be applied by "git am" because of this diff in the
commit message (it thinks the commit message stops at the first diff,
even if it is before a "---" marker). The usual practice is to indent
the included diff.

-Peff
