Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F26C54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 18:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiITSxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 14:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiITSxn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 14:53:43 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ADB606B5
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 11:53:41 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id h1so4135323vsr.11
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 11:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bj8kd78XPUUF7/AfRfCbtN9R1aIX4Hky5Yx0UkU2PtY=;
        b=NUGrinAvLWFQuwzSWJoRF8PyYu+OnH56FaJ3DvX9CDPEp9bkSa62MrRe2UKCYewSbh
         Hp3+RbHI91CPffdj3vbsByv4HeBiP/gtcyxGecpqyZCJZVklAY2NrXQZ5GyBuU/DIAO5
         wjTLYadiWx2L/rGyBqpeUewYIwf5XkIvOk4SOZbLJsctl85ggIusYhxZsDepTORp1VTE
         oTh/LrYbYeDcHzIc+1Lk68HRPgfJazHgc2OTu7fkT5PdkoFQudLH1o4LuzT2ve+DXXgC
         cZu3EehHfpLpda7vyoREoIziGcfyBMTPI+9YcHGNfD6mRpJ9CBHMqWXhY0jWdka4dHDm
         AyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bj8kd78XPUUF7/AfRfCbtN9R1aIX4Hky5Yx0UkU2PtY=;
        b=PX2+K/wEt17vI89jt+VtmktJBmwfWmMjwl+NJ7wqDE3IH4G67Dtq7JeTxsZ7kLPnju
         RbR2T44DwpFK0SEKFi9ZeCZZBdugXnMEP5dm/VEckmaLgBQxcaDnuog98tm8gtuHyf7t
         FWc0WEgZ3DiHjQvSUe2Q4ULlylOv7mJuQFMnajiju2Rwoli5wFzlPDeh1GR8r4YbD9to
         B0ed9vv9tSOZ4cYBkROUoK43q5qVSmSfn03hsrsVg55MpbsI+MX5Lqg2bkH5m9jKhp/H
         zv1VWS4tkJwWxywEg5uj42pc3mktJFFwSPo5RABpfXV01hrZpZIml3Iu/C3I5iWcZR4W
         BT4A==
X-Gm-Message-State: ACrzQf2yJrLoI7Cp3cBQp6/nOTo0zkpXt5zbZlWN9jT8kO6LfwMX/6nm
        8kxScog4bUKt9Y5NaQngrbc9yR2Riu4j/285FpAqcw==
X-Google-Smtp-Source: AMsMyM6mbX3E9Nne88votNmyRO4oP+XZ2x16B26EYLddnxR2CF4DpkPvid5XgR2gEtzoA5pI1blNAW2LafCXu8QkX3Y=
X-Received: by 2002:a67:f492:0:b0:398:4c36:367a with SMTP id
 o18-20020a67f492000000b003984c36367amr9670547vsn.70.1663700020409; Tue, 20
 Sep 2022 11:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
In-Reply-To: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
From:   Emily Shaffer <emilyshaffer@google.com>
Date:   Tue, 20 Sep 2022 11:53:29 -0700
Message-ID: <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 20, 2022 at 5:42 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Hey, guys,
>
> If two users of git monorepo are working on different sub project
> /project1 and /project2 by partial-clone and sparse-checkout ,
> if user one push first, then user two want to push too, he must
> pull some blob which pushed by user one. I guess their repo size
> will gradually increase by other's project's objects, so is there any way
> to delete unnecessary blobs out of working project (sparse-checkout
> filterspec), or just git pull don't really fetch these unnecessary blobs?

This is exactly what the combination of partial clone and sparse
checkout is for!

Dev A is working on project1/, and excludes project2/ from her sparse
filter; she also cloned with `--filter=blob:none`.
Dev B is working on project2/, and excludes project1/ from his sparse
filter, and similarly  is using blob:none partial clone filter.

Assuming everybody is contributing by direct push, and not using a
code review tool or something else which handles the push for them...
Dev A finishes first, and pushes.
Dev B needs to pull, like you say - but during that pull he doesn't
need to fetch the objects in project1, because they're excluded by the
combination of his partial clone filter and his sparse checkout
pattern. The pull needs to happen because there is a new commit which
Dev B's commit needs to treat as a parent, and so Dev B's client needs
to know the ID of that commit.

>
> The large number of interruptions in git push may be another
> problem, if thousands of probjects are in one monorepo, and
> no one else has any code that would conflict with me in any way,
> but I need pull everytime? Is there a way to make improvements
> here?

The typical improvement people make here is to use some form of
automation or tooling to perform the push and merge for them. That
usually falls to the code review tool. We can call the history like
this: "S" is the source commit which both A and B branched from, and
"A" and "B" are the commits by their respective owners. Because of the
order of push, we want the final commit history to look like "S -> A
-> B". Dev A's local history looks like "S -> A" and Dev B's local
history looks like "S -> B".

If we're using the GitHub PR model, then GitHub may do merge commits
for us, and it creates those merge commits automatically at the time
someone pushes "Merge PR" (or whatever the button is called). So our
history probably looks like:
o  (merge B)
|   \
o   |  (merge A)
|\  |
| | B
| A |
| / /
S

In this case, neither A or B need to know about each other, because
the merge commit is being created by the code review tool.

With tooling like Gerrit, or other tooling that uses the rebase
strategy (rather than merge), pretty much the same thing happens -
both devs can push without knowing about their own commit because the
review tool's automation performs the rebase (that is, the "git pull"
you described) for them.

But if you're not using tooling, yeah, Dev B needs to know which
commit should come before his own commit, so he needs to fetch latest
history, even though the only changes are from Dev A who was working
somewhere else in the monorepo.

>
> Here's an example of how two users constrain each other when git push.
>
> #!/bin/sh
>
> rm -rf mono-repo
> git init mono-repo -b main
> (
>   cd mono-repo
>   mkdir project1
>   mkdir project2
>   for ((i=0;i<10;i++))
>   do
>     echo $i >> project1/file1
>     echo $i >> project2/file2
>   done
>   git add .
>   git commit -m init
> )
>
> rm -rf mono-repo.git
> git clone --bare mono-repo
>
> # user1
> rm -rf m1
> git clone --filter="blob:none" --no-checkout --no-local ./mono-repo.git m1
> (
>   cd m1
>   git sparse-checkout set project1
>   git checkout main
>   for ((i=0;i<10;i++))
>   do
>     echo "data1-$i" >> project1/file1
>     git add .
>     git commit -m "c1 $i"
>   done
> )
>
> # user2
> rm -rf m2
> git clone --filter="blob:none" --no-checkout --no-local ./mono-repo.git m2
> (
>   cd m2
>   git sparse-checkout set project2
>   git checkout main
>   for ((i=0;i<10;i++))
>   do
>     echo "data2-$i" >> project2/file2
>     git add .
>     git commit -m "c2 $i"
>   done
> )
>
> # user1 push
> (
>   cd m1
>   git push
> )
>
> # user2 push failed, then pull user1's blob
> (
>   cd m2
>   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> blob_count1
>   git push
>   git -c pull.rebase=false pull --no-edit #no conflict
>   git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
> blob_count2
>   diff blob_count1 blob_count2
> )
>
> --
> ZheNing Hu
