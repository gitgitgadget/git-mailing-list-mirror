Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDEAC433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CDB6619CA
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 15:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbhC3PID (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 11:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhC3PHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 11:07:35 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F10C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:07:35 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so15886115ote.6
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYTSd1gYE59kSmrYcDV5ESVJu/q0+xd/IU1X6CV/+Nk=;
        b=TtnvqzoJ4mb/lmcVmOHqqZiJJsWzCSrPhTb1pCAfCR5RD/MjIjy3+3doQYbzGp1jfC
         Ko4twIea8h2QR/B0a8vgmGeF+F4OcNS5sG4t0F07OSeFTOaFIXM2SwxbfOLygrDnVa87
         MJ4Q0gXwcK+YDWWMJ5lwkVHH5K0tO5kwfP4khyChqc2xjKzEkCYT0KXLddIyAG7vPEmU
         iJcrd4gFHeb+uWcloLQgjXmbyYt7a6hWLYEBvyWfMKvB6uMQuekFRlyi9/7RPMlvYksB
         3KeBi9BbHtTsSc6a1VcSox4bHb5LGKLe6BJVJx4133AIEGWx6VRpH/lqIkqsSRailyHM
         DSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYTSd1gYE59kSmrYcDV5ESVJu/q0+xd/IU1X6CV/+Nk=;
        b=T+qOaeAgGXv3zaqe/G0Jl4WuQzGJT2qvotuXMW8CNQXrm6ec5YJYh+GT/QEx5mHU/J
         4c7xy5J7FNcCpyfSCSlWBC/iWCGkUWq4SqBPY053asoExqavcJXrMSfUnZf25DDBrsrB
         6Ch3FRWsLr9ZHYG1FFnmVdEsT1pHNcjSeGPfa1xQ6/6zzpYeZW/VhqqPYaCvXr12oI63
         kUS9QxHCgOah1YOPacLxSIep/QHWfvAMjQc7UV17bE0XuH55MnJ1UZMZwiDm0YpprQAM
         jjJUGiJFi0hbQYh7UuxA/2uJ7W0rDhOZX3nXv3E6dqKWXXhAqfM926Tj/27mRmfDjS50
         lwlg==
X-Gm-Message-State: AOAM531hkhhpMnEF5zdj41AF26LnJuz1r01ECF1N/0n8LWRn3DhWluiE
        FK9uIJOuuf71aSqH59tLBz+2lVOsynP1GHPoNZU=
X-Google-Smtp-Source: ABdhPJwl1aVXia8bn43xQkl2Sq4oFRccwloXC1NzFJ2Up0ef60pwR7dO0KH0hiVAnkbczAIWmToufzon3s6+5c8HZNM=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr27759618ota.164.1617116854526;
 Tue, 30 Mar 2021 08:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
 <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
 <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
 <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com>
 <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com> <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
In-Reply-To: <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 30 Mar 2021 23:07:19 +0800
Message-ID: <CAOLTT8SPRArgwwd_isw48gWQysgqJ9JJpn9JNGH+=9aY+0=SPA@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio,

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8830=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=887:22=E5=86=99=E9=81=93=EF=BC=9A
>
> In addition, I now found a small bug in ".cmd",
>
> git config -l |grep bug
> trailer.bug.key=3Dbug-descibe:
> trailer.bug.ifexists=3Dreplace
> trailer.bug.cmd=3Decho 123
>
> see what will happen:
>
> git interpret-trailers --trailer=3D"bug:text" <<-EOF
> `heredocd> EOF
>
> bug-descibe:123 text
>
> "text" seem print to stdout.
>
> I'm looking at what's going on here.
>

Here I may need to think with you whether it is reasonable to pass "$1".

I found that we passed the parameters in the above situation like this:

(gdb) print cp.args.v[0]
$7 =3D 0x5555558f4e20 "echo \"123\""
(gdb) print cp.args.v[1]
$8 =3D 0x5555558ee150 "text"

At this time, our idea is base on that v[0] will be the content of the shel=
l,
and v[1] will be the $1 of the shell.

But in fact, git handles shell subprocesses in a special way:

The `prepare_shell_cmd()` in "run-command.c" seem to use "$@" to pass
shell args.

Before exec:

(gdb) print argv.v[1]
$22 =3D 0x5555558edfd0 "/bin/sh"
(gdb) print argv.v[2]
$23 =3D 0x5555558f4c80 "-c"
(gdb) print argv.v[3]
$24 =3D 0x5555558ed4b0 "echo \"123\" \"$@\""
(gdb) print argv.v[4]
$25 =3D 0x5555558f5980 "echo \"123\""
(gdb) print argv.v[5]
$26 =3D 0x5555558edab0 "abc"
(gdb) print argv.v[6]
$27 =3D 0x0

Some unexpected things happened here.
Maybe "abc" was wrongly used as the parameter of "echo"?
Looking forward to your reply.

--
ZheNing Hu
