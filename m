Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1389C433ED
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 03:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 983F6610A5
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 03:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhDADkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 23:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbhDADjp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 23:39:45 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA79C061786
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 20:39:45 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x16so823742iob.1
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 20:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N7hKsdFPT1hWZQelAzJW/k9/zktkb0cBzsaDzE9D0E4=;
        b=idnbFcGo/sdvFzQk1hbqSslV0XnayDsomh2cpDJ9b0NQKidaXsOeqnvec4BpJ+za3p
         3lIyrIHjIevMoxOqlvbuDFOnMg3gqj6vxVKe4+zAe4tOUBfWLojFe9nNBNePmAXehHJp
         6Og72eVpno7tZoLiWjGWXmfW1iPw/1g8tslTmSEucugcU5eHMXnw70D409NZpznVOZM9
         c/d7BjfMAi7gc4Douw16EGp/N2/S7RS59AaeEDdSef7Aeo/I+miIfhITsGwkwitWazwA
         xa6fcjCGp7Dzb3dpP5UtbmqQOOC6KTiWT7I00r9DlTjqbJN0lLtExJpO9BMm5/DmejdO
         inDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N7hKsdFPT1hWZQelAzJW/k9/zktkb0cBzsaDzE9D0E4=;
        b=FMT4svqqiyixqu0YruI1ROmplKAKUgqw44bIsnkpkh6ppNVYeB5hjPChDKkd/1p0nT
         cqf4bX0dHk/259ey7KEDCqccaMc3CDmLwdiboVv6/ztvBeJMyCftZT/npyafpnL9g4cU
         gX3r8y5iWgNa1FrCx6biF4mJvYyDUjttOHLFbgWcPpuX9dA0VQSF2ubJAyDiBvaqouk7
         h4gLpPC7vIXZbtaaOHxUvhdoXCyKm7wg7xYS5ARoPgPuGN5OYMGLUb4d0rSPVFfvwwL4
         3zs69ojbrWn1WIXkWtmIlqPeFSWB0GQiKWGoTIjhoYtm71g052Au/LltuXrD+qNxdrUp
         4iQA==
X-Gm-Message-State: AOAM530GxhYfT5eykXh223EguQj8o7wQGZfUvpo6OXuFOoMITNTDZH3P
        WE9tnPV8kcjnKxfFOBxDsYMQWvNiV6oYZXVYOAA=
X-Google-Smtp-Source: ABdhPJyFcuWR2OwEihghmb8eOf3QbgNg5iUcXSOrLe8Q+KZk0n3TVB5lElgWyioohCRaAMy2DUXdp6Z4zD6zeDbRbLQ=
X-Received: by 2002:a6b:6308:: with SMTP id p8mr4968058iog.172.1617248383398;
 Wed, 31 Mar 2021 20:39:43 -0700 (PDT)
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
 <xmqqeefv89tc.fsf@gitster.g>
In-Reply-To: <xmqqeefv89tc.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Thu, 1 Apr 2021 11:39:30 +0800
Message-ID: <CAOLTT8Tn9E5qo-mv_o9-r+zQ0-FT6vOH3BZDLuXpACjPscMqeQ@mail.gmail.com>
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
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:20=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> writes:
>
> > The configuration is like this:
> > trailer.bug.key=3DBUG:
> > trailer.bug.ifexists=3Dadd
> > trailer.bug.cmd=3Decho "123"
> >
> > And use:
> >
> > $ git interpret-trailers --trailer=3D"bug:456" --trailer=3D"bug:789"<<-=
EOF
> > EOF
> >
> > BUG: 123
> > BUG: 123 456
> > BUG: 123 789
>
> I think that is quite expected.  You said the command to run is
> 'echo 123', and that is not "pick a directory $D on $PATH where
> there is an executable '$D/echo 123' exists, and run that".  It
> runs the given command with the shell, and in general that is
> what we want for end-user supplied commands specified in the
> configuration file [*1*].
>

I agree that if you want to use execv directly to execute a terminal
command, if arg[0] is something like "emacs -nw", error will be
reported:"No such file or directory". But by wrapping a layer of
"sh" "-c", The program name 'emacs' in 'emacs -nw' can be
found and executed normally.

> So we form a shell command whose beginning is 'echo 123' and tuck
> the argument after that command line, so it is understandable that
> "echo 123 456" gets executed for "--trailer=3Dbug:456".
>
> I wasn't following the discussion between you and Christian closely
> but I recall seeing him saying that the command is executed one
> extra time without any arg before it is run for actual --trailer
> requests with the value?  I am guessing that is where the first
> output "BUG: 123" (without anything else) is coming from.
>

Exactly.
Each .command/.cmd willl executes this 'beforeCLI' operation  once,
I use ifexists=3D'add' here just for seeing the effect, In general, we will
use ifexists=3D'replace'.

>
> *1* Imagine .editor set to 'emacs -nw' or 'vim -f'; we do not want
>     Git to find a directory on $PATH that has an executable whose
>     name is 'emacs -nw' and run that file (i.e. give 'emacs -nw' as
>     the first argument to execlp()).  Instead, you'd want to behave
>     as if the user typed "emacs -nw", followed by any arguments we
>     want to give to it (in .editor's case, the name of the file to
>     be edited) properly quoted for the shell.
>
>     And the way we do so is to form a moral equivalent of
>
>         execlp("sh", "-c", "emacs -nw $@", ...);
>
>     and put the arguments at the end where I wrote ... (we actually
>     do so with execvp(), but illustrating with execlp() is easier to
>     read and write---hence "a moral equivalent of").

I can see the benefits of this.
