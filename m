Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46CC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24FEF23B08
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 18:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgLPSie (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 13:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbgLPSie (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 13:38:34 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC88C061794
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:37:53 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id l207so28662885oib.4
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 10:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RkCeSsRrRxmpJEbtSEpyHwcifrCFEh70vSHLib0asT4=;
        b=nTdGyBEZOoPJJqoRT25im/rNytntGbDty3EII8iq/npXkIEyWjmcmU8wvLgZjD87n9
         tBaFgt9Rktxjt/MghtYM7McKvPklMB/Gdbl/BNwFcFrpr+TX7HoFRHfayKWlfPbkGmIu
         g7JF1tTziOPhs2w3HsZhrKATYpqD1M7vPAPEg8uv8+RbiaedQN+mfqGBrZiOa0kz6odJ
         YpTi+rvV8Q5bXEw17V3yORSTOdLQEuTo1uoKh6uRnlJFef077JdQCiTCmELU2luxuAHa
         KeV0ge0lPE8QSXPnVp8nXGe0//YpyDG6IvIAxnFLhLua4fBUTBQfECp2X01lEhH1JhQt
         GlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RkCeSsRrRxmpJEbtSEpyHwcifrCFEh70vSHLib0asT4=;
        b=O8yHWyV/2vixtOYnzihT3eRd6gCb3RwI6PnbCPYN1CvlqkOpKjmEEpfnTg9gX0DT6p
         oMsz/05US+LNjEVOd5J6sp0DsOBV8CrQ+j1AqL8KZv8rGAHEmNjlWvRbJ3lZasQklFUq
         R/d3dco/4rCY4bKIz7XcAg+wl+mFapk4H01sG/qEvjzqCbzq5lFfPa/AjjeekLQZ14oa
         lULBoP6YSeEdTIdN/FFiJD3NMJVUD+MK3pkoWwCaBUD32CUeCgEO/LqkMPmsHaN2Jmio
         MnvM6lHqwDMGacXaemloEQ0LA/XcSeyZvHoRTtlgjc3JzCMS6HCGYckjswsHXEW5alYJ
         rOqw==
X-Gm-Message-State: AOAM530ZXcwNfEaDRmbH5qs0Zji2oYrIaBrkS7vwW03ywvFSL2pQBH4h
        7fx6+wFFns5dfB3S7TiAGqGLhBSANfOSqceQa8s=
X-Google-Smtp-Source: ABdhPJy7Q1st3l4k+4lqNjINR+7h2iywtV4cuhEPbei3P065UqFOy+Kq85RoExKm5P3fXbGmzB5rahYPyiE59NrvCiw=
X-Received: by 2002:aca:3151:: with SMTP id x78mr2722108oix.39.1608143873238;
 Wed, 16 Dec 2020 10:37:53 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <pull.814.v2.git.1608097965.gitgitgadget@gmail.com> <d8f79450a40e5a91b401ccbbedc7326cfe8a33d6.1608097965.git.gitgitgadget@gmail.com>
 <xmqqeejp4o8d.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqeejp4o8d.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Dec 2020 10:37:41 -0800
Message-ID: <CABPp-BFr=1iVY739cfh-1Hp82x-Mny-k4y0f3zZ_YuP3PxiGfQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] merge-ort: implement merge_incore_recursive()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 16, 2020 at 10:09 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     /*
> > +      * merge_incore_nonrecursive() exists for cases where we always
> > +      * know there is a well-defined single merge base.  However,
> > +      * despite a similar structure, merge-recursive.c noted that some
> > +      * callers preferred to call the recursive logic anyway and still
> > +      * set a special name for opt->ancestor that would appear in
> > +      * merge.conflictStyle=diff3 output.
>
> Sorry, I do not understand the comment, especially the "anyway"
> part.  There is no such thing as nonrecursive variant of
> merge-recursive, is it?  If somebody wanted to perform a merge of

There is absolutely a nonrecursive variant; it's called merge_trees()
in merge-recursive.[ch] and merge_incore_nonrecursive() in
merge-ort.[ch].

Note that I called out the nonrecursive variant at the beginning of
the comment.  Perhaps I should have said "recursive variant" rather
than "recursive logic"?

> two trees with a designated single common ancestor ("am -3" would
> want to do so using a fabricated tree, "cherry-pick" would want to
> do so using the parent commit of what gets picked), it would be
> natural to call "git merge-recursive O -- A B" if it is a scripted
> Porcelain, or would call merge_recursive() with the single merge
> base on the merge_bases commit_list parameter if it is written in C,
> I would think.

cherry-pick/sequencer uses merge_trees() or
merge_incore_nonrecursive().  In other words, the non-recursive API.

git-am uses merge_recursive_generic(), a weird wrapper that calls
merge_recursive() [whose analogue in merge-ort would be
merge_incore_recursive()].  It always passes in exactly one merge
base, though.  And the label for the "ancestor" commit in diff3 output
would default to showing some fake commit ID, if it weren't for the
ability to override the ancestor label in that case.

> > +      * git-am was one such example (it wanted to set opt->ancestor to
> > +      * "constructed merge base", since it created a fake merge base);
> > +      * it called the recursive merge logic through a special
> > +      * merge_recursive_generic() wrapper.
> > +      *
> > +      * Allow the same kind of special case here.
> > +      */
>
> In any case, the mention of "constructed merge base" may explain
> very well why the assert in the previous iteration checked for the
> string, but it does not seem relevant after the condition changed.

Sure, the question in the last iteration was "why check for this
string", but there's a new question with this iteration: who would
pass a special opt->ancestor and with what kind of meaning.  Providing
an example thus provides an answer to that question and gives people
an easy way to search for more information.

> > +     int num_merge_bases_is_1 = (merge_bases && !merge_bases->next);
> > +     assert(opt->ancestor == NULL || num_merge_bases_is_1);
>
> The above comment may have explained why some callers that call the
> machinery with a single merge base want to use its own diff3 label,
> but the assert the comment applies to is stricter than that.
>
> In other words, it is unclear why the caller is forbidden from
> giving the diff3 label, when the recursive merge needs to synthesize
> the virtual ancestor using all the given merge bases?
>
> The answer could be a simple "opt->ancestor field is managed by the
> recursive machinery itself when it needs to create virtual ancestor,
> and must start as NULL, but when we do not create virtual ancestor,
> it is allowed to start with any value, as the machinery itself does
> not assign any new value to the field", but I cannot read if that is
> the case from the comments in the patch.

Yeah, you're making me lean towards thinking that
merge_recursive_generic() is just a broken API that I shouldn't port
over (even as a wrapper), and that I further shouldn't support using
the merge_ort_recursive() API in a fashion wanted by that function.

I'll just toss the single-merge-base check along with the laborious comment.

To clarify, though, your comment above is mostly correct but is off in
the case where there is no need to create a virtual ancestor.
merge_incore_recursive() does assign a label in that case (if one is
not already assigned) -- and that label is just a unique abbreviation
of the relevant commit.  That's a great label when the merge base is a
"real" commit, less so when it's fake/constructed.

But we already have a merge_incore_nonrecursive() that allows (in
fact, requires) setting the ancestor label, so we should probably just
shift merge_recursive_generic() callers who have a special ancestor to
go through that API instead.

> > +
> > +     merge_start(opt, result);
> > +     merge_ort_internal(opt, merge_bases, side1, side2, result);
> >  }
> > diff --git a/merge-ort.h b/merge-ort.h
> > index 55ae7ee865d..d53a0a339f3 100644
> > --- a/merge-ort.h
> > +++ b/merge-ort.h
> > @@ -34,6 +34,16 @@ struct merge_result {
> >  /*
> >   * rename-detecting three-way merge with recursive ancestor consolidation.
> >   * working tree and index are untouched.
> > + *
> > + * merge_bases will be consumed (emptied) so make a copy if you need it.
> > + *
> > + * NOTE: empirically, the recursive algorithm will perform better if you
> > + *       pass the merge_bases in the order of oldest commit to the
> > + *       newest[1][2].
> > + *
> > + *       [1] https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet/
> > + *       [2] commit 8918b0c9c2 ("merge-recur: try to merge older merge bases
> > + *           first", 2006-08-09)
> >   */
>
> I initially thought that this was a bit out-of-place for the comment
> that explains why the merge bases list gets reversed in the code, but
> it is actually the right place---it guides the callers that hand a
> list of merge_bases to the function.
>
> >  void merge_incore_recursive(struct merge_options *opt,
> >                           struct commit_list *merge_bases,
>
> Thanks.
