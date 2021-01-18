Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7B1C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6015422E00
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbhARUgP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389038AbhARUfm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:35:42 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA00C061757
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:35:01 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id i30so4664398ota.6
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JPF+6QyqBWH+DH3jRS/WCSo9TSabuL0LbgWKoOdw5ek=;
        b=mZ1+wu4DxfEGKfP4TgZ6VJaqPwKlhm+goGUClcoXCbo7/9NDf6/mYa/4Gq3VFWxA8u
         0cfQLH9nJol9HWsKJcBcdFTmglWJiaY6DM1Lz06kq60C+OW7uB1fpvSeF8bDKM9rUmHW
         YLPPUW7ScQ1wrB4qXZqfvhbF0uARUpC1cjKqnGpzRWJXX55vfaZQoFjPm8V4tNGY0IVd
         rr+1645tTQPeX9Tk78Rby6FN2HD8x/Uf/QCurpJGH9Ws1a52XNNB1CJLXMXZLRKzrlNN
         xkUG0F5hGJXgrqSnGoFLJMpgqgwCHhSrsPAUCuOreMW5ATZV7u80IukWJdE453pMgpcw
         mx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JPF+6QyqBWH+DH3jRS/WCSo9TSabuL0LbgWKoOdw5ek=;
        b=Fji971AYQty1ROYBx0OJv7dYIvs+t0UB3Z/86bpRge7NXGu1cnDCLAuIVrOUzJsDkv
         V9WrsB/Y2v8sdEwQDaFQ7gEzJn9euDR2DU9N+LtE2frz9RbCnHditDpckyee2kVg2FZz
         2gwVwlvbJujIxAHMyTvKp77CUv0LXnKwDibzwUFrpmcZsp/KWyaXJaEFjNZNdHCurjMq
         SDVxuBFRjTKxY4DDEmitrqohvf7sf2xT5b3InnwC65Pn/mE7WiFbzrMGYeAF2+jNxcVb
         1EaAFJE9HW6w/QxRe+ha4RZami9olU06M1GyEhoXRHkCLREsegvC6aOyYUjteZxOl2/1
         oT5w==
X-Gm-Message-State: AOAM5333lMp8MdjNJBT1oj0cMcGOM6QWHNSduYnb3EDrr2xWolJbuaBC
        ODobkSLciG+U+hve2H3/82XAeckJPRqE9GJUZv7YqWADwjk=
X-Google-Smtp-Source: ABdhPJzKzntd+djl39tgETMRSx/m68Q3wjB/UbJLmGApt2QPsaEHZ17yQszzsYncLz1ZdfIJLd5Ea290Xv7UhsgN9/Y=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr956854otr.345.1611002100588;
 Mon, 18 Jan 2021 12:35:00 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com> <bb4285250cdef2fcd16a22f8540968c871302c9f.1610055365.git.gitgitgadget@gmail.com>
 <YAXrKLM5vkkwmxjC@nand.local>
