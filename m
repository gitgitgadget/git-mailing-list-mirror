Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A91C433C1
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67A961935
	for <git@archiver.kernel.org>; Sun, 28 Mar 2021 10:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbhC1KrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Mar 2021 06:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1Kq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Mar 2021 06:46:58 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74181C061762
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:46:58 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id m21-20020a9d7ad50000b02901b83efc84a0so9494128otn.10
        for <git@vger.kernel.org>; Sun, 28 Mar 2021 03:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sjiJo05oWq0Qlo24LkaslH5dXrMkXYAo4MS43xjJRFY=;
        b=hsHANkmPLoECjVcd0aU6FxIUksDmnsE18JXymZ5jI8ZLkMWvtB3kwzU6n4Ktc2xXvr
         nfkDk9QaNtAMS/B8irz9oL8p4WvTl96b2DvbuUnIaBqj2umHSzcrv0pJDLVS+TI/WWlk
         4LKa96OpXa3OzPBbX9zZLZBEGrWE2L1ISW/R2GuFc8u7SN2mLDxo3O3dbm8cQ5tLV+eL
         SlchZZs5oISB5WQbUuwHhhfNGoUJGTWUMA5YtUh8ioUWR8zhCI9XqoO3JfcIXDEsh+i4
         OrrCMzEs/oinlmAnB1kXLFo3axy0oqJO/q2ONxIypwVv9AbBKCt87Y2fTLpY+dY9ado+
         P9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sjiJo05oWq0Qlo24LkaslH5dXrMkXYAo4MS43xjJRFY=;
        b=ZKYncoTh2LCx9aPYHGe0kxjJfpStBUNYcMDijyk24/AAwquEluQ2emBzwNFfzeqouK
         H/qNi0Fd30P9BhouPQwzcuHEzQSEozOJdYfNyr4r/ec1AEWqlGsSoih23jZcwpaIACxB
         wXGADWru0SzPS0KHqxs8DyX+dlrzorF8WEeIO+I/Hc/yGpB02r7Kl0yXCykxKaM6lc5r
         NtYq0p662JQu7AACNTIkeutHmTwOTA2v+Ir9jCCGXOZzrtmwAl8MfODGFy8+cyc/Ukpz
         0bMf5ERu4hXq+o10kJVhdOX0g94GUjL3yNfqag8xHCvOYBzuBviyTaR3r0C0aF4ePMvt
         jh3Q==
X-Gm-Message-State: AOAM533wExgZalPZKpCL6MOt7oQbn8cP8HCxZnSEwOVgq3UbOUIstzvG
        lY2b1ub8kcVR6N9figtuGLFkfV5C0p59YjXP16bp5XlnqVs6vh57
X-Google-Smtp-Source: ABdhPJyQQSPH3tl6FG4l26AROY1ccnRNZZN8qM1wM2Dz64hFy5mkk0QoP3jW6K4tFjnqzLQ/RxpkAIxY8V9zrkEISTw=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr18792761ota.164.1616928417684;
 Sun, 28 Mar 2021 03:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
In-Reply-To: <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 28 Mar 2021 18:46:42 +0800
Message-ID: <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=
=8828=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=883:53=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Sat, Mar 27, 2021 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > @@ -252,6 +252,16 @@ also be executed for each of these arguments. An=
d the <value> part of
> > >  these arguments, if any, will be used to replace the `$ARG` string i=
n
> > >  the command.
> > >
> > > +trailer.<token>.cmd::
> > > +     The command specified by this configuration variable is run
> > > +     with a single parameter, which is the <value> part of an
> > > +     existing trailer with the same <token>.  The output from the
> > > +     command is then used as the value for the <token> in the
> > > +     resulting trailer.
> > > +     The command is expected to replace `trailer.<token>.cmd`.
>
> s/trailer.<token>.cmd/trailer.<token>.command/
>
> > > +     When both .cmd and .command are given for the same <token>,
> > > +        .cmd is used and .command is ignored.
> >
> > Christian, because ".cmd" is trying to eventually replace it, I find
> > it a bit disturbing that the description we give here looks a lot
> > smaller compared to the one for ".command".  I am afraid that we may
> > have failed to reproduce something important from the description of
> > the ".command" for the above; care to rend a hand or two here to
> > complete the description?
>
> Yeah, sure. I just saw that you already asked about this in this
> thread. Sorry for not answering earlier.
>
> > As I cannot grok what the description for ".command" is trying to
> > say, especially around this part:
> >
> >     When this option is specified, the behavior is as if a special
> >     '<token>=3D<value>' argument were added at the beginning of the com=
mand
> >     line, where <value> is ...
>
> This is because when a number of trailers are passed on the command
> line, and some other trailers are in the input file, the order in
> which the different trailers are processed and their priorities can be
> important. So by saying the above, people can get an idea about at
> which point and with which priority a trailer coming from such a
> config option will be processed.
>

