Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B854BC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C2A464DF5
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 19:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhA3TRu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 14:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhA3TRs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Jan 2021 14:17:48 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308E2C061573
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:17:08 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id d18so14041619oic.3
        for <git@vger.kernel.org>; Sat, 30 Jan 2021 11:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TIUtcckhgRy/f2UjtIjDbTcOJdHHJprssI7FEgIvga0=;
        b=ddQ44BriqzO4hE1SOh1Hnh3gkjYk88ErxsW892zGX2TcxerfOcksGATE7ilAL4VVZB
         byoEFx9rmA4Ly8eTNfjzy/8Yia0mJeC4RKzsTTUBgoVUVi+vbuOgWzrxaoF0qfR5fo40
         T22b8Mpowow7WKoArpWJ0aTlerRFha4+ELlWLj4bUPVpHihihL06ADlk6OOX49YaPN8f
         Hb8V/orbsy/iwXUuwbxGic/SvxYCePKm65z1lwtygQQsonJyZWXi4FidW+m8ClaEIiQL
         tGWrbh31se+WoYXqSlhNVC/bxFmRrYuAOoROLgrJcBlPezXCb6Y8VAYULUoJIvRM0USX
         gEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TIUtcckhgRy/f2UjtIjDbTcOJdHHJprssI7FEgIvga0=;
        b=FXaK7nhbCL2shT5g3IAE3EWmyg2BefUsVb9vSELoVheaJrr6ucyE9auDLB8H1G5KZ3
         e5K0ccu5LG43jQjmWOPRaMnupWTlYK4VNf2+AQojQWFjeGGQjav69qdgXbnKXce5MqgW
         Fp7wZr2sPS/9+aQn2E8jSxUmTuOrtr4kJhPMPqIlMdAniwZPrINODx41iTSEiqQTH+Gk
         G+en+FZeurod+CWE9zj3CZ5yy5t2qeQQZXc8gfl7VAZrGj6pGKxM78s57qb+jG/kGVV4
         u43tSiSjU7ZaP3cNst/MYcfMyfyc0oZO2fY+hEkBgSpMTi4OClh9KR3A9DIBgt/iGZ/l
         4Exg==
X-Gm-Message-State: AOAM530e88AiCY/+w1zb1wwyBdtvvKU0S3E+LZgn+YjXeASEjQDuZeho
        KPWd8DkA2PGNr4tsiGcM7ytj0qAs2OPVnODJyoA=
X-Google-Smtp-Source: ABdhPJxXK/q79haOVda3DuwfClBkRZnPKLmpdE3tizvKvlw6c++mP7S4RlyQ3Ol7Y5gPTY92nfyEQKP9kqtrKSVsU0k=
X-Received: by 2002:aca:ab08:: with SMTP id u8mr6014537oie.84.1612034227491;
 Sat, 30 Jan 2021 11:17:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.726.git.1599335291.gitgitgadget@gmail.com>
 <pull.726.v2.git.1611954543.gitgitgadget@gmail.com> <245e48eb6835cae4e61f65af780b766d990d4b5f.1611954543.git.gitgitgadget@gmail.com>
 <CAP8UFD00sdiaFYUvgzQmXKCQSyrNKG82_xXvRGRaqdkbqKu7UQ@mail.gmail.com>
In-Reply-To: <CAP8UFD00sdiaFYUvgzQmXKCQSyrNKG82_xXvRGRaqdkbqKu7UQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Sun, 31 Jan 2021 00:46:56 +0530
Message-ID: <CA+CkUQ9sKyWJYahnZqfy1OfxxA+ukv148SCxjbGaOBzkCH0kbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pretty.c: capture invalid trailer argument
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Sat, Jan 30, 2021 at 3:58 AM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Jan 29, 2021 at 10:15 PM Hariom Verma via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Hariom Verma <hariom18599@gmail.com>
> >
> > As we would like to use this same logic in ref-filter, it's nice to
> > get invalid trailer argument. This will allow us to print precise
> > error message, while using `format_set_trailers_options()` in
> > ref-filter.
>
> Thanks for continuing to work on this!
>
> >  {
> >         for (;;) {
> >                 const char *argval;
> >                 size_t arglen;
> >
> > +               if(**arg == ')') {
> > +                       break;
> > +               }
>
> A space char is missing between "if" and "(". Also no need for "{" and
> "}". It could just be:
>
> > +               if (**arg == ')')
> > +                       break;

Thanks for pointing this out. Will fix it.
