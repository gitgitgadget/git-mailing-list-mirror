Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992E8C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C216206C0
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ptifgr86"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387494AbgLAJwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728467AbgLAJwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 04:52:33 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC18C0613CF
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 01:51:53 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id q137so951022iod.9
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 01:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pupqPKLzj6DfT+WyBWiXaqO+tHAyAXs+3WscbdnmX6Y=;
        b=Ptifgr86nFX02VwsMlnspGzZZGziGJT1goaGO7+9GHuK2YVQJsB+5kc1Bj8RhcP5oX
         ++5bAkE/njZ6emGPRMZI0mMcB/ugFM0gxk/sVjYK+kNyG8ME7okhJmLQ941wi83uLVhs
         kruTFGAnJMo3iFqOQUaD+rDtEc39Acv3ptNPhsZiYa3Y4AbINb8vsKayrYMFrUKlooD/
         GjKzAtG/EUuoobagQ75Ouv4V3za4+lpJNuz8reYH/C2N33/vvtCMJ2WALzBsjH3n1t+W
         FnS8AaONAUxrDPXg1PhrnJdLPjCoKvBLJqCcvP3n4qnxGV9vHIj1WU8gD4roLp0eJ95b
         f++A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pupqPKLzj6DfT+WyBWiXaqO+tHAyAXs+3WscbdnmX6Y=;
        b=MgzzV4DBJ/shCTzxVRz5XZRnZToktdmH+YRAPrHQyJBALaRQxSivMjBzOvGV163Rvp
         CfB06bPU5ih1IatUHn/MiIV2nLnS7s7c5IxB1ftCMUZBQ6c6A2Y1ATcJQzMSktHBNSkf
         TqDtwd79AAEJIGsVYw2YS5KAOAjjnUtgzHnn7IsjCQANY5jTnVrXAKa5GxsiQSGNk5/K
         RVjq3GeetamBYlRi8ls/5dl5Np1hYwUtVOuep2MZPOSlnGl0LpGcMLevFvofIT9ZdUYJ
         kYv1Vy6QrSFHRxeuZRQfaZ0OOzZCMF2jl2xn9QU7GLfYtPYnJ4ZD54A0+HE+fyp6t4L0
         vUWQ==
X-Gm-Message-State: AOAM530rc/cIrZpPxPyq0b17A154IdcqL0UmTpXlMIxGwDMd9b2O+3up
        77UVC7GFvuWJHIJK+TP68UPkFf0InfDa2aovSdgnDw==
X-Google-Smtp-Source: ABdhPJz8xkjDlZ6m4/EeG/bFT4oGXQJt1wIRfzPGu2NaS3isE5E+n/QvR9COJMItkMBh0AyiuFcryUNz8fK7L4pkhn0=
X-Received: by 2002:a02:862a:: with SMTP id e39mr1887003jai.95.1606816312833;
 Tue, 01 Dec 2020 01:51:52 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com>
 <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com> <91c3ac2449edc45db643b0ba6cba66ef31176600.1606419752.git.gitgitgadget@gmail.com>
 <87lfennln8.fsf@evledraar.gmail.com> <CAFQ2z_NEkJQM6xtppW9kkAyjFrBeEiXmhhiPB8A7pmssjXHhKg@mail.gmail.com>
 <CAFQ2z_MXF0wO76tVTcBuJJp0CwjVoVfE11BOYYQ7Y7h1h_VwJg@mail.gmail.com> <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
In-Reply-To: <CAMP44s0zoekLZYQ=r516jjdsGGQ2Y7m1fXpwW2BBJsGjQ5sseA@mail.gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Tue, 1 Dec 2020 10:51:41 +0100
Message-ID: <CAFQ2z_PaPdiJC71WGdePFVgxyJFFHZY_DFbmLg9sRFm=vc7XYw@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] reftable: add LICENSE
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 10:21 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> On Mon, Nov 30, 2020 at 2:28 PM Han-Wen Nienhuys <hanwen@google.com> wrot=
e:
> >
> > On Mon, Nov 30, 2020 at 12:26 PM Han-Wen Nienhuys <hanwen@google.com> w=
rote:
> > > Until the reftable code is actually merged into git, I work on the
> > > reftable library itself at github.com/google/reftable. I've asked our
> > > opensource team if we could switch off the CLA enforcement for this
> > > repo, to facilitate back & forth imports of fixes.
> >
> > I've asked our lawyers, but this is not currently possible, unfortunate=
ly.
>
> Maybe I'm not understanding something correctly.

> Sounds to me Google has not made its mind about actually contributing
> these changes.
>
> Or am I missing something?

The restrictions are not about the patches themselves. They are about
restricting what gets posted under github.com/google/ .


--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
