Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2071BC433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF0C233CF
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbhAGSWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbhAGSWc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 13:22:32 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79522C0612F6
        for <git@vger.kernel.org>; Thu,  7 Jan 2021 10:21:52 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id x13so8376094oic.5
        for <git@vger.kernel.org>; Thu, 07 Jan 2021 10:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E0EUT8x8Td0vBl/DZj6337FI47Mu4xg5q9dkUDaP/xY=;
        b=mgsmXDJsTf9L5OVJvHFYtXAUnSuqI/F84sEZiQZlujmzVrIZrfKv/AHzmYDuPITJpj
         H+NuUasA7SVxnT5BbrDatYNdVwcJojwbEA+4IV6tpvKOHCAmnXKGEr2l8Rdk6cOLM8iN
         vxOdDudE6QX/7XqTMamG295UnhLgJJipDu/Sf5O6z/4eq9XsI4zcC+NrIj0pquc2rpNg
         VcFoX17wrZvgrwqrSjypn77Y/Q2XwOAwRBcmQyCtShtQ6mFl4AZlWf4oA8ECEdQLbojq
         76hgAgMTAaP/v2i0OiJQrI9cfzwZXoFVLz9p9oR+WAoHCo+EZ/4jvWRtloQilcDAVZCJ
         tgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E0EUT8x8Td0vBl/DZj6337FI47Mu4xg5q9dkUDaP/xY=;
        b=HvOZR70E6DRB9ThCgeZPvugjqXFdeJ//6ZGwZffnDRciZc4L0q/ryc6ZIJ0MgIK9hy
         rkEI9wIv5mzD3sWF+EP7gHn+wrjM0T17WFhvx1r8nAtnv+ei7SW7pNiYzAL8UpodXx0K
         6gxYAT4VxOg/24/INXrOSWCSt65idi30bi6BMRsWfzJzrfC2nT8UsR424+Zs1iiHMCZA
         Pm6vJpWBNlPgisw4vIyR70gAoUoeUsiiq6Ix5WsTbb4u29luICkhdWB4JHhdxUFarR0C
         WjpEefxzW+LWyvq3cogFzP4gYOtQtUey08Ygbf2s+mNBGjxr6jrWJ8p6tKa3HLo9jyCK
         9x0A==
X-Gm-Message-State: AOAM531qVFeMt90EyxAnLkoFg5/NoLiNtL9s9OJQ45fSpYhv8+V2f69c
        1b2VASV4l/9MxkYgT/GsdKI1TVrHejFT6i4GfYc=
X-Google-Smtp-Source: ABdhPJzAaiq6D/b5e+4DFaiY6DYit/q88ym2w9oVx3TS/8DwJyhnMPIzzQBby4XzkNy0D6iJAaccb046MGgh+Xg2gmI=
X-Received: by 2002:a54:4185:: with SMTP id 5mr2157021oiy.31.1610043711787;
 Thu, 07 Jan 2021 10:21:51 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqa6tkn9xw.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 7 Jan 2021 10:21:40 -0800
Message-ID: <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #01; Wed, 6)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio (& Matheus),

On Thu, Jan 7, 2021 at 5:41 AM Junio C Hamano <gitster@pobox.com> wrote:
> * mt/grep-sparse-checkout (2020-12-06) 10 commits
>  - t7817: do not depend on any specific default branch name
>  - config: add setting to ignore sparsity patterns in some cmds
>  - grep: honor sparse checkout patterns
>  - config: correctly read worktree configs in submodules
>  - config: make do_git_config_sequence receive a 'struct repository'
>  - t/helper/test-config: unify exit labels
>  - t/helper/test-config: diagnose missing arguments
>  - t/helper/test-config: be consistent with exit codes
>  - t1308-config-set: avoid false positives when using test-config
>  - doc: grep: unify info on configuration variables
>  (this branch is used by mt/rm-sparse-checkout.)
>
>  "git grep" has been tweaked to be limited to the sparse checkout
>  paths.
>
>
> * mt/rm-sparse-checkout (2020-12-08) 1 commit
>  - rm: honor sparse checkout patterns
>  (this branch uses mt/grep-sparse-checkout.)
>
>  "git rm" follows suit to "git grep" to ignore paths outside the
>  sparsity pattern when the sparse checkout feature is in use.
>
>  Need to wait for how these fit in larger picture.
>  cf. <CABPp-BGMX3wb7LiS1HkJpGveoW3J1oR0vVHbKTF5+qYLRF+59g@mail.gmail.com>

