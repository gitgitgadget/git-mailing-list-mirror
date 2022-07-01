Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61B5C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 04:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiGAE13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 00:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiGAE11 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 00:27:27 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B657344F8
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:27:26 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z19so1404295edb.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 21:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVabxx3kkCHqxvVo0239QFn8nS8o8/wyo30+TnR+Qc4=;
        b=c3BsEYVTPfWlPngM1zcTJ2cXrQZvIqHAHL4ldkZaDL2eJvOyK1Ddhq1PPqvipgpuXv
         uNir0IUJCl2VBUCpBwASpe7o7TWCnjif8LAq8R8nGroSW9N2POXjuZo9kEg1EuC7EXKq
         n/1kgW0wQqyfxsCOfBN3u7R6lfdfiR4f+lRfIKxrexMlT5UzLIMrRuWRUhEACsdLyu7+
         iGGUVrdaIkg5K4Ul3Wk+8QcY7AtrUzw1eeRcQgU78jFZBv7c47uBedulKRZsokpIcVJJ
         sZo+iCmOBHtpggs0YtiJ3rkyoiwWBswSkVc3ohThcjSO2iu/MfIsXaOAKbeCK6nwulvm
         23zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVabxx3kkCHqxvVo0239QFn8nS8o8/wyo30+TnR+Qc4=;
        b=CngObDuWa+rAQufOUqoROTZxBexjggxhL2OPkPQUr8hMdbQMhYgois9VEocteE0YVL
         LN30bwQndIVNHEboT2N82A5w87/jPdN+6bWi0Y/AfovTBJBUlWqfoiMiKghCHJDOhQpc
         I0QWdtqbEbQUaBYt8O3IcfgZeUBJXwAru8jTbBDev/HXw5SGY5YHuEYFpNHX6qwgsimc
         Ff6NxajQyRftooAme3xVwoU5IJ8axewW+sHxzU5Tc8bmFlLB5BArg9eFLQ62UMpk1WVc
         7WLjBj3PGkTpfkQtV2Q3MRL7Q7lKtKmf4XzixIShYt6/Hj+2K5PbdQZNhZ5kC6mlcQPS
         oiBg==
X-Gm-Message-State: AJIora8zTqpKRDlJyaPabRcZHOV5NIIMJ8XE2uD21HIvoxhTXddfjmTO
        jCEuvDWG++CGZRKkYU60MefJPMjCjwM8V2cRjLKvnzGrwkc=
X-Google-Smtp-Source: AGRyM1sEv3i0zG6zUSfU61mkxvjxPx9n9LZo4W5K2OVRUZIRy7lIl02/Ke2aOaj+IPH5R3RQc4LminVFc7+02SWTyuA=
X-Received: by 2002:a05:6402:4242:b0:437:7771:982c with SMTP id
 g2-20020a056402424200b004377771982cmr16754327edb.146.1656649644657; Thu, 30
 Jun 2022 21:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <CABPp-BEXQNWCPXr31Oo59577kzoSbfDV=7_7dN8n6KMTsVgsjg@mail.gmail.com>
 <20220630194833.1191949-1-calvinwan@google.com>
