Return-Path: <SRS0=oqjl=22=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E230BC32767
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A855C215A4
	for <git@archiver.kernel.org>; Sun,  5 Jan 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQ2vElAe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgAEAtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jan 2020 19:49:25 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41638 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgAEAtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jan 2020 19:49:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so66418589otc.8
        for <git@vger.kernel.org>; Sat, 04 Jan 2020 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ksFCmJ48YBamD3mf7m+nYHiWmMDXjQjX/RpkRURKcvM=;
        b=pQ2vElAem2FGomjVRmyAFh9q5PFCIbFbGTtbKqg5a9rJTRJH401EnmF9kUjKNeNMKl
         nMqBa/JwQPAhGE6iPVD8pi/NnLoowDByA07HMj1uc/pDeO+asru37JpyczUs77NTl8qY
         8dZwkfkCDSgFQE2lklyG3vKzTl69DWZqkPvEACnLRhlFij+R3ch8L06Go+nG4MweALOh
         EG7Iz1QcC2kMxQth+mZO6upNKeIxjCJHiIeRmbS4Lcgr9Sn+yGkqFdpEy91mV/a6FqKE
         wTiQK15KKWY/0WU4NjfTYKmWfiyotHVYB1bLYPSdp3Y+zVlmhzzRvXZsxUJKWz23Jh+d
         IdFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksFCmJ48YBamD3mf7m+nYHiWmMDXjQjX/RpkRURKcvM=;
        b=F4UIZoggaiN9Q9ixwybkGu9w9KLwXj7DA8/fFOtBYnh/z6iy0kE5St+dySNZRN3E/g
         vIGo2EjZwRSITZYKbH169kNqq6RUqDb9SzrHso5dW8SOoGzGvSthSYgOTJReOKFmCSVS
         cNAJdGlmqVyxN2dnkJMYSil5rNP5lBcg+/CEsBHcmiuxA4RCxHN2IpJ9d3oSaHRrmDAi
         NzKeZcfb9OV3VcXGQq+r8598j9sL8dhnBneMlL8CH7n9ebSA0HlAGNiAAsWjQ52oU83J
         BP8SHJ7eGEGNboG4NSX2S3VyL27jUOo311JqMoT1G/3/oNGiON2ks+lssHs3Pf7Uw3H7
         EoXg==
X-Gm-Message-State: APjAAAUKPrS+YPkhpwQnCQqLZBVhEx+MBkGT4AyPr/3DCR2n+Wf+ZNa9
        gpXvs5i4aR8ckHnIZGqtFNqUM7Zoxde8HSnN8l8=
X-Google-Smtp-Source: APXvYqxdiIepFsQ8z3M9NzV1bb0XnjbXKrogOz/J5jUiCI12PAe82oTZKsKdk06FcZFLqnKU1GVigp815YSzEGueph0=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr103972217otq.112.1578185364391;
 Sat, 04 Jan 2020 16:49:24 -0800 (PST)
MIME-Version: 1.0
References: <pull.686.git.git.1578087730.gitgitgadget@gmail.com>
 <de0f381284cfe90c1bd8521abb8d29e3529c981a.1578087730.git.gitgitgadget@gmail.com>
 <xmqqimlqbx61.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqimlqbx61.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 4 Jan 2020 16:49:15 -0800
Message-ID: <CABPp-BGeVd-Bbh=nKWL1B9mmvG_Pf6ckEH7DVc5M5A=z4Yx1wA@mail.gmail.com>
Subject: Re: [PATCH 1/1] unpack-trees: exit check_updates() early if updates
 are not wanted
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sat, Jan 4, 2020 at 3:48 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +     if (!o->update || o->dry_run) {
> > +             remove_marked_cache_entries(index, 0);
> > +             trace_performance_leave("check_updates");
> > +             return 0;
> > +     }
>
> OK, so the idea is that bunch of codepaths we see later are
> protected by "o->update && !o->dry_run" in the original and are not
> executed, so we can leave early here.
>
> So the primary task of the reviewers of this patch is to see if the
> remainder of the function has some code that were *not* no-op when
> (!o->update || o->dry_run) is true in the current code, which would
> indicate possible behaviour change, and assess if the change in
> behaviour matters in the real world if there is.
>
> >       if (o->clone)
> >               setup_collided_checkout_detection(&state, index);
>
> If there were such a thing as dry-run of a clone, we will stop
> calling the report based on the thing we are setting up here?
> Presumably that does not happen in the current code---is that
> something we guarantee in the future evolution of the code, though?

setup_collided_checkout_detection() clears the CE_MATCHED flag for
each cache entry, which can be updated via way of checkout_entry()'s
call to mark_colliding_entries().  Then the trailing
report_collided_checkout() at the end of the function will report any
paths with CE_MATCHED set.  However, when we're in a dry-run, all
checkout_entry() calls are skipped, so we won't detect ever detect any
collided entries.  As such, there's no point in calling either the
setup_collided_checkout_detection() or report_collided_checkout()
funtions.

