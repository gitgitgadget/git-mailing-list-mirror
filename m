Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D0AC433E1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 07:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E69A6192E
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 07:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCUHWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 03:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhCUHWY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 03:22:24 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B064DC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 00:22:23 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w70so9674535oie.0
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 00:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5EUfCARXEx5KISEjok2HqEVmr7Ei6PBS3jf5j7BdAw4=;
        b=o9JS519nyYrVGDHuxX3OzIDoQWAC606PqQjQx4f9VwuJGvoxXCIacSSV3EMu/+6EMy
         fqfpJ2KLyXEp8iy5mTlGC7GCJ8jdnqQtGfJvSIUphA1Cd6tFPylFOa9+AmzJEgOIf5s1
         ZcyhFSDGY6s0Fan2UMpH9N+N/gO92Hui18OIBhK5IT9dELiID88gErIBaq2mlzD4KzK5
         WSabcdKwnDKJksO+MBHHd+f8SBiu3pPrLMkhQ9sIx+ERyGdfmEvsw7lgBL3UZZJb8nvG
         ubDkV5EBzqMHmuN+mkODhwc9Sd1p77Pdvl8scwOljEacbIbPVl7UWB1ZGT5kHmrrshbo
         GpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5EUfCARXEx5KISEjok2HqEVmr7Ei6PBS3jf5j7BdAw4=;
        b=oknVfZCvQt8UkI0otHtfWBOA4luMYOI3E/7EyB8KPXBcheZuI3fHM2xZ2A79V9Gfvm
         83JLir6HtuLc3H9MjwkjMXMh4D1LE4rKn6l8K959/NTLve8cn5XXO6MhrXeY5HtxQbWR
         CZxWGFr0E5UTvl8v5GZcevYVBMU9ZlEoF/tOGheXQd0un9vtPxj3VKe6LijVzaEp5e0D
         BH5+mcSRvitF5tp25tDSNLl5GcwS9X3IvhKrcQ1ynHshBU0fhM/9D/9A3NLe4owpBovb
         SA3KDp+KashT1y0EY79MWUZ0CBPeTTfhJgSP6FauAP1+tn349tzdiVtvoZ2wT55wXCxq
         +SVA==
X-Gm-Message-State: AOAM530h5KKz2Fkh8QvRH+JZ1/YUlhllhDK0trIWb1jAn0FAUAYaEn/X
        t0eq37Nao7rDyFO5Latom7C1uYXzBBTphGcD66M=
X-Google-Smtp-Source: ABdhPJwFpy+rAZz/4vEUjBP3YaOUCSGd5fKcBQrSiOfgkie7J98LXFgrhEWyEcSuHtsCSPdtnhe2PAhHXQiis9mmDW0=
X-Received: by 2002:aca:d68e:: with SMTP id n136mr6516382oig.179.1616311342905;
 Sun, 21 Mar 2021 00:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.885.v7.git.1616152884317.gitgitgadget@gmail.com>
 <pull.885.v8.git.1616252178414.gitgitgadget@gmail.com> <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
In-Reply-To: <CAPig+cQBATCe4XFt1k0_EfYvb61_RVgTO0NGy6Ykg7frNPbtpQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 21 Mar 2021 15:22:11 +0800
Message-ID: <CAOLTT8SbiYew=xEQou4oyfPQL+KYVuv03uk=So4NmL+3nvKKGA@mail.gmail.com>
Subject: Re: [PATCH v8] format-patch: allow a non-integral version numbers
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8821=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8812:05=E5=86=99=E9=81=93=EF=BC=
=9A
>
> On Sat, Mar 20, 2021 at 10:56 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/Documentation/git-format-patch.txt b/Documentation/git-for=
mat-patch.txt
> > @@ -221,6 +221,11 @@ populated with placeholder text.
> > +        `<n>` may be a non-integer number.  E.g. `--reroll-count=3D4.4=
`
> > +       may produce `v4.4-0001-add-makefile.patch` file that has
> > +       "Subject: [PATCH v4.4 1/20] Add makefile" in it.
> > +       `--reroll-count=3D4rev2` may produce `v4rev2-0001-add-makefile.=
patch`
> > +       file that has "Subject: [PATCH v4rev2 1/20] Add makefile" in it=
.
>
> This new example raises the question about what happens if the
> argument to --reroll-count contains characters which don't belong in
> pathnames. For instance, what happens if `--reroll-count=3D1/2` is
> specified? Most likely, it will fail trying to write the
> "v1/2-whatever.patch" file to a nonexistent directory named "v1".
>
> > diff --git a/log-tree.c b/log-tree.c
> > @@ -369,8 +369,8 @@ void fmt_output_subject(struct strbuf *filename,
> > +       if (info->reroll_count)
> > +               strbuf_addf(filename, "v%s-", info->reroll_count);
> >         strbuf_addf(filename, "%04d-%s", nr, subject);
>
> To protect against that problem, you may need to call
> format_sanitized_subject() manually after formatting "v%s-". (I'm just
> looking at this code for the first time, so I could be hopelessly
> wrong. There may be a better way to fix it.)

Hi, Eric,
This is a kind of "injection" problem,
thank you for your discovery and solution method.
