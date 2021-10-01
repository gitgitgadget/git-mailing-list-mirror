Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AF3C433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF861A54
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 06:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352132AbhJAGWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352034AbhJAGWA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 02:22:00 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510A7C06176A
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 23:20:16 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id v18so30176779edc.11
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 23:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lPAp2As84GqgEBWHGdRLu41I3iBX/323FGrYQrDF5Wg=;
        b=dsApErn0SMQ5rb/IsnXTpKemKhy4xfUXONGeXbUmXVSjuvALb2Bbs5ItiuFnEW3TxW
         NSLHqdBIY0LPa9IaJPT9uiWLT+Tc+g2g9kEXS7uk5BeL6DJVEdQ1Cj0CyeOJ8/z6bCNU
         LYrO8T6cAUg8HmRzOUZgPOfAUkhq/jKPkCSeIktbblipI801Eo9zOdzR86iuSa+nDsl6
         VsZwoT9MzrVPHu0OjkP32LaultRY6/KNV2YtAZod4G0NX34Ihf1QR1XuLQAU0t9ABPoC
         VhiTxwt1LNi5e65PXipXZcO4Az131/Rap9pAKh2BVtlWlESqLjq310yCHw5Z6Jgeu5j2
         65hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lPAp2As84GqgEBWHGdRLu41I3iBX/323FGrYQrDF5Wg=;
        b=kmg9GjFfPuvF0ZU/EXWOmhmyG/jrt0/nUX1kfZrh8UzQ7Dg1XP0s5i9fOq3Sp1vEF8
         z64VeuzcN0fj5H9+qvAWjfz5ijKIstIS6y2+i7YKC7Sx1HItm3aONuLknm50dNR6HWEH
         gmHk+baiPnOKsERIqv/29SYMsmm26AOt0jBNJne+J6/mZgVqEoQXzxcleHG5tyasPYIH
         WvlOEQMAdJJFl7IziUyq3NXwpXMNS0+/XdlJ4xBaHIhlmORHvz6kKk7NA0/OR24PgD3A
         0f2nnaoLAkwHElit6mrA14Coknd7WgtL/b3GyBiJQGNZcuLlPmDUNALb2FGC+Atn1cMc
         B44w==
X-Gm-Message-State: AOAM532nOtyLPq55kAuD+XZ7s7P2AeQw427AglvzFUPh4gbkdYUldh3F
        SC/EVr+ZyZTK7p7d8jcKY8pjEwp6MPgdEDY7e0MuwB0YdEdxag==
X-Google-Smtp-Source: ABdhPJy2aQaH5Ii7zOnCtJsYF/X2DmRgp7JBYpmjtDXwDWH8UQHj8dCmNMdOJDp22oyRQl5kwgMUf3+HeIioufmqLZM=
X-Received: by 2002:aa7:cfc4:: with SMTP id r4mr12159047edy.244.1633069214842;
 Thu, 30 Sep 2021 23:20:14 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqh7e18soj.fsf@gitster.g>
In-Reply-To: <xmqqh7e18soj.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Sep 2021 23:20:02 -0700
Message-ID: <CABPp-BHKOt+x+B3DGh3BJV_voP64pvTrL5B-w4hWqHNKfr2K3w@mail.gmail.com>
Subject: en/removing-untracked-fixes [Was: Re: What's cooking in git.git (Sep
 2021, #09; Thu, 30)]
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 30, 2021 at 6:09 PM Junio C Hamano <gitster@pobox.com> wrote:

> * en/removing-untracked-fixes (2021-09-27) 12 commits
>  - Documentation: call out commands that nuke untracked files/directories
>  - Comment important codepaths regarding nuking untracked files/dirs
>  - unpack-trees: avoid nuking untracked dir in way of locally deleted fil=
e
>  - unpack-trees: avoid nuking untracked dir in way of unmerged file
>  - Change unpack_trees' 'reset' flag into an enum
>  - Remove ignored files by default when they are in the way
>  - unpack-trees: make dir an internal-only struct
>  - unpack-trees: introduce preserve_ignored to unpack_trees_options
>  - read-tree, merge-recursive: overwrite ignored files by default
>  - checkout, read-tree: fix leak of unpack_trees_options.dir
>  - t2500: add various tests for nuking untracked files
>  - Merge branch 'en/am-abort-fix' into en/removing-untracked-fixes
>
>  Various fixes in code paths that move untracked files away to make room.
>
>  Will merge to 'next'?

Phillip (Wood) just recently acked the series[1].

=C3=86var made multiple good suggestions on an earlier round that I
incorporated.  A few others commented as well and I incorporated each
or responded why it didn't make sense, I believe to the individuals'
satisfaction.

However, on the latest series, =C3=86var has tried to suggest some changes
around the 'dir' member that he seems to want to see squashed in.
There's multiple reasons I don't like those changes, and even if we
ended up adopting them, I think they'd need a separate commit with a
good explanation of the assumptions being added by those changes[2].
I think such a change, if others want it, could and likely should be
submitted separately from this series.  And I suspect he's struggling
just as hard to see my point of view as I am to see his.

So...maybe I reroll the series with Phillip's Acked-by, and give it a
few days to see if either =C3=86var or I can convince the other?

[1] https://lore.kernel.org/git/b23bb983-39e6-75ad-0cb5-d9a5ba2cd4d8@gmail.=
com/
[2] https://lore.kernel.org/git/CABPp-BGi03JunRaMF_8SJKC00byOnq1kL3JyYhKWat=
z8-B4RsA@mail.gmail.com/
