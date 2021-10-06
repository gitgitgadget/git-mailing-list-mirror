Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D40DC433EF
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 05:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7D9610A8
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 05:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234450AbhJFFsH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 01:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhJFFsE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 01:48:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37457C061749
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 22:46:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z1so5274893edb.8
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wnUTwBKRcZI7BnCEABU5xV1mHJY8FGlsB6zSE5pIV6k=;
        b=YJtSDB4/4xeEiL6hCjcO7ChyAq9doRIEuvzYPA7YCe+s90qGnUjAOm3XrE1/kgBlY9
         +TidF6q8dDy9o8y3y8e07ZaZTj1U5iuLNk8ivQEP3EwSj/SH+FOr88tkiMoNSeQ4GQec
         Is3uqhAVl3rAd3yXI+ipiQDrfYGKiQ1cMXUf2UojECmop7wvVM8Ps6Fp+6o3euTVcITO
         JBC4ZlgzkGI6jZZ147eJQYAqeYitMQ/ECwhce1LCWO/uSxITwRkYEdbv+J9B46NLTTa/
         K/2mRCZ6UdsiG93UVm0Knvu0suwnjbwX+pvLsU6MqkLrFa9AhrHvXBH2Up+3oP7Z/22p
         dUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wnUTwBKRcZI7BnCEABU5xV1mHJY8FGlsB6zSE5pIV6k=;
        b=oZxmgtqSxbpXBFFe6xrTaJhBHWgwCL6aI1geZ9sjCD9z1J0cFUu6ZTBC7jtjMQdGu1
         SHQUOsiTehsdIwq/y56YTB+HeO/BRHDNwdlYsEtSEbZ1RFAk/2B/EaTfXzvrmVH8cHrg
         m6uEirS0tD6iPD0WfgeVJ0jwdnGi+RNHoNRkGXcPbcZjvpja0lEhLRVAPcaDsHM4Dmyo
         FhrLwRtgjWVbCdi+sfCDMnYSqeQtGq6Mz84b6YCRTEm0LMRz0LZbzenea63X+RzVlgBg
         BLtfZviSxE+E6InRmRrVxLHKB/ypIUabCMp27qzTxTWw8exwmv6LTpdkTt7Q3pk1piSW
         3tng==
X-Gm-Message-State: AOAM532voK+ZDGmMXhcvcjLH+cgwqwO54WBnVI2uvN6StZSBFLRJQOMv
        J8tdd2LgccSMwcbVPxu2jZ7m5TskQgfNWEZqeCPfdQpdwWw=
X-Google-Smtp-Source: ABdhPJxUkg/hmGy/rEWMaFxvtJ47DTe0okpJge0Y83TTmAFGKqIruK235TfjyCSiEXLIiUMXBqeEL5cBJPctyKSUPwY=
X-Received: by 2002:a05:6402:1848:: with SMTP id v8mr29319468edy.0.1633499171794;
 Tue, 05 Oct 2021 22:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com> <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 5 Oct 2021 22:46:00 -0700
Message-ID: <CABPp-BE+rc9_V9AHrXGRCJZJ9nG8FzVxTqmB+-nA+GuNboonDg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Sparse Index: integrate with reset
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Tue, Oct 5, 2021 at 6:20 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series integrates the sparse index with git reset and provides
> miscellaneous fixes and improvements to the command in sparse checkouts.
> This includes:
>
>  1. tests added to t1092 and p2000 to establish the baseline functionality
>     of the command
>  2. repository settings to enable the sparse index with ensure_full_index
>     guarding any code paths that break tests without other compatibility
>     updates.
>  3. modifications to remove or reduce the scope in which ensure_full_index
>     must be called.
>
> The sparse index updates are predicated on a fix originating from the
> microsoft/git fork [1], correcting how git reset --mixed handles resetting
> entries outside the sparse checkout definition. Additionally, a performance
> "bug" in next_cache_entry with sparse index is corrected, preventing
> repeatedly looping over already-searched entries.
>
> The p2000 tests demonstrate an overall ~70% execution time reduction across
> all tested usages of git reset using a sparse index:
>
> Test                                               before   after
> ------------------------------------------------------------------------
> 2000.22: git reset (full-v3)                       0.48     0.51 +6.3%
> 2000.23: git reset (full-v4)                       0.47     0.50 +6.4%
> 2000.24: git reset (sparse-v3)                     0.93     0.30 -67.7%
> 2000.25: git reset (sparse-v4)                     0.94     0.29 -69.1%
> 2000.26: git reset --hard (full-v3)                0.69     0.68 -1.4%
> 2000.27: git reset --hard (full-v4)                0.75     0.68 -9.3%
> 2000.28: git reset --hard (sparse-v3)              1.29     0.34 -73.6%
> 2000.29: git reset --hard (sparse-v4)              1.31     0.34 -74.0%
> 2000.30: git reset -- does-not-exist (full-v3)     0.54     0.51 -5.6%
> 2000.31: git reset -- does-not-exist (full-v4)     0.54     0.52 -3.7%
> 2000.32: git reset -- does-not-exist (sparse-v3)   1.02     0.31 -69.6%
> 2000.33: git reset -- does-not-exist (sparse-v4)   1.07     0.30 -72.0%
>
>
>
> Changes since V1
> ================
>
>  * Add --force-full-index option to update-index. The option is used
>    circumvent changing command_requires_full_index from its default value -
>    right now this is effectively a no-op, but will change once update-index
>    is integrated with sparse index. By using this option in the t1092
>    expand/collapse test, the command used to test will not need to be
>    updated with subsequent sparse index integrations.
>  * Update implementation of mixed reset for entries outside sparse checkout
>    definition. The condition in which a file should be checked out before
>    index reset is simplified to "if it has skip-worktree enabled and a reset
>    would change the file, check it out".
>    * After checking the behavior of update_index_from_diff with renames,
>      found that the diff used by reset does not produce diff queue entries
>      with different pathnames for one and two. Because of this, and that
>      nothing in the implementation seems to rely on identical path names, no
>      BUG check is added.
>  * Correct a bug in the sparse index is not expanded tests in t1092 where
>    failure of a git reset --mixed test was not being reported. Test now
>    verifies an appropriate scenario with corrected failure-checking.

I read over the first six patches.  I tried to read over the seventh,
but I've never figured out cache_bottom for some reason and I did
nothing beyond spot checking when Stolee touched that area either.

Anyway, I had lots of little comments, tweaks to the way to fix the
inconsistency in patch 1, various questions, etc.  It probably adds up
to a lot, but it's all small fixable stuff; overall it looks like you
(and Kevin) are making a solid contribution on the sparse-checkout
stuff; I look forward to reading the next round.
