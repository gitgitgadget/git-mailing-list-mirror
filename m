Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78BDC433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 03:57:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F4161056
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 03:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhDAD5G (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 23:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbhDAD4o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 23:56:44 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C21FC0613E6
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 20:56:44 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id h7so940101ilj.8
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 20:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=geFZrK6yI6yQ/Pgtte4kymhDIy5hXb/afYOvSPy2Uw4=;
        b=L8M84j/H7ODDGimMidhxrBxarxocw+shGHk8bTD0M6l+VFTm64siHpn18fsXIyFjKt
         TrydPZ0zX6fqFey3ox0hMz5ldRd7+/BDseoBhkPiw4TSX9aC97vRMhQDPG0L25M/gzu5
         FydCTAHqf/H3EF1ZxM9w3s82qPz1q52sCXs0QjU+Hup5VLnExfEIvAG6FsyxMai9hId5
         GwPSVehYqhXLH8dWf8aMlFQjR/c5GREpMnZS3b8gSecXGjsL+muB6Cm8gkc4MivsalUT
         tBvzVIRRZFdRa22g2cdvdet/F/lZH0aGTrziNkRkeN45bysGlp6X6aNnhAFp0dz8ft4m
         6sxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=geFZrK6yI6yQ/Pgtte4kymhDIy5hXb/afYOvSPy2Uw4=;
        b=gfAtONDL3TyMLQg03GPwo5diI0ooxawljEG/H/qOv17paR4Uq9c1pLvxIpmBJYYC/8
         DqUmNoW7kpE2Ja7ZppbwQMLO/CEI5eithRNX65tkmcobjzj8/UAPVF8/s+HtmoxHctlV
         falwIUPwskU0IqZYSwYpPLbn7DwCWM3oE94Hf2ZhAnIc8+MqjORsO3MafCYOIpgWQGnF
         /cYo52uJ7zJIP3v1hlRyVVA6ntIrpHQ+UsQJCBAwlTP+fZXZelcvy58eS+pT/YIvF03w
         0KpGstRCYWUwslLkvxIg7HIFI+b1nh8msKKVtn2pjHLTm8QYA5u8y1c4dMIY1rtKzeVu
         v7Dw==
X-Gm-Message-State: AOAM532/fghrb/Ctqdr2VV+Gnve9HKdpYfuT64IfH1e33z/MJQrn9IY0
        nZ5v6GRU+bBTL9faPWnM2Ih0v/QNGAR1KXAHTGc=
X-Google-Smtp-Source: ABdhPJxXf09tCcnZJ5rE+Ep5aK9X55HFTJR4ZmWDByTdvE0cMeUX03IVvV2Z5omDUGeQGmN/07GjIxuwLUIV9W136fQ=
X-Received: by 2002:a05:6e02:f41:: with SMTP id y1mr4761990ilj.259.1617249403139;
 Wed, 31 Mar 2021 20:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
 <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
 <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
 <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com>
 <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com>
 <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
 <CAOLTT8SPRArgwwd_isw48gWQysgqJ9JJpn9JNGH+=9aY+0=SPA@mail.gmail.com>
 <xmqqwntoef81.fsf@gitster.g> <CAOLTT8SLX7wVfND9ru8NPx_YhvP2Ed17UcuRdY6Uioj9XSFmwQ@mail.gmail.com>
 <xmqqeefv89tc.fsf@gitster.g> <xmqq7dln89dd.fsf@gitster.g>
In-Reply-To: <xmqq7dln89dd.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 1 Apr 2021 11:56:30 +0800
Message-ID: <CAOLTT8SV_ixYWTV-83vY6B6HUTwW1hTWJqamstf=F6tzkJm3aQ@mail.gmail.com>
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

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=881=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:29=E5=86=99=E9=81=93=EF=BC=9A
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > ZheNing Hu <adlternative@gmail.com> writes:
> >
> >> The configuration is like this:
> >> trailer.bug.key=3DBUG:
> >> trailer.bug.ifexists=3Dadd
> >> trailer.bug.cmd=3Decho "123"
> >>
> >> And use:
> >>
> >> $ git interpret-trailers --trailer=3D"bug:456" --trailer=3D"bug:789"<<=
-EOF
> >> EOF
> >>
> >> BUG: 123
> >> BUG: 123 456
> >> BUG: 123 789
> >
> > I think that is quite expected.  You said the command to run is
> > 'echo 123', and that is not "pick a directory $D on $PATH where
> > there is an executable '$D/echo 123' exists, and run that".  It
> > runs the given command with the shell, and in general that is
> > what we want for end-user supplied commands specified in the
> > configuration file [*1*].
> > ...
> > *1* Imagine .editor set to 'emacs -nw' or 'vim -f'; we do not want
> >     Git to find a directory on $PATH that has an executable whose
> >     name is 'emacs -nw' and run that file (i.e. give 'emacs -nw' as
> >     the first argument to execlp()).  Instead, you'd want to behave
> >     as if the user typed "emacs -nw", followed by any arguments we
> >     want to give to it (in .editor's case, the name of the file to
> >     be edited) properly quoted for the shell.
> >
> >     And the way we do so is to form a moral equivalent of
> >
> >       execlp("sh", "-c", "emacs -nw \"$@\"", ...);
> >
> >     and put the arguments at the end where I wrote ... (we actually
> >     do so with execvp(), but illustrating with execlp() is easier to
> >     read and write---hence "a moral equivalent of").
>
> So, learning from that .editor example, what you can do when you do
> not want to take any parameter is to explicitly ignore them.
>
> Let's take the very basic form first.  Imagine you wrote a little
> script and wanted to see three "123", ignoring end-user input after
> "--trailer=3Dbug:".
>
>     .cmd =3D my-script 123
>
> would run 'my-script "$@"'.  What should you write in my-script to
> cause that happen?  Here is an example solution:
>
>     #!/bin/sh
>     echo 123
>
> Notice that "$1" is completely ignored, even if the machinery that
> drives .cmd makes three calls?
>
>         sh -c 'my-script 123 "$@"'
>         sh -c 'my-script 123 "$@"' 456
>         sh -c 'my-script 123 "$@"' 789
>
> The way to do the same without an extra script on disk is for you to
> use sh-c yourself.
>
>     .cmd =3D sh -c 'echo 123'
>

This is indeed a viable solution, But the extra "sh -c" seems to put an
unnecessary burden on the user.
Sometimes I wonder, why not recommend using environment variables
like $ARG?

> And if you do want to use $1, you can do the same.  E.g. if you want
> to double them in the output, you'd probably do something like this:
>
>     .cmd =3D sh -c 'echo "<$1 - $1>"'
>
> You'd need to quote the value appropriately for the config file,
> though.

In fact, In the following example, trailer <value> contains whitespaces ,

$ git interpret-trailers --trailer=3D"bug:the information manager from hell=
"

which can make it to work properly (But it's a little bit tedious):

$ git config trailer.bug.cmd "sh -c \"echo \\\"\$1\"\\\""
$ git interpret-trailers --trailer=3D"bug:the information manager from hell=
"

Bug-from:
Bug-from: the information manager from hell

Is there an easier way?
Or can make the user ignore the details of "sh -c"?

Thanks.

--
ZheNing Hu
