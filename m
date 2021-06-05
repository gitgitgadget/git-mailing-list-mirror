Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD8BC47082
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 03:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8807610C9
	for <git@archiver.kernel.org>; Sat,  5 Jun 2021 03:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhFEDvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 23:51:46 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:42826 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFEDvp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 23:51:45 -0400
Received: by mail-oo1-f49.google.com with SMTP id y18-20020a4ae7120000b02902496b7708cfso183468oou.9
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 20:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ia0CifHGN4A/Pm7gBwIeArpLUg51uIiR6kK0sVv0RQw=;
        b=B9Wn6+wiR2awPMXSZgzigz0I1vu3SOv6bekpeYgGm2YwI/JRVB32S8J/Teptt9shSm
         WR0+lYYJxBX85HVUN2faSUDFqvkwSNgaja9yWNS6BG92e7jNurRIMP19rt0Myg5THDDL
         DrDRw5jpkoQsltu8G1BapHEpqFL8uxqiU8GNrnSSjElDyOqso8jFHp7XF6TS7wtPHz8Y
         +45VwCpDGyan1WMuXZNSoMTDOZLs+uSGEvQvR2UY/LQHBYa0pkoZVCOa8IMLfrgrXXyk
         fkzSv6yu/AKGduhn+4dRcYhJni0f/DZiCC+E/7PC69U0DsOibC/J8igbEHvKXsbvJjkn
         wyvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ia0CifHGN4A/Pm7gBwIeArpLUg51uIiR6kK0sVv0RQw=;
        b=kQhSjKD2hg+X2YBOedqlCF7j0Hb3fTDelKjFMkpiHLuLL+RgmMOtT60+Nfmc1wFteC
         EFwfRWAVKAWa3fNZpxJt0ZeM9HzJHDy/9mUGVAyh+xC0vzxsI2Xxxt5RCXek3PtrNFs5
         mWl3+aoDOiJDMpnBx8noscZMXptf2cbbb74Kf9bc+C1z5WzOz/fCjgFVNTFG2q0My6gO
         ShPhxZGGuSaP0nEdZydLvpS5ZJp4eBf3rDUMDtRENn2HPWoYbckYMPvmYuy/BTtgXWpo
         0QJW6RQtYZyGPp73kb5YCWBkFgMoaD+Qi4mCby/DkRvBiaygNWVFBD8GCWNt8KznltLh
         ezqQ==
X-Gm-Message-State: AOAM532qIFxcAJG7hyB2c6okyj0FIiuw08DfJVz+KX9fNQGrQF9pQnMx
        11NPWuLdS/HksdQfF/T4lEMvXzuqW458t2L2F74=
X-Google-Smtp-Source: ABdhPJx1mEAmwGHNkZ2dIx1JXsm3GCZTB6bTKUEujcd/CRZGhfvG+jlZcoM9VwIlzm5i2Cv47nltdIJefDtgOhNJhN8=
X-Received: by 2002:a05:6820:29b:: with SMTP id q27mr6067027ood.32.1622864925013;
 Fri, 04 Jun 2021 20:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
 <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
 <CABPp-BGeOVQokV+zg2-PUcmjEQ8+jmn6e=UeE=cOn=-Qm32p_Q@mail.gmail.com>
In-Reply-To: <CABPp-BGeOVQokV+zg2-PUcmjEQ8+jmn6e=UeE=cOn=-Qm32p_Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Jun 2021 20:48:34 -0700
Message-ID: <CABPp-BFz1gCcNKzGcpp=N7eeE9F9mqonLUS89aQRvOf8zMJcsQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A quick update...

On Fri, Jun 4, 2021 at 2:35 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Jun 1, 2021 at 2:38 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> >
...
> > diff --git a/object-file.c b/object-file.c
> > index f233b440b2..ebf273e9e7 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -1570,15 +1570,12 @@ static int do_oid_object_info_extended(struct repository *r,
> >                 }
> >
> >                 /* Check if it is a missing object */
> > -               if (fetch_if_missing && has_promisor_remote() &&
> > -                   !already_retried && r == the_repository &&
> > +               if (fetch_if_missing && repo_has_promisor_remote(r) &&
> > +                   !already_retried &&
>
> So here you removed the special check against the_repository while
> looking for promisor_remotes.  There are other such special checks in
> the code; I also see:
>
> diff.c: if (options->repo == the_repository && has_promisor_remote() &&
> diffcore-break.c:       if (r == the_repository && has_promisor_remote()) {
> diffcore-rename.c:      if (r == the_repository && has_promisor_remote()) {
>
> and a series I'm planning to submit soon will add another to merge.ort.c.
>
> Do these need to all be fixed as part of the partial clone submodule
> support as well?  Do I need to change anything about my series?  I
> guess since I'm asking that, I should probably submit it first so you
> can actually see it and answer my question.  (And the timing may be
> good since the area is fresh in your memory...)

That other topic is now over here:
https://lore.kernel.org/git/pull.969.git.1622856485.gitgitgadget@gmail.com/T/#t