This shows that .command itself has the characteristic of alwaysRun:
even if <token> <value> is not specified, the shell in .command will be
executed at least once, $ARG is empty by default. This is why I asked
`log --author=3D$ARG -1` will show the last commit identity when `--trailer=
`
 is not used.

> > and
> >
> >     If some '<token>=3D<value>' arguments are also passed on the comman=
d
> >     line, when a 'trailer.<token>.command' is configured, the command w=
ill
> >     also be executed for each of these arguments.
>
> Yeah, this means that when a 'trailer.foo.command' is configured, it
> is always executed at least once. The first time it is executed, it is
> passed nothing ($ARG is replaced with the empty string). Then for each
> 'foo=3D<value>' argument passed on the command line, it is executed once
> more with $ARG replaced by <value>.
>
> The reason it is always executed first with $ARG replaced with the
> empty string is that this way it makes it possible to set up commands
> that will always be executed when `git interpret-trailers` is run.
> This makes it possible to automatically add some trailers if they are
> missing for example.
>

Yes, $ARG or $1 are always exist because of:

               arg =3D xstrdup("");

so I think maybe we don't even need this judge in `apply_command`?
+               if (arg)
+                       strvec_push(&cp.args, arg);

> Another way to do it would be to have another config option called
> `trailer.<token>.alwaysRunCmd` to tell if the cmd specified by
> `trailer.<token>.cmd` should be run even if no '<token>=3D<value>'
> argument is passed on the command line. As we are introducing
> `trailer.<token>.cmd`, it's a good time to wonder if this would be a
> better design. But this issue is quite complex, because of the fact
> that 'trailer.<token>.ifMissing' and 'trailer.<token>.ifExists' also
> take a part in deciding if the command will be run.
>

In fact, I would prefer this design, because if I don=E2=80=99t add any tra=
ilers,
the trailer.<token>.command I set will be executed, which may be very
distressing sometimes, and `alwayRunCmd` is the user I hope that "trailers"
can be added automatically, and other trailers.<token>.command will not be
executed automatically. This allows the user to reasonably configure the
commands that need to be executed. This must be a very comfortable thing.

But as you said, to disable the automatic addition in the original .command
and use the new .alwaysRunCmd, I=E2=80=99m afraid there are a lot of things=
 to consider.
Perhaps future series of patches can be considered to do it.

> This mechanism is the reason why a trick, when setting up a
> 'trailer.foo.command' trailer, is to also set 'trailer.foo.ifexists'
> to "replace", so that the first time the command is run (with $ARG
> replaced with the empty string) it will add a foo trailer with a
> default value, and if it is run another time, because a 'foo=3Dbar'
> argument is passed on the command line, then the trailer with the
> default value will be replaced by the value computed from running the
> command again with $ARG replaced with "bar".
>
> Another trick is to have the command output nothing when $ARG is the
> empty string along with using --trim-empty. This way the command will
> create an empty trailer, when it is run the first time, and if it's
> not another time, then this empty trailer will be removed because of
> --trim-empty.
>

It looks very practical indeed.

