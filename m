Return-Path: <SRS0=OyOp=6K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF42C55194
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 15:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 888F820700
	for <git@archiver.kernel.org>; Sun, 26 Apr 2020 15:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oo4hOioY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgDZPzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726155AbgDZPzD (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 26 Apr 2020 11:55:03 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0C6C061A0F
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 08:55:02 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id g35so3053266uad.0
        for <git@vger.kernel.org>; Sun, 26 Apr 2020 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=68px5TlJpfl01vBZFNWrDsDib4pEiUEGJ9+5Z3u5wwQ=;
        b=Oo4hOioY36RyGuBWzwB4MCGoBkS+eCRgzbb8svIg8MJIF5w8lwP4W6qebZPhixB9tk
         sDyZ9yq8eAGEkx/oMlHchic1D+sMEsiYwMdRy7Jij+Gxj43gl3T73UUl2kjrPZdzK3Rl
         gvlxcIOk3X6hekfJhkTuzK5sY8ljsBlXJ1HQxiJwPIgI9VP2tvsLyiTnsJmVL4uPg+SU
         dS5PrH7CZH4G5L9/bhDBiiGMG03p5fvtyihVUWyggvo3bycJQgb/IMIT0yIFYoblJ9Cm
         8bms0pTuwEPA2elWXILU67HoEkZFlZzv/xNlnkxyjrHpd9xoHV2QM+siJjuyWGIjjTqQ
         Y4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=68px5TlJpfl01vBZFNWrDsDib4pEiUEGJ9+5Z3u5wwQ=;
        b=lVUPQxVSXN4m9wYMzdzt/vEMQiRrUuYFO42tCSMwX9RHaUmjjRi2spEzb/rD43s26M
         E8W4iRD/3GX1dxS2NqE9l9eVQSgNA3CE7ED7f+hXw3KqKXQoVsETnK/FTNlBaxtcmklx
         1pLJ0F8BWRZAOUdlyf40d2hs6a30UiRWDx6i/MT2SEhIQqhJSbioTpq5516E7x3uYjrH
         pRATfhiL+KgC9iXlb1xzxu+z60iPlEE98O1r+7lxA0gqo5w+5XB5VWE4NSMWwtlx9DAl
         pLPZMfowvyvzBPataq6cpMVumEvdwzAx42ifhHSxtk8HDf29XZYQqJ5m9wA+lNKBwtUF
         TJXA==
X-Gm-Message-State: AGi0PubszQynyOCqcKv7lVdaus5R7lHi2XULfncR4SD9PPdXoDhoL6QY
        55BQOF2AwirSEV00jaMKe9Y0LpS899nu6dM4ijniN1qV
X-Google-Smtp-Source: APiQypJyC3JGbXW2F9U57345QNIhIbhdxU+Naa+4qkapSACAovn5e1NR5v+0u+EeZ7bdYefZah9uXqcV2EU/dgGK0vI=
X-Received: by 2002:ab0:18d:: with SMTP id 13mr13960504ual.69.1587916501568;
 Sun, 26 Apr 2020 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <pull.616.git.1587628367528.gitgitgadget@gmail.com>
 <CAPig+cSDQe7YDke=fyfdeSZOimcR5jj3FFk=Q4iOk6uiHsT-Zw@mail.gmail.com>
 <CAPig+cSkr+2dExzETScru0N5_=JhjVR=QZKuY5CbhstwrUUk5w@mail.gmail.com> <nycvar.QRO.7.76.6.2004251452200.18039@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2004251452200.18039@tvgsbejvaqbjf.bet>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sun, 26 Apr 2020 08:54:50 -0700
Message-ID: <CAPUEspiici3-tTTe=AWcNWgS4CN8OiqtaE46dQGcNW5weFC8Aw@mail.gmail.com>
Subject: Re: [PATCH] macos: do let the build find the gettext headers/libraries/msgfmt
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 25, 2020 at 5:59 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> On Thu, 23 Apr 2020, Eric Sunshine wrote:
>
> > On Thu, Apr 23, 2020 at 12:17 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > > I'm slightly leery of seeing these applied globally on Mac OS in
> > > config.mak.uname since various package managers on Mac OS install
> > > packages in wildly different locations, and these settings might cause
> > > the wrong version of a package to be picked up if a user has a
> > > preferred version installed elsewhere.
> >
> > As a follow up, although slightly leery of applying this change
> > globally to config.mak.uname, I don't necessarily oppose it either.
> > Considering how widely adopted Homebrew is on Mac OS, baking in a bit
> > of Homebrew-specific knowledge would make it easier for a Git
> > developer to get up and running by eliminating some of the manual
> > fiddling and configuration currently necessary.
>
> I share your concern. But in contrast to Fink and DarwinPorts, we have no
> Homebrew-specific knob in the Makefile (does this mean that we expect
> users to use Homebrew by default?).

IMHO the reason why there is no NO_BREW flag is because brew decided
to use the "default" directory instead of one of their own (which is
why it has so many issues with unlinked files that might or not
conflict with the system, like gettext), this is also why a NO_BREW
flag (similar to the other two introduced since 8eb38cad44 (Disable
linking with Fink or DarwinPorts., 2006-07-24)) wouldn't make sense.

my assumption is also that most people in macOS use brew nowadays
instead of fink, darwinports or any of the other alternatives, but
there is also people that use none and it is that complication why my
proposed patch was in what would seem like the wrong place to begin
with.  for more context in that last point see: 59f8674006 (Move Fink
and Ports check to after config file, 2006-12-12).

on that last point, I am afraid there is still at least a problem that
needs addressing, but will comment in patch instead for easy of
reference.

Carlo
