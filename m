Return-Path: <SRS0=C4D3=4R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2354C3F2D2
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 01:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8C9246A8
	for <git@archiver.kernel.org>; Sat, 29 Feb 2020 01:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvsnJ0o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgB2Bm6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Feb 2020 20:42:58 -0500
Received: from mail-qk1-f170.google.com ([209.85.222.170]:41527 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgB2Bm6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Feb 2020 20:42:58 -0500
Received: by mail-qk1-f170.google.com with SMTP id b5so4913002qkh.8
        for <git@vger.kernel.org>; Fri, 28 Feb 2020 17:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aKn93SaDaCnBeDK8mt6ulJuQ6RVs5fmVKdIuhsUAuQI=;
        b=SvsnJ0o8dVp7vAKY4TmWDO/SJ2xi0fXtYOty6rFKlhAh4wBwVpMq14ZnzBUEEDK3rG
         HiU7T0918J4ExQfQIQR2Wnq5rCjmBR7TMNwoHa3EB5PYtdV8sq7w1LNX91TckKYjHcOF
         M31CxTf0GzG8SSwOD775N8JtM/bAFAfCoQTAA1vNr0V8DyWI779Qz3imx9gH+xoxZOMO
         gcJUiFjszFhXQVdOtxVLK+SZA661Zp1yAG4fKJuug9/IjXCy+0Bp9S8D4s3agfs1CnuB
         dKz1ZZjf4Bkqwz7MkoRChMkd5SYts0LuPqUvTRnCoidS2uCHjaFfZBsxdgstS7hYRhaK
         Ou9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aKn93SaDaCnBeDK8mt6ulJuQ6RVs5fmVKdIuhsUAuQI=;
        b=F6tMfm6zzeSv3gBpIg6Uhk6kGdfP8OWK4sNHnKmB6LRFyRZf56279rxucEGisHSsHg
         jKWjuzmCPY2JyedbS37srpP87QiMjzVwrV9bTEaWMpczOZFkm046vGiwOFHncYu6n0rK
         tt8jxIFX+RcPLUDLTUyIFZhn5o3FPe1wuaoxVAVBM4nzgc1lBUnrOpJwZseUwAlykdCA
         wgOEXIvQCfKhVDwzO6m4Y421NQNlEiKCt1rJckF4IWL9aQQ5NjA9mtf07iyKQv7Lk/2Z
         xZ4cWlzToTchL6QLgq7JAQ6EQYCYOLaPBGu2j51wt03BaE8FJ6gMYWWTWPAjTqDO2NBM
         0xSg==
X-Gm-Message-State: APjAAAUhQ4DAGqVyHvZO3csV4oVhTE5szwZ5LJq8dTucgspktKo7okeG
        QplzfAS5dqAY6f1lAIgIblE=
X-Google-Smtp-Source: APXvYqx46l+W5FsPn8v1EzFjNZ0ss61sVSoJ1FxsPPQ7G9xYPsrT6Okxt5oZiQ9qfaWZFmdCiLrKRQ==
X-Received: by 2002:a05:620a:944:: with SMTP id w4mr5667183qkw.90.1582940576115;
        Fri, 28 Feb 2020 17:42:56 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q29sm6127158qkn.133.2020.02.28.17.42.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 28 Feb 2020 17:42:55 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: GIT_DIR in aliases [Re: Spurious GIT_DIR set when in a worktree [was Re: Nested submodule status bug]
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200227155057.7idpa447ixo6sf6j@feanor>
Date:   Fri, 28 Feb 2020 20:42:52 -0500
Cc:     =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6D4FEE68-EF3C-491E-A7C1-3454B88977C3@gmail.com>
References: <20200214224242.knmzkwx7ls4sote7@doriath> <0123F1ED-C421-4C1F-896B-E54C9D345A34@gmail.com> <20200226172338.unembhjhog36sqj7@mithrim> <20200227100557.ydouc4n3jphzbits@feanor> <20200227104330.hp7zf2suquxsf6zw@feanor> <20200227155057.7idpa447ixo6sf6j@feanor>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Damien,

> Le 27 f=C3=A9vr. 2020 =C3=A0 10:50, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
> So one might argue that the behaviour I observed is not a bug, but it =
is
> still surprising for me (as a user), and maybe this could be stated =
more
> clearly in the docs?

It sure is surprising, and not super intuitive.

>=20
> Furthermore there is a question of consistency. GIT_DIR will not =
always be set
> before running a shell alias. Looking at `setup_discovered_git_dir`, =
it will
> be set if we are in a bare dir, or core.worktree / WORK_TREE is set, =
or if
> we have a gitfile.
>=20
> The annoying side effect is that I cannot use as an alias a command =
that
> iterate over submodules and run git commands inside them, because in =
this
> alias GIT_DIR will be set sometimes, and sometimes not (a quick fix =
would be to
> unset GIT_DIR in my alias).

If that=E2=80=99s what your are trying to do, =E2=80=98git submodule =
foreach=E2=80=99 [1] seems like a better way to go.=20
For example I have an alias =E2=80=98st-sub=E2=80=99 that calls git =
status in the superproject and then recursively in the submodules:

    $ cat ~/.gitconfig | grep st-sub
          st-sub =3D !git status "$@" && git sub foreach --recursive git =
status "$@"

[1] =
https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-for=
each--recursiveltcommandgt

>=20
> So what would be the best way to handle this?
> Thanks,
> Damien

Cheers,
Philippe.=