In-Reply-To: <YAXrKLM5vkkwmxjC@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Jan 2021 12:34:49 -0800
Message-ID: <CABPp-BEJeeX+0O+u7NjWU-qMYne75s_1FUPU9aiEr=jQ5eyptg@mail.gmail.com>
Subject: Re: [PATCH v2 05/17] merge-ort: add outline of get_provisional_directory_renames()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 12:10 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Jan 07, 2021 at 09:35:53PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This function is based on merge-recursive.c's get_directory_renames(),
> > except that the first half has been split out into a not-yet-implemented
> > compute_rename_counts().  The primary difference here is our lack of the
> > non_unique_new_dir boolean in our strmap.  The lack of that field will
> > at first cause us to fail testcase 2b of t6423; however, future
> > optimizations will obviate the need for that ugly field so we have just
> > left it out.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 59 insertions(+), 1 deletion(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 378ac495d09..73d3ff97f52 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -721,11 +721,69 @@ static int handle_content_merge(struct merge_options *opt,
> >
> >  /*** Function Grouping: functions related to directory rename detection ***/
> >
> > +static void compute_rename_counts(struct diff_queue_struct *pairs,
> > +                               struct strmap *dir_rename_count,
> > +                               struct strset *dirs_removed)
> > +{
> > +     die("Not yet implemented!");
> > +}
> > +
> >  static void get_provisional_directory_renames(struct merge_options *opt,
> >                                             unsigned side,
> >                                             int *clean)
> >  {
> > -     die("Not yet implemented!");
> > +     struct hashmap_iter iter;
> > +     struct strmap_entry *entry;
> > +     struct rename_info *renames = &opt->priv->renames;
> > +
> > +     compute_rename_counts(&renames->pairs[side],
> > +                           &renames->dir_rename_count[side],
> > +                           &renames->dirs_removed[side]);
> > +     /*
> > +      * Collapse
> > +      *    dir_rename_count: old_directory -> {new_directory -> count}
> > +      * down to
> > +      *    dir_renames: old_directory -> best_new_directory
> > +      * where best_new_directory is the one with the unique highest count.
> > +      */
> > +     strmap_for_each_entry(&renames->dir_rename_count[side], &iter, entry) {
> > +             const char *source_dir = entry->key;
> > +             struct strintmap *counts = entry->value;
> > +             struct hashmap_iter count_iter;
> > +             struct strmap_entry *count_entry;
> > +             int max = 0;
> > +             int bad_max = 0;
> > +             const char *best = NULL;
> > +
> > +             strintmap_for_each_entry(counts, &count_iter, count_entry) {
> > +                     const char *target_dir = count_entry->key;
> > +                     intptr_t count = (intptr_t)count_entry->value;
>
> Just to make sure I understand what's going on here: you're storing the
> whole int inside the pointer (and not pointing at it)?

Right, strmap just has (char *)keys and (void *)values.  The fact that
strintmap stores integers inside those values instead of pointers
means that I have to do casting.  That casting is often hidden behind
strintmap_get() calls, but since I'm not calling such a function here
but just accessing the raw strmap_entry fields, I need to cast myself.

> > +                     if (count == max)
> > +                             bad_max = max;
> > +                     else if (count > max) {
> > +                             max = count;
> > +                             best = target_dir;
> > +                     }
> > +             }
> > +
> > +             if (max == 0)
> > +                     continue;
>
> This is new from merge_recursive.c:get_directory_renames(). What is it
> doing here?

Ah, good catch.  That became necessary with an optimization I haven't
submitted yet.  I should probably pull these two lines out of this
patch and resubmit later with the other optimization.

>
> > +             if (bad_max == max) {
> > +                     path_msg(opt, source_dir, 0,
> > +                            _("CONFLICT (directory rename split): "
> > +                              "Unclear where to rename %s to; it was "
> > +                              "renamed to multiple other directories, with "
> > +                              "no destination getting a majority of the "
> > +                              "files."),
> > +                            source_dir);
> > +                     *clean &= 0;
>
> Also not a big deal, but why not simply '*clean = 0'?

Good question.  There might be a joke in there about this being a
dirty way of recording uncleanness, but what you suggest just looks
cleaner.  I'll fix it up.

>
> > +             } else {
> > +                     strmap_put(&renames->dir_renames[side],
> > +                                source_dir, (void*)best);
>
> Ah, answering my onw question: this is indeed shoving the int into your
> void*. That said, shouldn't this be '(void*)(intptr_t)best'?

??  best is not an int; it's a directory name.

You are correct that we shove an int into a void* elsewhere;
dir_rename_count is a map of {old_dir => {new_dir => int}} (as noted
in a comment where it was declared).

But this line of code is not for "dir_rename_count" but "dir_renames".
dir_renames is a map of {old_dir => new_dir}.  Thus, the value for the
strmap is meant to not be int but char*.  Here, best is a const char*
and the cast here is just to remove the constness so I can store in a
strmap -- I know that the strmap isn't going to modify the pointed-to
directory.
