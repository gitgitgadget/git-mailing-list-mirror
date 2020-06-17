Return-Path: <SRS0=YePV=76=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9171CC433E0
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5A620663
	for <git@archiver.kernel.org>; Wed, 17 Jun 2020 07:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLCWAi8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFQHkf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFQHke (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jun 2020 03:40:34 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550AEC061573
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 00:40:34 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so1201175ejm.12
        for <git@vger.kernel.org>; Wed, 17 Jun 2020 00:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T0ThxPcNiXL5+uHY0QcjyPovpuDBU4nSb/5T5gATrhA=;
        b=oLCWAi8E5Bgcwn9Bw3NSrVVgW2VBrxvvt/pqs7iUekUBmPMYukicfXcMgqQ30+YulH
         bMonaKFoEfVLPeVteNOJsyEv2hsFkzfGv0lwaFKIMAIfH+UItaZvl9ZDHGgwDTGr9bQF
         uYuw3x9ZVhcSpjH26R4srQZQPFMdbrU2O1FSvHuONxXH+oxieLV6e+VBr1iHe7C7l4M5
         eJEXBuL2F6pi8mjS83eSNqN8PoIQTmZ/qOqhg3g9B87B7k9oicYEdy7bYgn24zxEKeql
         sx06rqOcYWBGZCi8peKXj4Q8OdV7QwpQn943viXQC+wlqDZ23FI0I9D6QEmKcMhhp5KZ
         DJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T0ThxPcNiXL5+uHY0QcjyPovpuDBU4nSb/5T5gATrhA=;
        b=PYzaJFp1KsMhJPvmmGERqdahBD9XkC8hUd7XeV8iCZKrn5eU++cw9yQqUkFDypsnRU
         OPvaty8eWeakIdavIqd1BbfWUrJttiVVHW0PweZiqfnYwLsLJyRWs/NICY8BERTRKisF
         1uJh2hPZc5EwJly1moI0+Amf/fj2Ws77qDpcckwJ+rG8Yk4ssgSua41wfpcJr2WmKNF7
         OzbvM4zF+zuDTWTRrSIxDZKMurG9wJUAJrqX2fQWiTsGQAxqs4pb62pgyzNOZOEzp8zD
         Kwue7uBkil9CkiOQ6L6gyWZn/iA2sV/o0/jr1m0pMsHoTzZkf74utZNNQqFUwFjKUBBg
         DVAQ==
X-Gm-Message-State: AOAM5338WunhXERVtIUIi8hS01Y347SVpyaH4tw0ynXpGUyGeDrCVnCJ
        VS64VgSoSu5YcwN0dgZcq0qTJz6RDpSAp6SEb3dO9saS/d8=
X-Google-Smtp-Source: ABdhPJzajO+vjgb4MNLABO3DlERsjA8mZlWuke5CM6Ug67PMjS6eH7VyCUZRgQ0Lt93fOldxl7qb/XxOSE8I22TbClA=
X-Received: by 2002:a17:906:8684:: with SMTP id g4mr6012235ejx.431.1592379632974;
 Wed, 17 Jun 2020 00:40:32 -0700 (PDT)
MIME-Version: 1.0
From:   Son Luong Ngoc <sluongng@gmail.com>
Date:   Wed, 17 Jun 2020 09:40:22 +0200
Message-ID: <CAL3xRKf+rQuq=j_4NJpNbRq4Rdxz7MjQaxi3c9usS+c615k19Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Sparse checkout status
To:     gitgitgadget@gmail.com
Cc:     dstolee@microsoft.com, git@vger.kernel.org, newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

> Some of the feedback of folks trying out sparse-checkouts at $dayjob is that
> sparse checkouts can sometimes be disorienting; users can forget that they
> had a sparse-checkout and then wonder where files went.

I agree with this observation: that the current 'git sparse-checkout' experience
could be a bit 'lost' for end users, who may or may not be familiar
with git's 'arcane magic'.

Currently the only way to verify what's going on is to either run
'tree <repo-root-dir>'
or 'cat .git/info/sparse-checkout' (human-readable but not easy).

> This series adds some output to 'git status' and modifies git-prompt slightly as an attempt
> to help.

This is a great idea but I suggest to put a config/flag to let users
enable/disable this.

Git status is often utilized in automated commands (IDE, shell prompt,
etc...) and there may be
performance implications down the line not being able to skip this bit
of information out.

> For reference, I suspect that in repositories that are large enough that
> people always use sparse-checkouts (e.g. windows or office repos), that this
> isn't a problem. But when the repository is approximately
> linux-kernel-sized, then it is reasonable for some folks to have a full
> checkout. sparse-checkouts, however, can provide various build system and
> IDE performance improvements, so we have a split of users who have
> sparse-checkouts and those who have full checkouts. It's easy for users who
> are bridging in between the two worlds or just trying out sparse-checkouts
> for the first time to get confused.

One of our users noted that the experience is improved when combining
'git worktree' with sparse-checkout.
That way you get the correct sparsity for the topic that you are working on.

In a way, the current sparse-checkout experience is similar to a user
running 'git checkout <rev>' directly
instead of checking out a branch.
It does not feel tangible and reproducible.

I was hoping that these concerns will be addressed once the In-Tree
Sparse-Checkout Definition RFC[1] patch landed.
We should then be able to print out which Definition File(s) (we often
call it manifests) were used,
and ideally, only the top most file(s) in the inheritance tree.

So the ideal experience, in my mind, is something of this sort:

    git sc init --cone

    # assuming a inherited from b and c
    git sc add --in-tree manifest-dir/module-a.manifest
    git sc add --in-tree manifest-dir/module-d.manifest

    git sc status
        Your sparse checkout includes following definition(s):
        (1) manifest-dir/module-a.manifest
        (2) manifest-dir/module-d.manifest

    git sc status --all
        Your sparse checkout includes following definition(s):
        (1) manifest-dir/module-a.manifest
        (2) manifest-dir/module-d.manifest
        (3) manifest-dir/module-b.manifest (included by 1)
        (4) manifest-dir/module-c.manifest (included by 1)

I have a feeling that the current file skipped percentage prompt is
not that useful or actionable to end-users,
and they would still end up feeling lost/disoriented at the end.

Thanks,
Son Luong.

[1]: https://lore.kernel.org/git/pull.627.git.1588857462.gitgitgadget@gmail.com/T/#u
