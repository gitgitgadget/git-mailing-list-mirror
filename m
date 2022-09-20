Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707F6ECAAD8
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 07:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiITHOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 03:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiITHOF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 03:14:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84FD5C357
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 00:14:01 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so2265777lfo.7
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 00:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=roMx+GNZUxBWlSyknIK3VF3feN3s3th8hpuKPbWq2N4=;
        b=GfSsu6mmGzfxdVWLci+BqkYOfgALwChT7G8Mo/+2LVtmldvHij5GRWf8lRR4GpXvTM
         fPphiGPptYYlh5Uy+11BZSzZ6E9wAC+qiRTF7xDpNzYdMHIUVXVie8PMttX68Cran9N6
         kaHZCdkHVsYijra7Cxpw0bRaBy1HB/0mhrICTw+hdntltmRfQ8LnDp0CyZaWMOnUdGWh
         m2X1wF70LAcUwOySB2328PKecuTCKV59kEEBqb5G3ZOutcPrCTTGfrWc+rTKgUB3RFaN
         hh7qRehUk1sKbQZUITCtyuXvrhNytGf2UaFMzkGkEg21DUTQN70MJb6biN0TgPXy0ZlR
         2Zmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=roMx+GNZUxBWlSyknIK3VF3feN3s3th8hpuKPbWq2N4=;
        b=whh0FOREqqvnEF3amqkBx9/snbCzUkY/U8iuKHba1cMVNYkL2+u8II51MMu+DTvQM9
         DQS3bP81wAkt8mScpS38MyIaIkgxEt59tgq8swYCt7hzIC7UsqU9Pj2ofHwU68r/KT7y
         vaa1Vb5CgQQPNWiUpUqImDUM2acHQpiFI8KSIUQZA69B5/I+MVOJj+uuBouYIyMUlqvF
         OT5MIcq6EUrxP19QlrdbPV6PY0jyOnaGvgBK+unvhgPcDxMgavw2WthD1Gmyu+y0SYCS
         jOnRey3nZkZQtZjBWAAAECvzu5G8j+jYPnXmcMs52h5ljVVtw9j4Kndp8LCb4/rLuAiy
         j/Zw==
X-Gm-Message-State: ACrzQf0+lckLJPlfYsNHqReDrz0R0uqpQ3cw4Morim9AAzs96NrVpb3r
        E3iCUVJOvC9tzbGR7k6U8NObpsPDbM1rVvY1BWc=
X-Google-Smtp-Source: AMsMyM5JKZEzwXud0+C3YLs7+fHqHMZTEEV8/tMncPgoAN6bUOaJnOVBr5d89gLW20C4m2wk5OGW+6zouYtPwMZEnh0=
X-Received: by 2002:a05:6512:310:b0:496:a0ca:1613 with SMTP id
 t16-20020a056512031000b00496a0ca1613mr8301197lfp.394.1663658039936; Tue, 20
 Sep 2022 00:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com> <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
 <xmqqh719pcoo.fsf@gitster.g> <CABPp-BEOVGfgmAMGCjP6Q3k-t=C1tL=f27buhiCiL-Wv0eDF_A@mail.gmail.com>
 <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
