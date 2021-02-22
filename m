Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB22C433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE5464E12
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 18:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBVS4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 13:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhBVSyr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 13:54:47 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E71DC061574
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 10:53:59 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id l3so15067455oii.2
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 10:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aa222P3OEivDagpe+TMlil00hMhGkQHB4uAGX9LVagA=;
        b=FCxGtud1ytnI34sa/nxRW+Y9iIG7+yzNbgH9OUJNbQ+1v0HIULRv3BU4THlskvkOz7
         WDBzAJVj7avW8GjCFjQu8cN+o926OooXuVzZ0pUDPP0s5wZfBaKZHhETSdfKm+kP0tAL
         5A1t34Uv56PIDsBiTuOFu5Ix9HzA3XmjNzg0KAauCChNq/A+QjNksNtJjRfsvV1VBMgz
         2MDcgDulc4Hi+SQANQ+HULrIMOboirX4CaW70uOrXBWdptb3Q5U36Au/9N59MlH91soG
         3LQwzoT4wM0rn1p2qh+I6OXBhR27VSum7F51gMjM6NGZf7rrO+3rzMbuNTR2x/9f5GyD
         4jwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aa222P3OEivDagpe+TMlil00hMhGkQHB4uAGX9LVagA=;
        b=ZVI7a1CRjd1b5YvdOYDXWu82ksZL3azR+Vs6I604qa/5MsEMJpYCIHfh6H45OdfiMI
         W3bZsOSaKNV5QZ3cW3pJRq2B93CgMBlyI03gE5irTJBD7DsNKCZVwVzfsYjGlGiEjm3H
         rDemCjdnCFgqi/P18Ba8dYrpJRirAkPiKPkOrtbyWxBHMr+Yp/xK/bbOVUp4AZhZCPGn
         l4HV3GRwLDa+MPD7wqu/sYntRB5cvoLobgWXzIlfY0COIi/6pIE+2kOd1GAMhJSRD8cr
         XNsRWbR6iHAkdFgXueVkEMWgvJuVz5l1SVzsq5hHPUSch+Isp0q0eE6FQdd3AHPhdO1z
         2ADQ==
X-Gm-Message-State: AOAM531Wa3iR6KbymPcYUNA2P/fDHWDAYwBN77ztYT7AsWfD/x48cjUl
        0v3rheGbtYjqEg0LBzleY0gC+Mo4T/u7rtDvuA4=
X-Google-Smtp-Source: ABdhPJwDh9WuFojwU+aW9NLBZhyvnkojKd09zP8CKP4/XR5aEsdp0pYRFhGlLPlw+Pq2CBvCTYE1m+ErpXozY51h+7w=
X-Received: by 2002:a05:6808:650:: with SMTP id z16mr13791304oih.167.1614020038934;
 Mon, 22 Feb 2021 10:53:58 -0800 (PST)
MIME-Version: 1.0
References: <cover.1613593946.git.matheus.bernardino@usp.br>
 <6e30f133e234ff1d3a29f36423cd3fdca58d8095.1613593946.git.matheus.bernardino@usp.br>
 <xmqqpn0yi9ii.fsf@gitster.g>
