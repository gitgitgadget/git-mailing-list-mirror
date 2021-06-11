Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13AFEC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 21:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED6C2610E6
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 21:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFKVn6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 17:43:58 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:35791 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhFKVn6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 17:43:58 -0400
Received: by mail-ot1-f54.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so4554495otg.2
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 14:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DI1dm9FhD5a4b+1On+A1sv1dooios1hnBZmU5Hei3qk=;
        b=rWZniLSfymyWLKZaQhLTVhEHq2CnoMgAu4FriJRAEPCNkFSpLSDIxGQQAt3JgmSJ2c
         /Oqwf1mr+rbzXlYjp6mr1KcZn6Iw7qqwsuUAQjXkqDBKUyhAI4gNftbOCyvy3Et6+u+o
         RYFBfCzgRBwmzdklRwTcdH9sj+HyPYmr7IitgDYLqvfndxO0a0KqW8/FSb9C2sX9zoHa
         4J2jgZ4oS7+yEIS0xfj1/QlDfpQVQ6VDrttOE66EPwT9GqS1OfWLh6uvUX0rNv0JAA4K
         yyIEmPR2gECsak9VB9ZhUgOiGUwpNPhKp2FNL3rB5S3XK4uiHg5z9IdK7OCAuUcYnpOv
         fGGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DI1dm9FhD5a4b+1On+A1sv1dooios1hnBZmU5Hei3qk=;
        b=fXxTZBtFUoMcQMiNvGupu8AMZe7JEGHoeJrO7w1NI0iJfr1PbtJZG89b5HhrRoCqqx
         iXF+iYQMqWLMLUydVgqq3AZlm5Y4IgW/Do7Kx6yX2IaE/BnIlwP61PdaZfHTBUfutD4M
         TcFSoZMGDGuOAfD33tYl0cWd0hFEeMemY894e2TCE0UKUGFuLcHNJmzNTs9w21NxdEYF
         C2HwRQ3WoEB+RUDeSaZruBV0dWX5TMPzolEjLqe+uKlFmf+blgXERBCaakSzPZZzeZpn
         Nzg+z1LbwP0vA+xeyaguhSTF3K1aHs8wOJ7xmFHqgrv6V3uwSihGqhnNnOkzKJ7iteVi
         wkEQ==
X-Gm-Message-State: AOAM533wbrQIixhcTb/90xA9hdq3ELGkBJ5TdlehqhbEivobiFEURCI1
        NyVLOFLtTKLRp8ir9Aqt+P3FNN1KirGpx4Hj4pU=
X-Google-Smtp-Source: ABdhPJy7Tvd4T9y77QfvumCnEY7ABUIxpZyy+ekvbZVWGwqx2F8qoGhTRwSHev1kOhJWyEniN7j3FkPYxYRu+IJ3hpw=
X-Received: by 2002:a9d:426:: with SMTP id 35mr4600914otc.162.1623447644123;
 Fri, 11 Jun 2021 14:40:44 -0700 (PDT)
MIME-Version: 1.0
References: <60c3a41bd25e3_8d0f2089e@natae.notmuch> <20210611190235.1970106-1-newren@gmail.com>
 <60c3d0296f869_8d0f208ec@natae.notmuch>
In-Reply-To: <60c3d0296f869_8d0f208ec@natae.notmuch>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Jun 2021 14:40:32 -0700
Message-ID: <CABPp-BGhaSJmqXFKpCVcUKexNXaa8sLEms-6q-qno7uETzGQ=A@mail.gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 11, 2021 at 2:05 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Elijah Newren wrote:
> > On Fri, Jun 11, 2021 at 10:57 AM Felipe Contreras <felipe.contreras@gmail.com> wrote:
>
> > > Or just use the base of the virtual merge:
> > >
> > >   <<<<<<< HEAD
> > >   D
> > >   ||||||| merged common ancestors
> > >   1
> > >   =======
> > >   C
> > >   >>>>>>> C
> >
> > I think that implementing this choice would look like this (again, not
> > compiled or tested and I'm not familiar with xdiff so take it with a
> > big grain of salt):
> >
> >
> > diff --git a/ll-merge.c b/ll-merge.c
> > index 095a4d820e..dbc7f76951 100644
> > --- a/ll-merge.c
> > +++ b/ll-merge.c
> > @@ -130,6 +130,8 @@ static int ll_xdl_merge(const struct ll_merge_driver *drv_unused,
> >       memset(&xmp, 0, sizeof(xmp));
> >       xmp.level = XDL_MERGE_ZEALOUS;
> >       xmp.favor = opts->variant;
> > +     if (git_xmerge_style >= 0 && opts->virtual_ancestor)
> > +             xmp.favor = XDL_MERGE_FAVOR_BASE;
>
> The only time git_xmerge_style isn't >= 0 is when no merge style has
> been configured by the user.

Yep, probably should have just been

+     if (opts->virtual_ancestor)
+             xmp.favor = XDL_MERGE_FAVOR_BASE;

Though the difference doesn't matter a lot.  Since
merge.conflictStyle=merge (which is the current default) doesn't
display the contents from the merge base in a three-way content merge,
setting xmp.favor to XDL_MERGE_FAVOR_BASE vs. leaving it as 0 for the
recursive/intermediate merges won't generally end up affecting the end
result.  It'd only matter for diff3 and zdiff3 users.


Going on a slight tangent, I think there's actually a related bug
here.  We probably should not honor XDL_MERGE_FAVOR_{OURS,THEIRS} when
opts->virtual_ancestor is true; that's just asking for trouble.  I
think it'd paradoxically result in reversing the desired behavior
(e.g. users would see what they'd consider XDL_MERGE_FAVOR_THEIRS
behavior when they asked for XDL_MERGE_FAVOR_OURS) in some cases as a
result.

> In fact, I don't see why any style should change that desired behavior.
> If you said there's issues with the "merge" style too, perhaps the above
> will help for those cases too.
>
> > > We don't have to use diff3 all the way.
> >
> > Right, thus my mention in the other email to consider adding a
> > XDL_MERGE_FAVOR_BASE -- which you then also mention here in your third
> > option, and which I've now given at least a partial patch for.  Not
> > sure if it's a crazy idea or a great idea, since I don't do very many
> > criss-cross merges myself.
>
> I thought you meant as a separate configurable flag, not something done
> by default.
>
> Now that I understand what you meant I think it could be a great idea.

If someone that does lots of criss-cross merges can comment on the
idea, and agree that it's worth a shot, I can try to turn it into real
patches.

(I might even try to investigate the zdiff3 stuff too, which sounds
like something I've wanted many times...but I'd really rather
concentrate on merge-ort until its upstreaming is finished.)
