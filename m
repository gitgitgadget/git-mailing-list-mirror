Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5932DC433E0
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 02:50:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 139A064D8F
	for <git@archiver.kernel.org>; Sat, 27 Feb 2021 02:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhB0Cu3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Feb 2021 21:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhB0CuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Feb 2021 21:50:25 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B29CC06174A
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 18:49:45 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b13so4070437edx.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2021 18:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f00YTZg6d8usDaBYOUbeg16W1i/yrKQCONMGqWIjGqE=;
        b=HTL7V0X5pW1u16kDyQXNuxa5LfC6ardaKT8VzvyuxlbB+VpzSVF9HJ5sfuFxp2MkCx
         Uow5A+S9iQ5Zo4GXcZjQWvEPDjyMn4NKuGSfmV5t6IulFnmJhwMFN/PDSk0LsJwe2e4z
         mLswWrhevw8EutK4HK8GdZPcS4uAMCwj2wdVDQg6Bjb7mssH41TdoxveD6YHOBqwVrmn
         rGNSMmXla0xA72exxjb3r8kti+lVYH84XTNrLSOOCcmNTxM0UiHyrRoqiDyRSXF+gMpY
         zf5WbwKM2gZXmXDIuUsePKqCVv4ke4bqhJUfSUH8aDjShrdNAa8mNBxmKpxang0/OU2c
         81bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f00YTZg6d8usDaBYOUbeg16W1i/yrKQCONMGqWIjGqE=;
        b=qrlGkdNwvVCSjbBHfdENQy8VloxCkiFmQe+1BPNNhn+XTunYAg1+YiUn3HIzZgTd0l
         rENJOcd1ruMHUbZnFJAeUY/88BPnWpVLx8ZQ3qUdLXxzYvtd3OuznKrf6/bijWx+pCke
         g6DB4dkXjwgxmGFc0pITWkLLW8R3NEuo3zcnOYiwQe/NT9HgHfDB5nLs+98JXnNrfwSM
         xS31u5agbBUOUFb5DOlCSwjzPOu7BlqfLBfbFCOYNwTgxE64o+kz/ICa+Wst5NjKBfa8
         HC3orMFErJp178KfswYPYyAbrwdN8DxlpTO0mcdGF7DWbke67vVijAhJiwT73+CmyfBt
         xkBg==
X-Gm-Message-State: AOAM5300JFExu+9Tv98jE7uqJJPd9TI6JxNszWG8ZAlmFgsddrOK/0hL
        Mh1nG/PcdaqwsiMCpjyxhIEwrAZHolJnoAekfjc+Sw==
X-Google-Smtp-Source: ABdhPJwsvY/IUrf9GOFnuYxcrCtqfF71bPgVkKc6f1c/TvkW1COHjOKKsu8WLeterL3sLKtALzSiWUYnkVQKjp2vDcI=
X-Received: by 2002:a50:bc15:: with SMTP id j21mr6404821edh.187.1614394183808;
 Fri, 26 Feb 2021 18:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20200629220744.1054093-1-jonathantanmy@google.com>
 <92b218ca-f2b4-db9d-9f9c-1d071ea4fa97@gmail.com> <CAGyf7-G_OdS_0o7j64HA79n9Qv13SxciQSG+gfY7Qj8kNRQS5Q@mail.gmail.com>
 <fc8a2c0f-24b7-5884-b669-bb9700f3ba84@gmail.com>
In-Reply-To: <fc8a2c0f-24b7-5884-b669-bb9700f3ba84@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Fri, 26 Feb 2021 18:49:33 -0800
Message-ID: <CAGyf7-EzPrX8D5pnZKOGtiUHb6AZJs7Un4u39tOrcHkFi6gi-w@mail.gmail.com>
Subject: Re: Commit graph chains with no corresponding files?
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 25, 2021 at 6:20 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/24/2021 11:54 PM, Bryan Turner wrote:
> > On Mon, Jun 29, 2020 at 6:51 PM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 6/29/2020 6:07 PM, Jonathan Tan wrote:
> >>> At $DAYJOB, a few people have reported "warning: unable to find all
> >>> commit-graph files" warnings. Their commit-graph-chain files have a few
> >>> lines, but they only have one commit graph file with very few commits. I
> >>> suspected something happening during fetch, because (as far as I know) a
> >>> fetch may cause an incremental commit graph to be written, but I ran a
> >>> fetch on a large repository myself and didn't run into this problem.
> >>>
> >>> Has anyone ran into this problem before, and know how to reproduce?
> >
> > I don't have any specific reproduction steps, but we've just run into
> > our first case of this on Git 2.29. I ended up kicking off a full `git
> > commit-graph write` to fix it. That displayed the same warning, but
> > commands run after it no longer do. Prior to writing the new graph, I
> > had this:
> > $ ls
> > commit-graph-chain  graph-88f5fe6e0c659e3742e556982263813d528ead81.graph
>
> The contents of the 'commit-graph-chain' file are critical to diagnosing
> the problems here. Likely it had multiple lines.
>
> > Afterward, the `objects/info/commits-graphs` directory still exists
> > but is empty, and there is now an `objects/commit-graph` that didn't
> > exist before. `git commit-graph verify` seems happy with the state of
> > things.
>
> Yes, a full rewrite without "--split" will get you to this state.
>
> >> The incremental commit-graph code deletes any commit-graph files
> >> that do not appear in the chain. I believe this is done by comparing
> >> the contents of the ".git/objects/info/commit-graphs/" directory to
> >> the contents of the chain file.
> >>
> >> These appear to be case-sensitive, full-path comparisons.
> >>
> >> It is _possible_ that something like a case switch or a symlink
> >> could be causing a problem here. That's where I would look on
> >> the affected systems.
> >
> > Are commit graphs potentially problematic in repositories that are
> > borrowing objects from other repositories via alternates?
>
> This was definitely part of the design, with the intention of
> working with a common base in the alternate. However, if the
> alternate collapses layers, then the repo that is borrowing
> from that alternate may have a broken chain.

Thanks for the analysis, Derrick. This seems like a likely culprit for
how the repository got into this state, because it is a fork (of a
fork) and does use a series of alternates.

>
> It is likely a better setup to have the alternate keep a
> commit-graph file and leave the dependent repos clear of a
> commit-graph. _Or_ the dependent repos should use a full
> commit-graph instead of a chain.

Skipping writing the commit graph in forks seems like a reasonable
place for us to start, given the way it currently works, but always
writing full graphs may be another option. If the fork is able to
borrow the commit graph from its origin across the alternate, though,
then that implies there may not be a lot of value in writing commit
graphs in the forks (since they're likely to share the majority of
their refs with their origin).

>
> If you have a better idea for how to make this work, then there
> is room for improvement.
>
> For example, if we ensure during the commit-graph write that
> all layers of the chain are within our local repo, then these
> dependency issues go away without breaking any old Git versions
> that are reading the data.

Naively, this was the way I assumed it already worked--which is why I
was writing commit graphs in forks in the first place.

>
> > Have there
> > been important changes to commit graphs since 2.29?
>
> Not in the area of commit-graph chains.

Thanks again!
-b

>
> Thanks,
> -Stolee
