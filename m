Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BDEC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A91560F6C
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 22:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbhH0WtB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbhH0WtA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 18:49:00 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3B9C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:48:10 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id s16so3046347qvt.13
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 15:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2z3DuSJ9n0FCDO1l1uEbkDS3BHCrRaIwt563gKRzPow=;
        b=ifRxY7XNQvMbGgKRr4uCyE7t5VhrGp/5mA3dd8dRGLiJRC4jSYCMwl21FoYWrakAkS
         0A+HzLd3+qrJe8ncDHLSvDIuyCdOPQT45r+0KQ4hDJmayoS9dFm+66Jepn71TAtmi0Lm
         DCt7Hyl5mOQsFEJ8hIR88PrJWGVkLA20UNrcqWyQSkoK+DvZprN5DVjEnYYxGmEZGwB7
         JnUIcQRP9q7T5Q38Oxj/PLxdbI5DCKnfXVlfx9twh+DiAHiQzNGKnwdiR9tqFpEz6img
         Fifq0r57V8oidXYlsziulv8BWYXmKyLt+3tyvI9T/jfKK7UXUgGTu5/vEhAt2DJ7Gj1A
         AaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2z3DuSJ9n0FCDO1l1uEbkDS3BHCrRaIwt563gKRzPow=;
        b=NzyrcTTvylC6Va6n3y22ZzZyxPNrj95oWsGBQVy5tAyrk7r3FbslmO0iKvWzqgF+KT
         hRLl9GoMh3wz3Wb5F7oBX4hehkp9troKnO/7dCqw+WzU6A6ZXgiMdxlAg337dwVgod2l
         57NsQOHDvn0JpMvqok6u6Uewtuwm3jPoX/x2BZP1Of7+9+qfxWBsXgHEW6xfIns4hcrQ
         iULAI03Cv/Xe2J4yszX9O1lyY7irz52pQGzYSytZkva+1El+6/yMGIUw37hBtU/eo1m4
         eiLWvrL8VzvSL1nPpaDrZNRxeb50r5leZErKoMsbDAJO0HhCxKkuJSfzqSLZOzH216EU
         jEoQ==
X-Gm-Message-State: AOAM531vQYJVD2bTgI+jwRCKoO0JWyEN03r2HnTQQZQHkGphiHFGu0kv
        E8utOFflAL/RnafymoHDkfJZBjNckvk=
X-Google-Smtp-Source: ABdhPJyu1gRl7SHsu0Mj5Knuvx3ZEUu2ukTXFTt3C02C6Qis5aE+vRBBb0W0zJ3IB0Sd6HKxVScLEg==
X-Received: by 2002:a05:6214:240b:: with SMTP id fv11mr12148083qvb.28.1630104490096;
        Fri, 27 Aug 2021 15:48:10 -0700 (PDT)
Received: from [172.20.10.4] ([204.48.95.223])
        by smtp.gmail.com with ESMTPSA id h16sm4074610qtx.23.2021.08.27.15.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 15:48:09 -0700 (PDT)
Subject: Re: Automatically Handling Using/Checking Out Branches With One or
 More Different Contained Submodules?
To:     Bryce Glover <randomdsdevel@gmail.com>, git@vger.kernel.org
References: <CALH-JHvNHVvPWap8eiMaQ6HAJOBa4W5xuA9V_s7zPLubgwaRow@mail.gmail.com>
 <CALH-JHvKjK7KU+Z_R7kG291DQKyb3f=LwxcbP4fn-qL2eeosBQ@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>
Message-ID: <5a70d535-47b0-a4ea-b4e4-572a1bcfe997@gmail.com>
Date:   Fri, 27 Aug 2021 18:48:21 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CALH-JHvKjK7KU+Z_R7kG291DQKyb3f=LwxcbP4fn-qL2eeosBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bryce,

