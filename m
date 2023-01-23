Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC809C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjAWPFU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjAWPFR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:05:17 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7F612863
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:05:14 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-4fd37a1551cso150800017b3.13
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIhJZjM88NJOw0KrrJ5Y0RC9/DfCjjrzaz1EeJREqc8=;
        b=Tn0+FidjFG+zIQZiG14MjQEHIlui9tzYMxbVWjjO0Q2R2cbNXw8RLgy5nhZ8vlfeh9
         J7gUS216rpW5uFFVr2AOQSiZzcCDF7YhqZ+GMc9VzWbES/C8juRvb2jiY5KQXKvaAk80
         7Cmzy7KmSyUE8scJPpEUaVREfNlVIOGX4bXqXaE/QJOOv3pWtC/0YNjvyIKcL9TwhuE2
         nQW29ar8IfLH/v0fSKCxugp9MoPTTjDC4tqy9MHAL0QV1XRc2okk2nuHz02MNku1v4Ir
         lup2qhLClpKRCOOoD1dGlLDlmi/Vcy/yATtCMdPb2di5K8FKJueEaOfwQvXYLNpd5rGv
         JJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IIhJZjM88NJOw0KrrJ5Y0RC9/DfCjjrzaz1EeJREqc8=;
        b=Z91V5wRkUC2WlTA/HUY1hWGPFArjPUVqKVtuiRhQwdE6rNqsC9LIZ6gok/fmSr4BVP
         /aMSMM0ESFLRuKVSrYk/0bT4Iqg4/4yOA5SKqgQYEbazpV1+saxi7S+l1W5/GAqpHLyF
         tZGPjhNnYU1wfIiIOAjV7K4JVanhbGnB68PWQDsX+LgYVZM+CTFxLDuYr889t1lEhQpx
         jYHM5KRcyD45/rm+z7Zqa/dASgh831cWy81FXtdTl+sHMa3aXMrFa22C/JG6qd7Z7Qnr
         F8JxTLtJ29CDRPmVf43gM/dUvugr9N4Ic+LjZotIK5uZc3zvp+HQ7zL5pc83wFmKIPn8
         wsXQ==
X-Gm-Message-State: AFqh2kpbgqg8o4oefrvxRUXxnj0URwGGciGsvUElNDoM/mP/BxOeh1bw
        HQ/D9MCuVzU876K+AMxGQwS2TpBaPfRx343vwgw=
X-Google-Smtp-Source: AMrXdXt34wZ+0bs5ZNw1R4gfQb5GZNr8BWz9LneHfcqZsADl1xnDbDDnuCcjEq4W7StpUlLawGiCD6TT5TAcy7bFcE4=
X-Received: by 2002:a0d:d64a:0:b0:463:338b:7198 with SMTP id
 y71-20020a0dd64a000000b00463338b7198mr3266538ywd.351.1674486313560; Mon, 23
 Jan 2023 07:05:13 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
 <CAOLTT8SCtHD1KeLdRQ9cJNVm-uAae+=ii6L6r4DYDb4Lr4miSQ@mail.gmail.com> <CABPp-BF5npQrgoqE7cECJgsNpg7OWmVQrhEd=bm-KcpjsKhkvA@mail.gmail.com>
