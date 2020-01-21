Return-Path: <SRS0=4+BP=3K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95BAC33CAA
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2FFD24125
	for <git@archiver.kernel.org>; Tue, 21 Jan 2020 08:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl82N9QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgAUIoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:44:25 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:36197 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUIoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jan 2020 03:44:25 -0500
Received: by mail-il1-f196.google.com with SMTP id b15so1751143iln.3
        for <git@vger.kernel.org>; Tue, 21 Jan 2020 00:44:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3YmUszJbs/xj4pYjoyLJblN0UfU2KJZCjpn+zZsUqEc=;
        b=cl82N9QUmcDPKPOwZq9Y9UCHmpUTnjtk6N2la8yJzLZB4YbpV9vSkPMVvVW06WHkir
         UKgHZqw42qjeX+peNMEdX+TmgXoozUnubxHDmdl7vuWUDx4c4CUQpEzTgBJCGqrThtv8
         vNxFzn9YX5Kpy9Cf1yR76ZYKVOqHPF1Zg21paaEKPLbSvGfshwNao6ig70zHrunFz0Kw
         Vr1Fvk0l1tVBmJxukhOiyGCtQ595ScfballQD5JWB6/oEYnvmm2Yjd2Tq3kXC2nCGHGv
         HYlyRsMaH32W9b8L9EL4ePrPgkATLyz2Bh3gOA5xXorNS9QMW45xWGjctqLzJw+gUgQM
         WVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3YmUszJbs/xj4pYjoyLJblN0UfU2KJZCjpn+zZsUqEc=;
        b=OOporobvABsobQpV7GNEYKhEQMpcdMLs1GM8DQK7I4n3kOKVbeFJO5rE1A6G422A6e
         RCQjhzi0+L+Hgp3ZPUw3noBKANMMplUN5fnX+Za66W0tw5VxtNuVjVL4RA5e+ycXVIK9
         wKbhYBECQdWFe0oFUe/YqA2BnG/XBBCoLR6TNl0lng3hjrPzUElqg0Qs1DHvIpekgAup
         qoPA7eoaBC+wCk8Uo69XLscqYMPValaQ4M1U/vE5wjjio1FyVbKwrBlfsQFbqvwh8zFv
         8agsGcSm/6i2b79LtaleSsjga7tBNT8c1KW5xM1OSuCS7psL2iA4VlA0n960igQQJoWb
         7LZw==
X-Gm-Message-State: APjAAAXhc6RFI5GfOXNsTNoA9Qmco9fRPYARlbsG4ztz8tfNSBybShDc
        m8DKCPYnZgPoUsHeySew4aC4wfrwVgx+3zc/8Nk=
X-Google-Smtp-Source: APXvYqyCF8qjYPJvZiN/pIw/DDM8yCUU4uNRnDkCUfTH0R8HNoB35vaBsYAWdHHgguLEa9/VGIi/LoI1XLvw/xUknVY=
X-Received: by 2002:a92:b06:: with SMTP id b6mr2600224ilf.127.1579596264217;
 Tue, 21 Jan 2020 00:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20200120143800.900-1-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2001202237140.46@tvgsbejvaqbjf.bet>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 21 Jan 2020 09:44:13 +0100
Message-ID: <CAN7CjDC-UrD0sTE=jjNm8=tYsS5-X8p_u_8LYuvRix=_QvnxfA@mail.gmail.com>
Subject: Re: [Outreachy][PATCH 00/29] Finish converting git bisect to C part 1
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

El lun., 20 ene. 2020 a las 22:41, Johannes Schindelin
(<Johannes.Schindelin@gmx.de>) escribi=C3=B3:
>
> Hi Miriam,
>
> On Mon, 20 Jan 2020, Miriam Rubio wrote:
>
> > --- Changes since Tanushree=E2=80=99s pr117 sent patch series:
> > https://public-inbox.org/git/pull.117.git.gitgitgadget@gmail.com) ---
> >
> > General changes
> > ---------------
> >
> > * Rebase on master branch.
> > * Improve commit messages.
> > * Amend patch series titles.
> > * Reorder commits: first clean-up/preparatory commits, squash or split
> > commits.
>
> Great!
>
> > Specific changes
> > ----------------
> >
> > [1/29] bisect--helper: convert `vocab_*` char pointers to char arrays
> >
> > * New patch to convert `vocab_bad` and `vocab_good` char pointers
> > to char arrays
>
> 29 patches is _a lot_ to review. I would have preferred a series of
> smaller patch series.

Ok, I will discuss with my mentor how is the best way to split all this wor=
k.

>
> For example, the first three patches would have made for a fine "some
> cleanups" patch series, from my point of view.
>
> Also, as the mail's subject says "part 1", it would be good to have an
> overview how this part fits into the overall story of converting `git
> bisect` into a built-in.
>
> Finally, it would be nice to have a link to a public repository with the
> branch from which these mails were generated.
>

This is the link of the current branch:
https://gitlab.com/mirucam/git/commits/git-bisect-work2.8.2
I will add the public repository link on next cover-letters.
Thank you for the suggestion.

> I will try to review this patch series in its entirety, but it will take
> me a while.

