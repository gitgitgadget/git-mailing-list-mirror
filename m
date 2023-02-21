Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C7C61DA3
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 17:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbjBURqH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 12:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjBURps (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 12:45:48 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAC927983
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:45:31 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-172334d5c8aso2689466fac.8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 09:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vtwEY60IrTbnwczxuJfYXzr+WdXPx2lj8kHF9fe2P4E=;
        b=Zr8vq85L/OL6IGKZsAWGzugjW/UuKypkXKnx7azwLVHSSjVhj5gAtPM4HBDxH4dQdX
         GzPL4wmR0Fl3mK8jzuR2TytCuDVDwPSLGex724JkiVjoXV+Pv566r4kdsJwr2Otv+Gbu
         wLbAdosXGv2YOYpB9piy9CHrehmlvjvTsVOPrf63+ulpCdWqciemeCkHzZXOsIW2ZEon
         82IkWLAFL/g9/o4d/ohLhPKXH1yvvKvqiA+aUuY0v9S1s3z0C542/tRPiHnMUyiwXGD2
         sa8XSq9E+yb3TY5Mdw7YENrL6HXA+QyOupPwmdtuM9JIFPK2F7ECObBC0kgL9IZM4Uwv
         ttiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtwEY60IrTbnwczxuJfYXzr+WdXPx2lj8kHF9fe2P4E=;
        b=oqYKPflCANlgkM2glH8KfVh/LJW1SkkR7z7m2nb2DAw4FugzP1wAxNtQ1GKvDZNsib
         mlbqnnnaWZdk/gni5Xe9bMz5M0rJZ6yTKm3S2vN41CWhBmhOjrB+4ks7YbCocHEp23pV
         4w+6ZXVB/dWW1HRLeIO+p+kBw3RF+gyVePFZ3cI7fbonU+ieFbAs0tMj63W+Z03Tktd5
         k7yOt0LH1YhnNc8SDd+2lmYk8JOEObceMinUGoDYnZdWibwi88fIG/Sp9yKGN1sqLzuQ
         MRq9NFZcHTAvXPS1CYOgA2JCRiNEg5nP1e3t6l+E8iN6sOA3xdODJCOSwz7Cl0Q8TMrG
         Rr1w==
X-Gm-Message-State: AO0yUKXSvrKWwXStcR1WZVa4wH1xVOn+zQtDQ6NxHQRTmWC4Wg2VE4zy
        65xMjSi0EgX7Y+BEhepKO8cH2qgnTrn8h8daaFw=
X-Google-Smtp-Source: AK7set/CR0WevkfvM2ebqqk7L+ymet27jQySnTY/OPQ5wJy45+L0XYAl90o0aI5I7ZnXAaFR8ZVopIWoizKNUkme4n4=
X-Received: by 2002:a05:6870:1d06:b0:16e:902e:39df with SMTP id
 pa6-20020a0568701d0600b0016e902e39dfmr1182493oab.154.1677001530265; Tue, 21
 Feb 2023 09:45:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1474.git.1675614276549.gitgitgadget@gmail.com>
 <CAMMLpeTPEoKVTbfc17w+Y9qn7jOGmQi_Ux0Y3sFW5QTgGWJ=SA@mail.gmail.com>
 <CAPMMpogFAR6cvcR8T5fx+AoytAJ7TsPpSeOjHNzW4Gmkuq7FLQ@mail.gmail.com>
 <CAMMLpeTQ1RpsvwRdZ0G3wdvH1+LXE5tw=7Cs6Q+HxMcRU0qj5Q@mail.gmail.com>
 <CABPp-BFxGYQ_JTC5c4_S_gOK3GxWKuZ=KfvycpkBjPGyKzCJ+g@mail.gmail.com>
 <CAPMMpojCYAwwu6_BE+myFaUy6fLqVSWAyiRWr_dGAmMqqUF12Q@mail.gmail.com>
 <CABPp-BEtXf9ja7Ec1fZ=BZwFDa+50zSAhtm3nN_=k+Nc2c=RXw@mail.gmail.com>
 <CAMMLpeSZs8DqrN6_F9-eg7fcbjV-O5+3V+hUsOhyd0x10xsCaQ@mail.gmail.com> <CAPMMpohfF5Cwgxt_G+Gp4rNPGTJZcQfmgEoJcFi_Kzbv2XGuog@mail.gmail.com>
In-Reply-To: <CAPMMpohfF5Cwgxt_G+Gp4rNPGTJZcQfmgEoJcFi_Kzbv2XGuog@mail.gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 21 Feb 2023 10:45:19 -0700
Message-ID: <CAMMLpeR0Z1Ay_ubHuGVz4f5RfxhhmoKsNq=OsaL5TB3WHXfJvA@mail.gmail.com>
Subject: Re: [PATCH] pull: conflict hint pull.rebase suggestion should offer
 "merges" vs "true"
To:     Tao Klerks <tao@klerks.biz>
Cc:     Elijah Newren <newren@gmail.com>,
        Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2023 at 8:40 AM Tao Klerks <tao@klerks.biz> wrote:
>
> 2. The fact that the commit history of non-expert git users (those who
> should not be using rebase, especially in teams) are so often...
> spidery... is why the "Squash" option of pull requests / merge
> requests is so popular in centralized workflows (GitHub, GitLab,
> BitBucket, etc).
>
> If your project follows a "merge down, squash up" strategy with a
> well-CI-guarded evergreen trunk on a central server, there's simply no
> reason to *require* your users to become rebasing experts - you can
> let them use simple merge-based workflows, keep your trunk clean by
> squashing away their complex commit graphs, let them merge down
> whenever they need or want to, etc.

The advantage to that workflow is that you don't have to teach users
how to rebase. (Whether the actual process of merging or rebasing is
easier, assuming that the user knows how to do both, is debatable and
likely depends a lot on the particular situation.) The disadvantage is
that even merge requests that seem like they only need one commit
often turn into multiple commits, and squashing all of those commits
together indiscriminately both makes it harder for the reviewer to
follow the progression of steps the developer took and decreases the
usefulness of tools like `git blame` and `git bisect`. For example,
the patch series that I sent to add a rebase.merges option will be 3
or 4 commits in the end, and other developers have good reasons to ask
me to keep those commits separate instead of squashing them all into a
single patch. On top of that, if your developers get the impression
that all projects on GitHub/GitLab/whatever use the same workflow,
they are likely to cause headaches when they present spidery merge
requests to other projects. If you are OK with those tradeoffs then
that's fine, Git will support you. My point is simply that every
workflow has its advantages and disadvantages, and there's no workflow
that solves every problem.

> Do we have any analysis/understanding of how common workflows like
> that of the git or linux projects are, vs github-style fork-based
> projects, vs straight-up single central server projects?

I don't have any statistics (although I would love to see them if they
exist), but I do know that all of these workflows are common enough
that `git pull` can't assume what the user wants. The warning exists
to try to prevent the user from shooting themself in the foot.

> I'm not sure what you mean by "unusual", but I don't think "avoid
> rebase unless you really know what you're doing, merge down at will,
> we will squash your contribution in the pull/merge request at the end
> anyway" is an unusual flow at all nowadays.

The unusual cases are the ones where you mix merge and rebase on your
own topic branch. Your developers did that accidentally (despite `git
pull` trying to warn them) and suffered because of it, because it
isn't well supported right now. I think we all agree that it should be
better supported, we just disagree on how to get there.

-Alex
