Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB8DC433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 23:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239879AbiFBXwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 19:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiFBXwt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 19:52:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CBD6380
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 16:52:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id s12so5684707ejx.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 16:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoZ6MI6qSAPVklyhff/R2699QS5xYNMVCjNLT7hTEBY=;
        b=O2I2IpXiksSpKLzQ8bHoXWokVZDUse0zuQKTsEacVoWKFUgtJmILGjndXPphQO0nCb
         eMVYiXn4wvrp1rSZRqTCbBY1dWbkqAUshlPlaZmLQBrcKSqFUuqrt14/qsLdWQg5YBK0
         Zopw7RkkyKDKmz7Y3WWDIhVFiwXmj+6K2eunZLZzhx+jYuNdE/w5KqjbQ8xd5GgeKjxx
         GeXQVmvyqySyIr+KozSQFD596kb3VRP+DQ/RBSCzjoZXLIG8GCRuf2lc/uimbnGXfY2J
         ghm1Wg3D3Io2gnRiW1cC0x+LTExVCpQxax4Icxr+yUL0YR1JMivDmk3yxNXzclfZvzq2
         PiEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoZ6MI6qSAPVklyhff/R2699QS5xYNMVCjNLT7hTEBY=;
        b=gKIWRfezFuD9yRfmoQruBuJwWqHKg+KvMveczelm6//Ao5UWAsMLdDzNk39330KsOU
         bLbapDZtuEN1MnoubMKBHMVvdkslJikvdHsvtcZduRKavSs9xwSrxqHutUMVn+9G/w1F
         rib/jHy/zGAWyens0unbcGmCJH3zGmBlrZVb66YBaxQgMs4q3lEP3kUvlKZMcwFWyFU6
         ZpapDQipYZqyoSNoYQQReGv4ECYWW6Bs3RYSUAysvyECNCSH2hD6cH0bnW36ynk9ik3p
         Q1XyCHxDjGygXos4/1R1qnlQs8nJdfRkqTR/JOKJsoMDZlewhZOcxSLSqhayio3Ab+/7
         Y7JQ==
X-Gm-Message-State: AOAM530ULeX6Xu6kq/OL8VcKIoV5vnb4bWIlJr0OApNmkYsBuHCS8lpT
        zF5sogqCuuUQcN/n8L5/LvOORRgfNuVGmBC2+rp+kW1Gquc=
X-Google-Smtp-Source: ABdhPJzWX/U1NRtWn6w5Cya7BGmZW4Z++6zsNA23O3W1MFZ8mbW1qe2ymTtWE0gevKxkmB9s8gX8NvGnO/tGhpgTxFM=
X-Received: by 2002:a17:906:7049:b0:70c:a5fe:d4f8 with SMTP id
 r9-20020a170906704900b0070ca5fed4f8mr2760612ejj.493.1654213965973; Thu, 02
 Jun 2022 16:52:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpoj8CyhB=g0=HD2Y2w6+mkGVRsgoq6zsb5XCTt95uDELog@mail.gmail.com>
In-Reply-To: <CAPMMpoj8CyhB=g0=HD2Y2w6+mkGVRsgoq6zsb5XCTt95uDELog@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 2 Jun 2022 16:52:34 -0700
Message-ID: <CABPp-BF4kD8uieZ1QWLbzejhuhaZA7rYfDR+8dGrteL_4UhkHQ@mail.gmail.com>
Subject: Re: Cherry-Pick without affecting working tree / index?
To:     Tao Klerks <tao@klerks.biz>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 2, 2022 at 10:08 AM Tao Klerks <tao@klerks.biz> wrote:
>
> Hi folks,
>
> I'm wondering whether it's possible to perform a (non-conflicting)
> cherry pick without impacting the working tree (or index).
>
> I understand Elijah Newren has been working on git-merge-tree changes
> that would allow for simulating (and even saving) merge commits
> without affecting the index or working tree, and I could imagine
> that's a piece of how such a thing could/should work, but I'm not
> terribly clear on the relationship between merges and cherry-picks.
>
> It *seems* as though I could enact something functionally equivalent
> to a cherry-pick by first creating a (temporary) "--ours" merge commit
> on the target branch, pretending to have merged the parent commit of
> the cherry-pickable one, and then merging the cherry-pick commit
> itself on top of that. The resulting tree could be used as the basis
> for a final commit on top of the original tip of the target branch, if
> that merge were clean, and otherwise fail saying "there are conflicts,
> go do things properly in a working tree pls".
>
> I'm not sure whether this is the right way to conceive of
> cherry-picking, however, or whether it makes more sense to conceive of
> it as a single-commit rebase.

The merge --ours stuff is going down a weird path that I don't
recommend, but thinking of it as a single-commit rebase is good.  In
fact, the default rebase backend was originally written by calling
cherry-pick for each commit in question.

> Is there a relationship between
> git-merge-tree and rebases?

The patches I submitted do not have the ability for rebases to be
built from git-merge-tree.  There's a debate over whether my series
should be tweaked to enable it.  Peruse the thread over at
https://lore.kernel.org/git/xmqqh78nj0q0.fsf@gitster.g/ if you want to
read some of the discussion, as well as see discussion of how merging
and cherry-picks/rebases are related.

> Is there an aspiration to develop "server
> side rebase" also at some stage?

Yes, already in progress and possibly usable for simple cases.
Haven't had some time to work on it for a while (~4 months, sigh), but
will definitely get some time in late June/early July to carry it on.
You can check out the "replay" branch of github.com/newren/git if
you're curious.
