Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2454C433DB
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86815619E9
	for <git@archiver.kernel.org>; Wed, 24 Mar 2021 05:23:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbhCXFWd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Mar 2021 01:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232873AbhCXFWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Mar 2021 01:22:06 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A466BC061763
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 22:22:06 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 68-20020a9d0f4a0000b02901b663e6258dso21855456ott.13
        for <git@vger.kernel.org>; Tue, 23 Mar 2021 22:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnnczfsOGdaG541hhA9t6Zv1/KHee2jpfi0pKStjGQk=;
        b=iPHjlTwGPNP1TqiLdXVEMKgJSmqh+LuoEar3t99h7AxuvN85UcVz34iALmDYaCsn7y
         boMxA5yZ99TWU7KlaRasUW6y+2T3e58LZRVDYL7+abeRgjhTZKmApLhhimGRxaYRxZWZ
         grsvCYPiDHsQOKDlhzfE6T4bK9GerPhMixzCh+BcTd7uoTvcwLI8NSSwfj09MSatXzB0
         9Jvpd2fdN6ZqC6sfqoMVmKtsbIDLJA18h8EkA9LOgL8+oIhO1Kf2QKTABOBAuiTuYe6V
         br4RoDfC7rah6Cl0eKS2L2Q1y7EW/ddMaB1MLFAVml7Waa5wzgBSWj3PbEJBJvtB+N5F
         5cuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnnczfsOGdaG541hhA9t6Zv1/KHee2jpfi0pKStjGQk=;
        b=AKyKepd8ZfNo6329h4+ARpksZ5KgCrWdGatsNdZnI6Y74yWwToyZKUPub0sWfbie4N
         965iJWhLdA7ntCkzmep78srGI03hwhfSarW5MIs6QK3TDxVbCqiKUgUZDrwHz8lbZfTu
         q3iX2EeDUsH4DqPzxtmNiY+X3SVPZzsYU2A/3pcrqh0aBTp2jT8lnzwYrQzhB93O+go9
         HhSDgd01VH1d+2hcIZAVeh4F7pXPAA3RnCCkAb8x9O/p0w4RVZlSUCCLwRcdMksG+2l3
         aPWaTntNosXnVEP2R1NtJprHuO+i5VAhsbf7RWy2BYZcUO7cw0TEMNRvo/UluIDm5U3m
         Hw4Q==
X-Gm-Message-State: AOAM531awJK0sIxuui8Dm1odB2LlnqYGzeL6CYUKiSkDZ56dHskCKQip
        KzuoE2exuqAO0vcDYBnx2CG3KixgkMXsQEIyXPw=
X-Google-Smtp-Source: ABdhPJwY0suEc+1nRD/UoigBrjlCZT/xstfxlyudfzmxZYO91GnXxb6FtA6kPHC3GMOqdFMehmcCWyHLGPZf0SY2v74=
X-Received: by 2002:a05:6830:17d7:: with SMTP id p23mr1632191ota.164.1616563325774;
 Tue, 23 Mar 2021 22:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.901.v12.git.1616247681211.gitgitgadget@gmail.com>
 <pull.901.v13.git.1616387093662.gitgitgadget@gmail.com> <CAP8UFD0rtX0m+fGcvGFtsFFKZ2LVyxHx8dptYFvM9kWnbxEwFA@mail.gmail.com>
 <CAOLTT8Ty5kabU6ivX946=FDWJ4SEXBzPinq2aG5t7Rp9jCCEPA@mail.gmail.com>
 <CAP8UFD3fYTc8=y+kru-mN5KmTsnqc6X8mf14VtyWf1Nj9CJ1EQ@mail.gmail.com>
 <xmqqv99i4ck2.fsf@gitster.g> <CAP8UFD0s4Gm3PgDPpsXC-8Gyrnn1JTMUBu60XGV7i8nRDCCJ2Q@mail.gmail.com>
 <xmqqeeg54wye.fsf@gitster.g>
In-Reply-To: <xmqqeeg54wye.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 24 Mar 2021 13:21:54 +0800
Message-ID: <CAOLTT8S5djZQ7AEA8Cs5Q_3SMdjo+efJ+U4bP23=iXQGxqfyfQ@mail.gmail.com>
Subject: Re: [PATCH v13] [GSOC] commit: add --trailer option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        "Bradley M. Kuhn" <bkuhn@sfconservancy.org>,
        Brandon Casey <drafnel@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        Rafael Silva <rafaeloliveira.cs@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>
> It probably would have been better to do so before the feature got
> unleased to the public, but doing such a change retroactively would
> introduce regression for those who were using ARG that happens to be
> safe from shell quoting rules.
>
> For example, if the trailer.*.command were
>
>         echo '$ARG'
>
> and the argument 'h e l l o' were to be given to it, then the
> current code would have textually expanded $ARG with the argument
> and caused
>
>         echo 'h e l l o'
>
> to run, which would have been "fine" [*1*].
>
> But exporting the environment ARG would "break" such a setting that
> has been "working perfectly well" for the user.  Because of the
> single-quotes around $ARG, the command now will give literal four
> letter string $ARG and not 'h e l l o'.
>
> We should think such potential ramifications of changing it (and
> also not changing it) through before deciding what to do about it.
>
> Although I have a feeling that not many people would miss '$ARG'
> inside a pair of single-quotes to be replaced textually and it would
> be OK to make a backward incompatible bugfix, the safer and better
> way is not all that difficult, so I am inclined to suggest going the
> usual "deprecate and replace and then later remove" dance.
>

I think what you mean is that my patch breaks the principle of
"forward compatibility", which may make it impossible for users who
previously worked with `'$ARG'`.

> The normal sequence of replacing a "sort of works but not
> recommended" feature with a "better and safer, but can break a
> setting that has been 'working'" feature is:
>
>  - Announce deprecation of trailer.x.command and add and advertise a
>    similar traier.x.cmd that (1) exports environment variable ARG,
>    or (2) passes the argument as a positional parameter [*], as a
>    replacement.  Explain the reason for deprecation (i.e. unsafe
>    substitution that works only once).  When .cmd exists, .command
>    is ignored for the corresponding trailer.x
>

As your example below:

cmd = test -n "$1" && git log --author="$1" -1 --format='%aN <%aE>'

I would like to use this way.

It may be a bit cumbersome to do "deprecate and replace and
then later remove", Should documents tell users that the old method
"trailer.command" has been replaced by "trialer.cmd"? Or tell users that
"trailer.cmd" is a new feature?

Keep these doubts, I will try go to code it.

>  - Wait for a few releases and then remove trailer.x.command.
>
> and that is the safest way to fix this "bug".
>
>
> [Footnotes]
>
> *1* If the argument were
>
>         ';rm -rf .;'
>
>     then it wouldn't have been fine, though, and that is how the
>     current code solicited "Huh?"  reaction out of me.
>

A little scary. :-)

>
> *2* If we passed the argument as a positional parameter, the example
>     you gave in the quoted part of the message would become
>     something like this:
>
>       [trailer "sign"]
>         cmd = test -n "$1" && git log --author="$1" -1 --format='%aN <%aE>'
