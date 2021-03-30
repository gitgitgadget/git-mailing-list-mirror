Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9C1C433C1
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 11:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9029C6192C
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 11:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbhC3LWg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 07:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC3LW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 07:22:28 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4746C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 04:22:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id a8so16103641oic.11
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 04:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HJohsHSuFU8dH+W8X6CFzcC2GoiZyWSkILH+YITpuvI=;
        b=sgeG5Lcn0HieKYlPqNWf+5ck3KzTMC8xM8ucYx959EVNv7jk8trgE+6TBHqsbM2yTr
         ZEemLd2tdwKi/3CcQDIsrXw5WHBxgum5vswM8+pSw/lqRv1G67zeQcG/2opwH+QN/Y8H
         lhNUFw2oXK4hA+KeE4MPgf7oDlOwJpHTy10ZvMs09PzhLzMvlNfVsFLDzVqy/ICy8v4d
         DxoompDYknBFVqAb7xfsHZJS2Pq33dP6utz2vepRJ2weQo4ZWxwt+wOfCX1oim9dlFTr
         DFqilc39cb4OodQZM49e6KpbXD3kht9DCiC8msH5VW/fNMp4rJo3F2Uzy9vV4yg/WVlb
         ygXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HJohsHSuFU8dH+W8X6CFzcC2GoiZyWSkILH+YITpuvI=;
        b=daDEJ1fI1zJZ6ZIxPiv7GYFesHoveV14QOu90Ovsg6b+IboE/IrIpUrYSLPzOYT1Hd
         fKJlELL5lK8ny8TbQJ3vT2CDV2SBKdHXi7BhanD41JZmu0+euXnK+Upmrl8RdhhXipsi
         rTokQB/7/3hlRxX0gZutI6IFnwCtmCimkjNjbmFE510T7E78ELivfoFLBigfvrgd9ERl
         uuN7C5uTqg+7xb1u046O71ZTcPuEMSPxlCfd7hoc9A5xJSOT9T2QBYClebHMSiKgtK8k
         CRcMaVnJ8FXjTmfXx/+f3mF5RWmqNvU7Ic6d7AJkeYLWE3Nf4mORGxkvTEpJTAHgejl4
         uaUQ==
X-Gm-Message-State: AOAM532ZUV0aUg8gXckMiVxpajzh1ec+NApHap6pfI8kZiEuRkJXgjpg
        meDtRrlscfqRp3Chac/HT+WIO/y6gjEjxjOR0lY=
X-Google-Smtp-Source: ABdhPJys4qf/X5CsiYWl7QgGoWi6TqR/gxQBJ/02sQyTDHAUqRbMdxG5Mu7e15Q1+5WSqkGmSSzsyRgmyhJJ1iAL7KE=
X-Received: by 2002:a05:6808:68a:: with SMTP id k10mr2817151oig.120.1617103345744;
 Tue, 30 Mar 2021 04:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
 <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
 <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
 <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com> <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com>
