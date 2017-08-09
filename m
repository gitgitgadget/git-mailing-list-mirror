Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEE9E1F991
	for <e@80x24.org>; Wed,  9 Aug 2017 17:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752564AbdHIRhs (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 13:37:48 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34364 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751704AbdHIRhr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 13:37:47 -0400
Received: by mail-lf0-f54.google.com with SMTP id g25so31103925lfh.1
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 10:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YSm+ZigpE5DWwTb7iMuF3EKf4caPiaIjz6fFf8NLxE0=;
        b=b3ZWbWPDo0cVdemFgiKQJ1YGQXoELDOLcLrI1N4GtURRRX8tMVnALVuKODs0qyxkyl
         J8L7NUCPfdPE0LpMSMFjTJZIrTKQGnr66nJzmKviiElJVjyj6nmyxDy9gJKEZv9aggVG
         DOohfi6X/svMbLj2bX0jDlT2l7z5aPenjdgqZjU+0eR626ILBusO1FoH/WTaklCPp1Vp
         V7eq/WMh1uvTmRK7aaj0zs9RqM2GReWEsrQEXFuSKLi5os6SK8QYGtZ4RjxeHzyITjtL
         VQjYNVkhAbk6cdt0CQpWFy7yW2VHsd8utZYhqoG/LAPVfDtatQ98+3WE2nkxliX3mhtS
         KU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YSm+ZigpE5DWwTb7iMuF3EKf4caPiaIjz6fFf8NLxE0=;
        b=o9SF5l4V/pJo1I16eiwL5aDFRI9xs+h0992PvmPim7FlrhFc6IcEC+C1jCppvcnZF/
         KoM3HTfcsRkYgIm7MtidfXRd/jtrPV7qv+RFxjt7fzxg+DUfJAkIgbjQFM5gTOvjOG9g
         h4gcYEyCFjw5prkmtQwqTd/KF8SUCNFNmEn5OGQ0+bqfB2jw3ftnAUsu8u0USoR/71/E
         4V8jr3cDuJRRAlaA+IRJwlEt9/eoC/rP2ia1vDlKsCmzfqrL8PHDRVDN+cLYbMxGqoTS
         saa5yhgMs1wVfhw0by985XRAgNnUDiPHsySvYJ+VYI7lbLWEpbEo9HYQi25LLeYydvRe
         LeSA==
X-Gm-Message-State: AHYfb5gNAV/n4XRSSlFFjrlwL+NGGOJjl79t7DA8VbtIFHEO+6qcOP7G
        hoNkWHmbjvjS8jBGwiR1gxNZpzofXRw7bZCt2A==
X-Received: by 10.25.20.68 with SMTP id k65mr3947641lfi.260.1502300266037;
 Wed, 09 Aug 2017 10:37:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.1.130 with HTTP; Wed, 9 Aug 2017 10:37:45 -0700 (PDT)
In-Reply-To: <20170809120207.amjpwhxz3evjci6x@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net> <20170809120207.amjpwhxz3evjci6x@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 9 Aug 2017 10:37:45 -0700
Message-ID: <CAGZ79kai_d4sU0D-oR=VpGQea6ZGVTsFd7P5Ch8VqQyc4h5obA@mail.gmail.com>
Subject: Re: [PATCH 4/4] http: #error on too-old curl
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 9, 2017 at 5:02 AM, Jeff King <peff@peff.net> wrote:
> We already fail to build with versions of curl older than
> 7.19.4. But doing an explicit check with an #error has two
> benefits.
>
> One is that it makes it clear to users that the build
> failure is intentional, so they don't waste time trying to
> debug it.
>
> And two is that it documents our current "too old"
> assumption, so that we know whether we need use an #ifdef
> when using newer curl features in future patches.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/http.h b/http.h
> index da4d8589d8..29acfe8c55 100644
> --- a/http.h
> +++ b/http.h
> @@ -10,6 +10,10 @@
>  #include "remote.h"
>  #include "url.h"
>
> +#if LIBCURL_VERSION_NUM < 0x071304

Oh, it's hex. 0x13 == 19. Makes sense.

Thanks,
Stefan
