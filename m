Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF530C433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CE661264
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 18:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245322AbhDUS4V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 14:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245320AbhDUS4U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 14:56:20 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4721AC06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:55:46 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y4so28172346lfl.10
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Co3UL6GMqxkYFmaSMetRfm9ytC0/HxtWWlqzG4uIIVM=;
        b=PESWwdGIkLapEGYCm5/O09w2AuDhewzdFLcXm8+VjWdLECEveIAtMPBRcCmb0Slj1K
         gtIkwF5nMudzcoCF0FxrQELL8X/467/tIc9izfCP1fp39F7efccr14cThkzioQpli4rF
         pklhzCgaVz/PBASRqHHnpHnuhxVq3Yns0LBEIrFEBwnSXCRG1PwxmNBqXP7oOKNIbIAC
         ISdUU2ZSwDIiFusFHSr0pt9isztZuU6A9MHnQdTANcgi5jDtkH2miCNcJoopuG2BoFfX
         XNodMlSxTkoxTWamPY0AJnbam8nXxSBVCmmQjNn1YSNGXvE83QfPBaLyjBAYvggAAe7m
         +9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Co3UL6GMqxkYFmaSMetRfm9ytC0/HxtWWlqzG4uIIVM=;
        b=tgLdBXDiWpcEc9wt0f38bN8jNI7ri65R/j9pYTErkIaVW8C6bAqz5R3pTJaQ1KaScQ
         oKB9+dYinjS5R5Mu9LCRJI/e9LmumC8zwZJJlDdlmeah1aaPVGdx8PHkM0bd92d4qPdf
         shLXlNvZAt+RiGc+wBJFBsfspefENIYTMF/OBxwi74OwStQ4hKpQ2SlavEv78dg0J3HX
         cIS/IhVs2a7cYiVwsFXBTnR9VaZX6IH9vGmajYS5VkEcfjbLDAU7WC18TgKIeA/0Wklk
         iXyDj++EDZ4L3CYJueAn8YI8Q+aDIar0k0io+9rh4ENsiyAYsYkLhhFQm19U7SEC8Sfy
         saWQ==
X-Gm-Message-State: AOAM532v4lCvwgCjU3Gyz37oPI7is1hQRd/pEfpbCWpL/v0Xn98oSXm1
        aqe8t+VZy0z9BHM4bD7Ifm4RgVJ2FCpfvEcHEfrbwpN5KI5M9Q==
X-Google-Smtp-Source: ABdhPJyfrJMI/UL+kaX7Vu/8IzAWD/UwWof2OKHBZmfP5IdOHqlvxQNDFbTTLn2BVMowJe0JAdatid1IrDiqFcgGFDo=
X-Received: by 2002:ac2:5f64:: with SMTP id c4mr12814097lfc.538.1619031344711;
 Wed, 21 Apr 2021 11:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
 <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com> <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com>
In-Reply-To: <34972851-7d3b-c759-ba87-7022702f74c0@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 21 Apr 2021 15:55:33 -0300
Message-ID: <CAHd-oW76_8D_wu7dixX+2i7-_M3Je=JGk3JonL18yeA5PRrsRg@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 2:27 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 4/20/2021 7:00 PM, Elijah Newren wrote:
> > On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
>
> >> diff --git a/read-cache.c b/read-cache.c
> >> index 29ffa9ac5db9..6308234b4838 100644
> >> --- a/read-cache.c
> >> +++ b/read-cache.c
> >> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
> >>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
> >>                         continue;
> >>
> >> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> >> +                       continue;
> >> +
> >
> > I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
> > !ignore_skip_worktree and why it'd be desirable to refresh
> > skip-worktree entries.  However, this is tangential to your patch and
> > has apparently been around since 2009 (in particular, from 56cac48c35
> > ("ie_match_stat(): do not ignore skip-worktree bit with
> > CE_MATCH_IGNORE_VALID", 2009-12-14)).
>
> I did some more digging on this part here. There has been movement in
> this space!
>
> The thing that triggers this ignore_skip_worktree variable inside
> refresh_index() is now the REFRESH_IGNORE_SKIP_WORKTREE flag which was
> introduced recently and is set only by builtin/add.c:refresh(), by
> Matheus: a20f704 (add: warn when asked to update SKIP_WORKTREE entries,
> 2021-04-08).
>
> This means that we can (for now) keep the behavior the same by adding
>
>         if (ignore_skip_worktree)
>                 ensure_full_index(istate);
>
> before the loop.

Hmm, I don't think we need to expand the index here.
ignore_skip_worktree makes the loop below ignore entries with the
skip_worktree bit set. Since sparse dirs also have this bit set, we
will already get the behavior we want :)

However, I think we will need to expand the index at
`find_pathspecs_matching_against_index()` in order to find and warn
about the pathspecs that have matches among skip_worktree entries...

> This prevents the expansion during 'git status', but
> requires modification before we are ready for 'git add' to work
> correctly. Specifically, 'git add' currently warns only when adding
> something that exactly matches a tracked file with SKIP_WORKTREE. It
> does _not_ warn when adding something that is untracked but would have
> the SKIP_WORKTREE bit if it was tracked. We will need to add that
> extra warning if we want to avoid expanding during 'git add'.

Hmm, I see :( I was trying to think if it would be possible to do the
pathspec matching (for the warning) without having to expand the
index, but then there are the untracked files... If the user gives
"a/*/c" and we have "a/b/" as a sparse dir, we don't know if "a/b/c"
is a skip_worktree entry or an untracked file without expanding the
index...

> Alternatively, we can decide to change the behavior here and send an
> error() and return failure if they try to add something that would
> live within a sparse-directory entry.

I think this behavior would be tricky to replicate on non-sparse-index
sparse-checkouts, if we were to do that. We would have to pathspec
match each untracked file against the sparsity patterns, perhaps?
