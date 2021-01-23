Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435B2C433E0
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 08:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5511233EF
	for <git@archiver.kernel.org>; Sat, 23 Jan 2021 08:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbhAWITJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jan 2021 03:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbhAWITI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jan 2021 03:19:08 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 078E4C06174A
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 00:18:27 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id f6so7543100ots.9
        for <git@vger.kernel.org>; Sat, 23 Jan 2021 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=L14v/AJfDjtFDATx8hiY6Ej4GEt+cvciZKzWS8kqTSw=;
        b=iBj0o2kKNZhlCNixha9o176gIFUb2Ikg68zHifXPlrqhRYlJSwdLuDo0djLLZZAsda
         Yag0SeMuSd7gv9fecE7Kaetk4pJHRNbUJCRzO1R9rYWfvFuHova/LYx7vfBsbqhldXrw
         xEEnuyaqkrk7Vpc3dIFvHSduUosOU7MfHchtOb6OP2fKzXbkd1zlIklBZ+3vPJ2td5KF
         IzGEGD5iwPcdZtJ3+wrmQJoR98JB1/OYMzgIDqeQJjYH5WXq0uD0Ozm2KCg+kiylCNJb
         ITxveKrvUNNK16mwcGpcmeEYLOGV/jWuZqvOxheLdb8hFLGrcOiFpLv1S8SzS5UyYHoX
         j/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=L14v/AJfDjtFDATx8hiY6Ej4GEt+cvciZKzWS8kqTSw=;
        b=tTix4PRLkPMNMQx4/TY87aULjoEtErxX8uwQcgWdtbXMoTHxeitbKxEdI2UzQSEKmA
         X7vAxDmaqvQZatqjep+eLOuMQdHGkJtLJ9YeXx+u4AuC2dbStCB+IzShgz5N4w9b5sZ3
         O36tKU3KuO1NVGFjnwTKNKUwKcqQrUADv5rFkmMYLOvPIktjqNlqJjiTWMpPXhYq1aXl
         sVEWW35I5osw3++X+JNMG1JP48fwCo2VZ+sJB/rWsdLMZ2/YZUDcBHwUCaW9vsKDA2Xr
         HsY0b/5ElfmZTEPiM2CNsYxzaS6iNePEPPnDxBXfE0jyP9ucQX1v1Sa0bKYTl92JxDGP
         lGJQ==
X-Gm-Message-State: AOAM530lXhOKrIRUHggmFjgKhxZswx8m6naTIo4q82b2fI8EztlKrvo2
        4x6StmzWSdCQQaeuamDzks8syPl2pZn3CUjskOk=
X-Google-Smtp-Source: ABdhPJyLYL0l6HY0rAgVwWL/FYALzildLc3hfYLMLOx0Gmh08BgIfBI0QRPO06coOflmXTcU2hnQSsDFcf9SLNOUESk=
X-Received: by 2002:a9d:4812:: with SMTP id c18mr5769456otf.160.1611389907278;
 Sat, 23 Jan 2021 00:18:27 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
 <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <e9c5318670658b032ba921129859f9fb3b2ca017.1611037846.git.gitgitgadget@gmail.com>
 <xmqq7do7fggn.fsf@gitster.c.googlers.com> <CAOLTT8R=fF00WCVBSTDKHG_3p5RcZaxM2AU-cUj1sNWvy=mhCQ@mail.gmail.com>
 <xmqq1reec943.fsf@gitster.c.googlers.com> <CAOLTT8Qp2NMpbk56U6PVEmFVyZYWN6gM83HD4z_nmPWV4Z_ruw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2101221702420.52@tvgsbejvaqbjf.bet>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Sat, 23 Jan 2021 16:20:02 +0800
Message-ID: <CAOLTT8T1MRVcZxsF6cum8F7aXA=58CBjoD1+SJh3rhPx2zS++g@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] ls-files.c: add --deduplicate option
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes Schindelin,
Thanks for prompt me how to choose, maybe I was a little confused
about the git workflow before, "zh/ls-files-deduplicate" this kind of
 branch I don't need to operate,right?

Well, then I will modify my code on the original branch.

Johannes Schindelin <Johannes.Schindelin@gmx.de> =E4=BA=8E2021=E5=B9=B41=E6=
=9C=8823=E6=97=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=8812:04=E5=86=99=E9=81=
=93=EF=BC=9A
>
> Hi =E8=83=A1=E5=93=B2=E5=AE=81,
>
> On Fri, 22 Jan 2021, =E8=83=A1=E5=93=B2=E5=AE=81 wrote:
>
> > And should I still use gitgitgadget PR on my origin branch "dedup"or
> > send patch on branch "zh/ls-files-deduplicate"?
>
> The way GitGitGadget is designed asks for contributors to adjust their
> patch(es) via interactive rebase, implementing the suggestions and
> addressing the concerns while doing so, then force-pushing, optionally
> amending the first PR comment (i.e. the description) with a list of
> those changes, and then submitting a new iteration via `/submit`.
>
> Ciao,
> Johannes
