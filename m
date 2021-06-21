Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5491FC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:49:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372BC6124B
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 20:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbhFUUvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbhFUUvR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 16:51:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAA5C061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:49:02 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id nb6so30840277ejc.10
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=bKk7jx0F5wr9KEY4FPz9WGb+kQduPBJcV6MlYqbZDUM=;
        b=uP8ZTQ9wJpX5pfydd/lgucG1HgvnNIyls8S5NzNPU0yvXRbDfcDJudo9na7+jurEZB
         0rElIEYA/4bLDFRCwsKaK7WTlEXNxfkog9AjLiBu1BzvJJZ3ONzqOdHgG0vx8c2JFgd7
         yVbPY+JL4rHA46OzdHRfOwAtW+FnW23plPBc35fd57pqurHZ8iceGvp22AUExuRv1usM
         gisVUIGW0oiim5D72B38ZqUq1pPKoJXVGL2ot4qZ2fvrSbEsOpP0C2OZZ9l1ct+eYNfc
         OgwCYMNw5/xDBux1q/tHe+AzbOez3rxd3RBUksUlr5l5IZd4uoZVBxjg9Jw+LXFIHgCB
         O25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=bKk7jx0F5wr9KEY4FPz9WGb+kQduPBJcV6MlYqbZDUM=;
        b=alpQ/sOXRHBWwul1wtjGGGmAQEdq/qGuEep7B3eor7n01m89jomhOpVvKzYXsUWNH2
         JTxe1O7DVrrXh/CXSUqMa1SWykkMzghDvRg1FvYU3a2SEhJSqB2puzAP15TFnJkc9UH7
         8dAqfIaf5fSWQz1bSAvZHvbJKyO3A3Q7PhNzJFHPBLN77nw7hs1kGBt2RGXaA6iXMI72
         /p9bfCQHjDRbq0nhl8lJ6b/9TEP1A7ViuZfLnOJ/HxRLaVhh0dOLALCP1YUV7VI0eNee
         CTnS4eYea0zTzLJpsakMn/4eUNV2GWXuU8AGQjS8jBGWcwRkn44bPIQMttbuZM9XqQ/8
         Hw1w==
X-Gm-Message-State: AOAM531g/Q75Wo2YC00fXUNSRzde2rwD55hqx427g5YUG8YCyj4pnEiP
        pIoc2bv30VkRmUpkx2IOEfI=
X-Google-Smtp-Source: ABdhPJyZaut8TyG7tTusY/RwBXhbWOmuf4xo4bLyCTKBS14MEXv5MlVSXeakZ2PZEFbjrHJUntYncA==
X-Received: by 2002:a17:907:9719:: with SMTP id jg25mr73723ejc.82.1624308540678;
        Mon, 21 Jun 2021 13:49:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id c23sm11185660eds.57.2021.06.21.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 13:49:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     albertqcui@gmail.com, gitgitgadget@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] hooks: propose repository owner configured hooks
Date:   Mon, 21 Jun 2021 22:35:04 +0200
References: <874kghk906.fsf@evledraar.gmail.com>
 <20210621193646.1173220-1-jonathantanmy@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210621193646.1173220-1-jonathantanmy@google.com>
Message-ID: <87eecv2bb8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 21 2021, Jonathan Tan wrote:

[Most of this I've replied to in
https://lore.kernel.org/git/87k0mn2dd3.fsf@evledraar.gmail.com/; or
that's a better jump-off point to discuss, just replying to leftover
bits here]

>> It's also just un-git-y in *requiring* a remote. A .mailmap,
>> .gitattributes etc. all work with a repo you find on-disk, why does
>> config & hooks need to be different?
>
> Why is a remote required? The purpose of this proposal is for remotes to
> suggest hooks, but that doesn't mean that the existing hooks mechanism
> will no longer work.

As a general matter because Git is a distributed VCS, so we should think
about how new proposed features can integrate properly with distributed
models of development.

If we make distributed development a second-class feature set we're
responsible from e.g. guiding open source projects away from distributed
repos and patch application etc. to centralized hosting.

We are also talking about exposing users to some manner of "do you trust
this thingy?" UI from day 1.

Given the points about training users to accept insecure patterns from
others on this topic in past discussions I don't we can just say we'll
worry about the distributed aspect later, as that means e.g. someone who
interacts with N forks of a repo in GitHub being encouraged to add N
trusted remotes if they want their linting of PRs to work properly.

>> > This seems like an OK alternative to allow-listing based on remote,
>> > but are you expecting users to add a GPG key to their .gitconfig?
>> 
>> That instead of saying you trust https://github.com/git/git your primary
>> means of interaction with this feature would be saying you, as an
>> example, trust Junio's GPG key.
>
> I think this feature can be extended to trusting GPG keys later. Do you
> think that we should move to a model of trusting a key *instead of* (not
> "in addition to") a URL?
>
> [snip until summary paragraph]

I think we should trust content, GPG keys are one way of getting
there. But even a magic URL implementation can be based on trusting
advertised content with what I'd think are fairly small
changes. E.g. you'd clone a branch, it has hooks, you'd diff the
relevant thing against your trusted remote's version, it's the same it
passes.
