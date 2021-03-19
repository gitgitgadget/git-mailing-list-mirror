Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36720C433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 08:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDF2860232
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 08:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233993AbhCSIEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 04:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbhCSIEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 04:04:14 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB70C06174A
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 01:04:14 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so7733925oto.2
        for <git@vger.kernel.org>; Fri, 19 Mar 2021 01:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F7XT+ztYGgRre0xR3PdDFWgjJs2i5bX9zwN05D9G5OQ=;
        b=lqKEBKv2Op9xC4FM+86lVHcqEXgzgv1bfV9o0FOhEUgVBIhlK+s3gscno9ycSJavDM
         elZith4YAKtfm7JdrCrBN+XF0nmwX++M/yPsPHfsZoSS9k5gI0B6kMDauRNoZItu6Wnf
         a60XNv+0HTiRTyHAIc/dkYjbBIBKxbHdYC/yFpYD/g2Kpr++nsJjHvsaauSVJalKZPPy
         4gw5Qql2aibNZb+zZaqHZI9fS1+73cWKRKmZTfQNEDsDlqw2n5uK0V+dj1+5lCXqFxMR
         /Rq4i8zNT1Camb4c5Hh0EEMAQ5ol+mf1yit3+Qz1HRGv+Y+kg+gkOoWYK7E9kopHTH5x
         iQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F7XT+ztYGgRre0xR3PdDFWgjJs2i5bX9zwN05D9G5OQ=;
        b=siKJPNo/gkxiTUNMas4HCp1nPlRB8gBM0CRQhNTez3FzkXh6DIn+u2yOA3ZeIAsaQl
         5XmaX4KoL1TD5zpXcW0B9ki7gSmZFRLQXwy8GVJ/kZHcMD1uVYHniZ3UkIlC48WZO409
         FtmvQHYWDRUuxOBwXFzJnAcBmi5C0JZp6O/AiIvGxFuiw/c7g+3eT9tOyalColCXSHZC
         HwRaJzkkkFnN4yU25lOs7ydxzqkv5cCC2vn832/DEgCJt98p4BNDI9WCnv+DISbRXrvb
         aW7d6u3vr1rIBIPSsL5Lzwv9Tvtj1tjHtdmOGK/wlEbKL555icgGacvJjsEuOeGpAL7Q
         K18w==
X-Gm-Message-State: AOAM532zqFQq51ajgZ6A8zDY7eCRJZmX7r3dXxGFzxj4EcbLKyNB70O0
        7m54EMlOkOg2/7UephRnEXmZyFT2ySyTxXnQDNc=
X-Google-Smtp-Source: ABdhPJwqsAzKjRU/T2R3JivmQ+TkwOGee1TPwG71OC6/p76hapVKjW0vJ1JUOHE4FFn5YUczjOseFDOSXRC2Uy8bZkM=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr113935otq.160.1616141053688;
 Fri, 19 Mar 2021 01:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v9.git.1615891183320.gitgitgadget@gmail.com>
 <pull.901.v10.git.1616066156.gitgitgadget@gmail.com> <42590e95deeece6ba65e0432c3a59746e717fee3.1616066156.git.gitgitgadget@gmail.com>
 <YFODnm4JKfqRn37H@danh.dev>
In-Reply-To: <YFODnm4JKfqRn37H@danh.dev>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 19 Mar 2021 16:04:02 +0800
Message-ID: <CAOLTT8R-h5T4eqZ_T1BFXX++u_A=2uhOhdfc4Yz83effhWjeqg@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] interpret-trailers: add own-identity option
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com> =E4=BA=8E=
2021=E5=B9=B43=E6=9C=8819=E6=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=8812:4=
5=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2021-03-18 11:15:55+0000, ZheNing Hu via GitGitGadget <gitgitgadget@gm=
ail.com> wrote:
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > Beacuse `git commit --trailer=3D"Signed-off-by: \
>
> s/Beacuse/Because/
>
> And I think, it's easier to read if we write the command in its own
> (indented) line.
>
> > $(git config user.name) <$(git config user.email)>"`
> > is difficult for users to add their own identities,
> > so teach interpret-trailers a new option `--own-identity`
> > which allow those trailers with no value add the user=E2=80=99s own
> > identity. This will help the use of `commit --trailer` as
> > easy as `--signoff`.
>
> Perhap, saying that we're optionalise <value> in --trailer, by
> substitute user's identity if missing instead?

Indeed so.

>
> > @@ -131,6 +144,7 @@ OPTIONS
> >       when you know your input contains just the commit message itself
> >       (and not an email or the output of `git format-patch`).
> >
> > +
>
> I think it's better to not add this line change
>
> >  CONFIGURATION VARIABLES
> >  -----------------------
> >
> > diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.=
c
> > index 84748eafc01b..be7f502a58d7 100644
> > --- a/builtin/interpret-trailers.c
> > +++ b/builtin/interpret-trailers.c
>

Thanks for these kindful advices.

> --
> Danh

--
ZheNing Hu
