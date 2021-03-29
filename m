Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6EEC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763AD61938
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbhC2No2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhC2NoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:44:08 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4191C061756
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:44:07 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id s11-20020a056830124bb029021bb3524ebeso12350566otp.0
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WCPSJFHqhbJ/rVDU+LxZsdHarWGryVeE5hckZqeRquU=;
        b=qVp0d4MF8w9uozUpUjsDot7nA1hPXlTuZehqmTvoKeaX78X5OobJ2wAU11jO9tfnby
         9FtlTV99m6muxgzJ6zI6bspcR7IENisgVn2vooQTeAfPz939t2/RrSyf0x7iCyWIsq0w
         mYPGmtM6KlrGn9CSBLDEwjg/lYTs3qpHwaHv6yk08bgmgxdLOrKdq0eRr3rOn00SwKiW
         rR2h0oF2+ouaCPs+lTh7yc2BO9h0ZSAor0G477mRLPySHuMnw+fiCiTDfKSP1+FucCmC
         oZtRci1tx3GM6+0GwjZQmtut84w3IEDPcEE+4EnLOu+DxbTdZI/SbSvBwCCx2hb4NpSk
         UEUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WCPSJFHqhbJ/rVDU+LxZsdHarWGryVeE5hckZqeRquU=;
        b=ZKYFdWOVTjeuTPWPjYKIe1PsdanFTs8Jpsp+ggONBuLRP1Nj2+Wb0Jjv0DlQgtfo5C
         qPbKPNNyyOXSqDTxhUogxS8e6GIyGtEiWvnZAW5e+xxFHa71wDk1Ra1MbOQ+tv9CbJ5l
         g7epLXolvHcTNP6njl4BgCw6MRUDlhO2O1gb0UJQK64uJV98u0hlwgZ0jMa6kR2pW8Eu
         fAcfBeKy5NDg5NlQCwiUtm5Le5hLFAuX5UE8OK5pXsTZM9q+3bBvhPaOZsjbx+9snKef
         g4//qsE4Omt7Sj2iYdrVSO7z+hvJ8h9WVQNHVhlq8xZf+QFuEFLXJLQeXAPgXREDDfd3
         AIDA==
X-Gm-Message-State: AOAM53190Cg13Z96WVD4BxYkqhATmgdiEjsOqwfvowXiFvPpyxYpN8ka
        I5xKtnrc5Rvpme98t51niVGJXWUEOmjtJXSUpUw=
X-Google-Smtp-Source: ABdhPJzQ0n5atQkn7/D3+Ab+pIHcdhWd1N7smnXmdwDGUcn7RQToDt09sUJlorxRLceI27YGDGKzIWv0t5pB/VIufcg=
X-Received: by 2002:a9d:6ad6:: with SMTP id m22mr22104846otq.160.1617025447352;
 Mon, 29 Mar 2021 06:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v3.git.1616673200809.gitgitgadget@gmail.com>
 <pull.913.v4.git.1616775185562.gitgitgadget@gmail.com> <xmqqk0psqxqo.fsf@gitster.g>
 <CAP8UFD26YaoDGs_8eUhuRCytDMyOhFM-Egs-Srk83iMpZxbKxA@mail.gmail.com>
 <CAOLTT8Ryrp90xJ0=Y2avndYpf_2JvabK=XAuc+hactk8idyv1w@mail.gmail.com> <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
In-Reply-To: <CAP8UFD0OMJfkuX_JoDros7h0B20D8sm0ZbtkVpL3dCYRV_M=OA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 29 Mar 2021 21:43:54 +0800
Message-ID: <CAOLTT8RAe0HhTL6p6MXeqbSazaJF0=PtnDKvh06-FXXBB+w94A@mail.gmail.com>
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
=8829=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=885:05=E5=86=99=E9=81=93=
=EF=BC=9A
>
> >
> > Yes, $ARG or $1 are always exist because of:
> >
> >                arg =3D xstrdup("");
> >
> > so I think maybe we don't even need this judge in `apply_command`?
> > +               if (arg)
> > +                       strvec_push(&cp.args, arg);
>
> Yeah, I haven't looked at the code, but that might be a good
> simplification. If you work on this, please submit it in a separate
> commit.
>

Well, if necessary, I'll put it in another commit, maybe I should double ch=
eck
to see if there's anything special going on.

> > > Another way to do it would be to have another config option called
> > > `trailer.<token>.alwaysRunCmd` to tell if the cmd specified by
> > > `trailer.<token>.cmd` should be run even if no '<token>=3D<value>'
> > > argument is passed on the command line. As we are introducing
> > > `trailer.<token>.cmd`, it's a good time to wonder if this would be a
> > > better design. But this issue is quite complex, because of the fact
> > > that 'trailer.<token>.ifMissing' and 'trailer.<token>.ifExists' also
> > > take a part in deciding if the command will be run.
>
> Actually after thinking about it, I think it might be better, instead
> of `trailer.<token>.alwaysRunCmd`, to add something like
> `trailer.<token>.runMode` that could take multiple values like:
>

