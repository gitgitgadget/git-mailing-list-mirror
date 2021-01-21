Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B182C43381
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 10:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA4923975
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 10:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728781AbhAUKBz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 05:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbhAUKBe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 05:01:34 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A519FC061575
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 02:00:54 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id a109so1084629otc.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2021 02:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wuTdRZacdyAc8DdGBxhK3D7ev7bGr5ffCfPeb6f8tv8=;
        b=khsTZ2DhidJvy1jO4TSCAgBSQ8qSPUc5/KxG+ednrqTcTuaEhBiZkj3K7cZbcXQ787
         WS7AbpVeM7q/pE1bXoavTGyX/OEzrycGXHSMjF4Pqi+z7S375+aUR4BJyxp48qnDDmA6
         AHOvdTaIls6k59cM2Lqetlofz/VgGDaG9/lxqBTghgRO1NPJWvHPT+8OECfH44yfVVWL
         /F14SPmKzOT/g7/SXMvTmfxWfeZcBQkTAmsoiaQjC+WS5+Fkl7r53oFGIgB3iRRmevim
         vsLysuyp2v2X9EgjHfC9vIqIPkeUl7SokV2tqrw5k+pLf9x2F/AQhJTKamVfaRxzcuEC
         0YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wuTdRZacdyAc8DdGBxhK3D7ev7bGr5ffCfPeb6f8tv8=;
        b=RpYrlrXMypPnweIas0yn+KJMHAqYOy0H3bvmgP6MpEXYFA7Hoqegh71ubnvvqjfhJ7
         TJmpavjlS6PmQ98RcjVQHY35TJXCMO/6CmmOB1cJRu08SvJnPSeX5yw9qWEFtTv5apD3
         MjGes4zcd9wGJrUCGdPzFdLwaVwLm/q3lI8yA2WZKDS6wAiga2l7d7wKfHTzoancWi8D
         gCkgjj9KfkpnfNkiE9sheU7AFWYAbaMEabBT541o3wOyOWckcBr7BgnDJB4fvWiW6AaU
         cD6qOiKyEvwKILq1ptxj0+ilSMRsdCwJ0E2M37k34+QPhD71V6GhDI/oS2wGCumoI3Ai
         5Z/Q==
X-Gm-Message-State: AOAM532tLebPa5sWO3qnaHD6nMPd3VRpr2qNKXDkOjCp5SX0Tyd32DJq
        M9lXxzGQGgR4L34cjJ7Hk14TvtrQ37cK6zkZlntFBfInLg5Icn3G
X-Google-Smtp-Source: ABdhPJxS9P2+Iz/O8bhggve4GD9qoIrNdh6q43ViXUMhqF+X+g519A0HeZbyRUPRKV8swvnFQhj2O4XWlG8Wa+0D5no=
X-Received: by 2002:a9d:6188:: with SMTP id g8mr9810419otk.299.1611223254090;
 Thu, 21 Jan 2021 02:00:54 -0800 (PST)
MIME-Version: 1.0
References: <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
 <pull.832.v5.git.1611037846.gitgitgadget@gmail.com> <ec9464f6094f111bc7b6dc1dc07ecc9997d366d4.1611037846.git.gitgitgadget@gmail.com>
 <xmqqlfcnfj82.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfcnfj82.fsf@gitster.c.googlers.com>
From:   =?UTF-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Date:   Thu, 21 Jan 2021 18:02:26 +0800
Message-ID: <CAOLTT8QN=qLUb7HSCeufbo_zQyhjgQXE4T6x_XCg9Y8t_kT2Ag@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] ls_files.c: bugfix for --deleted and --modified
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8821=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=884:26=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > This situation may occur in the original code: lstat() failed
> > but we use `&st` to feed ie_modified() later.
> >
> > Therefore, we can directly execute show_ce without the judgment of
> > ie_modified() when lstat() has failed.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
>
> Thanks.  A few comments:
>
>  * The error_errno() line is not indented correctly; I'll fix it up
>    while queuing, but it would conflict with 2/3 as you'll be moving
>    that line around.
>
I might not have noticed,very Sorry.
>  * When we say "error", we do not even know if the thing got removed
>    or modified at all, so it is somewhat strange to report it as
>    such (the path may be intact and the only issue may be that we
>    cannot read the containing directory).  It is equally strange not
>    to say anything on the path, and between the two, there isn't
>    clearly a more correct answer.  What you implemented here does
>    not change the traditional behaviour of reporting it as
>    deleted/modified to "alert" the user, which I think is good.
>
Haha,thanks!
>  * The logic for modified entry looks a bit duplicated.  I wonder if
>    the one at the end of this message reads better.  Renaming err to
>    stat_err is optional, but I think the name makes it clear why it
>    is sensible that these two places use the variable as a sign that
>    the path was deleted and/or modified.
>
> >                       err =3D lstat(fullname.buf, &st);
> > +                     if (err) {
> > +                             if (errno !=3D ENOENT && errno !=3D ENOTD=
IR)
> > +                                 error_errno("cannot lstat '%s'", full=
name.buf);
> > +                             if (show_deleted)
> > +                                     show_ce(repo, dir, ce, fullname.b=
uf, tag_removed);
> > +                             if (show_modified)
> > +                                     show_ce(repo, dir, ce, fullname.b=
uf, tag_modified);
> > +                     } else if (show_modified && ie_modified(repo->ind=
ex, ce, &st, 0))
> >                               show_ce(repo, dir, ce, fullname.buf, tag_=
modified);
>
>
>                         stat_err =3D lstat(...);
>                         if (stat_err && (errno !=3D ENOENT && errno !=3D =
ENOTDIR))
>                                 error_errno("cannot lstat '%s'", fullname=
.buf);
>
>                         if (show_deleted && stat_err)
>                                 show_ce(..., tag_removed);
>                         if (show_modified &&
>                             (stat_err || ie_modified(..., &st, 0)))
>                                 show_ce(..., tag_modified);
>
Yes,"stat_err" may better then "err".
And putting the conditions together will make the code more compact.

Thanks for your comment:)
