Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4F0C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 03:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0C9060C4A
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 03:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhKLDWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 22:22:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbhKLDWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 22:22:12 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D9E8C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 19:19:21 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id g28so3405911qkk.9
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 19:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5Ih7UYn20vxn0LQY8d5muEbuZhh8Agrx4MrpJoqC09M=;
        b=Yys9irF2ObJ21AGWHCdaELbPS2b8P4WLAtBSNzDU6Limd1oHTmgMm20f1N5ACaKxrP
         tb0xkNFXGaOIIBjzoIyGfUDQJtzorh6LL5kiaKJdkUKnx4wiyZ8+IHGyeoyzafxRHWNu
         Uw9ujlta+11sGswRuctG/eUNoXRJJZUulkXujw5x6hMwEDJZVKqkWlhKJhZHpWTNSBQZ
         NsM9HxFmfaDGXGI2FoZp/qftS+9+yYfH+aVzqSkhAS+AgakPd5CKCulVYhAGn46tNmC5
         u+clK79Mls1bs3vaPBw8fYc90hGJd3hDdcOu0/iFqBr2EQjb5KmhF/tBBPAQYqBoSl8X
         eliw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Ih7UYn20vxn0LQY8d5muEbuZhh8Agrx4MrpJoqC09M=;
        b=B4pST2yiOpj6lc/At3HrIZBdChu+WBWRe1RP5dG7JXnfm7SHVgoFtdKNktLG6EuKXI
         jdZRWLAQFTO0lWkWpe/EAzBFQcjDRhmtKtd9u/KYCYGfqTLr7ZWcI/wrlQqFwPbKfz/U
         rPnsCrePSs/iEqqBA9/iE40QvrIPI//fpwo9oTZDFbxcKN07rkSAAKmzSeNec2w81K47
         8cv2x9Gtwr/7ZyoNcBNKcVJgZ8Z0AW7yDaTMaIOpRHzd8Y+KEq1/v5C/ByjFt9151hRD
         R/KLp5M/q09WHrUK0b1RkipZr7Xyhwms32pIJfhlZJ6dN54gs1rbd1TZlM8TccNuWboZ
         6MvA==
X-Gm-Message-State: AOAM533tj2jF3b/FW4yUNCE3xMxN8NlOXFbpZd3ys6BZISEDuprz4tc4
        AL3FUYZXWry0FfU4el799I9BucBdZR8=
X-Google-Smtp-Source: ABdhPJw7azRWeCutw/MOdGgj2skg6o3F5mgtLsUSKlKD92+AwIVtV/sPY1cRyjXAvJhb3qgvK+7n+A==
X-Received: by 2002:a37:62c5:: with SMTP id w188mr10114935qkb.396.1636687160143;
        Thu, 11 Nov 2021 19:19:20 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id q13sm2198081qkl.7.2021.11.11.19.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Nov 2021 19:19:19 -0800 (PST)
Subject: Re: [RFC] Branches with --recurse-submodules
To:     Glen Choo <chooglen@google.com>, git@vger.kernel.org
References: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <bb9c0094-8532-c463-47a2-442b225ad52e@gmail.com>
Date:   Thu, 11 Nov 2021 22:19:18 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <kl6lv912uvjv.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

