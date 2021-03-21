Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B196EC433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF5161947
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbhCUNu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 09:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhCUNuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 09:50:09 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EA0C061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 06:50:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso13284922ott.13
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=w8IQJw0zjI3lfuT5htyBB9wyD+mS8qLTzTJtaKrU15Q=;
        b=jVq8ZIrZuassrDm84KrM8XpTXHuycQdpVpT/E4bAzp5F8iPsu6L7r0RUtpoAq5/D87
         xM+rQvBOhXL94Fb6kv3/jJBvkQdMSRrZrrfb0KtG6YQ9S072frf+xkKiDfWWD3eEbT94
         43iPABT+njNx4LaMx7EC86yKSekCmNCoVrxUupWmkjuDEFOlP2NcbLsQn59JQ+tEvFMZ
         TYgJaKNNgoRFzdoyMyq8sA5Rw6hJ5mcpVxmHCDqCe1m9qaT6XyaC8cbf6m8oPgNZaW0e
         CYpHl8+ZKCUYeJ8NKCL25SPaT2fzbUGMJEtrj4uRGim776npEw/hQcfIkUJjr4kD1AA/
         uRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=w8IQJw0zjI3lfuT5htyBB9wyD+mS8qLTzTJtaKrU15Q=;
        b=flAdeCN8gzXZNeQCu2Qf1l5HBr8voJUPV2ksTF4/UZPerVGUlGBQXn1n15eKOcTXgk
         M44ejrfztJPuTD0tlYl9WNYLXe7/YXMLPb3Cg4BJpeRqfy6v9p3EQ4GDwcm6vmZpePk4
         CEW05SBb44SEt1BEaIm+hgm0b0r+1nZ9bvkAQEGeH3KO/+Sy/TAetmfb2i8eEI+Uz7Yk
         TphCTV36MXNa/APV3PtRtEJVwqvWOrmHjApHRo8rqt5HcY+tapPpnrBSxN/Vsglv15Vd
         tAPBrRRsQd9B/27QVJT3zulKqwFXfgrEA8aIVT+LxPvxCgibLnIOj/1D4rqfL0SWfkVR
         T17A==
X-Gm-Message-State: AOAM533J2Hqg6HaejRj1bLqLhOdd+laQVt8vc/Mr/AUkqwHyUj7Bujyv
        DBqB58GXXUcRjuo3CS5kwDpB1TYHdeWDB4bE85c=
X-Google-Smtp-Source: ABdhPJywnX9yoJXm0nSOtskqpKXs3UHdM4VaewabpSGIllnFGD90fSBDZTrYYYRomO9PaKP6aKAY/m+DRqaiqQ+qtqo=
X-Received: by 2002:a05:6830:8f:: with SMTP id a15mr8117552oto.299.1616334608659;
 Sun, 21 Mar 2021 06:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
In-Reply-To: <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 21 Mar 2021 21:49:56 +0800
Message-ID: <CAOLTT8TnWdOgxJSza3oiPt3jk478XQ_gSHH-iAAEYtyC7RLdoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Christian Couder <christian.couder@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8821=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=889:15=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sun, Mar 21, 2021 at 9:58 AM ZheNing Hu via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > The original `-trailer` adding some trailers like
>
> s/-trailer/--trailer/
>
> > "Signed-off-by:C O <Mister@email.com>" is often too
> > verbose and error-prone.
>
> The 'trailer.<token>.command' config option can already be used to
> help with that, for example:
>
> -------
> $ git config trailer.sign.key "Signed-off-by: "
> $ git config trailer.sign.ifexists replace
> $ git config trailer.sign.command "git log --author=3D'\$ARG' -1
> --format=3D'format:%aN <%aE>'"
> $ git interpret-trailers --trailer sign=3DLinus<<EOF
> subject
>
> body
> EOF
> subject
>
> body
>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> -------
>
> So even without this patch, after your first patch that implements
> `git commit --trailer ...`, it should be easy to setup something less
> verbose and less error-prone.

Hey, Christian,
`@nickname` can provides a "quick" way for those users
who haven't config as you mention. I hope I am not wrong.

--
ZheNing Hu
