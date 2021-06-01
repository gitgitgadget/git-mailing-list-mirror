Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67F0C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 11:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72256128A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 11:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbhFALCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 07:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhFALCC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 07:02:02 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F7C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 04:00:21 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e7so982031ils.3
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 04:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8EE1DnTiqP72kikJqIq+hcvsbojwGGKlwa5AVALkduI=;
        b=Jl/sS1FFvnDk/2SVhun2r7tNyhBOKoj5j61iXUvaTfxm+DptFS1Y32HU1vu3KBMY4g
         4grcTdoE2D38f20EFqreydTL3KbS1tT/xn0Kgb9g+bAVJUp/P2cHg1BCwVKDrVrdrnlU
         6L6XpfCFCY1051J7foyTqhLZw2qHfrL2BrKc//thEgfZ4S9tYpb+/Fe6s44k8onAI6h1
         aPPLbDIzZ7LUE6vQsatgpndFWzMgdZ+7rd7GS6yIB+hzFyX2stlKqx5scxGsdS8t4+lC
         L+bkZCYu8lS3lmIvGNVhLz6pjE8bkqE1um1ux/E4tKAUhZOrs1QUg8u8BtyNloZ1bPgC
         NptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8EE1DnTiqP72kikJqIq+hcvsbojwGGKlwa5AVALkduI=;
        b=lfYPKyvopKg+VpTg2ZbzageQGKkLWIxCzCWKSN9CLmZk/ehQAvMAGBOEpItT47+HYM
         P3F6onTnb0PskcoaNXA05J8GUTA4/Pw9hIxFcA6cghMexfuLQW5cubHqbZnwkY5Gx4ba
         esoEdU9JQDCt1LdyXiGmMgRRGhi3vDDEG8dvwd34MY+xv7NaXrUD1MUNzp3U+G+FgSO9
         khLlNuSMnPBOtJFcWn9PZtZ4gHv5IKsWDkhVRWIDbg8Z9C1SnbmGtG9Kiqc8HO7DdyeW
         xWwVYLAVkCMLG+SOE4zR7OOrYGVytv6UfC65WNObZM+IyjjU2PPUmRL20utmC2cmVjyD
         ebUQ==
X-Gm-Message-State: AOAM530KLWTC89SxxYqZXvTpYyif8z/iNRoiEmLZZagome0PENMiw+h2
        gjCJf+lFuD8FYksK6JYyBsGA+7c2TKTSnWPBg54=
X-Google-Smtp-Source: ABdhPJwEA3XiXlMc1oegPhj094lPGMtkEqyP9OWvSqSH8f1wpRheEOXnxdMqaOZOUcMdYdrLy8RSy2MimA5QVit8s7s=
X-Received: by 2002:a92:b0b:: with SMTP id b11mr16080802ilf.301.1622545220770;
 Tue, 01 Jun 2021 04:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.963.git.1622126603.gitgitgadget@gmail.com>
 <pull.963.v2.git.1622379718.gitgitgadget@gmail.com> <e44a2ed0db596ab0e0f484c25facb7da7214369e.1622379718.git.gitgitgadget@gmail.com>
 <xmqqtumjy2e4.fsf@gitster.g> <CAOLTT8QFW4UrwZ+OboYqkoT-oKo1Sz3JJ-Fp8b2RWugMOy5Cug@mail.gmail.com>
 <xmqqlf7ut15w.fsf@gitster.g>
In-Reply-To: <xmqqlf7ut15w.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 1 Jun 2021 19:00:09 +0800
Message-ID: <CAOLTT8STkD_2vhL7uCt1umgmfGBRKcuF7nWv+DpQ4H0dBSLJ0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] [GSOC] ref-filter: add %(raw) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=881=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:54=E5=86=99=E9=81=93=EF=BC=9A

>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> >> Doesn't this conflict with your own zh/ref-filter-atom-type topic?
> >> Shouldn't one build on top of the other?
> >>
> >> Or did we find something fundamentally broken about the other topic
> >> to make us retract it that I do not remember?
> >>
> >> Thanks.
> >
> > I am waiting for zh/ref-filter-atom-type to be merged into master. But =
it
>
> As you sent this that conflicts with it, clearly you are doing
> something else that conflicts with it _without waiting_ ;-).
>

OK.

> > hasn't happened yet. But if I want to base the current topic on
> > zh/ref-filter-atom-type, GGG will send past patches (zh/ref-filter-atom=
-type)
> > repeatedly.
>
> I thought GGG lets you say "this is based on that other branch, not
> on the 'master' branch" to solve that exact issue?

I'm not sure...I will try it after I rebasing this topic to
zh/ref-filter-atom-type.
I just remember that it looked like something went wrong with my base on
your patch last time.[1]

[1] https://lore.kernel.org/git/pull.870.v6.git.1613739235241.gitgitgadget@=
gmail.com/
