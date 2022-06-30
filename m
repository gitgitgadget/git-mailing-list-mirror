Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EDEC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 19:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiF3TtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 15:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235847AbiF3Ts4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 15:48:56 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D51B20F49
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 12:48:55 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id jg5-20020a17090326c500b0016a020648bcso130391plb.19
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 12:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=rFH7HKmB2MJKLWi9N/7arbDPDMwjGxzn70yIZTSMkxc=;
        b=DfQM+9Vg+ajMEvvR/xjNTErMcD+V3NDBc6un6yuRjJZRHB0y0KWGVKdt5No7m7M7+M
         9rZWWydpkckxJ49QMtOw1GUVQEyFnXSD6i24fr/0IeoJ/lJdtH0b8T4RdS82v9VV7s0Z
         jhnc6lh+3YkBxgUTAgeK2bxdjdTPH1vnmgCeyfBVona87e4N3Q7pzesOOicbV3mit/rV
         f5pG13EzDfdbzSEi7wI1kFBcVmtvnv7EzJ2GQUcsQdINCH7AY+tsUNiZ3hjzEcNAkKvI
         VRASaJWS+NmwltA6IF1+1eo71NK8fupeTLWlrf1Vf8Ew5bVgwVE1UyfX+3W5InH/tGQR
         VOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=rFH7HKmB2MJKLWi9N/7arbDPDMwjGxzn70yIZTSMkxc=;
        b=MvFsZYX+w9oKNRwh+ggd7L+EQS5evQSC84NxF4eQ2UXzprRwLJwE1AFZbARF8Hezic
         dSvWOCJnyaKXIdOu+NWAFLeyaLkRWbBbAh4m5J1lqm9omUrCn8c2Nqv7gZDuoGs/7Zfv
         WZGo8ggd6HS/qnxAq4s6A6C0D/H9f2+2zzrpm6SlRH5+5CTdhvIAZ5uAYaBi7xnrX7aF
         PHRF4nbcimq7iiA1VM5fl0JRP4Ej/TthvWWkSL33hhE7jOh10nc/6363SgSH/ql3pnP3
         wilgk8N89gxV0QOITyFBsiBt1tSx/NZdKBjF8TKXkL/pURf79Anv5WIhJ1ncawrqdRaD
         rfeA==
X-Gm-Message-State: AJIora/HZIcubkVjOkHp5HvQtYpr5sJwWrAuMnBK7H04NmNTZjCZSjct
        Rtmb1uI3bS5AtNLvCbk0IjduTYM2ij8qU22WqLsfpkthbCTXgD6BAbA3VXyjTSSW28KlWpKDDFy
        MP0BcjAdcXggA1PhQZc1a0zTOovkQTtMa+42CvpklYEJQofKRngA4m+T5CgxOMK/OfQ==
X-Google-Smtp-Source: AGRyM1sMfKJKIQ3o9PxU5eF7pDC3qV3d9ipKCancqjAQyeUW7C6LdjvMmMKygxqJ+AjINvzx7ssiByZGnoc+gwk=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:90b:3146:b0:1ed:4485:1168 with SMTP
 id ip6-20020a17090b314600b001ed44851168mr13752571pjb.245.1656618534881; Thu,
 30 Jun 2022 12:48:54 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:48:33 +0000
In-Reply-To: <CABPp-BEXQNWCPXr31Oo59577kzoSbfDV=7_7dN8n6KMTsVgsjg@mail.gmail.com>
Message-Id: <20220630194833.1191949-1-calvinwan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: Re: [PATCH v3] submodule merge: update conflict error message
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Failed to merge submodule <submodule>
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Automatic merge failed; recursive merging with submodules is currently
> > not supported. To manually complete the merge:
> >  - go to submodule (<submodule>), and merge commit <commit>
> 
> I'm still a little unsure on this.  The merge_submodule() logic we
> have may not have detected a merge commit that merges the two branches
> together, but that doesn't automatically imply a new merge must be
> created in the submodule to resolve this conflict.  There might be
> various reasons that other existing commits in the submodule could be
> used as the "correct" update.
> 
> Perhaps that is uncommon enough to not be worth mentioning; I'm just a
> little hesitant to treat the merge_submodule() logic as robust and
> finding the only choices users might want to use.  If we do keep the
> wording as-is, it might be nice to at least discuss in the commit
> message why we chose that and ignored the or-update-submodule option
> in this case.

