Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B9001F803
	for <e@80x24.org>; Tue,  8 Jan 2019 23:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfAHXXF (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 18:23:05 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:39905 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbfAHXXF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 18:23:05 -0500
Received: by mail-it1-f174.google.com with SMTP id a6so8478136itl.4
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 15:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=onAhjGgAuuiBTvwZ+uHScPMP7kaxMxLz97t0Pi17CoI=;
        b=ak58YLOOnQd3foSK4QyJeaZ/FzMlko5hNqz+sjLjfF2FkdJMVlRhwv3Zac80H0By1f
         feueBgM1UeOnGsl+RggvV9Yb7HyZdJ06CfQ8BTw71XcWRk7+Zh7FvPn0Bw/i+gT1Kyqu
         ip9nuaq7wKkpRNDLTmR2DzaJFsKi3A3kA3bgV+X1Tnk6AMy48RUIokqHud1+UypCWz77
         rDvL1fUjgnhvzbZpE6rTN320vLVVRZ9twa//icO1MDMCyar2QXgHPeyO4Gvxh2hdVIZ6
         QecbtkmUoKK+yzBxvbf87HtuilEn2fk02nUBHJ+OyZ/XtTgZXbvEt/0OdGFI7pNSfWQF
         qbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=onAhjGgAuuiBTvwZ+uHScPMP7kaxMxLz97t0Pi17CoI=;
        b=i4M8u7a38IpiHcKrwF4Aw1e0bsUl1TZ/IO1UOHbTMtZ/bTsowCVydI/Sev0Fae9GbJ
         MyVAPk/7mrlYw7yECeOJQwOIljOrE2OBJgL68I1EOOeUDanCp0BUqOWdisRDQ1WWzD6I
         J5fRlscSJZ8+lBaV5l0yu9rBjfpcIpRJK3Dr2AxGPvxXmyK5ie3Hw7NQeAG1OCrMrCcI
         Msi/Blp261bQ0eGdJmlFWzkoXHNNQ4b4N7lFdukTY60w/ygD5oXPqvUGy5wreU4sFtK4
         ffjAALqYFeIwTcVPeFbB07/KC4D9xqsrA53JA/7Mtm+NQOGgd9rgQT2J3M2StsFvaBIL
         fsJQ==
X-Gm-Message-State: AJcUukd31F82WgUzVESrp3TyrDWMY2UqH1a+GmxOPJ37mU7m3btg4zJU
        JoIRHG8QAPzFE2c/Q1uvgrrxTggOxrpGwzss3dAcahA4
X-Google-Smtp-Source: ALg8bN47VkFatdgsowgb3uXz0UUHlTPgfDuKHi1c0j6JZzEfEV78Qw21IKkrLREdyIrt2xhWOdH1ZPVljd2I+M7owdY=
X-Received: by 2002:a02:183:: with SMTP id 3mr2558788jak.130.1546989784064;
 Tue, 08 Jan 2019 15:23:04 -0800 (PST)
MIME-Version: 1.0
References: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
In-Reply-To: <CAG0vfyQeA3Hm7AsYgYtP4v-Yg0=rKXW0YYfg_emAwEscZha4VA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 9 Jan 2019 06:22:38 +0700
Message-ID: <CACsJy8Cvc8v_4OEmpgKPWSO5csV6jRya7mnSQjEs4mMhHRq4AQ@mail.gmail.com>
Subject: Re: Regression: submodule worktrees can clobber core.worktree config
To:     =?UTF-8?Q?Tomasz_=C5=9Aniatowski?= <tsniatowski@vewd.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 9, 2019 at 5:56 AM Tomasz =C5=9Aniatowski <tsniatowski@vewd.com=
> wrote:
>
> After upgrading to 2.20.1 I noticed in some submodule+worktree scenarios =
git
> will break the submodule configuration. Reproducible with:
>     git init a && (cd a; touch a; git add a; git commit -ma)
>     git init b && (cd b; git submodule add ../a; git commit -mb)
>     git -C b worktree add ../b2
>     git -C b/a worktree add ../../b2/a
>     git -C b status
>     git -C b2 submodule update
>     git -C b status
>
> The submodule update in the _worktree_ puts an invalid core.worktree valu=
e in
> the _original_ repository submodule config (b/.git/modules/a/config), cau=
sing
> the last git status to error out with:
>     fatal: cannot chdir to '../../../../../../b2/a': No such file or dire=
ctory
>     fatal: 'git status --porcelain=3D2' failed in submodule a
>
> Looking at the config file itself, the submodule update operation applies=
 the
> following change (the new path is invalid):
>     -       worktree =3D ../../../a
>     +       worktree =3D ../../../../../../b2/a
>
> This worked fine on 2.19.2 (no config change, no error), and was useful t=
o have
> a worktree with (large) submodules that are also worktrees.

This scenario is not supported (or at least known to be broken in
theory) so I wouldn't call this a regression even if it happens to
work on 2.19.2 for some reason.

The good news is, I have something that should make it work reliably.
But I don't know if it will make it to 2.21 or not.

> Bisects down to:
> 74d4731da1 submodule--helper: replace connect-gitdir-workingtree by
> ensure-core-worktree
>
> --
> Tomasz =C5=9Aniatowski



--=20
Duy
