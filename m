Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D67CC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5860D64EC1
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 23:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhBWX5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 18:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233902AbhBWXuo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 18:50:44 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51908C06178C
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:49:47 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id f33so419605otf.11
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 15:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh3BQjelFm0GD/VgFiKRzX3MIpHTStfwtpp5F0s8rp8=;
        b=f/+GaB5k+/ivtOvQkq6xe651Oro34+OnSJSua0SpUTnBsXZZlwlyo0IH+6cP80E+T6
         bCOj/JoD7xgC2hQMPFpRwRf+jU3fF6/rsnEtq/iOcm/RDQ6lIzRnv1DJDiOP0hgYgiiz
         UwOJxxy4v5NFe6ZhbclhvDVLOuIQIsHgnIXD6C3RBXtoNXqHId9kNdCc+vg+gmHnlyf1
         u0wX4rvqTHSKyabpLHEnSnHH+V+swV5UEickCuZ8SDICGS+OkVLGE4SuF05Yx/l99YIr
         LafQ2Xp/T9RYgGJD1j4jPBNFH7dMs+1ui+nN+Q4+xO1bKGi2TNf89MxGxkVOnFuq05mJ
         cHCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh3BQjelFm0GD/VgFiKRzX3MIpHTStfwtpp5F0s8rp8=;
        b=UOYNj+AhpJdzhw0KVxw4PeQti97GizK+wJe+Vi6qR3zbGOuhDKymIT2gMnRv2rQbOI
         EUZcQA9VEw06Zj9bW/8TxNCnbIzBU28xp/FjHCaZo1c6jTtE5orAXKZ2rEE6wsBwGhMN
         LqIIDV2uuhrOgm4C6iDVCSzD7e20s3owfwum0XD0ZQM7SNZYqhkyeZVTriaV4UZBGOF4
         taIwGfwp06IWRbyAxydUWl7e8P4+RFDDdOkjKvkxHgEiUpc94Uo7CW006fGyBb6+zMKj
         ldjE+Zznnb+r3y2IfFzhFfjx5pbMwhWooCi+XWOHTKqd/IDIw1JV/td/MNnC7RDmHOVY
         +EYQ==
X-Gm-Message-State: AOAM531k7ZvC3D0fuBdwXqXV5/f8feCa+7f8bIefeKb2FwtI9TortAAV
        M94dC60TE4RzSqzV/q/oKB2O6VGeqM3KfWgVllM=
X-Google-Smtp-Source: ABdhPJzFm09mpw/AMxW8CEIaL9IWnOqPXc1OaF6woPP4MpfRMHB4NcNmlpCTyaIfn4YJEA5hr4XGOjVtxqwrAlSeHfI=
X-Received: by 2002:a05:6830:100c:: with SMTP id a12mr7107828otp.345.1614124186636;
 Tue, 23 Feb 2021 15:49:46 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
In-Reply-To: <pull.883.git.1614111270.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 15:49:35 -0800
Message-ID: <CABPp-BEf5F_BT69_V0vOq9CdcNEce6qR5nk+2XZsdS5EeLV0_g@mail.gmail.com>
Subject: Re: [PATCH 00/20] Sparse Index: Design, Format, Tests
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Here is the first full patch series submission coming out of the
> sparse-index RFC [1].

Wahoo!  I'll be reading these over the next few days.

> [1]
> https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/
>
> I won't waste too much space here, because PATCH 1 includes a sizeable
> design document that describes the feature, the reasoning behind it, and my
> plan for getting this implemented widely throughout the codebase.
>
> There are some new things here that were not in the RFC:
>
>  * Design doc and format updates. (Patch 1)
>  * Performance test script. (Patches 2 and 20)
>
> Notably missing in this series from the RFC:
>
>  * The mega-patch inserting ensure_full_index() throughout the codebase.
>    That will be a follow-up series to this one.
>  * The integrations with git status and git add to demonstrate the improved
>    performance. Those will also appear in their own series later.
>
> I plan to keep my latest work in this area in my 'sparse-index/wip' branch
> [2]. It includes all of the work from the RFC right now, updated with the
> work from this series.
>
> [2] https://github.com/derrickstolee/git/tree/sparse-index/wip
>
> Thanks, -Stolee
>
> Derrick Stolee (20):
>   sparse-index: design doc and format update
>   t/perf: add performance test for sparse operations
>   t1092: clean up script quoting
>   sparse-index: add guard to ensure full index
>   sparse-index: implement ensure_full_index()
>   t1092: compare sparse-checkout to sparse-index
>   test-read-cache: print cache entries with --table
>   test-tool: don't force full index
>   unpack-trees: ensure full index
>   sparse-checkout: hold pattern list in index
>   sparse-index: convert from full to sparse
>   submodule: sparse-index should not collapse links
>   unpack-trees: allow sparse directories
>   sparse-index: check index conversion happens
>   sparse-index: create extension for compatibility
>   sparse-checkout: toggle sparse index from builtin
>   sparse-checkout: disable sparse-index
>   cache-tree: integrate with sparse directory entries
>   sparse-index: loose integration with cache_tree_verify()
>   p2000: add sparse-index repos
>
>  Documentation/config/extensions.txt      |   7 +
>  Documentation/git-sparse-checkout.txt    |  14 ++
>  Documentation/technical/index-format.txt |   7 +
>  Documentation/technical/sparse-index.txt | 167 +++++++++++++
>  Makefile                                 |   1 +
>  builtin/sparse-checkout.c                |  44 +++-
>  cache-tree.c                             |  40 ++++
>  cache.h                                  |  12 +-
>  read-cache.c                             |  35 ++-
>  repo-settings.c                          |  15 ++
>  repository.c                             |  11 +-
>  repository.h                             |   3 +
>  setup.c                                  |   3 +
>  sparse-index.c                           | 290 +++++++++++++++++++++++
>  sparse-index.h                           |  11 +
>  t/README                                 |   3 +
>  t/helper/test-read-cache.c               |  61 ++++-
>  t/perf/p2000-sparse-operations.sh        | 104 ++++++++
>  t/t1091-sparse-checkout-builtin.sh       |  13 +
>  t/t1092-sparse-checkout-compatibility.sh | 136 +++++++++--
>  unpack-trees.c                           |  16 +-
>  21 files changed, 953 insertions(+), 40 deletions(-)
>  create mode 100644 Documentation/technical/sparse-index.txt
>  create mode 100644 sparse-index.c
>  create mode 100644 sparse-index.h
>  create mode 100755 t/perf/p2000-sparse-operations.sh
>
>
> base-commit: 966e671106b2fd38301e7c344c754fd118d0bb07
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-883%2Fderrickstolee%2Fsparse-index%2Fformat-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-883/derrickstolee/sparse-index/format-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/883
> --
> gitgitgadget