You make a good point about merge_submodule() possibly not finding all
of the right choices -- I'll add back the or-update-submodule option
back.

> > If this is correct simply add it to the index for example
> > by using:
> >
> >   git update-index --cacheinfo 160000 <commit> "<submodule>"
> >
> > which will accept this suggestion.
> 
> The last few lines above will no longer be part of the output once
> en/merge-tree is merged; see commit a4040cfa35 (merge-ort: remove
> command-line-centric submodule message from merge-ort, 2022-06-18).

ack

> > CONFLICT (submodule): Merge conflict in <submodule>
> > Recursive merging with submodules is currently not supported.
> > To manually complete the merge:
> >  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
> 
> Again, I'm hesitant to treat the suggestions from merge_submodule() as
> the only possibilities.  For example, perhaps the user will want to
> pick a commit that contains one of the ones found by merge_submodule()
> in its history -- perhaps because the newer commit they want to select
> contains an important bugfix for an issue not discovered at the time
> of the merge in the submodule.
> 
> Also, I'm worried your sentence may be easy to misunderstand, due to
> it being ambiguous whether "merge" is a verb or an adjective.  More
> precisely, your sentence could be read as "update the submodule to a
> possible commit above, or update the submodule to merge commit
> <commit>" and then users say, "But <commit> isn't a merge commit; why
> does this message claim it is?  Do I just update the submodule to that
> commit anyway?"  Or perhaps users just update it to <commit> without
> even checking to find out that it's not a merge commit, with the
> deleterious consequences of missing all the important changes
> currently found in the submodule.

I agree this sentence can be misinterpreted. I also think the main
reason my current message is unclear is because there is not enough
context for the user to understand why the merge failed. In a standard
merge, the reason in "CONFLICT (<reason>)" provides context, whereas in
this case, "CONFLICT (submodule)" only tells the user that the submodule
is conflicted in some way. The user is unaware that we attempted to
fast-forward the submodule, failed, and now require the user to either
update the commit or merge the commit. How does this rewording sound?

 Automatic merge failed; recursive merging with submodules currently
 only supports fast-forward merges. For each conflicted submodule, if
 the current commit does not reflect the desired state, either update or
 merge the commit. This can be accomplished with the following steps:

 - go to submodule (<submodule>), and either update the commit or merge commit <commit>

> >  - come back to superproject, and `git add <submodule>` to record the above merge
> 
> "...to record the above merge or update"?

will... "update" haha

> > If git detects multiple possible merge resolutions, the following is printed:
> >
> > --------
> >
> > Failed to merge submodule sub, but multiple possible merges exist:
> >     <commit> Merge branch '<branch1>' into <branch2>
> >     <commit> Merge branch '<branch1>' into <branch3>
> >
> > CONFLICT (submodule): Merge conflict in <submodule>
> > Recursive merging with submodules is currently not supported.
> > To manually complete the merge:
> >  - go to submodule (<submodule>), and either update the submodule to a possible commit above or merge commit <commit>
> 
> Same issues as I mentioned above for the single-merge-resolution-found case.
> 

ditto

> >  - come back to superproject, and `git add <submodule>` to record the above merge
> 
> "merge or update", right?

ditto

> > +ret:
> > +       if (!ret) {
> > +               if (!csub) {
> > +                       CALLOC_ARRAY(csub, 1);
> > +               }
> > +               csub_item.oid = *result;
> 
> Shouldn't this be "*b" rather than "*result"?

Yes it should

> 
> Also, are we risking telling the user to "merge commit
> 0000000000000000000000000000000000000000" from the submodule, given
> some of the early exits that you redirected to come through here?

You are correct, but I'm not quite sure what should happen in this case. What does it mean for either o, a, or b to be null? Did a submodule get deleted on one side? 

> > +void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub) {
> 
> Maybe just make this function be static?

It should be static now that this won't be called in merge-recursive

> > +                                       find_unique_abbrev(&id, DEFAULT_ABBREV));
> 
> Shouldn't this be repo_find_unique_abbrev(), and in particular with
> the submodule repository being passed to it?  Or perhaps using the
> format_commit() function, since merge_submodule() is already using it
> for the earlier submodule-related messages?

