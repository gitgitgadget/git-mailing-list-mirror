Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEDDC433EF
	for <git@archiver.kernel.org>; Sat, 26 Feb 2022 08:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiBZIrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 03:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiBZIrh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 03:47:37 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A236E1B84EC
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:47:03 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qk11so15221318ejb.2
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zoVpoL2cX1TLk+1EHaY0HwMCkL5GtdYtLUZZ06R5cIk=;
        b=SKk6zOVy40VFPqj1LhtO+Rugaj+FID0PsjPvDJhFTTKcsOt7wZijm0r6f2ygeVCN0a
         eyp8uQR/tfT6TyQZJ8ToYJjXWty1p1NCmN4S4qc5cQ6HeMZMAZupi2pNSdvddaUA/cf4
         ieINsDOooWtya0rQyDkJoTJgyoiLzVEoJZItIrBetz0HbsTuBh1C6Qi7NSC0YFr1veZc
         pOs1PU+S/JYJKcYNKi4y/KI1MCRKTksv3BofG7wJcPkFY3L0vlhKzmQW2OVOHlJDHgg2
         4t5f1o9wizKJYHftUPzfSOJETY+DfIOXLkeyyZKLnHEudXlhnmcaGd/4pJi4uJD95wUC
         HSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zoVpoL2cX1TLk+1EHaY0HwMCkL5GtdYtLUZZ06R5cIk=;
        b=acEjWBxKFRlj/jyPi/XwxgIG8ypGLpeVR0BBvdTZgXmyExK/oOgtG3HBf2+De61zCL
         B0k443i0rCk3Noxs40IdXm/ej3MSqClqxBntcGIOdEFxZ3HDZd8TEkTCazdjk3k3V51r
         ieCPblyUxGpRtS6jW6uzRFFetAtUy/RSLZaI67uzQueyG2ePNcoZQNM6Zgw9YF+iz+oq
         qWlF1t9POL5YfOFXqMtmW9G6kqvd3wAcApGE1pE8qqB3jGy6QEpDGMXsOenlzvLASWvj
         G9zMuWxmX2UM9SDRjXPSk0HhN/ucsFi2UJukEMKTstZg+gSFk7GYO2HuBs+mKRGDPprn
         xZ0A==
X-Gm-Message-State: AOAM530KA2FRKJpXC01eRAkhOpN0paWkVQSTJwhls5Im1i3u49/bIHE3
        bMNfSZnCNWfQu8w7rcgk8Y2v55dKPOGxzxt6eq4=
X-Google-Smtp-Source: ABdhPJwNLA8YsCxKTY4zFyJfyR6ISY0WKjD3yYLojoxpExqcNLrta+ELVSGQzXLvcnWshvyAbdIdPJAFCMfFkSZTLdc=
X-Received: by 2002:a17:907:11c1:b0:6cf:723b:37af with SMTP id
 va1-20020a17090711c100b006cf723b37afmr8978622ejb.476.1645865222114; Sat, 26
 Feb 2022 00:47:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.1157.git.1645640717.gitgitgadget@gmail.com> <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
In-Reply-To: <pull.1157.v2.git.1645742073.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 26 Feb 2022 00:46:50 -0800
Message-ID: <CABPp-BHu2sDFiDU=xGEr-MzqbtGwcwu+_m3b3gMWri561JyqWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Sparse index: integrate with 'read-tree'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 24, 2022 at 2:34 PM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Like previous integrations [1] [2], this series allows 'git read-tree' to
> operate using a sparse index.
>
> The first two patches are bugfixes for issues found while implementing the
> 'read-tree' integration:
>
>  * The first (patch 1/7) fixes an edge case in which a repo with no in-cone
>    files or directories would have its root collapsed into a sparse
>    directory; the fix ensures the root directory is never collapsed into a
>    sparse directory.
>  * The second (patch 2/7) corrects the 'git status' reporting of changes
>    nested inside the subdirectory of a sparse directory, ensuring that the
>    modified file (not the subdirectory) is correctly reported as having
>    changes.
>
> The remainder of the series focuses on utilizing the sparse index in 'git
> read-tree'. After some baseline behavior-establishing tests (patch 3/7),
> sparse index usage is trivially enabled (patch 4/7) for 'read-tree' except:
>
>  * usage with '--prefix'
>  * two- and three-way merge
>
> These cases require additional changes in order to work as expected (i.e.,
> outwardly matching non-sparse index sparse-checkout). For the former, the
> sparse index can be enabled as long as the index is expanded when the prefix
> is a directory outside the sparse cone (patch 5/7). For the latter, sparse
> directories that cannot be trivially merged must have their contents merged
> file-by-file, done by recursively traversing the trees represented by the
> sparse directories (patches 6/7 & 7/7).
>
>
> Changes since V1
> ================
>
>  * switched an empty string check from '!strlen(path)' to the
>    slightly-less-expensive '!*path'

