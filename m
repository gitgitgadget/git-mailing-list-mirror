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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA13C433DB
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA8C22B39
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 20:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394345AbhARUnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jan 2021 15:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbhARUmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jan 2021 15:42:09 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787F2C061575
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:41:29 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id x71so3180712oia.9
        for <git@vger.kernel.org>; Mon, 18 Jan 2021 12:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GH5F3jepDP5anOQ5lu52fqSfFu3CTS73LrbwszSYMdo=;
        b=oV/u7txgMajBHmUuxGoZPlV0PnMJVBWNHFA9XpivbiuWUN7HruWnO3CPW+1bRcHrur
         D5NJcl5vxlY+fIyeWz6YQQRDT5u2d8BJ6nBKDytfZWgRmcOyTJQjWv5Odr/Ejg+arRkb
         GOdXI0rI12eNrwUZ4GNyXWWx7biFuR2xjt3OLqA4/aOuipfDDOcSmyYkWHnKu6AFfd6H
         kgXS4Pa5Sx/zdikzbXnqqsaSWv0/SKUgdLxA3XZrdzKRIs8uNevXoMV5/VLqBC5/sqWm
         2v2dmYTvdbrotKFfOVt2O7xHPlYQb2ccnc9z8ePG8OcuSWbYs1pGX28o5kDjEDQl2N7W
         5Clw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GH5F3jepDP5anOQ5lu52fqSfFu3CTS73LrbwszSYMdo=;
        b=NTrTMZLy5gq9bj+n+OyYVP2/oJ9by4v9V/t1La0QltJqJv04rPzeg/uP/TczlJ+nWb
         zy51aEmhfPk+Fie1jaDZUKQXAO4GhydYyclZVcjzKInyjXghT3OIutfetYDNEuQImkhd
         Gct6jTDw8zyIFfLTLVMtBFBw2RFpVGHX4gaUrvAoJtSaJi3RQPb03rOiBujibcogGein
         UedbckFOQFMZNm06lzwKmFcsg/5Qd7EubSJp6SKjRMusW1vYU0h7c0cxAO0U+PxD9gTs
         u2YTIpQ9F9Nfmm40JpWrVszSy6glr2AOrllnO4y5ENAojnqL/kHy012H0dRKPrVIdSqs
         nPGw==
X-Gm-Message-State: AOAM533ImgEyU33yQnn2WRDdBj6m4WWokGxkyBZNIxkU1Ibaya+rrmq+
        lCRwAK9q8vmZoTqEP0GItyp1T7jyniRWv4sfb1s=
X-Google-Smtp-Source: ABdhPJyQdoZCaO8UTMYD3UY7mqhvCQD6LT5lp11DCuMhUD6zaWNwSHBLxQt9Fqh20v8cQmWt6R2cYzhz2WYdG5n9+cY=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr659549oib.167.1611002488850;
 Mon, 18 Jan 2021 12:41:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.835.git.1610049687.gitgitgadget@gmail.com>
 <pull.835.v2.git.1610055365.gitgitgadget@gmail.com> <1e48cde01b9e2fe24eeda063e0298db8421b13a7.1610055365.git.gitgitgadget@gmail.com>
 <YAXxTsnQ0gqQZv75@nand.local>
In-Reply-To: <YAXxTsnQ0gqQZv75@nand.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 18 Jan 2021 12:41:17 -0800
Message-ID: <CABPp-BG0a7AfqHgnxWRwsA774d=n7tnTo6Mcx5x4x5E_NtUSSA@mail.gmail.com>
Subject: Re: [PATCH v2 07/17] merge-ort: implement compute_rename_counts()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 18, 2021 at 12:36 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> On Thu, Jan 07, 2021 at 09:35:55PM +0000, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > This function is based on the first half of get_directory_renames() from
> > merge-recursive.c
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  merge-ort.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 51 insertions(+), 2 deletions(-)
> >
> > diff --git a/merge-ort.c b/merge-ort.c
> > index 7e0cc597055..a8fcc026031 100644
> > --- a/merge-ort.c
> > +++ b/merge-ort.c
> > @@ -721,7 +721,6 @@ static int handle_content_merge(struct merge_options *opt,
> >
> >  /*** Function Grouping: functions related to directory rename detection ***/
> >
> > -MAYBE_UNUSED
> >  static void get_renamed_dir_portion(const char *old_path, const char *new_path,
> >                                   char **old_dir, char **new_dir)
> >  {
> > @@ -825,11 +824,61 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
> >       *new_dir = xstrndup(new_path, end_of_new - new_path);
> >  }
> >
> > +static void increment_count(struct strmap *dir_rename_count,
> > +                         char *old_dir,
> > +                         char *new_dir)
> > +{
> > +     struct strintmap *counts;
> > +     struct strmap_entry *e;
> > +
> > +     /* Get the {new_dirs -> counts} mapping using old_dir */
> > +     e = strmap_get_entry(dir_rename_count, old_dir);
> > +     if (e) {
> > +             counts = e->value;
> > +     } else {
> > +             counts = xmalloc(sizeof(*counts));
> > +             strintmap_init_with_options(counts, 0, NULL, 1);
> > +             strmap_put(dir_rename_count, old_dir, counts);
> > +     }
> > +
> > +     /* Increment the count for new_dir */
> > +     strintmap_incr(counts, new_dir, 1);
> > +}
> > +
> >  static void compute_rename_counts(struct diff_queue_struct *pairs,
> >                                 struct strmap *dir_rename_count,
> >                                 struct strset *dirs_removed)
> >  {
> > -     die("Not yet implemented!");
> > +     int i;
> > +
> > +     for (i = 0; i < pairs->nr; ++i) {
> > +             char *old_dir, *new_dir;
> > +             struct diff_filepair *pair = pairs->queue[i];
> > +
> > +             if (pair->status != 'R')
> > +                     continue;
>
> This had a useful comment in merge-recursive.c that I think would help
> future readers here. Would you consider brining over the comment that
> starts with "File not part of directory rename ..." here?

Sure, will do.

> > +             /* Get the old and new directory names */
> > +             get_renamed_dir_portion(pair->one->path, pair->two->path,
> > +                                     &old_dir,        &new_dir);
>
> This spacing is a little odd to me, but it does come directly from
> merge-recursive.c. I don't feel strongly about it.
>
> > +             if (!old_dir)
> > +                     /* Directory didn't change at all; ignore this one. */
> > +                     continue;
> > +
> > +             /*
> > +              * Make dir_rename_count contain a map of a map:
> > +              *   old_directory -> {new_directory -> count}
> > +              * In other words, for every pair look at the directories for
> > +              * the old filename and the new filename and count how many
> > +              * times that pairing occurs.
> > +              */
> > +             if (strset_contains(dirs_removed, old_dir))
> > +                     increment_count(dir_rename_count, old_dir, new_dir);
>
> Much clearer. If you're rerolling anyway, it may be worth it to say
> something about this movement in the patch message: "along the way,
> factor out the routine to update the bookkeeping to track the number of
> items renamed into new directories".

Sure, makes sense.

>
> > +             /* Free resources we don't need anymore */
> > +             free(old_dir);
> > +             free(new_dir);
> > +     }
>
> And obviously this is new, but it makes sense here. Thanks.
>
> Thanks,
> Taylor