It should and I will go with the format_commit() option so I don't have to pass subrepo information into the print function.

> >  void merge_switch_to_result(struct merge_options *opt,
> >                             struct tree *head,
> >                             struct merge_result *result,
> > @@ -4324,6 +4367,8 @@ void merge_switch_to_result(struct merge_options *opt,
> >                 }
> >                 string_list_clear(&olist, 0);
> >
> > +               print_submodule_conflict_suggestion(opt->conflicted_submodules);
> > +
> >                 /* Also include needed rename limit adjustment now */
> >                 diff_warn_rename_limit("merge.renamelimit",
> >                                        opti->renames.needed_limit, 0);
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index fd1bbde061..311cc37886 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> 
> Is it worth updating merge-recursive.c here?  I'd rather only give it
> security fix updates until we delete it.

Ah wasn't aware that was the status of merge-recursive. Will delete.

> > diff --git a/merge-recursive.h b/merge-recursive.h
> > index b88000e3c2..b615955fb7 100644
> > --- a/merge-recursive.h
> > +++ b/merge-recursive.h
> > @@ -9,6 +9,7 @@ struct object_id;
> >  struct repository;
> >  struct tree;
> >
> > +struct conflicted_submodule_list;
> >  struct merge_options_internal;
> >  struct merge_options {
> >         struct repository *repo;
> > @@ -51,6 +52,21 @@ struct merge_options {
> >
> >         /* internal fields used by the implementation */
> >         struct merge_options_internal *priv;
> > +
> > +       /* field that holds submodule conflict information */
> > +       struct conflicted_submodule_list *conflicted_submodules;
> 
> I think this should be added to merge_options_internal rather than to
> merge_options.  There's no need for an API caller to make use of
> these.
> 
> Also, if a clear need arises later for API callers to make use of this
> information, then it should be part of merge_result for merge-ort.c,
> not part of merge_options.

ack

> > +};
> > +
> > +struct conflicted_submodule_item {
> > +       struct object_id oid;
> > +       char *path;
> > +       int resolution_exists;
> > +};
> > +
> > +struct conflicted_submodule_list {
> > +       struct conflicted_submodule_item *items;
> > +       size_t nr;
> > +       size_t alloc;
> >  };
> 
> Similarly, I think these should be defined in merge-ort.c (and maybe
> also merge-recursive.c) near struct merge_options_internal.

ack

> >  void init_merge_options(struct merge_options *opt, struct repository *repo);
> > @@ -122,4 +138,6 @@ int merge_recursive_generic(struct merge_options *opt,
> >                             const struct object_id **merge_bases,
> >                             struct commit **result);
> >
> > +void print_submodule_conflict_suggestion(struct conflicted_submodule_list *csub);
> 
> and I think there's no reason to put this in the header file; it
> should just be a static function in merge-ort.c.  (And, if we really
> want to update merge-recursive.c, then copy the function over there.
> *Nothing* in merge-ort.c should call a function in merge-recursive.c
> and similarly nothing in merge-recursive.c should call any function in
> merge-ort.c.  Yes, that implies some duplication.  There is a fair
> amount already and we've discussed it, and chosen against creating a
> shared module as well.  I want merge-recursive to not be broken by
> merge-ort updates; it should remain stable until the day we finally
> get to nuke it.  I'm personally of the opinion that merge-recursive
> should only get security fixes at this point, though I haven't pinged
> to see if other folks agree with that point of view yet or not.  I'm
> not wasting my time fixing/improving it, though...)

Good to know going forward I should only update merge-ort (unless for security fixes). I'll keep this in mind refactoring my patch.
 
> Despite my many nitpicks and whatnot, it looks like your change will
> make things nicer for the user, and I think your patch is coming along
> nicely.  There are some things to fix up, but the overall direction
> seems good.

Thank you for all of the helpful feedback!
