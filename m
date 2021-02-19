Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863C3C433E0
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 11:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3033064EBD
	for <git@archiver.kernel.org>; Fri, 19 Feb 2021 11:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhBSLCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 06:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhBSLAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 06:00:50 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51D7C061574
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 03:00:06 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id g6so568176otk.11
        for <git@vger.kernel.org>; Fri, 19 Feb 2021 03:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kCGXcihDoWbKcYmnta5apE67onFv9s9KfTVwoah8yok=;
        b=BZwGsOgLB4IiZhXhv2cBf86X1xRAVX16xK9+JuOfceVhWPbVnmCEIi0aovxJLMSK2e
         KboQW5Vf3iOGurpJgeM68hMPdNFx8EG1ilTENJMnTEgM686vssdd2XShxTMVJUlaBp4Q
         67FWUzPRZJGJ4aV2s/ukplBVdjsCvbVm7ORGFJyj1Ol5lVuXvudaVEAKPc1CC5ECh6MM
         fhoZ84sBkqVWozz13sQaNfJ/JQnkgPfMMDLLD3rFv9IQ3MsjOZT0FajUcgOu/oi5Wykn
         hBybqZHTlJkXk7dQhluSB0njz3mEGIG/jdG2hzvndLWhIapljxGp30XfHUr9FupQmvPh
         Ksew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kCGXcihDoWbKcYmnta5apE67onFv9s9KfTVwoah8yok=;
        b=J4oumJgTpKaM3kqjr6TeCDDbKTOlXal51QtZe7Fv5jlJq4iL4YZMUZ/DaC/85eiLI9
         jFsC8cpsF+UVVV6P7pyBEQCUze39YGTlkduRxkKXWmRLOjnBdy0wTT5Wy83sPHj5n6HR
         ELWtEWEPU8xmc0MuNmLxAvhfuCXrawnPnQ7LwGNUxBudeYIowABADd3B/Sfp1LifzivQ
         g8vXwZig2MuiqpvgmLlX8H4qjbKFfspF0LOybFvKImpmvg08eZgVzYtY6OLEYIFdSCA+
         DaIYvt6/kKolilaQ7dlghSEhvZosGqHMebf9Izc+h1Jzx62BaqVTjXC/IhCWIPBwKWaH
         Sfng==
X-Gm-Message-State: AOAM5326JsV8LEybSTbD45Wj7bHE30ObmWsqEY/pKjdT7JOzMZKb2XN6
        hqww6gD7e2Pe3rwzS9nTJIhbKwdcACAftAIzjO8=
X-Google-Smtp-Source: ABdhPJwYGz+n8iIYRQjR6AIxeURp2lDu6MaIX38WzSHWoaPgzrXg0T/SqO+Mb+l0aUcQ0DhsduxmnimSP6TiBP0qgGo=
X-Received: by 2002:a9d:4c02:: with SMTP id l2mr1501501otf.299.1613732406133;
 Fri, 19 Feb 2021 03:00:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
 <pull.870.v5.git.1613480198.gitgitgadget@gmail.com> <xmqqblcjrgvc.fsf@gitster.c.googlers.com>
 <CAOLTT8T=R-M1eK9thSuzHNOJ8wkaTX3yYsLEgpqmHiEYWgM1XA@mail.gmail.com>
 <YCz6oDZCAODPS8sY@generichostname> <CAOLTT8Ri+XbSg_=KaLOCmNX4Nrii1ssN9_FFbnmm7ew4vYN5nA@mail.gmail.com>
 <xmqqo8gile02.fsf@gitster.g> <CAOLTT8QNbTeSJfo2O7f5vv6Q9ZVMrkGjRCikc4P7eN7M6aeZdw@mail.gmail.com>
 <xmqqy2flfay4.fsf@gitster.g>
In-Reply-To: <xmqqy2flfay4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 19 Feb 2021 18:59:55 +0800
Message-ID: <CAOLTT8QUsrKPnCkbbz_4G6Z-4PRfK8H_pz_4YMzXKdACNNxT2A@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] difftool.c: learn a new way start at specified file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ok,hope these problems won't make you unpleasant.
 I will try to solve these small problems.

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B42=E6=9C=8819=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8A=E5=8D=883:11=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > I think my patch is stuck in GGG, and the current version is after I
> > cherry-pick your patch and my patch on the master. Because I don=E2=80=
=99t
> > know how to based on your patch but not submit your patch. Is there
> > any good way?
>
> I am not capable of doing helpdesk for GGG but I think you can send
> two of them anyway with the title of the first one munged for
> reading humans to tell them not to use or even look at it ;-)
>
> GGG may send both of them out, but the ultimate objective here in
> the exercise is to avoid the unwanted first one to waste people's
> time, so until such a feature is implemented in GGG (or there may
> already be one, but we do not know it), that would serve as a
> workaround.
>
> Thanks.
