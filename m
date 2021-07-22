Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9ACC63793
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABEB66127C
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 08:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhGVHlE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHlE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 03:41:04 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88FF2C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:21:38 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id r16so4594363ilt.11
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 01:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JDQjrKcQyHl2szdC89HznRi92kTdEqE8Ehfm7uJPU6U=;
        b=EtpGtECUqgJ23v3pmg4vA1smkKxdxXGvVJpZxbZD8EkUxAq0NwGVSy3gcC0Pic6NAR
         M6K7exFfvyB0XK9oWfL0Jpd/FC/9PinRS6LpLZDkmNn6dQvq9KcIM80s9oFqXPBhBDdW
         ygDnozGDw0N3MMxE+DxgMdcWQN2yFqOKSn8QxVgw7LBgbzQuXUC9QCOkj0qQyLVUBdXn
         QVZrHSDerXcz/ORcjgimOcChGmQBBC2u2bA/WrdXvV7ZvmzyRshnKKpLJoOjC4sK8PIp
         YSe9a9czdxJt8meO2/mrIpKDLXTPOBkm+9hiFSeblia6JF42LWSgkg3UgtX0ZkU2eY0c
         bbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JDQjrKcQyHl2szdC89HznRi92kTdEqE8Ehfm7uJPU6U=;
        b=R59xeAvmobJGB646aedko1wIVaW+oswQKnkwGYpTy4wHGNd/uupA22edH2Sll/L1eS
         kpa6nSZUpBvETxFIjCMYwYJ8hUI9kS8PgJqvFxX3Ux924SOxW8wKiXFsfYinkh9KHxET
         kVJJXFDYrf2PMA6A/qSVY9vwPebOzXAMVjD1bq6+1Asnt3MKs2TyVqjjvc8e3WhF1tOh
         GrnxLkRoF/qgifyST9LMzWOZJa/ePGCX4pqmyv2oQquqdgcfGn6bV8PxNm8Ik1PkH7O7
         r22a1x2b/PwnZD1VbfOuMSkbW2bnyXgs1Cq7vLHTvfxdhJtNDQSdyHg7oF5gClUA5agy
         vYXg==
X-Gm-Message-State: AOAM531qc4exucb+5nheRgJImBOHi39wIs0IfvWnDOwimdy6tIcprKp+
        OS/HfW6z872dpA2zBcIn6fja2R2zxb5jQflZwSo=
X-Google-Smtp-Source: ABdhPJyNn+yILwT6LJ/yRPshHheIYxN/1SpxOQ+JfPSL0qrog4DaHvWDBPEu5a3DXKOJ4DCMMRyQdyOfiThZDtN6UEo=
X-Received: by 2002:a92:ab0a:: with SMTP id v10mr11997638ilh.17.1626942098103;
 Thu, 22 Jul 2021 01:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com> <CAP8UFD3ENBZdm8yQn6J-yb4PvUsrzTA3KGxes42dE3bTrYbr9Q@mail.gmail.com>
In-Reply-To: <CAP8UFD3ENBZdm8yQn6J-yb4PvUsrzTA3KGxes42dE3bTrYbr9Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 22 Jul 2021 16:22:02 +0800
Message-ID: <CAOLTT8QSUX6xDontk2xorDkrFAFYC7hiG=nOukMHgjpGdKzXww@mail.gmail.com>
Subject: Re: [PATCH 0/5] [GSOC] ref-filter: add %(raw) and %(rest) atoms
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=
=8822=E6=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:08=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Thu, Jul 22, 2021 at 9:39 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > This patch series is split from my main patch series zh/ref-filter-raw-=
data,
> > to make things easier for reviewers to read.
>
> Thanks for doing that!
>
> > This patch series provided %(raw) and %(rest) for ref-filter, which wil=
l be
> > used by zh/cat-file-reuse-ref-filter-logic later.
>
> Great!
>
> It would be nice if you could also point to the previous times when
> you sent this to the mailing list, so that previous reviews can more
> easily be found and maybe checked.
>

Okey, I will do it next time.

> Another nice improvement would be to link to a branch on GitHub or
> GitLab, so that people could more easily fetch your work and try it.

Thanks.
--
ZheNing Hu
