Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1ECC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 01:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiBQBn2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Feb 2022 20:43:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiBQBn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Feb 2022 20:43:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ABB2128B6
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:43:13 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id c6so4243936edk.12
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 17:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FQH4m0RJuPvYN1WrLTYPHPQTkEYEIxv4LIBYPEkNXfg=;
        b=fMLwHLbeDEuf4OsvMrklFvBKRLlweDamty1INDEbwVK2l3jjovb3gd9TRx0G5zA4iQ
         qDMu+QaMFAh5KFazcpulB4HWcN9U2AwO6Q38DFcBSwCF1YXIvvHKSZCFXSFjtR6lF8oL
         nQhLc6Bq9AEgat3yY8ADYSj3cDs8FYwTbR8RxEH1pE30KUab/WTdk3FAvGRuIwHDi6yI
         EdJ0txTBTqxiPpVJlcZpKH+dh+4qyqR7+T3ridfHiRlkapmFkhwh8UawiPz6yGGMS+fo
         vi/r/n4O3xHD/6176WE92AFQd6evNOtluTCrwxTq6l/EPTMKxLhmfIio7hnQglvZnnvN
         omgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FQH4m0RJuPvYN1WrLTYPHPQTkEYEIxv4LIBYPEkNXfg=;
        b=mdf/65qF0SLHkc3LtoQ4hcCRk/uY4Z9yxizkbJQ13cHmpHhIDR5NOyNUZC+7aGCYPj
         NzGBtl5AbDZ7QQ4pbnjCGce2UuMMXozbTaDEGV4VgqpQBMoNEJ8aCwdPWeYsQb9lvgZ9
         kTvkYzjrExQ/2BmNAGQ5Kw4JKRYJi85CzBKTUoi0zbgYw5kkl3e52Vk+TFDrc7JP5iW4
         Db3AnNLEb3ZxMDaAUKpepOL2XcuyzW5wYc3GNWVUcDsBx2iGU2IW8MOPT1ZaUlcpoFZR
         AWJQSCT+kkD/udaJM+gLUc/p80IqqXhQcr6/Q7/u3QeY2EvDtKS6NHAVC00nkujeXlzV
         Fzfw==
X-Gm-Message-State: AOAM533DQVT3d58uf8f4Kkty/xoRxuxKS/jNhhK8MSZtQiho/L9Z0aEn
        oAcEzSR81OqIRrZo1ie5wwghZFH/xLWhrays+RkhsxMpW48=
X-Google-Smtp-Source: ABdhPJxBR4/4aUL3+W/u+jBewS4cEbN89i5tJBWNXxUle9v4y2Z0RQfn9zkx9PE6Ol6ZGB9uV9wc2SL/X2Mw2Dguyrg=
X-Received: by 2002:aa7:cc12:0:b0:410:cb7b:a9ba with SMTP id
 q18-20020aa7cc12000000b00410cb7ba9bamr463266edt.196.1645062191739; Wed, 16
 Feb 2022 17:43:11 -0800 (PST)
MIME-Version: 1.0
References: <pull.1118.v2.git.1644913943.gitgitgadget@gmail.com>
 <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com> <2008542d0c718bbe43388297307a791f94bc73e1.1644985283.git.gitgitgadget@gmail.com>
 <220216.8635kjuob0.gmgdl@evledraar.gmail.com> <CABPp-BEBX4tWwqkG=7+rcZa_EJzOC2+Rg214av_+-yymHTQGQw@mail.gmail.com>
 <af439020-8314-9171-4300-94a5102c8a38@github.com>
In-Reply-To: <af439020-8314-9171-4300-94a5102c8a38@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Feb 2022 17:43:00 -0800
Message-ID: <CABPp-BG8j=cNRDcsm3s7U2F8u3FCvoOLAbeuQTyv+2u1o1-fVA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] sparse-checkout: reject arguments in cone-mode
 that look like patterns
To:     Victoria Dye <vdye@github.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 16, 2022 at 9:20 AM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > On Wed, Feb 16, 2022 at 1:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Wed, Feb 16 2022, Elijah Newren via GitGitGadget wrote:
> >>
> >>> From: Elijah Newren <newren@gmail.com>
> >>>
> >>> In sparse-checkout add/set under cone mode, the arguments passed are
> >>> supposed to be directories rather than gitignore-style patterns.
> >>> However, given the amount of effort spent in the manual discussing
> >>> patterns, it is easy for users to assume they need to pass patterns s=
uch
> >>> as
> >>>    /foo/*
> >>> or
> >>>    !/bar/*/
> >>> or perhaps they really do ignore the directory rule and specify a
> >>> random gitignore-style pattern like
> >>>    *.c
> >>>
> >>> To help catch such mistakes, throw an error if any of the positional
> >>> arguments:
> >>>   * starts with any of '/!'
> >>>   * contains any of '*\?[]'
> >>
> >> But not "\" itself, we're just escaping the "?" here?...
> >
> > Nah, I just missed that one.  I should add it below.
> >
> >>> +     if (core_sparse_checkout_cone) {
> >>> +             for (i =3D 0; i < argc; i++) {
> >>> +                     if (argv[i][0] =3D=3D '/')
> >>> +                             die(_("specify directories rather than =
patterns (no leading slash)"));
> >>> +                     if (argv[i][0] =3D=3D '!')
> >>> +                             die(_("specify directories rather than =
patterns.  If your directory starts with a '!', pass --skip-checks"));
> >>> +                     if (strchr(argv[i], '*') ||
> >>> +                         strchr(argv[i], '?') ||
> >>> +                         strchr(argv[i], '[') ||
> >>> +                         strchr(argv[i], ']'))
> >>> +                             die(_("specify directories rather than =
patterns.  If your directory really has any of '*?[]' in it, pass --skip-ch=
ecks"));
> >>
> >> Isn't this nested || a reinvention of a simpler strtok() or strtok_r()
> >> call? I.e. (untested):
> >>
> >>         const char *p;
> >>         const char *wildcards =3D "*?[]";
> >>         if (strtok_r(argv[i], wildcards, &p))
> >>                 die(_("specify... has ony of '%s' in it...", wildcards=
));
> >>
> >> That would also allow parameterizing the set of characters for
> >> translators.
> >
> > I considered strtok, but strtok & strtok_r are documented as modifying
> > their argument.  Perhaps they don't modify the argument if they don't
> > find any of the listed tokens, but I didn't want to rely on that since
> > I found no guarantees in the documentation.
>
> Maybe `strpbrk` would work? Unless I'm misunderstanding, it should
> consolidate the condition to one line without potentially modifying the
> arguments. E.g.:
>
>         if (!strpbrk(argv[i], "*?[]"))
>                 die(_("specify directories rather than patterns.  If your=
 directory really has any of '*?[]' in it, pass --skip-checks"));

Ah, perfect -- thanks for the pointer!  (Though I think the logic
needs to be reversed; error if we find any of those characters rather
than error if we don't.)
