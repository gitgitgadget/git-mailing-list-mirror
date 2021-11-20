Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4218C433EF
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 22:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236176AbhKTWRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 17:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235984AbhKTWRE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 17:17:04 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACFEC061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:14:01 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so58619769edd.9
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFIv8nPgoNgQAIJm3kSQ4eTVer1rVh6g/pIWZEPiXFU=;
        b=VqKp8A06Mf7JQQQ+C1Xx21g6OW+cBGXujdaArCJS8HHyVjLVVrr3eD4nzUSo5iinT6
         qrz+PMML/hapo/S+0A5AAGfhbHXsNtaTCG1O9qr41cWENxj5paPdEUTjSF5mjSwUwy9M
         nc5FjphmPBvsoLhcSGf5rZLDBRhb7izGHAPgKuVe2W+8L+IECQTuu+hr8tKLoVX24ENP
         Kca0p3m8IuRZfPPYAh2T30K61UHB+wDa2Cap10avWKtAUTNOKh6cZrWuVfvnVbWy4lyo
         mGGaJ0/ardBhkLW+wYUCpuHRFmqLkgcXIFGkkZOO2FYXB/1bHCx3hp9zQID9bjvB+sbc
         4gXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFIv8nPgoNgQAIJm3kSQ4eTVer1rVh6g/pIWZEPiXFU=;
        b=oU03XyTHCLBuhL2/9CUqbRzEZMrG4bmZa4ZsBWp4H35s96o7T1IQNkOFqHpKdNq+I9
         29siD0XlXAw+TpuhTrM14wTOpgsIWzOcvx70/Ggu/zltFZWj1tg8N/CW/MfSnHtW3iTk
         O/czwU8750Rg+mtjtTHP476COrY69FAvJGqbhRo5WFFOHivm7QycVL+vELtFJPSdDPSZ
         jQFfDgX4ajnZxusO8rhp9DLfT2UBrPGtKMf6+wbqK1r/1NxALqbU/Tfd1PWZ0o9v3fTQ
         r5MMmgWu5bVUE4v13C4hHoUT0cypbL7Y6nv7GpTrUwCFm4TDqZ6AdLg9FrmTBYIWubPq
         z9LA==
X-Gm-Message-State: AOAM532ZPm5cBKXlW7P825QISDjJ559E7WY9RYpzTJKxiRe5V5IjGhOh
        w8tSwxhDodJ+fg/aavgzoAvwQLX69q736EMb/dI=
X-Google-Smtp-Source: ABdhPJxd5+ROKJcagS/uPqAZGzXMyYZySpoka+XpuvRLoeJs6nH6DFbgKnO10+Eft5Y3zG3E+qpxWE5klQUgrJ3INF0=
X-Received: by 2002:a05:6402:12d3:: with SMTP id k19mr42819245edx.244.1637446439601;
 Sat, 20 Nov 2021 14:13:59 -0800 (PST)
MIME-Version: 1.0
References: <pull.1048.v4.git.1633984222.gitgitgadget@gmail.com> <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 14:13:48 -0800
Message-ID: <CABPp-BEKEC74qx_KrZTLDdt_bsgAQhR9MhO9v9pTtVvFyjaX6A@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Sparse Index: integrate with reset
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

On Wed, Oct 27, 2021 at 7:39 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series integrates the sparse index with git reset and provides
> miscellaneous fixes and improvements to the command in sparse checkouts.
...
> Changes since V3
> ================
>
>  * Replace git update-index --force-full-index with git reset update-folder1
>    -- folder1/a, remove introduction of new --force-full-index option
>    entirely, and add comment clarifying the intent of sparse-index is
>    expanded and converted back test
>  * Fix authorship on reset: preserve skip-worktree bit in mixed reset
>    (current patch fully replaces original patch, but metadata of the
>    original wasn't properly replaced)
>
>
> Changes since V4
> ================
>
>  * Update t1092 test 'checkout and reset (mixed)' to explicitly verify
>    differences between sparse and full checkouts

I apologize for my tardiness in reviewing your updated series.  You
have addressed all my feedback from v2 and things look really good.  I
had a couple small questions on patch 7.

As with my previous review, I kinda skipped over the last patch
because I never figured out the cache_bottom stuff.  I read it to see
if there were any obvious mistakes to someone unfamiliar with that
mechanism (i.e. me) but didn't see anything.  I read over the earlier
patches much more carefully.

Anyway, other than patch 7 -- where I only had a minor nit on the
commit message plus two questions (which might result in no changes),
the series looks good.
