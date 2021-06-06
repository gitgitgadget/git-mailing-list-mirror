Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201DEC47096
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 09:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0368C61420
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 09:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhFFJJW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 05:09:22 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:45835 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhFFJJV (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 05:09:21 -0400
Received: by mail-ej1-f46.google.com with SMTP id k7so21412748ejv.12
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 02:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=swyoKh+Km5gBweyWskWH74HHZMePNseLrm5HskFSkcA=;
        b=oGHLcM+nJn8nbBMEZrlBoGKJRDj91Jtqx0dPfCCw1qBm57AHlxkrWzFJ4q33pS0L2G
         rlNNI9wOWbn1CIugA4SIEGDZtfd8f91ZXWUALl6JD0hSSGqW8IbPtW0Ohc3dxDQKTIIJ
         eZ393eK7WugQxvtx1G+0ruNnz63dhtkFigciqcbsOBpq81T0sVR5pNS7xY5Ssuo0YMb5
         MKZ5yxwFshvPHwI2u01g725p3iIJU/QAl/SuwzyFNefhMug3ISacC0i4WBh6cuhCelYW
         S+yDXttwRCo+TxPCDwib5b36Q15zh0DkIZ/zftf8l70NeVkoVwyVo13R9T3+wFgoDttW
         e1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=swyoKh+Km5gBweyWskWH74HHZMePNseLrm5HskFSkcA=;
        b=odkEPnv8AWhNh7PN78wY9wTRxUetRela2jNEv6HmiY5ySvUsiXMmbefucqJJjM7rVl
         5wSUurzjiTL/rPwowPqecE4OmjGhVOLY7PhtTVpwWYG/C7IbVtF4B1PgcTGJ9Mc4nsnH
         fXU4qR+7SlDiH5uKkWfR4Q2ckw9ihfxRQBdFlOLzcTahe6zavCLbFAGM6rW3HphUarIt
         nmb5CJgdr9Js64P9XiQJfnvyOw3DnNzgBItQzv0Hfo4SlYEoh1FJWvGcMhFVqzknhLDg
         OpyjWuQmIuiPcTJoIgm/cPapJ2ngVl0ADIRqCNqqjgLeSDlIAaGhAJqjsQnj2yQVYp+X
         kWtg==
X-Gm-Message-State: AOAM5320EQTV4Vfsp6PnKFbmoYv0jeKRMhkNmKknM/ya0HnnqeJF6neB
        0GjypmjnPmGJPpXLEWqvTeVQvsMNqZogkY/mYs0=
X-Google-Smtp-Source: ABdhPJyjeacndm1NxQ9NhKQTuBcodK9n9wI4/FS9oCg2InGPOr9Zo+Ekkg8q0RlBNzbbnkmEaqJtPvL5zxcL0Dcq5a0=
X-Received: by 2002:a17:906:2481:: with SMTP id e1mr12836779ejb.216.1622970376642;
 Sun, 06 Jun 2021 02:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210605113913.29005-1-raykar.ath@gmail.com> <20210605113913.29005-2-raykar.ath@gmail.com>
 <2422ea94-473e-2fa9-a3cf-f22f941e9b44@gmail.com>
In-Reply-To: <2422ea94-473e-2fa9-a3cf-f22f941e9b44@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 6 Jun 2021 11:06:05 +0200
Message-ID: <CAP8UFD0oXjxRCXi12nVWtKWBm+tAOcRhZ5g+1tM8qP+5nKbLpQ@mail.gmail.com>
Subject: Re: [GSoC] [PATCH 1/2] submodule--helper: introduce add-clone subcommand
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Jun 6, 2021 at 5:38 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Hi,
>
> On 05/06/21 18.39, Atharva Raykar wrote:
> > +     git submodule--helper add-clone ${GIT_QUIET:+--quiet} ${force:+"-=
-force"} ${progress:+"--progress"} ${branch:+--branch "$branch"} --prefix "=
$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${referen=
ce:+"$reference"} ${dissociate:+"--dissociate"} ${depth:+"$depth"} || exit
>
> What is the exit code you mean in case of error?

The exit code of the above is the same as the exit code of what's
before `|| exit`.

For example:

$ ( ( exit 10 ) || exit ); echo $?
10

> >       git config submodule."$sm_name".url "$realrepo"
> >
> >       git add --no-warn-embedded-repo $force "$sm_path" ||
>
> Is `git` executable that found in $PATH used? I have both
> distro-packaged Git and custom-compiled Git installed, and I would like
> the latter to be able to use git-submodule from its own install prefix
> (/path/to/git-prefix or whatsever).

This is a different issue than what this patch is doing.
