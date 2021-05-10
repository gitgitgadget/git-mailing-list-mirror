Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA2C43461
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A69E613B6
	for <git@archiver.kernel.org>; Mon, 10 May 2021 12:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbhEJMwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347933AbhEJMhz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 08:37:55 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA22C0613ED
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:35:12 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id z24so14599593ioj.7
        for <git@vger.kernel.org>; Mon, 10 May 2021 05:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X/PlFb13aC9EKXJWdEpZdcesdC5az85/RqJA69Z434o=;
        b=gOtHmtRTcgQbNj2bLTjWC6X1jzLg+OzqnEA7pU/w/bT2atukB7kyPDLMfTXmizMxmx
         KlgoWb0hIxJ7iRq8m6zNZfh72ygQF7ONgh6IlTRRDviHUpluRp+ru6TWIloMz3xO4Zph
         /xayFJpti2AeBbZ1ZEBd0RFPHhHMCMwL9dyca2i6E9dGovp7avp8azJOZqcxrkEzw0RB
         IZwljrbMetHm8Pdb306DGjznhhc2jsSAZIQZERNSt4/s3i/a/x+hTQWbIJ0ooMdhQ4re
         FxtKilc3Zb5uB2dVX1WBMiIi/94mVdYYWeka7qu/tjqmMYuQUv8mM6Ly8anJ3i9amXPb
         qtcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X/PlFb13aC9EKXJWdEpZdcesdC5az85/RqJA69Z434o=;
        b=OaEU6IINoQuZJbdytWqx2SboMxYRo3SxmBmL6EhFaJzca3+IeZXzuNEtvmPpotEAVR
         XsFVqZd7GqBC3i94lInHb92wmnwlL7kbj1LCWlRcyuMs6tTpEf9zE/qt7e/uaoE+1+uW
         NtkeL3zRZy/ipkp49KpEDmzgfa2FU1kT8xtilakyavcz/XXoWaYcML9Y1wfew7aLeBUu
         cCq15PWez7wIDGcyGwpIRL2JgF1PYx335P/+BMP2YZ8kvlnw+CPhrCL25E44MRc3wGxJ
         Gklf3VpzVhF7LTpIbu5CnPgcpJho2NDQOG1dsYmaGs2mmglg2KRLu+CNZm88faoINkqY
         O9Dw==
X-Gm-Message-State: AOAM530F7MgzfxniVW3MMoPCo75beGcFG+GPsitUh+2B0Bs18Hg0+WKm
        eN+2Ep8lW/vy8M+qwFlnslKgFLjs3goiPRysXsI=
X-Google-Smtp-Source: ABdhPJzk0FynnL+kQccl/Vw5BXMlcWU1W18flBv970fr9ZELWChQ8lD3F2Oe692I5hocAUTWIpa0hX6K09Oi7kIa3ek=
X-Received: by 2002:a05:6638:1242:: with SMTP id o2mr21412018jas.10.1620650112268;
 Mon, 10 May 2021 05:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <pull.949.v2.git.1620318676776.gitgitgadget@gmail.com>
 <pull.949.v3.git.1620487572222.gitgitgadget@gmail.com> <xmqqh7jbqck1.fsf@gitster.g>
In-Reply-To: <xmqqh7jbqck1.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 10 May 2021 20:35:01 +0800
Message-ID: <CAOLTT8T3yqbM8Ucey6Jfs2U75AP33B4d8W_Ab7ZYDQQDZX-4CQ@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC] ref-filter: fix read invalid union member bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B45=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=883:21=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > used_atom.u is an union, and it has different members depending on
> > what atom the auxiliary data the union part of the "struct
> > used_atom" wants to record. At most only one of the members can be
> > valid at any one time. Since the code checks u.remote_ref without
> > even making sure if the atom is "push" or "push:" (which are only
> > two cases that u.remote_ref.push becomes valid), but u.remote_ref
> > shares the same storage for other members of the union, the check
> > was reading from an invalid member, which was the bug.
> >
> > Modify the condition here to check whether the atom name
> > equals to "push" or starts with "push:", to avoid reading the
> > value of invalid member of the union.
> >
> > Helped-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     [GSOC] ref-filter: fix read invalid union member bug
> >
> >     Change from last version:
> >     Modify the processing method of the condition: check whether the na=
me of
> >     the atom equals to "push" or starts with "pushs", which can enhance=
d
> >     security, although it may bring string match overhead.
>
> I do not think this would have much security implication either
> way.  What it buys us is the future-proofing.
>

Ah, truely.

> I think it is OK to make this change without the enum thing to have
> it graduate early as a fix to the existing code.  The enum thing can
> come on top.
>

Indeed. "enum atom_type" is for ref-filter performance optimization and get
some other benefits like quick index. So I put it in another topic.

> Will queue.  Thanks.

Thanks.
--
ZheNing Hu
