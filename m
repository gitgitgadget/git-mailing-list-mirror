Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8421EC433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 09:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FBB619A0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 09:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbhC2JGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbhC2JFE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 05:05:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BB2C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 02:05:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x21so13369432eds.4
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 02:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ErFT+Q0lPn0UoM4lFsACbS7gQQVi0qgRAVsziWONg60=;
        b=SIu7FtMGxLnLdVuBSReOK6iHDkzYRR7ZDd/hOL7Bp6t8V+GwsUnZlDaE+bmZ6TE3f8
         Dc3qyT++y9qN6MceMt4QZZeIUiwAeB9g13UlmCdUaqSL3GpsbeyIw3kI0m/SCnOv/Tc7
         1Bdmto8OApBs7tkZ2QrUURKD2tqIdgARZEO4vm9n5frzmH5DOMsvmlgX2m/MRg9q1ujF
         OJnwWF2EqFgSc1ollglHxvf0AbwO6w3gY0O+22zBgHDJ8FG816nDXk1K54KPafdx7L2d
         WMub4spKSWcsFZD4I9URGo+/zN6zNPWB5zVTxo8MaX2vQNeYYKJQ2V8QV9iEWjoNN2k2
         pQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ErFT+Q0lPn0UoM4lFsACbS7gQQVi0qgRAVsziWONg60=;
        b=SsLfktlqNPeE1jBSiSaMu286JIl8QNvQ7ScEhyjsvrroFXXsaDtxFIc6N5v1CSVTKa
         QxTH37MdlyKT5HELNwqa7z9BF9tUiqtXEBKkV8gWB4sGeUphjBXYknCQZnY1xFRRLcuS
         jl4urwUFlJUssz74pQZSSbVClTzC0wAw0CdZAI2gJW9gxwf36DztLj+ogjvnizJRk2P4
         iyZSki6B8Q/bXwjLuV9RXZk214sDqh2ry3T3g1/i9FXCsOyL41cVMM4Jb+BKLnMK2J9+
         CLG1WHfoMvy+tboiIuYjhuQWMI/rO3zaGe9wSyUgBpwB80gNFuJJnDcRc79vNmDq6qvc
         xg9w==
X-Gm-Message-State: AOAM533Ztsgmy6Y2y59Pm3K8AlrBE+EVPS6LQjQVrlLAvjUK5nHZysnT
        2cm0ccCWDgSDCEDJn4jEtZL9UMCJKD8iFdrlCOU=
X-Google-Smtp-Source: ABdhPJyCc6Iy4FhJAIKzEUMvsv6qPY4GfvOoiJ6p6kfb4YyxEX/NY3/1BhtmJlnvgQGHY6aPTx02K90YNZT8xugG0EE=
X-Received: by 2002:a05:6402:5244:: with SMTP id t4mr27546058edd.87.1617008701291;
 Mon, 29 Mar 2021 02:05:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com> <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
In-Reply-To: <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 29 Mar 2021 11:04:50 +0200
Message-ID: <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
Subject: Re: [PATCH v4] [GSOC]trailer: pass arg as positional parameter
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 28, 2021 at 12:46 PM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B43=E6=
=9C=8828=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=883:53=E5=86=99=E9=81=
=93=EF=BC=9A
> >
> > On Sat, Mar 27, 2021 at 7:04 PM Junio C Hamano <gitster@pobox.com> wrot=
e:

> > > As I cannot grok what the description for ".command" is trying to
> > > say, especially around this part:
> > >
> > >     When this option is specified, the behavior is as if a special
> > >     '<token>=3D<value>' argument were added at the beginning of the c=
ommand
> > >     line, where <value> is ...
> >
> > This is because when a number of trailers are passed on the command
> > line, and some other trailers are in the input file, the order in
> > which the different trailers are processed and their priorities can be
> > important. So by saying the above, people can get an idea about at
> > which point and with which priority a trailer coming from such a
> > config option will be processed.
>
> This shows that .command itself has the characteristic of alwaysRun:
> even if <token> <value> is not specified, the shell in .command will be
> executed at least once, $ARG is empty by default. This is why I asked
> `log --author=3D$ARG -1` will show the last commit identity when `--trail=
er`
>  is not used.

Yeah, that's the reason.

> > > and
> > >
> > >     If some '<token>=3D<value>' arguments are also passed on the comm=
and
> > >     line, when a 'trailer.<token>.command' is configured, the command=
 will
> > >     also be executed for each of these arguments.
> >
> > Yeah, this means that when a 'trailer.foo.command' is configured, it
> > is always executed at least once. The first time it is executed, it is
> > passed nothing ($ARG is replaced with the empty string). Then for each
> > 'foo=3D<value>' argument passed on the command line, it is executed onc=
e
> > more with $ARG replaced by <value>.
> >
> > The reason it is always executed first with $ARG replaced with the
> > empty string is that this way it makes it possible to set up commands
> > that will always be executed when `git interpret-trailers` is run.
> > This makes it possible to automatically add some trailers if they are
> > missing for example.
>
> Yes, $ARG or $1 are always exist because of:
>
>                arg =3D xstrdup("");
>
> so I think maybe we don't even need this judge in `apply_command`?
> +               if (arg)
> +                       strvec_push(&cp.args, arg);