In-Reply-To: <cafcedba-96a2-cb85-d593-ef47c8c8397c@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Sep 2022 00:13:47 -0700
Message-ID: <CABPp-BH7cKUSDrt60zC8TTR3Jpxru9i25=3XJM-KYMoFSPqhQw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
To:     Victoria Dye <vdye@github.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 18, 2022 at 12:52 PM Victoria Dye <vdye@github.com> wrote:
>
> Elijah Newren wrote:
> > == Overall ==
> >
> > For existing querying commands (just ls-files), `--sparse` already
> > means restrict to the sparse cone.  If we keep using the existing flag
> > names, grep should follow suit.
> >
> > For existing modification commands already released (add, rm), the
> > fact that the command is modifying actually gives a different way to
> > interpret things such that it's not clear `--sparse` was even a
> > problem.  However, perhaps the name of the flag is bad just because
> > there are multiple ways to view it and those who view it one way will
> > see it as counter-intuitive.
> >
> > == Flag rename? ==
> >
> > There's another reason to potentially rename the flag.  We already
> > have `--sparse` and `--dense` flags for rev-list and friends.  So,
> > when we want to enable those other commands to restrict to the
> > sparsity patterns, we probably need a different name.  So, perhaps, we
> > should rename our `--sparse/--dense` to `--restrict/--no-restrict`.
> > Such a rename would also likely clear up the ambiguity about which way
> > to interpret the command for the add & rm commands (though it'd pick
> > the second one and suggest we were using the wrong name after all).
> >
> > (There are also two other commands that use `--sparse` -- pack-objects
> > and show-branch, though in a much different way and neither would ever
> > be affected by our new --sparse/--dense/--restrict/--no-restrict
> > flags.)
> >
> > Other names are also possible.  Any suggestions?
> >
> > == global flag vs subcommand flags ==
> >
> > Do we want to make --[no-]restrict a flag for each subcommand, or just
> > make it a global git flag?  I kind of think it'd make sense to do the
> > latter
> >
> > == Defaults ==
> >
> > As discussed before, we probably want querying commands (ls-files,
> > grep, log, etc.) to default to --no-restrict for now, since we are
> > otherwise slowly changing the defaults.  We may want to swap that
> > default in the future.
> >
> > However, for modification commands, I think we want the default to be
> > --restrict, regardless of the default for querying commands.  There
> > are some potentially very negative surprises for users if we don't,
> > and those surprises will be delayed rather than occur at the time the
> > user runs the command.  In fact, those negative surprises are likely
> > why those commands were the first to gain an option controlling
> > whether they operated on paths outside the sparsity specification.
> > (Also, the modification commands print a warning if they could have
> > affected other files but didn't due the the default of restricting, so
> > I think we have their default correct, even if the flag name is
> > suboptimal.)
>
> One of the things I've found myself a bit frustrated with while working on
> these sparse index integrations is that we haven't had a clear set of
> guidelines for times when we need to make UI/UX changes relating to
> 'sparse-checkout' compatibility. I think what you've outlined here is a good
> start to a larger discussion on the topic, but in the middle of this series
> might not be the best place for that discussion (at least in terms of
> preserving for later reference).

Yeah, that's fair, and I apologize for the problems.  I should have
pushed for a resolution and/or documentation of these issues at some
point; particularly since I was the one to bring it up in the first
place.  Between Stolee asking us to defer for a year-ish on UI/UX
changes in sparse-checkout while he got sparse-index into place, and
various other things coming up in the meantime, I just didn't get back
to it.  I probably should have, especially since we also had other
similar discussions going back to when git-sparse-checkout was first
introduced, but we've often focused on just solving the next subset of
usecases that were within reach rather than getting a bigger design
document.  Knowing that these kinds of issues were lurking was part of
the reason I insisted on having the big scary warning in the docs:

"""
THIS COMMAND IS EXPERIMENTAL. ITS BEHAVIOR, AND THE BEHAVIOR OF OTHER
COMMANDS IN THE PRESENCE OF SPARSE-CHECKOUTS, WILL LIKELY CHANGE IN
THE FUTURE.
"""

I'm glad I at least had the foresight to insist on that small measure...  :-)

> Elijah, would you be interested in compiling your thoughts into a document
> in 'Documentation/technical'? If not, Stolee or I could do it. If we could
> settle on some guidelines (option names, behavior, etc.) for better
> incorporating 'sparse-checkout' support into existing commands, it'd make
> future sparse index work substantially easier for everyone involved.

Sure, I'll take a stab at it this week.

> As for this series, I think the best way to move the sparse index work along
> is to drop this patch ("builtin/grep.c: add --sparse option") altogether.
> Shaoxuan's updates in patch 3 [1] make 'git grep' sparse index-compatible
> for *all* invocations (not just those without '--sparse'), so we don't need
> the new option for sparse index compatibility. It can then be re-introduced
> later (possibly modified) in a series dedicated to unifying the
> sparse-checkout UX.

Seems reasonable.

> [1] https://lore.kernel.org/git/20220908001854.206789-4-shaoxuan.yuan02@gmail.com/
