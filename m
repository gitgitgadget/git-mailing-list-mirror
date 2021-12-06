Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9625FC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 17:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243512AbhLFRlR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 12:41:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbhLFRlR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 12:41:17 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5512CC061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 09:37:48 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id w1so46188223edc.6
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 09:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SbIGcpTWQ09xUFLaSnZvRdysvTKxtaFJQ6lEtoXrlAg=;
        b=Rj5LYXqQpUoa4KG370uBJo1Q4KNXkdWUKP0e9jcE4ybvSUzczMnfIHJpx9ZP5J94rx
         uOCq8CW7WNlIEEnktlxmJ2+uo9g69VmATWkJPUe+Evma4S6ILhQci1zMC1D6dI1QUCy0
         yozEesRPLDKe6OAVC8SgyRFZCmXr1HG3DiA72hBZ+dIDqZ6JhKmFX/mFILEngteJuJlk
         aNlyjJRBWmYRflVMkstB0kvqpvtcPrQPvUiQqMFf/kHuxnPmpLVzBUTbYGYAXRgVQEMS
         2Hs2sgc1YRNNHa46sCx8o/ALAPUaT04U3LOyzxBWiWVKOUOQM09KOj5UB8CyAy1nW4/E
         C1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SbIGcpTWQ09xUFLaSnZvRdysvTKxtaFJQ6lEtoXrlAg=;
        b=XjDeBDVcqNpR5fsU5H0F5FB/prWfew8LYUOPKvkAxJxBphIzWKNrXys2mLsWltR0jB
         uyLH9xTkfDkYW+PNaFLLDS5OHIBqHj3tX1RY0f/hsGqYUHv0Ipj6R+tvnGTch5S0Lis/
         pR1Eg31GP6FtBcA6sJjR3JL0q5Q2ctDqJ5qzKMHuLjbbAZVo5v+PbSFfvfap9kKOE4B4
         0PR3baRrOPixFK6ywPB5Q3OT8UZz/anCUB7sToZdeDBz2k7Gbrt3JtVQZ/iop2PzvaKn
         NXCmYenha0zpEuxHGRzxaL+fj7vDu4vBqzA+PoiMYwKLeeUD1Vt7cUCNIe2iqEVwbFP8
         FnRQ==
X-Gm-Message-State: AOAM532+VYuoH229M6sI3zgMkxbNLUhRePsmpUpTATDLeY6DKxTznxAl
        6I/y0TZCmVvHKKz/gXE3D2RUaiB6PNeOhL39ThM=
X-Google-Smtp-Source: ABdhPJw2/hEx21aXPVUkufT4XKEgbvYa+HkY/6aRZkZe9ECkMxrC5CWKUX1RdSSP/72vbt55awQwLppNyl3ejr4/9M8=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr636259edb.175.1638812266884;
 Mon, 06 Dec 2021 09:37:46 -0800 (PST)
MIME-Version: 1.0
References: <xmqqzgpm2xrd.fsf@gitster.g> <CABPp-BE4uYBFnb-AgVJhNo6iK4da5hiEFEBhd=7Ea3Ov=4K4zw@mail.gmail.com>
 <d95f092.3f.17d73a85761.Coremail.pwxu@coremail.cn> <CABPp-BG9jHaJYekDnvZT+8QW_fLGM_bmz-oOqzJswaotyVDFBA@mail.gmail.com>
 <211203.861r2tsfej.gmgdl@evledraar.gmail.com> <CABPp-BGE5Ff=adH3nREMDm38DGLEmtRTcPwuJowHw-ckwpbmqQ@mail.gmail.com>
 <211203.86wnklqx05.gmgdl@evledraar.gmail.com> <30b4169a.18.17d8d589b6d.Coremail.pwxu@coremail.cn>
 <xmqqilw2i6w1.fsf@gitster.g>
In-Reply-To: <xmqqilw2i6w1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 6 Dec 2021 09:37:35 -0800
Message-ID: <CABPp-BGk9fYqtuYTACmzdXakpV7TP635eqHtHxkoHRT3aa4qFQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2021, #07; Mon, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 5, 2021 at 10:28 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@coremail.cn> writes:
>
> > Dears Hamano,
> >
> >     In my opinion, the '--empty' should act as a strategy option like t=
he
> >     'X' option to 'git-rebase'. Since that the default behaviour of not=
 passing
> >     the option is stopped in the middle of an am session, should the 'd=
ie' value
> >     dies the whole process but not the middle state? It may also make i=
t not
> >     confusing.
>
> Hmph, unlike "git rebase" or "git merge", "git am" does not employ
> different strategy backends, so "-X<option>" would be out of place,
> I would think.
>
> Among what we already have, what kills the entire session is called
> "git am --abort".  Since I do not find it unnatural to say "'git am'
> dies" when it stops and gives control back to the user, so that the
> user can decide what to do next, I am not sure where the aversion to
> the word comes from

When I first read the documentation, it sounded to me like it was
implying an abort.  I find 'die' very unnatural as a way to explain
this behavior; it's too strong of a word.

> (on the other hand, I find 'ask' highly
> unnatural since we do not ask anything---we just throw the control
> back the user).

Okay, but what about my previous suggestions of 'stop' or 'interrupt'?
