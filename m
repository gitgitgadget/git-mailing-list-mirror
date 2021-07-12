Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92075C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74A5761164
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 18:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhGLS17 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 14:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhGLS16 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 14:27:58 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5454AC0613DD
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:25:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y42so45174083lfa.3
        for <git@vger.kernel.org>; Mon, 12 Jul 2021 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7UO4Y7+K/Oz7t1o5Bggn7/yjANmXs0fgmjZLirHVlAc=;
        b=jzM+l/IL4fsCCurjSqNDJwd5Q16Mdts3ZWKt+GHpwPlBnm/Atp1RJ4hxuergboCjAc
         Y9ZdjQKSBbTflLW/l6Fuu1Nmyuoi31O9w2WEd7XQV0vDPHyhykkiojWBCuszIpBb7gJV
         +OIth2VS2ciIpMGj83y17VeHbCx+XVL17O9N/kgwr82E0pbMVz0pzCwkeSDbzrrImOYN
         6jYcVy0uVcE9V1R+NeabUR7+yPlL0OdNHpZwrAbPHUGSoCy6NqJpkdEQPqvq5HudDN1S
         ya8WSx7LIvezqjz0L7KOxVK4mPMofY2CHo1jvWHlYvjFOscYDIyAcPKKJqYPgwYnmHAR
         KoSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7UO4Y7+K/Oz7t1o5Bggn7/yjANmXs0fgmjZLirHVlAc=;
        b=Vd+l9v6AuPYf5UJHgCLzBmm00kk9iZH3DJn2qCHqED/Xb8aBus1OlS/7aBMbf3j3i9
         NKSywi7mN1PJRbkbZHfb5W7MgFgZHMybOyStKR3S6lVvEoDdSZ42vn5twKbx9R1ciqf/
         qCaVcU2ek4pOM8XS5AxVUcvkALLzl+KgeOjYfPqmfZzhTYojp7KlCtOdHpq4tYs1rHPH
         vIAbJ6O6taSum9Yw528Fd+LwstJTcGR21X5odU2XJyKl1x6JAf1mT1WHT36flVf6tLLt
         tIupn41/XmH9D7q4vnix8ngOs+DrwHNl8oPh8CiQ2ZZqIjBkwl65zsg54AxBIeDnsVVy
         uQzg==
X-Gm-Message-State: AOAM531NBhquHK3nkqnPS9Z91c1rsGkfkM54o0EyFHg8gVAlT1a9yL50
        55CG7KGpnUNnCqChaJhb5TvkoktQRPCZXq3o5aI=
X-Google-Smtp-Source: ABdhPJwRDqkVWZt9kDK0dNLK65zco2/7Ki9OHVrTLmusPUQ8TMnwBUGdTLAL4pdu88+//ipSp+d11n+6jqE4PRCFl8c=
X-Received: by 2002:a05:6512:1381:: with SMTP id p1mr56489lfa.367.1626114307641;
 Mon, 12 Jul 2021 11:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210711012604.947321-1-alexhenrie24@gmail.com>
 <00e246b1-c712-e6a5-5c27-89127d796098@gmail.com> <xmqqpmvn5ukj.fsf@gitster.g>
 <CABPp-BERS0iiiVhSsSs6dkqzBVTQgwJUjjKaZQEzRDGRUdObcQ@mail.gmail.com> <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
In-Reply-To: <CAMMLpeRX3iMwT9NJ+ULHgAhS3A=nAybgDYFHomkY3sif-H+F4g@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Mon, 12 Jul 2021 12:24:56 -0600
Message-ID: <CAMMLpeSBgURtX+MKbABKdmFuuoTA-Dw3h8uONwNeiP5aqcnfpA@mail.gmail.com>
Subject: Re: [PATCH] pull: abort if --ff-only is given and fast-forwarding is impossible
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 12, 2021 at 12:20 PM Alex Henrie <alexhenrie24@gmail.com> wrote:
>
> And it's not really necessary to make
> --ff-only imply --no-rebase because we're going to make `git pull`
> handle --ff-only itself without invoking `git merge`.

Sorry, I misspoke. I was thinking of the case where fast-forwarding is
impossible. If fast-forwarding is possible, --ff-only already
effectively implies --no-rebase, and we might want to make that
explicit in the documentation.

-Alex