Yeah, I haven't looked at the code, but that might be a good
simplification. If you work on this, please submit it in a separate
commit.

> > Another way to do it would be to have another config option called
> > `trailer.<token>.alwaysRunCmd` to tell if the cmd specified by
> > `trailer.<token>.cmd` should be run even if no '<token>=3D<value>'
> > argument is passed on the command line. As we are introducing
> > `trailer.<token>.cmd`, it's a good time to wonder if this would be a
> > better design. But this issue is quite complex, because of the fact
> > that 'trailer.<token>.ifMissing' and 'trailer.<token>.ifExists' also
> > take a part in deciding if the command will be run.

Actually after thinking about it, I think it might be better, instead
of `trailer.<token>.alwaysRunCmd`, to add something like
`trailer.<token>.runMode` that could take multiple values like:

- "beforeCLI": would make it run once, like ".command" does now before
any CLI trailer are processed

- "forEachCLIToken": would make it run once for each trailer that has
the token, like ".command" also does now, the difference would be that
the value for the token would be passed in the $1 argument

- "afterCLI": would make it run once after all the CLI trailers have
been processed and it could pass the different values for the token if
any in different arguments: $1, $2, $3, ...

This would make it possible to extend later if the need arises for
more different times or ways to run configured commands.

> In fact, I would prefer this design, because if I don=E2=80=99t add any t=
railers,
> the trailer.<token>.command I set will be executed, which may be very
> distressing sometimes, and `alwayRunCmd` is the user I hope that "trailer=
s"
> can be added automatically, and other trailers.<token>.command will not b=
e
> executed automatically. This allows the user to reasonably configure the
> commands that need to be executed. This must be a very comfortable thing.

I agree that it should be easier and more straightforward, than it is
now, to configure this.

> But as you said, to disable the automatic addition in the original .comma=
nd
> and use the new .alwaysRunCmd, I=E2=80=99m afraid there are a lot of thin=
gs to consider.
> Perhaps future series of patches can be considered to do it.

Yeah, support for `trailer.<token>.runMode` might be added in
different commits at least and possibly later in a different patch
series. There are the following issues to resolve, though, if we want
to focus only on a new ".cmd" config option:

- how and when should it run by default,
- how to explain that in the doc, and maybe
- how to improve the current description of what happens for ".command"

> > This mechanism is the reason why a trick, when setting up a
> > 'trailer.foo.command' trailer, is to also set 'trailer.foo.ifexists'
> > to "replace", so that the first time the command is run (with $ARG
> > replaced with the empty string) it will add a foo trailer with a
> > default value, and if it is run another time, because a 'foo=3Dbar'
> > argument is passed on the command line, then the trailer with the
> > default value will be replaced by the value computed from running the
> > command again with $ARG replaced with "bar".
> >
> > Another trick is to have the command output nothing when $ARG is the
> > empty string along with using --trim-empty. This way the command will
> > create an empty trailer, when it is run the first time, and if it's
> > not another time, then this empty trailer will be removed because of
> > --trim-empty.
> >
>
> It looks very practical indeed.
>
> > > I cannot quite judge if what we came up with in the above
> > > description is sufficient.
> >
> > I don't think it's sufficient. I think that, while we are at it, a bit
> > more thinking/discussion is required to make sure we want to keep the
> > same design as 'trailer.<token>.command'.
>
> Sure. I agree that more discussion is needed.
> I think if the documents that once belonged to .command are copied to .cm=
d,
> will the readers be too burdensome to read them? Will it be better to mig=
rate
> its documentation until we completely delete .command?

My opinion (if we focus only on adding ".cmd") is that:

- for simplicity for now it should run at the same time as ".command",
the only difference being how the argument is passed (using $1 instead
of textually replacing $ARG)
- the doc for ".command" should be first improved if possible, and
then moved over to ".cmd" saying for ".command" that ".command" is
deprecated in favor of ".cmd" but otherwise works as ".cmd" except
that instead using $1 the value is passed by textually replacing $ARG
which could be a safety and correctness issue.

Another way to work on all this, would be to first work on adding
support for `trailer.<token>.runMode` and on improving existing
documentation, and then to add ".cmd", which could then by default use
a different ".runMode" than ".command".

> > > This, too, but until ".command" is removed, wouldn't it be better
> > > for readers to keep both variants, as the distinction between $ARG
> > > and $1 needs to be illustrated?
>
> So the correct solution should be to keep the original .command Examples,
> and then give the .cmd examples again.

Maybe we could take advantage of ".cmd" to show other nice
possibilities to use all of this. Especially if support for `git
commit --trailer ...` is already merged, we might be able to use it in
those examples, or perhaps add some examples to the git commit doc.

Best,
Christian.
