Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD46EC4727E
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 05:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9375B208B6
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 05:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=webstech-net.20150623.gappssmtp.com header.i=@webstech-net.20150623.gappssmtp.com header.b="Bjdbt67p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgIYFKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 01:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgIYFKK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 01:10:10 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1EC0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 22:10:08 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b2so962841qtp.8
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 22:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=webstech-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6+8kPxkopHZ4yqZwHsM0ayMeD1xJdES4vaBbVmijEM=;
        b=Bjdbt67pz83T9j7OuMEwzzjRNz7iw6Gw+Ho0CCnl5smot1qWnwxGAHvn+rMytXIMV3
         qg5TJWzN5sbZt7NtgGSNh0PGIZBKyivHy3VAHrCciZ58encc5L+bSiIXierXxsXWtlEA
         aCG5efZs6U3C4ZZOfLuqX0G66gaTfQ/ln86LsxogDIdtLnItsed8hXayAtbOEFrxZLP/
         FrwRAbXPgeTppveOvrz4lxlXKY1LMEbijF1vSRG7UgskXdkzPHfftMadFbkB3jWXElVs
         roQHYFEjdPfaNPdzShrfMp7A+XAbmPse77Esm8irOywWSclBnWQv97vlh6fhNvprsRU3
         zTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6+8kPxkopHZ4yqZwHsM0ayMeD1xJdES4vaBbVmijEM=;
        b=p9/KkaiV0NpOrgwcCAN6eYYRv4dTQIz4W7UYstBjSC/ojIA8YFt70L5dg0BIn51oJ6
         J6mlWZA4j/sA3rjDHyDz5U1brm/NQyb09TZoi3ht+eATAmjmLMnnfp+XPr6qnJVETZfZ
         yYQgl5Jm3ghACQ13rfRjMx7GiS+WwhSU6VVrwbzq93Q6fZxrl8fMJIBkh1RVd8V6E1HS
         j27JMtxHjSq3nysnfqFh3sogbAYWlJJVclUDDzTo66nHLpcFdex/pbKjAKBxP7aPpvuq
         4umJBD9Fslsxiajs666S/oFDQRte+Qg/CPZneymJ9r+2/PSYUV3XQSAWVXvPrryv8xpu
         SlZA==
X-Gm-Message-State: AOAM530WOHVh7kXMFIj+iDZFaypXhgQVzQ1ACsaELqXfUYo+JWr4/k8I
        zp/AZpGv6mG7K9NibbVB2UCN+wDG15mkriRFzohTzg==
X-Google-Smtp-Source: ABdhPJzmsLRVaafpbLDqMIU6jS9f0qL4xLisXpRwJcajiJ2/XtFYbdUxS7RYVqZwsv1Pw7sMyp+h8qQ/14EYsevvgrE=
X-Received: by 2002:ac8:60d1:: with SMTP id i17mr2827810qtm.272.1601010607510;
 Thu, 24 Sep 2020 22:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com>
 <20200922170745.GA541915@coredump.intra.peff.net> <CAGT1KpVmeT+nT1-Pfwa_M8BptFYwRTL4ofM0k6UOOzkYh0kucw@mail.gmail.com>
 <20200924065129.GB1851751@coredump.intra.peff.net>
In-Reply-To: <20200924065129.GB1851751@coredump.intra.peff.net>
From:   Chris Webster <chris@webstech.net>
Date:   Thu, 24 Sep 2020 22:10:16 -0700
Message-ID: <CAGT1KpU6zkvr9QQQqez6x1cVsvhxmkU9gG5T0QYC8yCgnOPN1Q@mail.gmail.com>
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
To:     Jeff King <peff@peff.net>
Cc:     "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 11:51 PM Jeff King <peff@peff.net> wrote:
>   git clone --shallow-exclude=HEAD --single-branch -b $branch
>   git log --check
>
> _almost_ works. The problem is that the shallow graft means that the
> bottom commit looks like it introduces every file. We really want to
> graft at HEAD^, but the server side only accepts exact refnames. You
> could work around it with a followup:
>
>   git fetch --deepen 1

Thanks for the other possibilities (I have much to learn).  The first
step to increase the commit count is addressing this very problem.

> Definitely not worth
> it compared to your solution for a PR, but maybe worth it if it lets us
> do the same thing for arbitrary branches.

The PR solution works because fixed values are available from GitHub
(both repos are present and accounted for).  A push action for
branches could have issues with the state of the GitHub repo versus
the local repo.  What happens if the base branch is not current on
GitHub?  Is HEAD reliable? What if the branch has been re-used with a
back-merge? How do you limit the check in this case?  Based on my
demonstrated lack of knowledge these concerns may be addressable.

The original push solution pulled an arbitrary depth knowing
GitGitGadget had a limit of 30 commits and then limited the check to
post merge commits, again knowing merges were flagged.  Not pretty but
workable in the confines of the GitGitGadget workflow.

A generic push solution (with an opt out?) could be a separate file or
replace this (yea).

I appreciate the feedback,
...chris.
