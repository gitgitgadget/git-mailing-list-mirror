Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3974ECAAD3
	for <git@archiver.kernel.org>; Sun,  4 Sep 2022 07:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbiIDH23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Sep 2022 03:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbiIDH2B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2022 03:28:01 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C7C47BB8
        for <git@vger.kernel.org>; Sun,  4 Sep 2022 00:27:59 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id e195so4869943iof.1
        for <git@vger.kernel.org>; Sun, 04 Sep 2022 00:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=EE1CjC/ou0iBlH61EHhj/4Ct2o6tJ8W+noAALE+uZXw=;
        b=UaMBlG1Gmc8HtqFfgNqsDYvtgyu9q8XqPpmc6YM8LDV4t197YHbFZxHGkoa0DndigB
         6Z3bXIZh3zb8HYQD0nDmzVfUg+Mr4oiPugvv/QZnPqVu1tOJvqjyW18f2dJIPgXciGp8
         jmHzLzxcnlNX3NY3NbLQNT5+c84RhFvJ1F13aTThztynpCvyBEQA9aqmSUuTTXv1VyUm
         GgVB87t1wKQkQUHqIEjWF5MSKOsY4mpOZAPRqUQY/NubMaB5/GIyKgmUchasmypb4B2G
         7tNifudExHDktrrU08U1bez1SnJ4UZOPE1qgQafitu9XvrZcDvzoxCGe6YKBamaJylJF
         mkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=EE1CjC/ou0iBlH61EHhj/4Ct2o6tJ8W+noAALE+uZXw=;
        b=1YimawgjTgfXYjhJOuWewDp1ATz2zaO3tqekWFd0OTb+j0geIp7Am/bXoPTFpWgcOn
         +L2BCJzl+kfV1z8BV/sJa38U7SYflkQ5jk7quKn3GGhtakr6ttIWEQveAXJvYBBQ2FWR
         bjQASkgt+Nrtjfr02q/PntmIrDOsqF5KUdIdvYw8ynMRV78qlzSz8g5br8A0bNpf8bxB
         Hcdj8WBxw5TDs9znV41KpcLJL9fuGfIyuANG52wegrHgTd7muhX1CriV/o7/XFueg5hj
         zCNqcrvK79nqSW84ebT10Zb7M9vcFnReItLv38HvFo3i9okh3ZMjuAe9gK2y1MInwIpB
         R+kw==
X-Gm-Message-State: ACgBeo3cvWj9CuTYcHEXggpqVwhh61vRAnZgTyexHukBjukFL4dd6oSy
        KcfXx7eOJvWEDPJwu5GQ9FDTD3XheqNYvGx/7ZU=
X-Google-Smtp-Source: AA6agR4GB+MdL54hHjvpblWZSenuCMPTON6cj2cqaK2QSJh505tbESj6MwJB7gJg8ki4SPpYPyS4RmILrtyVN3L6bFU=
X-Received: by 2002:a05:6638:1396:b0:350:1059:29bb with SMTP id
 w22-20020a056638139600b00350105929bbmr3955531jad.67.1662276478786; Sun, 04
 Sep 2022 00:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1343.git.1662025272.gitgitgadget@gmail.com> <a14028be-2fd2-258d-94f5-c010669de8a6@github.com>
In-Reply-To: <a14028be-2fd2-258d-94f5-c010669de8a6@github.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Sep 2022 15:27:47 +0800
Message-ID: <CAOLTT8T5gxC9F2KS--c8L3=-zzET=eRj_jNZxKeKGcoNZipzWw@mail.gmail.com>
Subject: Re: [PATCH 0/3] list-object-filter: introduce depth filter
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=882=
=E6=97=A5=E5=91=A8=E4=BA=94 03:24=E5=86=99=E9=81=93=EF=BC=9A
>
> On 9/1/2022 5:41 AM, ZheNing Hu via GitGitGadget wrote:
> > This patch let partial clone have the similar capabilities of the shall=
ow
> > clone git clone --depth=3D<depth>.
> ...
> > Now we can use git clone --filter=3D"depth=3D<depth>" to omit all commi=
ts whose
> > depth is >=3D <depth>. By this way, we can have the advantages of both =
shallow
> > clone and partial clone: Limiting the depth of commits, get other objec=
ts on
> > demand.
>
> I have several concerns about this proposal.
>
> The first is that "depth=3DX" doesn't mean anything after the first
> clone. What will happen when we fetch the remaining objects?
>

According to the current results, yes, it still downloads a large number
of commits.

Do a litte test again:

$ git clone --filter=3Ddepth:2 git.git git
Cloning into 'git'...
remote: Enumerating objects: 4311, done.
remote: Counting objects: 100% (4311/4311), done.
remote: Compressing objects: 100% (3788/3788), done.

Just see how many objects...
$ git cat-file --batch-check --batch-all-objects | grep blob | wc -l
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
    4098
$ git cat-file --batch-check --batch-all-objects | grep tree | wc -l
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
     211
