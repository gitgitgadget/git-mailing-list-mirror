Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB85C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA22610A6
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 10:04:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232025AbhGIKGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 06:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbhGIKGu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 06:06:50 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EB6C0613DD
        for <git@vger.kernel.org>; Fri,  9 Jul 2021 03:04:06 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id k16so11785051ios.10
        for <git@vger.kernel.org>; Fri, 09 Jul 2021 03:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OyYUN0KE7gLtYpFClozTtRZ0RB0e7rv53+vvjBfnyug=;
        b=Xfmnz35xSBP6AxVv3FQ+Kmq3hBj7nuMlGM6akWemBNfRhdjBhDBLxeDsas8gXy+LQV
         RAQ76zQ4K0VVPUF3E4+1k4OAjYXewzY5UZdnOmi7Xc7dVa5dymwWRsfbCqfwyGpWATsk
         HG9I872UQBJtzHFaeg49iFC2js+eQwsdDTxpA3D7xQicyJKzUnQ00nVic6Jm11/F+XJs
         JtxsjIcEhxgxC3m/iCX8DRbovgZI7eT4Uxixfj2GgYc8VdUCJ2cM5BvzMJR7tuoi0eww
         +9XtjK35O5Fr0r+qCm1ljuYFX0m8yWxcU6xaG16iO0vFyXqd/SQd0PzK5qL6YIHdrT8r
         2QhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OyYUN0KE7gLtYpFClozTtRZ0RB0e7rv53+vvjBfnyug=;
        b=uYYl1l5RNj1sE7y0+B0Qg3J6aguGiwXW9IlKjcMEtm0jLgtch/Dr7e62BzUJEe0diQ
         sRl310E5SYmqMln6uIovZ1AQr6SE3d5oMqJpSiAJ1G2aoW9JrE8FOEQ6ipMhtc9NbUdq
         /9Uizk5ycZcsTNZp9bJEsOh37FlcI9hTK99DO1TnLbO3HY3thUEaO70PVNSSlutSPCVh
         LvPVGzHCGdXsezJvADqJ7/bqLYM2wnKr28xEmwhhDdZA6YWWERljnHt6Bpja9tgQXOMv
         jWl5Q532aRZdm0pKyHTvFeQ926dLT/FqNC89fKuhzP6JAXGsli3B67Z+vCSz+AuWoB/m
         +pug==
X-Gm-Message-State: AOAM53039BYK925k6JfMVsAEe/sTZJjpyuxkn0Ygs+PCgvd01Q1AlzdQ
        XRXBlOYZK0vy6UIy+xebY35AiG18Sp2/+kb/VFQ=
X-Google-Smtp-Source: ABdhPJwSzeSW4CzgKiGaEQA7i6+TfNzm7+MQuXc5ofFwGuKIU/QfxXLPD6lqJOdLre6ULdkZ4OE37tOkeldsu/HcCUA=
X-Received: by 2002:a05:6638:d1:: with SMTP id w17mr6716596jao.10.1625825046425;
 Fri, 09 Jul 2021 03:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
 <pull.980.v6.git.1624797350.gitgitgadget@gmail.com> <xmqqbl7nt3fh.fsf@gitster.g>
 <CAOLTT8S=qeg8QBhMU0fCc600n-qzJBT9P9LvhSVZaXpvsr0__Q@mail.gmail.com> <xmqqtulerudh.fsf@gitster.g>
In-Reply-To: <xmqqtulerudh.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 9 Jul 2021 18:04:11 +0800
Message-ID: <CAOLTT8TipBZ+rQmKN_hMpXfPJFKWbfeYash6G50H23e9ez6J2A@mail.gmail.com>
Subject: Re: [PATCH v6 00/15] [GSOC][RFC] cat-file: reuse ref-filter logic
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio,

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=8810:17=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B47=E6=9C=881=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=886:04=E5=86=99=E9=81=93=EF=BC=9A
> >>
> >> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >>
> >> > This patch series make cat-file reuse ref-filter logic.
> >>
> >> Unfortunately this seems to interact with your own
> >> zh/cat-file-batch-fix rather badly.
> >>
> >
> > Well, it's because I didn't base this patch on it.
> > That should be easy to achieve.
>
> It is preferrable for contributors try merging their individual
> topics with the rest of 'seen' to see if there are potential
> conflicts (either textual or semantic) before sending their topics
> out.  Not all topics need to build on top of other topics (in fact,
> the fewer inter-dependencies they have, the better), but in this
> case, I think it makes sense to build one on top of the other.
>

I have a "rebase" trouble:

My new feature branch "cat-file-batch-refactor-rebase-version" should base =
on
zh/cat-file-batch-fix and  zh/ref-filter-atom-type, so last time I choice
(bb9a3a8f77 Merge branch 'zh/cat-file-batch-fix' into jch) as the patch bas=
e.

But github only allow me base the patch on a branch, so I choice
"gitgitgadget:seen"
as my github PR base. It causes that some merge commit include in it. [1]

So In order to prevent these "merge" commits from being sent, the GGG mecha=
nism
is modified to reject their merge commits.

Now I can't choice a good branch as my patch base... Have any ideas?

Thanks.

[1]: https://github.com/gitgitgadget/git/pull/989

--
ZheNing Hu
