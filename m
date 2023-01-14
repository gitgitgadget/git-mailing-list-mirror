Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC22CC3DA78
	for <git@archiver.kernel.org>; Sat, 14 Jan 2023 10:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjANKTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 05:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjANKTH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 05:19:07 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0E7A9C
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 02:19:06 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4bf16baa865so316708617b3.13
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 02:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JR+ubtX7N+Qe1s5Op+D7qfsHEYlLatrbSLuQnC7vF8=;
        b=aqlvUH6Butf3xfs0ooWyDDwHT54w0MpXPzn5XezpNChHIKEkNRzifvA2073h8s25bu
         +h/J5kFyxGpAoI4PXX4cmQTACXKZzINoFY7TV3Ur/e+Oy65ZvifDQfa002pJkIdgTgyq
         P26WnGN1IGgS8ekSRdvu0eLE50QMs9yNUr95YHPv+dQfwX6na/1rMs+frq3lNL6tMA3v
         RBlJTdHupexNmAFp3gAo6/JSL/Sps8e5WTphf3IfMItBZMAM5ygYwtFv6nFYWpcjGT9v
         kD5I+FneB89burA7VcCdkpXUnMDR/Vg0y5zVczu9Fpq1NfPx2dVQL2T9LosjHQLyLmZp
         dDHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5JR+ubtX7N+Qe1s5Op+D7qfsHEYlLatrbSLuQnC7vF8=;
        b=mvz1im2cvKF0UVHrzhaeqh7Th5a7t1r7fN+d8gojBatZ1EXRMP+msCEhozhFkfJVA0
         oibcy6yXGyaJp7+A9X/xiIsvFr5FlcMlRdZunQj767OVw54+Cyud+YK4FAHVtyfqLKVA
         wn2vNU4a26lR6wI/zq7TOPr2hB6TRxrDiB1Cr6afmR5LcK4mkd/KScBmuN3h6e63NRY0
         S7Vv7winz+LzP94saPBIGTCVU43W76/p8Ww+tBBey9lNGFg+q3LeV+Q8Et5yTLicVzu0
         cH12S9+eFbaNzJ3q7qS67LuiOBanB3bZ80Ph50AlFQBKY0BVauNDe/l/1w2bZoNAmaEx
         0EiQ==
X-Gm-Message-State: AFqh2kr/U1ymEjBNyWJdIJI2T01fW36Yv81foWC6AaiDUvY+T2z7rdud
        CHDctI2RunS1RD7cRB2CA88i/AhsqUox6BeOR10=
X-Google-Smtp-Source: AMrXdXt4JDd0n5V3NdNtQeO0BgTO73k1WM4zoL5goxhuJ6Taeoc/vDFJ+O2GKUCi8Nkrj3uS2rIal3Fl/Gt37tRDLQY=
X-Received: by 2002:a81:6c8f:0:b0:479:b6a1:d9a4 with SMTP id
 h137-20020a816c8f000000b00479b6a1d9a4mr2009680ywc.263.1673691545645; Sat, 14
 Jan 2023 02:19:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
In-Reply-To: <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 14 Jan 2023 18:18:54 +0800
Message-ID: <CAOLTT8SCtHD1KeLdRQ9cJNVm-uAae+=ii6L6r4DYDb4Lr4miSQ@mail.gmail.com>
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

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=97=
=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A

> [...]
> > > +    The fact that files can move between the 'tracked' and 'untracke=
d'
> > > +    categories means some commands will have to treat untracked file=
s
> > > +    differently.  But if we have to treat untracked files differentl=
y,
> > > +    then additional commands may also need changes:
> > > +
> > > +      * status
> > > +      * clean
> > > +
> >
> > I'm a bit worried about git status, because it's used in many shells
> > (e.g. zsh) i
> > in the git prompt function. Its default behavior is restricted, otherwi=
se users
> > may get blocked when they use zsh to cd to that directory. I don't know=
 how