In-Reply-To: <CAP8UFD1XSTAq28LrBe-q+M_Vs78gZhr58mHM6EgYt9g3pPuPDg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 30 Mar 2021 19:22:13 +0800
Message-ID: <CAOLTT8SfOKS41uJDHAMAmhWZXc3qZsngfFtsbzXxdNP1cEObzg@mail.gmail.com>
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
=8830=E6=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=884:45=E5=86=99=E9=81=93=
=EF=BC=9A
>
> On Mon, Mar 29, 2021 at 3:44 PM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=
=E6=9C=8829=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:05=E5=86=99=E9=
=81=93=EF=BC=9A
> > >
> > > >
> > > > Yes, $ARG or $1 are always exist because of:
> > > >
> > > >                arg =3D xstrdup("");
> > > >
> > > > so I think maybe we don't even need this judge in `apply_command`?
> > > > +               if (arg)
> > > > +                       strvec_push(&cp.args, arg);
> > >
> > > Yeah, I haven't looked at the code, but that might be a good
> > > simplification. If you work on this, please submit it in a separate
> > > commit.
> >
> > Well, if necessary, I'll put it in another commit, maybe I should doubl=
e check
> > to see if there's anything special going on.
> >
> > > > > Another way to do it would be to have another config option calle=
d
> > > > > `trailer.<token>.alwaysRunCmd` to tell if the cmd specified by
> > > > > `trailer.<token>.cmd` should be run even if no '<token>=3D<value>=
'
> > > > > argument is passed on the command line. As we are introducing
> > > > > `trailer.<token>.cmd`, it's a good time to wonder if this would b=
e a
> > > > > better design. But this issue is quite complex, because of the fa=
ct
> > > > > that 'trailer.<token>.ifMissing' and 'trailer.<token>.ifExists' a=
lso
> > > > > take a part in deciding if the command will be run.
> > >
> > > Actually after thinking about it, I think it might be better, instead
> > > of `trailer.<token>.alwaysRunCmd`, to add something like
> > > `trailer.<token>.runMode` that could take multiple values like:
> >
> > If really can achieve it is certainly better than 'alwaysRunCmd'.
> > The following three small configuration options look delicious.
> > But I think it needs to be discussed in more detail:
> >
> > > - "beforeCLI": would make it run once, like ".command" does now befor=
e
> > > any CLI trailer are processed
> >
> > Does "beforeCLI" handle all trailers? Or is it just doing something to =
add empty
> > value trailers?
>
> I am not sure what you mean by "handle all trailers". What I mean is
> that it would just work like ".command" does right now before the
> "--trailers ..." options are processed.
>
> Let's suppose the "trailer.foo.command" config option is set to "bar".
> Then the "bar" command will be run just before the "--trailers ..."
> options are processed and the output of that, let's say "baz" will be
> used to add a new "foo: baz" trailer to the ouput of `git
> interpret-trailers`.
>
> For example:
>
> -------
> $ git -c trailer.foo.command=3D'echo baz' interpret-trailers<<EOF
> EOF
>
> foo: baz
> -------
>
> In other words an empty value trailer is just a special case when the
> command that is run does not output anything. But such commands are
> expected to output something not trivial at least in some cases.
>
> See also the example in the doc that uses:
>
> $ git config trailer.sign.command 'echo "$(git config user.name)
> <$(git config user.email)>"'
>

I see what you mean, which is to provide a default value for any
trailers that haven't been run command yet.

> > > - "forEachCLIToken": would make it run once for each trailer that has
> > > the token, like ".command" also does now, the difference would be tha=
t
> > > the value for the token would be passed in the $1 argument
> >
> > This is exactly same as before.
>
> Yeah it is the same as before when the "--trailers ..." options are
> processed, but not before that.
>
> To get exactly the same as before one would need to configure both
> "beforeCLI" _and_ "forEachCLIToken", for example like this (note that
> we use "--add" when adding "forEachCLIToken"):
>
> $ git config trailer.foo.runMode beforeCLI
> $ git config --add trailer.foo.runMode forEachCLIToken
> $ git config -l | grep foo
> trailer.foo.runmode=3DbeforeCLI
> trailer.foo.runmode=3DforEachCLIToken
>
> > > - "afterCLI": would make it run once after all the CLI trailers have
> > > been processed and it could pass the different values for the token i=
f
> > > any in different arguments: $1, $2, $3, ...
> >
> > I might get a little confused here: What's the input for $1,$2,$3?
>
> The input would be the different values that are used for the token in
> the "--trailer ..." CLI arguments.
>
> For (an hypothetical) example:
>
> ------
> $ git config trailer.foo.runMode afterCLI
> $ git config trailer.foo.cmd 'echo $@'
> $ git interpret-trailers --trailer foo=3Da --trailer foo=3Db --trailer fo=
o=3Dc<<EOF
> EOF
>
> foo: a b c
> $ git interpret-trailers<<EOF
> EOF
>
> foo:
> ------
>
> I am not sure "afterCLI" would be useful, but we might not want to
> implement it right now. It's just an example to show that we could add
> other modes to run the configured ".cmd" (and maybe ".command" too).
>

Yes, not so useful.

> > Is users more interested in dealing with trailers value or a line of th=
e
> > trailer?
>
> I am not sure what you mean here. If "a line of the trailer" means a
> trailer that is already in the input file that is passed to `git
> interpret-trailers`, and if "trailers value" means a "--trailer ..."
> argument, then I would say that users could be interested in dealing
> with both.
>

