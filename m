Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7C0C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 04:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61B8F2310F
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 04:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbgLPEKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 23:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725274AbgLPEKH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 23:10:07 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E85C0613D6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 20:09:27 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id l207so26024304oib.4
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 20:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9r6HO9Q7SrKeHT4hLljJDm1ox05HknbBYm/4U8Jtnso=;
        b=HFyxOAwuamsQsGvAatC/1kymBugLmG9dVMlux8zusSa8uPYlBHBxTpTE8rIyzmR/KJ
         p0Cyr5LtrRW6/uYcWt/4dcDNtZzxGevsqvjEFAlWKnFzX/uKXA3/w7tSAJOCdJTXnroh
         IbDatl5L9cagDZgUyIuk+eWDLUZ6FbjOj34hfoy7suMeP2oz6aNGDReikB2qzIbhnXPO
         4KHRR0oMw6Ka6j8HnMBzbz4Lniz34x4lqXoVYH0g1vntxPsCj860Np1nZwG6f3xs6zyF
         esyuuk6GAA8oQfbe7TDlZiyicwmOuMN96cIpflLWAwVWJQyu+BOzTbdymOoNnuVqkxaJ
         kA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9r6HO9Q7SrKeHT4hLljJDm1ox05HknbBYm/4U8Jtnso=;
        b=gmBj2rjlLFPdgb9fmWqyA1ZBK+Q9XmLN8/VNlghKtyLFmmWgdiSBssb43pFDK3urYS
         wE5jfZL9XG9xdOJXtNoUrlpc/CuFMl/3ZD2m/ICmU826Vwdnr46twbMjYsFOs/fklqvc
         LV5iG3qMsdNIKtg5kWPprKu3kZ3XgRxD6Ig0Bpc1bqdr8ggW7wRbdl1YJzYTxvZaUTLK
         VUUlUkq9EIIhX9sDim2TUZg8/dQA3fYJ64hGtWy3ISt6NSKlV/MVdp5yHw1Y3FGVeoZ2
         RvhkhJuPRFrdDS5SBFIxxkCXckuiWo+ty3RB4/D0w/IUDlUGUfR+sgAD81hwAmNLbcWS
         iXSw==
X-Gm-Message-State: AOAM533HF5IrnRuSkbTluMCNc/Rm+5JHijMEI0MbniieERmq45rxM1KH
        NbKQwfXK/246vHvFLp8xPUYc9uSWZJhS4QZArXO5eEjNlg03Qg==
X-Google-Smtp-Source: ABdhPJzLqkAKyLqXfpG3y/x0b8ovTBJ5BHUn0FeHU4nKA4RO4gSLKZrn1vOIMKLlla+QWIM1q0trBLrbNy06BtrVztI=
X-Received: by 2002:aca:e083:: with SMTP id x125mr1099096oig.31.1608091766451;
 Tue, 15 Dec 2020 20:09:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.814.git.1608054807.gitgitgadget@gmail.com>
 <82a773d8972b6641a25b3c84121dd38703a9286c.1608054807.git.gitgitgadget@gmail.com>
 <xmqqbleu5wrs.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbleu5wrs.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 15 Dec 2020 20:09:14 -0800
