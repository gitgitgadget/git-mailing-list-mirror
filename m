Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14366ECAAD8
	for <git@archiver.kernel.org>; Wed, 21 Sep 2022 15:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiIUPW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 11:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIUPWy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 11:22:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C5D883E1
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:22:53 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id e205so5328291iof.1
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=baU5hg6xn5ilp5eIhdYfzbxkhaBFYJsaARAkc2KNdFM=;
        b=FReu26PA76rIZiARIUCjDf6O9EyyGQ7WXCi4n/zxKqd6/6/jwaYyf+dBVCGKJXXErF
         LRhvq94nO5nm+naP9acwSMU9vvq+Lw3A4qia8NLb4YBbZPwC0EzNr5iDYSuyXZrsDEWq
         LKR9frEEtorKOyNImK2pg38A1+yo3/kbt7qaBwYVNMRo/tjrMf/kvZOFShsskNQpnpFb
         /r292EioNi5LwO9ujVWa7ksEiR6u3jAaySbfcIj0QPV/daqCbMRLhxK7b6OIJohlyxyN
         yEEczohR58SdGdYhNgf71eBpmJ+ks8UE5GG0iNkjseA8NhMH3oiOUhZupS6O7cibnJ+q
         zoBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=baU5hg6xn5ilp5eIhdYfzbxkhaBFYJsaARAkc2KNdFM=;
        b=2j6RFQgSIoC2jgmFe9V498yQCWlJhqsCdMZv9dglJ4L0ivdI5nCtqr6swHyBtJwEqz
         UJAlGb8Rt3tCdVAOukXJDMQKqmlwwoAtWiskC1eMEQiPgiILNrWaz2ZYF9ljXXVTXicM
         tU/JkUaRI6u5iTtcANsla4YEXYr22H64hglPF1O2scVLo1m0hkVw9d8vyavB7Pl9ILmB
         4LajUPgoXd2mPsAOQPlDqgmhSAZIYwv4f+LGFiK2NVWW+s4SxFkyuboauZfTqHYdo/PS
         WY5yrEP3E9l+1MC7Vkyd0afvYWpsUHpouSrZoatVXxORdZJehEKJ4BVAMAc7xCKf8stn
         9DSQ==
X-Gm-Message-State: ACrzQf1mULcCnSihyeM4FfDKiwnrJQSdZU9SAggT4Fpk4gL0L5EqNclz
        to3UN6wIi5LGGSuKbE2bKzuPgYNIjWVGx/YMDns=
X-Google-Smtp-Source: AMsMyM7PLMndrMAbsIhfODBIt276ICIOTYkQq/k1tVjb3zusStW2M+5+51dNaML0blmyOQ4urPzInE1wq/XcxLo2iZ8=
X-Received: by 2002:a05:6602:368e:b0:6a3:97bd:c978 with SMTP id
 bf14-20020a056602368e00b006a397bdc978mr3038290iob.135.1663773773159; Wed, 21
 Sep 2022 08:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8SHo66kGbvWr=+LQ9UVd1NHgqGGEYK2qq6==QgRCgLZqQ@mail.gmail.com>
 <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
In-Reply-To: <CAJoAoZnm8jE9rT+rrze-zP7KZNW=oCZjcrFWqjDssW3LzxrKPg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 21 Sep 2022 23:22:41 +0800
Message-ID: <CAOLTT8TwdwfHCCv+x51++Aanf3tipMegfZiTKFbQtfh7b_EY0A@mail.gmail.com>
Subject: Re: Question relate to collaboration on git monorepo
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> =E4=BA=8E2022=E5=B9=B49=E6=9C=8821=
=E6=97=A5=E5=91=A8=E4=B8=89 02:53=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Sep 20, 2022 at 5:42 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Hey, guys,
> >
> > If two users of git monorepo are working on different sub project
> > /project1 and /project2 by partial-clone and sparse-checkout ,
> > if user one push first, then user two want to push too, he must
> > pull some blob which pushed by user one. I guess their repo size
> > will gradually increase by other's project's objects, so is there any w=
ay
> > to delete unnecessary blobs out of working project (sparse-checkout
> > filterspec), or just git pull don't really fetch these unnecessary blob=
s?
>
> This is exactly what the combination of partial clone and sparse
> checkout is for!
>
> Dev A is working on project1/, and excludes project2/ from her sparse
> filter; she also cloned with `--filter=3Dblob:none`.
> Dev B is working on project2/, and excludes project1/ from his sparse
> filter, and similarly  is using blob:none partial clone filter.
>
> Assuming everybody is contributing by direct push, and not using a
> code review tool or something else which handles the push for them...
> Dev A finishes first, and pushes.
> Dev B needs to pull, like you say - but during that pull he doesn't
> need to fetch the objects in project1, because they're excluded by the
> combination of his partial clone filter and his sparse checkout
> pattern. The pull needs to happen because there is a new commit which
> Dev B's commit needs to treat as a parent, and so Dev B's client needs
> to know the ID of that commit.
>

