Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ADACC4332F
	for <git@archiver.kernel.org>; Sat, 19 Nov 2022 02:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiKSCu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 21:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233366AbiKSCum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 21:50:42 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1897CC4C3F
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:37:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id j16so11019420lfe.12
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 18:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mRdHmmWnnu5UfZgws2PFWVRcYApAT2YPskDo8sry/bs=;
        b=RyLv3i6XZC4GQhCjQ7ZSZZeZf6cREM5+VAlwDWgiYSdS3dFrP6V6iQ3dkCz1A3bfGa
         1AMkSxqOikB+PjzDcgWUv4BZIDSiugy3ng6MVRLmcWcbHaf1aZWfQ2npjLjEV4nUGYMn
         4yVSkV/HC8pQAxKq/c8Ww/HyKIKikbMppdCxrngBwvB1m+uMWSMtms8wB5Kl91GpbhRu
         CLEKZMDqsew+V8QJyQcjz+x83YVRP2fTDe07mT1VMoNRewdKmljYxqPwEehniG4FpnQm
         5f5EgJF2mjThSF799ejc74ZCEhfnTEdJTm+Q5Isj9IDylUSoBYEKahaE6SC2JkLaG20I
         2hzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mRdHmmWnnu5UfZgws2PFWVRcYApAT2YPskDo8sry/bs=;
        b=YBI+Op6aO+HQhyO0GZkwMyt9+bX6JrJ7u8d+aJ7ejr75tocAhVDfZq4T5N/HW3aGSO
         yLTplgktBkxF5qNg1TXjhBCOFclfYqjkL1xHmmD9vfUab7RYMNGmTwijw8OumVmalFRe
         SYaWVMz7TCEfsDQ6Cj9NxW5tyE2U2j+2GheiQChKYKJi+P2KeGb9Wi5Wv/Y56PRIO6GC
         Y5p7+9FBrmvlsTtsJ1Ly1+KUaHF+mIPabBdgKFIQ7WZe07PElhboszux+AGC6MIEr9qd
         7m3Y4eQwo13eUjmGr2Xtgnfv8x+95bwJTxdw2CyR1ax1SDM7QKM1zoeZ8lzu6JKZ82t4
         3IZw==
X-Gm-Message-State: ANoB5pmMgoHIEs1lr0Y1eHS/rOTo1A1lCSdnUb8uFP5Nru0Me0/v6Ybt
        8/onoc/tltIThra3kxCJGLFEyob/p8Q+w3nDeQE=
X-Google-Smtp-Source: AA0mqf686INjFdClQ4HQGZF87EEFyljKvrheKxSqHuGZ9iQ+c8fwdmKDIG2X+a6hr8HMDpX9+v1bsI9DRjMkAcm1fsE=
X-Received: by 2002:a19:674a:0:b0:4b1:3931:af with SMTP id e10-20020a19674a000000b004b1393100afmr3609493lfj.394.1668825419388;
 Fri, 18 Nov 2022 18:36:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
 <CAOLTT8QOr-zTHBPLx5jibzQ6Co8a3VApgLEGRu0b+ht-VJh0nw@mail.gmail.com>
 <CAOLTT8QPPJ-pPvr9r3nJQgBg_7xCp5Ys=dd9nhi6fhgW6gYLow@mail.gmail.com> <CAOLTT8S8e_0LaEFLD4B4F=u9cKPtdPvp7tWJoEf3Z4Z9Bw6SUw@mail.gmail.com>
In-Reply-To: <CAOLTT8S8e_0LaEFLD4B4F=u9cKPtdPvp7tWJoEf3Z4Z9Bw6SUw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 18 Nov 2022 18:36:00 -0800
Message-ID: <CABPp-BEvJWAWkKsknAqYVs16GuStmgzetkHXiSgqkYLdAhfPPw@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     ZheNing Hu <adlternative@gmail.com>
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

On Wed, Nov 16, 2022 at 6:33 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=B8=89 18:10=E5=86=99=E9=81=93=EF=BC=9A
> >
> > ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=B8=89 18:04=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > Elijah Newren <newren@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8816=
=E6=97=A5=E5=91=A8=E4=B8=89 13:49=E5=86=99=E9=81=93=EF=BC=9A
> > > >
> > > > Perhaps it's worth noting why I think the sparse specification shou=
ld
> > > > be extended when dealing with the index:
> > > >
> > > >   * "mergy" commands (merge, rebase, cherry-pick, am, revert) can
> > > > modify the index outside the sparsity patterns, without creating a
> > > > commit.
> > > >   * `git commit` (or `rebase --continue`, or whatever) will create =
a
> > > > commit from whatever staged versions of files there are
> > > >   =3D> `git status` should show what is about to be committed
> > > >   =3D> `git diff --cached --name-only` ought to be usable to show w=
hat
> > > > is to be committed
> > > >   =3D> `git grep --cached ...` ought to be usable to search through=
 what
> > > > is about to be committed
> > > >
> > > > See also https://lore.kernel.org/git/CABPp-BESkb=3D04vVnqTvZyeCa+7c=
ymX7rosUW3rhtA02khMJKHA@mail.gmail.com/
> > > > (starting with the paragraph with "leery" in it), and the thread
> > > > starting there.  If the sparse specification is not expanded, users
> > > > will get some nasty surprises, and the only other alternative I can
> > > > think of to avoid such surprises would be making several commands
> > > > always run full tree.  Running full-tree with a non-default option =
to
> > > > run sparse forces behavior A folks into a "pick your poison"
> > > > situation, which is not nice.  Extending the sparse specification t=
o
> > > > include files whose index entries do not match HEAD for index-relat=
ed
> > > > operations provides the nice middle ground that avoids such usabili=
ty
> > > > problems while also allowing users to avoid operating on a full tre=
e.
> > > >
> > >
> > > I can understand the reason why we need to extend sparse specificatio=
n:
> > > index often needs to handle files that are not in the sparse pattern.
> > >
> >
> > I might have one more question: when we use "git diff -cached HEAD~",
> > what is the best way to check if an index entry is the same as HEAD her=
e?
> > Do we need to run "git diff --cached HEAD <file>" again?
>
> I found that git commit will execute index_differs_from() to determine
> whether the index has changed, It defaults to comparing HEAD.
> But if we use git commit --amend, index_differs_from() will compare
> to HEAD~.
>
> the docs say:
>
>        * When modifying or showing results from the index, the sparse
>          specification is the set of files with a clear SKIP_WORKTREE bit
>          or that differ in the index from HEAD.
>
> I wonder if there is some description error here? Not always "from HEAD"?

Perhaps this part of the document will help:

+  * commands that always ignore sparsity since commits must be full-tree
+
+      * archive
+      * bundle
+      * commit
+      * format-patch
+      * fast-export
+      * fast-import
+      * commit-tree
