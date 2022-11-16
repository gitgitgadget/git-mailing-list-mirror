Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB8C4332F
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 06:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiKPGwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:52:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231428AbiKPGwn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 01:52:43 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FC628707
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 22:52:41 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id d3so20613327ljl.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 22:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eACEQElCHuw15Ai6MII1LaDtP+9yIB6ARX5qtbDdlVE=;
        b=BHCWFcxDKWL95XLzqmACRlgpiS7bWwPkFibrscrxwc6tLBdWF3lxRCVWmD43nz3kLg
         uTQ3j+eAmghxVUQXRYKhr0vLmHS5UJoAySwZO3P0gCtUZVGvoLZ+eb6ACeIT+Xavw2qw
         rtJYEEHS2PdZYaClHn7TqpsfFPjUTyDi1bwtJucodYZSjCdqqoFsoRYPi26B4zpVh3mi
         CFBwyl/crMLIB+KvXMjBne+SjR3gvShmp3R5nFUSLnqZMgro3FNpidQX+5LIa4Lc3AGQ
         dgyXyFXuMDgwjVWowN01iHNS3QaKwP/adEfURMOzTWtZx0/LeSgUKrIQpCgs6fYIx0U5
         DQJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eACEQElCHuw15Ai6MII1LaDtP+9yIB6ARX5qtbDdlVE=;
        b=as0WyRJbxYWljNiugb97EBJPmrfhFZFms1/xyXTaW6CDZYCpYF8x9LqrfFjqa2/8A8
         Sz1eAYLx86x6XAYkEwKhT8k+UmtM0oZx7T0tZS7gG87V5qA0kYTaeAH2ArlWOtu/MZmD
         nxu7+9b6K746VpkBaNn5xvs4f/tVd98AK01qWvnoy4/KROEXcfG/GIdM4sIWp8IMizoQ
         pvaPNGAB+pn8vLFROuoeXUoPOBzKM765Ap++6sVkB8VToSzo8C2k4YJP4FHBBliEaUpn
         ShFE4GOxJkq//ZeBbi/vgXjEPiI0LtQtWop468D+yXnQLnS8Z1N++/6m8MBV8vxDqNyZ
         wJkw==
X-Gm-Message-State: ANoB5pnxbqm7Sn5jI3+RfF3Rygtpp7x8yJ6gLCJClF6QGRjYVU7zliMh
        9C2zThaXBfaUwDlB3FJV8UdPCtUGfdt+nECI0Ds=
X-Google-Smtp-Source: AA0mqf7W95zBiOfk2Kc5PadSdGLX6lWbFRFybGB/I4heJ9eB00a166wk++kESZ9PKHmtRckzIpu1nD//owCsWM0bCXg=
X-Received: by 2002:a2e:8e2b:0:b0:278:f572:c9ac with SMTP id
 r11-20020a2e8e2b000000b00278f572c9acmr6474854ljk.73.1668581560123; Tue, 15
 Nov 2022 22:52:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CAOLTT8T39Q4q5W2BaFVkm81T7mRc1UvT2MN07XHGT5qpB7ZMHQ@mail.gmail.com>
In-Reply-To: <CAOLTT8T39Q4q5W2BaFVkm81T7mRc1UvT2MN07XHGT5qpB7ZMHQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Nov 2022 22:51:00 -0800
Message-ID: <CABPp-BHQyLVoWu2eTqpC2tB0Kgg0b79otuoMDbVD8AtEXxQfjg@mail.gmail.com>
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

On Tue, Nov 15, 2022 at 7:18 PM ZheNing Hu <adlternative@gmail.com> wrote:
> ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2022=E5=B9=B411=E6=9C=8815=
=E6=97=A5=E5=91=A8=E4=BA=8C 12:03=E5=86=99=E9=81=93=EF=BC=9A
> > Elijah Newren via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2022=
=E5=B9=B411=E6=9C=886=E6=97=A5=E5=91=A8=E6=97=A5 14:04=E5=86=99=E9=81=93=EF=
=BC=9A
[...]
> > > +sparse specification: The set of paths in the user's area of focus. =
 This
> > > +       is typically just the tracked files that match the sparsity
> > > +       patterns, but the sparse specification can temporarily differ=
 and
> > > +       include additional files.  (See also "Sparse specification
> > > +       vs. sparsity patterns")
> > > +
> > > +       * When working with history, the sparse specification is exac=
tly
> > > +         the set of files matching the sparsity patterns.
> > > +       * When interacting with the working tree, the sparse specific=
ation
> > > +         is the set of tracked files with a clear SKIP_WORKTREE bit =
or
> > > +         tracked files present in the working copy.
> >
>
> I found af6a518 (repo_read_index: clear SKIP_WORKTREE bit from files
> present in worktree)

Yes, that was one of the footnotes referenced in the file:

+[3] (Present-despite-skipped entries)
+    https://lore.kernel.org/git/11d46a399d26c913787b704d2b7169cafc28d639.1=
642175983.git.gitgitgadget@gmail.com/

> which maybe a good place to learn about "sparse specification",
> it has a long commit message though.

Not quite; it was a predecessor that described some of the bugs caused
by the facts that:
  * "SKIP_WORKTREE" meant the file would be missing from the worktree
  * the above promise was often violated in a variety of ways
Experience with all the bugs caused by this situation (and the many
other attempted workarounds we tried that kept falling short)
certainly informed my suggestions about the sparse specification.
However, that only looks at the working tree side; the sparse
specification is also expanded for index-related operations, as I
called out in the other email I just sent you.
