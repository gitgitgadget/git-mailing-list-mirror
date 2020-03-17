Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FFCC10F29
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 07:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5587A20674
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 07:24:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8XNbQFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbgCQHYj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:24:39 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:34391 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgCQHYi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 03:24:38 -0400
Received: by mail-ed1-f44.google.com with SMTP id i24so21254936eds.1
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 00:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EAs7Yox9YtyGM4Q+8C+ThGmr0gaucRYwXgVR/FNrzVo=;
        b=N8XNbQFn4gEqV0Zb+rfA8k6FYuIJY8QjWql/imkL3M55TlJ/qX1ufPoisOtaI63Onf
         gMpW3f9Mf3Gwk0q1PVP7aUKLkE3skD5EpMjWkKh7hUOw0kXceAEehSbMPr4NPGXcGdk4
         riws6DsUAMFipVd3rXZmYERuAl6Z7Jmw1eie/FxBWcfj9beSgFMYW68TwatLtHlfh2BC
         3uHdFBDQ+PD6GcOeLbac3YvDa8Xmivf0m8emx2npkz082hKxTmgcoDMUyldMdL5C7QAy
         YIF50XIYWY4JHo3RqUuWee13N+BIqNMd4hJ//Otv/8e1kGCFDFDRsxXWettrEe5oDy2t
         OVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EAs7Yox9YtyGM4Q+8C+ThGmr0gaucRYwXgVR/FNrzVo=;
        b=X7A323CyiQqusrDpcfBOJ7bD39X3ZDipNWnudqmb0S0Q9bBsrOuYZ6EbXIgwuEMCCg
         b6csmCblMduRn8QSSatdRyQm9cIK8kVehLH9RRaPq1WbBENFwunGbS54dvGn16Sy4SeR
         fvawyGAmLIW3C3DbHBsGTIuErZAedks2fyJBeybax21y89jVUYsEUoGbhMv1PI/yPDxR
         3oDrY4rWfkNKoobR8Dd29LSw8rGqpnG9JiOa2cS45AxGSnK9Cy6EFZLdNARlYb6513JS
         6xDNgqXBrN50Bl4eUsWAsoHzUx6XwAoPOslcO04lGwWESrJMxa3R4iifhR89daYmR6a9
         vpkg==
X-Gm-Message-State: ANhLgQ3EhpuxEHTfzrovcMOL16goqOARIfI7BqhsxRkrgW+4Z24xexKO
        iBiCN8t9yU3gCl2FIBjTG5HJhMxaSEJfvLMGt+KZWkX4Tng=
X-Google-Smtp-Source: ADFU+vsToayiGXeeSVFXodKO6EyCwHaklz6LFpkZ2Do5jN39+uCS+UDTcGlnuyD2cW37trLdnaaYLmhHQoDqoyQoi2o=
X-Received: by 2002:a17:906:3502:: with SMTP id r2mr2761270eja.67.1584429873951;
 Tue, 17 Mar 2020 00:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <86mu8o8dsf.fsf@gmail.com> <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
 <86d09b7jx6.fsf@gmail.com>
In-Reply-To: <86d09b7jx6.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Mar 2020 08:24:22 +0100
Message-ID: <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
Subject: Re: [RFC] Possible idea for GSoC 2020
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 17, 2020 at 4:13 AM Jakub Narebski <jnareb@gmail.com> wrote:

[...]

> >> ### Graph labelling for speeding up git commands

[...]

