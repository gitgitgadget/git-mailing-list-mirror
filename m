Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334A0C63777
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 07:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE39120B80
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 07:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgLCHzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 02:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgLCHzA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 02:55:00 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5294BC061A4D
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 23:54:20 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id h19so963999otr.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 23:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AxIOFpf2wcPnT98gzdU3TbfMf31xyk2opHmRFD8yaj4=;
        b=K91m/NJ16fF7ylxjxy00SUt+axqKjHmCEXsD5GHdpK0cEl/sS5dlHluGRIXlG/ZtDy
         V3MpHdf0AkzkfJ3pPjLRnayLgfulgJ3ahTlSyDQJ4jmWLrrYSCBVy51Zivvoa6F31O3o
         uaskjW/F2NSRT5uYt3Q+GnDOjXMjRULP93pSkanRSugFVYf3RFuBMzj14o+O+pVmW/KV
         RP/AxrwXFK1avP/uLJBzcjH8jLR7zC3HeVjBfVdK6gUOplD6LHkcHOFoGRb4BsdwjMRN
         SoQbdu01R/pp7klRT6aLiIyq5GKXOilnbP2Y2UnMzO24BlIzCygOrbjDKTwW5qzPzWoy
         5eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AxIOFpf2wcPnT98gzdU3TbfMf31xyk2opHmRFD8yaj4=;
        b=OLDAwpfSMFZ5pyaZJuOjI0gmNXCgTKJfWoT3U46v3LTaCgoZyNPna6ZEWnze0j/3CZ
         Pn9jymIpO1tGKpRw9Uy3nQL6cZGL4yXGTZMzuiQLZvzbJznrcNifHMEChYzu8zT24uK9
         LOlVnB3/LxUVWDCGqLpndGwGJ9tJvz6FrT+7u+5kcjo4GX1txTml0k7mxsotfLlfiZfu
         Q84fSXMhCPihgrEFW0vosJ8jStMDxI3LkHkVQRV8iyvMP7zZp7qdF8PDvmECUrMGU5/x
         Q4gkGfuMYfaEZXTqFf32I9/yPFHsw5CLWC8QhoW25gNphML7w30gR6evfjIq+NQhkR5Q
         4+FQ==
X-Gm-Message-State: AOAM533H0kgrpR2dpgKOFb0ZceDZqVrnJxsUeajrRn1AP9KOUFz8Mq+3
        oXiSa01jh7E+shnsdrlOHvURvHnNqxB8Ysp68Xk=
X-Google-Smtp-Source: ABdhPJxW2wBJD58BpLtuad218kB6gKUNNdwf/GMB7u3IftkTX4FvWi0U7HCqh945bWfNCTlkVXFJfXsKMDhJfD0c0Ds=
X-Received: by 2002:a05:6830:1002:: with SMTP id a2mr1240838otp.316.1606982059480;
 Wed, 02 Dec 2020 23:54:19 -0800 (PST)
MIME-Version: 1.0
References: <20201101193330.24775-1-sorganov@gmail.com> <20201108213838.4880-1-sorganov@gmail.com>
In-Reply-To: <20201108213838.4880-1-sorganov@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Dec 2020 23:54:08 -0800
Message-ID: <CABPp-BHdhvLRe4jCSsRtPrbh2=kwJxEQs0Dx+Ng1Vutx8Hdqqw@mail.gmail.com>
Subject: Re: [PATCH v1 00/27] git-log: implement new --diff-merge options
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 8, 2020 at 1:43 PM Sergey Organov <sorganov@gmail.com> wrote:
>
> These patch series implement new set of options governing the diff output
> of merge commits, all under the umbrella of the single --diff-merges=<mode>
> option. Most of the new options being synonyms for -m/-c/--cc options,
> there is also additional functionality provided, allowing to get the format
> of "-p --first-parent" without change in history traversal that
> --first-parent option causes.
>
> The net result of these series are the following new options:
>
> --diff-merges=   |  old equivalent
> -----------------+----------------
> first-parent     | --first-parent (only format implications)
> separate         | -m
> combined         | -c
> dense-combined   | --cc

Interesting.  I have some local patches implementing another choice,
with the new flag --remerge-diff.  This flag will cause `git show` or
`git log` to automatically remerge the two parents in a 2-parent merge
commit, and then diff the merge commit against that automatic merge,
showing the result.  Thus, the diff for a merge commit is likely to be
empty if the merge was clean, and is likely to show the removal of
conflict markers if the merge was not clean.

I'm curious how it'd interact with this new option.  Would it also get
a name, e.g. --diff-merges=remerge-diff?  Feels like a mouthful, but I
can't come up with anything better.

