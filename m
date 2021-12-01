Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAA6C433F5
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbhLATW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 14:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhLATW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 14:22:56 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB7FC061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 11:19:35 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s139so50591558oie.13
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=se9ZVutcCRPhbxYRd8TkHMIVxrigGY9gE6jfFh78DU8=;
        b=M1CCxHzNGjsjlaQpcodU4TvFBxg5tEYBZq7vM4HBXljPImPG359kkeUnW7oVBwt9mg
         zEi1nd2LUgqffixZIluCJf8ojpHXKkjAHt73niq+yOBN8jlYcLsQdnu2F188Gs93m1cJ
         7cX8NHHXX6yYRpaFXlcbYMm15fL7tDTcXyZDjXZBazrLwe4+/4mUMy1YWrCkK6jGiO8j
         /ZeG1EWQd36c9/f57fKzsUxAiS1XgrWyL8D7Iu3LnZfSTWJ3wMMSsy1Ga6Gk7Hc+C9VQ
         BDGUredGTYKahdTQglamGn84jWT0C3ZhN5+SL9EB+FbDZ9Gg/8L8MazzaMM84pYdAvPa
         Ym5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=se9ZVutcCRPhbxYRd8TkHMIVxrigGY9gE6jfFh78DU8=;
        b=2VWohDUZmWlRjSqJr93m9MsaMlae5pryHANUAmlgBF2apzsbXjG50hpYoJhO8YRHib
         5q6cBVzLPtHoZARujZKKkecUT8aFP+UxuTtqN3FzJ5LaHgVV53XBL0qGTh5FtO43p21A
         KlIca9IG1WJcG2H3KttiXDAkHprhPUU4dTmVPT3rDcWevpZ/MfCNlw1+pZQII3v5Mjuc
         dj7Re2Wdd0k5elHOUIUZnHF7TO59x/OIlREMzcXFIDB+v1Qq4AmQz/aYyFvS9TkPS8gU
         mRCL28joK1jtCYhyEKmGZ2f1CyCt6Zof+ilqKdQDvOUw539HKhodeqYhxA4MbbinZav5
         0pFA==
X-Gm-Message-State: AOAM531yMcH4Tl58C7HefX4mdoKYDlQ9vDEMR/Oq//2NfTCjut91cnwS
        OmqHLHRxJgR9xwS+ual1CNTvvslYO9I=
X-Google-Smtp-Source: ABdhPJyx8tnY39/lncXYoUKCtMOEk2R3MMQqfqZ3IJLfY1JhNmW/tXvy0ET6EvIGl4NyMWLM4jelYg==
X-Received: by 2002:a54:4402:: with SMTP id k2mr135345oiw.141.1638386374755;
        Wed, 01 Dec 2021 11:19:34 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:e92c:9d4:9177:23b9? ([2600:1700:e72:80a0:e92c:9d4:9177:23b9])
        by smtp.gmail.com with ESMTPSA id j187sm303341oih.5.2021.12.01.11.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 11:19:34 -0800 (PST)
Message-ID: <9c7afd37-9940-e6e7-da41-8a44840defb3@gmail.com>
Date:   Wed, 1 Dec 2021 14:19:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: 2.34 regression (and workaround): deleting untracked files both
 outside *and inside* desired sparsity cone
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BE8TJ8QGAQWsSGT7S+9Xp-XmApcC9PSw3K=RQOP0rt+PQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2021 12:16 PM, Elijah Newren wrote:
> Hi,
> 
> I've got a proposal for changing the sparse-checkout command slightly;
> but it probably doesn't make sense without the context of the bugs
> (old and new) we are facing.  Consider this an RFC, with the final
> bullet point particularly in need of comment and ideas.
> 
> == Background ==
> 
> sparse-checkouts in cone mode are documented as being obtained either
> by using the `--sparse` flag to `git clone`, ...

The `--sparse` flag doesn't initialize cone mode, unfortunately.

>     git sparse-checkout init --cone [--sparse-index]
>     git sparse-checkout set ...
> 
> The first step has traditionally deleted all the tracked files from
> the working tree, except in the toplevel directory, and the second
> restores all the tracked files that are wanted.
> 
> (Usage context:)
> My understanding is Microsoft never uses this sequence, instead using
> the --sparse flag to `git clone`.  In contrast, at Palantir the
> --sparse flag to clone is rarely used.

We use the sparse-checkout builtin. From the Scalar patch series,
you can see that we don't call "git clone" at all, but instead
"scalar clone" does a lot with "git init" and works from there by
setting config and fetching at the correct time.
 
> == The (New) Bug ==
> 
> Starting with Git 2.34, each step will delete all ignored files
> outside the sparsity paths specified to the individual command in
> question.  We are totally onboard with deleting ignored files outside
> the sparsity paths the user wants, but the first command is required
> according to the documentation and does not allow specifying any
> sparsity paths.  Since it does not allow specifying any sparsity
> paths, it treats *everything* as outside and essentially deletes all
> ignored files everywhere.  That's not workable for us.  We want a
> single command for changing to a sparse-checkout.

Ah, since 'git sparse-checkout set' would work differently if not
in cone mode, I see the problem. It's a little too much to manually
set core.sparseCheckoutCone=true before running the 'set' command,
probably.

> == The Current Workaround ==
> 
> Luckily, having these two commands separate isn't enforced, and the
> first command is basically roughly equivalent to setting a few config
> variables and then running `sparse-checkout set` with an empty set of
> paths.  So, currently, we can just do the config setting part of init
> manually, and then skip the rest of init, and then call our desired
> `set` command:
>     git config extensions.worktreeConfig true
>     git config --worktree core.sparseCheckout true
>     git config --worktree core.sparseCheckoutCone true
>     git sparse-checkout set ...

Which you have already worked out.

> Since we're using a wrapper anyway (for computing dependencies and
> determining the list of directories to include), it was relatively
> easy for us to add this workaround.
> 
> However, it is not clear that our current workaround will continue
> functioning with future versions of git, particularly if
> `sparse-checkout init` gains more options.  In fact, it already
> doesn't handle --sparse-index.

Right. It's _yet another_ config option to tweak.

> == Long term proposal ==
> 
> Make `set` do both the work of `init` and `set`.
> 
> This means:
>   * `set` gains the ability to parse both --cone and --sparse-index
> (in addition to --stdin, etc.)
>   * If the sparse-index is not initialized, `set` does the
> initialization work of `init`.
>   * Modify the `init` documentation to mark it as deprecated,
> mentioning the 2-3 bugs above as reasons why.
>   * We could effectively just turn `git sparse-checkout init ...` into
> an alias for `git sparse-checkout set ...`, since init's parameters
> would be a subset of those that `set` accepts.  However, the latter
> might interact badly with allowing a user to toggle sparse-index on
> and off in the middle of a sparse-checkout...so maybe we need
> something more?  Alternatively, we could leave `init` as-is and just
> consider it set in concrete, possibly risking it becoming
> non-functional in a future upgrade.  Hmm...

I think this is a good plan. Making 'init' the same as 'set' with
no paths makes sense to me. We would want to be careful now that
"--option" could be interpreted as a path to recommend using

  git sparse-checkout set <options> -- <path1> ... <pathN>

While you are here, I would be interested in making 'git clone
--sparse' default to cone mode. Or, should it be 'git clone
--sparse=cone' or something? Not making it default to cone mode
is a big regret of mine.

Thanks,
-Stolee