In-Reply-To: <20220630194833.1191949-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Jun 2022 21:27:13 -0700
Message-ID: <CABPp-BE0qGwUy80dmVszkJQ+tcpfLRW0OZyErymzhZ9+HWY1mw@mail.gmail.com>
Subject: Re: [PATCH v3] submodule merge: update conflict error message
To:     Calvin Wan <calvinwan@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 30, 2022 at 12:48 PM Calvin Wan <calvinwan@google.com> wrote:
>
> > > Failed to merge submodule <submodule>
> > > CONFLICT (submodule): Merge conflict in <submodule>
> > > Automatic merge failed; recursive merging with submodules is currently
> > > not supported. To manually complete the merge:
> > >  - go to submodule (<submodule>), and merge commit <commit>
> >
> > I'm still a little unsure on this.  The merge_submodule() logic we
> > have may not have detected a merge commit that merges the two branches
> > together, but that doesn't automatically imply a new merge must be
> > created in the submodule to resolve this conflict.  There might be
> > various reasons that other existing commits in the submodule could be
> > used as the "correct" update.
> >
> > Perhaps that is uncommon enough to not be worth mentioning; I'm just a
> > little hesitant to treat the merge_submodule() logic as robust and
> > finding the only choices users might want to use.  If we do keep the
> > wording as-is, it might be nice to at least discuss in the commit
> > message why we chose that and ignored the or-update-submodule option
> > in this case.
>
> You make a good point about merge_submodule() possibly not finding all
> of the right choices -- I'll add back the or-update-submodule option
> back.
>
> > > If this is correct simply add it to the index for example
> > > by using:
> > >
> > >   git update-index --cacheinfo 160000 <commit> "<submodule>"
> > >
> > > which will accept this suggestion.
> >
> > The last few lines above will no longer be part of the output once
> > en/merge-tree is merged; see commit a4040cfa35 (merge-ort: remove
> > command-line-centric submodule message from merge-ort, 2022-06-18).
>
> ack
>
> > > CONFLICT (submodule): Merge conflict in <submodule>
> > > Recursive merging with submodules is currently not supported.
> > > To manually complete the merge:
> > >  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
> >
> > Again, I'm hesitant to treat the suggestions from merge_submodule() as
> > the only possibilities.  For example, perhaps the user will want to
> > pick a commit that contains one of the ones found by merge_submodule()
> > in its history -- perhaps because the newer commit they want to select
> > contains an important bugfix for an issue not discovered at the time
> > of the merge in the submodule.
> >
> > Also, I'm worried your sentence may be easy to misunderstand, due to
> > it being ambiguous whether "merge" is a verb or an adjective.  More
> > precisely, your sentence could be read as "update the submodule to a
> > possible commit above, or update the submodule to merge commit
> > <commit>" and then users say, "But <commit> isn't a merge commit; why
> > does this message claim it is?  Do I just update the submodule to that
> > commit anyway?"  Or perhaps users just update it to <commit> without
> > even checking to find out that it's not a merge commit, with the
> > deleterious consequences of missing all the important changes
> > currently found in the submodule.

I probably should have mentioned that listing "merge" first and
"update" second in your instructions at least avoids the ambiguity
because it makes it clear that "merge" is a verb that way:

    - go to submodule (<submodule>), and either merge commit <commit>
or update the submodule to a possible commit above

> I agree this sentence can be misinterpreted. I also think the main
> reason my current message is unclear is because there is not enough
> context for the user to understand why the merge failed. In a standard
> merge, the reason in "CONFLICT (<reason>)" provides context, whereas in
> this case, "CONFLICT (submodule)" only tells the user that the submodule
> is conflicted in some way. The user is unaware that we attempted to
> fast-forward the submodule, failed, and now require the user to either
> update the commit or merge the commit. How does this rewording sound?

Do they need to know what we attempted?  I'm not sure why that
matters, beyond maybe telling them that actual automatic merging of
submodules is currently only done by Git's merging machinery in very
trivial cases.  All that should really matter at this point is that
there was a submodule modified on both sides of history, and we need
them to handle the merge of the submodule.

>  Automatic merge failed; recursive merging with submodules currently
>  only supports fast-forward merges. For each conflicted submodule, if

I'd rather substitute "trivial cases" instead of "fast-forward
merges".  For example, we handle deletions on both sides, it's just
that that's done before it ever gets to merge_submodule().  And if we
add more types of special cases beyond fast-forwards at some point,
it'd be nice to not need to update this text.

>  the current commit does not reflect the desired state, either update or
>  merge the commit. This can be accomplished with the following steps:

Maybe replace the last two sentences with "Please manually handle the
merging of each conflicted submodule; this can be accomplished with
the following steps:"

>  - go to submodule (<submodule>), and either update the commit or merge commit <commit>