Message-ID: <CABPp-BHW61zA+MefvWK47iVZKY97rxc2XZ-NjXzuJxEhgSLqUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] merge-ort: implement merge_incore_recursive()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 6:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +/*
> > + * Originally from merge_recursive_internal(); somewhat adapted, though.
> > + */
> > +static void merge_ort_internal(struct merge_options *opt,
> > +                            struct commit_list *merge_bases,
> > +                            struct commit *h1,
> > +                            struct commit *h2,
> > +                            struct merge_result *result)
> > +{
> > +     struct commit_list *iter;
> > +     struct commit *merged_merge_bases;
> > +     const char *ancestor_name;
> > +     struct strbuf merge_base_abbrev = STRBUF_INIT;
> > +
> > +     if (!merge_bases) {
> > +             merge_bases = get_merge_bases(h1, h2);
> > +             merge_bases = reverse_commit_list(merge_bases);
>
> Do we want to say why we reverse here, or is the reason so well
> known why in the original merge-recursive case?

Oh, good point.  After starting on merge-ort, I shifted back and forth
between it and cleaning up merge-recursive for a while...and it looks
like this is one of the things I forgot to copy over.  The reason was
totally opaque to me until Johannes spelled it out over here:
https://lore.kernel.org/git/nycvar.QRO.7.76.6.1907252055500.21907@tvgsbejvaqbjf.bet/

Note that the same reversing of merge bases is done in builtin/merge.c
and sequencer.c as well.  It resulted in me adding the following note
to the declaration of merge_recursive() in merge-recursive.h:

 * NOTE: empirically, about a decade ago it was determined that with more
 *       than two merge bases, optimal behavior was found when the
 *       merge_bases were passed in the order of oldest commit to newest
 *       commit.  Also, merge_bases will be consumed (emptied) so make a
 *       copy if you need it.

but I never copied that comment over to merge_incore_recursive().  I
should do that, and perhaps reference that comment at this point in
the code.

> > +     }
> > +
> > +     merged_merge_bases = pop_commit(&merge_bases);
> > +     if (merged_merge_bases == NULL) {
> > +             /* if there is no common ancestor, use an empty tree */
> > +             struct tree *tree;
> > +
> > +             tree = lookup_tree(opt->repo, opt->repo->hash_algo->empty_tree);
> > +             merged_merge_bases = make_virtual_commit(opt->repo, tree,
> > +                                                      "ancestor");
> > +             ancestor_name = "empty tree";
> > +     } else if (opt->ancestor && !opt->priv->call_depth) {
> > +             ancestor_name = opt->ancestor;
> > +     } else if (merge_bases) {
> > +             ancestor_name = "merged common ancestors";
> > +     } else {
> > +             strbuf_add_unique_abbrev(&merge_base_abbrev,
> > +                                      &merged_merge_bases->object.oid,
> > +                                      DEFAULT_ABBREV);
> > +             ancestor_name = merge_base_abbrev.buf;
> > +     }
>
> So, up to this point we learned:
>
>  - merge bases either given by the caller, or computed from h1 and
>    h2 when the caller just told us to figure it out ourselves.
>
>  - if we have
>
>    - 0 merge base between h1 and h2, in which case we would use an
>      empty tree as an imaginary common
>
>    - 1 merge base between h1 and h2, in which case the common
>      ancestor of the resuting merge between h1 and h2 is that single
>      merge base
>
>    - 2 or more bases, in which case we'd use that would eventually
>      come back when we merged recursively all bases.
>
> and the primary products of the above procedure are
>
>  - ancestor_name (the string used when presenting conflicts while
>    merging h1 and h2)
>
>  - merged_merge_bases (one starting commit among the merge bases)
>
> And then the loop will iterate over the remaining merge bases,
> merging one popped from it in the current merged_merge_bases,
> until we run out.  At that point when we leave the loop, we'd
> have merged_merge_bases that is a virtual commit to be used as
> a single merge base to use while merging trees of h1 and h2.
>
> > +     for (iter = merge_bases; iter; iter = iter->next) {
> > +             const char *saved_b1, *saved_b2;
> > +             struct commit *prev = merged_merge_bases;
> > +
> > +             opt->priv->call_depth++;
> > +             /*
> > +              * When the merge fails, the result contains files
> > +              * with conflict markers. The cleanness flag is
> > +              * ignored (unless indicating an error), it was never
> > +              * actually used, as result of merge_trees has always
> > +              * overwritten it: the committed "conflicts" were
> > +              * already resolved.
> > +              */
> > +             saved_b1 = opt->branch1;
> > +             saved_b2 = opt->branch2;
> > +             opt->branch1 = "Temporary merge branch 1";
> > +             opt->branch2 = "Temporary merge branch 2";
> > +             merge_ort_internal(opt, NULL, prev, iter->item, result);
> > +             if (result->clean < 0)
> > +                     return;
> > +             opt->branch1 = saved_b1;
> > +             opt->branch2 = saved_b2;
> > +             opt->priv->call_depth--;
> > +
> > +             merged_merge_bases = make_virtual_commit(opt->repo,
> > +                                                      result->tree,
> > +                                                      "merged tree");
> > +             commit_list_insert(prev, &merged_merge_bases->parents);
> > +             commit_list_insert(iter->item,
> > +                                &merged_merge_bases->parents->next);
>
> We need to record these parents because...?  When merged_merge_bases
> we just created is used as one side of a merge in the next iteration,
> we'd need to compute the merge base between it and the one we'd pop
> out of merge_bases, and that is why.
>
> > +             clear_or_reinit_internal_opts(opt->priv, 1);
> > +     }
>
> OK.  I think I understood this loop.  It looks mostly straight-forward.
>
> > +     opt->ancestor = ancestor_name;
>
> And the label to be used, that was computed before the above loop,
> is used here...
>
> > +     merge_ort_nonrecursive_internal(opt,
> > +                                     repo_get_commit_tree(opt->repo,
> > +                                                          merged_merge_bases),
> > +                                     repo_get_commit_tree(opt->repo, h1),
> > +                                     repo_get_commit_tree(opt->repo, h2),
> > +                                     result);
>
> ... to finally compute the 3-way merge between h1 and h2.
>
> > +     strbuf_release(&merge_base_abbrev);
>
> And the storage that may have been holding the .ancestor name is
> cleared, as we no longer need it.
>
> > +     opt->ancestor = NULL;  /* avoid accidental re-use of opt->ancestor */
> > +}
> > +
> >  void merge_incore_nonrecursive(struct merge_options *opt,
> >                              struct tree *merge_base,
> >                              struct tree *side1,
> > @@ -1493,7 +1577,9 @@ void merge_incore_recursive(struct merge_options *opt,
> >                           struct commit *side2,
> >                           struct merge_result *result)
> >  {
> > -     (void)reverse_commit_list;
> > -     (void)make_virtual_commit;
> > -     die("Not yet implemented");
> > +     assert(opt->ancestor == NULL ||
> > +            !strcmp(opt->ancestor, "constructed merge base"));
>
> Where does this string come from?  The recursive backend does
> asssign a fixed string with that value to opt->ancestor, but we
> don't expect that string to come here, no?

It's specifically the merge_recursive_generic() function from
merge-recursive.c that sets this, which was part of the
merge-recursive API.  merge-ort does not (yet?) have an equivalent
function (anything calling merge_recursive_generic() just can't use
merge-ort right now -- a list that includes 'am', 'stash', and
'merge-recursive').  For now, I am just letting those callers continue
to use merge-recursive.c.  I never figured out if I wanted to make
that function part of merge-ort's API, whether I just wanted to add a
wrapper to merge-ort-wrappers.[ch] for it, or if I should rewrite the
callers to do something else.

However, looking a little closer, the name for opt->ancestor is
slightly phony -- I think it only makes sense for "am", not for either
of "stash" or "merge-recursive".  Perhaps I should instead count the
number of merge_bases, and assert that either opt->ancestor == NULL
(exclusive)OR  num_merge_bases == 1.  merge_recursive_generic() should
also be made to stop setting opt->ancestor, and then callers like
"am", "stash", and "merge-recursive" should be responsible to provide
a reasonable ancestor name for merge.conflictStyle=diff3 to use when
it's clear they are providing the sole ancestor.

Then at some point I can decide what to do with
merge_recursive_generic().  I'll probably just make it a wrapper at
some point; since that lets me kick the can down the road even
further.  :-)

> > +     merge_start(opt, result);
> > +     merge_ort_internal(opt, merge_bases, side1, side2, result);
> >  }