$ git cat-file --batch-check --batch-all-objects | grep commit | wc -l
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
       2

$ git checkout HEAD~

Fetch nothing...because depth=3D2.

$  git checkout HEAD~
remote: Enumerating objects: 198514, done.
remote: Counting objects: 100% (198514/198514), done.
remote: Compressing objects: 100% (68511/68511), done.
remote: Total 198514 (delta 128408), reused 198509 (delta 128406), pack-reu=
sed 0
Receiving objects: 100% (198514/198514), 77.07 MiB | 9.58 MiB/s, done.
Resolving deltas: 100% (128408/128408), done.
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (1/1), 14.35 KiB | 14.35 MiB/s, done.
remote: Enumerating objects: 198014, done.
remote: Counting objects: 100% (198014/198014), done.
remote: Compressing objects: 100% (68362/68362), done.
remote: Total 198014 (delta 128056), reused 198012 (delta 128055), pack-reu=
sed 0
Receiving objects: 100% (198014/198014), 76.55 MiB | 14.00 MiB/s, done.
Resolving deltas: 100% (128056/128056), done.
Previous HEAD position was 624a936234 Merge branch 'en/merge-multi-strategi=
es'
HEAD is now at 014a9ea207 Merge branch 'en/t4301-more-merge-tree-tests'

Fetch a lot of objects... (three times!)

$ git cat-file --batch-check --batch-all-objects | grep blob | wc -l
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
    4099
$ git cat-file --batch-check --batch-all-objects | grep tree | wc -l
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
    130712
$ git cat-file --batch-check --batch-all-objects | grep commit | wc -l
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
    67815

It fetched too many Commits and Trees... But Surprisingly, only one
more blob was downloaded.

I admit that this is a very bad action, That's because we
have no commits locally...

Maybe one solution: we can also provide a commit-id parameter
inside the depth filter, like --filter=3D"commit:014a9ea207, depth:1"...
we can clone with blob:none filter to download all trees/commits,
then fetch blobs with this "commit-depth" filter.... even we can
provide a more complex filter: --filter=3D"commit:014a9ea207, depth:1, type=
=3Dblob"
This may avoid downloading too many unneeded commits and trees...

git fetch --filter=3D"commit:014a9ea207, depth:1, type=3Dblob"

If git fetch have learned this filter, then git checkout or other commands =
can
 use this filter internally heuristically:

e.g.

git checkout HEAD~
if HEAD~ missing | 75% blobs/trees in HEAD~ missing -> use "commit-depth" f=
ilter
else -> use blob:none filter

We can even make this commit-depth filter support multiple commits later.

> Partial clone is designed to download a subset of objects, but make
> the remaining reachable objects downloadable on demand. By dropping
> reachable commits, the normal partial clone mechanism would result
> in a 'git rev-list' call asking for a missing commit. Would this
> inherit the "depth=3DX" but result in a huge amount of over-downloading
> the trees and blobs in that commit range? Would it result in downloading
> commits one-by-one, and then their root trees (and all reachable objects
> from those root trees)?
>

I don't know if it's possible let git rev-list know that commits is missing=
, and
stop download them. (just like git cat-file --batch --batch-all-objects doe=
s)

Similarly, you can let git log or other commands to understand this...

Probably a config var: fetch.skipmissingcommits...

> Finally, computing the set of objects to send is just as expensive as
> if we had a shallow clone (we can't use bitmaps). However, we get the
> additional problem where fetches do not have a shallow boundary, so
> the server will send deltas based on objects that are not necessarily
> present locally, triggering extra requests to resolve those deltas.
>

Agree, I think this maybe a problem, but there is no good solution for it.

> This fallout remains undocumented and unexplored in this series, but I
> doubt the investigation would result in positive outcomes.
>
> > Disadvantages of git clone --depth=3D<depth> --filter=3Dblob:none: we m=
ust call
> > git fetch --unshallow to lift the shallow clone restriction, it will
> > download all history of current commit.
>
> How does your proposal fix this? Instead of unshallowing, users will
> stumble across these objects and trigger huge downloads by accident.
>

As mentioned above, I would expect a commit-depth filter to fix this.

> > Disadvantages of git clone --filter=3Dblob:none with git sparse-checkou=
t: The
> > git client needs to send a lot of missing objects' id to the server, th=
is
> > can be very wasteful of network traffic.
>
> Asking for a list of blobs (especially limited to a sparse-checkout) is
> much more efficient than what will happen when a user tries to do almost
> anything in a repository formed the way you did here.
>

Yes. also as mentioned above, enabling this filter in some specific cases:
e.g. we have the commit but not all trees/blobs in it.

> Thinking about this idea, I don't think it is viable. I would need to
> see a lot of work done to test these scenarios closely to believe that
> this type of partial clone is a desirable working state.
>

Agree.

> Thanks,
> -Stolee

Thanks to these reviews and criticisms, it makes me think more :)

ZheNing Hu