What would you think of switching this to

   - go to submodule <submodule>, and either merge commit <commit> or
update to an existing commit which has merged those changes such as
one of the ones listed above

> > >  - come back to superproject, and `git add <submodule>` to record the above merge
> >
> > "...to record the above merge or update"?
>
> will... "update" haha

:-)

> > > If git detects multiple possible merge resolutions, the following is printed:
> > >
> > > --------
> > >
> > > Failed to merge submodule sub, but multiple possible merges exist:
> > >     <commit> Merge branch '<branch1>' into <branch2>
> > >     <commit> Merge branch '<branch1>' into <branch3>
> > >
> > > CONFLICT (submodule): Merge conflict in <submodule>
> > > Recursive merging with submodules is currently not supported.
> > > To manually complete the merge:
> > >  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
> >
> > Same issues as I mentioned above for the single-merge-resolution-found case.
> >
>
> ditto
>
> > >  - come back to superproject, and `git add <submodule>` to record the above merge
> >
> > "merge or update", right?
>
> ditto
>
> > > +ret:
> > > +       if (!ret) {
> > > +               if (!csub) {
> > > +                       CALLOC_ARRAY(csub, 1);
> > > +               }
> > > +               csub_item.oid = *result;
> >
> > Shouldn't this be "*b" rather than "*result"?
>
> Yes it should
>
> >
> > Also, are we risking telling the user to "merge commit
> > 0000000000000000000000000000000000000000" from the submodule, given
> > some of the early exits that you redirected to come through here?
>
> You are correct, but I'm not quite sure what should happen in this case. What does it mean for either o, a, or b to be null? Did a submodule get deleted on one side?

o is the version in the merge-base, a is the version from the first
parent (thus the submodule version stored within HEAD), and b is the
version from the second parent (thus the submodule version stored
within the main module's MERGE_HEAD commit).

We can't have all three be null, because that would just mean there
was never a submodule at this path.

We can't have two of the three be null, because that would either be
deleted on both sides, or added on one side, and those cases are
trivially resolvable elsewhere in the merge machinery and there's no
need to call merge_submodule().

If o is null, the submodule didn't exist in the merge base.  So it
must be added on both sides (and the two sides have to have different
submodule commits, or the merge of the submodule would be trivially
handle-able elsewhere).

If a is null, it didn't exist in HEAD, meaning it was deleted on our
side of history.  (And b has to be different than o, or else this
would be trivially resolvable as a deletion.)

If b is null, then it's similar to the above case, but the submodule
was deleted on the other side of history that we are trying to merge
into HEAD rather than on HEAD's side of history.

However, now that I've said this, I took another look through the
code.  I think this actually isn't relevant right now.
merge_submodule() is only called from handle_content_merge(), which in
turn is only called from two places: (1) process_renames(), and (2)
the filemask >= 6 section of process_entry().  The process_renames()
cases, since we can't detect renames involving submodules, can't
involve a case with a null oid for a submodule.  And the filemask >= 6
implies that only o could have a null hash.  That means the checks for
a and b being null oids within merge_submodule will never trigger.
And we don't actually run the risk of telling users to merge the all
null commit.

Any time we have a modify/delete issue with submodules, we'll just end
up at the codepath that reports "CONFLICT (modify/delete): ...", and
which doesn't mention anything about the path being a submodule, but
it really doesn't need to; the text is accurate regardless.


> > > +void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub) {
> >
> > Maybe just make this function be static?
>
> It should be static now that this won't be called in merge-recursive
>
> > > +                                       find_unique_abbrev(&id, DEFAULT_ABBREV));
> >
> > Shouldn't this be repo_find_unique_abbrev(), and in particular with
> > the submodule repository being passed to it?  Or perhaps using the
> > format_commit() function, since merge_submodule() is already using it
> > for the earlier submodule-related messages?
>
> It should and I will go with the format_commit() option so I don't have to pass subrepo information into the print function.
>
> > >  void merge_switch_to_result(struct merge_options *opt,
> > >                             struct tree *head,
> > >                             struct merge_result *result,
> > > @@ -4324,6 +4367,8 @@ void merge_switch_to_result(struct merge_options *opt,
> > >                 }
> > >                 string_list_clear(&olist, 0);
> > >
> > > +               print_submodule_conflict_suggestion(opt->conflicted_submodules);
> > > +
> > >                 /* Also include needed rename limit adjustment now */
> > >                 diff_warn_rename_limit("merge.renamelimit",
> > >                                        opti->renames.needed_limit, 0);
> > > diff --git a/merge-recursive.c b/merge-recursive.c
> > > index fd1bbde061..311cc37886 100644
> > > --- a/merge-recursive.c
> > > +++ b/merge-recursive.c
> >
> > Is it worth updating merge-recursive.c here?  I'd rather only give it
> > security fix updates until we delete it.
>
> Ah wasn't aware that was the status of merge-recursive. Will delete.
>
> > > diff --git a/merge-recursive.h b/merge-recursive.h
> > > index b88000e3c2..b615955fb7 100644
> > > --- a/merge-recursive.h
> > > +++ b/merge-recursive.h
> > > @@ -9,6 +9,7 @@ struct object_id;
> > >  struct repository;
> > >  struct tree;
> > >
> > > +struct conflicted_submodule_list;
> > >  struct merge_options_internal;
> > >  struct merge_options {
> > >         struct repository *repo;
> > > @@ -51,6 +52,21 @@ struct merge_options {
> > >
> > >         /* internal fields used by the implementation */
> > >         struct merge_options_internal *priv;
> > > +
> > > +       /* field that holds submodule conflict information */
> > > +       struct conflicted_submodule_list *conflicted_submodules;
> >
> > I think this should be added to merge_options_internal rather than to
> > merge_options.  There's no need for an API caller to make use of
> > these.
> >
> > Also, if a clear need arises later for API callers to make use of this
> > information, then it should be part of merge_result for merge-ort.c,
> > not part of merge_options.
>
> ack
>
> > > +};
> > > +
> > > +struct conflicted_submodule_item {
> > > +       struct object_id oid;
> > > +       char *path;
> > > +       int resolution_exists;
> > > +};
> > > +
> > > +struct conflicted_submodule_list {
> > > +       struct conflicted_submodule_item *items;
> > > +       size_t nr;
> > > +       size_t alloc;
> > >  };
> >
> > Similarly, I think these should be defined in merge-ort.c (and maybe
> > also merge-recursive.c) near struct merge_options_internal.
>
> ack
>
> > >  void init_merge_options(struct merge_options *opt, struct repository *repo);
> > > @@ -122,4 +138,6 @@ int merge_recursive_generic(struct merge_options *opt,
> > >                             const struct object_id **merge_bases,
> > >                             struct commit **result);
> > >
> > > +void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub);
> >
> > and I think there's no reason to put this in the header file; it
> > should just be a static function in merge-ort.c.  (And, if we really
> > want to update merge-recursive.c, then copy the function over there.
> > *Nothing* in merge-ort.c should call a function in merge-recursive.c
> > and similarly nothing in merge-recursive.c should call any function in
> > merge-ort.c.  Yes, that implies some duplication.  There is a fair
> > amount already and we've discussed it, and chosen against creating a
> > shared module as well.  I want merge-recursive to not be broken by
> > merge-ort updates; it should remain stable until the day we finally
> > get to nuke it.  I'm personally of the opinion that merge-recursive
> > should only get security fixes at this point, though I haven't pinged
> > to see if other folks agree with that point of view yet or not.  I'm
> > not wasting my time fixing/improving it, though...)
>
> Good to know going forward I should only update merge-ort (unless for security fixes). I'll keep this in mind refactoring my patch.
>
> > Despite my many nitpicks and whatnot, it looks like your change will
> > make things nicer for the user, and I think your patch is coming along
> > nicely.  There are some things to fix up, but the overall direction
> > seems good.
>
> Thank you for all of the helpful feedback!
