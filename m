Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BCFC433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 12:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D9561041
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 12:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbhDZMyV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbhDZMyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 08:54:21 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3498C061756
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 05:53:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x5so5468987wrv.13
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 05:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bKUQRE50+aZ1uc0sPRHVw/fr4g09Tzu7gGM24p/Z+3I=;
        b=po/quQrGVzav+XaGH4dqTpGho6jwLoWEsZZysfPYL5gGyPDwsq/hQHN39210+Ql6Si
         dHBuD1pmhpNu6Z0dqfNFXrwMa3GneSfKMZFzfLZe9u5sI2XVQ+xsAu6qVSTxxUXV/STQ
         t9zuJzfEoG8XaL1t5YGLUEHb34oPTdzRW9lKbZ4gtdqy2IOxb810RRVOFBSEFX722Ej/
         cUSYoVNYhlyw/IXUUlAsPVBNag7RKOW8otu+0MnbGw1bEaKPq8FiIns7/dSRYAbmW6ok
         nLihrp3b9jFCmdlkJavhbEl/ZREvpOqDebbt/c9ffU+wY1vi06TxKY7dqvMsgGe0tOsx
         ZeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bKUQRE50+aZ1uc0sPRHVw/fr4g09Tzu7gGM24p/Z+3I=;
        b=kghoYmugK2sknF2WBIYxfWXehiogyb4Z5aQf5kgHRlftrZge5fgfTkLqLkl1FmWG+F
         2FUQ4wATrj8UZbV4lW8QxqICQiMzg/geRWgcBwNqg1C3Etop4DMufKFEv9meD0zuU5OU
         Pq9Hr1am8AFvvVN6F28SCgKvjPSxodIWDiAv63klAgGnBdw7P67meM4HCTx99K5w9/5K
         0JTCgK3tOWDf+y/ZmkZ6ZousV3rpuTFNYRlLvyW4UFkQQEizII8Ncaksd///JIaX8Tee
         S68cJGOSngXtX0a4HZsNMwW/qfaWlkX8xlr+VaPBLMyLpu93Rgei3dKFq5oP58O59DIH
         uU6Q==
X-Gm-Message-State: AOAM533zOkfBMjZEQO2LC7+ozgjYPR2EO+XP9a1PJ6kn15uofsEMszyW
        12E1ZyizrN4jkZ6FOA718z2aA4QVA0HX984j+VE=
X-Google-Smtp-Source: ABdhPJw7rzQUDZXX5r9y/cMk9UPJ2NrS106xl447RKPFVzhkHuAPmorZP/nLut9uw6h/ZG56ABumS1T+5ofFs2NXs8g=
X-Received: by 2002:adf:fb87:: with SMTP id a7mr23219001wrr.58.1619441618456;
 Mon, 26 Apr 2021 05:53:38 -0700 (PDT)
MIME-Version: 1.0
References: <CACAwW2gHBPRujCV0LSS3p1Td_GkiGG87U6QPLVrp69ShVNnPTA@mail.gmail.com>
 <YIYL2BtIacMIthgy@danh.dev>
In-Reply-To: <YIYL2BtIacMIthgy@danh.dev>
From:   Kostya M <kostya27@gmail.com>
Date:   Mon, 26 Apr 2021 15:53:28 +0300
Message-ID: <CACAwW2gUo7R2V-gX8dM90UCoRSBwqgz3nw67xyDx1a3R9ahmqw@mail.gmail.com>
Subject: Re: Possible segfault with `git clone --mirror`
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes, adding `HOME=3D/tmp/not-exist` fix this.

my ~/.gitconfig is (maybe it have outdated options, it was generated long a=
go):

[color]
  status =3D auto
  branch =3D auto
  diff   =3D auto

[core]
  symlinks =3D false
  autocrlf =3D false
  repositoryformatversion =3D 0
  filemode =3D false
  bare =3D false
  logallrefupdates =3D true
  symlinks =3D false
  ignorecase =3D true
  quotepath =3D false
  pager =3D less
  editor =3D "vim"

[pack]
  packSizeLimit =3D 2g

[apply]
  whitespace =3D nowarn

[i18n]

=D0=BF=D0=BD, 26 =D0=B0=D0=BF=D1=80. 2021 =D0=B3. =D0=B2 03:39, =C4=90o=C3=
=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail.com>:
>
> On 2021-04-25 21:17:50+0300, Kostya M <kostya27@gmail.com> wrote:
> > Git 2.31.1, reproduced on Ubuntu 20.04.01, and Arch Linux.
> >
> > `git clone -c core.askPass=3Dtrue --mirror --quiet --
> > https://github.com/kostya/myhtml.git myhtml`
> > Segmentation fault (core dumped)
> >
> > If i remove --mirror argument, it works.
> > This command generated by crystal language package manager called shard=
s.
>
> Not reproducible.
>
> You may want to check if it's your config or filesystem first?
>
> If I were you, I would run something like this to see if it works:
> (Maybe with GIT_TRACE2=3D1 removed in first run to see if it's your confi=
g)
>
>         HOME=3D/tmp/not-exist XDG_CONFIG_HOME=3D/tmp/not-exist GIT_TRACE2=
=3D1 \
>                 /usr/bin/git clone -c core.askPass=3Dtrue --mirror --quie=
t -- \
>                 https://github.com/kostya/myhtml.git myhtml
>
> --
> Danh
