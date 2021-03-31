Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9E6C433DB
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55DB619D7
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 05:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhCaFPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 01:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhCaFPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 01:15:10 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57391C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 22:15:10 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id f5so7241271ilr.9
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 22:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xf6xtpV2LtmNSCgliGwrXEMgy0vvRcNGMUrMeH/VUXQ=;
        b=LTPiILiVV4kFJMAS1+uKoN4vZf5rLmnBvuTsnlaB6oZYK7TLp/RjVnq9xKQzdnhJnn
         5JiokafjLIoyMvkKtBrxig3nL/cNeMRGMi2lXVS8HAk2HiOllv1q7ffiw1nniOtsTGTX
         IUVr5a34Mb51cVRfwwyjP55oNf2um4ZdHDT8JFKygrcM/uN2ZPNU0asZhphme6WngJrW
         8bdFfjWhhhBYVYhdmNE2qrcR9I7ADGDPDtcDurwXQXBB3mOF8/jP9tjCGQgx3Gx2/eHm
         uzmVquI1FigdTu7iS8jTwyooghMMNK1Ltr0He0Q5Enrw9NgaiHbznzCCGhYfyO/oO3ru
         BIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xf6xtpV2LtmNSCgliGwrXEMgy0vvRcNGMUrMeH/VUXQ=;
        b=CqAYChMVuLfoCku+qdEHz3/FjgdgKPK+pp93rwAZ+r50zAG1GG+7rqXtQWM/OVemOp
         oycwpZc2bvd/uDB5+4ESPPntGFmlyTU83PGlV6SrYkgZLEb4O43GQrCG+66ebamIbf+/
         fSIp+UGRa5iRxseGOUovy+Zli/dSueA8Y83XaRHLlFEI3ILVKpOAvtz8uBI+93EriYAc
         ZbC5GT76PTRmnkU18hd8XRKjHqQVVNiAePnD17+n/Gf1r1kmZd5S+xahBw8vQVhR+d4L
         FrDwve01VUeNnppnurYv3kIJEmjeZiY6HFhxcucb85Rdh9G947Wg+WpTCz7wlbT6KGfB
         r7lg==
X-Gm-Message-State: AOAM532NMQH/61lTES9VMOC8yH+39cU96vxwcNr9o3h2ObdSSzwNXHO2
        6rece8baI/G00x/aaFrS0uG/lHTx8usj499m0mI=
X-Google-Smtp-Source: ABdhPJzn9AyKx8omNKlVpTKUClnYQRzbSChsndtVqaYXEDgDlKQ7jHawS9HSUuoC18jRWCwvOuH3wi5J/UTjWCfXQVo=
X-Received: by 2002:a05:6e02:15c6:: with SMTP id q6mr1321709ilu.17.1617167709681;
 Tue, 30 Mar 2021 22:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
 <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
 <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
 <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com>
 <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com>
 <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
 <CAOLTT8SPRArgwwd_isw48gWQysgqJ9JJpn9JNGH+=9aY+0=SPA@mail.gmail.com> <xmqqwntoef81.fsf@gitster.g>
In-Reply-To: <xmqqwntoef81.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 31 Mar 2021 13:14:57 +0800
Message-ID: <CAOLTT8SLX7wVfND9ru8NPx_YhvP2Ed17UcuRdY6Uioj9XSFmwQ@mail.gmail.com>
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8831=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=881:14=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > The `prepare_shell_cmd()` in "run-command.c" seem to use "$@" to pass
> > shell args.
>
> Yes. "$@" is a way to write "$1" "$2" "$3"...
> Since you are passing only one,
>
>         echo "$@"
>
> and
>
>         echo "$1"
>
> would be the equivalent.
>
> I am not sure what program you fed to the gdb (and remote debugging
> over e-mail is not my forte ;-), but let's see.
>



> > Before exec:
> >
> > (gdb) print argv.v[1]
> > $22 =3D 0x5555558edfd0 "/bin/sh"
> > (gdb) print argv.v[2]
> > $23 =3D 0x5555558f4c80 "-c"
> > (gdb) print argv.v[3]
> > $24 =3D 0x5555558ed4b0 "echo \"123\" \"$@\""
> > (gdb) print argv.v[4]
> > $25 =3D 0x5555558f5980 "echo \"123\""
> > (gdb) print argv.v[5]
> > $26 =3D 0x5555558edab0 "abc"
> > (gdb) print argv.v[6]
> > $27 =3D 0x0
> >
> > Some unexpected things happened here.
> > Maybe "abc" was wrongly used as the parameter of "echo"?
> > Looking forward to your reply.
>
> Observe
>
>         $ sh -c '
>                 echo "\$0 =3D=3D $0"
>                 count=3D0
>                 for arg in "$@"
>                 do
>                         count=3D$(( $count + 1 ))
>                         echo "\$$count =3D=3D $arg"
>                 done
>         ' 0 1 2
>         $0 =3D=3D 0
>         $1 =3D=3D 1
>         $2 =3D=3D 2
>
> i.e. the first arg after
>
>         argv[1] =3D "/bin/sh"
>         argv[2] =3D "-c"
>         argv[3] =3D "script"
>
> is used to give the script the name of the program ($0).  Are we
> getting hit by this common confusion?
>
> It is customery to write such an invocation with '-' as the "name of
> the program" thing, so that ordinary positional parameters are
> available starting at $1, not $0, like so:
>
>         sh -c 'script' - arg1 arg2 ...

The configuration is like this:
trailer.bug.key=3DBUG:
trailer.bug.ifexists=3Dadd
trailer.bug.cmd=3Decho "123"

And use:

$ git interpret-trailers --trailer=3D"bug:456" --trailer=3D"bug:789"<<-EOF
EOF

BUG: 123
BUG: 123 456
BUG: 123 789

I just want three "BUG: 123", but "456" and "789" appeared...

In fact, I think about this problem like this way:
When we execute a child process that runs the shell,
the function`prepare_shell_cmd()` will actively add "$@" to the end of our
shell command when we have more than zero args ,

e.g.

"echo \"123\"" "abc"

will turn to

 "echo \"123\" \"$@\"" "echo \"123\"" "abc"

Normally, $@ should not cause any problems because it passes arguments
to the script what we provide.

But now, what we actually want is take any $1 that appears in the script as=
 an
argument, the automatically added $@ causes $1 to be implicitly included.
And the original $ARG does not have this problem, Or if we pass environment
variables, this kind of problem will not occur.

Or If we want to avoid this problem, should we add one new options in
`struct child_process` , such as: "shell_no_implicit_args" , let git not ad=
d
 extra "$@" before we run the shell script?

Thanks.

--
ZheNing Hu