> > We already have the second inequality (f(u) <= f(v)) where the function
> > 'f' is the generation of v. The success of this approach over generation
> > numbers relies entirely on how often the inequality min_graph(v) <= post(u)
> > fails when gen(u) <= gen(v) holds.
>
> True.  It may turn out that additional negative-cut filters do not bring
> enough performance improvements over topological levels or corrected
> commit date (or monotonically increasing corrected commit date) to be
> worth it.
>
> I think they can help in wide commit graphs (many concurrently developed
> branches with many commits and few merges), and when there is orphan
> branch (like 'todo' in the git.git, or 'gh-pages' for storing
> per-project GitHub Pages) that is somehow entangled in query.
>
> >> If for each commit 'v' we would compute and store in the commit-graph
> >> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
> >> that were visited during the part of depth-first search that started
> >> from 'v' (which is the minimum of post-order number for subtree of a
> >> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
> >> Then the following condition is true:
> >>
> >>   if min_tree(v) <= post(u) <= post(v), then 'v' can reach 'u'
> >
> > How many places in Git do we ask "can v reach u?" and how many would
> > return immediately without needing a walk in this new approach? My
> > guess is that we will have a very narrow window where this query
> > returns a positive result.
>
> As I wrote below, such positive-cut filter would be directly helpful in
> performing the following commands:
>
>  - `git merge-base --is-ancestor`
>  - `git branch --contains`
>  - `git tag --contains`
>  - `git branch --merged`
>  - `git tag --merged`
>
> It would be also useful for tag autofollow in git-fetch; is is N-to-M
> equivalent to 1-to-N / N-to-1 `--contains` queries.
>
> I am quite sure that positive-cut filter would make `--ancestry-path`
> walk faster.
>
> I think, but I am not sure, that positive-cut filter can make parts of
> topological sort and merge base algorithms at least a tiny bit faster.

Is there an easy way to check that it would provide significant
performance improvements at least in some cases? Can we ask the
student to do that at the beginning of the GSoC?

> > I believe we discussed this concept briefly when planning "generation
> > number v2" and the main concern I have with this plan is that the
> > values are not stable. The value of post(v) and min_tree(v) depend
> > on the entire graph as a whole, not just what is reachable from v
> > (and preferably only the parents of v).
> >
> > Before starting to implement this, I would consider how such labels
> > could be computed across incremental commit-graph boundaries. That is,
> > if I'm only adding a layer of commits to the commit-graph without
> > modifying the existing layers of the commit-graph chain, can I still
> > compute values with these properties? How expensive is it? Do I need
> > to walk the entire reachable set of commits?
>
> I think it would be possible to compute post(v) and min_tree(v) using
> incremental updates, and to make it compatibile with incremental
> commit-graph format (with the commit-graph chain).  But I have not
> proven it.

Would it be difficult to prove? What would be required? And again can
we ask the student to do that at the beginning of the GSoC?

[...]

> > The point of generation number v2 [1] was to allow moving to "exact"
> > algorithms for things like merge-base where we still use commit time
> > as a heuristic, and could be wrong because of special data shapes.
> > We don't use generation number in these examples because using only
> > generation number can lead to a large increase in number of commits
> > walked. The example we saw in the Linux kernel repository was a bug
> > fix created on top of a very old commit, so there was a commit of
> > low generation with very high commit-date that caused extra walking.
> > (See [2] for a detailed description of the data shape.)
> >
> > My _prediction_ is that the two-dimensional system will be more
> > complicated to write and use, and will not have any measurable
> > difference. I'd be happy to be wrong, but I also would not send
> > anyone down this direction only to find out I'm right and that
> > effort was wasted.
>
> That might be a problem.
>
> This is a bit of a "moonshot" / research project, moreso than others.
> Though it would be still valuable, in my opionion, even if the code
> wouldn't ultimately get merged and added into Git.

I agree that it feels like a "moonshot" / research project.

> > My recommendation is that a GSoC student update the
> > generation number to "v2" based on the definition you made in [1].
> > That proposal is also more likely to be effective in Git because
> > it makes use of extra heuristic information (commit date) to
> > assist the types of algorithms we care about.
> >
> > In that case, the "difficult" part is moving the "generation"
> > member of struct commit into a slab before making it a 64-bit
> > value. (This is likely necessary for your plan, anyway.) Updating
> > the generation number to v2 is relatively straight-forward after
> > that, as someone can follow all places that reference or compute
> > generation numbers and apply a diff
>
> Good idea!  Though I am not sure if it is not too late to add it to the
> https://git.github.io/SoC-2020-Ideas/ as the self imposed deadline of
> March 16 (where students can start submitting proposals to GSoC) has
> just passed.  Christian, what do you think?

Would that be a different project idea or part of your "Graph labeling
for speeding up git commands" project idea?

I am very reluctant to add new project ideas at that time. I don't
think student will have time to properly research it and get it
reviewed.

It could be part of your research project though, to check if that
approach is better or good enough compared to what you suggest in the
current version of your project.

> Would you agree, Stolee, to be a _possible_ mentor or co-mentor for
> "Generation number v2" project?

At this point I think it might be best if you are both willing to
co-mentor a "moonshot" / research project to find what is the best way
forward by bench-marking the different approaches that you both
suggest for different commands/use cases.
