Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2F0C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 985616101D
	for <git@archiver.kernel.org>; Thu, 20 May 2021 08:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbhETIBv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 04:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhETIBu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 04:01:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A4C061574
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:00:28 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y7so783025eda.2
        for <git@vger.kernel.org>; Thu, 20 May 2021 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M1QhmOk/l0Csqx2vXOfGJGUtdIYJpzLregf52NaE9SQ=;
        b=vM5W9j+qtMLTeE1GQUadgfhISeHYnWUiWJ6y1mV9nPGFDelXAk40P0WiCqZdqFRshQ
         Yl4y6219TUoI1Mlg5ZNACufs18w98Wq3TQ814Knl1rpuTW1ZbGe9KvdWgfrYp3lTDW82
         EtUtOykUbUuR2K1q8FDdnUUOEZbU8R/IwhwNYrsxQsk1LZV87xPArBF6KZkyc3qE3kd2
         pKJ/bHGMELegjcr/Z3a63C45A4r+Pl2HD45t4YSNxXQDBZm8LVFmJu8JfkCJUsYdbFaN
         uYYf/Dg8SSTF97PEHWYp+qcdPgMIpqUUhzHsuea2C6uZHuzf0LDS/+5X5VV//PqGZAyU
         kVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M1QhmOk/l0Csqx2vXOfGJGUtdIYJpzLregf52NaE9SQ=;
        b=Ax9XUAbfZMaicyRPYungHp1WzbF0vEl7EeN1oIgDNubCR2GyzdjYtPJd5QYq/TWx4P
         JC/s54k9TsGP+C67shxJhtZ2QVzFHU2mzlbPYOZ5lEUGzv6c0LhaZqVNsVtAtFjGpbgI
         Tb65rHmGrf39UAmgPvzQmcPf5SQgjEfkumICwfwJcs+JhbXzYEjgWIJ8ED2Z6CGkqu5K
         gfzbaoxe2pdvleoT7gqg1db1P4VtHSYoa/HIcpicg9FmhKlf9+u+Oh9H2vH+aBIUSq2A
         LVTitXJomGeLAouuWMa7giBFoE97gjwLEBqcSukeAl+cxJWY0KepUrgAc0ijyIOcpeqS
         FcJA==
X-Gm-Message-State: AOAM532a0jXoqpKJD51p3Oq1Rchoz8rKVX0pK5Ge0ZR+Yuv2K4+MaLu1
        gGeL7MkvAMPa/iDbjcciSlM+6ccb5AQHMQEAB1mAavNbDEyVXg==
X-Google-Smtp-Source: ABdhPJyqx6VBxhskYW1ew3oSF1f1lcvqc3UY5BHyoeLW5AX6VjYRiOw6Hejc1QxdoZ3UE12NqkEOmOjOEANYvbHXw4I=
X-Received: by 2002:a05:6402:1207:: with SMTP id c7mr3622628edw.387.1621497626974;
 Thu, 20 May 2021 01:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
 <CAP8UFD0qQg9vfuDvjrc5amnw8w7NFBLEaJUwEksV08HBdFJ7LA@mail.gmail.com> <CAOLTT8TRqn5=SqEEnHdFaYi1U5XJXM_MrULfPVzAGPH9AjXk-w@mail.gmail.com>
In-Reply-To: <CAOLTT8TRqn5=SqEEnHdFaYi1U5XJXM_MrULfPVzAGPH9AjXk-w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 20 May 2021 10:00:15 +0200
Message-ID: <CAP8UFD2_PWKzwuYACH2MkjzCqO4VWm1EwReOZjgnsXAgpFcZtA@mail.gmail.com>
Subject: Re: [GSoC] Hello Git
To:     ZheNing Hu <adlternative@gmail.com>
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

On Thu, May 20, 2021 at 9:14 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B45=E6=
=9C=8818=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:32=E5=86=99=E9=81=
=93=EF=BC=9A

> > > 2. "50cfe1f([GSOC] ref-filter: introduce enum atom_type)" has
> > > been merged into the `next` branch, should we focus on the
> > > performance optimization of `ref-filter.c`? Finally, we can build a
> > > `format_cat_file_item()` similar to `format_ref_array_item()`,
> > > which should not be difficult. And we have to make sure that the
> > > performance of `cat-file --batch` is not lower than before.
> >
> > I wonder if format_ref_array_item() could not just be used by
> > batch_object_write() like Olga did it in:
> >
> > https://github.com/git/git/pull/568/commits/f911b342ae6503dc9f6f8e3c7df=
316aa45d97bdf
>
> Thanks for the tip! Olga uses `format_cat_file_item()` in

You mean `format_ref_array_item()` not `format_cat_file_item()`, right?

> batch_object_write() , which may be the correct approach.
> Before that, we have to make ref-filter support "%(contents:raw)"
> (similar to Olga's "%(raw)") and "%(rest)".

Yeah, please take a look, if you haven't already, at
https://github.com/git/git/pull/568 where Olga already worked on that.
It would likely help if you can reuse her work.
