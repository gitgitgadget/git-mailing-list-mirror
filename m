Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462E0C7EE29
	for <git@archiver.kernel.org>; Thu,  8 Jun 2023 18:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236491AbjFHSTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Jun 2023 14:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234280AbjFHSTU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2023 14:19:20 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE5E1993
        for <git@vger.kernel.org>; Thu,  8 Jun 2023 11:19:19 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-568ab5c813eso12444487b3.2
        for <git@vger.kernel.org>; Thu, 08 Jun 2023 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686248358; x=1688840358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CMPHtwIzqU+73R4V/lNVq8/Iir9ms7hSMUmJrQhfaUk=;
        b=idIjkGWbe96Zn/ZP2/mucFmaHYzVVkBBqpFzRzvvrLmAWZ7a1x1Ynbrd+fzW6JLcXx
         Nyg8X7231sOE+GlJP2lNFsMNIDINGwCP09NNmgP4w5natsmihjaBx00NdAsBNi4zjEGL
         cmwJYZv3yC0s5WWU+F4pT/CxRBxs3ZE0i1xH0oQADEHq2Gy+Xd+TBFT9LHWk4e3jn4i+
         B4/FlsQrz+BqvYNsmg/5m6QOveO+XKeOkRAGz8NjRU7BArZKXB7Y+flsnIl27XKhtA6W
         H71iBRckWMWhR6igJSnIiEWVK5URr83URfkixZ9Mwzz8JdV9V4n0EJDMe9VIiD6k0Lzm
         JvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686248358; x=1688840358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMPHtwIzqU+73R4V/lNVq8/Iir9ms7hSMUmJrQhfaUk=;
        b=RTkGcb59Jd3cmhmGGPi/kIAI/KIddx/NIRdVGDudIPDpIyZ5VdN8Q1y6S9SMr5jUum
         55xpPybuXyraen5wFA7rVNoCLCgIwEGUvjUd/henEcPeUW36VI5/o1xOYL1TUID2XSNR
         qklq83fVmP/AVuETrCu8eXai4tOjOKu4JIwMBzQjnAtFxPQ3lx2OLnQGy41YiMgnVIlq
         F7sFQSY5eKrffb1AAhoZG05csYxyZgzKmXlIaMD9D2qaJnBDy+5TlnrtFECtPrzkgZvy
         EnwqI3elvmSn0mxNRaCxBoteIV+dqVOYjHHUOzbVwHvjreNF/nCjWrJJtzvg9SuYKrXi
         JVoA==
X-Gm-Message-State: AC+VfDzRYvN7Tp6q0DUf1Ee1r5sEUE2NTkBDPv3T0kpHyJNhX1jhJ06u
        bCo88EqK3AtlHBwiK46zdB/JutkypqKwbw==
X-Google-Smtp-Source: ACHHUZ5/h0WGM8mk1/LCUGSulISJb+NbUBVBxIX02Go03NTKbIjpBNdK8B7UWJbNcjMe18X5IgeR1Xmd1cvtHA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a25:240f:0:b0:bad:600:1833 with SMTP id
 k15-20020a25240f000000b00bad06001833mr276305ybk.0.1686248358420; Thu, 08 Jun
 2023 11:19:18 -0700 (PDT)
Date:   Thu, 08 Jun 2023 11:19:16 -0700
In-Reply-To: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1539.git.1685716420.gitgitgadget@gmail.com>
Message-ID: <kl6lbkhpzujf.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 0/6] [RFC] Lazy-loaded default Git config
From:   Glen Choo <chooglen@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     vdye@github.com, johannes.schindelin@gmx.de, newren@gmail.com,
        peff@peff.net, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee!

Thanks for coming to the Libification discussion today, it was nice to
be able to discuss this idea with a bigger group.

As is custom, I'll repost my own thoughts here. If folks are interested
in a summary of the whole discussion, you can find the notes at

  https://docs.google.com/document/d/1mw_qPPgfQUv1gfKMwmvZjpYaOOzxcNH2N8bRbvBWfIQ/edit#heading=h.fcm7uhwlk55z

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  * Is this a worthwhile category of bug to protect against?

If we look past the concrete bugs and consider the general problem of
process-wide state being hard to use correctly, I think this is
definitely worth solving.

And in case anyone doubts the the current interface is hard to use
correctly: the state lives in poorly scoped global variables that need
to be manually initialized by calling git_config() at the right time
with git_default_config. It's also hard to remember to do this for your
builtin because some builtins call git_default_config in _their own_
outer config_fn_t, and others call git_config(git_default_config).

>  * Is wrapping global state in accessor methods the right way to protect
>    against that class of bugs?

Lazy-loading via accessor methods seem slightly excessive. The crux of
the problem is that we haven't initialized the values before they are
read, so I think we can get away with plain fields in a struct as long
as they are always initialized (e.g. the builtin author doesn't need to
remember to do this). We could initialize all of the fields during the
setup process, where you placed declare_config_available(), at which
point config should be available.

If we use config hash lookups to intialize the values we want,
pre-initializing like this shouldn't be noticeably more wasteful
compared to lazy-loading, since in either case, we are already parsing
all of the config into the in-memory config sets and looking them up
with hash lookups. Pre-initializing does a small bit more work upfront
by assigning to the fields, but it means that accessing the settings
later can be faster since we can avoid the "getter method" calls.

>  * Are there other benefits to doing this?

Yes! I'm generally excited about encapsulating loose global variables
into an appropriate abstraction, e.g. it was something I was thinking
about this when I was working on protected config (which is loose global
state, but also sort of a collection of repo-wide settings). It'll be
extremely relevant for libification, since this paves the way to
eventually encapsulate the process-wide state in a way that makes it
separable from the library code.

>  * Are there reasons why this cure is worse than the disease?

This seems quite similar to what we're doing with repo-settings.c (which
also has its own problems with initialization), and I'd like to avoid
having two similar-looking-but-different systems in the long run. For
this to go forward, I'd like to see either an explicit goal to deprecate
repo-settings.c (e.g. this new system handles repository settings in
addition to process-wide settings), or a reasoned separation between
them.
