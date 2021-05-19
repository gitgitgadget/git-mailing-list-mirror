Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FBDC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C6706135F
	for <git@archiver.kernel.org>; Wed, 19 May 2021 11:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349823AbhESLUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 07:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349281AbhESLU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 07:20:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91902C061760
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:19:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so3322971pjt.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 04:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VLbTsiMqpWlt3g2mmeqArqh/rra3KHclsurkFYRl9qM=;
        b=ZG8r31h+2LqLnXwjuSj2UmlufHdLV42APUey20WgBVQs5xJ7GxGHwoTZHl50qE2iZ4
         AaIDVncsHMe5BdTlV8xtpP/nTnQXI4Eel5mEwnrUo42eCbK27D8vpPQW4jwHpK1b3xYI
         i72pX+PFWT2AIMFpx50Pjixvl9hoHRZvf7Y7m9zITmG++eQFpPwtNBFep3Qd3lH2b91u
         rBBXyeNqJqpJqYlKzTEDCJmXHP8z3TmTsrCFV1aCM/0MvGjkGyCwraAgoyhtaU0tRwWM
         svoA7ehq05mkg+ISEOD3FKO9pxpWLC5sRWSRzBzbVjnqc8Yqsj0KkjTO8gW1RGQTLeEb
         mKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VLbTsiMqpWlt3g2mmeqArqh/rra3KHclsurkFYRl9qM=;
        b=QcxmP87G6wBpzzLJPGBiI2qvAn3fCbntKUDm+rLCGZF+HNoD4rx7qnYhqhQAWJKu9g
         xbXEGccnrAUXcNS3cJGRG6po92nF1Yvb5kyi69s9hZ+MGKtfl4rG0TA1R3k9/DC0WiQH
         wPOUcr6fUQNCCcJtErepYPDI0yBUKlzjHupjrEGD6gX7sNYC+hvq/e600FVOofflJqkc
         PsVpDbTYF6aoA1HCsOXUk8G2eWRIUPM0JYX0C9Pp+Q1d4lzbsF/1qakAeg8gWmYeLkLg
         Kz3E9lqYvHbBuQFsMJ0UAz6QlnOMLMaXE7PpkzK3j63nFUrd3QE2zb+/+nmXKc6SOU88
         NxoA==
X-Gm-Message-State: AOAM5302hqRsoO9/V5tyjouFn96eoSWO5ts6HoicU4CQx1KjK0K2tYEt
        DnkdQ0ln+i1zLsTqx/vsjVNNLyd/FztgJw==
X-Google-Smtp-Source: ABdhPJzXevCVEYsjj0QHP+iavzT4mF7cI5NdsgYmPZ4SEA8/Q+FFt+tyqv3iEKBVNbW8AchCMVp0cQ==
X-Received: by 2002:a17:902:ce87:b029:ef:aff8:5d6 with SMTP id f7-20020a170902ce87b02900efaff805d6mr10416139plg.34.1621423149034;
        Wed, 19 May 2021 04:19:09 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id j189sm14469838pfd.21.2021.05.19.04.19.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 May 2021 04:19:08 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Bug in git submodule update --remote
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
Date:   Wed, 19 May 2021 16:49:05 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <876768D2-4F22-47F7-A6D4-3C0CB7FD2E6E@gmail.com>
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
To:     Ben Avison <bavison@riscosopen.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am also reposting your message, adding hard line breaks so that
it displays more readably in the list archive, and also so that
anyone else can choose to quote you from this.

On 14-May-2021, at 23:41, Ben Avison <bavison@riscosopen.org> wrote:
> 
> A recent-ish change in git 2.27.1, introduced in commit f0a96e8d, has
> also got me wondering about whether some related functionality is
> correct. I'm not sure what the best way to fix things is, so can I
> invite opinions?
> 
> The scenario: I have a repository with a submodule. The submodule's
> upstream repository uses a fork workflow, so the submodule has two
> remotes, one for pulling in other people's changes, and one for
> uploading my own pull requests.
> 
> $ mkdir myproject
> $ cd myproject
> $ git init
> $ git submodule add https://github.com/acme/library
> $ cd library
> $ git remote add -f myfork https://github.com/user/library
> $ cd ..
> $ git add .
> $ git commit -m "Initial commit"
> $ git remote add origin https://github.com/user/myproject
> $ git push -u origin master
> 
> Furthermore, assume I forked https://github.com/acme/example some time
> ago, so that the master branches between it and my fork have diverged.
> 
> Time passes. People hack away on both projects. I want to fix a bug or
> implement a new feature in the library, so I start by ensuring both are
> up-to-date:
> 
> $ git pull $ git submodule update --remote
> $ cd library
> $ git checkout -b new-feature
> $ # hack away
> $ git add .
> $ git commit -m "New feature"
> $ git push -u myfork new-feature
> $ cd ..
> 
> Some more time passes, and I want to work on it again. Again, I start by
> ensuring I'm up-to-date. Before git 2.27.1, I could do:
> 
> $ git submodule update --remote
> 
> Now, I get:
> 
> fatal: Needed a single revision Unable to find current myfork/HEAD
> revision in submodule path 'library'
> 
> What's going on is that within "git submodule update --remote", the sha1
> used is formed by looking up the submodule's ref "<remote>/<branch>".
> The change in git 2.27.1 is that if no remote tracking branch is stated
> in the superproject's .gitmodules file, <branch> defaults to "HEAD"
> rather than "master" as previously. That's fine if <remote> is "origin",
> but in practice, it depends on how the submodule is currently checked
> out:
> 
> * if it's in detached HEAD state, <remote> is set to "origin"
> * if its branch is not a tracking branch, "origin" is also used
> * but if it's a tracking branch (as I used in my workflow above - not
>   uncommon in pull request workflows because you might grant other
>   people access to the branch during the review process) then it looks
>   up the name of the remote which is being tracked
> 
> First observation: a ref called "myfork/HEAD" presumably *could* have
> been created by the "git remote add" command, reflecting that remote's
> default branch. Should it?
> 
> In practice, that's not actually what I'd want, though. If I do "git
> submodule update --remote", I personally normally do so as a shortcut
> compared to cloning everything again. I don't expect the behaviour to
> change depending on whether I happen to have left one of the submodules
> checked out on a tracking branch or not: myfork/master is potentially
> quite out of date compared to origin/master.
> 
> It also makes very little sense to me that issuing "git submodule update
> --remote" twice in quick succession would leave us in a different state,
> because the first call puts all the submodules into detached HEAD state,
> meaning that the second call always looks up the remote tracking
> branches from the submodule's "origin" remote.
> 
> One way this could be fixed is that if <branch> turns out to be "HEAD",
> we could force <remote> to be "origin". However, this doesn't address
> the equivalent problem that arises if the remote tracking branch *is*
> named in .gitmodules.
> 
> I'd therefore like to propose that "git submodule update --remote"
> *always* uses the remote named "origin" to form the ref used to check
> out the submodule. However, I'm not sure whether everyone would agree
> that this constitutes a bugfix, or whether I'd need to introduce a new
> switch to enforce this behaviour.
> 
> So, what do you think?
> 
> Ben

