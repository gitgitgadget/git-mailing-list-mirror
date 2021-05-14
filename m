Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B444BC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881EB61444
	for <git@archiver.kernel.org>; Fri, 14 May 2021 17:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhENRiq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230487AbhENRip (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 13:38:45 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E6DC061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 10:37:33 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id d25-20020a0568300459b02902f886f7dd43so13667666otc.6
        for <git@vger.kernel.org>; Fri, 14 May 2021 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w07z7lWuoGZYDNTskAfKqrEcgAjYKOT6khHG7UnKMCI=;
        b=ELR6CLzdgZHu0KroSiK2eZqh7tUzdn4q+64f9wkzEwOu3zHnW01bGboim16vVrQN8T
         CKZmjCraJcNRSHqjen/uI+gvjsFKK/Zhv4oFdqdgQwOfZX/ojX9p06ic9zgO6E3gp9rn
         yQCoMAZ31ANkdBdArHpY4LGk1Gn/KN/doMd4CqoaNY7tO74ZYFqjJFc4f+zE7XT35Q7z
         c/M94XPH/UWR/j3J8ZTWTCMEx8reA6Pv9PlGywWubXqne3NMO/bIulmJiLtELwfl/Jqu
         IpcruMWDW/3DQxhGj7pVQbf9DqQLyHqjBtOHSlTYKKBI+6YGTO0KGass8XfkDJWOU03X
         TGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w07z7lWuoGZYDNTskAfKqrEcgAjYKOT6khHG7UnKMCI=;
        b=szYmTjuX2sP6aOrA9uyijnaGUWjIXOsg/ac4Gsl49Vh0i75AHxU6wCWl+ekf4PFqEb
         RvLJDjF0Bn0ACblzTrGxoIR7jAsRnRr5hJC2+CT7aXO3BsWWI+4C4JqhKYSo5rJxWbr2
         yx3rJSig9jkfaMJDQ6EKXkJGH8CVO++9svPxNHZIR/h393hGKecWPbkWJCHwcGiUXs2y
         XKTTnnZrl/WGhLeTTJFGYuKbd834YzB9YNJvYjnEyxQMTFB5gpTuUdfUQfC+KVD13rhG
         E5IEf+HC1JomiCPjwzZPmGgmpM4ugbdgwkUJ4pMnudrrj6w3itpv4C1oJNOdYmrEwOBb
         xpDg==
X-Gm-Message-State: AOAM530Y97Ims6aL8zgcdsT/A/HLDJ7PQR1jJgZk0rgylmGjufu4REHR
        YM9c60UXBiVIsb37Skl/d1WR9WYWNu5tIsTqiULPuEqeuHa7Zw==
X-Google-Smtp-Source: ABdhPJxB6MmGOM2oCBI70qgN9ZLBeVUVjv9GrC7bGI4dLNYL++qZ0QKBxwU2bVbvWnMQunbJAg+lN7PkEJBowW1lTpc=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr22139118otn.162.1621013853333;
 Fri, 14 May 2021 10:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <pull.859.git.1616621553.gitgitgadget@gmail.com> <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
In-Reply-To: <pull.859.v2.git.1620094339.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 14 May 2021 10:37:20 -0700
Message-ID: <CABPp-BGz-SGzbHAHOOjjo5FCBOgYehR0qa_rEn3saOw2gXt86g@mail.gmail.com>
Subject: Re: [PATCH v2 00/13] Optimization batch 11: avoid repeatedly
 detecting same renames
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 3, 2021 at 7:12 PM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series avoids repeatedly detecting the same renames in a sequence of
> merges such as a rebase or cherry-pick of several commits. It's
> unfortunately become a bit lengthy, but much of the length (the first five
> patches) is owed to special testcases and documentation.

Since this obviously hasn't inspired much review, let me note that you
can cut out 90% of the review size by skipping patches 2 & 5.

Patch 2 is essentially written as something approaching a formal
proof, so yes it's dense and lengthy, but it's not at all required;
there's no code there.  Think of it as insurance for if someone wants
to introduce some new tricky optimizations or radically different
features to the merge machinery, because the remember-renames
optimization by its nature tends to interact with other optimizations.
I figured because of that interaction that documenting why and how the
remember renames optimization works at a much deeper level than is
typical for optimizations or code in git in general that it might help
with future maintenance...and it happened to help me catch two minor
bugs.

Patch 5 is very much related to patch 2; it's testcases inspired by
that document.  Most of those tests were just "what could possibly go
wrong in a new from-scratch implementation of this optimization?"
based on what's written in this proof-like document.  Most of the
tests didn't turn up anything, but a couple found some small issues in
my implementation.  I decided to just include all of them; it's nice
to be thorough.

You can get 95% of the whole idea behind this optimization skipping
those patches and reading Junio's great two-paragraph summary at
https://lore.kernel.org/git/xmqqzgyrukic.fsf@gitster.g/, and then just
read the other patches in this series.