Sorry, I mean after we running those command, a line trailer is
"foo: bar" and trailers value will be "bar".

> It's true that right now the command configured by a ".command" is not
> run when `git interpret-trailers` processes in input file that
> contains a trailer with the corresponding token. So new values for
> ".runMode" could be implemented to make that happen.
>

Sure.

> > > > But as you said, to disable the automatic addition in the original =
.command
> > > > and use the new .alwaysRunCmd, I=E2=80=99m afraid there are a lot o=
f things to consider.
> > > > Perhaps future series of patches can be considered to do it.
> > >
> > > Yeah, support for `trailer.<token>.runMode` might be added in
> > > different commits at least and possibly later in a different patch
> > > series. There are the following issues to resolve, though, if we want
> > > to focus only on a new ".cmd" config option:
> > >
> > > - how and when should it run by default,
> >
> > Do you mean that ".cmd" can get rid of the ".command" auto-add problem
> > in this patch series?
>
> I am not sure what you mean with "auto-add". Do you mean that fact
> that the ".command" runs once before the CLI "--trailer ..." options
> are processed?
>

I'm talking about the empty values $ARG passing to the user's command,
those command  at least run once, You say "how and when should it run by
default", I was wondering if I could not run .cmd without passing trailer.

> > This might be a good idea if I can add the three modes you mentioned ab=
ove
> > in the later patch series.
>
> I like that your are interested in improving trailer handling in Git,
> but I must say that if you intend to apply for the GSoC, you might
> want to work on your application document first, as it will need to be
> discussed on the mailing list too and it will take some time. You are
> also free to work on this too, but that shouldn't be your priority.
>

In fact, I had written the proposal carefully.
I have been studying what went wrong with OIga's improvement of cat-file
recently.

I may have thought of some ideas, and has been written in Proposal,
I will submit it in about two days :)

> By the way if this (or another Git related) subject is more
> interesting to you than the project ideas we propose on
> https://git.github.io/SoC-2021-Ideas/, then you are welcome to write a
> proposal about working on this (improving trailer handling) rather
> than on a project idea from that page. You might want to make sure
> that some people would be willing to (co-)mentor you working on it
> though.
>

Aha, for the time being, you are the most suitable mentor,
But I might just take improvement of `interpret-tarilers` as my interest to
do something. I will choice the project of "git cat-file" .

> [...]
>
> > > Another way to work on all this, would be to first work on adding
> > > support for `trailer.<token>.runMode` and on improving existing
> > > documentation, and then to add ".cmd", which could then by default us=
e
> > > a different ".runMode" than ".command".
> >
> > I think the task can be put off until April.
> > Deal with the easier ".cmd" first.
>
> Ok for me, but see above about GSoC application.
>
>
> > > > > > This, too, but until ".command" is removed, wouldn't it be bett=
er
> > > > > > for readers to keep both variants, as the distinction between $=
ARG
> > > > > > and $1 needs to be illustrated?
> > > >
> > > > So the correct solution should be to keep the original .command Exa=
mples,
> > > > and then give the .cmd examples again.
> > >
> > > Maybe we could take advantage of ".cmd" to show other nice
> > > possibilities to use all of this. Especially if support for `git
> > > commit --trailer ...` is already merged, we might be able to use it i=
n
> > > those examples, or perhaps add some examples to the git commit doc.
> >
> > Oh, the 'commit --trailer' may still be queuing, It may take a while.
>
> You might want to check if it needs another reroll or if there are
> other reasons (like no reviews) why it's not listed in the last
> "What's cooking ..." email from Junio. If you think it is ready and
> has been forgotten, you can ping reviewers (including me), to ask them
> to review it one more time, or Junio if the last version you sent has
> already been reviewed.

It should still be in "seen" inheritance, Junio is advancing it.
Maybe you think it has something to improve, please feel free to tell me.

In addition, I now found a small bug in ".cmd",

git config -l |grep bug
trailer.bug.key=3Dbug-descibe:
trailer.bug.ifexists=3Dreplace
trailer.bug.cmd=3Decho 123

see what will happen:

git interpret-trailers --trailer=3D"bug:text" <<-EOF
`heredocd> EOF

bug-descibe:123 text

"text" seem print to stdout.

I'm looking at what's going on here.

--
ZheNing Hu
