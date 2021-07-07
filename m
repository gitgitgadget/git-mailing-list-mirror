Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF02C07E95
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:19:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C439261CBB
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 23:19:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbhGGXWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 19:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhGGXWN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 19:22:13 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E0EC061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 16:19:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t3so5487686oic.5
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 16:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KztLERewadhnOPi8EBb5aXCL7rwoS0yrQYq4KECqBY=;
        b=D5/lW/TQJMrNflsHetEO6xr+bqIlfyGjpS69kVCjV5HMgJkx1wUr4pyYEDDlPb8JSD
         9TRuLAV22I13AUxIKGuIIHlWltpH8dEwiAPmquDzN05Pmr/b5V/MfQ7fES7qgVjWWekd
         skXev0eDmZGPBKwFpuQed0iHb3tMNveQYw0NZUuOMThgkvX9bE+EMCL9jY0bnTbT8i/D
         ZcKGsxizDswAFzQ2Qxpk9ISG640S2Gz2tP/MaCoAq8vG5j5wQyLSpMmHsS6DYqcb674B
         tv3RD98xIyo2Rk6jqoG0+DwSnUHiZDEu4978TmhSwQHjeQf4yUgUMxWKhmZe8Jh7MZG7
         Ufsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KztLERewadhnOPi8EBb5aXCL7rwoS0yrQYq4KECqBY=;
        b=Tbqa7fqi8jxRJ0aNKoqJ3/DSrqfpkaA21CzJpiTQ08fMc5yZ/NeCUMkaIFSpRDLmpb
         sZplANaMl3UThPv8bcpWLRvm6LcJCQXce7V5tczmKzaojqTMuqukKyzvAjyXEd9wSvpA
         wxc6IgdaEzdmXUCMM0RiELSsKrkzXHzJI9QyZHvKTCOuWpYFAYFoP/Litu6jkmcy+RzV
         /azXPBf1x9ThNU7BOOI5LTaJY9ykd7RQ+kBHvKM+R5jb7SmsOFBOg+f8NID8f8uX76Do
         QVq6XrLhJ576d/9BlppX5OU6Jyv2kZpTT+2HgRyNyeR63+o8rkeOIttbUc07doy4iDZJ
         Y/eA==
X-Gm-Message-State: AOAM530N9SbO1WR9u1ATTQJ7rnpd3hk1Ss3U04pSWTI/971Jwbu/2ozC
        N26meKcwjgCT0Sa8LyQh/3CnJFf9g6yWFEnlZuE=
X-Google-Smtp-Source: ABdhPJxfQwW3uAIU8873Y2gXG6nn6YjRv3VKrooFglSB4qlyrE8J7RV/l2BkYJ+DA/Fhr2TkW1ovF8uTuyikp+SgiiQ=
X-Received: by 2002:aca:acc5:: with SMTP id v188mr1234822oie.167.1625699971024;
 Wed, 07 Jul 2021 16:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v6.git.1624931502.gitgitgadget@gmail.com>
 <pull.932.v7.git.1624932293.gitgitgadget@gmail.com> <9f31c691af6780f0ea48bdcb5ff6d56b628f1a81.1624932294.git.gitgitgadget@gmail.com>
