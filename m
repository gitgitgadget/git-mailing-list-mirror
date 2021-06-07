Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3ABC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 282E460FDA
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 13:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGNEc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbhFGNEb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 09:04:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4733C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 06:02:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id a6so18245990ioe.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PrG2dJc+XY9kC8iScvoaVYQYWT/GJgzqvaMg7PaHoYg=;
        b=dJai1f/mHQkbOJ+F/dY0X79qB88sohkyvy17/Y+OMNnsJ9mW8SGkEYzAW9GRewKLdz
         ylmIUPnxZvLS+IUeIH7n8Hi15VM/Rt0+OI2A+ezR3SeOLtIRR85ZGwMP+2TStnRvNLir
         VkzyRBQdIs0MMYFT/m0gUlJjlsGerwh9DQxwX/U+QVryLjN3HynnRc8vuPnwDDJEBT16
         1cH8cgU1dGvh1Svuw+WLKU4h/t6C+RftheeX2Hbfl+r7NJSnrqeIifRr/IiIElMEzObY
         mbrTFpu2ZYN2uJKc1Q0RV/ypEDYgWMWm9o0zyC+qKFnxRPhVNY8TU2SceN8N3mgVIz+Y
         3Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PrG2dJc+XY9kC8iScvoaVYQYWT/GJgzqvaMg7PaHoYg=;
        b=ntrpBVk+UEDqwMs1Y1EWugdUng/g+8nxhJKD9DEk3e41k3WYjfvMP0i20Qw4T+TKCv
         Xwl6/KZQB5py8P2CPSHHAPOtnnvmBfMdTT4/94VxdKmUxI6E6tZc3EKg7Qir7W3K5w4s
         7fZbMNqyoMjaTIZXLmW12EixjKUZDyhvQuBtf15GdJlprKNrbpiqMjl8KbkIQiIqaas+
         qPvpyATXU4X5Cf8iwHXFFRkOz9cVb6NXKOztPXfACtOeGSpxEdHmMTSD1SYhocm9AwQB
         WbFXvE9pR++ZDb5AVt02apfgN9tFUPJEFuarmhOMcw5IXwodqh/2ZOgfinsgg7MuCnyS
         4IjA==
X-Gm-Message-State: AOAM530ABS87WNCs6CgRhVumDX9sNRiahHpBJSZ4UoTQs4vVGHEgcJuM
        ozLrJ/SqikAHL66KpklyZ96q4Q1oCR6vpMqt6aQ=
X-Google-Smtp-Source: ABdhPJxAG8/yn+fjz/d+Dj37ecViZ6ydaSmgspTooPPgzPc27ATiCih2JkDITsbL1uO3tAGrjgqWw432hk0qZmdBqLs=
X-Received: by 2002:a05:6638:1602:: with SMTP id x2mr14131088jas.130.1623070960080;
 Mon, 07 Jun 2021 06:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
 <ccdd18ad508824aa206a02c479229d0ede69522d.1622884415.git.gitgitgadget@gmail.com>
 <xmqq7dj6w7a6.fsf@gitster.g>
In-Reply-To: <xmqq7dj6w7a6.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 7 Jun 2021 21:02:28 +0800
Message-ID: <CAOLTT8S+5m+-XF-AcQi9t8njTvyDYzHt=BU+4OPcvTT27RP6dw@mail.gmail.com>
Subject: Re: [PATCH 4/6] [GSOC] ref-filter: add %(rest) atom and --rest option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B46=E6=9C=887=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=881:52=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In order to let "cat-file --batch=3D%(rest)" use the ref-filter
> > interface, add %(rest) atom for ref-filter and --rest option
> > for "git for-each-ref", "git branch", "git tag" and "git verify-tag".
> > `--rest` specify a string to replace %(rest) placeholders of
> > the --format option.
>
> I cannot think of a sane reason why we need to allow "%(rest)" in
> anithing but "cat-file --batch", where a natural source of %(rest)
> exists in its input stream (i.e. each input record begins with an
> object name to be processed, and the rest of the record can become
> "%(rest)").
>

First of all, although %(rest) is meaningless in ordinary circumstances,
ref-filter must learn %(rest), it is impossible for us to leave the parsing
of %(rest) in cat-file.c alone.

Then, `--rest` is a strategy that make %(rest) can use in `git for-each-ref=
`
or `git branch -l`. As you said, it is just a boring placeholder used for s=
tring
replacement. We can make it output only empty content, If we really don=E2=
=80=99t
need `--rest`.

> The "cat-file --batch" thing is much more understandable.  You could
> for example:
>
>     git ls-files -s |
>     sed -e 's/^[0-7]* \([0-9a-f]*\) [0-3]       /\1 /' |
>     git cat-file --batch=3D'%(objectname) %(objecttype) %(rest)'
>

s/[0-3]       /[0-3]\t/

> to massage output from "ls-files -s" like this
>
>     100644 c2f5fe385af1bbc161f6c010bdcf0048ab6671ed 0   .cirrus.yml
>     100644 c592dda681fecfaa6bf64fb3f539eafaf4123ed8 0   .clang-format
>     100644 f9d819623d832113014dd5d5366e8ee44ac9666a 0   .editorconfig
>     ...
>
> into recods of "<objectname> <path>", and each output record will
> replay the <path> part from each corresponding input record.
>

Yeah, the <path> in the input will be treated as "rest".

> Unless for-each-ref family of commands read the list of refs that it
> shows from their standard input (they do not, and I do not think it
> makes any sense to teach them to), there is no place to feed the
> "rest" information that is associated with each output record.  The
> only thing the commands taught about %(rest) by this patch can do is
> to parrot the same string into each and every output record.  I am
> not seeing what this new feature is attempting to give us.
>

"parrot the same string"? I think we should use an empty string here,
"parrot the same string" more like what the "git log --format" family does.

> If anything, I would imagine that it would be a very useful addition
> to teach the ref-filter machinery an ability to optionally error out
> depending on the caller when the caller attempts to use certain
> placeholder.  Then, we can reject "git branch --sort=3Drest" sensibly,
> instead of accepting "git branch --sort=3Drest --rest=3Dconstant", which
> is not technically wrong per-se, but smells like a total nonsense from
> practical usefulness's point of view.
>

This sounds like it might help `cat-file` to reject some useless atoms
like %(refname). So something like:

$ git for-each-ref --format=3D"%(objectname) %(objectsize)"
--refject-atoms=3D"%(objectsize) %(objectname)"

will fail.

"git for-each-ref" family use hardcoded to reject %(rest).
I can try to achieve this function.

> > -     [--list] [<pattern>...]
> > +     [--list] [<pattern>...] [--rest=3D<rest>]
> >  'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
> >  'git branch' (--set-upstream-to=3D<upstream> | -u <upstream>) [<branch=
name>]
> >  'git branch' --unset-upstream [<branchname>]
> > @@ -298,6 +298,10 @@ start-point is either a local or remote-tracking b=
ranch.
> >       and the object it points at.  The format is the same as
> >       that of linkgit:git-for-each-ref[1].
> >
> > +--rest=3D<rest>::
> > +     If given, the `%(rest)` placeholders in the `--format` option
> > +     will be replaced.
>
> If not given, what happens?

Will output an empty string.

Hope we can reach an agreement:
delete `--rest` and add `--reject-atoms`. ;-)

Thanks.
--
ZheNing Hu
