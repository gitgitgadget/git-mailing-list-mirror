Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1511AC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 03:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC97760EBD
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 03:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbhHKDsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbhHKDsC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 23:48:02 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2818CC061765
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 20:47:39 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id y1so1876877iod.10
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 20:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UGjdi7R77MkXROzoZeDhAlxKI2Qvh4pwHoJ6ijF2WuE=;
        b=c+Y98tG2Ud1/KsDwEO3nwGpL6ddkPnX5P7CTC8SR+4lICrB7B4hmSW7kU104P+BMOS
         SBvLIkvFLaY4dPblcE+VRmuXpfTqmsLJVP6fxT4pNaujoQSUP3QQxuT2wDcgFdUYFTRy
         vgiffgiVO+nMV7A9l1O9eih5l5pXaeJ9Pl/G41l4p6aRL2a7xPB6irAkTh0+1LPnuqX3
         x3EdBsHgHSjwqtble2N/E6RjYf2lBOzSxXjyWE0Rnri9mzCYXQJRV8bWQeAVCSriwomD
         Ha4hhTBppEETbWr33Pj5AkHwWiJXMgDgdr1TXRpd4vKuLkFgMUvaCo2ZGdgoTdgkmzWQ
         q5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UGjdi7R77MkXROzoZeDhAlxKI2Qvh4pwHoJ6ijF2WuE=;
        b=W8+jcRLSb99t8n+xRnBzgVzfIrkizcT6DGK3hnp/rK3wgms0cGPOVlH/GEBwhzo3Tb
         woQ5k8bmkSTSyF86p0FmaoEH2iq8z78gWg5P6+bvkv0X7TD4Em/g7rDS7Toq3rpiEnFs
         syAg86i5CwUtabmOlt2F931pedVK10f2fsZZjj/1XqH1ZyPdcooXfrixW6XcfcKHyQDi
         F+tky6TTkA3SSObPf68qXDKDwOrmJmN2rGOZbDn806yI00xEk3HjBSwXhaRUr++jit3O
         b8AlEmjR2Xky9eNhPDnCiae/gzUeNEzPPpdy9gKWsmU5sjHzezkswE2z9sw3xOFeeGnw
         bHew==
X-Gm-Message-State: AOAM531ABLuJnVhRejatDzWf9hqTuPL3slBlGrCAk4+Dv1Xn55kcwCPb
        TCxzx366WjVTb7KnF5aZ5Rkb1+LYkLgWZs8eRmI=
X-Google-Smtp-Source: ABdhPJy5lhsYe/eUoHQNHg1+zYLVQI1zDoS9QcG7MSspZE8IA1p3gjUHPJT0F1ufUaGt3K/ktm9oKRsUtBnXhJoO2rc=
X-Received: by 2002:a05:6602:38a:: with SMTP id f10mr228044iov.172.1628653658629;
 Tue, 10 Aug 2021 20:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8TYiUbXbkSTPY50jCU1bYP3JFx2P+hVmGL58S8V=AUMbA@mail.gmail.com>
 <CAP8UFD2yG3cC3qM3Ty7prdpVd=gXvArjM1soXD7EUn_NFFODaw@mail.gmail.com> <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com>
In-Reply-To: <CAOLTT8TQxz2xkQE7etDa3cgb-kRfho-WAyhfHTsK=FrYVsPN1A@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 11 Aug 2021 11:47:27 +0800
Message-ID: <CAOLTT8S0etdnFNKuD7z5QMxWdERZ-FWimn4Sc+u+7Ra1F2WAmA@mail.gmail.com>
Subject: Re: [GSoC] Git Blog 12
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B48=E6=
=9C=8810=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:04=E5=86=99=E9=81=
=93=EF=BC=9A
>
> > > parse_object_buffer(), let's take a look at the result of gprof again=
:
> > >
> > > We need to call grab_sub_body_contents(), grab_person() to rescan the
> > > buffer and extract the data.
> > > What if we can combine these multiple scanning and parsing into one c=
ompletion?
> > > At least intuitively, this has an opportunity to improve performance.
> >
> > Yeah, but is there a way to check that we indeed scan or parse the
> > same objects multiple times? This way we might get an idea about how
> > much scanning and parsing we could save.
> >
>
> I think find_subpos() called by grab_sub_body_contents() and find_wholine=
()
> called by grab_person() are evidences that we are repeating iteratively.
> But the proportion of time they occupy is too small. 0.0142% and 0.0109%
>

Using such a method may reduce some unnecessary scans [1]
But it can do very little optimization... 1.6%.
On the other hand, our optimization should focus on the default format of
`git cat-file --batch`.

My new idea is to need a fast path: when we use the default format,
let us directly execute get_object() to avoid unnecessary traversal
and checking.

Thanks,
--
ZheNing Hu

[1]: https://github.com/adlternative/git/commit/7d274971d2b5e1d4e6061d1e29e=
4a0b2c6a10ea5
