Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0037C433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 00:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9CD36192C
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 00:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVAjh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 20:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhCVAjV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 20:39:21 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A112BC061574
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 17:39:20 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso14293551ott.13
        for <git@vger.kernel.org>; Sun, 21 Mar 2021 17:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3BfcwI5C06hLJV6WUhFHAOSoRVkvColOTJrEYxDg7mw=;
        b=PNYd5+Dhng2kaDTFHRN+CIpnPBMaARoDEIf153faSOGNMYo7nSK/Tt20gDHe9UPaZM
         ZV/y8V7wulSHB4ecPQfnAiFddnuThUbOXWtZsx7meDfYQhA6nKKXci1sPCVjkrrs84De
         WIF2twCToRq4ZLCOkwYoZP/MZQRkGd86ASx9SUGMoZVUURuctkuoM+X/1hrCeFXdC5bB
         6490LO9glcUAyhlgjg9COovX/2lcte5ce8umWR0fdHEb6h/pIcbMvLVPIiYHwnd2LWLG
         SXTnVMMjqZ06awKTd84SA2m7c1IWM2gJuYAJM0jA+dvgQ/rWp0jF/YZKygkXhtVEbuE8
         WOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3BfcwI5C06hLJV6WUhFHAOSoRVkvColOTJrEYxDg7mw=;
        b=qwKqVc0ruMSk2wQAIaURTfJQA/FfbtQYIRFq9X/KiH4P8Li5TAN8GY616v+rkS32sT
         VVpDZjth//ljvMCYKDz7WAIzpfCpYikvWC+7tW7uQkISPOtL/MCyZMoTP2FZPaYGeZk9
         E4nsHbfFz3mdFtBnF5qtTDr9ZSebSqU2G9xLd2bcteG2JP9KDJ/qBprLayvhkW5LK66F
         9G35GChq66Zib06KVkuGQsQV+5ZpF2T05vz6ZDM0TdQoWH+X246vmnDOma6wM8/qzRq9
         hSFESmBHNG39tVTjRWXYinBn79paafedmZ145MQtSCF45A8Fdys9YGiKqH3liZHXhu++
         73tA==
X-Gm-Message-State: AOAM532jKIwHu8Ze53G3QSzoxpjL1yQDgL0FgAki0aG2QWry+xF1hOas
        1S3jxmMM1jR5gxcvXpGcqr9uDqoE5XlalaCn6Oc=
X-Google-Smtp-Source: ABdhPJxH04uazDzSnXwxybJIH1UgUrnde4zNjteD/FoVc/8g4iW2st0HsgKFLiZmuuBqeZGriFJNa0oBsz19styiYtQ=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr9571833ota.164.1616373559877;
 Sun, 21 Mar 2021 17:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com> <xmqqwnu0bga9.fsf@gitster.g>
In-Reply-To: <xmqqwnu0bga9.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 22 Mar 2021 08:39:08 +0800
Message-ID: <CAOLTT8TU+XwLmDQRROHW6iumFgMKok9mi+_OBmN4FbvgWkNb7Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=9A
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> >> "Signed-off-by:C O <Mister@email.com>" is often too
> >> verbose and error-prone.
> >
> > The 'trailer.<token>.command' config option can already be used to
> > help with that, for example:
> >
> > -------
> > $ git config trailer.sign.key "Signed-off-by: "
> > $ git config trailer.sign.ifexists replace
> > $ git config trailer.sign.command "git log --author=3D'\$ARG' -1
> > --format=3D'format:%aN <%aE>'"
> > $ git interpret-trailers --trailer sign=3DLinus<<EOF
> > subject
> >
> > body
> > EOF
> > subject
> >
> > body
> >
> > Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> > -------
> >
> > So even without this patch, after your first patch that implements
> > `git commit --trailer ...`, it should be easy to setup something less
> > verbose and less error-prone.
>
> It is nice that it makes the complexity of 2/2 unnecessary ;-)

A little frustrated, both `--own-identity` and `@nickname` seem to be
 rejected. I will roll back to the first patch.
