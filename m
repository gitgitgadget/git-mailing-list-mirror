Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644B8C433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 08:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CEF610CD
	for <git@archiver.kernel.org>; Wed, 19 May 2021 08:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbhESIjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 04:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238704AbhESIjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 04:39:52 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CD1C061760
        for <git@vger.kernel.org>; Wed, 19 May 2021 01:38:32 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id u25-20020a0568302319b02902ac3d54c25eso11145626ote.1
        for <git@vger.kernel.org>; Wed, 19 May 2021 01:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NILiSlC7OmRE8SUrtFhxq4GIiC0VOGHovpr+Ox+WohM=;
        b=WbSVt89G/iHB0OCWNJ2l0P0qc0JL/zDmnvVn8a4/HQzH7tqYIHHQpcEKMSe+8qwYRU
         aDvBrj2dWCeKhym5a0TKXIta1vT2X0E+MHabPDHZLziNWuvNEnTtQAENECej/uDE2MAg
         LG5FnuSfNF4MITeXdj10WzoQearjriVoI1w7+vnskXZF7e0/l9WKqx0P6BTde8Hu5Cb2
         njmBS4WG86Q9VFEqV1m2IKAtGlxJ7MNlCPJW3TittJGgqSkMmo7RIYzqCMqw1VnBabUC
         jVRQVaKvx5rMCtAPG2Enj3wnHCvIv8NOBsnIsLjtUaMuN6Fck57RBqkJPd5SHqcUYrLV
         WXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NILiSlC7OmRE8SUrtFhxq4GIiC0VOGHovpr+Ox+WohM=;
        b=dZ7o8YTiDy2hg9HYvhJi+lVsqR9ZS5o1bwKNT/wT2Lp9yjhNtQ3c/pe81n/QjHBRnp
         gtox+xmWI80z0qZ8RjxuIEVU+nBuYtTp/hNWjlYa+5mmZrRgWwJCw35cyK4Ca5YEaje+
         9tfSKLrWV2zbMFG8wXGHoT58qWqS8CAJdoD70mN+QV2yJ8/M3lTVJGYmgL9VrLWUBEO5
         C/kcA2FbpLCIdfkuZ0tqvOoJ1UjZZrLEQtn6N+mAVDFvtZA3BFapFqiMVtY7o/vCCM3G
         z5RpfoBu6Z70R5RkvKp/geC/fq1EON+WKnmiED4HJYx7cZHU/1OvVQHm9hwOSO+SzNAc
         6Hhw==
X-Gm-Message-State: AOAM532qiCEZQH8Ri+NULAOW1NUwPxztruE8hRyiTTFci11MD5Ym71GK
        cWtNHbfZB4hjzm+AVCAABKrjBF7eGa1e/12iUEg=
X-Google-Smtp-Source: ABdhPJybjev8XkA+LxvDjXXIxyLjvAU0cgLq7dqXjxrIIDEz6oKfJMBgzgruP71/zSZXuChV+zjsP+z6xQ1C593AUOk=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr7875903otn.162.1621413512180;
 Wed, 19 May 2021 01:38:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <3b42783d4a86473420480b2789d61d8103e6e7d4.1621017072.git.gitgitgadget@gmail.com>
 <CABPp-BGww6VPMmp9dDyRJ2vgNCOdj16-LjU3aM3MM1NQ+T-pmg@mail.gmail.com>
 <a96b5081-e913-22a8-45eb-8d5de432dccb@gmail.com> <f592fa8e-b607-1665-5f2e-3a3ad834b30b@gmail.com>
