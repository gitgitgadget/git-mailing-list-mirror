Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE59C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 14:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243640AbiCPOsS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiCPOsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 10:48:16 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A7763BCC
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:46:58 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so1561141otl.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 07:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nCq/nxfLFhjj74YyoDQ5E7ODytQNFgToF6CoJg0PpfM=;
        b=L8f38SbjRyTc7lWVB/ECQ7dgym2Q71uHMR8zDCQwKKvI+oQB7+NcIiMIE3qrgObuKs
         SfAJMiWb18PRCkeP+kkHvQosMrXroz6wz4Qiyb7Kk/SWxjQc8avnl19sww2T/dPYfnyw
         3bYDG2esbw9X3MwvULZekVlxmGDmafhI7SGQhkVQtURh9jVaNz6RvfqHbseuxUHHfBCP
         wxdjHNzbiS7NuY4MKQhnlUGH5XMmdX+IT2C8/dDFftzmQn4KX903Kj6jk8MxG/1Tfiaw
         mJS71TySY+WCeZuEIPoghSgqOFrtgZ0Afvuly9ISWYhJXTtTsmGlJiDHb4akLGUO3vdF
         MAxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nCq/nxfLFhjj74YyoDQ5E7ODytQNFgToF6CoJg0PpfM=;
        b=EKTEVbW4L3rPohojUzCXVTHpRQGcR2qcrms6BJjAf5erHIuqGAiUgwrYBzIME5h8Rg
         0vkc2Wr4cBwNth3zwSCu1GHjPT+wny9ltbZnrDSzguUQTpeWjrSe0uO0fEIp0HPNUqdm
         7jICxmnj6LA6RrfbM6qInsQ3NIqYcFQ6uMSiW76a33V00H0Y5By3NMEe0sL9K9yun4eq
         3hTYqjyocV6997dnHJ+lX8MJbMemss4LXqjuTQmycfJ+18a1scboCCKw+skCdB7FwaUq
         HnPvc4bgNJgCg1My+q43T7hPe2VO7kpzoBJcNwsI9EfYRwj1LL5nK/6GHvLvtrzRWB6F
         bT+A==
X-Gm-Message-State: AOAM533+prYhepcNrNgCDH3YQOzyVBXdgHXbLblzUZKoTGi4rfwTnwMx
        UP+cDV/ZSd7eOxYARemttOmITFAi+Yu2BDY8Yqfug1ZDgK4=
X-Google-Smtp-Source: ABdhPJxRbPYUDaQudAS3lYTMj2UNaj+/QEFHyRc1ogcHJMGIOih7Lj4Fj0jH3xHY4mDW9salZj1E8OTjfu6Q1tQ1Xh0=
X-Received: by 2002:a9d:162:0:b0:5b2:1c30:a1e6 with SMTP id
 89-20020a9d0162000000b005b21c30a1e6mr138054otu.26.1647442017870; Wed, 16 Mar
 2022 07:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220315100145.214054-1-shaoxuan.yuan02@gmail.com>
 <20220315100145.214054-2-shaoxuan.yuan02@gmail.com> <1ab24e4b-1feb-e1bc-4ae4-c28a69f77e05@github.com>
 <CAJyCBORDOJUwTzOC+hYwGGPUBCXST0_mBdwRLh2N+cA=5k0d4A@mail.gmail.com> <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
In-Reply-To: <675c7681-c495-727d-1262-ee8c6a5c8ce5@github.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 16 Mar 2022 22:46:46 +0800
Message-ID: <CAJyCBORfAV_TV6DrOxgim4KtU9T-uTibOaQCsJZsi5_FQfci1Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] mv: integrate with sparse-index
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

On Wed, Mar 16, 2022 at 9:34 PM Derrick Stolee <derrickstolee@github.com> wrote:
> The issue here is that this file is "untracked", not just outside
> of the sparse-checkout cone.

Thanks for the succinct explanation, it makes much more sense now :)

> Instead, what about
>
>         git mv folder2/a deep/new
>
> since folder2/a is a tracked file, just not in the working tree
> since it is outside the sparse-checkout cone.
>
> (If it fails, then it should fail the same with and without the
> sparse index, which is what "test_sparse_match" is for.)

I tested this and it fails as expected with:
"fatal: bad source, source=folder2/a, destination=deep/new"

> Thanks,
> -Stolee

Thanks for the reply above!

Other than that, I also have found another issue (probably), with

$ mkdir folder2
$ git mv folder2 deep

After these I do:

$ git status

And the output indicates that the index is updated with the following changes:

        renamed:    folder2/0/0/0 -> deep/folder2/0/0/0
        renamed:    folder2/0/1 -> deep/folder2/0/1
        renamed:    folder2/a -> deep/folder2/a

Nothing fails, which is not what I expected. What I expect is `git mv` will
fail because it is being told to update a sparse-directory (which as I read the
blogs and sparse-index.txt is taken as a sparse-directory entry) outside of the
sparse-checkout cone. Unless `git mv` is supplied with `--sparse`, the command
will do nothing but fail, no?

What confuses me more is that the `folder2`, which is present in the index but
not in the working tree (due to sparse-checkout cone), seems to be "unlocked"
and re-picked up by Git after `mkdir folder2` and move `folder2` into
the cone area.
And still, the files under `deep/folder2` are not present in the
working tree (might
be relevant to the previous context).

I haven't run the gdb to see into the process, I just get somehow confused by
these discrepancies (seemingly to me). I think I should gdb into it though,
getting some info here from people can also be really helpful :)

-- 
Thanks & Regards,
Shaoxuan
