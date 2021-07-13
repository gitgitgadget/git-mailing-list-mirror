Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED6C07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E55E611AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 21:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbhGMVz4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 17:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbhGMVz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 17:55:56 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F19C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 14:53:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id p14-20020a17090ad30eb02901731c776526so2193206pju.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 14:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLSlS0R5GaZnnbKZOAkLOcaMAcIESHBXc6PGzJhWNn0=;
        b=e1NwjeXpTlCPp9oKrhK4YndRJUIY1qgUqyWFqU94/4Rf2u+5EmsyEH4n1QyEtZXlqq
         xzARV2VbbDwZFFTw9ADvRghdtggdKK7FXAhbWTqfEV8I+/XY/OO+X/HTlXHDc6UOiP3x
         /ptIHOtphpL77edpZ7jQHhoZBQBUUnv06qntWpqDkmn694dZPYNQoiJdZlJaEKxE9MR4
         AWxDUJTLVAvB25r0AmoRg8FitVRfCHXxPKBi8cADLc4GKPbc8A3txdphN6FC2Dn4grc+
         FRFqLQWEd5vPOKqLehvLTzp8cbqDGAucrKCydfn+Ugk+VNahYx0CxIBgPMqacvwZ4OUl
         mbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLSlS0R5GaZnnbKZOAkLOcaMAcIESHBXc6PGzJhWNn0=;
        b=LgHjdWke/P6au1S1hql29FqaG8Rhj8Fy7OpUBoKi5Zw1ZaceEsJT47JsbtdvMLAp0U
         AhXQ85wZPwS1qCnjw3qiiVFnrKEhOcjE5L9ckjEydE6FRllFWKLSghNH3lmp0/4dey5l
         xGd45MeqaagLAw5PXXODwDAiTQ2eaQnLoL+nlYJpRKlXkQ2X/vem4ZFUxhh3jzjo7laD
         FwV7DIQNo8nAzf8HI+miCqoDzk2goKjHMkxNqe4QBb5HSEW5b4ijggjo5B7ufc38bVuG
         lBJQXxVw12/8n7m8DQEozAKsQdshIN/ct0CxaENahG1PqfeplDzifhA1bmbtr/GQYANW
         QWhg==
X-Gm-Message-State: AOAM5308FYSDUpjB5ZZq5EMYGYrVdt290q7SYv9YhSfXcW7I4TBQx+0h
        YaLqwRQERgPLDYfVmRYeYi9pzgv8xxt+hpm2F6hZnpkwxSc=
X-Google-Smtp-Source: ABdhPJw/4lp2V5dqJyNWv0/bbGYgEOtHqnYZG2D2CVbvejNzdZ5cdkmvrjU4R2fMZ3MXuQSMR8h7Hzhzf5aP/0ZF/dc=
X-Received: by 2002:a17:90a:8811:: with SMTP id s17mr315378pjn.171.1626213184330;
 Tue, 13 Jul 2021 14:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <YOzY+qNFM2GsgKMO@coredump.intra.peff.net> <20210713074018.232372-1-martin.agren@gmail.com>
 <YO1GNWjMol8JV8MR@coredump.intra.peff.net> <xmqqpmvl29ry.fsf@gitster.g>
 <YO4FObgRvpt1nVr0@coredump.intra.peff.net> <xmqqlf6928qv.fsf@gitster.g>
In-Reply-To: <xmqqlf6928qv.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Jul 2021 23:52:53 +0200
Message-ID: <CAN0heSqCFVqC9Ncn5r3b4dKOE80byDt_XRM3pnswixX4jFcLFA@mail.gmail.com>
Subject: Re: [PATCH v2] load_ref_decorations(): fix decoration with tags
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier, Junio C Hamano <gitster@pobox.com> wrote:

>>> Note how this commit could have been done as an optimization before
>>> 88473c8bae: When our peeling hits a non-tag, we won't parse that tagged
>>> object only to immediately end the loop.
>>
>> Yep, thanks for mentioning this, as it's somewhat subtle.
>
> It is too subtle that I am not sure what the paragraph wants to say.

Then:

> Jeff King <peff@peff.net> writes:
>
> >> Puzzled.
> >
> > ...and the answer is that we don't need to parse it. The tag object
> > mentions the type of what it points to, and we use lookup_commit(), etc,
> > to create the object pointed to by its "tagged" field.
>
> Ahh, parse_object() on the outer tag, when instantiating the in-core
> obj, allocated an in-core object and that instance is already given
> a type from the tag object and .taggeed member points at that
> object, so it is not an "unknown" object (tag.c::parse_tag_buffer()).
>
> Totally forgot about that one; thanks.

Do you have any suggestions for how this could be explained better? I
waffled on whether to add that paragraph to the commit message and when
I finally did, it seems it got a little bit too succinct.

I'm about to check out for today. Maybe in the morning I can think of
some clarification.

Martin
