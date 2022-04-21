Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E54DCC433F5
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 02:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356764AbiDUCgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 22:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDUCgp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 22:36:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2DF2BC
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 19:33:56 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so7148844ejd.9
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 19:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XBYqOLerKwHQSNjATDUA71TfsQhMmgxd8Ayf2POpp5s=;
        b=Y6agWFkGKeGpQPB06PYJTDlBtX6j10tKwJiOVxSJeW4sfI81XkAcYNlzHnPtMKvjl6
         zIWdPE4SQAuEYwX3D3Muf9fN9v92ustgUMBplrXnUZL3kp1Fw3I2zUioklec0qVzsHyp
         Zm0Cckf7TW7757Q6nkySzAXH2NxKiQe8ScLUGdCEzJI/HETmSRtuZy1m2xBfBzb2qx04
         QlVH2JWvfogvTSQe62vvwSplQJ6mqmc8z9QeuGop0Ky7ZMteVo5TjVbrDPg2kDUF8Iag
         LjsnHJ3EoNTd6j4Ye0sSRF9bXTKgsM9JFw14/DydzBhyy0/BmcR2Sz96khy+iHK9rJLO
         Ncmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XBYqOLerKwHQSNjATDUA71TfsQhMmgxd8Ayf2POpp5s=;
        b=JOvhFXMxiEbQzHB12hRlDZ95OydpjjtZWv6N2ty085uuDUKlE1MUGfbZWDH2623rFm
         4545VpsK44GYdUvbsQKym0+30Djk7x0er6/QQpHXFDwmlFZcUyo0dsv70PqY4q++jS4X
         BQfH7qlHlHEL9l69/gMSp6SQ9IfpQT+0eVrnl40tiznd0h9yFJkbjwumrrRY1psVdLRu
         Iwd1UaxDh0amyrnsm+ykvG/bbO7SHLJgIM38LcrGRyL0arPKJ4zGbLsfQCedC9MRMoWN
         HmAwlVQvdfAP6Rub2tCtG36KX3xmSWi4D/FORPq0DTC/T1WqAghHmSoqXfaV6XOqvnR/
         giqA==
X-Gm-Message-State: AOAM532DmUVziHv7WV3O00zIJ5zrR1cTgbWu/gNOKWd3Ny0Nyc+BD1+g
        zefKo47uh+P9+wpblrkIbsjcDRnkj1077CUk5TY=
X-Google-Smtp-Source: ABdhPJwFNIVCOMJnjXD9NPqJCcYT+u0oxVYLsYVaI44mdu6YJ2vU/rgpPx1pgM5Cn0QcLBLxKW26QjQ/1bThRj8V9vM=
X-Received: by 2002:a17:907:7f19:b0:6ef:fe0b:71aa with SMTP id
 qf25-20020a1709077f1900b006effe0b71aamr5666556ejc.493.1650508435390; Wed, 20
 Apr 2022 19:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220413164336.101390-1-eantoranz@gmail.com> <xmqq4k2wap8g.fsf@gitster.g>
 <CAOc6etYvOhqQn3icWj3Ny1m+J_60h7aiqW-gvm=dQyDLgG=6NA@mail.gmail.com>
 <xmqqbkx2ccj4.fsf@gitster.g> <CAOc6etYwMtfytbw6iRfnJnsexJhe7UydVu0OFUbWP0byS9i=MQ@mail.gmail.com>
 <CABPp-BE=H-OcvGNJKm2zTvV3jEcUV0L=6W76ctpwOewZg56FKg@mail.gmail.com>
 <87lew226iw.fsf@osv.gnss.ru> <CABPp-BGQSN2iRWco4pQCVKA3AM6J0L0vyFMnYdrOgK0Pa26tWw@mail.gmail.com>
 <CAPMMpoh9-sm57D_OSVpo4A3KdJypNZbZ2KTWURvcOW0690eviA@mail.gmail.com>
In-Reply-To: <CAPMMpoh9-sm57D_OSVpo4A3KdJypNZbZ2KTWURvcOW0690eviA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 20 Apr 2022 19:33:44 -0700
Message-ID: <CABPp-BFh-=3E-yMDaU1TgigwriFDbd-CwXe0PJKkc422LCSP6Q@mail.gmail.com>
Subject: Re: [RFC] introducing git replay
To:     Tao Klerks <tao@klerks.biz>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 20, 2022 at 4:27 AM Tao Klerks <tao@klerks.biz> wrote:
>
> On Mon, Apr 18, 2022 at 6:28 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > If you read the suggestion I made (which I'll reinclude here at [1]),
> > you'll note that I read the old thread you link to with both your and
> > Phillips' suggestions.  I dug into them with some examples, and came
> > to the conclusion that we needed something better, as I briefly
> > commented when proposing my suggested alternative (at [1]).  I
> > appreciate your suggestion and the time you put into it, but based on
> > my earlier investigation, I believe my suggestion would be a better
> > way of preserving user changes in merges and I'll be implementing it.
> > The fact that Martin (in this thread) independently came up with the
> > same basic idea and implemented it in jj (though he apparently has
> > some further tweaks around the object model) and it works well
> > suggests to me that the idea has some real world testing too that
> > gives me further confidence in the idea.
> >
> > [1] https://lore.kernel.org/git/CABPp-BGW39_5r8Lbt3ymR+F_=hWJcf=2e7O75vFNJ=3CEL5s=g@mail.gmail.com/
>
> Thank you for the clarification, and sorry I'm clearly missing
> something here - the link you provided is to a deeply threaded
> conversation about "[PATCH 08/12] merge-ort: provide a
> merge_get_conflicted_files() helper function", in the context of a
> server-side merge support patchset... I can't figure out how to relate
> that conversation to the "how can safely reusing previous merge
> outcomes when rebasing a merge work well?" topic I thought you had
> introduced here :(

Sorry, I entered the wrong link, and assumed it was right when I
copied it into the response email.  Whoops.  The link for [1] was
supposed to be https://lore.kernel.org/git/CABPp-BHp+d62dCyAaJfh1cZ8xVpGyb97mZryd02aCOX=Qn=Ltw@mail.gmail.com/

But as has been said elsewhere, what you're asking for doesn't exist
yet.  That other email was where I outlined a bunch of details about
what someone could do to implement it, and where I pointed out that I
planned to eventually implement it if Dscho didn't beat me to it.
I've since started on it.

I also linked to my tree a few times where anyone can look at what I
have done so far (which isn't useful to users yet).  If you want to
take what I've implemented and implement the rest before I can, go
ahead.  If you want to take the steps I outlined on how to do it in
the email link I provided above, and implement it from scratch then go
ahead.  But otherwise, as Junio already pointed out in this thread, it
just doesn't exist today.