In-Reply-To: <xmqqpn0yi9ii.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Feb 2021 10:53:47 -0800
Message-ID: <CABPp-BF6GpoDtMfpzf=3VWL_puuRH-cNV=9KajdF1003Fe05jA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/7] t3705: add tests for `git add` in sparse checkouts
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 3:01 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Matheus Tavares <matheus.bernardino@usp.br> writes:
>
> > We already have a couple tests for `add` with SKIP_WORKTREE entries in
> > t7012, but these only cover the most basic scenarios. As we will be
> > changing how `add` deals with sparse paths in the subsequent commits,
> > let's move these two tests to their own file and add more test cases
> > for different `add` options and situations. This also demonstrates two
> > options that don't currently respect SKIP_WORKTREE entries: `--chmod`
> > and `--renormalize`.
>
> Nice.  It makes sense to describe what we want first, like this step..
>
> > Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> > ---
> >  t/t3705-add-sparse-checkout.sh   | 92 ++++++++++++++++++++++++++++++++
> >  t/t7012-skip-worktree-writing.sh | 19 -------
> >  2 files changed, 92 insertions(+), 19 deletions(-)
> >  create mode 100755 t/t3705-add-sparse-checkout.sh
> >
> > diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> > new file mode 100755
> > index 0000000000..5530e796b5
> > --- /dev/null
> > +++ b/t/t3705-add-sparse-checkout.sh
> > @@ -0,0 +1,92 @@
> > +#!/bin/sh
> > +
> > +test_description='git add in sparse checked out working trees'
> > +
> > +. ./test-lib.sh
> > +
> > +SPARSE_ENTRY_BLOB=""
> > +
> > +# Optionally take a string for the entry's contents
> > +setup_sparse_entry()
> > +{
>
> Style.
>
>         setup_sparse_entry () {
>
> on a single line.
>
> > +     if test -f sparse_entry
> > +     then
> > +             rm sparse_entry
> > +     fi &&
> > +     git update-index --force-remove sparse_entry &&
>
> Why not an unconditional removal on the working tree side?
>
>         rm -f sparse_entry &&
>         git update-index --force-remove sparse_entry &&
>
> Are there cases where we may have sparse_entry directory here?
>
> > +
> > +     if test "$#" -eq 1
>
> No need to quote $# (we know it is a number).
>
> > +     then
> > +             printf "$1" >sparse_entry
>
> Make sure the test writers know that they are passing a string that
> will be interpreted as a printf format.  Review the comment before
> the function and adjust it appropriately ("a string" is not what you
> want to tell them).
>
> > +     else
> > +             printf "" >sparse_entry
>
> Just
>
>                 >sparse_entry
>
> is sufficient, no?
>
> > +     fi &&
> > +     git add sparse_entry &&
> > +     git update-index --skip-worktree sparse_entry &&
> > +     SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
> > +}
> > +
> > +test_sparse_entry_unchanged() {
>
> Style.
>
>         test_sparse_entry_unchanged () {
>
> > +     echo "100644 $SPARSE_ENTRY_BLOB 0       sparse_entry" >expected &&
> > +     git ls-files --stage sparse_entry >actual &&
> > +     test_cmp expected actual
>
> OK.  So the expected pattern is to first "setup", do stuff that
> shouldn't affect the sparse entry in the index, and then call this
> to make sure?
>
> > +}
>
> > +test_expect_success "git add does not remove SKIP_WORKTREE entries" '
>
> We use the term SKIP_WORKTREE and SPARSE interchangeably here.  I
> wonder if it is easier to understand if we stick to one e.g. by
> saying "... does not remove 'sparse' entries" instead?  I dunno.
>
> > +     setup_sparse_entry &&
> > +     rm sparse_entry &&
> > +     git add sparse_entry &&
> > +     test_sparse_entry_unchanged
>
> Wow.  OK.  Makes a reader wonder what should happen when the two
> operations are replaced with "git rm sparse_entry"; let's read on.
>
> > +'
> > +
> > +test_expect_success "git add -A does not remove SKIP_WORKTREE entries" '
> > +     setup_sparse_entry &&
> > +     rm sparse_entry &&
> > +     git add -A &&
> > +     test_sparse_entry_unchanged
> > +'
>
> OK.  As there is nothing other than sparse_entry in the working tree
> or in the index, the above two should be equivalent.
>
> I wonder what should happen if the "add -A" gets replaced with "add .";
> it should behave the same way, I think.  Is it worth testing that
> case as well, or is it redundant?
>
> > +for opt in "" -f -u --ignore-removal
> > +do
> > +     if test -n "$opt"
> > +     then
> > +             opt=" $opt"
> > +     fi
>
> The above is cumulative, and as a consequence, "git add -u <path>"
> is not tested, but "git add -f -u <path>" is.  Intended?  How was
> the order of the options listed in "for opt in ..." chosen?
>
> > +     test_expect_success "git add$opt does not update SKIP_WORKTREE entries" '
> > +             setup_sparse_entry &&
> > +             echo modified >sparse_entry &&
> > +             git add $opt sparse_entry &&
> > +             test_sparse_entry_unchanged
> > +     '
> > +done
> > +
> > +test_expect_success 'git add --refresh does not update SKIP_WORKTREE entries' '
> > +     setup_sparse_entry &&
> > +     test-tool chmtime -60 sparse_entry &&
> > +     git add --refresh sparse_entry &&
> > +
> > +     # We must unset the SKIP_WORKTREE bit, otherwise
> > +     # git diff-files would skip examining the file
> > +     git update-index --no-skip-worktree sparse_entry &&
> > +
> > +     echo sparse_entry >expected &&
> > +     git diff-files --name-only sparse_entry >actual &&
> > +     test_cmp actual expected
>
> Hmph, I am not sure what we are testing at this point.  One way to
> make the final diff-files step show sparse_entry would be for "git
> add --refresh" to be a no-op, in which case, the cached stat
> information in the index would be different in mtime from the path
> in the working tree.  But "update-index --no-skip-worktree" may be
> buggy and further change or invalidate the cached stat information
> to cause diff-files to report that the path may be different.
>
> > +'
> > +
> > +test_expect_failure 'git add --chmod does not update SKIP_WORKTREE entries' '
> > +     setup_sparse_entry &&
> > +     git add --chmod=+x sparse_entry &&
> > +     test_sparse_entry_unchanged
>
> Hmph.  Should we also check if sparse_entry in the filesystem also
> is not made executable, not just the entry in the index?
>
> > +'
> > +
> > +test_expect_failure 'git add --renormalize does not update SKIP_WORKTREE entries' '
> > +     test_config core.autocrlf false &&
> > +     setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
> > +     echo "sparse_entry text=auto" >.gitattributes &&
> > +     git add --renormalize sparse_entry &&
> > +     test_sparse_entry_unchanged
>
> Makes sense.
>
> What should "git diff sparse_entry" say at this point, I have to
> wonder?

It'll show nothing:

$ git show :0:sparse_entry
LINEONE
LINETWO
$ echo foobar >sparse_entry
$ cat sparse_entry
foobar
$ git diff sparse_entry
$

Likewise, `git status` will ignore SKIP_WORKTREE entries, and `reset
--hard` will fail to correct these files.  Several of these were
discussed at https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/;
Matheus is just cleaning up the first few candidates.

I thought that present-despite-SKIP_WORKTREE-setting files would be
extremely rare.  While they are somewhat rare, they show up more than
I thought.  The reason I've seen them appear for users is that they
hit Ctrl+C in the middle of progress updates for a `git
sparse-checkout {disable,add} ...` command; they decide mid-operation
that they specified the wrong set of sparsity paths or didn't really
want to unsparsify or whatever, and wrongly assume that operations are
atomic (individual files are checked out to the working copy first,
followed by an update of the index and .git/info/sparse-checkout file
at the end).

The same kind of issue exists without SKIP_WORKTREE when people use
checkout or switch to change branches and hit Ctrl+C in the middle,
but `git status` will warn users about those and `git reset --hard`
will clean them up.  Neither is true in the
present-despite-SKIP_WORKTREE files case.  That should also be fixed
up, but add & rm were easier low-hanging fruit.
