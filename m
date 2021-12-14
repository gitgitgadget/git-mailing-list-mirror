Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828F9C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 02:25:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241480AbhLNCZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 21:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhLNCZr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 21:25:47 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C4CC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 18:25:46 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g14so57382162edb.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 18:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CGkO6fGHBDgkHxsTPf727NtAQAeOnn4fby3KGJXwTXw=;
        b=Djbnz7Vvo9sFzKF3k2DhcXpSQ2zAW6JuJ7EIcKC7Zz7oxb2gGDu2Y4SBUfUiZppO00
         3oIE/VhDKDTVVSpWxXWonIYL9PwttC7+egIUX8+P6ilI4IGrYPyf9lfE7mr/gPhNfqaO
         YOK8YJAo/8gsMC1dmyyWwTqqCPnJM/mEJRZM0ts0Urd+V2Jlq+j4XViHtoCyR2oV9ueL
         KoTIEVWbDAWXRD7ZtWfV90K5qaT7hXlLnnsH/q/LVSZhLYCn73KzLTHDXzql0Q2CbM8z
         YxtT8nvbB3I1niUDhV5MwI6FUke/ZnV3dOzE+j/Rtetw6D+qg5z8iDGczOpVRYWUJROp
         UYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CGkO6fGHBDgkHxsTPf727NtAQAeOnn4fby3KGJXwTXw=;
        b=mKrOtHI12bJwqMHdyh3RzRr0sbI1wlwDEVtS1hNwOmk0F196Sp5a4edfxD6gm5urgJ
         CpWhJp2NkpMOZiWk0tTCXvccx4Q4bsqPdPChrFtKkSdBzLJplYbyq4ZXiIlsllk/wghF
         8LT0eYQDD83ZEcf0kR7QpIRdtUXV18Gk9K17iMCWnv682CyAPeT1SUKR9RXo486A6oVu
         PPESMoJwtNw6XADMKLX9irk6blIXWjpeGZLrjrx7nIzCVOgaSpIIhS0Z8tB2Lj/+V8rl
         oIQ/oBEWGFAiCJrh7+jORe8nz029ru7RBfoiUXhJNCHZvSG6hFZq3VO00JdE6JzTbopt
         5sNQ==
X-Gm-Message-State: AOAM531kVgLlSdmCNBD7Tb7Q5ggQ42usf3k5vgZNfjrjeznPLxewmGHa
        1v69VYnTJXMNl5/dqNcdGn0lfVjFRENTnXxAbhc=
X-Google-Smtp-Source: ABdhPJyMBS8rNrv6lqqu+SWRtYMqLqdPL6aKKrPBpNhQX2ZErXvZj5405ntag9GfqTx1JXrjepRrB0+nef33VfoxWRc=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr3658604edb.175.1639448745223;
 Mon, 13 Dec 2021 18:25:45 -0800 (PST)
MIME-Version: 1.0
References: <pull.1151.v2.git.git.1638908410.gitgitgadget@gmail.com>
 <pull.1151.v3.git.git.1639108573.gitgitgadget@gmail.com> <f3af5edb25d5bed46996a1b826ae0c8306eeb912.1639108573.git.gitgitgadget@gmail.com>
 <xmqq7dc8e5n8.fsf@gitster.g>
In-Reply-To: <xmqq7dc8e5n8.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 13 Dec 2021 18:25:33 -0800
Message-ID: <CABPp-BF=bv+KoGkL_5N0Tc7cET5Dwvteg3_gOwOmB5==8P5yug@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] sparse-checkout: add sanity-checks on initial
 sparsity state
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 10:11 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Most sparse-checkout subcommands (list, add, reapply, disable)
> > only make sense when already in a sparse state.  Add a quick check
> > that will error out early if this is not the case.
> >
> > Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
> > Reviewed-by: Victoria Dye <vdye@github.com>
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/sparse-checkout.c          | 12 ++++++++++++
> >  t/t1091-sparse-checkout-builtin.sh | 10 +++++++++-
> >  2 files changed, 21 insertions(+), 1 deletion(-)
>
> I won't complain too much but some looks a bit questionable to die
> on.  For example, when asked to "please disable" something that is
> already disabled, I do not think the user's intention includes "if
> already disabled, please die"; rather it is "I want the end result
> to be in the disabled state", isn't it?

Yeah, fair enough, I can change it to just print that it's already disabled.

However, I think add, list, and reapply should all die still.

> I think what is common among the ones that I find questionable to
> die is that they do not use end-user input from argv.  "Please add X
> to sparsity patterns" may not make much sense when we are not already
> sparse", unlike "Please disable", for example.
>
>     Side note. I suspect that it can be argued that we might just
>     auto-enable sparse state upon the first request to add
>     something, but I personally feel that is dwimming too much, as
>     behaviours of git in normal mode and sparse mode are so
>     different.
>
> So, for the same reason, I think "list" that shows "there is
> nothing" without an error, when sparse-checkout is not active, would
> also be perfectly defensible, and some people may find that dying a
> bit too much in such a situation.
>
> Or does the system work differently between
>
>  (A) core_apply_sparse_checkout is true and the sparsity pattern list is
>      empty, and

You can get empty output from
   git sparse-checkout list

after running
   git sparse-checkout --cone

(cone mode, no paths specified)

In this state, only files immediately in the toplevel directory will
be present; all subdirectories will be sparsified away.

(Granted, that's because cone mode by default gives you some pattern
lists behind the scenes.  If you actually delete all entries in
.git/info/sparse-checkout and do a git sparse-checkout reapply, then
you will have NO (tracked) files in your checkout; everything will be
SKIP_WORKTREE.)

>  (B) sparse-checkout is not in effect at all.

In this state, the tree is dense; all files are present.

> If that is the case, please ignore all of the above.

I think your comment about disable makes sense, though.
