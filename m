Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A190AC43334
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 11:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiF0LTI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiF0LTE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 07:19:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6275654F
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 04:19:03 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id o4so5763653ilm.9
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 04:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqcYKgdQqx/aAQzLcfFXoB0j4CpMmAQhatlgq0JjKgM=;
        b=mwpQ+iQaO1XIVkPsoTyBJP1C8faTfs4CX9tMLkFdPMSERXE0Xv9GwXa7COvkJSJxgu
         KqttfI/k+IAG7FLcNShWcQKEuGmn/P1zuwU2amATyLpcg0mDIurUSKg4MaeGXqq8erd8
         o05Ys9r7bghxmCG3n5d4ZjBRFor5joJjBtcE3GeiQfZQoz0GIWGw/FHnTGBG2+poXw9g
         MLSbvre5aVOevsSBubo6Ts16xaZ23Hk+nCGRbx6rpZEYv+r2A3JkXKUXipjn800lOW1H
         oX3cfaBr0pk1lifgTgocB7E4oIKlpcm5uymVdknTxHd2V2xftgMZQgisFVGo3akCbtID
         R7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqcYKgdQqx/aAQzLcfFXoB0j4CpMmAQhatlgq0JjKgM=;
        b=qHfZrPcrzyx120wEmUWPZ0Ei5S4kqMo+zMxIrDtnKfSfZnrfPO7Hxmg67o4pblk76N
         uu5Xrb2Q7cNGiRA6O+1lSk0ODYDy8lHz+K71HZIlReswq7BD6Ypd+O8l+jNt6QRcGpSc
         cC54B5TcQaXlqA9u7T/SY+AudclUKnipaAshkt9UsVEc9nvkptHQ/vcAEih62ViJLjEH
         18ingYtrmHyOIaiE9ca5imWsRiZSJgObcHt5+qXQt/F2Yc1D9IVwB0NkqxtQyAs37rbC
         f5cKXt1TS0rbb0nb2WmnASr8SSL4qJpnk8gqmPvj0TAJA0QoFiMJCwSDX9YbWiJ6TN+W
         q6hw==
X-Gm-Message-State: AJIora95QeseVlb7rRdiuvz12vJj6nvjpy1q61cA+kI525rR9WWanIo6
        bgEI1PhKF913o5EUdBW9lG/zFQuu5DjTBHZjHbc=
X-Google-Smtp-Source: AGRyM1t0HNdbqR9hwM4Iokj4MV+5xlMDBnDxPr/hOtnkLZV6Yf3W92R5lnjOKYYYjLVOkGhAcS6nMrkGsoO+oAvFPdE=
X-Received: by 2002:a05:6e02:1bc8:b0:2d4:342:9c68 with SMTP id
 x8-20020a056e021bc800b002d403429c68mr7012787ilv.254.1656328742902; Mon, 27
 Jun 2022 04:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1262.v3.git.1655777140231.gitgitgadget@gmail.com>
 <pull.1262.v4.git.1656257376109.gitgitgadget@gmail.com> <xmqq1qvase0o.fsf@gitster.g>
In-Reply-To: <xmqq1qvase0o.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 27 Jun 2022 19:18:51 +0800
Message-ID: <CAOLTT8SkJgOUi5dmSQOsg=E0_WtarPWRM-YRcF96gEAkwbb2TQ@mail.gmail.com>
Subject: Re: [PATCH v4] ls-files: introduce "--format" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2022=E5=B9=B46=E6=9C=8827=E6=97=
=A5=E5=91=A8=E4=B8=80 16:32=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Range-diff vs v3:
> > ...
> >       +test_done
>
> I omitted 300 lines of range-diff, which is not exactly illuminating
> in this case.  I wonder if there is a way to turn it off when it is
> not helping automatically...
>

I have make a issue to gitgitgadget, maybe Johannes Schindelin can
give a help: https://github.com/gitgitgadget/gitgitgadget/issues/1024

> > +FIELD NAMES
> > +-----------
> > +Various values from structured fields can be used to interpolate
> > +into the resulting output. For each outputting line, the following
> > +names can be used:
> > +
> > +objectmode::
> > +     The mode of the file which is recorded in the index.
> > +objectname::
> > +     The name of the file which is recorded in the index.
> > +stage::
> > +     The stage of the file which is recorded in the index.
>
>
> > +eolinfo:index::
> > +     The <eolinfo> of the file which is recorded in the index.
> > +eolinfo:worktree::
> > +     The <eolinfo> of the file which is recorded in the working tree.
>
> These sound somewhat strange, as the above makes it sound as if we
> are recording eolinfo for something (we never record eolinfo of
> anything anywhere).
>
>         eolinfo:index::
>         eolinfo:worktree::
>                 The <eolinfo> (see the description of the `--eol` option)=
 of
>                 the contents in the index or in the worktree for the path
>
> perhaps?  I dunno.
>
> > +eolattr::
> > +     The <eolattr> of the file which is recorded in the index.
>
> Likewise, eolattr comes from the attribute subsystem and not
> recorded in the index.  It is more like
>
>         eolattr:
>                 The <eolattr> (see the description of the `--eol` option)
>                 that applies to the path.
>
> Because attribute applies to the path, it applies equally to both
> what is in the index and what is in the working tree.
>

Thanks for clarifying it, I will fix it.

> > +path::
> > +     The pathname of the file which is recorded in the index.
>
> As ls-tree already uses %(path) for it, this is probably OK
> (otherwise we would probably have called it %(pathname)).

Agree. Unless we want to fix it in git ls-tree too.
