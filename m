Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E86221F454
	for <e@80x24.org>; Fri,  8 Nov 2019 03:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfKHDvU (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 22:51:20 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46753 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbfKHDvT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 22:51:19 -0500
Received: by mail-ed1-f65.google.com with SMTP id x11so3846750eds.13
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 19:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dropbox.com; s=corp;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u50VNFaKLCpUOkz3m4fOc6TSJkyNtl1q6UxdCC8GPmo=;
        b=BnhJk2DhLgVGuZvSDgH6OridfRd6E19OV03/gblRVjqcBXMeEW4ptRikHVhw+uBo3b
         wp78NhreHTOzZCNzASRfdzvTJRkXgTkAoXDJedANzhlPPnzIuWTavO1CXNhnbOTju1ec
         Re6QzbFl/n6iLQWxO35ZiDeFYPFFdgpBzkCvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u50VNFaKLCpUOkz3m4fOc6TSJkyNtl1q6UxdCC8GPmo=;
        b=JfO9xFvcS6mOp52OevIxl+ikCN+o0ue4nT1y67r0PGgxK25HRbW/DkA3bnfbw4Fxwx
         PbsYs53X94erCfDCC3qx293dM6tC44WCsITqBNnQkwf0c0SPOZW32Pu97wA902J2pre9
         IuPm/z6RAKxJUkOHf1jHGGbeW0J4lgx1rcw8K7jKioQFGXT1piIHrZYawUqmx8Lm9NiH
         WbPQrfZme7gn2HWa10AB9YgMBm6VVWSRH3otUsiDdd88DTbZ3cFqzmevBdW30rnqoS0D
         VyMI2MNiIKfLseuq6C+sWSRZRV/vKNoSNCba5xAlte6gxAha+FdDFCts0N+9+puWqXF5
         xkGA==
X-Gm-Message-State: APjAAAVA6MknZqhPdke3AvkilXEyeWJl+fdu8i/XDg1ICkK0m4iCG6D3
        IJUn5fZXxt2FIVIbBfWfaI9OtbsCXAEgMsPI+eBFCw==
X-Google-Smtp-Source: APXvYqzLDvwZVKoBH55tHJJJpPWn7lf3abCtrEGuJ6/V4TTyay5rl5XwByG6JxZHzl/T6IEMMBQVqtv1zhDKVwLOzpU=
X-Received: by 2002:a50:b4e4:: with SMTP id x33mr7887813edd.222.1573185075540;
 Thu, 07 Nov 2019 19:51:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.424.v2.git.1572967644.gitgitgadget@gmail.com>
 <pull.424.v3.git.1573016055.gitgitgadget@gmail.com> <4bea7075cfcac013f5947cd3e9254d38e86e675c.1573016055.git.gitgitgadget@gmail.com>
 <xmqqftj1th93.fsf@gitster-ct.c.googlers.com> <CAPYzU3P6M0s365gOEz360B0QqRN6JKaUB2Zc8+-XnVei0WF6WA@mail.gmail.com>
In-Reply-To: <CAPYzU3P6M0s365gOEz360B0QqRN6JKaUB2Zc8+-XnVei0WF6WA@mail.gmail.com>
From:   Utsav Shah <utsav@dropbox.com>
Date:   Thu, 7 Nov 2019 19:51:04 -0800
Message-ID: <CAPYzU3OU45E_OQKOFFohxsqUvmMGXL9NNYNi2i27k3aRZ4oqVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] unpack-trees: skip stat on fsmonitor-valid files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Utsav Shah via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Utsav Shah <ukshah2@illinois.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 6, 2019 at 2:33 PM Utsav Shah <utsav@dropbox.com> wrote:
>
> On Wed, Nov 6, 2019 at 2:46 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Utsav Shah via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > From: Utsav Shah <utsav@dropbox.com>
> > >
> > > The index might be aware that a file hasn't modified via fsmonitor, but
> > > unpack-trees did not pay attention to it and checked via ie_match_stat
> > > which can be inefficient on certain filesystems. This significantly slows
> > > down commands that run oneway_merge, like checkout and reset --hard.
> >
> > s/hasn't/& been/;
> >
> > Otherwise, well written.
> >
> > > This patch makes oneway_merge check whether a file is considered
> > > unchanged through fsmonitor and skips ie_match_stat on it. unpack-trees
> > > also now correctly copies over fsmonitor validity state from the source
> > > index. Finally, for correctness, we force a refresh of fsmonitor state in
> > > tweak_fsmonitor.
> >
> > s/This patch makes/Make/; order the person who is updating the code
> > what to do to the codebase in imperative mood.
> >
> > Otherwise, well written.
> >
> > > After this change, commands like stash (that use reset --hard
> > > internally) go from 8s or more to ~2s on a 250k file repository on a
> > > mac.
> > >
> > > Signed-off-by: Utsav Shah <utsav@dropbox.com>
> > > ---
> > >  fsmonitor.c                 | 39 ++++++++++++++++++++++++-------------
> > >  t/t7519-status-fsmonitor.sh |  9 +++++++--
> > >  unpack-trees.c              |  6 +++++-
> > >  3 files changed, 37 insertions(+), 17 deletions(-)
> > >
> > > diff --git a/fsmonitor.c b/fsmonitor.c
> > > index 1f4aa1b150..04d6232531 100644
> > > --- a/fsmonitor.c
> > > +++ b/fsmonitor.c
> > > @@ -18,7 +18,7 @@ static void fsmonitor_ewah_callback(size_t pos, void *is)
> > >
> > >       if (pos >= istate->cache_nr)
> > >               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %u)",
> > > -                 (uintmax_t)pos, istate->cache_nr);
> > > +                     (uintmax_t)pos, istate->cache_nr);
> >
> > Unintended whitespace change?
> >
> > > @@ -55,9 +55,10 @@ int read_fsmonitor_extension(struct index_state *istate, const void *data,
> > >       }
> > >       istate->fsmonitor_dirty = fsmonitor_dirty;
> > >
> > > -     if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> > > -             BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> > > -                 (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> > > +     if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> > > +             BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
> > > +                     (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
> > > +
> >
> > The patch disables this sanity check under "split index" mode and it
> > must be done for good reasons, but readers (imagine, somebody found
> > a bug on this line 6 months down the road, ran "git blame" and found
> > this commit and reading it via "git show") would want to know why
> > this change was made.
> >
> > I recall seeing no mention of "split index" in the proposed log
> > message.  Is this a fix for unrelated issue that needs to be
> > explained in a separate patch, perhaps?

Yes. I think this is an important bug to fix, fsmonitor and split
indices don't seem to be interoperating well after these checks have
been added.

> >
> > The hunk also has the unintended whitespace change, it seems.
> >
> > > @@ -83,9 +84,9 @@ void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
> > >       uint32_t ewah_size = 0;
> > >       int fixup = 0;
> > >
> > > -     if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> > > -             BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> > > -                 (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> > > +     if (!istate->split_index && istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> > > +             BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %"PRIuMAX")",
> > > +                     (uintmax_t)istate->fsmonitor_dirty->bit_size, (uintmax_t)istate->cache_nr);
> >
> > Likewise (both indentation of the second line and the unexplained
> > change to the sanity check condition we saw above).
> >
> > > @@ -189,13 +190,25 @@ void refresh_fsmonitor(struct index_state *istate)
> > >               }
> > >               if (bol < query_result.len)
> > >                       fsmonitor_refresh_callback(istate, buf + bol);
> > > +
> > > +             if (istate->untracked)
> > > +                     istate->untracked->use_fsmonitor = 1;
> >
> > Unexplained.  We used to do this in tweak_fsmonitor() but now we do
> > this here, as we are making tweak_fsmonitor() to call this function
> > anyway.  If there are other callers that call refresh_fsmonitor()
> > and they did not do this, this would be a behaviour change to them.
> > As there is no explanation why this change is done, readers cannot
> > tell if it is a good change.  If this were explained like so:
> >
> >     Any caller of refresh_fsmonitor() must set use_fsmonitor bit in
> >     istate when istate->untracked exists FOR SUCH AND SUCH REASONS.
> >     Move the code to do so in tweak_fsmonitor() to near the
> >     beginning of refresh_fsmonitor(), which would fix SUCH AND SUCH
> >     other callers that forgets to do this.
> >
> > in the proposed log message, that might help justifying the change.
> >
> > If use_fsmonitor is not set, why is the caller calling
> > refresh_fsmonitor() in the first place, by the way?
> >
> > Isn't it more like "we are told to use fsmonitor via
> > istate->untracked->use_fsmonitor bit being true, so we call
> > refresh_fsmonitor, and if the bit is false, we do not have to bother
> > with fsmonitor and no point calling refresh_fsmonitor"?
> >
> > If a careless caller makes a call to refresh_fsmonitor() when the
> > configuration tells us not to use fsmonitor, wouldn't this cause us
> > to use fsmonitor anyway?  Which sounds bad, so perhaps all callers
> > are careful to first check if use_fsmonitor is set before deciding
> > to call refresh_fsmonitor()---but if that is the case, is there a
> > point in setting it here to true?
> >
> > Puzzled by an unexplained code...

I might be misunderstanding, but wouldn't the if condition above make
sure we don't enter this codepath at all?

if (!core_fsmonitor || istate->fsmonitor_has_run_once)
        return;

istate->untracked->use_fsmonitor is only used in the untracked cache
to skip some lstats AFAICT. So callers refresh_fsmonitor should see no
difference.

I agree that this change deserves a better explanation.

> >
> > >       } else {
> > > +
> > > +             /* We only want to run the post index changed hook if we've actually changed entries, so keep track
> > > +              * if we actually changed entries or not */
> > > +             int is_cache_changed = 0;
> > >               /* Mark all entries invalid */
> > > -             for (i = 0; i < istate->cache_nr; i++)
> > > -                     istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> > > +             for (i = 0; i < istate->cache_nr; i++) {
> > > +                     if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
> > > +                             is_cache_changed = 1;
> > > +                             istate->cache[i]->ce_flags &= ~CE_FSMONITOR_VALID;
> > > +                     }
> > > +             }
> > >
> > >               /* If we're going to check every file, ensure we save the results */
> > > -             istate->cache_changed |= FSMONITOR_CHANGED;
> > > +             if (is_cache_changed)
> > > +                     istate->cache_changed |= FSMONITOR_CHANGED;
> >
> > This part (and a call to refresh_fsmonitor() we see blow) is the
> > "Finally, we force a refresh" explained in the proposed log message,
> > I presume.
> >
> > >               if (istate->untracked)
> > >                       istate->untracked->use_fsmonitor = 0;
> > > @@ -254,12 +267,10 @@ void tweak_fsmonitor(struct index_state *istate)
> > >                       /* Mark all previously saved entries as dirty */
> > >                       if (istate->fsmonitor_dirty->bit_size > istate->cache_nr)
> > >                               BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" > %u)",
> > > -                                 (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> > > +                                     (uintmax_t)istate->fsmonitor_dirty->bit_size, istate->cache_nr);
> >
> > This shares the same indentation issue but does not disable the
> > sanity check for split index case.  Intended?  Without explanation
> > in the proposed log message, readers cannot tell.