I don't agree here, it indeed fetches the blobs during git pull. So I
do a little
change in the previous test:

(
  cd m2
  git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
blob_count1
#  git push
#  git -c pull.rebase=3Dfalse pull --no-edit #no conflict
  git fetch origin main
  git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
blob_count2
  git merge --no-edit origin/main
  git cat-file --batch-check --batch-all-objects | grep blob | wc -l >
blob_count3
  printf "blob_count1=3D%s\n" $(cat blob_count1)
  printf "blob_count2=3D%s\n" $(cat blob_count2)
  printf "blob_count3=3D%s\n" $(cat blob_count3)
)

warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
remote: Enumerating objects: 32, done.
remote: Counting objects: 100% (32/32), done.
remote: Compressing objects: 100% (20/20), done.
remote: Total 30 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (30/30), 2.61 KiB | 2.61 MiB/s, done.
From /Users/adl/./mono-repo
 * branch            main       -> FETCH_HEAD
   a6a17f2..16a8585  main       -> origin/main
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
Merge made by the 'ort' strategy.
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
Receiving objects: 100% (1/1), 87 bytes | 87.00 KiB/s, done.
 project1/file1 | 10 ++++++++++
 1 file changed, 10 insertions(+)
warning: This repository uses promisor remotes. Some objects may not be loa=
ded.
blob_count1=3D11
blob_count2=3D11
blob_count3=3D12

The result shows that blob count doesn't change in git fetch, but in git me=
rge.
However, not all the history of this blob will be pulled down here, so
the growth
of the local repository should be slow. So I was concerned about whether th=
ere
was a way to periodically clean up these unneeded blob.

> >
> > The large number of interruptions in git push may be another
> > problem, if thousands of probjects are in one monorepo, and
> > no one else has any code that would conflict with me in any way,
> > but I need pull everytime? Is there a way to make improvements
> > here?
>
> The typical improvement people make here is to use some form of
> automation or tooling to perform the push and merge for them. That
> usually falls to the code review tool. We can call the history like
> this: "S" is the source commit which both A and B branched from, and
> "A" and "B" are the commits by their respective owners. Because of the
> order of push, we want the final commit history to look like "S -> A
> -> B". Dev A's local history looks like "S -> A" and Dev B's local
> history looks like "S -> B".
>
> If we're using the GitHub PR model, then GitHub may do merge commits
> for us, and it creates those merge commits automatically at the time
> someone pushes "Merge PR" (or whatever the button is called). So our
> history probably looks like:
> o  (merge B)
> |   \
> o   |  (merge A)
> |\  |
> | | B
> | A |
> | / /
> S
>
> In this case, neither A or B need to know about each other, because
> the merge commit is being created by the code review tool.
>
> With tooling like Gerrit, or other tooling that uses the rebase
> strategy (rather than merge), pretty much the same thing happens -
> both devs can push without knowing about their own commit because the
> review tool's automation performs the rebase (that is, the "git pull"
> you described) for them.
>

Agree. Using Github PR or Gerrit, the Merge/Rebase process occurs on
a remote server, so local repo will not do git merge, and so don't need to
fetch blobs.

> But if you're not using tooling, yeah, Dev B needs to know which
> commit should come before his own commit, so he needs to fetch latest
> history, even though the only changes are from Dev A who was working
> somewhere else in the monorepo.
>

Thanks for the answer,
ZheNing Hu