Le 2021-08-24 à 08:00, Bryce Glover a écrit :
> (Note:  If this question would fit better on the git-users Google
> Group, I apologize, but I saw that, unlike there — unless I overlooked
> something? —, you could send messages here even if you weren't a list
> subscriber.)
> 
> To whom it may concern,
> 
>       Currently, the only method I've seen that you can reliably use to
> switch between different branches when they don't all have the same
> contained submodules comes from the Stack Overflow answer at
> <https://stackoverflow.com/a/64690495/3319611>.  I'll reproduce the
> Bash snippet it presents as a solution here for completeness's sake:
> 
> ```
> export TARGET_BRANCH="my-branch-name"
> export CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
> if [ -f ".gitmodules" ]; then
>    git submodules deinit --all
>    mkdir -p .git/git-tools/modules
>    mv .git/modules .git/git-tools/modules/$CURRENT_BRANCH
> fi
> 
> git checkout $TARGET_BRANCH
> 
> if [ -f ".gitmodules" ]; then
>    if [ -f ".git/git-tools/modules/$TARGET_BRANCH" ]; then
>      git mv .git/git-tools/modules/$TARGET_BRANCH .git/modules
>    fi
> 
>    git submodule sync && git submodule update --init
> fi
> ```
> 
> This involves invoking some actions before '`git checkout`,' so I
> couldn't have a couple of Git hooks handle this since, per '`git help
> hooks`,' Git doesn't implement a 'pre-checkout' hook, only a
> post-checkout one.  That wouldn't be enough of a use case to motivate
> adding that, though, would it?  Alternatively, '`git checkout`'
> would, ideally, handle this automatically, perhaps when requested by
> flag if it wouldn't make sense for this behavior to be the default
> one.  I don't know if I'd personally be up to contributing either one
> or both of either of those approaches, at least not right away, but,
> hypothetically, how involved might that turn out to be?
The script above is in my opinion complicated and uneeded. I will copy below some content
from the original stackoverflow post, and reply inline. The bottom line is:

1. 'git checkout --recurse-submodules $ref' should always work in an ideal
world, but there are still some missing pieces as of today.
2. 'git checkout $ref && git submodule sync --recursive && git submodule update
--recursive' should always work.

Here goes:

> The problem I am facing is that I cannot figure out a set of git commands that
> will consistently work in all cases when switching between branches if the
> branch has submodules. In my test, I have one repo with 3 branches, one branch
> has no submodules (master), another module [sic, should be "branch"] has 1 submodule (submodule-test),
> and another branch has another submodule (submodule-test2) that points to a
> different repository (at the same path). 
[...]

> In example here is one set of commands and their failure in git 2.20.1
> 
> cd /tmp
> git clone git@github.com:simpleviewinc/git-tools-test.git ./checkout --recurse-submodules
> cd checkout
> git checkout submodule-test
> git submodule sync
> git submodule update
> # branch submodule-test fully checked out, all submodules downloaded, looking good!
> git submodule deinit --all
> git checkout submodule-test2
> git submodule sync
> git submodule update
> fatal: remote error: upload-pack: not our ref c1bba6e3969937125248ee46e308a8efec8ac654
> Fetched in submodule path 'submodule', but it did not contain c1bba6e3969937125248ee46e308a8efec8ac654. Direct fetching of that commit failed.
> It fails because it uses the wrong submodule remote, even though I thought that was the explicit purpose of submodule sync. 

The reason it fails is because the 'git submodule sync' did *not* update the
'remote.origin.url' configuration in the Git config file of the submodule, i.e.
/tmp/checkout/.git/modules/submodule/config, despite (confusingly) outputing
"Synchronizing submodule url for 'submodule'".  It does change the
'submodule.$name.url' value in the config file *of the superproject*, though,
(/tmp/checkout/.git/config) but 'git submodule update' only uses
'remote.origin.url' in the submodule's config file (if it exists).

The reason why the second 'git submodule sync' does not change
remote.origin.url is because the submodule has been deinitialized when the
command is run, because the previous command is 'git submodule deinit --all',
which deinitializes all submodules. So this second step of changing
'remote.origin.url' is skipped for deinitialized submodules (this fact is
missing from the doc).

