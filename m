Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B83FC4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 14:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKPOd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbiKPOdh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 09:33:37 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA4363D2
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:33:36 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-367cd2807f2so169231587b3.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAU1Quo7/n5IW+2/3sjZQC3Ina49Fc4U75nVNUcyh/k=;
        b=dRVlPHg47guui18Ry/dOGAXEyL4MAa4DI4P3vaqn4HazkLTjLXFukGsyvc/nfWSUTY
         LP2nVLam6BCeGqmIIBnEOewzlwFV8tVg+0l07pzVKrpTfHJ5YVaY0aeKlhBMPyv994CJ
         nCDf+OD29LgO8KCkqGEllq0orfHFpdHoKQ/32sPB3EnskY4NdnsZyoLMevPB1hYmFl6k
         Vgb+zKchy71V/yd+Y7aVaxTSocss6zsy3Et+kQmLtcP4YKmpvJky1FHq207OfDJk5SyZ
         jKMBLBVRSrnkLtzD7qR75/3YzI/p+oYnkozN1p4nedi7axEWgk5dBSddN/iKBCFX1KHd
         QKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAU1Quo7/n5IW+2/3sjZQC3Ina49Fc4U75nVNUcyh/k=;
        b=TwGSWGlFz9GLhlk/YQDDChmf3hIZnhZJXf0qFEWbYQ8fi8Zg+iJJkGLaBISrKCwYdV
         Nhy5H57TSPBL6pc9IminLWF9sRTxPRNl4iWWaeC8IItZZgqz+70d4qV1WsILeczsT7c7
         QCvk//KqDBjMHS5Oq7oQB4p1GTV/BoO7STG2c276Ob3ulTD26VEdnnZWxbAxdjCH8XFA
         JU9jUyy9/3zhmTyD1f0xGRXXAl6hFWG1bg0cZ4MALVmPInK+fXjuypGjMV2asJjG/glS
         DV38KoesyqkUx43+pWGzlF33vCV55evt3+bag9+viD2gmy8mkHNgm2A43m6nx04/PXKJ
         SpJg==
X-Gm-Message-State: ANoB5pmnwC7D0NB3p8sZ9u5M6FCxq8Y2yrBPAENmDkcFwhCfvj0TnX/o
        pCxZoFr7G3r8lGDdWk9VMXkHR9rKIxAsppkwUDo=
X-Google-Smtp-Source: AA0mqf6t+2TsKxN1HyfGncVguP90Ckxa76OzyeVZRdfBgiaUBgPEU86POSERN5nEovXk3U9AiOBM3Tyr89XH2vOm1Qw=
X-Received: by 2002:a81:198d:0:b0:373:4e1a:2b78 with SMTP id
 135-20020a81198d000000b003734e1a2b78mr21785512ywz.49.1668609215763; Wed, 16
 Nov 2022 06:33:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
 <CAOLTT8QOr-zTHBPLx5jibzQ6Co8a3VApgLEGRu0b+ht-VJh0nw@mail.gmail.com> <CAOLTT8QPPJ-pPvr9r3nJQgBg_7xCp5Ys=dd9nhi6fhgW6gYLow@mail.gmail.com>
In-Reply-To: <CAOLTT8QPPJ-pPvr9r3nJQgBg_7xCp5Ys=dd9nhi6fhgW6gYLow@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 16 Nov 2022 22:33:23 +0800
Message-ID: <CAOLTT8S8e_0LaEFLD4B4F=u9cKPtdPvp7tWJoEf3Z4Z9Bw6SUw@mail.gmail.com>
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

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 18:10=E5=86=99=E9=81=93=EF=BC=9A
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=B8=89 18:04=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=E6=
=97=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Perhaps it's worth noting why I think the sparse specification should
> > > be extended when dealing with the index:
> > >
> > >   * "mergy" commands (merge, rebase, cherry-pick, am, revert) can
> > > modify the index outside the sparsity patterns, without creating a
> > > commit.
> > >   * `git commit` (or `rebase --continue`, or whatever) will create a
> > > commit from whatever staged versions of files there are
> > >   =3D> `git status` should show what is about to be committed
> > >   =3D> `git diff --cached --name-only` ought to be usable to show wha=
t
> > > is to be committed
> > >   =3D> `git grep --cached ...` ought to be usable to search through w=
hat
> > > is about to be committed
> > >
> > > See also https://lore.kernel.org/git/CABPp-BESkb=3D04vVnqTvZyeCa+7cym=
X7rosUW3rhtA02khMJKHA@mail.gmail.com/
> > > (starting with the paragraph with "leery" in it), and the thread
> > > starting there.  If the sparse specification is not expanded, users
> > > will get some nasty surprises, and the only other alternative I can
> > > think of to avoid such surprises would be making several commands
> > > always run full tree.  Running full-tree with a non-default option to
> > > run sparse forces behavior A folks into a "pick your poison"
> > > situation, which is not nice.  Extending the sparse specification to
> > > include files whose index entries do not match HEAD for index-related
> > > operations provides the nice middle ground that avoids such usability
> > > problems while also allowing users to avoid operating on a full tree.
> > >
> >
> > I can understand the reason why we need to extend sparse specification:
> > index often needs to handle files that are not in the sparse pattern.
> >
>
> I might have one more question: when we use "git diff -cached HEAD~",
> what is the best way to check if an index entry is the same as HEAD here?
> Do we need to run "git diff --cached HEAD <file>" again?

I found that git commit will execute index_differs_from() to determine
whether the index has changed, It defaults to comparing HEAD.
But if we use git commit --amend, index_differs_from() will compare
to HEAD~.

the docs say:

       * When modifying or showing results from the index, the sparse
         specification is the set of files with a clear SKIP_WORKTREE bit
         or that differ in the index from HEAD.

I wonder if there is some description error here? Not always "from HEAD"?