I've read over the series.  It was a nice read, well motivated, and
split up rather nicely.  I only had a few small commetns.

I think it'd be nice to insert another patch into the series that
throws an error if the argument to --prefix starts with a '/'.  That
would also allow you to simplify patch 5/7 a little.

Patch 6/7 has the right idea, but I'm worried about one part of it; a
test would go a long way towards verifying whether that aspect is
handled correctly or whether my concern is warranted.

I had a couple smaller comments on some of the other patches.

Overall, nicely done.


> Thanks!
>
>  * Victoria
>
> [1]
> https://lore.kernel.org/git/pull.1109.v2.git.1641924306.gitgitgadget@gmail.com/
> [2]
> https://lore.kernel.org/git/pull.1048.v6.git.1638201164.gitgitgadget@gmail.com/
>
> Victoria Dye (7):
>   sparse-index: prevent repo root from becoming sparse
>   status: fix nested sparse directory diff in sparse index
>   read-tree: expand sparse checkout test coverage
>   read-tree: integrate with sparse index
>   read-tree: narrow scope of index expansion for '--prefix'
>   read-tree: make two-way merge sparse-aware
>   read-tree: make three-way merge sparse-aware
>
>  builtin/read-tree.c                      |  10 +-
>  dir.c                                    |   7 +-
>  t/perf/p2000-sparse-operations.sh        |   1 +
>  t/t1092-sparse-checkout-compatibility.sh | 129 +++++++++++++++++++++++
>  unpack-trees.c                           | 121 ++++++++++++++++++++-
>  wt-status.c                              |   9 ++
>  6 files changed, 268 insertions(+), 9 deletions(-)
>
>
> base-commit: e6ebfd0e8cbbd10878070c8a356b5ad1b3ca464e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1157%2Fvdye%2Fsparse%2Fread-tree-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1157/vdye/sparse/read-tree-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1157
>
> Range-diff vs v1:
>
>  1:  90da1f9f33a ! 1:  744668eeece sparse-index: prevent repo root from becoming sparse
>      @@ Commit message
>           non-cone sparse-checkouts), the new check does not cause additional changes
>           to how sparse patterns are applied.
>
>      +    Helped-by: Derrick Stolee <derrickstolee@github.com>
>           Signed-off-by: Victoria Dye <vdye@github.com>
>
>        ## dir.c ##
>      @@ dir.c: static int path_in_sparse_checkout_1(const char *path,
>       +  * patterns, or the patterns are of the wrong type.
>          */
>       - if (init_sparse_checkout_patterns(istate) ||
>      -+ if (!strlen(path) ||
>      ++ if (!*path ||
>       +     init_sparse_checkout_patterns(istate) ||
>             (require_cone_mode &&
>              !istate->sparse_checkout_patterns->use_cone_patterns))
>  2:  c21c9b9be34 = 2:  f0cff03b95d status: fix nested sparse directory diff in sparse index
>  3:  ac42ae21d4a = 3:  ffe0b6aff2b read-tree: expand sparse checkout test coverage
>  4:  5ee193bfa87 = 4:  cb7e0cf419c read-tree: integrate with sparse index
>  5:  bea482b6b28 = 5:  4f05fa70209 read-tree: narrow scope of index expansion for '--prefix'
>  6:  9fdcab038b2 = 6:  94c2aad2f93 read-tree: make two-way merge sparse-aware
>  7:  1502e9acb32 = 7:  c4080e99d6e read-tree: make three-way merge sparse-aware
>
> --
> gitgitgadget
