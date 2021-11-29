Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EB8C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 20:35:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhK2UjM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 15:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232597AbhK2UhI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 15:37:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F3BC09675D
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:10:46 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id x15so74783626edv.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 09:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0kQfuCVail3s6ZFn/1pM04m6pR2QCz7nzQIDr1OWOlI=;
        b=iGBvi8WD+6nify7Ooh9v7ezm3H3zFLaMF+dvb9tnClcOtZgakwjMtfLOSfuvgTJSIK
         VzzeKWWyzwyVoOrkr7qdowPMU2nCCVxjtA6AvComQQ2vSJM9kPNYPdkWW7Yc72E6T9LN
         wdykSedSs1NXzyy4aucRXdQQ+h7qAmafyssQr+QHJrzBRwVQygk15OXBViajrz3FTqeG
         jvRdUwHQ0FcujdJIClzaMk8dyLqJoNOrWD5XHxOZhjM+0WuvJfs6MYiHZSucs2oelAQn
         3SoM3OygW3ZnhiW8QWW/ZwHuE9xIjk2UDMDz1kW48yXLrW33R+pch9JdtYp2cCxJKWG3
         LoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0kQfuCVail3s6ZFn/1pM04m6pR2QCz7nzQIDr1OWOlI=;
        b=X8k880UE2wJkKgW2ctanvEqidS8DUPh8/OinUzxvTn4UDGzO4cbxUj+8KbYyCo77fT
         8MP1JbFqd7/rOcS7oeMhuQpyBCffzyQcYYjd2GLeTpzWRQgNdEgZF7skzwHdCA9eFBNh
         2AnU/QpMu/Dy6NQiU/k8Gmj9akgM37KoOUeu87SnamR2hrZC/TRo9HCzmMv9HWp+oUjT
         SppSI0oylke4Xh/0g2i8FdkN0ry4mU3EOGr4hPDWaQa0nl60vS4ZPIxAksYX5yseWXq6
         km46lozaD7tnsAHqaEglhqVgPi9wGSMulwBFfsPaFu7auYpA/BdTHQnjlM5NCeeh5OOq
         CmZw==
X-Gm-Message-State: AOAM53201EXq+4Qum4sjd2ZWNOWxnOTe9g8L+3dBHVAuCKUFm1PBEiN/
        V9eUtiUU+ZPm5jZimeeqvJFpha7aJ3MDnEwWflU=
X-Google-Smtp-Source: ABdhPJwaQZitXHfc//EnmFK2m7iwzPD1eZgGbVDv41D7hTt7B1BiL1rZtqHGIncvIjrP7lErt85QWJ1GqLXr9Jc6h9g=
X-Received: by 2002:aa7:c902:: with SMTP id b2mr74669745edt.320.1638205844463;
 Mon, 29 Nov 2021 09:10:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.1076.v10.git.1637567471.gitgitgadget@gmail.com>
 <pull.1076.v11.git.1637681215.gitgitgadget@gmail.com> <6051ad9440a966124e9147ec344ee6d87c46944a.1637681215.git.gitgitgadget@gmail.com>
 <CABPp-BF-eYcJ7eS==VK3M2xOqf5z4KNK4dP6qd_UcfLO1NWBeg@mail.gmail.com>
 <36706841.2ec.17d6afdb326.Coremail.pwxu@coremail.cn> <7cffa143.3af.17d6b2371c7.Coremail.pwxu@coremail.cn>
In-Reply-To: <7cffa143.3af.17d6b2371c7.Coremail.pwxu@coremail.cn>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 09:10:33 -0800
Message-ID: <CABPp-BEOJs7E4Cn35UkzNAQ+Qp3me-ZPc36+LyaTnqi_RFXNAg@mail.gmail.com>
Subject: Re: Re: [PATCH v11 2/2] am: support --empty=<option> to handle empty patches
To:     =?UTF-8?B?QWxlZW4g5b6Q5rKb5paH?= <pwxu@coremail.cn>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbikgdmlhIEdpdEdpdEdhZGdldA==?= 
        <gitgitgadget@gmail.com>, Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 29, 2021 at 2:00 AM Aleen =E5=BE=90=E6=B2=9B=E6=96=87 <pwxu@cor=
email.cn> wrote:
>
> It is quite complicated to support 'git commit --allow-empty' extracting =
messages
> from an empty patch, because 'git am' has to find somewhere to store the =
parsed state
> for 'git commit' to read.

.git/COMMIT_EDITMSG is such a place that already exists, assuming you
are just extracting a commit message.

> How about directly supporting another interactive option
> '--allow-empty' for 'git am' to keep recording?

--empty=3Dkeep was already part of your patch series; I don't see why
you'd need to add a synonym (--allow-empty) for it.

I think you were trying to ask if you could just leave out the
implementation of --empty=3Dask (or --empty=3Ddie) from your patches.
That's usually fine, but there is a small wrinkle here since it was
your chosen default.  You'll have to pick a different default, and
possibly alert users in the documentation that the default may change
in the future if/when the other option is implemented.

> > Dears Hamano,
> >
> >    Elijah Newren has given two better suggestions:
> >
> >        1. Use 'ask' rather than 'die'
> >        2. When erroring out 'Patch is empty', print out a tutorial info=
rmation
> >           to help users using 'git commit --allow-empty' to keep record=
ing as
> >           an empty commit.
> >
> >    Should we continue to implement these features in current PR?
> >
> > Aleen