The following sequence would be the correct one:

git clone git@github.com:simpleviewinc/git-tools-test.git ./checkout [--recurse-submodules] # --recurse-submodules is optional
cd checkout
git checkout submodule-test
git submodule update --init
git checkout submodule-test2
git submodule sync
git submodule update
# and we can switch back
git checkout submodule-test
git submodule sync
git submodule update

Note that the correct command to initialize  all submodules is 'git submodule
init' or, to initialize, clone and check them out in a single step, 'git
submodule update --init'. The fact that the first 'git submodule sync' works to
initialize the submodule is in fact due to using '--recurse-submodules' for
'git clone', which sets 'submodule.active' to the match-all pathspec '.' in the
superproject's config, and 'git submodule sync' recurses into *active*
submodules (this is also missing from the doc).

So for 'git checkout', what you want to achieve can be done with a
post-checkout hook:

```shell
#!/bin/sh

# If the checkout was a branch checkout [1], update the submodules
# to the commits recorded in the superproject
# [1] https://git-scm.com/docs/githooks#_post_checkout

previous_head=$1
new_head=$2
checkout_type_flag=$3

if [ "$checkout_type_flag" -eq 1 ] ; then
   git submodule sync --recursive
   git submodule update --init --recursive
fi
```

Here I add '--recursive' to both commands for extra safety in case any of your
submodules themselve contain submodules.

Now, about 'git checkout --recurse-submodules':

> I tried --recurse-submodules but that fails too, but this time when checking
> from a branch without submodules to a branch with submodules.
> 
> cd /tmp
> git clone git@github.com:simpleviewinc/git-tools-test.git ./checkout --recurse-submodules
> cd checkout
> git checkout submodule-test --recurse-submodules
> fatal: not a git repository: ../.git/modules/submodule
> fatal: could not reset submodule index

Yeah, that one is bad. The reason it fails is because:

1. 'git clone --recurse-submodules' in fact runs a simple 'git submodule update
--init --recursive' at the end of the process, at the step where it's checking
out the working tree. This means that only submodules present *in the branch
being checked out* get initialized and cloned.

2. 'git clone --recurse-submodules' *always* writes 'submodule.active=.' to the
superproject's config.

3. 'git checkout --recurse-submodules' recurses into active submodules, and for
that it needs access to the Git repository of the submodule, which does not
exist yet since it was not cloned.

This is the same error you get when you try to recursively checkout an older
revision that contains a submodule that was since deleted [1], [2].

I suggested in those threads a few ways all this could be improved; here is my
up to date take on the subject:

1. 'git clone --recurse-submodules' should be able to at least clone *all*
submodules for *all* branches that are cloned, and put their Git directory in
.git/modules/.  This would allow your use case to "just work" with 'git
checkout --recurse-submodules'

2. 'git clone --recurse-submodules' could also be taught to clone all
submodules for *all* revisions of *all* branches that are cloned. This would
allow the "deleted submodule" cases I mentioned to work, but would not be
wanted in all situations, so it could be a supplementary flag to 'git clone'.

3. 'git fetch' should be taught to clone new submodules.

4. 'git checkout --recurse-submodules' could be taught to clone missing
submodules and fetch missing submodules commits.  This would cover both your
use case as well as the "deleted submodule" use case.

5. In any case, 'git checkout --recurse-submodules' should not abort midway if
it can't find the Git repository of the submodule and leave '.gitmodules'
untracked in the working tree, and a 'config' file in .git/modules/$name/ with
only 'core.worktree' set.

Hope that helps,

Philippe Blain.

[1] https://lore.kernel.org/git/20200501005432.h62dnpkx7feb7rto@glandium.org/T/#u
[2] https://lore.kernel.org/git/CAE5ih78zCR0ZdHAjoxguUb3Y6KFkZcoxJjhS7rkbtZpr+d1n=g@mail.gmail.com/t/#u
