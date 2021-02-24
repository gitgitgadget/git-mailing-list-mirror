Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E6FC433E6
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BA8360241
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 18:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbhBXSwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbhBXSuw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 13:50:52 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6596C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 10:50:12 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 105so3187710otd.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 10:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBYWLg9mCxlXAwS9NrjLUzsZWmACCMPCyON8ZP4nDlU=;
        b=mSwMfS7QCPCPXWHqKLB3dUAFivfEXH7ekvhfcDRzmJIctEM0lf8vZBxhK1KLtW/OAf
         I1Uox3/oQ0JCJVwss6e7eBQ0uyXRo9B2OhxDHy+AAVsFtY3kc7XvMp+GvWBUEqR2Lyib
         4dTcZm3bxwv432GXgAOB5zlgES/gxw5gzAUXkE4S/c8/MF5ziovwyKDoXmo7EdLRfmZx
         694YNNMBrEAd+/eYdvW7xdB4ovP8zfUK4mf904SYnU/rnEqr4yugebYop4hKgmL4q5fI
         r+aeKpo5FPQVLzdfIAiqcyP27mLQPDCZ6zPURBavjE+B6ozKtql15IcirXyTxcYa9XWY
         CYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBYWLg9mCxlXAwS9NrjLUzsZWmACCMPCyON8ZP4nDlU=;
        b=EH4zZ086GVO80z6U31m4z/3T6z0RNjSXRvhGz8ixrJ+v7YP9IiRK4NLgWKiRnAUr8W
         pvE3YyI1dUx2re0pc7fztnM+wUkwW4lpCVwKtJkW/iqGRqbPAP5nbsu50GJEpQR5d0j3
         Y9nXTfzDUF79l6gyT3RTr+kTWJKPApY3q5Teh5sF/x19tMb+FpOS6zEMyjTLJBZJhKxp
         AoX7CbEgzVd28fPqtnhpg2bZxxjDpVtn0rulFscR37k8x/whhU05vuYv1XSAsEgxrBta
         mBZ4NNAwQrEPbvKsdg4SBA4MkH+rNq1S4qyToZBoX081TH8mgoW+Nw4IrqX6PCdDfvNv
         bskg==
X-Gm-Message-State: AOAM532GI4eM+X9ukXEgOGr5ew9OqenGrxxKxHJ4J+EREv5+gd+Ta6rc
        qFh0i8A6OxK5+gW1rXdV1kWdoym4SAoaGpnC/us=
X-Google-Smtp-Source: ABdhPJzJOo/8lb5kAhT+OIXj5KF7uZx39guJFz8MoLoN2u+lXq/Plb3n8zR15g7tL5x+5RMwRLmY25N6itJ6m4BZZO8=
X-Received: by 2002:a9d:6251:: with SMTP id i17mr16363582otk.162.1614192612116;
 Wed, 24 Feb 2021 10:50:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.844.git.1613289544.gitgitgadget@gmail.com>
 <pull.844.v2.git.1614123848.gitgitgadget@gmail.com> <fec4f1d44c0694cf92c9b98f2b6519a15fb78188.1614123848.git.gitgitgadget@gmail.com>
 <bb0ef143-3050-6f3e-79ed-f06c1536f0a7@gmail.com>
In-Reply-To: <bb0ef143-3050-6f3e-79ed-f06c1536f0a7@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 10:50:01 -0800
Message-ID: <CABPp-BHJGi7m6=DgP3zDR4nLF6jaDuysgRgfDae8HY85VaLvgg@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] Move computation of dir_rename_count from
 merge-ort to diffcore-rename
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 7:25 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 2/23/2021 6:43 PM, Elijah Newren via GitGitGadget wrote:
> > ... While the
> > diffstat looks large, viewing this commit with --color-moved makes it
> > clear that only about 20 lines changed.  With this patch, the
> > computation of dir_rename_count is still only done after inexact rename
> > detection, but subsequent commits will add a preliminary computation of
> > dir_rename_count after exact rename detection, followed by some updates
> > after inexact rename detection.
>
> The --color-moved recommendation is a good one. Everything seems to be
> pretty standard, except this function:
>
> > +static void compute_dir_rename_counts(struct strmap *dir_rename_count,
> > +                                   struct strset *dirs_removed)
> > +{
> > +     int i;
> > +
> > +     /* Set up dir_rename_count */
> > +     for (i = 0; i < rename_dst_nr; ++i) {
> > +             /*
> > +              * Make dir_rename_count contain a map of a map:
> > +              *   old_directory -> {new_directory -> count}
> > +              * In other words, for every pair look at the directories for
> > +              * the old filename and the new filename and count how many
> > +              * times that pairing occurs.
> > +              */
> > +             update_dir_rename_counts(dir_rename_count, dirs_removed,
> > +                                      rename_dst[i].p->one->path,
> > +                                      rename_dst[i].p->two->path);
> > +     }
> > +}
>
> is very similar to this:
>
> > -static void compute_rename_counts(struct diff_queue_struct *pairs,
> > -                               struct strmap *dir_rename_count,
> > -                               struct strset *dirs_removed)
> > -{
> > -     int i;
> > -
> > -     for (i = 0; i < pairs->nr; ++i) {
> > -             struct diff_filepair *pair = pairs->queue[i];
> > -
> > -             /* File not part of directory rename if it wasn't renamed */
> > -             if (pair->status != 'R')
> > -                     continue;
> > -
> > -             /*
> > -              * Make dir_rename_count contain a map of a map:
> > -              *   old_directory -> {new_directory -> count}
> > -              * In other words, for every pair look at the directories for
> > -              * the old filename and the new filename and count how many
> > -              * times that pairing occurs.
> > -              */
> > -             update_dir_rename_counts(dir_rename_count, dirs_removed,
> > -                                      pair->one->path,
> > -                                      pair->two->path);
> > -     }
> > -}
> > -
>
> but we dropped that "File not part of directory rename" check.
>
> It seems that is no longer possible to use with the new data structure,
> but I wonder if this will cause a slowdown in the directory renames when
> merging? Or, has the data already been filtered before calling
> compute_dir_rename_counts()?

Oh, indeed, good catch.  The
    if (pair->status != 'R')
        continue;
check should have been translated to
    if (!rename_dst[i].is_rename)
        continue;
Such a check _was_ added later in the series except with more code
than just the "continue" that didn't make sense at this stage; the
extra code made me overlook it when I was splitting.  Oops.  I'll add
this check back in; thanks for catching.
