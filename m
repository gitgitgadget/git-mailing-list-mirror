Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCB70C4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 00:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiKLAcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 19:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbiKLAcu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 19:32:50 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C26F35E
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 16:32:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c1so10573812lfi.7
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 16:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gSK5CT7D/bMR24BRQJHfoJFzIo6qjmrqTWD/xR9qvhk=;
        b=WZYZKnALgasXGwgPZwoEsxFioS9pi6n20yf3q6wmXbeEhbTYV9bQaw6ZcIzCY/94DN
         kkK4DEHpfcuKMbnJpTdB8AqYcBcyRb0XmX1A/zuzwIcCB4W+vkYia6kvEa57kk8xtcsu
         jxecveNZ8HNiPbr7oicyjClydAgsxhqTlXuqBWB9eTK7IrLAPTkkrunI3d6XcMq5CIqZ
         Vqh7jofe3qPgjNgH7WItYac/8VDKE/xfJjXPyPXUq+7TLEp/21OLR+OlUEZ6gzdl15TT
         B/CDDuFG/b4cZLx4W1ZegzdK9ciBzfCze1HaDdiL7kxKgbbF9miFBAVfJe33Rrmz7Y72
         s2vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gSK5CT7D/bMR24BRQJHfoJFzIo6qjmrqTWD/xR9qvhk=;
        b=7QfiDGCDc4oUgbuiVbjAJPfH/sdfbiYwiqvWK3p4deCA8yJH9CckMa+OLivpmmgs1s
         l4nPVr+FZqbLzRX4L+0lyehVbAYoK7mDzQFWExeo7RKoBp/lPsy5+569FTROK+IqnqFu
         rJRGgkIgrvQ498FC8QHObWx86AZBMiTj9mqHBcouETQGasRBMd39icgJXFIJ/QsKqMjp
         k4Z0P3LeMxqppYJEvhnnJjyMeLF2NjHSTVWmZTjNmV66iq1Ya87eiDowmO32oWfMLqq+
         /DOhn7u2Ks2T4JA+B/tXEFu96zhKv79jS/ztsyUbwwbQqhylhCiDtoUMtzEb8x3B0JNJ
         3EEg==
X-Gm-Message-State: ANoB5pkbA5aCN2C9ZKnYYOT44NGFr2CsXLRZrkRABxLY+CpYu9R4ACib
        oLuoYSdN1zhXXALqI0ZF9ecejfcNEDClRDjn9ZtO7Uyu
X-Google-Smtp-Source: AA0mqf7ezMt09kQF8voCATlo4SKUGS1EFfgSvBA/EBypCXBukVJhLTA2uAG1VUT0c+KJREGlPJLvtxSodf0t6pPhLo0=
X-Received: by 2002:a19:f703:0:b0:4aa:a6f8:f042 with SMTP id
 z3-20020a19f703000000b004aaa6f8f042mr1336718lfe.405.1668213167320; Fri, 11
 Nov 2022 16:32:47 -0800 (PST)
MIME-Version: 1.0
References: <pull.1397.v6.git.1667472621.gitgitgadget@gmail.com> <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
In-Reply-To: <pull.1397.v7.git.1668210314.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Nov 2022 16:32:35 -0800
Message-ID: <CABPp-BE=XgrQxnyPp3-xi+CuU8kBarwJNfNvEtK3HscQh9sSEw@mail.gmail.com>
Subject: Re: [PATCH v7 0/2] merge-tree: allow specifying a base commit when
 --write-tree is passed
To:     Kyle Zhao via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Kyle Zhao <kylezhao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2022 at 3:45 PM Kyle Zhao via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks for everyone's careful reviews.
>
> In this patch, I introduce a new --merge-base=<commit> option to allow
> callers to specify a merge-base for the merge and extend the input accepted
> by --stdin to also allow a specified merge-base with each merge requested.
>
> Regards, Kyle
>
> Changes since v1:
>
>  * Changed merge_incore_recursive() to merge_incore_nonrecursive() when
>    merge-base is specified.
>  * Fixed c style problem.
>  * Moved commit lookup/die logic out to the parsing logic in
>    cmd_merge_tree().
>  * use test_commit for test
>
> Changes since v2:
>
>  * commit message
>  * Rebased on top of en/merge-tree-sequence.
>  * Set opt.ancestor to o->merge_base. Because opt.ancestor is a *char. To
>    make it easier to pass parameters, I moved
>    lookup_commit_reference_by_name() to real_ merge() again.
>  * Added test comment.
>
> Changes since v3:
>
>  * support --merge-base in conjunction with --stdin
>
> Changes since v4:
>
>  * commit message
>  * added input format document
>  * changed the input format for specifying the merge-base when --stdin is
>    passed
>  * changed the output when --stdin and --merge-base are used at the same
>    time
>  * add comment for test
>
> Changes since v5:
>
>  * improved test: remove the test repo after the test; avoid sub-shell.
>
> Changes since v6:
>
>  * fixed comment of test

Thanks; this version looks good to me and is ready to merge down.

> Kyle Zhao (2):
>   merge-tree.c: add --merge-base=<commit> option
>   merge-tree.c: allow specifying the merge-base when --stdin is passed
>
>  Documentation/git-merge-tree.txt | 16 ++++++++
>  builtin/merge-tree.c             | 65 ++++++++++++++++++++++++++------
>  t/t4301-merge-tree-write-tree.sh | 62 ++++++++++++++++++++++++++++++
>  3 files changed, 131 insertions(+), 12 deletions(-)
>
>
> base-commit: ec1edbcb56ac05e9980299b05924c5c1b51d68b4
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1397%2Fkeyu98%2Fkz%2Fmerge-tree-option-merge-base-v7
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1397/keyu98/kz/merge-tree-option-merge-base-v7
> Pull-Request: https://github.com/gitgitgadget/git/pull/1397
>
> Range-diff vs v6:
>
>  1:  1cf1c69b8e8 = 1:  1cf1c69b8e8 merge-tree.c: add --merge-base=<commit> option
>  2:  40d56544e6e ! 2:  48e55d4e97c merge-tree.c: allow specifying the merge-base when --stdin is passed
>      @@ t/t4301-merge-tree-write-tree.sh: test_expect_success 'specify merge-base as par
>        '
>
>       +# Since the earlier tests have verified that individual merge-tree calls
>      -+# are doing the right thing, this test case is only used to test whether
>      -+# the input format is available.
>      ++# are doing the right thing, this test case is only used to verify that
>      ++# we can also trigger merges via --stdin, and that when we do we get
>      ++# the same answer as running a bunch of separate merges.
>       +
>       +test_expect_success 'check the input format when --stdin is passed' '
>       + test_when_finished "rm -rf repo" &&
>
> --
> gitgitgadget
