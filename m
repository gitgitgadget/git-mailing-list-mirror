Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A46C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 228DC64F5C
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 19:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhBCTLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 14:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhBCTLr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 14:11:47 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071B2C061573
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 11:11:07 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id k25so974643oik.13
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 11:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=87q1WOlHuitcfHLgxeJf1/u3avoC9T3A7euSlGQNy9E=;
        b=IzXhQbcdk3TuuSFOPtnZqEU3jZzwZDz97wpuCYpcvqF9VAZOyTvEjyB5Xr6H/fDGmp
         Q+wy+w1tw4TutKIhlofiKlQeldkuE4qh1HZW+LaGjAXkacndXvqzGHGIepTJFc5sKAyI
         y8u8WcDe/PnvU1aGzgDWT6l5OORllgisOoE6WV3WbCBbcFEqNgaN4JE1+UioNdRUNr9s
         Azq3mE+C4pNFWBAUtnnet6BwacA23PN1iELKR418Uu4K+5SeJpKdffKnKmknTiX/9SDP
         yZpFFlVJkL40bMvmOV48yJlEDKC2LgzO3vGaR3FdH+V0G4aP0d8t6L6fSfE3pl+sqbmZ
         Shwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=87q1WOlHuitcfHLgxeJf1/u3avoC9T3A7euSlGQNy9E=;
        b=VwtKaJQmvgnAi3iBV2jKS9aX4yu56YziPtTIE+XLB6+287LuKtXpsi3CRya0uRUWuM
         FR/hXHKGkZ2Ryz3ULjmZ5JHzBjDqgu+Lo8Ve/6o0WNgwOnCBsn8x3/31R8WXb0EflyBR
         zcxQTO3spGhtzK6YvkbciKQHgi0X7dDtolIfTlAdO9eyH3HLOXmvvMy6jV1VM16ps93P
         VylQUKccyfOuTkCgcik1xLCTy8uNfOVRy4VBaNPh4T5+BRjOe9nWhGaHL+CJ7A5P/IFQ
         8UPUPem01ThZPYmPzJRl/mI3BPyAI9FSweCtvNWQ8N7Pg1l4lw6341Y61Ugkw4mT3z9R
         kJlw==
X-Gm-Message-State: AOAM532zMfix7htXn0TbU1OGzUjvNY2PvPvPM4jyqMdHkhsLYFjgxKdx
        H0PEBYSLdxM+7n66LO34nrXCU8pQbbQnPejMjuw=
X-Google-Smtp-Source: ABdhPJwMUA7CShrIlDVDF0L3E7+ZYdHvcHt0zLMpYYMfgrC1w0QzKRrEOf2wtEbg2wYKZV6cU9veg4z4z/TN4ixdhvY=
X-Received: by 2002:aca:a816:: with SMTP id r22mr2946024oie.31.1612379466467;
 Wed, 03 Feb 2021 11:11:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <3e69857f37e12540f7986245b99916b68702217a.1612331345.git.gitgitgadget@gmail.com>
 <515f55bd-90e2-9a7f-0973-501c9351969e@gmail.com> <xmqqft2dc7lj.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqft2dc7lj.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 3 Feb 2021 11:10:55 -0800
Message-ID: <CABPp-BH45RzNjo_Xj9uTpLj5f00dWwXun4m+mob25FJ0sPprWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] diffcore-rename: no point trying to find a match
 better than exact
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 3, 2021 at 10:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <stolee@gmail.com> writes:
>
> >>      /* All done? */
> >> -    if (!num_destinations)
> >> +    if (!num_destinations || !num_sources)
> >>              goto cleanup;
> >
> > And add an extra quit condition which is very possible to hit.
> > Is it only hit when every "delete" is actually a rename?
>
> When every delete is actually an unmodified exact rename, I think.

Yes, exactly.

> If this simple change gives us good performance gain, that is
> superb.
>
> Nicely done.

Thanks.

I probably should have separated this from the speculative
not-quite-working changes that weren't ready yet and pushed just it
sooner.[1]  But I kinda wanted to get all the performance changes
together, and...well, all the other performance changes took a while
to complete (especially given multiple starts and stops).

[1] https://lore.kernel.org/git/20171110222156.23221-2-newren@gmail.com/
