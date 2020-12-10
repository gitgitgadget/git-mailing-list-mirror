Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7B0C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75E4B235F7
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 00:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgLJAdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 19:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgLJAdc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 19:33:32 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989DDC061794
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 16:32:52 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id b62so3293765otc.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 16:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwdwin5kamTRjNnIjQC9Kn6Q+56c8+H8FZrG45ATPQg=;
        b=BBoyWX7lXCK7EWUNolyY33CEl4ikjqVje5cjclNKY/PuPfmGQR2huvzU4mAQyY52cx
         f96ZG/dXzwhRj0MlicJGtwg6rsMyQJV8XVVDAnDnEGdmIOHpaUygQJBenWjK/qvIw5Oc
         FM+ebld8W9MAGm4JhoKQ2XYR7IuE6Gs6n3mDwROo6BNLrL4afXd6deP477ouTLjKmN10
         OLbHp5AGCI117AVKcQMiS5DFsQAf2t6QCQy6LK/6ZRaS5DEWeu+jC/BAN/QQSN4xWA6m
         P64Lmf2dwKmtdr+nANioDHjjaxMjmFadmTc1m2M3zMf/GaSqTbUJ7Eews93TCzX85Zqs
         ImXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwdwin5kamTRjNnIjQC9Kn6Q+56c8+H8FZrG45ATPQg=;
        b=IKjYkhdUxVzaKoSx0T92LArEuDkqD2KzUIqGct7k+DDboYZ4vUHZubkNI6cKm9E81+
         ZcDaK/+uUleg4L1iyKlUXWngYZ34cqhBVoBmUsEf9XVe9s1i/yMADgnCmIfeAgg5YOoA
         1wS77DtK2i6HQJd5aPhZYIeUWUKaU3281sPH2V1sg1EwZ27/SP0HbNhMax+KPGAF3Kvq
         AHBMEK5DFCUh7ScycWqs8zKSgS2nLUrhyj7KYx9WMYd9ciSW7dF48gMypguPx+Ldajdy
         YoDuWc/XMsBrZLzr0fDhGZsnymWlWWtFQ4JIEs76OcRBugCnIQ9FScVDn73j/1XjqT/z
         v+PQ==
X-Gm-Message-State: AOAM533fgKTfe3SxEx4ZNY9j5uP4EkjWT2yPcis+po3aWiUV0RKkdRLR
        Rvw/qsWrDeISTXHO85OhyXzO/ft5q5Rmd2V9fqY=
X-Google-Smtp-Source: ABdhPJyU+VVmeONdnsLZ7DFgBe7O+x7Xy79j/m8MTpJ/xSqIWtRA+GK/RsZZSeWJSvicFIi+uMaCHp3KKdBXakdQV4Q=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr4011592otr.345.1607560371893;
 Wed, 09 Dec 2020 16:32:51 -0800 (PST)
MIME-Version: 1.0
References: <pull.929.git.git.1607223276.gitgitgadget@gmail.com>
 <f96bb36930a6e5e42f0d3b9c5dfa3b2cc27c1f9d.1607223276.git.gitgitgadget@gmail.com>
 <X9FLaiuWpYely6es@nand.local>
In-Reply-To: <X9FLaiuWpYely6es@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 9 Dec 2020 16:32:40 -0800
Message-ID: <CABPp-BHQNy3MQ9u=sZKd0h2vqOzhFZC35XqR-QbHgzeiJ7VbLQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] diffcore-rename: remove unnecessary if-clause
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 9, 2020 at 2:10 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Sun, Dec 06, 2020 at 02:54:31AM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > diffcore-rename had two different checks of the form
> >
> >     if ((a < limit || b < limit) &&
> >         a * b <= limit * limit)
> >
> > Since these are all non-negative integers, this can be simplified to
> >
> >     if (a * b <= limit * limit)
>
> Makes sense.
>
> > The only advantage of the former would be in avoiding a couple
> > multiplications in the rare case that both a and b are BOTH very large.
> > I see no reason for such an optimization given that this code is not in
> > any kind of loop.  Prefer code simplicity here and change to the latter
> > form.
>
> If you were really paranoid, you could perform these checks with
> unsigned_mult_overflows(), but I don't think that it's worth doing so
> here.
>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  diffcore-rename.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> >
> > diff --git a/diffcore-rename.c b/diffcore-rename.c
> > index 68ddf51a2a1..0f8fce9293e 100644
> > --- a/diffcore-rename.c
> > +++ b/diffcore-rename.c
> > @@ -450,9 +450,8 @@ static int too_many_rename_candidates(int num_targets, int num_sources,
> >        */
> >       if (rename_limit <= 0)
> >               rename_limit = 32767;
> > -     if ((num_targets <= rename_limit || num_sources <= rename_limit) &&
> > -         ((uint64_t)num_targets * (uint64_t)num_sources
> > -          <= (uint64_t)rename_limit * (uint64_t)rename_limit))
> > +     if ((uint64_t)num_targets * (uint64_t)num_sources
> > +         <= (uint64_t)rename_limit * (uint64_t)rename_limit)
>
> One small nit here (and below) is that not all of these need casting.
> Only one operand of each multiplication needs to be widened for the
> compiler to widen the other, too. So, I'd write this instead as:
>
> > +     if ((num_targets * (uint64_t)num_sources) <=
> > +     (rename_limit * (uint64_t)rename_limit))
>
> or something. (I tend to prefer the cast on the right-most operand,
> since it makes clear that there's no need to cast the "first" operand,
> and that casting either will do the trick).

Yeah, I think that reads slightly better too, but on the other hand it
does make the diff slightly harder to read.  *shrug*.

> >               return 0;
> >
> >       options->needed_rename_limit =
> > @@ -468,9 +467,8 @@ static int too_many_rename_candidates(int num_targets, int num_sources,
> >                       continue;
> >               limited_sources++;
> >       }
> > -     if ((num_targets <= rename_limit || limited_sources <= rename_limit) &&
> > -         ((uint64_t)num_targets * (uint64_t)limited_sources
> > -          <= (uint64_t)rename_limit * (uint64_t)rename_limit))
> > +     if ((uint64_t)num_targets * (uint64_t)limited_sources
> > +         <= (uint64_t)rename_limit * (uint64_t)rename_limit)
>
> Same notes here, of course. I was hoping that we could only do this
> multiplication once, but it looks like limited_sources grows between the
> two checks, so we have to repeat it here, I suppose.

The right hand side of the expression is the same -- rename_limit *
rename_limit -- so it could be stored off (though I don't think
there's much point in doing so unless it made the code clearer; this
is not remotely close to a hot path).  However, in the left hand side,
it's not so much that one of the variables has changed since the last
check, it's that it uses a different set of variables in the check.
In particular, it replaces 'num_sources' with 'limited_sources'.
