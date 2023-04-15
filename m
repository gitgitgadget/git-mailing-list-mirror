Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2C1C77B70
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjDOXbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 19:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjDOXbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 19:31:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1B71FF1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 16:31:16 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2a8b3ecf59fso5535551fa.0
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 16:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681601475; x=1684193475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS1tULfbbrw7IqQUW2Z5IFNhRafcEUFR3GDe2nrJ5No=;
        b=V6bgiuZm3xU4ULcy4jMNFhUz5PDPQyxbPmDwrPIr4f7EV1G9g5elvF31/Epawhab3f
         kAwTzgVNInw5Y+0LLvb/jw3Nln0QZHiS+Ys7zpS1i5qTiwuBSiXkS/QDypTi1fX4LYm0
         1ktS4hMmsSfH84yA4BW4jYk40WQuH3F+T+tAvXLwWyPFsT4Kx0XpXKPe9eJvBCeNUyB1
         +7X5HfSS6qY9vBHOPcGOsQSCs1e/+DUOSoeCAVLcfM2cj6183VtKXzPG0BlehmUnDFHB
         01lAVupL7Xm0IMjwwC1r/fGCN73WE8r435qipULyWG1YgAzu6Fe4B+UDJ0av2WFRXWiK
         p2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681601475; x=1684193475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS1tULfbbrw7IqQUW2Z5IFNhRafcEUFR3GDe2nrJ5No=;
        b=YTlGKZ6+37tl77ivQwyXrpfg2LcegaGbQHK8uCkhrl7k2r+18gCEPYSnPtFVmrBfiY
         Go1F2HPQVV4y/qhWe3g+ESO+Feo8U0Q63dkTQgROsst8e9A+QtOjFVrlBijdcQpMN70k
         kMsTbRWretVC/g3e95z3suF0Wzg1sqw0XTqvi223YERyw9QTOIokluz1f/ofXJoSd7Pb
         4QI8FuWpDABd+iu5U5tevQGZ8D3Bg5nO0juOAmY9lGyIhBVr97gV4urQJzRaMuytr9Np
         U6nKVsZVcB2ADu4bSvXsPkjs0fspIzsXVkjvCNswZQh18ewsXpFAMvWom+O5npO6Cdfq
         iWSA==
X-Gm-Message-State: AAQBX9dsUD2ARqgIvGkVdVZ3twrMlvm4PtuH1vr47DUwVeqiotxBQJKf
        9xKF1awZsqjlmS5DB7WArPw7u4/tzMFB6zMxK0zk5F5OkqI=
X-Google-Smtp-Source: AKy350YftkG2ET/9O2gTSuc/R82G2zK52z2PRC5fvDWlw5vEWoFqxJhl6aluP2SDrwfki2sUfgJIrYt0rAuFiXEFFcw=
X-Received: by 2002:ac2:5383:0:b0:4ec:a052:9e93 with SMTP id
 g3-20020ac25383000000b004eca0529e93mr894247lfh.7.1681601474788; Sat, 15 Apr
 2023 16:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
 <CABPp-BHyvVhVKa+M-GYTG3OEmgmoaEij15BFXQ6oyDDsboxS9g@mail.gmail.com> <5cd89e46-f099-24bb-ebe4-fabdd6f94aef@gmail.com>
In-Reply-To: <5cd89e46-f099-24bb-ebe4-fabdd6f94aef@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 16:31:01 -0700
Message-ID: <CABPp-BGtewvrsO_9hf5A4iqpTBW7VL1p8skwMGA+tFju1emQ4w@mail.gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2023 at 8:36=E2=80=AFAM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Elijah,
>
<snip>
> > (By contrast, the closely related --remerge-diff option to `git log`
> > or `git show` does help see the resolution of *both* the textual and
> > non-textual conflicts, but of course one can't use that option on the
> > current merge until after first commiting the existing changes.)
>
> That's true. And, remerge-diff only helps when actually looking at two-wa=
y
> merge commit, not with conflicts hit during a rebase, cherry-pick or reve=
rt.

Good point.  I have a small patchset to create an option allowing
folks to see how conflicts were resolved in reverts, and in
cherry-picks made with the -x option.  I made it over two years ago,
but never ended up deciding whether to submit it or not.  At some
point I put it up on gitgitgadget, at
https://github.com/gitgitgadget/git/pull/1151.

Points against it are that it doesn't work for rebases (because we
don't know which commits they were taken from) or for many
cherry-picks.  Given the lower utility, and the fact that it involves
commit message scraping (looking for "reverts commit <X>" and
"(cherry-picked from <X>)"), I never ended up pushing for it.

> A semi-related trick I use to check conflict resolution during a rebase (=
after
> resolving the conflicts but before 'git rebase --continue') is to manuall=
y
> construct a commit from the index and use 'git range-diff' to compare it
> to REBASE_HEAD.

Heh, I have a semi-related trick as well.  During rebases, when I want
to compare overall diffs for the current commit against what it was
picked from, I tend to use:
   mydiff <(git log -1 -p REBASE_HEAD) <(git diff HEAD)
where `mydiff` is a specialized wrapper around `git diff --no-index`
that actually reads the contents of /dev/fd/<value> instead of
treating it as a symlink.  (Though if I don't have that script handy,
I just plug in `diff -u` for `mydiff`).
