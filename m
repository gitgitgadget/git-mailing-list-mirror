Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89934C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 11:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238115AbiEKLVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 07:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiEKLV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 07:21:29 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CACF749E
        for <git@vger.kernel.org>; Wed, 11 May 2022 04:21:25 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id l15so1208014ilh.3
        for <git@vger.kernel.org>; Wed, 11 May 2022 04:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aMRYiesUkuhUcWHm7mXM0NxFY94g3BEKOZEWtuemyI8=;
        b=jjx7PwZ98nmmjGGAlrjah+HPY4jLxIODEQe9gvAf/FTUyVRFNa2i7IXMn5ofXIGJs/
         qzMTes5RY68gBm8FV8SXCtPQZ2Tgor4vDJu2razfl3uhC6alk2Ld0h9BHiIhSz1zKrrs
         UKycEQNt6Lkeq6m6uiFxJGagsWMxyZHh2teg+v7N8fyA5324AkI+tpMys4eRvPIT9KCL
         GvKPr9LvkK2uSU2MC9bCKrd7ncEchIALNorW3oi3muuwLF0+jabtWVy/qzxhSKhd1lSb
         oTBX9BEzgZlt0rqi4qWA6MEoB15+h4PmOPtNTPoAIprh+PW/8OFRmGpq2DSL/dnORZe4
         hykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aMRYiesUkuhUcWHm7mXM0NxFY94g3BEKOZEWtuemyI8=;
        b=Q1fyJ9dZMVOf/TkCe3Edmg9V6VPtZwfnv+P+GTFdsjKQidYW/vcRhw4Yaj6vvx90/Y
         HmJT9N3zkIgGKRdGNHPlhDE6i79QFf6k1IDSzgFDUWJW8VYpVzW/8+rcBHapeTiGcCTA
         n5R4okqQSEp86zu1DHRagwEiS0W9wZAHjWRBiT5p4MUKE/M1eF8w6kMIPrdg84KM1o5p
         esIkJAyGtySy6d54vdunnzavoC1s5JJ/wOhwLBsNOjPyi6OkBVDwNR4EysfWuRawTD6U
         24l5n4G2nn6FgK2HexhnnW70OIra39bzGc/upV5cRyHDC5CsT4/Iks7lWtocikE6+p62
         2LaQ==
X-Gm-Message-State: AOAM530HPLP/gzd4z+pjytcHf6PerhMwlyFb6ifAfHtGr5IBpf0fDWE1
        fMzC5LvhJuBUs9TaGuUiYbXbLh9MLfqpouCqgI8=
X-Google-Smtp-Source: ABdhPJyv8nzrnckS77xCl5suwUe4iWJh91COjRmhSaNDz5AhCyceunIK6RLm6WJ7bi8mFSkQay9Ov5qruii4WJWFT3o=
X-Received: by 2002:a92:dacc:0:b0:2cf:10a:8f73 with SMTP id
 o12-20020a92dacc000000b002cf010a8f73mr12270558ilq.213.1652268085286; Wed, 11
 May 2022 04:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8S8rh+VYcuaqBeNtmphiRqw7HropLFpkxfnTJq6BngGXw@mail.gmail.com>
 <CAP8UFD2p+Evqv_MBAgv23zooppsNWjOw6ZU2GLqAq_skZoJPOw@mail.gmail.com>
 <CABPp-BGD3AZvXwmSHfQQ_xh_UqevH23kdBYijAWUk8GHu1q0Qw@mail.gmail.com>
 <CAOLTT8STRfqq4bfobCK8Q5uvtXzgNYY0x0wNh4HNyAhv0Mc07A@mail.gmail.com> <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
In-Reply-To: <CABPp-BEFYjTvK4ZNSg+yiahRAzXW=KU11a-b+QRdcBDGb-movQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 11 May 2022 19:21:14 +0800
Message-ID: <CAOLTT8R7QmpvaFPTRs3xTpxr7eiuxF-ZWtvUUSC0-JOo9Y+SqA@mail.gmail.com>
Subject: Re: Question about pre-merge and git merge octopus strategy
To:     Elijah Newren <newren@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, vascomalmeida@sapo.pt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C 15:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, May 8, 2022 at 7:44 AM ZheNing Hu <adlternative@gmail.com> wrote:
> >
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B45=E6=9C=887=E6=
=97=A5=E5=91=A8=E5=85=AD 12:09=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > On Fri, May 6, 2022 at 10:24 AM Christian Couder
> > > <christian.couder@gmail.com> wrote:
> > > >
> > > > On Fri, May 6, 2022 at 10:15 AM ZheNing Hu <adlternative@gmail.com>=
 wrote:
> [...]
> > > > > I think it's not useful for git merge-octopus, because if we meet=
 a
> > > > > merge conflict, we can't find
> > > > > MERGE_HEAD at all! How can we abort this conflict merge?
> > >
> > > MERGE_HEAD doesn't have anything to do with aborting the conflict
> > > resolution step.  When you need to abort, the thing you want to go
> > > back to is HEAD (which represents the commit you had checked out and
> > > were merging the other stuff into), not MERGE_HEAD (which represents
> > > the branch or branches you were merging into HEAD).
> > >
> >
> > Thanks for clarifying. As I reply to Christian, when I just use "git
> > merge A B C" happily,
> > and there is a conflict, so I try "git merge --abort" as usual, but it
> > can not work... git tell me:
> >
> > fatal: There is no merge to abort (MERGE_HEAD missing).
>
> Sounds like a bug to me; .git/MERGE_HEAD should be written.  That file
> is created for me when I set up a simple octopus merge that has
> conflicts.  Do you have a set of steps others can use to reproduce the
> problem you are seeing?

Let me minimally reproduce this question (with git 2.33.0):

#!/bin/bash

rm -rf test-repo
git init test-repo
cd test-repo
git branch -m main
echo base > base
git add .
git commit -m "base"
git branch -c dev-1
git branch -c dev-2
echo main > main
git add .
git commit -m "main change"
git checkout dev-1
echo dev-1 >> base
git add .
git commit -m "dev-1 change"
git checkout dev-2
echo dev-2 >> base
git add .
git commit -m "dev-2 change"
git checkout main
echo main >> base
git add .
git commit -m "main change"
git merge dev-1 dev-2
file .git/MERGE_HEAD

which output:

.git/MERGE_HEAD: cannot open `.git/MERGE_HEAD' (No such file or directory)
