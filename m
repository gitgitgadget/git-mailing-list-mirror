Return-Path: <SRS0=62NG=5C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1770DC2BB1D
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D385E20714
	for <git@archiver.kernel.org>; Tue, 17 Mar 2020 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt0W0f3y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgCQREj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:04:39 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44442 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgCQREi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Mar 2020 13:04:38 -0400
Received: by mail-ed1-f43.google.com with SMTP id z3so9870319edq.11
        for <git@vger.kernel.org>; Tue, 17 Mar 2020 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/v6fr1yDS6gkRC5Stwqm7yiV2W/LI6Nzdbc9FVHrLwE=;
        b=Jt0W0f3yjA00vISoTznT7gJDp+ACoMDXQOQKgzavDWQfwligb1Hp1am/S1v5SEssjn
         Y3LzA2YHR9oqVkcNPuudXQG0aQLP2ooOsVMopywdi9vRDNRE+mYc6X3uaklfco+gwAay
         Jp6atmEMhxQo8e5TAjOo3bl2O+hArJU3rrfVBPeApOW5LGyrYukLFVuPaUpso0eB8pgH
         rYwft+G9VMpaAjSxoTk8qx4t+ER2C7p/ppN4MRBl1wTSkcEYcxbxyymIYLeOCmFP01KB
         6e8QS8CAz0xw/No85z3sllvMnyo7pTLTQzYxtCTkbytgoqIm7SU15v2W7xaJanTpg/Ic
         WRBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/v6fr1yDS6gkRC5Stwqm7yiV2W/LI6Nzdbc9FVHrLwE=;
        b=nm0ePuNVzYxFkBKl/4Xi+t5z6+Zp99m8qEIMMZjOkNoQanDPc8jJF6M1a8o5UFQO5G
         N57RGQpQw6qFiuINirw1zBkEDa8uqOs7zJKET0HqdamMPgsepUxIwZJd/Ngp5nDS9TWK
         2T43pD6r7MIMu0F+Xg4PwTtdc6hruj4Ffv8apiok03UpLZgMqk0rWX6GNzjIEJu+DubT
         QUe6f2KqbFDamnniiCo/mp0C8hNaERuMbDvWmITpIWn3ffaRs21judc9KYTKh0MwW4FK
         D/07krLMqMWB2kqO4cAPUg8t1V2a2o8wgenv23ZZw2UiPLW2jTRXKGJQH5Ox90vKSQgV
         YIpA==
X-Gm-Message-State: ANhLgQ2HpSdwt0b4Y1WwAKZ3ETajPRbo2mB20fMwFWLCgmtjhfvH2+yR
        +U5W8H1S3SzOfaxx0o7xwCB9YuSiNpsFA8WzZfs=
X-Google-Smtp-Source: ADFU+vv39K3ig+2DoBHJKT10+IGhpfKqkK6cjEeImVFrQ9HGnjaZ6gFpDWIihmt6V5/v31qnviV9sKmkwaleVbJIkxw=
X-Received: by 2002:a50:b5e5:: with SMTP id a92mr6284052ede.127.1584464675564;
 Tue, 17 Mar 2020 10:04:35 -0700 (PDT)
MIME-Version: 1.0
References: <86mu8o8dsf.fsf@gmail.com> <7d6a84c7-6b16-c2a9-11a1-3397422064d1@gmail.com>
 <86d09b7jx6.fsf@gmail.com> <CAP8UFD3BeS8bj8OGKJmVyKeDTCvqhCpBxLhTwuQ3zffejQkj7g@mail.gmail.com>
 <867dzj6p4y.fsf@gmail.com>
In-Reply-To: <867dzj6p4y.fsf@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 17 Mar 2020 18:04:23 +0100
Message-ID: <CAP8UFD1ihR1PtM2y24HTKa2woGXMVFq9MoVSj1cHVZCNWSH7EA@mail.gmail.com>
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

On Tue, Mar 17, 2020 at 3:18 PM Jakub Narebski <jnareb@gmail.com> wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
> > On Tue, Mar 17, 2020 at 4:13 AM Jakub Narebski <jnareb@gmail.com> wrote:

