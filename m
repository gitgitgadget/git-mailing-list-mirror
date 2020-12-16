Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D472BC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 04:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 930B622D04
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 04:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgLPEpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 23:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgLPEph (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 23:45:37 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C6C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 20:44:57 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id q25so21715379otn.10
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 20:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TV6f8mw7hcv+jKHMrdTx1cAZa6YveC8ctwIzS3FakE4=;
        b=UhitNu8JaLSdRMY3GAg78lumpeAZegWUzCw1o92LH+zIa3qp0UIpdQ4zXKDjTJukP/
         3IN05X/UjoL0vG5GFqM20sZONLvk+WR9aHMETUIQqk2Uxy2n/MC8mhgQbTO0i732y14S
         BhhdUaKt+drGOPwCBo6FS9RjeeNgzaeFnAMuEyLLXt3WL9hIXbI8adyU8uTaXQKLC3r9
         DcLuz8Ik5znMMap/NPdPCYNx6wNX/OeTXvpItTEaXcZtaMgQlLpsBdd7brjRjYLWkm+O
         K/sFQhicq1iDITaZxg7RroCMSgpei8uKvl59Ykbz+VXGreggpwdfaxrTYOacIoemrgMU
         jrjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TV6f8mw7hcv+jKHMrdTx1cAZa6YveC8ctwIzS3FakE4=;
        b=iirnxxNTvMa8BpQ4qYJKWAcwQ94vReS0/j7YIcnP5UIyZg7To1XAfGO1VGDR4rSKyD
         jag4afpeqNXY5B06KMGoQv8qgg/tOFKXVYj8NZLrxpscBSGjt8wRPMawWRY8Nw6tXVUw
         RoeHYWLPugwrG9DjcjBwU1wD1i1gWQPhi5W4F+B3kfaEi9G+1D81dmjD9nCjuTEuxc0p
         ezrufwu7I3qf+SLtXd/eZtSjHv/NF8hL0QUMpB+MUIEnOWSVnYfqOgJ2sZJgHsf9PnBZ
         wkleFuGnIlsx89LCSETrZ2fWt05vBa6RHJWSm40hdMmH1zvxoaQwMpd3coRwmhuFrq2l
         t/OQ==
X-Gm-Message-State: AOAM5336mNVMxRbxmNNidmwgHFl6oedCzgvkfqdaR8ruSYIorg0fFp3Q
        F0Zxa9eloKU/y3T/1whbXfI1Fh7Izsd2TB6ZCcM=
X-Google-Smtp-Source: ABdhPJzRkNZszST43MJiqAGJSVB3YOFs5IaV0yAx0YQX9cav0GOi4P16UIf0MlQ1iwTUsVRd6C7pthEYoQVzRFk+Epk=
X-Received: by 2002:a05:6830:10:: with SMTP id c16mr24686368otp.162.1608093896760;
 Tue, 15 Dec 2020 20:44:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <82a773d8972b6641a25b3c84121dd38703a9286c.1608054807.git.gitgitgadget@gmail.com>
 <xmqqbleu5wrs.fsf@gitster.c.googlers.com> <CABPp-BHW61zA+MefvWK47iVZKY97rxc2XZ-NjXzuJxEhgSLqUw@mail.gmail.com>
In-Reply-To: <CABPp-BHW61zA+MefvWK47iVZKY97rxc2XZ-NjXzuJxEhgSLqUw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Dec 2020 20:44:45 -0800
Message-ID: <CABPp-BEk514YEdgDHmrD-sD7tZ=xnJxfV8cpS9-_qP-xQYTKxQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] merge-ort: implement merge_incore_recursive()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 8:09 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Tue, Dec 15, 2020 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > +/*
> > > + * Originally from merge_recursive_internal(); somewhat adapted, though.
> > > + */
> > > +static void merge_ort_internal(struct merge_options *opt,
> > > +                            struct commit_list *merge_bases,
> > > +                            struct commit *h1,
> > > +                            struct commit *h2,
> > > +                            struct merge_result *result)
> > > +{
> > > +     struct commit_list *iter;
> > > +     struct commit *merged_merge_bases;
> > > +     const char *ancestor_name;
> > > +     struct strbuf merge_base_abbrev = STRBUF_INIT;
> > > +
> > > +     if (!merge_bases) {
> > > +             merge_bases = get_merge_bases(h1, h2);
> > > +             merge_bases = reverse_commit_list(merge_bases);
> >
> > Do we want to say why we reverse here, or is the reason so well
> > known why in the original merge-recursive case?
>
> Oh, good point.  After starting on merge-ort, I shifted back and forth
> between it and cleaning up merge-recursive for a while...and it looks
> like this is one of the things I forgot to copy over.  The reason was
> totally opaque to me until Johannes spelled it out over here:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet/
>
> Note that the same reversing of merge bases is done in builtin/merge.c
> and sequencer.c as well.  It resulted in me adding the following note
> to the declaration of merge_recursive() in merge-recursive.h:
>
>  * NOTE: empirically, about a decade ago it was determined that with more
>  *       than two merge bases, optimal behavior was found when the
>  *       merge_bases were passed in the order of oldest commit to newest
>  *       commit.  Also, merge_bases will be consumed (emptied) so make a
>  *       copy if you need it.
>
> but I never copied that comment over to merge_incore_recursive().  I
> should do that, and perhaps reference that comment at this point in
> the code.
>
> > > +     }
> > > +
> > > +     merged_merge_bases = pop_commit(&merge_bases);
> > > +     if (merged_merge_bases == NULL) {
> > > +             /* if there is no common ancestor, use an empty tree */
> > > +             struct tree *tree;
> > > +
> > > +             tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
> > > +             merged_merge_bases = make_virtual_commit(opt->repo, tree,
> > > +                                                      "ancestor");
> > > +             ancestor_name = "empty tree";
> > > +     } else if (opt->ancestor && !opt->priv->call_depth) {
> > > +             ancestor_name = opt->ancestor;
> > > +     } else if (merge_bases) {
> > > +             ancestor_name = "merged common ancestors";
> > > +     } else {
> > > +             strbuf_add_unique_abbrev(&merge_base_abbrev,
> > > +                                      &merged_merge_bases->object.oid,
> > > +                                      DEFAULT_ABBREV);
> > > +             ancestor_name = merge_base_abbrev.buf;
> > > +     }
> >
> > So, up to this point we learned:
> >
> >  - merge bases either given by the caller, or computed from h1 and
> >    h2 when the caller just told us to figure it out ourselves.
> >
> >  - if we have
> >
> >    - 0 merge base between h1 and h2, in which case we would use an
> >      empty tree as an imaginary common
> >
> >    - 1 merge base between h1 and h2, in which case the common
> >      ancestor of the resuting merge between h1 and h2 is that single
> >      merge base
> >
> >    - 2 or more bases, in which case we'd use that would eventually
> >      come back when we merged recursively all bases.
> >
> > and the primary products of the above procedure are
> >
> >  - ancestor_name (the string used when presenting conflicts while
> >    merging h1 and h2)
> >
> >  - merged_merge_bases (one starting commit among the merge bases)
> >
> > And then the loop will iterate over the remaining merge bases,
> > merging one popped from it in the current merged_merge_bases,
> > until we run out.  At that point when we leave the loop, we'd
> > have merged_merge_bases that is a virtual commit to be used as
> > a single merge base to use while merging trees of h1 and h2.
> >
> > > +     for (iter = merge_bases; iter; iter = iter->next) {
> > > +             const char *saved_b1, *saved_b2;
> > > +             struct commit *prev = merged_merge_bases;
> > > +
> > > +             opt->priv->call_depth++;
> > > +             /*
> > > +              * When the merge fails, the result contains files
> > > +              * with conflict markers. The cleanness flag is
> > > +              * ignored (unless indicating an error), it was never
> > > +              * actually used, as result of merge_trees has always
> > > +              * overwritten it: the committed "conflicts" were
> > > +              * already resolved.
> > > +              */
> > > +             saved_b1 = opt->branch1;
> > > +             saved_b2 = opt->branch2;
> > > +             opt->branch1 = "Temporary merge branch 1";
> > > +             opt->branch2 = "Temporary merge branch 2";
> > > +             merge_ort_internal(opt, NULL, prev, iter->item, result);
> > > +             if (result->clean < 0)
> > > +                     return;
> > > +             opt->branch1 = saved_b1;
> > > +             opt->branch2 = saved_b2;
> > > +             opt->priv->call_depth--;
> > > +
> > > +             merged_merge_bases = make_virtual_commit(opt->repo,
> > > +                                                      result->tree,
> > > +                                                      "merged tree");
> > > +             commit_list_insert(prev, &merged_merge_bases->parents);
> > > +             commit_list_insert(iter->item,
> > > +                                &merged_merge_bases->parents->next);
> >
> > We need to record these parents because...?  When merged_merge_bases
> > we just created is used as one side of a merge in the next iteration,
> > we'd need to compute the merge base between it and the one we'd pop
> > out of merge_bases, and that is why.
> >
> > > +             clear_or_reinit_internal_opts(opt->priv, 1);
> > > +     }
> >
> > OK.  I think I understood this loop.  It looks mostly straight-forward.
> >
> > > +     opt->ancestor = ancestor_name;
> >
> > And the label to be used, that was computed before the above loop,
> > is used here...
> >
> > > +     merge_ort_nonrecursive_internal(opt,
> > > +                                     repo_get_commit_tree(opt->repo,
> > > +                                                          merged_merge_bases),
> > > +                                     repo_get_commit_tree(opt->repo, h1),
> > > +                                     repo_get_commit_tree(opt->repo, h2),
> > > +                                     result);
> >
> > ... to finally compute the 3-way merge between h1 and h2.
> >
> > > +     strbuf_release(&merge_base_abbrev);
> >
> > And the storage that may have been holding the .ancestor name is
> > cleared, as we no longer need it.
> >
> > > +     opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
> > > +}
> > > +
> > >  void merge_incore_nonrecursive(struct merge_options *opt,
> > >                              struct tree *merge_base,
> > >                              struct tree *side1,
> > > @@ -1493,7 +1577,9 @@ void merge_incore_recursive(struct merge_options *opt,
> > >                           struct commit *side2,
> > >                           struct merge_result *result)
> > >  {
> > > -     (void)reverse_commit_list;
> > > -     (void)make_virtual_commit;
> > > -     die("Not yet implemented");
> > > +     assert(opt->ancestor == NULL ||
> > > +            !strcmp(opt->ancestor, "constructed merge base"));
> >
> > Where does this string come from?  The recursive backend does
> > asssign a fixed string with that value to opt->ancestor, but we
> > don't expect that string to come here, no?
>
> It's specifically the merge_recursive_generic() function from
> merge-recursive.c that sets this, which was part of the
> merge-recursive API.  merge-ort does not (yet?) have an equivalent
> function (anything calling merge_recursive_generic() just can't use
> merge-ort right now -- a list that includes 'am', 'stash', and
> 'merge-recursive').  For now, I am just letting those callers continue
> to use merge-recursive.c.  I never figured out if I wanted to make
> that function part of merge-ort's API, whether I just wanted to add a
> wrapper to merge-ort-wrappers.[ch] for it, or if I should rewrite the
> callers to do something else.
>
> However, looking a little closer, the name for opt->ancestor is
> slightly phony -- I think it only makes sense for "am", not for either
> of "stash" or "merge-recursive".  Perhaps I should instead count the
> number of merge_bases, and assert that either opt->ancestor == NULL
> (exclusive)OR  num_merge_bases == 1.  merge_recursive_generic() should

No, this isn't right.  Most callers just grab all the merge bases and
often there happens to be only one.  In such a case, the caller
shouldn't have to set opt->ancestor; the fallback of referencing the
commit id is perfectly good there.  It's just that when there is
exactly one merge base, a special caller like
merge_recursive_generic() might want to override the value for
opt->ancestor.

Anyway, I'll post a new patch soon.

> also be made to stop setting opt->ancestor, and then callers like
> "am", "stash", and "merge-recursive" should be responsible to provide
> a reasonable ancestor name for merge.conflictStyle=diff3 to use when
> it's clear they are providing the sole ancestor.
>
> Then at some point I can decide what to do with
> merge_recursive_generic().  I'll probably just make it a wrapper at
> some point; since that lets me kick the can down the road even
> further.  :-)
>
> > > +     merge_start(opt, result);
> > > +     merge_ort_internal(opt, merge_bases, side1, side2, result);
> > >  }
