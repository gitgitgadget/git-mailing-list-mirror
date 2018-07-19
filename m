Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 932341F597
	for <e@80x24.org>; Thu, 19 Jul 2018 21:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbeGSWBC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 18:01:02 -0400
Received: from mail-yb0-f173.google.com ([209.85.213.173]:43670 "EHLO
        mail-yb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbeGSWBC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 18:01:02 -0400
Received: by mail-yb0-f173.google.com with SMTP id x10-v6so3839333ybl.10
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 14:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9LBub31PtXTF5yOgKGEsAn0Sip/FGWc1IyK0kFXwJY=;
        b=K+kVxKiN3Vzwj9O5XxT2x9n4gpeOmLaoBsgAgmDO0fZl/qR1FCanYtj6OV7Rwi7gKG
         dUOD32Z9yp7mpMlGqeZBmWtv0gxcYRZeigs2pqObJCNtxS/xjO0ZzOAM5Jt5NGCE4MN7
         y04kAh6hmJS2ppntn8cvs8wmmPftfG/CYQRhzRmyTLlWGRZJtDSuCjpKjCGTBvaWPvLe
         HOgcyCvVRQ63k+ekfKybHCmzbhhlWkVpKelx4SNnhkxxeV2lBENHYflYmUVDKnL/HIF4
         6eyNxGusBMbLJtWobHdLN4yHu7F9ZPmQ/YsKqFPE/XHllq15PVqBHh/WKmMJv1rVW2C8
         nnkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9LBub31PtXTF5yOgKGEsAn0Sip/FGWc1IyK0kFXwJY=;
        b=dRc7LmsmzdXd4b1AIA6pkSW1UMUVTMJS0tB6LHXnC24FQlgCkT3UP5YWawZgvQrOcz
         2rmq0opG76V/4JcBjMlx8E2Se33M3OUUBS46a+V58RZqUFqBkwGqqww+/aTcWieHzlq/
         egzW9JU43ZiH+MPbhazgDjMKdF5AGgnOKK9Vix8B0xtsrS5gss9O+bEoOOT/br5ZkCR7
         1z1MeQD52wvwgrkd7dkFrYjv1RwTAbzwoDnLElKKjhCEH4nAmu/NvXse11XMaMwf0wy7
         OKkBhIa9jCZ6oiav4xzVVngOqq3GqwIY26JiJmfs+5DP27RHkkJE9ykG4Tn9ec7JZd/J
         vNOQ==
X-Gm-Message-State: AOUpUlF2KLsZljgq85BrjjkfZmanECIpCjWBYcHVvVsSMlTmb5aMss/5
        UrB1ERaqoHKcWKLVdoh+vyPcnsEtdagdtBsbov+3rw==
X-Google-Smtp-Source: AAOMgpeI1Tdv+p7fk1yt2Ngf2GR1n9wagC2+9HKOgpS2WnHdnMSXsNtDuxh+eYy3+zTj3FTnfcN2gkYTGxghewe7iWU=
X-Received: by 2002:a25:560b:: with SMTP id k11-v6mr6497141ybb.292.1532034966661;
 Thu, 19 Jul 2018 14:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180719203259.GA7869@sigill.intra.peff.net> <20180719203901.GA8079@sigill.intra.peff.net>
In-Reply-To: <20180719203901.GA8079@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Jul 2018 14:15:54 -0700
Message-ID: <CAGZ79ka1yHb-485xc-sAK5iVkeyWJq4Q2g-7jzEgHuVUWLBXKg@mail.gmail.com>
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Jeff King <peff@peff.net>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 19, 2018 at 1:39 PM Jeff King <peff@peff.net> wrote:
>
> There are a few standard C functions (like strcpy) which are
> easy to misuse. We generally discourage these in reviews,
> but we haven't put advice in CodingGuidelines, nor provided
> any automated enforcement. The latter is especially
> important because it's more consistent, and it can often
> save a round-trip of review.

Thanks for writing these patches. I would think this is a
good idea to have as I certainly would use banned functions
if not told by the compiler not to.

>  Documentation/CodingGuidelines |  3 +++

I'd prefer to not add more text to our documentation
(It is already long and in case you run into this problem
the error message is clear enough IMHO)


> @@ -0,0 +1,19 @@
> +#ifndef BANNED_H
> +#define BANNED_H
> +
> +/*
> + * This header lists functions that have been banned from our code base,
> + * because they're too easy to misuse (and even if used correctly,
> + * complicate audits). Including this header turns them into compile-time
> + * errors.
> + */
> +
> +#define BANNED(func) sorry_##func##_is_a_banned_function()
> +
> +#define strcpy(x,y) BANNED(strcpy)
> +
> +#ifdef HAVE_VARIADIC_MACROS

In a split second I thought you forgot sprintf that was
mentioned in the commit message, but then I kept on reading
just to find it here. I wonder if we want put this #ifdef at the
beginning of the file (after the guard) as then we can have
a uncluttered list of banned functions here. The downside is that
the use of strcpy would not be banned in case you have no
variadic macros, but we'd still catch it quickly as most people
have them. Undecided.

Regarding the introduction of the functions to this list,
I would imagine people would find the commit that introduced
a function to the ban list to look for a reason why.
Can we include a link[1] to explain why we discourage
strcpy and sprintf in this commit?


[1] https://www.thegeekstuff.com/2013/06/buffer-overflow/?utm_source=feedly
  This is the best I found. So not sure if it worth it.

Thanks,
Stefan