> >>>> If for each commit 'v' we would compute and store in the commit-graph
> >>>> file two numbers: 'post(v)' and the minimum of 'post(u)' for commits
> >>>> that were visited during the part of depth-first search that started
> >>>> from 'v' (which is the minimum of post-order number for subtree of a
> >>>> spanning tree that starts at 'v').  Let's call the later 'min_tree(v)'.
> >>>> Then the following condition is true:
> >>>>
> >>>>   if min_tree(v) <= post(u) <= post(v), then 'v' can reach 'u'
> >>>
> >>> How many places in Git do we ask "can v reach u?" and how many would
> >>> return immediately without needing a walk in this new approach? My
> >>> guess is that we will have a very narrow window where this query
> >>> returns a positive result.
> >>
> >> As I wrote below, such positive-cut filter would be directly helpful in
> >> performing the following commands:
> >>
> >>  - `git merge-base --is-ancestor`
> >>  - `git branch --contains`
> >>  - `git tag --contains`
> >>  - `git branch --merged`
> >>  - `git tag --merged`
> >>
> >> It would be also useful for tag autofollow in git-fetch; is is N-to-M
> >> equivalent to 1-to-N / N-to-1 `--contains` queries.
> >>
> >> I am quite sure that positive-cut filter would make `--ancestry-path`
> >> walk faster.
> >>
> >> I think, but I am not sure, that positive-cut filter can make parts of
> >> topological sort and merge base algorithms at least a tiny bit faster.
> >
> > Is there an easy way to check that it would provide significant
> > performance improvements at least in some cases? Can we ask the
> > student to do that at the beginning of the GSoC?
>
> The "Reachability labels for version control graphs.ipynb" Jupyter
> Notebook on Google Colaboratory was created to answer this question
> (originally for the FELINE reachability index).  Among others it can
> min-post interval labels and topological levels (generation numbers),
> use them for reachability queries, and load Linux kernel
> commit-graph. The exploration didn't get finished, but it would be not
> that difficult, I think, to at least find the amount of false negatives
> for min-post interval labeling for git.git or Linux kernel repo.
>
>   https://colab.research.google.com/drive/1V-U7_slu5Z3s5iEEMFKhLXtaxSu5xyzg
>
> As Jupyter Notebook, it is run in the web browser.  It can either use
> local runtime, or run on Google Cloud runtime.  On the other hand it
> requires at least some knowledge of Python...

Ok, if that's a possible approach to the project, then please add it
to the description.

> >> I think it would be possible to compute post(v) and min_tree(v) using
> >> incremental updates, and to make it compatibile with incremental
> >> commit-graph format (with the commit-graph chain).  But I have not
> >> proven it.
> >
> > Would it be difficult to prove? What would be required? And again can
> > we ask the student to do that at the beginning of the GSoC?
>
> Formal mathematical proof by induction would be not that difficult.  The
> problem is, I think, in finding all possible classes of initial spanning
> forest arrangements, and all possible classes of commit-graph growth by
> one commit -- and examining how this affect the spanning forest.

Ok.

> >>> The point of generation number v2 [1] was to allow moving to "exact"
> >>> algorithms for things like merge-base where we still use commit time
> >>> as a heuristic, and could be wrong because of special data shapes.
> >>> We don't use generation number in these examples because using only
> >>> generation number can lead to a large increase in number of commits
> >>> walked. The example we saw in the Linux kernel repository was a bug
> >>> fix created on top of a very old commit, so there was a commit of
> >>> low generation with very high commit-date that caused extra walking.
> >>> (See [2] for a detailed description of the data shape.)
> >>>
> >>> My _prediction_ is that the two-dimensional system will be more
> >>> complicated to write and use, and will not have any measurable
> >>> difference. I'd be happy to be wrong, but I also would not send
> >>> anyone down this direction only to find out I'm right and that
> >>> effort was wasted.
> >>
> >> That might be a problem.
> >>
> >> This is a bit of a "moonshot" / research project, moreso than others.
> >> Though it would be still valuable, in my opionion, even if the code
> >> wouldn't ultimately get merged and added into Git.
> >
> > I agree that it feels like a "moonshot" / research project.
> >
> >>> My recommendation is that a GSoC student update the
> >>> generation number to "v2" based on the definition you made in [1].
> >>> That proposal is also more likely to be effective in Git because
> >>> it makes use of extra heuristic information (commit date) to
> >>> assist the types of algorithms we care about.
> >>>
> >>> In that case, the "difficult" part is moving the "generation"
> >>> member of struct commit into a slab before making it a 64-bit
> >>> value. (This is likely necessary for your plan, anyway.) Updating
> >>> the generation number to v2 is relatively straight-forward after
> >>> that, as someone can follow all places that reference or compute
> >>> generation numbers and apply a diff
> >>
> >> Good idea!  Though I am not sure if it is not too late to add it to the
> >> https://git.github.io/SoC-2020-Ideas/ as the self imposed deadline of
> >> March 16 (where students can start submitting proposals to GSoC) has
> >> just passed.  Christian, what do you think?
> >
> > Would that be a different project idea or part of your "Graph labeling
> > for speeding up git commands" project idea?
> >
> > I am very reluctant to add new project ideas at that time. I don't
> > think student will have time to properly research it and get it
> > reviewed.
> >
> > It could be part of your research project though, to check if that
> > approach is better or good enough compared to what you suggest in the
> > current version of your project.
> >
> >> Would you agree, Stolee, to be a _possible_ mentor or co-mentor for
> >> "Generation number v2" project?
> >
> > At this point I think it might be best if you are both willing to
> > co-mentor a "moonshot" / research project to find what is the best way
> > forward by bench-marking the different approaches that you both
> > suggest for different commands/use cases.
>
> So perhaps we should expand "Commit graph labeling for speeding up git
> commands" idea, splitting it into two possible ways of working in this
> project: the more technical 'Generation number v2', and 'Interval labels
> for commit graph' which is more of research project?

Ok for that.

>  Which should be
> put first, then?

Which ever you prefer. If you say that any part could be done
separately, that doesn't matter much.

Best,
Christian.
