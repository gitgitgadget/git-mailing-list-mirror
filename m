Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43CCEC5479D
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 02:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjAJCnx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 21:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjAJCnw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 21:43:52 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAE92718E
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 18:43:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id q2so11005242ljp.6
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 18:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rRtiURg/peYnt/8M0e62lg4cm8lihAoLnNM0wFQfBnU=;
        b=UKdy8h0VUPavR+Ku2a3u9D/v/8Rblb7+0+/UQ7/eEXOtj/Khl+59IHRUCESlZ0up4e
         /Bnayn39sR86mvyAR/5Iba3mIookvDMd5b7/99zkpp0dOTEgFTK8mZEp2OsKAIfPBDjJ
         wNB8q6DlLud0ng3sewC4STyenj508Se6V4nqccgJy1gHiTVDiebzioEY6MkBHshwSi8O
         BR2bhRp8uSQdkhQX//xHgvo5s12E5mqTlBzsZPKGCmusftgE7c4vYBwyYGbYO6VEfBgQ
         Lk30wb5OxYr6VRPFljLeaQhb+D3FEarjAUCPWsqCybaNYeCPOk8o8SIywv50UDGZVXaz
         tfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rRtiURg/peYnt/8M0e62lg4cm8lihAoLnNM0wFQfBnU=;
        b=Sa2ugRPktVV15rCsgwi4tk4AHDANREvINRsL/IDcwo4rHBq0cI1uaXyKi2BdLWFta6
         rtW+r1rNN+dBrocJm+v5a+OeJjtYJvj9wVI02FgGq7VYlxLGlzVjoa8Tjum2bWf4+lm7
         frbz7AfBEdpTUqabT03h/Do4HPLURYVwgnNRnXRyypdKHSbpUqAN0mMTf4s7moCBOiKA
         3guchP872YYC7VdImlX5AfwRlI0Imwjb2db6w+bU9xJr4So0YE1ZaZGkSmtZGpT9KX9M
         TJ9w9vZysfj8ooRh0l+poHBc641W4QkGw2CJWSOOkZuOAKoWx5H5GGj3P6+x2XufiQnR
         JMIw==
X-Gm-Message-State: AFqh2kqliWthGP9VELA5Euujn7ADExJyveoFrJRk0T80DBCczOtf5M96
        38HOl6IJMKIOw8P8D5RzAMJ9Jrxk0IkcATvTIbdDdkuSxBQ=
X-Google-Smtp-Source: AMrXdXvLUuJfJF2CwSAmjZQFLxTll1Ym0/hcYgYFhHw1TA41qGLq6FNOmSqg6W84aZPBIvfpjsdNIYESYUwE1Szisqo=
X-Received: by 2002:a05:651c:168d:b0:281:c7e8:cfd3 with SMTP id
 bd13-20020a05651c168d00b00281c7e8cfd3mr882905ljb.521.1673318628846; Mon, 09
 Jan 2023 18:43:48 -0800 (PST)
MIME-Version: 1.0
References: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB779560B6C003FEE76E4F2471F1FE9@PH7PR12MB7795.namprd12.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Jan 2023 18:42:00 -0800
Message-ID: <CABPp-BE_FLFL3-s3936zWWfaORBPim14A-oqVNo+8gx+CMduHA@mail.gmail.com>
Subject: Re: Reducing Git Repository size - git-filter-repo doesn't help
To:     fawaz ahmed0 <fawazahmed0@hotmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2023 at 6:54 PM fawaz ahmed0 <fawazahmed0@hotmail.com> wrote:
>
> Hi,
>
> I have this huge repo: https://github.com/fawazahmed0/currency-api#readme  and I am trying to reduce its size.
>
> I have run filter-repo script on this repo (  https://github.com/fawazahmed0/currency-api/blob/1/.github/workflows/cleanup-repo.yml )

Why are you cleaning up in a CI task?  filter-repo is intended for a
one-shot "flag day" type cleanup, not something you repeatedly do.
Something seems a bit off already.

> The commits were reduced from 1k to 600 , but the space used is still same. (i.e size-pack: 6.47 GiB , https://github.com/fawazahmed95/currency-api/actions/runs/3865919157/jobs/6589710845#step:5:1498 )

You show the ending size, but not the starting.  Could you provide
that number and how you got it, so we can see what you're measuring
(especially since below it's not at all clear what you're even
measuring?)

The reduction in commits suggests it certainly did do some kind of
pruning, and you might also want to look at the output of running
"python3 git-filter-repo --analyze", both before and after filtering,
to get an idea of what's is/was using lots of space.

Taking a closer look, I suspect you are missing some important
cleaning.  When there are multiple copies of a file in a repository,
git only stores one version.  Based on
https://github.com/fawazahmed0/currency-api/issues/55, all the files
that are now in directories that you are deleting used to be in the
root folder under another name.  The files with the old name aren't
going to be deleted by your pruning since you only requested that the
new names of the files be deleted.  If I'm understanding your
structure correctly (I didn't clone your repo or try this out; I'm
making inferences based on poking around at the links you provided and
looking at that issue), the upshot of that is that your filtering
probably won't shrink things much since you are still keeping a copy
of those files.  Again, "python3 git-filter-repo --analyze" both
before and after filtering will help you find these kinds of things
and/or other problems.

> Almost all commits of this repo were applied on partially cloned repository: ( https://github.com/fawazahmed0/currency-api/blob/1/.github/workflows/run.yml )
> So I guess it had never run any git maintenance task in it's life.

How exactly are you measuring the size, given that you have a partial
clone?  You don't even have the objects in order to measure, so I
don't understand how you are measuring.  I'm even suspecting you are
measuring something else entirely; could you clarify all your size
measurements and how you got them?

> I am not sure what needs to be done to reduce it's space utilization. ( https://docs.github.com/en/repositories/working-with-files/managing-large-files/about-large-files-on-github#:~:text=less%20than%205%20GB%20is%20strongly%20recommended )

Note that git-filter-repo only changes the size of the _local_ repo.
You made an additional clone within GitHub Actions, and then
filter-repo shrinks *that* clone.  Even if you had deleted all copies
of older files you don't want anymore locally (which is suspect as I
noted above), your force pushing isn't going to shrink the size of the
repo on the server (i.e. on GitHub) since there are pull requests in
your repo that GitHub won't allow you to overwrite via force-push, and
those pull requests still hold on to the old history.

You probably want to read the "DISCUSSION" section of the filter-repo
manual, and you may also want to see GitHub's documentation on
shrinking repos, up at
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository.
It appears you've skipped the whole "Fully removing the data from
GitHub" section of their documentation.