Yes, will add the sanity check here too.

> >
> > >                       ewah_each_bit(istate->fsmonitor_dirty, fsmonitor_ewah_callback, istate);
> > >
> > > -                     /* Now mark the untracked cache for fsmonitor usage */
> > > -                     if (istate->untracked)
> > > -                             istate->untracked->use_fsmonitor = 1;
> > > +                     refresh_fsmonitor(istate);
> > >               }
> > >
> > >               ewah_free(istate->fsmonitor_dirty);
> > > diff --git a/unpack-trees.c b/unpack-trees.c
> > > index 33ea7810d8..fc5ceb932c 100644
> > > --- a/unpack-trees.c
> > > +++ b/unpack-trees.c
> > > @@ -1504,6 +1504,9 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
> > >       o->merge_size = len;
> > >       mark_all_ce_unused(o->src_index);
> > >
> > > +     if (o->src_index->fsmonitor_last_update)
> > > +             o->result.fsmonitor_last_update = o->src_index->fsmonitor_last_update;
> > > +
> >
> > This is the "correctly copies" part, which was well explained.
> >
> > >       /*
> > >        * Sparse checkout loop #1: set NEW_SKIP_WORKTREE on existing entries
> > >        */
> > > @@ -2384,7 +2387,8 @@ int oneway_merge(const struct cache_entry * const *src,
> > >
> > >       if (old && same(old, a)) {
> > >               int update = 0;
> > > -             if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old)) {
> > > +             if (o->reset && o->update && !ce_uptodate(old) && !ce_skip_worktree(old) &&
> > > +                     !(old->ce_flags & CE_FSMONITOR_VALID)) {
> >
> > This is the "skip when we know it is valid" part, which was well
> > explained.
> >
> > >                       struct stat st;
> > >                       if (lstat(old->name, &st) ||
> > >                           ie_match_stat(o->src_index, old, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE))
> >
> > Thanks.
>
> Thanks for the feedback. The lines with the indentation changes had
> tabs and spaces mixed up, but I'll revert those changes.

I will try to figure out how to use gitgitgadget to send a smaller
patch within this thread to fix the fsmonitor and split index
interactions. I tried writing a test today that uses
t7519/fsmonitor-watchman to simulate the bug, but it is flaky.