Also, I'm curious how it'd interact with another option I added, named
--remerge-diff-only.  This latter option modifies revision traversal
in that it skips octopus merges, root commits, and single parent
commits IF no cherry-pick or revert information can be found.  If it
finds a 2-parent merge commit, it behaves like --remerge-diff.  If it
finds a 1-parent commit with cherry-pick or revert information, it'll
do an in memory repeat of that cherry-pick (or revert) and then diff
the actual commit against what the automatic cherry-pick would
perform.  Again, that likely means an empty diff if the automatic
cherry-pick was clean, and showing any changes made by the user to
complete the original cherry-pick (such as deleting conflict markers
and picking which chunks from which side to keep) if the automatic
cherry-pick was not clean.  (I suspect --remerge-diff-only is much
more likely to be used with `git show` than with `git log`.)  Anyway,
your changes seem to suggest that anything relating to how diffs for
merges are handled should be documented in the same section, but
--remerge-diff-only doesn't fit.  And it'd seem odd to have
--remerge-diff and --remerge-diff-only not show up in adjacently but
be split into separate sections.  Any ideas?

(This doesn't matter yet, since I'm waiting for merge-ort to be
completed before submitting the --remerge-diff and --remerge-diff-only
patches, but thought I'd bring it up as food for thought and to query
if others have good ideas about how to handle the names and
documentation location.)

> The series also cleanup logic of handling of diff merges options and fix an
> issue found in the original implementation where logically mutually
> exclusive options -m/-c/--cc failed to actually override each other.
>
> The series start with the set of pure refactoring commits that are expected
> to introduce no functional changes. These are all commits up to and
> including:
>
> "diff-merges: revise revs->diff flag handling"
>
> The aim of these commits is to isolate options handling for diff merges so
> that it could be easily understood and tweaked to ease introduction of the
> new options.
>
> Then the fix of -m/-c/-cc overriding issue follows, starting with a failing
> test and followed by the fix.
>
> Then follows a little bit of additional refactoring in order to prepare for
> introduction of the new options, and finally the series are finished by the
> implementation, testing, and documentation update for the new options.
>
> Updates in v1:

A minor point, but this should have been labelled v2.  The unlabelled
original submission is v1.

>
>         * Added documentation fix for git-show to include --diff-merges.
>         * Fixed typos in commit messages noticed by Philip Oakley.
>
> Sergey Organov (27):
>   revision: factor out parsing of diff-merge related options
>   revision: factor out setup of diff-merge related settings
>   revision: factor out initialization of diff-merge related settings
>   revision: provide implementation for diff merges tweaks
>   revision: move diff merges functions to its own diff-merges.c
>   diff-merges: rename all functions to have common prefix
>   diff-merges: move checks for first_parent_only out of the module
>   diff-merges: rename diff_merges_default_to_enable() to match semantics
>   diff-merges: re-arrange functions to match the order they are called
>     in
>   diff-merges: new function diff_merges_suppress()
>   diff-merges: new function diff_merges_set_dense_combined_if_unset()
>   diff-merges: introduce revs->first_parent_merges flag
>   diff-merges: revise revs->diff flag handling
>   t4013: support test_expect_failure through ':failure' magic
>   t4013: add tests for -m failing to override -c/--cc
>   diff-merges: fix -m to properly override -c/--cc
>   diff-merges: split 'ignore_merges' field
>   diff-merges: group diff-merge flags next to each other inside
>     'rev_info'
>   diff-merges: get rid of now empty diff_merges_init_revs()
>   diff-merges: refactor opt settings into separate functions
>   diff-merges: make -m/-c/--cc explicitly mutually exclusive
>   diff-merges: implement new values for --diff-merges
>   t4013: add test for --diff-merges=first-parent
>   doc/git-log: describe new --diff-merges options
>   doc/diff-generate-patch: mention new --diff-merges option
>   doc/rev-list-options: document --first-parent implies
>     --diff-merges=first-parent
>   doc/git-show: include --diff-merges description
>
>  Documentation/diff-generate-patch.txt         |   6 +-
>  Documentation/diff-options.txt                |  54 +++++
>  Documentation/git-log.txt                     |  39 ----
>  Documentation/git-show.txt                    |   8 +-
>  Documentation/rev-list-options.txt            |   3 +
>  Makefile                                      |   1 +
>  builtin/diff-files.c                          |   5 +-
>  builtin/diff.c                                |   9 +-
>  builtin/log.c                                 |  18 +-
>  builtin/merge.c                               |   3 +-
>  diff-merges.c                                 | 120 +++++++++++
>  diff-merges.h                                 |  18 ++
>  fmt-merge-msg.c                               |   3 +-
>  log-tree.c                                    |  17 +-
>  revision.c                                    |  38 +---
>  revision.h                                    |   7 +-
>  t/t4013-diff-various.sh                       |  10 +-
>  t/t4013/diff.log_--cc_-m_-p_master            | 200 ++++++++++++++++++
>  t/t4013/diff.log_-c_-m_-p_master              | 200 ++++++++++++++++++
>  ...f.log_-p_--diff-merges=first-parent_master | 137 ++++++++++++
>  20 files changed, 788 insertions(+), 108 deletions(-)
>  create mode 100644 diff-merges.c
>  create mode 100644 diff-merges.h
>  create mode 100644 t/t4013/diff.log_--cc_-m_-p_master
>  create mode 100644 t/t4013/diff.log_-c_-m_-p_master
>  create mode 100644 t/t4013/diff.log_-p_--diff-merges=first-parent_master
>
> --
> 2.25.1