In-Reply-To: <CABPp-BF5npQrgoqE7cECJgsNpg7OWmVQrhEd=bm-KcpjsKhkvA@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Mon, 23 Jan 2023 23:05:02 +0800
Message-ID: <CAOLTT8S3qaA7E0=qMHOKKs7F3zcNeXnscL-VrP3pVSHmxc7YZw@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 12:30=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jan 14, 2023 at 2:19 AM ZheNing Hu <adlternative@gmail.com> wrote=
:
> >
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > [...]
> > > > > +    The fact that files can move between the 'tracked' and 'untr=
acked'
> > > > > +    categories means some commands will have to treat untracked =
files
> > > > > +    differently.  But if we have to treat untracked files differ=
ently,
> > > > > +    then additional commands may also need changes:
> > > > > +
> > > > > +      * status
> > > > > +      * clean
> > > > > +
> > > >
> > > > I'm a bit worried about git status, because it's used in many shell=
s
> > > > (e.g. zsh) i
> > > > in the git prompt function. Its default behavior is restricted, oth=
erwise users
> > > > may get blocked when they use zsh to cd to that directory. I don't =
know how
> > > > to reproduce this problem (since the scenario is built on checkout =
to a local
> > > > unborn branch).
> > >
> > > Could you elaborate?  I'm not sure if you are talking about an
> > > existing problem that you are worried about being exacerbated, or a
> > > hypothetical problem that could occur with changes.  Further, your
> > > wording is so vague about the problem, that I have no idea what its
> > > nature is or whether any changes to status would even possibly have
> > > any bearing on it.  But the suggested changes to git status are
> > > simply:
> > >
> >
> > I find this special case, it will fetch some blobs when "git status".
> > First, we init a git repository, then set sparse specification to "*.js=
" with
> > no-cone mode, then use blob:none filter to fetch all commits and trees,
> > and finally checkout to the default branch.
> >
> > #!/bin/sh
> >
> > rm -rf sparse-checkout-example
> > git init sparse-checkout-example
> > git -C sparse-checkout-example remote add origin
> > git@github.com:derrickstolee/sparse-checkout-example.git
> > git -C sparse-checkout-example sparse-checkout set --no-cone *.js
> > git -C sparse-checkout-example fetch origin --filter=3Dblob:none main
> > git -C sparse-checkout-example branch --track main origin/main
> > git -C sparse-checkout-example checkout main
> >
> > Then let's do a git status, which some zsh git plugin
> > will do when user "cd" the git repository.
> >
> > # git -C sparse-checkout-exmaple status
> >
> > remote: Enumerating objects: 1, done.
> > remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
> > Receiving objects: 100% (1/1), 416 bytes | 416.00 KiB/s, done.
> > remote: Enumerating objects: 1, done.
> > remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
> > Receiving objects: 100% (1/1), 160 bytes | 160.00 KiB/s, done.
> > remote: Enumerating objects: 1, done.
> > remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
> > Receiving objects: 100% (1/1), 2.01 KiB | 2.01 MiB/s, done.
> > remote: Enumerating objects: 1, done.
> > remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
> > Receiving objects: 100% (1/1), 120 bytes | 120.00 KiB/s, done.
> > On branch main
> > Your branch is up to date with 'origin/main'.
> >
> > You are in a sparse checkout with 8% of tracked files present.
> >
> >
> > It took 17.00 seconds to enumerate untracked files. 'status -uno'
> > may speed it up, but you have to be careful not to forget to add
> > new files yourself (see 'git help status').
> > nothing to commit, working tree clean
> >
> > Yeah, here it fetches four blobs, and takes 17s!!!
> >
> > So what blobs are we fetching?
> >
> > GIT_TRACE_PACKET=3D1 git -C sparse-checkout-example status
> > ...
> > 18:02:32.989231 pkt-line.c:80           packet:        fetch> want
> > dff85a65c0ef4b50a4c01bdd4a247b974bc45f90
> > ...
> > 18:02:37.059203 pkt-line.c:80           packet:        fetch> want
> > f07ead02d13f62414589b1f1b891bb6a764ec91f
> > ...
> > 18:02:40.868899 pkt-line.c:80           packet:        fetch> want
> > 3c4efe206bd0e7230ad0ae8396a3c883c8207906
> > ...
> > 18:02:44.961809 pkt-line.c:80           packet:        fetch> want
> > 6590681af7e177dc71fe08648c4bbf4223b82866
> >
> >
> > Then let's we look what's the blob:
> > git log --find-object=3Ddff85a65c0ef4b50a4c01bdd4a247b974bc45f90 --stat
> > commit 8ec229339caad56eb849c67361a9699004564177
> > Author: Derrick Stolee <dstolee@microsoft.com>
> > Date:   Mon Dec 30 13:30:27 2019 -0500
> >
> >     Add twbs/bootstrap
> >
> >  web/browser/.gitignore | 47 ++++++++++++++++++++++++++++++++++++++++++=
+++++
> >  1 file changed, 47 insertions(+)
> >
> > git log --find-object=3Df07ead02d13f62414589b1f1b891bb6a764ec91f --stat
> > commit 9c5a31030de62355410a322923e33e90a00032f6
> > Author: Derrick Stolee <dstolee@microsoft.com>
> > Date:   Mon Dec 30 13:31:06 2019 -0500
> >
> >     Add artsy/artsy.github.io
> >
> >  web/editor/.gitignore | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > Yeah, it seems that git status fetch these .gitigore files.
> > So what's the wrong here?
>
> Nothing; this looks exactly as I'd expect.
>
> `git status` is supposed to check whether untracked files are ignored
> or not, and it needs .gitignore files to do so.  If an entire
> directory is missing, then it can avoid loading a .gitignore under
> that directory, but you set up your patterns such that no directory is
> likely to be excluded.
>

This may be a bit strange, why doesn't the cone mode have this problem?

> Maybe there are other special cases that one could attempt to handle
> (e.g. first check if there are any untracked files in a directory and
> only then check for which are ignored, but that'd probably take some
> big refactoring of some hairy dir.c code to accomplish something like
> that, and you'd have to be really careful to not regress the
> performance of non-sparse cases).  Personally, I don't think it's
> worth it.  If you really don't like it, I'd suggest choosing any one
> of the following ways to avoid it:
>

This "bug" may not be very important, because it has no application
at present,  scalar also uses cone mode by default.

>   * Include the .gitignore files in your sparse-checkout; might as
> well since you're going to get them anyway.

This can also seem like a pain in the butt because of the extra
unnecessary .gitigore downloads.

>   * Set status.showUntrackedFiles to `no` so that .gitignore files are
> irrelevant

This may also be a temporary rather than a complete solution.

>   * Use cone mode instead of non-cone mode (and yes, restructure your
> repo if needed)

No, I might think cone mode has some other disadvantages: it includes
too many files. I would prefer to get the behavior of non-cone mode.

>   * Remove the .gitignore files and commit their deletion.  Just do
> without them, somehow.

That's not a proper solution absolutely.

Anyway, thanks for the answer!
--
ZheNing Hu
