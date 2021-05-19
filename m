Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A88AC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9E3F611AE
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352272AbhESLqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352261AbhESLqk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:46:40 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12468C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:45:20 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id u11so12847422oiv.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=GumbkIk9nXoekKyHReWKXz7H7pz3uANcr5sVr+Wy/wA=;
        b=In9Jc8ZysyH1/Ec2pLXrsTAs+RY8DL1kWl702IYgeejHeNWAUg+9a1Jlf5x0vQFdC/
         1WKIClTUzAAFq9Vd6VUuNUWY3oxew0RdzbAl6Ux17wyJ7ZkkyiTuU2WiKSPoqDZaYwo4
         zDpE5r8GBvhDLt3SXTLUSz9h3F5VD3+5n0azTmnjWFX9IPkCjingUsFz/dHbfjhV/zYb
         nIJ1EO7Rq6N6GtY+xSbs/LX0C4DxhpxE+beuhhTmoGFLB/qe7xyuisWjVheKL3+aQY8E
         2SL4vhYLW+44GQE93Qr9NfRN1fnTihXFlbyweidJdBCjFpYpvgl5OhhV+IcJodmIpyUT
         9SfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=GumbkIk9nXoekKyHReWKXz7H7pz3uANcr5sVr+Wy/wA=;
        b=XVB2d5N40NB3lk+QHOv3XCy+zd+fL+PvBWNvnIJO5NIlMujrIvfU0U4mgLOGFpp8Ar
         gKppqAstlj8fe9mWpsVrDXt2U93YebehwEze6Q/a18pUABpY/GGEi2dKmOlhE9qin1G5
         Gc+gKhAekuGR40o7SW4v2arnJNRSWIk3U+2d6v2Uy6APT7TY/AojYq1RI+m/xVT3lmRn
         /HN6gMMin+zqkgDdjFeMtJZShu6hMNM1OH5EdCMnUT6zbiKo5nL/LNpl17yywMgh5ZxH
         yraX4jRsdUz+PBdzNJlfwbZ1O7v/McuJ+pP53PZO86NZWr3lhy+RjNHj6JSJNeRFJj9L
         SdlA==
X-Gm-Message-State: AOAM531dczsPpKfEwHkgBaGNZoTWQHWSliTiaNT/8V+L3zY5HNxmTMQj
        nvAMc1vGhTD5T23yuU3Xf7E=
X-Google-Smtp-Source: ABdhPJynuHQRuMyYiTpGGEnZ6RoTYKNiuHmwS5kF96RAfMu48haEb7T3swU+ISpxg8Oys797mwv1PA==
X-Received: by 2002:aca:1015:: with SMTP id 21mr8013752oiq.92.1621424719454;
        Wed, 19 May 2021 04:45:19 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id d62sm3064217oif.47.2021.05.19.04.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 04:45:18 -0700 (PDT)
Date:   Wed, 19 May 2021 06:45:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "Randall S. Becker" <rsbecker@nexbridge.com>
Message-ID: <60a4fa4dc7701_86a820896@natae.notmuch>
In-Reply-To: <YKTkIgdJgBomzieH@coredump.intra.peff.net>
References: <20210518010121.1350327-1-felipe.contreras@gmail.com>
 <YKMWL0iZLVl1KTrB@camp.crustytoothpaste.net>
 <60a332fd22dad_14c8d4208ed@natae.notmuch>
 <YKRSlFcFAcHcR3uY@camp.crustytoothpaste.net>
 <87im3fqci9.fsf@evledraar.gmail.com>
 <YKTkIgdJgBomzieH@coredump.intra.peff.net>
Subject: Re: [PATCH] help: colorize man pages
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Wed, May 19, 2021 at 11:26:12AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
> =

> > > There's a big difference between Git coloring a Git UI, like a diff=
, and
> > > Git coloring a separate program that already has sensible, standard=

> > > defaults.  A user who has not configured any color settings would
> > > probably not want Git to render manual pages one way, cargo to rend=
er
> > > manual pages a second way, and still other programs to render manua=
l
> > > pages in other, incompatible ways.  We need to consider not only th=
e
> > > impact that our decisions have in a vacuum, but what results simila=
r
> > > decisions from other projects would produce in the software ecosyst=
em as
> > > a whole.
> > >
> > > Would you consider various projects coloring their respective manua=
l
> > > pages differently to be a desirable state of affairs?
> > =

> > I think it's an important distinction that we're not coloring any man=
ual
> > pages, it's a question of whether we invoke "man" invoked by "git hel=
p
> > <whatever>" with the exact same paramaters/options a user would get w=
ith
> > "man git-<whatever>".
> > =

> > Right now our documentation seems to suggest that we won't do any suc=
h
> > magic, but you can also set man.viewer to e.g. invoke a web browser o=
r
> > something instead of man(1).
> > =

> > I don't think it's confusing in that context if we learn to do some "=
man
> > with fancy on top" in this mode.
> =

> I agree that we could explain it as "man with fancy on top". But it
> makes me wonder: why is this Git's responsibility to do the fancy at
> all?

It is not.

Just like it is not git's responsibility to display diffs in color.

But it's a nice thing to do.

> I.e., if you want colorized manpages, why don't you configure man to do=

> so?

Because this has nothing to do with man.

In the default mode man just takes the output of groff, and passes it to
a pager. That's it.

It doesn't know anything of colors. That's between groff and less.

> Sure, it's a bit of a pain to do so since it involves setting a
> bunch of obscure environment variables.

The environment variables are for less, not man.

If you export those variables into your environment, you could
potentially mess up the output of some programs when viewed through
less.

That's why in my tip I set the variables only for man, inside a man
function wrap: man () { FOO=3D1 command man "$@"; }

> But if that's what you want, wouldn't you want it for all manpages,
> whether you ran "git help log" or "man git-log" or "man ls"?

How? (without messing up the environment for other programs that use a
pager)

> This seems like a "man" feature and not a "git" feature.

man does not care. It can do many things, dumping data onto a pager is
just one of them.

Where does LESS_TERMCAP_* affect `man -Hchromium git`? For more read man =
man.

> And arguably some of it is really a "less" feature

It's *all* a less feature.

> (it is trying to set "standout" mode for its prompt, so configuring
> "so" and "se" termcap entries is just reinterpreting that. If you
> like, wouldn't you want it on for all "less" invocations?).

I don't.

Rendering things correctly on a terminal is tricky enough as it is, I
would like to hedge such kinds of changes inside a controlled
environment.

Which is exactly what my patch does.

-- =

Felipe Contreras=
