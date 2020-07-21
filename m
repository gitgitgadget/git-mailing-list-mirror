Return-Path: <SRS0=GLOD=BA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DF3C433DF
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 17:09:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECE32206E9
	for <git@archiver.kernel.org>; Tue, 21 Jul 2020 17:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GjwJzE6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgGURJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jul 2020 13:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGURJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jul 2020 13:09:00 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C1EC061794
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 10:09:00 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id e90so15624177ote.1
        for <git@vger.kernel.org>; Tue, 21 Jul 2020 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g02ewQxDnrTHZpYeW9FMFnSol7pT3Wfg3AdUirqmi/c=;
        b=GjwJzE6/zhvqzLskp/L8PIxs0KiGUNXXIJmgGXJ2fbeOjX1OiZvAoD6z2JnyGOPUg5
         Pvqeku4XuNQIYxu4okhsamrUJzPkEd9xLfv1rQBzwUmpc+FVZNdn7Dieg/F8+vFEdb9w
         nAlF8BGczsJtXpIbmaF2WSVjjVbpygJYkYfcTpRSjvpx+LrubNwCNmyJN/ahxNEYjLDX
         upQxalHqHwrfNcfx58cRnKdvuFDPi32r42YDgXUrEcxOfSzr1oBt8ddop7iecUKA/DMQ
         e5W93xdli0LuaZMB8hDsKSwXcZAWAFfdglL0KOt5wDNoQVbL+4V1ei5PJeU3RPm2dwFu
         BaNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g02ewQxDnrTHZpYeW9FMFnSol7pT3Wfg3AdUirqmi/c=;
        b=TiUxxjf/8xGUAxdnpt60IW2vFQb71GQJQqoA6Vi2K6Jpg8x2fpbkLpq4568IZCDSe+
         /psnlUwW96BLhZB3Lk7bWKeuEUog4QWrLXTI965nqbSqxbTkRZ2yH6aDNlBk3RDMAsVm
         sORRU2N5gx0UVBS+t/EhlGe6DjjZQqaxFOlYWOrEimmJEVXbjGBgy2sKLxc3wwyf9wh9
         gsj4sxjHuVYlFn98cqNPUtsykTN82LyYdKUefne/Y51DbzNVY5PFaEbV9QWfbOccPzuZ
         n3hmttLA2tPTBktezrraBPXcLBSpUyXMdWYqPNe5MR8CXHQkHQ9hV6QiYJ3RQIodABuM
         dVKA==
X-Gm-Message-State: AOAM5327zrq6nVp9ionEUN67de5AXBOpa6bz1/3Dsx52YTGjELGZhYrp
        vpl8E2QfEUbcvbXeBMZy0Bu6AvJnrB+9q57PUBM=
X-Google-Smtp-Source: ABdhPJytaGUqldY2uJYxlUC/0AhqSqpMJftKqb/bXK5a5+GCdsQvnZiocTMEPHqHF5o8rTQi4zwkJ+ICUL0Ti6LwaLs=
X-Received: by 2002:a05:6830:18da:: with SMTP id v26mr26168788ote.316.1595351339048;
 Tue, 21 Jul 2020 10:08:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
In-Reply-To: <CAD9n_qh0y84HC6sX1OxXWWv8dDMMA_tPv9zRknePVivQq_rfww@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 21 Jul 2020 10:08:47 -0700
Message-ID: <CABPp-BE2R3eUU7WD1Ovkn_OfVH6fc42DnXs5CuBTkMUcQsnCdQ@mail.gmail.com>
Subject: Re: Request for adding a "clean" merge strategy for a double-commit
 merge to deal with conflicts separately
To:     Alireza <rezaxm@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 16, 2020 at 10:17 AM Alireza <rezaxm@gmail.com> wrote:
>
> Hi,
>
> Even though the merge commit's message includes conflicted files by
> default, the *resolution* itself is lost, that is, it's hard or
> impossible to review how the author *resolved* said conflicts.
>
> The proposal is that an option like `-X clean` would commit a clean
> merge and leave out any conflicting hunks in the tree for a follow-up
> commit to resolve conflicts.
>
> That would be extremely helpful for a code reviewer to see how a
> possibly external contributor has dealt with upstream changes e.g. in
> a long-standing branch.
>
> Any comment would be appreciated.

I disagree that they are "lost".  Rather, git doesn't make them very
easy to access: git log -p won't show you any output for a merge by
default, and the only options that exist (-c, -cc) don't do what you
need to see how conflicts were resolved.  Thus, the only way to get
them would be to check out the first parent of the merge, do a merge
with the second parent, then do a "git diff -R $merge_commit".  That's
doable, it's just annoying.

If there were an option to allow git log for a merge to show the
difference between what an automatic merge would do (complete with
conflicts) and the end-state that was committed, then the resolution
would become very accessible and the rest of your request would be
moot.  See https://bugs.chromium.org/p/git/issues/detail?id=12.  I'm
getting closer to having such a thing.

Elijah
