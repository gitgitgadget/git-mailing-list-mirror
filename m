Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFCDC43460
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B412E6135F
	for <git@archiver.kernel.org>; Mon,  3 May 2021 14:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhECOWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 May 2021 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbhECOWi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 May 2021 10:22:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F183AC06174A
        for <git@vger.kernel.org>; Mon,  3 May 2021 07:21:43 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h4so677539lfv.0
        for <git@vger.kernel.org>; Mon, 03 May 2021 07:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y5sjkVbuPC5plVwy+hc306G7Jgq9xj7XGbRoC5te9NM=;
        b=aAzCtXZZfHB/IrTwMLhdN2+89THbpCIXZax7rzUTJo05gC12EuacIuLe5lRH95tCYa
         hOkbQuQiub5vULBQuqvFJle90H3pKNxrTlhOdpnko9EDC3pOnAT8LvjG1DbRmMJEaZVr
         0IbzaKPEdK6cwC/0HYF6IdPWtW6WkF3aL1Q7Ymn3cnZ2KqxXvMZff3ll0hIcwfdsqe8o
         n+QSOmnHeFEgtE26Ru52t2oD577Dk6XIzrQFlmtVOtrkGPG5XEYHH8ZzjAajqdaw7w+9
         hSGNMpSPzRfWcxfqAX6Y+6kYvTZtXusbpDiflXTDSNy3W+ht6TvMuXKkI8+WEZu7H/r/
         L6tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5sjkVbuPC5plVwy+hc306G7Jgq9xj7XGbRoC5te9NM=;
        b=c7SDJ/Yb5vGefbfceF84Kr3uEGAgA0HiGacZ6pQaN5j4rJNIJtCpSJSlDB9TlRYs23
         NCWJkc1tPcc5dK0TKsCbO6gfQEuB9qcycA8apvt0ktdWyf2+J5V0cTJs7spjsBQraBYp
         1mrfrAo1VryZIFSY6/Nn1b75wJUEXufusnTHVSswLCc3IwGGemPvXLBcqYYZjjGlPA9l
         1yMaCRbEdrNnu5g/tawAfMAWNenE+DQWCCQPrVARoOUH7I+lw8Dh9zOmh3HyjYkhFTAP
         MzG6bh8gRzkvHJ/rF2YB9p3T7lcI60ZyaPQ3zxM3ifQpBMfhkrg8O/NBNb30SWDaeP/i
         kcng==
X-Gm-Message-State: AOAM531m+1Ecl4UoG7mobdncsBkBj0zoq69AYjISyHUisx2Jy5tNEx7o
        CjLoKzyssXMfaTSxre6FT1NWDXaRs6W/ef+U2+4/SA==
X-Google-Smtp-Source: ABdhPJwPDqP65AS2BN/K6rPYwNV3PJSclKRsx0LZBsxx8EKCZoai4/MD3uT5WUJtSXHUv+44HkYcYWrUq4FwxU9MzKM=
X-Received: by 2002:ac2:5503:: with SMTP id j3mr12157231lfk.538.1620051702083;
 Mon, 03 May 2021 07:21:42 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619818517.git.matheus.bernardino@usp.br>
 <e2d82c4337dc002d7296454c59d4006c3bb43c27.1619818517.git.matheus.bernardino@usp.br>
 <CAP8UFD16N3MiYawrRLCxsrYuo4KkvD3SS5F4UqyEF37j4T9yVA@mail.gmail.com>
In-Reply-To: <CAP8UFD16N3MiYawrRLCxsrYuo4KkvD3SS5F4UqyEF37j4T9yVA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Mon, 3 May 2021 11:21:31 -0300
Message-ID: <CAHd-oW57tFTQtqKPhS7J=52yhcatd9wQh3sTHVAmjwvPdWw=HA@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] builtin/checkout.c: complete parallel checkout support
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 1, 2021 at 2:08 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Apr 30, 2021 at 11:40 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Pathspec-limited checkouts (like `git checkout *.txt`) are performed by
> > a code path that doesn't yet support parallel checkout because it calls
> > checkout_entry() directly, instead of unpack_trees(). Let's add parallel
> > checkout support for this code path too.
> >
> > Note: the transient cache entries allocated in checkout_merged() are now
>
> s/Note: the/The/

Thanks

> > allocated in a mem_pool which is only discarded after parallel checkout
> > finishes. This is done because the entries need to be valid when
> > run_parallel_checkout() is called.
>
> > -static int checkout_merged(int pos, const struct checkout *state, int *nr_checkouts)
> > +static int checkout_merged(int pos, const struct checkout *state,
> > +                          int *nr_checkouts, struct mem_pool *ce_mem_pool)
>
> For consistency with the previous patch, maybe: s/ce_mem_pool/ce_mp/

Yeah, I agree that it's a good idea to keep this consistent. In fact,
instead of changing `ce_mem_pool` here, I think I should change `mp`
in the previous patch to either `mem_pool` or `ce_mem_pool`. Those
seem to be the most common names, at read-cache.c, for a memory pool
struct holding cache entries.
