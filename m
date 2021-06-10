Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F97C48BDF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B32A60FD8
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFJVel (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 17:34:41 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:34549 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbhFJVek (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 17:34:40 -0400
Received: by mail-ot1-f49.google.com with SMTP id v27-20020a056830091bb02903cd67d40070so1167855ott.1
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Zki8oTA6iDKi5Jb+/N+xypZC0vHes6b9OmpKb0FOHE=;
        b=GNrNmvYhMh2sGZOByI+N16Ow5CtQbSZQD7ofM1dNZ+4BudBi5pE0A1V4b3liydOcB0
         N19Zf0V5TAEFpc/LRqPbT4ZzmT8iWXg0GXqH/qw2hUjnO3ogjoDKIBt7G7VfBKSZlYZF
         jbOk7D+dFtsvpiYthMVQJqblC5+k3JF2bPTgC0ywpc19IAi6zF+1OSntNqTmFgQ702xs
         GhudpBEQqryfVVlW8krSe417hwHB/hWdRIYQlKLFg1CKxBKNxu7vhvmLYfiaaWNfs8Wr
         1fyhZeZ4VPflUSzbl2broRwHemtc91mP39q5G48Q4HxpKipew91+tWJA7w6BYVZl4KQ3
         yM0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Zki8oTA6iDKi5Jb+/N+xypZC0vHes6b9OmpKb0FOHE=;
        b=ZdVV9i3q4Nqr0SwBWYkQ0mgPQsDxjiwqzoAtzkBM+aujfM2RkQTFXIUYeK6n0GieHa
         IHUEUvagoHLK+ARZrae0njp+seYhYg/WlsO1uJYSn9TO2VjTjvsJOgGuSx9COmIn92us
         i2Fv3HIxO3/oHKI45ra1myL7iuFG3NaWqUCbejdXtVgnZoyf2nrXazqjCEnMGfe8w571
         134NKxV3k1GF0SMXtS8mTQNP9CcdFolx7LP6D6jFznLTxDi2eJyt0itWYkPpGFQCE1ho
         ZgexnZaFr1umDXJX6IsU/bePOGqCK5/krsL/3q4R4JYF/eVQUwnPMhEXM/FOzcq8fOWA
         Xplw==
X-Gm-Message-State: AOAM532V2xUPwNIjCMt7K1xYDWQOKzOdiFVntbAJb/gmlI/DTEFgvJTB
        Ho7mUw0qsOAnq9PG7exeXsoYN+GuVebcWaGlaxM=
X-Google-Smtp-Source: ABdhPJxPTkU2g1FkNjPWOIv2QFBfHnIxPU8b3cRrY1mGTg7V5DiyUE6T1O32SXObk5SHeGLEGYV9QIjh8P3aIwg48go=
X-Received: by 2002:a9d:426:: with SMTP id 35mr341036otc.162.1623360703768;
 Thu, 10 Jun 2021 14:31:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <b9b97e0112939d1787ff1d2a13c48e5b406408db.1623069252.git.gitgitgadget@gmail.com>
 <CABPp-BEp0NzUqW_pWpTGoUvrB1JMp9fVHr28Sp8RZqV6w0-hEw@mail.gmail.com>
 <xmqqfsxrk0oc.fsf@gitster.g> <CABPp-BHEp6mH3jx6BeRk+u8C-9Q+go0=hHiaxenN_5KQKsR5iw@mail.gmail.com>
 <60844f4b-33d4-b6d7-3611-a93cf012d3ff@gmail.com> <38d0900b-c677-a32d-cc63-e615828e9a5d@gmail.com>
In-Reply-To: <38d0900b-c677-a32d-cc63-e615828e9a5d@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 14:31:32 -0700
Message-ID: <CABPp-BHFdG9=JfR7fnwSjNgJ2o=ttHn--ogD3_LQLYKe4dV9SQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] diff-lib: handle index diffs with sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 10:45 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/9/2021 4:33 PM, Derrick Stolee wrote:
> > On 6/9/2021 4:11 AM, Elijah Newren wrote:
> >> On Tue, Jun 8, 2021 at 11:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> >>>
> >>> Elijah Newren <newren@gmail.com> writes:
> >>>
> >>> The tree-diff machinery takes two trees, walks them in parallel and
> >>> repeatedly calls either diff_addremove() or diff_change(), which
> >>> appends diff_filepair() to the diff_queue[] structure.  If you see
> >>> an unexpanded tree on the index side, you should be able to pass
> >>> that tree with the subtree you are comparing against to the tree-diff
> >>> machinery to come up with a series of filepairs, and then tweak the
> >>> pathnames of these filepairs (as such a two-tree comparison would be
> >>> comparing two trees representing a single subdirectory of two different
> >>> vintages) before adding them to the diff_queue[] you are collecting
> >>> the index-vs-tree diff, for example.
> >>
> >> Good to know it seems my idea might be reasonable.
> >
> > I agree that this is reasonable. I just didn't look hard enough
> > to find existing code for this, since I found traverse_trees and
> > thought that _was_ the library for this.
>
> This was surprisingly simple, since most of the complicated stuff
> is built into diff_tree_oid() and its use of revs->diffopt. The
> new patch works as shown below the cut-line.
>
> I was incredibly suspicious of how quickly this came together,
> but it passes all the tests I have for it (including Scalar
> functional tests with the commit, checkout, and add integrations).

Nice!

> I'll send a new version with this patch tomorrow, as well as the
> other recommended edits.
>
> Thanks,
> -Stolee
>
> --- >8 ---
>
>
> diff --git a/diff-lib.c b/diff-lib.c
> index c2ac9250fe9..b631df89343 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -316,6 +316,13 @@ static int get_stat_data(const struct index_state *istate,
>         return 0;
>  }
>
> +static void show_directory(struct rev_info *revs,
> +                          const struct cache_entry *new_dir,
> +                          int added)
> +{
> +       diff_tree_oid(NULL, &new_dir->oid, new_dir->name, &revs->diffopt);
> +}
> +
>  static void show_new_file(struct rev_info *revs,
>                           const struct cache_entry *new_file,
>                           int cached, int match_missing)
> @@ -325,6 +332,11 @@ static void show_new_file(struct rev_info *revs,
>         unsigned dirty_submodule = 0;
>         struct index_state *istate = revs->diffopt.repo->index;
>
> +       if (new_file && S_ISSPARSEDIR(new_file->ce_mode)) {
> +               show_directory(revs, new_file, /*added */ 1);
> +               return;
> +       }
> +
>         /*
>          * New file in the index: it might actually be different in
>          * the working tree.
> @@ -336,6 +348,15 @@ static void show_new_file(struct rev_info *revs,
>         diff_index_show_file(revs, "+", new_file, oid, !is_null_oid(oid), mode, dirty_submodule);
>  }
>
> +static void show_modified_sparse_directory(struct rev_info *revs,
> +                        const struct cache_entry *old_entry,
> +                        const struct cache_entry *new_entry,
> +                        int report_missing,
> +                        int cached, int match_missing)
> +{
> +       diff_tree_oid(&old_entry->oid, &new_entry->oid, new_entry->name, &revs->diffopt);
> +}
> +
>  static int show_modified(struct rev_info *revs,
>                          const struct cache_entry *old_entry,
>                          const struct cache_entry *new_entry,
> @@ -347,6 +368,17 @@ static int show_modified(struct rev_info *revs,
>         unsigned dirty_submodule = 0;
>         struct index_state *istate = revs->diffopt.repo->index;
>
> +       /*
> +        * If both are sparse directory entries, then expand the
> +        * modifications to the file level.
> +        */
> +       if (old_entry && new_entry &&
> +           S_ISSPARSEDIR(old_entry->ce_mode) &&
> +           S_ISSPARSEDIR(new_entry->ce_mode)) {
> +               show_modified_sparse_directory(revs, old_entry, new_entry, report_missing, cached, match_missing);
> +               return 0;
> +       }

What if S_ISSPARSEDIR(old_entry->ce_mode) != S_ISSPARSEDIR(new_entry->ce_mode) ?

> +
>         if (get_stat_data(istate, new_entry, &oid, &mode, cached, match_missing,
>                           &dirty_submodule, &revs->diffopt) < 0) {
>                 if (report_missing)