In-Reply-To: <f592fa8e-b607-1665-5f2e-3a3ad834b30b@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 19 May 2021 01:38:20 -0700
Message-ID: <CABPp-BEnE47iH4zgf4dU-_nby9NCs0s=rOKDOHEqSKiL01A6pQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] wt-status: expand added sparse directory entries
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 12:05 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 5/18/2021 2:26 PM, Derrick Stolee wrote:
> > On 5/17/2021 10:27 PM, Elijah Newren wrote:
> >> On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
> >> <gitgitgadget@gmail.com> wrote:
> >>>
> >>> From: Derrick Stolee <dstolee@microsoft.com>
> >>>
> >>> It is difficult, but possible, to get into a state where we intend to
> >>> add a directory that is outside of the sparse-checkout definition. Add a
> >>
> >> Then we need to fix that; allowing things to be added outside the
> >> sparse-checkout definition is a bug[1][2].  That's an invariant I
> >> believe we should maintain everywhere; things get really confusing to
> >> users somewhere later down the road if we don't.  Matheus worked to
> >> fix that with 'git add'; if there are other commands that need fixing
> >> too, then we should also fix them.
> >>
> >> [1] https://lore.kernel.org/git/CABPp-BFhyFiKSXdLM5q5t=ZKzr6V0pY7dbheierRaOHFbMEdkg@mail.gmail.com/
> >> [2] https://lore.kernel.org/git/CABPp-BF0ZhbSs42R3Bw_r-hbhQ71qtbXSBqXdq0djyaan=8p=A@mail.gmail.com/
> >>
> >>> test to t1092-sparse-checkout-compatibility.sh that demonstrates this
> >>> using a combination of 'git reset --mixed' and 'git checkout --orphan'.
> >>
> >> I think `git checkout --orphan` should just throw an error if
> >> sparse-checkout is in use.  Allowing adding paths outside the
> >> sparse-checkout set causes too much collateral and deferred confusion
> >> for users.
> >
> > I've been trying to strike an interesting balance of creating
> > performance improvements without changing behavior, trying to
> > defer those behavior changes to an isolated instance. I think
> > that approach is unavoidable with the 'git add' work that I
> > pulled out of this series and will return to soon.
> >
> > However, here I think it would be too much to start throwing
> > an error in this case. I think that change is a bit too much.
> >
> > The thing I can try to do, instead of the current approach, is
> > to not allow sparse directory entries to differ between the
> > index and HEAD. That will satisfy this case, but also a lot of
> > other painful cases.
> >
> > I have no idea how to actually accomplish that, but I'll start
> > digging.
>
> It didn't take much digging to discover that this is likely
> impossible, or rather it would be a drastic change to make this
> happen.
>
> The immediate issue is trying to prevent sparse directory entries
> from existing when the contained paths don't match what exists at
> HEAD. However, in the 'git checkout --orphan' case, we are using
> a full index for the unpack_trees() that updates the in-memory
> index according to the paths at HEAD, then updates HEAD to point
> to a non-existing ref. The sparse directories are only created as
> part of convert_to_sparse() within do_write_index(). At that
> point, there is no HEAD provided. Trying to load it from scratch
> violates the fact that HEAD is being staged to change _after_ the
> index updates in a command like 'git checkout'.
>
> So, the drastic change to make this work would be to update the
> index API to require a root tree to be provided whenever writing
> the index. However, that doesn't make sense, either! What do we
> do when in a conflicted state?
>
> What if a user modifies HEAD manually to point to a new ref?
>
> Such a change would couple the index to the concept of HEAD in
> an unproductive way, I think. The index data structure exists
> as a separate entity that is frequently _compared_ to HEAD, and
> the solution presented in this patch presents a way to keep the
> comparison of a sparse-index and HEAD to be the same as if we
> had a full index.
>
> So, after looking into it, I'm back in favor of this change and
> forever allowing sparse cache entries to differ from HEAD,
> because there is no way to avoid it.

Doh, thanks for digging in and entertaining the idea.  I'm worried
we'll get lots of confused users over the years from not being able to
do this, but you do make some good points.

I still think `git checkout --orphan` should be an error when in a
sparse checkout -- the point of a sparse checkout is that you only
care about a subset of files, whereas checkout --orphan fundamentally
says you are throwing away history but care about each and every file
since you are staging "changes" from all of them to include in some
new commit soon.  They just seem in strong opposition to me, and it
seems likely to result in surprises for some of the users when despite
the --orphan request and them fixing up the working directory how they
like, they get some new commit that contains files that aren't in
their working tree.  (In contrast, `git switch --orphan` would
probably be fine in a sparse checkout, precisely because it really
does empty everything).  However, I do agree with you that such a
change belongs in a separate series.  So, yes, your patch is good, and
I'll raise the behavioral change later.

(Sorry for being slow to respond and still not getting to all your
good reviews of my series; I'm a bit limited in my time for git right
now...)
