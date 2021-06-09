Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40300C47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7816128D
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbhFID7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:59:03 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:35766 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbhFID7D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 23:59:03 -0400
Received: by mail-il1-f180.google.com with SMTP id b9so23181585ilr.2
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IWXryYtDCvITzJlvd9jsGhCXrUhcFhQXipRYebtNaVk=;
        b=gEGrJV1Fs9mpJemVyFCRxRzp/5RhVUZ+cCY7heJlaOdJXe0TklYXELMpNHzTNb3Gai
         CMAhFD/ozliuMAD3ZL5rOqqxXKzybk1fpAmJ/udGr1TCoh+6HL+Rd05n4IwO76ggnUlw
         evh2agADd0ryaJIjoS6YnnFcH7lMlVNa578YYmlHx8kRYoD0GT35mkXRofrwK+Cr8C2R
         O/Y+0S9FKlbWvoUdxwMtC5dw0h3yPPzID8naYU9LwFbWsDl8cZqYi4H7K5y5hQvtddb3
         QCa6+r/HhcEAhh5N0PnZ00iYFNk0oSyrLt7D7g46ddDfXG07sisN3hD9MTYrRr7vSBA4
         FA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IWXryYtDCvITzJlvd9jsGhCXrUhcFhQXipRYebtNaVk=;
        b=WbKHt5z2QkcdkQ25F5LedmbPMcJopz5kVyZwmXEXlwxCUDSsNrrMANBXAIdmWzdmvq
         a9IeJ7BPEL/TbY/feT1fNRxF+lYWcjERMkJGi8VB5swtlf9EEjYEp0Rci/RiF6bgd6Nw
         xQJAV4p2ohlPwRY3xjgcetUepSKtBb+A/Ru0J7bZJ9LZ0sj3RgHgsUP7PF07GJYA3UC+
         EA9W/ebqNyiofqRdSX+jDF5/EEkTIjoVC8SnOHyQh9aGAnzzMTEsqKNPZgGs4A7I1kA/
         LS9OO8/blzt0OnUAZ+TQqM32xoIJ/D+zoiKoOcekknKwnDr2o2vf3u9+QRkxSgks+xUv
         wDBQ==
X-Gm-Message-State: AOAM531fiRL1wrPS371sndycjsbB1z7ClvU78HaeNo7ZLP6DD695Yc6z
        wOnfgkSxwnDpz/jQYXmCb92TEzIXTIgzBUz9APk=
X-Google-Smtp-Source: ABdhPJylJB4ATuf+TovuTF3cH3azuapjRTdiVhtOdJftHO0Vmy4P5ZkXx2bNetDVtWSzBeJR0RLdHK9knVXXjRqyOtE=
X-Received: by 2002:a92:2004:: with SMTP id j4mr22683768ile.53.1623210954276;
 Tue, 08 Jun 2021 20:55:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.976.git.1623163082.gitgitgadget@gmail.com> <xmqqtum7ln9m.fsf@gitster.g>
In-Reply-To: <xmqqtum7ln9m.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 9 Jun 2021 11:55:43 +0800
Message-ID: <CAOLTT8RURwom91VqFATjMEGGe5NJRgyWSojCC=TH8DwG+7MeSA@mail.gmail.com>
Subject: Re: [PATCH 0/4] [GSOC][RFC] ref-filter: add %(rest) atom
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=889=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8811:39=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > In order to let git cat-file --batch reuse ref-filter logic, in this
> > version, the atom %(rest) is added to ref-filter.
> >
> > Change from last version:
> >
> >  1. Deleted two commit about %(raw:textconv) and %(raw:filters), their
> >     construction will be after letting cat-file --batch uses ref-filter
> >     logic.
> >  2. Exchange the order of the definition of "cmp_fn" and the declaratio=
n of
> >     "a_size" and "b_size" in cmp_ref_sorting(), to avoid breaking
> >     -Wdecl-after-stmt.
> >  3. Delete --rest option, "git for-each-ref" family will reject %(rest)=
 by
> >     default.
> >  4. Add GPG prefix to some %(raw) tests.
> >
> > ZheNing Hu (4):
> >   [GSOC] ref-filter: add obj-type check in grab contents
> >   [GSOC] ref-filter: add %(raw) atom
> >   [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
> >   [GSOC] ref-filter: add %(rest) atom
>
> Thanks, will replace.

It=E2=80=99s worth mentioning that this patch still fails the github CI tes=
t. [1]

t6300-for-each-ref.sh:
274: Verify sorts with raw
275: Verify sorts with raw:size
278: empty raw refs with %(if)

There is no such breakage on my local machine.

[1] https://github.com/gitgitgadget/git/pull/976/checks?check_run_id=3D2774=
963705
