Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543D4C47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 340CD6108E
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 17:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFCRat (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 13:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbhFCRas (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 13:30:48 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88878C06174A
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 10:28:53 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a21so7060713oiw.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=XaAt66SdYaB/apOhCAQiyvITmEL3CX+UUiY5L/38tw8=;
        b=C1ykXbK/uSYVfU+7NISmxMWUTRkD145Fc3+VkDidebnY9kC8tbWmKNG71Qn9EAQntu
         QbMYYKLQP0S3SWMmZ4lzQ+3yhEJ7UTPy62t+8VH6q3R3HTdhAkL/GNCrLYjusjarEJAD
         UoY8BhJ777SlQ/U6yaYpipxRfG59zIcQ/iU+W4s55qzKcz9JF1AskbOd+fs3j4iUWQOg
         J02tGvetN1F4eWMzNyNQ27uBKayo9sd5FP5mc3Xs6xvmip6J9CbyyP4Kzsh4T+SLdf8Y
         W/YUFde8TKd61h6LQVKoi/cuytITn6O6ilAArl17UVPFu/bzhQ4PnxAZ99E3xLAp82ks
         0KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=XaAt66SdYaB/apOhCAQiyvITmEL3CX+UUiY5L/38tw8=;
        b=F6KZxYH4U40wBQtwQeVyyHzfYzxtSuX0+UjYMFT9Hj0li4Okl28N+NdpAs/yZ1ilaH
         yqAHSjnLuvITcRFZ7kj7E47+ZFdNzlbu1hJv3WjcUakFPPsTyb7o0v6xFY8u90MO4jtH
         H30MwuCE2SEMpApyZMU9n5G1FTUo0A8mUN380hyw6p1hJ9YnN8ddLlGa9CAhjKZ8oXv0
         k4PyAAvpBlj1LamfwyAQ+kh3TdC//rh/TcUU/W4EHwALJgjixuyUiZB92ZQVzeXU6T59
         4OpYVxtQUmOMQ8Tyu+5OSZnNESpupX2L9OY4qKOm8CpI2sRON85UG1VtbOD6GzGmsMng
         k2TQ==
X-Gm-Message-State: AOAM533bjpkvriUtOmTdbuef8axJrjpo0Ygv1fP8h/ll03/JEi3nEr33
        hC5P7TleH4SKCYG57tk/SjE=
X-Google-Smtp-Source: ABdhPJxf9B2WkHFAHetb/TxMEqiwZuzsBkEJjmDVRafbe38uyf2CN1V3UE6BhIg8A6lRlypkYh99Ug==
X-Received: by 2002:aca:1916:: with SMTP id l22mr214290oii.48.1622741332898;
        Thu, 03 Jun 2021 10:28:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id c13sm817125oto.18.2021.06.03.10.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 10:28:52 -0700 (PDT)
Date:   Thu, 03 Jun 2021 12:28:50 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Message-ID: <60b91152dd007_258801208b7@natae.notmuch>
In-Reply-To: <87wnrb5cvl.fsf@evledraar.gmail.com>
References: <60b5d281552d6_e359f20828@natae.notmuch>
 <87bl8n73om.fsf@evledraar.gmail.com>
 <60b8b882b9dc5_1a0a2d208e9@natae.notmuch>
 <87wnrb5cvl.fsf@evledraar.gmail.com>
Subject: Re: The git spring cleanup challenge
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Jun 03 2021, Felipe Contreras wrote:

> >>  * checkout.defaultRemote=3Dorigin: I introduced this, so I'm biased=
, but
> >>    I find it super useful. Usually because I do "git branch -m
> >>    new-branch" on master to create topics, and then "git checkout
> >>    master" to get a master back (or use the existing one).
> >
> > That is useful, but I don't think it's aptly named, it should be
> > something like checkout.autoUpstream. The name of the default branch
> > belongs elsewhere.
> >
> > I would say core.defaultRemote.
> >
> > Right now for example `git fetch` defaults to a hard-coded "origin".
> > Doesn't make much sense that the remote for automatic upstream checko=
ut
> > can be configured, but not the one `git fetch` uses.
> =

> I think there was some bikeshedding around that time. I share the
> sentiment, but worry about "core" over-configuring such a
> thing.

I don't see a need for core.defaultRemote, but I don't see a need for
checkout.defaultRemote either.

Just have `checkout.autoUpstream =3D true` and hardcode *both* to "origin=
".

> >>  * commit.verbose=3Dtrue: so you know what you're looking at in doin=
g in
> >>    "git commit --amend".
> >
> > Aha! My alias had `commit -v` but I would want this on all commit
> > commands.
> >
> > Moreover, I was thinking on suggesting this by default. Who would it
> > hurt?
> =

> E.g. "git rebase -i" with "reword" now becomes a lot more verbose, I
> think it's a feature, but others might disagree.
> =

> It also exposes various edge cases around our parsing of the diff
> v.s. commit message content in our apply.c etc. code, e.g. say you want=

> to blindly search-replace "diff" with "difference" in your commit
> messages. You'll now change the "diff --git" line to "difference --git"=
,
> and now "commit" won't detect that it's the patch part anymore, and
> merge that diff into your commit message itself.
> =

> I can't remember if we pick up on "diff --git" exactly, IIRC, but
> anyway, whatever part of the format you need to screw with, the point
> stands. I've run into mistakes like that in the past, one recently made=

> it to this ML.

I've personally never have had a problem with it.

Sure, it *might* have some issues, but any change does. That's not a
very strong arugment against making it the default.

> >>  * grep.patternType=3Dperl: Another personal soap box (but really, B=
RE
> >>    anywhere sucks).
> >
> > Nice. `git grep` is the #2 command I use the most, and I often need t=
o
> > specify another regexp because the basic one doesn't understand what =
I'm
> > trying to do.
> =

> Yeah, it should be at least ERE by default, Something for Git v3.0 ...?=

> =

> >> I also have a bunch of aliases that would not be useful to a general=

> >> audience, but which I find I can't live without, some of the most
> >> commonly used ones:
> >> =

> >>     # Log with "less" n/p already going to the next/prev commit
> >>     log-psfd =3D "!f() { PAGER=3D\"less -p'^commit'\" git log -p --s=
tat --full-diff $@; }; f"
> >
> > Very neat.
> =

> I think similar to your "git help xyz" patches having coloring, we
> really should consider things like that by default knowing that we're
> invoking "less". I.e. if we got over the notion that our job is just to=

> throw data over the wall to "man" or the pager without any further
> tweaking or integration.

Perhaps. I think defaults should be tried-and-true. Only after a
considerable number of people have tried them should they become
default.

I have no problem with something like the above being a default, but
only when the user has specified these kinds of features.

Maybe with

  [core]
    mode =3D fancy

> >> Similarly rebase is "r", "--interactive" is "ri", "--abort", and
> >> "--continue" are "ra" and "rc".
> >
> > I have almost the same, except rbi, rbc, and rba. My 'r' is reset, bu=
t
> > since I use rebase more often I guess I should switch them up.
> >
> > Theres are a couple of mine:
> >
> >   advance =3D merge --ff-only
> >   undo =3D reset --hard @{1}
> >   =

> >> If anyone's interested in the rest / full set:
> >> https://github.com/avar/dotfiles/blob/master/.gitconfig
> >
> > Is thata private repo?
> >
> > Here are mine:
> >
> > https://github.com/felipec/dotfiles/blob/master/.gitconfig
> =

> Yes, it was private[1]. I've made it public again.
> =

> 1. It used to be public, but then the security/auditing people at an
>    ex-job kept pestering me about me hardcoding =C3=BCber-secret compan=
y data
>    in public GitHub repos.
> =

>    They didn't find questions like "uh, you mean this information we
>    advertise in an MX lookup to our public nameservers?", or "yes,
>    that's my company E-Mail address in a config file, my co-workers hav=
e
>    the same info on linkedin" all that convincing. Anyway, it's back no=
w
>    :)

Yeah, it's surpsingly difficult to convince some people of the most
obvious things. I rather have a private branch on my dotfiles, where I
don't have anything sensitive really, just stuff I'm sure others won't
find useful.

Cheers.

-- =

Felipe Contreras=