> > to reproduce this problem (since the scenario is built on checkout to a=
 local
> > unborn branch).
>
> Could you elaborate?  I'm not sure if you are talking about an
> existing problem that you are worried about being exacerbated, or a
> hypothetical problem that could occur with changes.  Further, your
> wording is so vague about the problem, that I have no idea what its
> nature is or whether any changes to status would even possibly have
> any bearing on it.  But the suggested changes to git status are
> simply:
>

I find this special case, it will fetch some blobs when "git status".
First, we init a git repository, then set sparse specification to "*.js" wi=
th
no-cone mode, then use blob:none filter to fetch all commits and trees,
and finally checkout to the default branch.

#!/bin/sh

rm -rf sparse-checkout-example
git init sparse-checkout-example
git -C sparse-checkout-example remote add origin
git@github.com:derrickstolee/sparse-checkout-example.git
git -C sparse-checkout-example sparse-checkout set --no-cone *.js
git -C sparse-checkout-example fetch origin --filter=3Dblob:none main
git -C sparse-checkout-example branch --track main origin/main
git -C sparse-checkout-example checkout main

Then let's do a git status, which some zsh git plugin
will do when user "cd" the git repository.

# git -C sparse-checkout-exmaple status

remote: Enumerating objects: 1, done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
Receiving objects: 100% (1/1), 416 bytes | 416.00 KiB/s, done.
remote: Enumerating objects: 1, done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
Receiving objects: 100% (1/1), 160 bytes | 160.00 KiB/s, done.
remote: Enumerating objects: 1, done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
Receiving objects: 100% (1/1), 2.01 KiB | 2.01 MiB/s, done.
remote: Enumerating objects: 1, done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 1
Receiving objects: 100% (1/1), 120 bytes | 120.00 KiB/s, done.
On branch main
Your branch is up to date with 'origin/main'.

You are in a sparse checkout with 8% of tracked files present.


It took 17.00 seconds to enumerate untracked files. 'status -uno'
may speed it up, but you have to be careful not to forget to add
new files yourself (see 'git help status').
nothing to commit, working tree clean

Yeah, here it fetches four blobs, and takes 17s!!!

So what blobs are we fetching?

GIT_TRACE_PACKET=3D1 git -C sparse-checkout-example status
...
18:02:32.989231 pkt-line.c:80           packet:        fetch> want
dff85a65c0ef4b50a4c01bdd4a247b974bc45f90
...
18:02:37.059203 pkt-line.c:80           packet:        fetch> want
f07ead02d13f62414589b1f1b891bb6a764ec91f
...
18:02:40.868899 pkt-line.c:80           packet:        fetch> want
3c4efe206bd0e7230ad0ae8396a3c883c8207906
...
18:02:44.961809 pkt-line.c:80           packet:        fetch> want
6590681af7e177dc71fe08648c4bbf4223b82866


Then let's we look what's the blob:
git log --find-object=3Ddff85a65c0ef4b50a4c01bdd4a247b974bc45f90 --stat
commit 8ec229339caad56eb849c67361a9699004564177
Author: Derrick Stolee <dstolee@microsoft.com>
Date:   Mon Dec 30 13:30:27 2019 -0500

    Add twbs/bootstrap

 web/browser/.gitignore | 47 ++++++++++++++++++++++++++++++++++++++++++++++=
+
 1 file changed, 47 insertions(+)

git log --find-object=3Df07ead02d13f62414589b1f1b891bb6a764ec91f --stat
commit 9c5a31030de62355410a322923e33e90a00032f6
Author: Derrick Stolee <dstolee@microsoft.com>
Date:   Mon Dec 30 13:31:06 2019 -0500

    Add artsy/artsy.github.io

 web/editor/.gitignore | 13 +++++++++++++
 1 file changed, 13 insertions(+)

Yeah, it seems that git status fetch these .gitigore files.
So what's the wrong here?