If really can achieve it is certainly better than 'alwaysRunCmd'.
The following three small configuration options look delicious.
But I think it needs to be discussed in more detail:

> - "beforeCLI": would make it run once, like ".command" does now before
> any CLI trailer are processed
>

Does "beforeCLI" handle all trailers? Or is it just doing something to add =
empty
value trailers?

> - "forEachCLIToken": would make it run once for each trailer that has
> the token, like ".command" also does now, the difference would be that
> the value for the token would be passed in the $1 argument
>

This is exactly same as before.

> - "afterCLI": would make it run once after all the CLI trailers have
> been processed and it could pass the different values for the token if
> any in different arguments: $1, $2, $3, ...
>

I might get a little confused here: What's the input for $1,$2,$3?
Is users more interested in dealing with trailers value or a line of the
trailer?

> This would make it possible to extend later if the need arises for
> more different times or ways to run configured commands.
>
> > In fact, I would prefer this design, because if I don=E2=80=99t add any=
 trailers,
> > the trailer.<token>.command I set will be executed, which may be very
> > distressing sometimes, and `alwayRunCmd` is the user I hope that "trail=
ers"
> > can be added automatically, and other trailers.<token>.command will not=
 be
> > executed automatically. This allows the user to reasonably configure th=
e
> > commands that need to be executed. This must be a very comfortable thin=
g.
>
> I agree that it should be easier and more straightforward, than it is
> now, to configure this.
>
> > But as you said, to disable the automatic addition in the original .com=
mand
> > and use the new .alwaysRunCmd, I=E2=80=99m afraid there are a lot of th=
ings to consider.
> > Perhaps future series of patches can be considered to do it.
>
> Yeah, support for `trailer.<token>.runMode` might be added in
> different commits at least and possibly later in a different patch
> series. There are the following issues to resolve, though, if we want
> to focus only on a new ".cmd" config option:
>
> - how and when should it run by default,

Do you mean that ".cmd" can get rid of the ".command" auto-add problem
in this patch series?
This might be a good idea if I can add the three modes you mentioned above
in the later patch series.

> - how to explain that in the doc, and maybe
> - how to improve the current description of what happens for ".command"
>
> > > This mechanism is the reason why a trick, when setting up a
> > > 'trailer.foo.command' trailer, is to also set 'trailer.foo.ifexists'
> > > to "replace", so that the first time the command is run (with $ARG
> > > replaced with the empty string) it will add a foo trailer with a
> > > default value, and if it is run another time, because a 'foo=3Dbar'
> > > argument is passed on the command line, then the trailer with the
> > > default value will be replaced by the value computed from running the
> > > command again with $ARG replaced with "bar".
> > >
> > > Another trick is to have the command output nothing when $ARG is the
> > > empty string along with using --trim-empty. This way the command will
> > > create an empty trailer, when it is run the first time, and if it's
> > > not another time, then this empty trailer will be removed because of
> > > --trim-empty.
> > >
> >
> > It looks very practical indeed.
> >
> > > > I cannot quite judge if what we came up with in the above
> > > > description is sufficient.
> > >
> > > I don't think it's sufficient. I think that, while we are at it, a bi=
t
> > > more thinking/discussion is required to make sure we want to keep the
> > > same design as 'trailer.<token>.command'.
> >
> > Sure. I agree that more discussion is needed.
> > I think if the documents that once belonged to .command are copied to .=
cmd,
> > will the readers be too burdensome to read them? Will it be better to m=
igrate
> > its documentation until we completely delete .command?
>
> My opinion (if we focus only on adding ".cmd") is that:
>
> - for simplicity for now it should run at the same time as ".command",
> the only difference being how the argument is passed (using $1 instead
> of textually replacing $ARG)
> - the doc for ".command" should be first improved if possible, and
> then moved over to ".cmd" saying for ".command" that ".command" is
> deprecated in favor of ".cmd" but otherwise works as ".cmd" except
> that instead using $1 the value is passed by textually replacing $ARG
> which could be a safety and correctness issue.
>

I agree with you. There may be need some discretion.

> Another way to work on all this, would be to first work on adding
> support for `trailer.<token>.runMode` and on improving existing
> documentation, and then to add ".cmd", which could then by default use
> a different ".runMode" than ".command".
>

I think the task can be put off until April.
Deal with the easier ".cmd" first.

> > > > This, too, but until ".command" is removed, wouldn't it be better
> > > > for readers to keep both variants, as the distinction between $ARG
> > > > and $1 needs to be illustrated?
> >
> > So the correct solution should be to keep the original .command Example=
s,
> > and then give the .cmd examples again.
>
> Maybe we could take advantage of ".cmd" to show other nice
> possibilities to use all of this. Especially if support for `git
> commit --trailer ...` is already merged, we might be able to use it in
> those examples, or perhaps add some examples to the git commit doc.
>

Oh, the 'commit --trailer' may still be queuing, It may take a while.

> Best,
> Christian.

Thanks.

--
ZheNing Hu