Sorry for forgetting to include this in the commit message.

> >       progress = get_progress(o);
>
> get_progress() would yield NULL when !o->update, but o->dry_run does
> not influence it, so we would have called the progress API in
> today's code, if o->dry_run and o->update are both true.
>
> Presumably, o->update and o->dry_run are not true at the same time
> in the current code---but even if in the future we start supporting
> the combination, dry-run should be skipping the filesystem update
> (which is the slow part) and lack of progress may not matter, I
> guess?

The point of the progress display was to show how long it takes to do
the updates.  For a dry-run, that time is zero because we skip the
updates.  And if we're skipping the updates, shouldn't we also skip
measuring how long it takes to do them?

Yeah, I should have included this in the commit message too.

> It seems to me that unpack_trees_options.dry_run can become true
> only in "git read-tree" when the -n (or --dry-run) option is given
> and no other codepath touches it.  Am I reading the code correctly?

I hadn't checked previously, but that looks right to me.

> Similarly, unpack_trees_options.clone is turned on only in the
> builtin/clone.c::checkout().  It _might_ occur to future developers
> that "git clone --no-checkout" is better implemented by actually
> going through builtin/clone.c::checkout() with .dry_run turned on,
> instead of leaving that function early.  That would for example
> allow collided_checkout() detection to still be done---in such a
> future, is the optimization this patch makes still safe, I wonder?

If it is intended that a report of colliding paths be given when doing
a dry-run using unpack_trees, then the current code is quite buggy
because it'll never report anything.  In order to report anything, the
mechanism for detecting them would need to be drastically reworked.
As such, I'd view the optimization as at least making it more obvious
why the code won't report collisions with dry-run rather than
pretending it will.  Or are you saying that I've just uncovered a bug
and it should really be fixed rather than exploited for an
optimization?

> > -     if (o->update)
> > -             git_attr_set_direction(GIT_ATTR_CHECKOUT);
> > +     git_attr_set_direction(GIT_ATTR_CHECKOUT);
> >
> > -     if (should_update_submodules() && o->update && !o->dry_run)
> > +     if (should_update_submodules())
> >               load_gitmodules_file(index, NULL);
>
> Good (no behaviour change because this wouldn't have been done under
> the early-exit condition anyway).
> >
> >       for (i = 0; i < index->cache_nr; i++) {
> > @@ -388,18 +393,18 @@ static int check_updates(struct unpack_trees_options *o)
> >
> >               if (ce->ce_flags & CE_WT_REMOVE) {
> >                       display_progress(progress, ++cnt);
> > -                     if (o->update && !o->dry_run)
> > -                             unlink_entry(ce);
> > +                     unlink_entry(ce);
>
> Good (no behaviour change because this wouldn't have been done under
> the early-exit condition anyway).
>
> >               }
> >       }
> > +
> >       remove_marked_cache_entries(index, 0);
> >       remove_scheduled_dirs();
> >
> > -     if (should_update_submodules() && o->update && !o->dry_run)
> > +     if (should_update_submodules())
> >               load_gitmodules_file(index, &state);
>
> Good (no behaviour change because this wouldn't have been done under
> the early-exit condition anyway).
> >
> >       enable_delayed_checkout(&state);
> > -     if (has_promisor_remote() && o->update && !o->dry_run) {
> > +     if (has_promisor_remote()) {
>
> Good (no behaviour change because this wouldn't have been done under
> the early-exit condition anyway).
>
> >               /*
> >                * Prefetch the objects that are to be checked out in the loop
> >                * below.
> > @@ -431,15 +436,12 @@ static int check_updates(struct unpack_trees_options *o)
> >                                   ce->name);
> >                       display_progress(progress, ++cnt);
> >                       ce->ce_flags &= ~CE_UPDATE;
> > -                     if (o->update && !o->dry_run) {
> > -                             errs |= checkout_entry(ce, &state, NULL, NULL);
> > -                     }
> > +                     errs |= checkout_entry(ce, &state, NULL, NULL);
>
> Good (no behaviour change because this wouldn't have been done under
> the early-exit condition anyway).
>
> >               }
> >       }
> >       stop_progress(&progress);
> >       errs |= finish_delayed_checkout(&state, NULL);
> > -     if (o->update)
> > -             git_attr_set_direction(GIT_ATTR_CHECKIN);
> > +     git_attr_set_direction(GIT_ATTR_CHECKIN);
> >
> >       if (o->clone)
> >               report_collided_checkout(index);
>
> Behaviour around this one (and the corresponding setup) may make a
> difference before and after the patch to future developers (who may
> need to revert this change to achieve what they want to do), but I
> think it is a no-op clean-up for today's code.
