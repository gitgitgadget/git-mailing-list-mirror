Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D3BC433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC73161001
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhETILU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbhETILT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:11:19 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F0FC061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:09:57 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id r4so14968574iol.6
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XIJUuG/MgCC0NxSLGwomGf3NkZ09VKBsZmIh9czeBFw=;
        b=Vkm7j9gkoxHd8wTRYV3FyoiN/gGySTl5NiGRHV+qgCcVKqrUpmRYj61ulsK9YYcoHj
         53K1wEvNFPAUOnGZulrDLvzmM9cfJfD7GwWpZZjXRkl1fZ1bCIJrTra1BpuyfKm/f/7Y
         YaLxeSihJK9LwewdSEdPt6NzypouU7ulj+Rv6bLlPCPy2/c/tD2hUtQ3UaimluUICDsp
         OtOsiWok796tofaO3C5Fk3FL/S6iGXdP2kTOpjb9634NCy1CmobKSUZ60zzJXrqNegJd
         sP3AA1NNGlw4RiwzI3jWNI128UvynasZe6MRL6nHCvViwHaNZGdJh9RyVGNrbf/N8XrD
         /rDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XIJUuG/MgCC0NxSLGwomGf3NkZ09VKBsZmIh9czeBFw=;
        b=ZtBzfeqEyEYnxarXj7fPFHoLJwtNJj5gBcjbfveyP3RCI0JKqf/By2h+KS7IY8IvwH
         +dC1cm9zb2weEDD+rszQS1J6GdXURpo89wNsw8fjyuzEE7QAboaerIWiGLSjNy6wQ9d8
         sJLMpBdE1R4gNhSDwXPkHU7SKc4aTNUHYdBechE6/0dTDI228BsZu/IJZ9gKIBUWAbfa
         zZn8P8xf9a/QcHYtoWlZA9H9bWa0IsRLhkfLkTY/4kPU9TpSkB7N7MsgDlxGFkQPd51s
         /n2Vl4NJpMDJxYdv+5h+5iVFhlzj90H3yZdnCOTfZMxCnNCKztgtVETQrp4Z3YzzZXtl
         PP9Q==
X-Gm-Message-State: AOAM532VtvSCHtIwrBf738G4KcIDA6rCsj0PcrSUGP8525ZNG0ch0Qkh
        Jis5YEz46yyYDT3zXy+7Jjtx1ub7XFGvb/l419g=
X-Google-Smtp-Source: ABdhPJzfzyvk0ZP6KRIL2uRFjVKCkg3O0vWJ+f9WmtKEbc1QbmgVUjyUrU9fuSefoS7QMBCt3PAC0lpFHpUu/Jeqko0=
X-Received: by 2002:a02:69ca:: with SMTP id e193mr4544767jac.130.1621498197335;
 Thu, 20 May 2021 01:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
 <CAP8UFD0qQg9vfuDvjrc5amnw8w7NFBLEaJUwEksV08HBdFJ7LA@mail.gmail.com>
 <CAOLTT8TRqn5=SqEEnHdFaYi1U5XJXM_MrULfPVzAGPH9AjXk-w@mail.gmail.com> <CAP8UFD2_PWKzwuYACH2MkjzCqO4VWm1EwReOZjgnsXAgpFcZtA@mail.gmail.com>
In-Reply-To: <CAP8UFD2_PWKzwuYACH2MkjzCqO4VWm1EwReOZjgnsXAgpFcZtA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 20 May 2021 16:09:43 +0800
Message-ID: <CAOLTT8QO6RsScmvxrvNo5SisWtm9BhfPiK3T8Ez-exwMwOUT_Q@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jiang Xin <worldhello.net@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=
=8820=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:00=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, May 20, 2021 at 9:14 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=
=E6=9C=8818=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=99=E9=
=81=93=EF=BC=9A
>
> > > > 2. "50cfe1f([GSOC] ref-filter: introduce enum atom_type)" has
> > > > been merged into the `next` branch, should we focus on the
> > > > performance optimization of `ref-filter.c`? Finally, we can build a
> > > > `format_cat_file_item()` similar to `format_ref_array_item()`,
> > > > which should not be difficult. And we have to make sure that the
> > > > performance of `cat-file --batch` is not lower than before.
> > >
> > > I wonder if format_ref_array_item() could not just be used by
> > > batch_object_write() like Olga did it in:
> > >
> > > https://github.com/git/git/pull/568/commits/f911b342ae6503dc9f6f8e3c7=
df316aa45d97bdf
> >
> > Thanks for the tip! Olga uses `format_cat_file_item()` in
>
> You mean `format_ref_array_item()` not `format_cat_file_item()`, right?
>

Yes. `format_ref_array_item()`.

> > batch_object_write() , which may be the correct approach.
> > Before that, we have to make ref-filter support "%(contents:raw)"
> > (similar to Olga's "%(raw)") and "%(rest)".
>
> Yeah, please take a look, if you haven't already, at
> https://github.com/git/git/pull/568 where Olga already worked on that.
> It would likely help if you can reuse her work.

I have check them, I want to use "%(contents:raw)" instead of %(raw),
https://github.com/gitgitgadget/git/pull/958 tell the reason,
I will submit it later.

--
ZheNing Hu
