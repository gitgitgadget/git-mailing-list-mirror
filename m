Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA59C433E1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 08:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1867861967
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 08:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhCVI2o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 04:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhCVI21 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 04:28:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5698FC061574
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 01:28:27 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so15133931otn.1
        for <git@vger.kernel.org>; Mon, 22 Mar 2021 01:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dmue/u3F4iHSP6fodgzEpFaBbd/kKc7HpXuBuc3mrKk=;
        b=IegCcRe/xBoqxgY0ng10vCGV73kerqmPNEgB0KXo/6hhw33AgoKTHdr2a9bnQdVNVe
         3tDn/7JOkADd6LURLfnSl3cVz5gmgEONu6n74BEainUjxQqwhvrTPC77UCQYXXGM42Rq
         z2rdtLth9Nla+cEpYBPe2MJcpKxRiZRliW7qy9/dH1/MK2fZHTfDE+mY0r8QjogAe4a+
         mxiZVNiMpjLBjYGMPkhMM189cu8o11c0b1Dfe/9LwnjFrm2NEKQjHjd+bq1cRY+hmekE
         XSFzSVjkBhHzcMKfTNolsg6+HujNU4O8iovdTM3cz35UCcafUTdgoinJ/cYzf9d2QI71
         y8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dmue/u3F4iHSP6fodgzEpFaBbd/kKc7HpXuBuc3mrKk=;
        b=OqRrIB1nQlAYLfhUm0ldC2GMCOEdOQQr+RcYp4hp4fg3dUET3sSscatEjQap+Pl90C
         jY1APe3CZ/IZ94PRQcWys6P/VfsZ1cKN+AX6KsoIz7b1/A5eBOcg83MjY/6QQE5eFoYI
         PLVO5awNzot2cD0BHudtO+satq8EHxxRGv4ydoiVM/acUQeh4/Isl1owa/+XJW8m7sFY
         YdUuR/RgsnIJPtCLZUfvAHkrR0R7SmN9e5Vtg8XAb5UbhB2qyAhGZbVM3XR2f6QnzONd
         /TU1ltoh949sp4PkOptr7Jn3wP4KQN/4LtAh1+UtboyW2Rg35gxOuAqh7XutjjJTD66F
         BthQ==
X-Gm-Message-State: AOAM5326PEneFkMj3OziIR4eQOYsZ7y74UC87dR7vWi0yqZCM3KXb2qD
        l6Z0lTkgmWoFSZq18gDWCSC0GXBNZLVZa/4WIpM=
X-Google-Smtp-Source: ABdhPJxm81KQWAp7g+1RWrctHBkWIXjQjKdrhnsuq3inhdzFkIOnpOYF8hqCIN3dIYLRFYv9+NfwOUSIRDgXk2xkGgs=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr10299807otq.160.1616401706789;
 Mon, 22 Mar 2021 01:28:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.911.git.1616251299.gitgitgadget@gmail.com>
 <pull.911.v2.git.1616317134.gitgitgadget@gmail.com> <8b8b236a4ffb81a8c6be3f320b878cea1d0f9d7a.1616317135.git.gitgitgadget@gmail.com>
 <CAP8UFD1Oo-eWmoV-1mh1M=pA8+yRUYHy1wg8NvN3bthmCHBfvQ@mail.gmail.com>
 <xmqqwnu0bga9.fsf@gitster.g> <CAOLTT8TU+XwLmDQRROHW6iumFgMKok9mi+_OBmN4FbvgWkNb7Q@mail.gmail.com>
 <CAP8UFD0TKFhpQkAk5apUXpEg=tEhHdZxL9USjfxVSiSyYzLT=w@mail.gmail.com>
In-Reply-To: <CAP8UFD0TKFhpQkAk5apUXpEg=tEhHdZxL9USjfxVSiSyYzLT=w@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 22 Mar 2021 16:28:14 +0800
Message-ID: <CAOLTT8TyEiLXsLAkpO2C+CzWz=uCmtOa0K30Rzx_zydZZ1mBpw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] interpret-trailer: easy parse trailer value
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
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

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8822=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:26=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 22, 2021 at 1:39 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8A=E5=8D=8812:52=E5=86=99=E9=81=93=EF=BC=
=9A
> > >
> > > Christian Couder <christian.couder@gmail.com> writes:
>
> > > > So even without this patch, after your first patch that implements
> > > > `git commit --trailer ...`, it should be easy to setup something le=
ss
> > > > verbose and less error-prone.
> > >
> > > It is nice that it makes the complexity of 2/2 unnecessary ;-)
> >
> > A little frustrated, both `--own-identity` and `@nickname` seem to be
> >  rejected. I will roll back to the first patch.
>
> It's good to want to implement new features, and to come up quickly
> with patches, but it's also good to give people time on this list to
> discuss the goals you would like to achieve, and which features are
> already available or should be implement to achieve the goals.
>

I basically started coding after receiving the first reviewer's comment.
It seems that I should be more patient.

> Thanks for working on this topic anyway!

Thanks, Christian.