Le 2021-11-08 à 17:33, Glen Choo a écrit :
> 
> Original Submodule UX RFC/Discussion:
> https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
> 
> Contributor Summit submodules Notes:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2110211148060.56@tvgsbejvaqbjf.bet/
> 
> Submodule UX overhaul updates:
> https://lore.kernel.org/git/?q=Submodule+UX+overhaul+update
> 
> Hi all! Building on Emily’s original RFC, here is a more fleshed out
> vision of how `git {switch,checkout,branch}` will work with
> submodule-native branches.
> 
> The "Background" section reframes the justification and mental model
> behind our proposed workflow in more explicit terms (see "Submodule UX
> RFC:Overview"). The "Design" section presents the rules we are using to
> implement "Submodule UX RFC:Detailed Design", and how certain corner
> cases should be handled.
> 
> I’d appreciate any and all feedback :) In particular, readers may be
> interested in the "dirty worktree" approach behind `git switch`. If
> anything stands out as good, bad or missing, do let us know. Thanks!
> 
> == Background
> 
> The purpose of this effort is to bring the benefits of branches to
> superprojects. In Git, branches are used to name and track progress;
> submodules are used to incorporate other repos. However, because of how
> submodules are tracked by superprojects, submodules usually operate in
> detached HEAD and the benefits of branches are lost. For users
> uncomfortable with detached HEAD, this workflow seems risky and
> unintuitive. Other users may still prefer branches because they can have
> branch reflog and they can be confident that submodule work is being
> tracked by some branch and won’t be gc-ed.
> 
> The main ideas are:
> 
> * there is a single set of branch names that are used throughout the
>    repo tree
> * progress can be made on submodules and/or the superproject without
>    requiring a gitlink update on the superproject
> * the user can switch between branches like they would for a
>    non-submodule-using repo.
> 
> We do not require the branches to move in lockstep, thus this UX may be
> suboptimal for logical monorepos that are implemented as submodules.
> 
> == Design
> 
> This design uses the same branch name in the superproject and
> submodules; a user who sees the branch `topic` in the superproject and
> submodules knows that they are the same logical thing. Commands with
> --recurse-submodules maintain the invariant that branches in the
> superproject and submodules are {read,created,modified,deleted}
> together.
> 
> e.g.
> 
> * `git branch --recurse-submodules topic` should create the branch
>    `topic` in each of the repositories.

I guess for some workflow this would be the good, but for others you might
not need to create submodule branches for each new superproject branch you
create.  I think I pointed that out before; I don't necessarily think that
creating branches in all submodules should *not* be the default behaviour,
but I think that it should be configurable. I mean that if I have 'submodule.recurse'
set to true, I would not like 'git branch topic' to create a 'topic' branch
in each submodule. So I wish I'll be able to add 'branch.recurseSubmodules = false'
to my config (or something similar) to have more granularity in behaviour.

Also, I assume the new behaviour would carry over to 'git checkout -b' and
'git switch -c' ?

> * `git switch --recurse-submodules topic` should checkout the branch
>    `topic` in each of the repositories

Nit: I guess you also include 'git checkout --r topic' here also ?

> 
> In a superproject-submodule relationship there is some ambiguity in what
> ‘checkout the branch `topic`’ should mean (does the submodule use its
> topic branch, or the version recorded in the superproject’s gitlink?).
> Our approach is to preserve existing semantics where reasonable - the
> ref name refers to the superproject’s ref, just as it does without
> --recurse-submodules.
> 
> One wrinkle is that a user can act on submodules _without_ going through
> the superproject (e.g. by cd-ing into the submodule), thus the branch
> tips may not match the expected commits in the superproject or the set
> of submodules branches may not match the set of superproject branches.
> As such, submodule branch names are resolved on a best-effort basis:
> 
> * If the submodule branch commit matches the one in the superproject, we
>    can safely use the submodule branch.

That makes sense.

> * If the branch is in an unexpected state, we either:
> ** Fallback to the version that the user would expect (if it is safe to
>      do so).

What would be 'the version the user would expect' here ? checking out the 'topic' branch
in the submodule, even if it's ahead of the commit recorded in the superproject ?
(it could even be behind, if the submodule branch was manually resetted). Or falling
back to the old behaviour of checking out the commit recorded in the superproject
on a detached HEAD ? I think I would prefer that, with sufficient warning.

