Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A3C433B4
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 23:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A13613B0
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 23:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhDWXvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 19:51:08 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:38860 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbhDWXvB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 19:51:01 -0400
Received: by mail-ed1-f43.google.com with SMTP id y3so22902773eds.5
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 16:50:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ODRbios5o1B+fxo5+z/kWM/ISCpuE/BTJOioZ9MvIIk=;
        b=QRoJGxIIMZbWaQ2M2ryZEddIWQnW9Yuu15GP/NtPSW9EddK0uJVLe8zBcpHgD1Dqnc
         IGCADmlBtvNZPYNOR0K24y/Dt7Z+0FkUCAZiRi0HBGvi/V9HxBWuRZalsVfc8vXu3XBE
         MlhJIwLcJULDz9ruSGPs3ZNqEdKCfa/Dz1tREerhF5Br+riECcDiQtP1CrBBg+9xWSo9
         l5tw5ZmhkNTbnIB1IoOf5fYEwt+Pg48fYQ6kJRJ2AGbCJoZ5AsanFhg81NoKS/xlbtK4
         4CnTmE8BSOXBgkI61B4D1Yfm4C2O8M3sM0dCFZvYHPesvxce5jNJfBhXTftfOLalMmf2
         AMrw==
X-Gm-Message-State: AOAM5331vwWEOGOpWVhEM0I6mDERYDx+gMCCRyBghKqizPEipepbmRcN
        Qk+/KK7Br9pA8y6LHJ2/RLEpls0GBipJuHrN1Uo=
X-Google-Smtp-Source: ABdhPJyxfawXvGFaDVeFOZaaOhtyFKFcDoB4PPy76EZQ/qnAdkH1f0wDChgmZupZs43FmXb5RylhjzCN7svW/CGLE4U=
X-Received: by 2002:aa7:c7cc:: with SMTP id o12mr7379636eds.291.1619221822073;
 Fri, 23 Apr 2021 16:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210423194230.1388945-1-lukeshu@lukeshu.com> <20210423194230.1388945-15-lukeshu@lukeshu.com>
 <CAPig+cRcBA1y0WY_k4fge1KiRcLrW7PMeOS=Ns8bMa4VMdyy2w@mail.gmail.com> <8735vgbmy6.wl-lukeshu@lukeshu.com>
In-Reply-To: <8735vgbmy6.wl-lukeshu@lukeshu.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 23 Apr 2021 19:50:11 -0400
Message-ID: <CAPig+cRutK=C6WcnFyh+AJO0G5iyAUV1Us4U_F8gtDZK1+s1cg@mail.gmail.com>
Subject: Re: [PATCH 14/30] subtree: drop support for git < 1.7
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     Git List <git@vger.kernel.org>,
        Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 7:28 PM Luke Shumaker <lukeshu@lukeshu.com> wrote:
> On Fri, 23 Apr 2021 14:31:46 -0600, Eric Sunshine wrote:
> > Is there a higher reason for this change aside from "let's do it
> > because we can"? For instance, are subsequent changes going to take
> > advantage of features only present in more recent Git versions which
> > would be painful or impossible to support with the older Git?
> >
> > The downside of this change is that, while git-subtree may live in
> > git.git, it's still just "contrib", so people might grab git-subtree
> > from a modern git.git but then end up using it with an older Git
> > installation. That's not to say that doing such a thing is guaranteed
> > to work anyhow, but we don't need to make it harder on people if there
> > isn't a good reason (hence my question about whether subsequent
> > changes will actually take advantage of newer Git features).
>
> With the goal of making the whole thing easier to hack on, this just
> seemed like an easy (if small) piece of fat to trim.
>
> I guess I should include here that my bias is: With the 'git' package
> that Parabola inherits from Arch Linux, you install 'git', you get a
> working 'git subtree'.  If you want 'git send-email' to work, you also
> need to install several other Perl packages.  Like, it might live in
> the "contrib" directory, but it's de-facto at least as much a "part
> of" Git as send-email is.
>
> So that's the mindset I started from.  It looks like the latest macOS
> supports me on that, but other distros like Fedora don't (Fedora has a
> separate 'git-subtree' package).  If I take a step back, I realize
> that mindset is flawed, but that's where I started from.
>
> I don't think any of the other work depends on this (I think the only
> commit that will conflict if we drop it is the "rename a some
> variables" commit in this patchset).  It's very possible that
> something else I do relies on newer git features (I'm not testing
> against older git), but that's not something I did intentionally.
>
> I just figured this would be a welcome piece of cleanup.  If that's
> not the case, I don't have a problem dropping it.

As a person who does not and has never used git-subtree, I don't have
a strong opinion, and any git-subtree opinion I might have wouldn't
carry any weight. I do have a bit of reflexive negative reaction to
such removals in general if there's no clear and strong benefit,
perhaps because my daily-use computers are old (perhaps ancient, as in
10-25 years old), so I am regularly stung by support being dropped by
packages I use. That's why I was asking if later patches would take
advantage of some newer Git feature.

Anyhow, I wasn't specifically asking for the patch to be dropped. As a
reviewer I rather wanted to better understand the reason for the
change beyond the somewhat hand-wavy "git-subtree now lives in-tree".
If you happen to re-roll, perhaps you can expand the commit message a
bit with something more concrete (for instance, how some packagers
include git-subtree by default) to better sell the patch to reviewers
who actually have investment in git-subtree (of which I am not one).
Considering how old Git <1.7 is, it's quite likely that no current
git-subtree users/reviewers would care about dropping support for such
old versions.
