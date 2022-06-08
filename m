Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B91C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 14:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241649AbiFHOjG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241663AbiFHOjF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 10:39:05 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79635EDDF
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 07:38:58 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id y17so16689840ilj.11
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 07:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tpXqkR2DxPXDfwRFiqdlPoSm9URR8V/hGHjaeHdZztQ=;
        b=hf8hynRSXnAczeSdfmFTnXhD2eH35beOJ3G59zrsot/suj+1kdPQBl7kfPKF0lKY4/
         ciGasMbo7SaeUE0pkMtefvQuKF3vuk/jMRNn54gAvdO0UbMvoTLUP+q2AL0iSafJ9g1C
         JZpRonS1x/IPUIFhhYYlsXn/I0qvYzpeVCRtKwS/jhAsXrfONoCMGf/jDplTTwKnNidH
         AVurPzWusZ0868w7dc0JcWPKQ5VE3hjbz3g4sf+QFDVKQFWUDeOYhv+0tDPWyvBgX4zc
         mk3DhxU+7JI4BJDrcQM/U8pxVLdrWad4tfBHHJH3pFWqe1klx+031GZkxfKD2XNfyjiQ
         jy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tpXqkR2DxPXDfwRFiqdlPoSm9URR8V/hGHjaeHdZztQ=;
        b=1bkUGIm+VNRnMsSIeb76QufHQyMNpA2Cdie7ymIOUJBE7Yv/Dan3wncr27rnYoUWFD
         k8wAl479r9N0HiYsyXdehg3GtwE5XAEylFugWWxIN/8zgtjIJHLgAzFxol9YI6iHhxdm
         a9/R/LqoRGHwUhpecbKWZ0S8rsM5XvZZ+1gieNi9eqPnhkrHhy5iY1AWBnJe0+4ZRqS2
         aLcj3LqrH/3HWg4BaHphwgit9bwG8l9d1Os4BYQNE9zOC5OqVEmpfdp6oBH4YlAzr7rh
         ZFvHcd76hnPx7m5bzNyYTsj9T+wCdrTJqeBwUHusl8GJ7RMMaTXD6eQv2zGCA864qYaw
         4atw==
X-Gm-Message-State: AOAM533ckBWb/Oa7iFQWGcJl/WDqASIblayVdc2WDggPqfUOsDNLqjgz
        zu6GoOI89vwufpwZmXeH/vcN3S/KL4s2w/skPsuLnbSzdYI=
X-Google-Smtp-Source: ABdhPJylfSU4ouMAxDJsQRzcCVRUCu2u5bSKQa27A8sQtrL58yaB3+FCSffHxrQPN4h+aUjvNIsTnfCyVPlgJUM5m5k=
X-Received: by 2002:a92:c087:0:b0:2d3:96f3:1b1a with SMTP id
 h7-20020a92c087000000b002d396f31b1amr20245891ile.163.1654699138240; Wed, 08
 Jun 2022 07:38:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com> <220606.86zgipvg7e.gmgdl@evledraar.gmail.com>
In-Reply-To: <220606.86zgipvg7e.gmgdl@evledraar.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 8 Jun 2022 22:38:47 +0800
Message-ID: <CAOLTT8Sz3q2db1fRcHp7Exnarw4sMCnUfAF6bot+pwYxmXJjiw@mail.gmail.com>
Subject: Re: [PATCH] ls-files.c: add --only-object-name option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=E5=
=B9=B46=E6=9C=887=E6=97=A5=E5=91=A8=E4=BA=8C 01:45=E5=86=99=E9=81=93=EF=BC=
=9A
>
>
> On Mon, Jun 06 2022, ZheNing Hu via GitGitGadget wrote:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > `git ls-files --stage` default output format is:
> >
> > [<tag> ]<mode> <object> <stage> <file>
> >
> > sometime we want to find a path's corresponding objectname,
> > we will parse the output and extract objectname from it
> > again and again.
> >
> > So introduce a new option `--only-object-name` which can only
> > output objectname when giving `--stage` or `--resolve-undo`.
> >
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > ---
> >     ls-files.c: add --only-object-name option
> >
> >     Something we want to extract objectname from git ls-files --stage, =
but
> >     git ls-file don't support something like --format=3D%(objectname) (=
which
> >     git ls-tree have implemented)
> >
> >     So now add a new option --only-object-name which can only output
> >     objectname.
> >
> >     (Maybe we should add something like git ls-files --format ?)
>
> Yes I think that would be very useful, especially if we could see if
> some of the code could be shared (maybe not).
>

Maybe I can try to implement it :-)

> But in any case shouldn't this be called --name-only to go with "git
> ls-tree"'s version of this? Or is there some subtle difference I'm
> missing...?
>

Eh, git ls-tree --name-only will only show file paths, so maybe
--only-object-name
will be better than --object-name-only in git ls-files.

> > +check_resolve_undo_only_object_name() {
> > +     msg=3D$1
> > +     shift
> > +     while case $# in
> > +     0)      break ;;
> > +     1|2|3)  die "Bug in check-resolve-undo test" ;;
>
> Use the "BUG"  helper in thaht case.
> > +     esac
> > +     do
> > +             path=3D$1
> > +             shift
> > +             for stage in 1 2 3
> > +             do
> > +                     sha1=3D$1
> > +                     shift
> > +                     case "$sha1" in
> > +                     '') continue ;;
> > +                     esac
> > +                     sha1=3D$(git rev-parse --verify "$sha1")
>
> missing && here when invoking "git".
>

Sorry, but this function check_resolve_undo_only_object_name() is
just a mock version of check_resolve_undo(), so maybe I should fix
this function first?
