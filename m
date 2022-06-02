Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA0CC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 12:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234970AbiFBMZF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 08:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbiFBMZE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 08:25:04 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505969E9EB
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 05:25:03 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id n28so6036024edb.9
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 05:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8dyjZ9TcMP/G8nu4kDkK7GqpMBpyXOr+a6Qpyl5MR9U=;
        b=EAZh9AdBDIkeMnQCl2z8i+jgzQPXk8XeuGLF0jkJ8D2O5rxMcyuHmNLpBsXhKBnqVX
         RAHwOFEPzOVSUu/7iZbmRjCsHXR6ru8gKh+HzVS3Ib0fDMkpuFoFs9iyuaAuZ88T3U8y
         FGM0wK1NrsoA5Fg9+kPimzQ7DX3hDMzIljb5KPyCbqGC/pe+SOGzHwh3u8PT1RQCtL/u
         b2TCKnxKnlBj908qixBxutHGCt/wD2rrCdwgT+q6id++9d5zzYjZWiW+ItpW7P95A+hu
         qWMrDvb2lWv9JZ6t1yRmMiTtIn0rysKPAsy95xGF3Z/ld5W5tpOWhNjYuLQFy0o2DS2d
         CTWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8dyjZ9TcMP/G8nu4kDkK7GqpMBpyXOr+a6Qpyl5MR9U=;
        b=7f3U43QDTUmXT55BvezEN4QhmrmuqVWMcBXgVnDyJenmS/9i/QRo5X2KlZ4/bsUc/9
         Y4KCH79gCfaQxL5vJiJs7OzzqGq9rYbUJcarXTm+04hWNtBKw3GWGcPjln6r4357hp8W
         NuTFY9NQqxcxzHBCX9gre/ShaDqT9Snolhi53fuBsyIyvVTMegmJiZinoeWd4AClxnd1
         aAPRbjpTYCGAARnV1gWqhms8xOLNqun5nH6HL+Dqf6ETBuFyWcI0/osfa4ADt0REdMrf
         l2QoOJywuQj9RYj9CK9Nmpb0+C3KgmBJM1AXGE3hF+FZgsiH9ieZb0gjqXEwgQRqz1mZ
         vGeg==
X-Gm-Message-State: AOAM531Pq7zp+tYFBJfGT53csogYEd21UXyCWd6AHfLLmhBDoX5ryv/m
        cMO/Geq33Rl/qR0hrKmu2fj6wA7HqSId9d8hGiwGMSmdVa8=
X-Google-Smtp-Source: ABdhPJyunB0qD/GEvGHB8vDIB33zS4N/ziJ69Rvc2+yYxBQua/++28b/iwhpeRHj41avhbDYMoeKo8BZmExHlke43QA=
X-Received: by 2002:aa7:c508:0:b0:42d:cc6b:df80 with SMTP id
 o8-20020aa7c508000000b0042dcc6bdf80mr5080754edq.393.1654172701485; Thu, 02
 Jun 2022 05:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHHcNoe12h5E9OmkZy03-i7miFg2hLiT04BF3_t9C2bcmduR5Q@mail.gmail.com>
 <CAPx1GvfQLP3q-SvW38=VOxoAmQpMMau_UfXXXQiZSV3NOJCs0w@mail.gmail.com> <CAHHcNodnB8gnaLgxW-vr6PxHh_YjCOAf7CTuot-CJsonb1mdnA@mail.gmail.com>
In-Reply-To: <CAHHcNodnB8gnaLgxW-vr6PxHh_YjCOAf7CTuot-CJsonb1mdnA@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Thu, 2 Jun 2022 05:24:50 -0700
Message-ID: <CAPx1GveKYjEoAnhJLkGOo9Esd5-vhkFkbz2Uwy10j5fxR_W9Bw@mail.gmail.com>
Subject: Re: BUG? git stash and immediate git apply results in conflict
To:     Akos Vandra-Meyer <axos88@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 2, 2022 at 4:31 AM Akos Vandra-Meyer <axos88@gmail.com> wrote:
> Hi Chris,
>
> Thanks for getting back to me on this.
> My use case is the following:
>
> I made a bunch of (loosely related) changes to my code, but I have
> been asked to submit them as separate commits, so I need to separate
> the changes to dependent files relating to the first and second
> feature.

I snipped the rest of this because I *dislike* and *recommend against*
the use of `git stash` in the first place. If you want to use it that way, I am
sure it is possible, but I recommend doing something else entirely.
The rest of this message is all opinion! You seem to be looking for
a recommended method, so I'm recommending mine.

Let's say for concreteness that your current branch is named "topic".
Here is what I would do (though I might change strategies and use
various short-cuts depending on various sub-scenarios; this is meant
for illustrating how to do what you want, in a way that provides the
most clarity):

git add (files as needed)
git commit -m "final version, to be split up"
git branch -m not-final-topic

Then:

# create a new topic branch
git checkout -b new-topic <start-point>

# get a view of commits
git log HEAD..topic

# copy some commits, up until some point
git cherry-pick <some of those commits as desired>

# begin splitting a commit:
git cherry-pick -n <hash>

# split it up: use a mix of the following:
git reset / git add -p / git reset -p
                # as needed here to take part of the commit)

# observe what's to be committed
git diff --cached
git commit      # and write a commit message

git add -p ...  # as needed again
git diff --cached
git commit      # repeat until satisfied with broken up commit(s)

# make sure final result matches - optional: use the same
# hash here as for the `git cherry-pick -n` command
git diff HEAD <hash>

# repeat copying whole and partial commits:

git cherry-pick ...     # add more whole commits as desired
git cherry-pick -n ...  # add commit that is to be split up
                        # repeat the split-up process

# When finally done, ensure that new-topic and not-final-topic
# have the same contents. If they do, the split-up was successful.
git diff not-final-topic HEAD

Note that there is no longer any branch named "topic" at this
point: we have instead "not-final-topic" and "new-topic". We
can now rename "new-topic" to "topic" and use `git push -f`
or whatever else is appropriate for whatever review system(s)
you may be using.

The entire process above can often be done with a single `git
rebase -i` command, but that obscures the fundamental nature of
what you're really doing. The repeated cherry-pick, reset, add
-p, and/or reset -p sequence is what you're really doing: you are
taking some set of existing commits, which are *close* to the
commits you'd like to have, and rebuilding them to make a new set
of commits (with different hash IDs) that represent what you
really do want.

In the end, you will have Git *find* your commits by name: the
name "topic" will name the last commit in a chain of commits.
The names here are up to you, and you can change any name at
any time using `git branch -m`. Both Git and any review system
you use is going to use the *commits*, with their scary looking
hash IDs, but like you they will *find* these commits by starting
from a branch name: so by changing the hash ID stored in the
branch name, you change the set of commits they (and you) find.

What `git stash` does is make several commits that are not on
*any* branch. These commits are a little weird, requiring the
use of the `git stash` command to access them. Ordinary commits
on ordinary branches are not weird and do not need any special
access, so that's what I prefer.  But the fact that the stash commits
are on *no* branch makes it easy to slide them from one branch to
another without having to think about hash IDs; that's one reason
some people prefer `git stash`. I'm just not one of those people.

Chris