Larger picture provided last week[1].  I would now say that:
  * mt/rm-sparse-checkout needs some small changes (Matheus: I'm happy
to tweak the patch and add a Helped-by: Elijah to it if you want me to
push those changes)
  * the bug fix part of mt/grep-sparse-checkout could possibly be
broken out and merged now (Matheus: similar question here...do you
want help with this?)
  * the other parts of mt/grep-sparse-checkout should probably wait
off based on Stollee's sparse-index work mentioned later in that
thread (Matheus: I'm so sorry we've delayed your series for so long.
I feel bad.  But Stollee is proposing some rather big changes that
could significantly affect this and several other things.)

[1] https://lore.kernel.org/git/CABPp-BGJ_Nvi5TmgriD9Bh6eNXE2EDq2f8e8QKXAeYG3BxZafA@mail.gmail.com/

> * en/merge-ort-recursive (2020-12-16) 4 commits
>   (merged to 'next' on 2020-12-22 at 0dbf60011f)
>  + merge-ort: implement merge_incore_recursive()
>  + merge-ort: make clear_internal_opts() aware of partial clearing
>  + merge-ort: copy a few small helper functions from merge-recursive.c
>  + commit: move reverse_commit_list() from merge-recursive
>  (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-3 and en/ort-conflict-handling.)
>
>  The ORT merge strategy learned to synthesize virtual ancestor tree
>  by recursively merging multiple merge bases together, just like the
>  recursive backend has done for years.
>
>  Will merge to 'master'.

Thanks.

> * en/merge-ort-3 (2020-12-15) 11 commits
>  - merge-ort: add implementation of type-changed rename handling
>  - merge-ort: add implementation of normal rename handling
>  - merge-ort: add implementation of rename collisions
>  - merge-ort: add implementation of rename/delete conflicts
>  - merge-ort: add implementation of both sides renaming differently
>  - merge-ort: add implementation of both sides renaming identically
>  - merge-ort: add basic outline for process_renames()
>  - merge-ort: implement compare_pairs() and collect_renames()
>  - merge-ort: implement detect_regular_renames()
>  - merge-ort: add initial outline for basic rename detection
>  - merge-ort: add basic data structures for handling renames
>  (this branch uses en/merge-ort-2 and en/merge-ort-impl; is tangled with en/merge-ort-recursive and en/ort-conflict-handling.)
>
>  Rename detection is added to the "ORT" merge strategy.

Is there a reason this is being held back in seen?  It was submitted
and reviewed[2] before en/merge-ort-recursive which you've marked for
merging to master.  I'm not aware of any outstanding review issues,
and think it's ready to merge down.

[2] https://lore.kernel.org/git/xmqqh7om7mdc.fsf@gitster.c.googlers.com/;
and note that the one (embarrassing) issue highlighted in that revew
was addressed at
https://lore.kernel.org/git/pull.812.v3.git.1608056886.gitgitgadget@gmail.com/

> * en/diffcore-rename (2021-01-04) 9 commits
>  - diffcore-rename: remove unnecessary duplicate entry checks
>  - diffcore-rename: accelerate rename_dst setup
>  - diffcore-rename: simplify and accelerate register_rename_src()
>  - t4058: explore duplicate tree entry handling in a bit more detail
>  - t4058: add more tests and documentation for duplicate tree entry handling
>  - diffcore-rename: reduce jumpiness in progress counters
>  - diffcore-rename: simplify limit check
>  - diffcore-rename: avoid usage of global in too_many_rename_candidates()
>  - diffcore-rename: rename num_create to num_destinations
>
>  File-level rename detection updates.

I'm curious again about your workflow and the meanings of your
messages.  Here, I'm surprised by the change in date; in [2] you
listed it as 2020-12-14.  Do you update the dates when you pull in new
versions of the patch series?  (In particular, I submitted one just
before the new year that did nothing more than correct the
'unneccessary' typo in a commit message.)  Again, not a big deal, I'm
just trying to understand.

[2] https://lore.kernel.org/git/xmqq3608duhp.fsf@gitster.c.googlers.com/

Anyway, I'm not aware of any outstanding requests for this series; I
think it's ready to start merging down.  Are there issues you are
aware of that you want to see fixed?

> * en/stash-apply-sparse-checkout (2020-12-01) 3 commits
>  - stash: fix stash application in sparse-checkouts
>  - stash: remove unnecessary process forking
>  - t7012: add a testcase demonstrating stash apply bugs in sparse checkouts
>
>  "git stash" did not work well in a sparsely checked out working
>  tree.
>
>  Will merge to 'next'.

Thanks.