> > I cannot quite judge if what we came up with in the above
> > description is sufficient.
>
> I don't think it's sufficient. I think that, while we are at it, a bit
> more thinking/discussion is required to make sure we want to keep the
> same design as 'trailer.<token>.command'.

Sure. I agree that more discussion is needed.
I think if the documents that once belonged to .command are copied to .cmd,
will the readers be too burdensome to read them? Will it be better to migra=
te
its documentation until we completely delete .command?

>
> > > -* Configure a 'sign' trailer with a command to automatically add a
> > > +* Configure a 'sign' trailer with a cmd to automatically add a
> > >    'Signed-off-by: ' with the author information only if there is no
> > >    'Signed-off-by: ' already, and show how it works:
> > >  +
> > > @@ -309,7 +319,7 @@ $ git interpret-trailers --trailer 'Cc: Alice <al=
ice@example.com>' --trailer 'Re
> > >  $ git config trailer.sign.key "Signed-off-by: "
> > >  $ git config trailer.sign.ifmissing add
> > >  $ git config trailer.sign.ifexists doNothing
> > > -$ git config trailer.sign.command 'echo "$(git config user.name) <$(=
git config user.email)>"'
> > > +$ git config trailer.sign.cmd 'echo "$(git config user.name) <$(git =
config user.email)>"'
> > >  $ git interpret-trailers <<EOF
> > >  > EOF
> >
> > This change would definitely be needed when the support for
> > ".command" is removed after deprecation period.  As it does not take
> > any argument, .cmd and .command should behave identically, so making
> > this change now, without waiting, may make sense.
>
> By the way the above example is an example of why we might want any
> configured command to be executed at least once, even when no
> corresponding '<token>=3D<value>' argument is passed on the command
> line.

Already noticed that.

>
> > > @@ -333,14 +343,14 @@ subject
> > >  Fix #42
> > >  ------------
> > >
> > > -* Configure a 'see' trailer with a command to show the subject of a
> > > +* Configure a 'see' trailer with a cmd to show the subject of a
> > >    commit that is related, and show how it works:
> > >  +
> > >  ------------
> > >  $ git config trailer.see.key "See-also: "
> > >  $ git config trailer.see.ifExists "replace"
> > >  $ git config trailer.see.ifMissing "doNothing"
> > > -$ git config trailer.see.command "git log -1 --oneline --format=3D\"=
%h (%s)\" --abbrev-commit --abbrev=3D14 \$ARG"
> > > +$ git config trailer.see.cmd "test -n \"\$1\" && git log -1 --onelin=
e --format=3D\"%h (%s)\" --abbrev-commit --abbrev=3D14 \"\$1\"|| true "
> > >  $ git interpret-trailers <<EOF
> > >  > subject
> >
> > This, too, but until ".command" is removed, wouldn't it be better
> > for readers to keep both variants, as the distinction between $ARG
> > and $1 needs to be illustrated?

So the correct solution should be to keep the original .command Examples,
and then give the .cmd examples again.

> >
> > Besides, the examples given here are not equivalent.  The original
> > assumes that ARG is there, or it is OK to default to HEAD; the new
> > one gives no output when $ARG/$1 is not supplied.
>
> Yeah, I agree they are not equivalent.
>
> > It would confuse
> > readers to give two too-similar-but-subtly-different examles, as
> > they will be forced to wonder if the difference is something needed
> > to transition from .command to .cmd (and I am guessing that it is
> > not).
>
> I agree.

OK...I will modify it.

>
> > Rewriting both to use "--pretty=3Dreference" may be worth doing.  As
> > can be seen in these examples:
> >
> > git show -s --pretty=3Dreference \$1
> > git log -1 --oneline --format=3D\"%h (%s)\" --abbrev-commit --abbrev=3D=
14 \$1
> >
> > that it makes the result much easier to read.
>
> Yeah, thanks for the good suggestion.

Yes, `--pretty=3Dreference` is similar to `--format=3D"%h(%s)"` and provide=
s better
readability.

Thanks,Junio and Christian!

--
ZheNing Hu