> ** Reject the operation (if it is not safe).
> 
> As we expand submodule branches to other commands (merge, rebase,
> reset), the notions of ‘unexpected state’ and ‘safety’ become
> increasingly nebulous and difficult to define because they depend on the
> command being run. To manage this, we will start by supporting submodule
> branching under a limited set of circumstances and try to loosen them in
> the future. We will manage the user’s expectations by warning them if
> Git detects an unexpected state.
> 
> The proposed rules for submodule branching are as follows:
> 
> === Switching _from_ a branch `topic`, i.e. `git {switch,checkout}`
> 
> Check `topic` if each submodule’s worktree is clean (except for
> gitlinks), and has one of the following checked out:
> 
> * `topic`
> * the commit id in the superproject gitlink

I'm not sure what you mean here, if we are switching away from 'topic',
why do we want to checkout 'topic' ? (assuming "out" is missing from your sentence above).

Or maybe you really mean "check" ? But then I'm not sure either what you mean...


Re-reading it, and your next email, maybe that should read:

> === Switching _away from_ a branch `topic`, i.e. `git {switch,checkout} other-branch`
> 
> Checkout `other-branch` if each submodule’s worktree is clean (except for
> gitlinks), and has one of the following checked out:
> 
> * `topic`
> * the commit id in the superproject gitlink at the tip of 'topic'

Is that what you meant ? (that would indeed make sense).

> 
> This allows the user to switch with a dirty worktree (with respect to
> the superproject). We consider this acceptable because the submodule
> commits are tracked by the submodule branch. This is helpful when a user
> needs to switch branches before they are ready to commit to the
> superproject.
> 
> === Switching _to_ a branch `topic`, i.e. `git {switch,checkout} topic`
> 
> Switch to `topic` in the superproject. Then in each submodule, switch to:
> 
> * `topic`, if it exists
> * Otherwise, the commit id in the superproject gitlink (and warn the
>    user that HEAD is detached)
> 
> If the submodule `topic` points to a different commit from the
> superproject gitlink, this will leave the superproject with a dirty
> worktree with respect to the gitlinks. This allows a user to recover
> work if they had previously switched _away from_ "topic".

OK, so you seem to answer my interrogation above about "what is the version
the user would expect ?" with "the commit at the tip of 'topic' in the submodule,
if that branch exists.".

> 
> If a dirty worktree is unacceptable, we may need an option that is
> guaranteed to check out the superproject’s `topic`.

Yes, I would think that should be configurable, maybe something like
'--recurse-submodules=branch' vs '--recurse-submodules=detached' (which
is the actual behaviour). Just thinking out loud here.

> 
> === Creating a branch `topic`, i.e. `git branch topic start-point`
> 
> Check each submodule at the superproject’s `start-point` (not the
> submodule’s `start-point`) for the following:
> 
> * The submodule is initialized (in .git/modules)

The submodule should also be active, no ? Maybe it was cloned before,
so exists in .git/modules, but was then set as inactive (submodule.<name>.active=false)...

> * `topic` is a valid branch name
> 
> If so, create `topic` in the superproject and submodules based on the
> superproject’s `start-point`. Else, do not create any `topic` branches
> and guide the user towards a possible fix:
> 
> * A --force option that will move the branch tip to the commit in the
>    superproject. This will let the user overwrite the history of `topic`.
> * An --ignore option that ignores the existing `topic` branch. If used,
>    `git switch topic` would result in a dirty worktree.
> * (If needed) An --adopt option that creates a new superproject commit
>    that points to the existing submodule `topic` branch. This will let
>    the user checkout `topic` without ending up with a dirty worktree.
> * For uninitialized submodules, prompt them to initialize it via git
>    checkout start-point && git submodule update (we are working to
>    eliminate manual initialization in the long run, so this will become
>    obsolete eventually).

I think if the submodule are not initialized, they should be left alone, without
prompting the user. Projects that use non-optional submodules already instruct
their users to clone with --recurse-submodules or run 'git submodule update --init --recursive' after the clone, so I'm not sure that sort of nagging would be necessary...


Cheers,

Philippe.  