In-Reply-To: <9f31c691af6780f0ea48bdcb5ff6d56b628f1a81.1624932294.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 7 Jul 2021 16:19:20 -0700
Message-ID: <CABPp-BEcELkxaVT1nPca7VL=OcWaMQ4XYsbjNBuw6xbUw9x42w@mail.gmail.com>
Subject: Re: [PATCH v7 10/16] unpack-trees: handle dir/file conflict of sparse entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 7:05 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  t/t1092-sparse-checkout-compatibility.sh | 25 ++++++++++++++++++++++--
>  unpack-trees.c                           |  5 ++++-
>  2 files changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 3f61e5686b5..4e6446e7545 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -95,6 +95,19 @@ test_expect_success 'setup' '
>                 git add . &&
>                 git commit -m "rename deep/deeper1/... to folder1/..." &&
>
> +               git checkout -b df-conflict base &&
> +               rm -rf folder1 &&
> +               echo content >folder1 &&
> +               git add . &&
> +               git commit -m df &&
> +
> +               git checkout -b fd-conflict base &&
> +               rm a &&
> +               mkdir a &&
> +               echo content >a/a &&
> +               git add . &&
> +               git commit -m fd &&
> +
>                 git checkout -b deepest base &&
>                 echo "updated deepest" >deep/deeper1/deepest/a &&
>                 git commit -a -m "update deepest" &&
> @@ -325,7 +338,11 @@ test_expect_success 'diff --staged' '
>  test_expect_success 'diff with renames and conflicts' '
>         init_repos &&
>
> -       for branch in rename-out-to-out rename-out-to-in rename-in-to-out
> +       for branch in rename-out-to-out \
> +                     rename-out-to-in \
> +                     rename-in-to-out \
> +                     df-conflict \
> +                     fd-conflict
>         do
>                 test_all_match git checkout rename-base &&
>                 test_all_match git checkout $branch -- .&&
> @@ -338,7 +355,11 @@ test_expect_success 'diff with renames and conflicts' '
>  test_expect_success 'diff with directory/file conflicts' '
>         init_repos &&
>
> -       for branch in rename-out-to-out rename-out-to-in rename-in-to-out
> +       for branch in rename-out-to-out \
> +                     rename-out-to-in \
> +                     rename-in-to-out \
> +                     df-conflict \
> +                     fd-conflict
>         do
>                 git -C full-checkout reset --hard &&
>                 test_sparse_match git reset --hard &&

Tests look good...

> diff --git a/unpack-trees.c b/unpack-trees.c
> index d141dffbd94..e63b2dcacbc 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2617,7 +2617,10 @@ int twoway_merge(const struct cache_entry * const *src,
>                          same(current, oldtree) && !same(current, newtree)) {
>                         /* 20 or 21 */
>                         return merged_entry(newtree, current, o);
> -               } else
> +               } else if (current && !oldtree && newtree &&
> +                          S_ISSPARSEDIR(current->ce_mode) != S_ISSPARSEDIR(newtree->ce_mode))
> +                       return merged_entry(newtree, current, o);
> +               else
>                         return reject_merge(current, o);
>         }
>         else if (newtree) {

This seems wrong to me but I'm having a hard time nailing down a
testcase to prove it.  The logic looks to me like "if the old tree as
nothing in the index at the given path, and the newtree has something,
and the index had something staged, but the newtree and staged index
entry disagree on the type of the object, do some weird merged_entry()
logic on both types of trees that tends to just take the newer I
thought but who knows what functions like verify_uptodate(entry) do
when entry is a sparse directory...".

So, I'm not so sure about this.  Could you explain this a bit more?

However, I did find a testcase that aborts with a fatal error...though
I can't tell if it's even triggering the above logic; I think it isn't
because I have an "ignoreme" on both sides of the history.  Here's the
testcase:

# Make a little test repo
git init dumb
cd dumb

# Setup old commit
touch tracked
echo foo >ignoreme
git add .
git commit -m "Initial"
git branch orig

# Setup new commit
git rm ignoreme
mkdir ignoreme
touch ignoreme/file
git add ignoreme/file
git commit -m "whatever"

# Switch to old commit
git checkout orig

# Make index != new (and index != old)
git rm ignoreme
mkdir ignoreme
echo user-data >ignoreme/file
git add ignoreme/file

# Sparsify
GIT_TEST_SPARSE_INDEX=0 # GIT_TEST_SPARSE_INDEX is documented as a boolean;
                        # but the traditional boolean value is ignored and it
                        # really only cares about set/unset.  Confusing.
git sparse-checkout init --cone --sparse-index
git sparse-checkout set tracked

# Check status and dirs/paths in index
git status --porcelain
test-tool read-cache --table
test-tool read-cache --table --expand

# Run a command that aborts with a fatal error
git checkout -m master
