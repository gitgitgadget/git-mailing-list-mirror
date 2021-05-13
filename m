Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1164C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F67613A9
	for <git@archiver.kernel.org>; Thu, 13 May 2021 04:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhEMEN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 00:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhEMENz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 00:13:55 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8B1C061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 21:12:46 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso22633504otg.9
        for <git@vger.kernel.org>; Wed, 12 May 2021 21:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJsNsUzENm8jaqv6HZmf/n5YA87NeR9q7sEzGnoQYN0=;
        b=VteaaT/CkV/78wUC4gaczDeNEjIxv/MDXAOdn8jjgUQX8iWD1NCkxtEqUSZj8KdYEH
         /GzNscUPd5fV+06rS17FEU6vdWz1WaIhKpKQNEB1TPnDR2YUQbcq7dOdYNYrhLf5eL1k
         JDzB0cgg3KT7Ny1TcQnEWRcqG0sSHQxWt6C2u+8OkbCfTEuoOtb8bx4woquEO8Oz1zmD
         y7sqkjz5ZbddXyoYWkjOm4rRCJx6zOkKlWuRm6+zRb2anOXZPYGCrsH5gl4iErXIv0LY
         VTd1UX/QxYUUQxmI9/YDV8hrzSkQsetYgSwvftgNoFFNrIk1J0zK+Gmp7L317MBA3yk+
         LFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJsNsUzENm8jaqv6HZmf/n5YA87NeR9q7sEzGnoQYN0=;
        b=CeGO+qXS4HfNDYxxXsB2ylnkZcOGBgzRcDDGxWC3//4D3W0oYMbUOG1LqznJUaWQvm
         eUDv0n17cv5ok65oVPNCLM8OxokmG2fE7/p/xpfIFrTrtXJ8X4mVPfwkFl7M772FG1xD
         oIzQz2NhS/j7sQRKXS0hkfVGZP73Z5dwnQw1Z8XxlNnxMyYT+OreU7FKmhiFCqWO8TwW
         ajW+sdzGzQMVWtDyPVGgDU+CTLZ3aYwkqu3KYUYrC+NKlbMnJtO9BCewNAnoCRkPdeEW
         i9hNzQatgPM+XLLVfmhhfBdJPeMQQ/3qshTIXF+2noX9o+9uzIHtzQiQM56AieygWlJW
         TC/w==
X-Gm-Message-State: AOAM533w0yL5prjzG/g5ScVESy2R/FAJBv6IntSHJ+ZcBVK2TU3rRL/0
        z/0GzyToJNpN2H5jFgGZLCFIyxc8iQgqNiTpiD8=
X-Google-Smtp-Source: ABdhPJwFeeUMYmgvNl6HmQz2c4yu7yVeYWimq+lSuAaAiWbZdBCtv+UQVKtzM1jkxxyUvVw3vylo+tou2iWxKMLp8kM=
X-Received: by 2002:a9d:6b8d:: with SMTP id b13mr11002227otq.316.1620879165410;
 Wed, 12 May 2021 21:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 May 2021 21:12:34 -0700
Message-ID: <CABPp-BF0EGo-WLTN45qOu02O4sEzmSCUXT3XeoKQdbTHToNQOw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Sparse-index: integrate with status
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 23, 2021 at 2:34 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This is the first "payoff" series in the sparse-index work. It makes 'git
> status' very fast when a sparse-index is enabled on a repository with
> cone-mode sparse-checkout (and a small populated set).
>
> This is based on ds/sparse-index-protections AND mt/add-rm-sparse-checkout.
> The latter branch is needed because it changes the behavior of 'git add'
> around sparse entries, which changes the expectations of a test added in
> patch 1.
>
> The approach here is to audit the places where ensure_full_index() pops up
> while doing normal commands with pathspecs within the sparse-checkout
> definition. Each of these are checked and tested. In the end, the
> sparse-index is integrated with these features:
>
>  * git status
>  * FS Monitor index extension.
>
> The performance tests in p2000-sparse-operations.sh improve by 95% or more,
> even when compared with the full-index cases, not just the sparse-index
> cases that previously had extra overhead.
>
> Hopefully this is the first example of how ds/sparse-index-protections has
> done the basic work to do these conversions safely, making them look easier
> than they seemed when starting this adventure.
>
> Thanks, -Stolee
>
>
> Updates in V2
> =============
>
>  * Based on the feedback, it is clear that 'git add' will require much more
>    careful testing and thought. I'm splitting it out of this series and it
>    will return with a follow-up.
>  * Test cases are improved, both in coverage and organization.
>  * The previous "unpack-trees: make sparse aware" patch is split into three
>    now.
>  * Stale messages based on an old implementation of the "protections" topic
>    are now fixed.
>  * Performance tests were re-run.

I read through the topic, both my old comments, the range-diff, and
the new patches where the range-diff wasn't enough.  I tried to spot
issues, and was hoping to find problems you alluded to in your recent
comments at https://lore.kernel.org/git/05932ebc-04ac-b3c5-a460-5d37d8604fd9@gmail.com/,
but I failed to spot them.  I hope it has to do with the cache bottom
stuff that I just don't understand, because otherwise I just missed
the problems in my review.  I can say that in v2 you fixed the issues
I did spot in my review of v1.

I'll look forward to v3 to see what it was I missed.  If I somehow
don't respond soon (in a week at the latest), do feel free to ping me;
sorry for somehow having this one slip through the cracks.