Thank you very much for reviewing.
Best,
Miriam
>
> Ciao,
> Johannes
>
> >
> > --
> >
> > [2/29] bisect--helper: change `retval` to `res`
> >
> > * Replace one last variable `retval` to `res`.
> >
> > --
> >
> > [3/29] bisect: use the standard 'if (!var)' way to check for 0
> >
> > * New patch to use '!var' and make 'bisect.c' more consistent with the
> > rest of the code
> >
> > --
> >
> > [4/29] run-command: make `exists_in_PATH()` non-static
> >
> > * Add comment before function declaration.
> > * Move function declaration in `run-command.h`.
> >
> > --
> >
> > [6/29] bisect: libify `exit_if_skipped_commits` to `error_if_skipped*`
> > and its dependents
> >
> > * Fix `mark_edges_uninteresting()` and `show_diff_tree()` calls after
> > rebase on master.
> >
> > --
> >
> > [7/29] bisect: libify `bisect_checkout`
> >
> > * Fix `memcpy()` call after rebase on master.
> > * Introduce `res` variable to return `bisect_checkout()` output.
> > * Fix `get_commit_reference()` declaration after rebase on master.
> >
> > --
> >
> > [8/29] bisect: libify `check_merge_bases` and its dependents
> >
> > State: Previously sent
> >
> > * Fix `check_ancestors()` declaration after rebase on master.
> > * Fix `get_bad_and_good_commits()` call after rebase on master.
> >
> > --
> >
> > [9/29] bisect: libify `check_good_are_ancestors_of_bad` and its
> > dependents
> >
> > State: Previously sent
> >
> > * Fix `check_good_are_ancestors_of_bad()` declaration after rebase on
> > master.
> > * Fix `check_good_are_ancestors_of_bad()`, `bisect_next_all()`
> > and `bisect_rev_setup()` calls after rebase on master.
> >
> > --
> >
> > [11/29] bisect: libify `bisect_next_all`
> >
> > State: Previously sent
> >
> > * Fix `show_diff_tree()` call after rebase on master.
> >
> > --
> >
> > [12/29] bisect--helper: reimplement `bisect_next` and `bisect_auto_next=
`
> > shell functions in C
> >
> > * Fix `repo_init_revisions()` and `bisect_next_all()` calls after rebas=
e
> > on master.
> > * Remove `goto` statement in `bisect_skipped_commits()`
> >
> > --
> >
> > [13/29] bisect--helper: finish porting `bisect_start()` to C
> >
> > * Change `return` statement instead of `die` in error handling.
> > * Remove `goto` statements in `bisect_skipped_commits()`.
> >
> > --
> >
> > [21/29] bisect--helper: reimplement `bisect_replay` shell function in C
> >
> > * Add blank line in `get_next_word()`.
> > * Remove `goto` statements in `bisect_replay()`.
> >
> > --
> >
> > [23/29] bisect--helper: use `res` instead of return in BISECT_RESET cas=
e
> > option
> >
> > * New patch to split previous commit in two.
> >
> > --
> >
> > [26/29] bisect--helper: reimplement `bisect_skip` shell function in C
> >
> > State: Previously sent
> >
> > * Add blank line.
> >
> > --
> >
> > [28/29] bisect--helper: reimplement `bisect_visualize()`shell function
> > in C
> >
> > New patch:
> >
> > * Reimplement the `bisect_visualize()` shell function in C.
> > * Add `--bisect-visualize` subcommand.
> > * Fix long code line.
> >
> > --
> >
> > [29/29] bisect--helper: reimplement `bisect_run` shell function in C
> >
> > New patch:
> >
> > * Reimplement the `bisect_run()` shell function in C.
> > * Add `--bisect-run` subcommand.
> > * Remove blank line.
> >
> > --
> >
> > Miriam Rubio (2):
> >   bisect--helper: convert `vocab_*` char pointers to char arrays
> >   bisect: use the standard 'if (!var)' way to check for 0
> >
> > Pranit Bauva (24):
> >   run-command: make `exists_in_PATH()` non-static
> >   bisect: libify `exit_if_skipped_commits` to `error_if_skipped*` and
> >     its dependents
> >   bisect: libify `bisect_checkout`
> >   bisect: libify `check_merge_bases` and its dependents
> >   bisect: libify `check_good_are_ancestors_of_bad` and its dependents
> >   bisect: libify `handle_bad_merge_base` and its dependents
> >   bisect: libify `bisect_next_all`
> >   bisect--helper: reimplement `bisect_next` and `bisect_auto_next` shel=
l
> >     functions in C
> >   bisect--helper: finish porting `bisect_start()` to C
> >   bisect--helper: retire `--bisect-clean-state` subcommand
> >   bisect--helper: retire `--next-all` subcommand
> >   bisect--helper: reimplement `bisect_autostart` shell function in C
> >   bisect--helper: reimplement `bisect_state` & `bisect_head` shell
> >     functions in C
> >   bisect--helper: retire `--check-expected-revs` subcommand
> >   bisect--helper: retire `--write-terms` subcommand
> >   bisect--helper: reimplement `bisect_log` shell function in C
> >   bisect--helper: reimplement `bisect_replay` shell function in C
> >   bisect--helper: retire `--bisect-write` subcommand
> >   bisect--helper: use `res` instead of return in BISECT_RESET case
> >     option
> >   bisect--helper: retire `--bisect-autostart` subcommand
> >   bisect--helper: retire `--bisect-auto-next` subcommand
> >   bisect--helper: reimplement `bisect_skip` shell function in C
> >   bisect--helper: retire `--check-and-set-terms` subcommand
> >   bisect--helper: reimplement `bisect_visualize()`shell function in C
> >
> > Tanushree Tumane (3):
> >   bisect--helper: change `retval` to `res`
> >   bisect--helper: introduce new `decide_next()` function
> >   bisect--helper: reimplement `bisect_run` shell function in C
> >
> >  bisect.c                 | 146 +++++---
> >  builtin/bisect--helper.c | 776 +++++++++++++++++++++++++++++++++------
> >  git-bisect.sh            | 279 +-------------
> >  run-command.c            |   2 +-
> >  run-command.h            |  11 +
> >  5 files changed, 793 insertions(+), 421 deletions(-)
> >
> > --
> > 2.21.1 (Apple Git-122.3)
> >
> >
