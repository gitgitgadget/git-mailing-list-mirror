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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D20C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB9E564E0F
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 05:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233720AbhBXFQq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 00:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhBXFQn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 00:16:43 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA16C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 21:16:02 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id l3so1257533oii.2
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 21:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NX6XZorb6hR4oQyvylg3naojXPaCXJ07DdO1lzyfSJ8=;
        b=JwOdUx2goz2mKA7uReEUNxVwDMnwfvJ20cJiCLWOzMMkq9nhh484uqBjEmVQASR7Ly
         3BBXcaSZsTJ3Kjb2uiXD/XeFHqQqDUevAKEPC79rTI5ENk9gnCW9oilwc6ImZ+NpeeLO
         RNmbPE9FWNKb62gnwAUJXvpthlmoxkKLcbvSjSS6ig7dGVubl3WMG8o6uJPtlAupJQZV
         oJeRnu96aCHoxxpKKP9no1WgNzWupu6dKf18I6OXKyEdTVIKXE8K+tFX4AGL7jtJCMKM
         G+H5ois4K0Gv/w4UkxMIehIXIXCfUVEGZ6hQJLJn1jSRQoRGHArbR8NxJzck2SbcBJDZ
         QRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NX6XZorb6hR4oQyvylg3naojXPaCXJ07DdO1lzyfSJ8=;
        b=nOkUMyH34R7pcD9LZC6drDnVCB2/XydMygz/4G+jKHFo0zexW16VcuGPEazPb49IZ9
         nE3hw5ejpw/JzGePohxrCP3pcal6qp1bG6eUvg9Lo6bd4xYxtTN+ETwFAIe2IBx0QBCm
         11RIhe7iUpU+dF09Y+MTi/X2VdkCfkTTkCdAekL8ogYpvbXgHhtNL2UpaD2toqFQIGhA
         msjdK2kkEq1v+tGpSSn1vYRyeHIsrBdmikJDNVw1YaeReZxVBxVarjvz3EnqpCL3xtsO
         GEUCNYww3pT/SPg3XnVPDO6Fo7iTsreWtBzlut/mDExp4LLmsiw9gLjQPk0e+EYoTP41
         u/7Q==
X-Gm-Message-State: AOAM530444+IKrF02TaqgLRuzhvT9wZOWuAf3ZKUlyfEyHza9P6dzBcI
        yo/gUskRQ3EKqffxJxiJljffSj1NPYKLeO1iBXE=
X-Google-Smtp-Source: ABdhPJzDH4h0lFeN02LTYioPJWgPKLflUanU29fSVX0oXAQjAL7GymTPlwqW9+AyginUwIe00AyaG442BXkojrT8ciw=
X-Received: by 2002:aca:b407:: with SMTP id d7mr1529488oif.167.1614143761140;
 Tue, 23 Feb 2021 21:16:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1614138107.git.matheus.bernardino@usp.br> <72b87870181d8bf72ce7bf86b5fae2e485fef9c0.1614138107.git.matheus.bernardino@usp.br>
In-Reply-To: <72b87870181d8bf72ce7bf86b5fae2e485fef9c0.1614138107.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 21:15:50 -0800
Message-ID: <CABPp-BH=wzpm1aQfQqZDBDw0+QABEURvX43+4==MyFX05DoKCA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] t3705: add tests for `git add` in sparse checkouts
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 8:05 PM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> We already have a couple tests for `add` with SKIP_WORKTREE entries in
> t7012, but these only cover the most basic scenarios. As we will be
> changing how `add` deals with sparse paths in the subsequent commits,
> let's move these two tests to their own file and add more test cases
> for different `add` options and situations. This also demonstrates two
> options that don't currently respect SKIP_WORKTREE entries: `--chmod`
> and `--renormalize`.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  t/t3705-add-sparse-checkout.sh   | 96 ++++++++++++++++++++++++++++++++
>  t/t7012-skip-worktree-writing.sh | 19 -------
>  2 files changed, 96 insertions(+), 19 deletions(-)
>  create mode 100755 t/t3705-add-sparse-checkout.sh
>
> diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
> new file mode 100755
> index 0000000000..9bb5dc2389
> --- /dev/null
> +++ b/t/t3705-add-sparse-checkout.sh
> @@ -0,0 +1,96 @@
> +#!/bin/sh
> +
> +test_description='git add in sparse checked out working trees'
> +
> +. ./test-lib.sh
> +
> +SPARSE_ENTRY_BLOB=""
> +
> +# Optionally take a printf format string to write to the sparse_entry file
> +setup_sparse_entry () {
> +       rm -f sparse_entry &&

I think this is unnecessary.

> +       git update-index --force-remove sparse_entry &&

It might be worth adding a comment above this line that it is
necessary when sparse_entry starts out in the SKIP_WORKTREE state,
otherwise the subsequent git add below will ignore it.

> +
> +       if test $# -eq 1
> +       then
> +               printf "$1" >sparse_entry
> +       else
> +               >sparse_entry
> +       fi &&
> +       git add sparse_entry &&
> +       git update-index --skip-worktree sparse_entry &&
> +       SPARSE_ENTRY_BLOB=$(git rev-parse :sparse_entry)
> +}
> +
> +test_sparse_entry_unchanged () {
> +       echo "100644 $SPARSE_ENTRY_BLOB 0       sparse_entry" >expected &&
> +       git ls-files --stage sparse_entry >actual &&
> +       test_cmp expected actual
> +}
> +
> +setup_gitignore () {
> +       test_when_finished rm -f .gitignore &&
> +       cat >.gitignore <<-EOF
> +       *
> +       !/sparse_entry
> +       EOF
> +}
> +
> +test_expect_success 'git add does not remove sparse entries' '
> +       setup_sparse_entry &&
> +       rm sparse_entry &&
> +       git add sparse_entry &&
> +       test_sparse_entry_unchanged
> +'
> +
> +test_expect_success 'git add -A does not remove sparse entries' '
> +       setup_sparse_entry &&
> +       rm sparse_entry &&
> +       setup_gitignore &&
> +       git add -A &&
> +       test_sparse_entry_unchanged
> +'
> +
> +test_expect_success 'git add . does not remove sparse entries' '
> +       setup_sparse_entry &&
> +       rm sparse_entry &&
> +       setup_gitignore &&
> +       git add . &&
> +       test_sparse_entry_unchanged
> +'
> +
> +for opt in "" -f -u --ignore-removal --dry-run
> +do
> +       test_expect_success "git add${opt:+ $opt} does not update sparse entries" '
> +               setup_sparse_entry &&
> +               echo modified >sparse_entry &&
> +               git add $opt sparse_entry &&
> +               test_sparse_entry_unchanged
> +       '
> +done
> +
> +test_expect_success 'git add --refresh does not update sparse entries' '
> +       setup_sparse_entry &&
> +       git ls-files --debug sparse_entry | grep mtime >before &&
> +       test-tool chmtime -60 sparse_entry &&
> +       git add --refresh sparse_entry &&
> +       git ls-files --debug sparse_entry | grep mtime >after &&
> +       test_cmp before after
> +'
> +
> +test_expect_failure 'git add --chmod does not update sparse entries' '
> +       setup_sparse_entry &&
> +       git add --chmod=+x sparse_entry &&
> +       test_sparse_entry_unchanged &&
> +       ! test -x sparse_entry
> +'
> +
> +test_expect_failure 'git add --renormalize does not update sparse entries' '
> +       test_config core.autocrlf false &&
> +       setup_sparse_entry "LINEONE\r\nLINETWO\r\n" &&
> +       echo "sparse_entry text=auto" >.gitattributes &&
> +       git add --renormalize sparse_entry &&
> +       test_sparse_entry_unchanged
> +'
> +
> +test_done
> diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
> index e5c6a038fb..217207c1ce 100755
> --- a/t/t7012-skip-worktree-writing.sh
> +++ b/t/t7012-skip-worktree-writing.sh
> @@ -60,13 +60,6 @@ setup_absent() {
>         git update-index --skip-worktree 1
>  }
>
> -test_absent() {
> -       echo "100644 $EMPTY_BLOB 0      1" > expected &&
> -       git ls-files --stage 1 > result &&
> -       test_cmp expected result &&
> -       test ! -f 1
> -}
> -
>  setup_dirty() {
>         git update-index --force-remove 1 &&
>         echo dirty > 1 &&
> @@ -100,18 +93,6 @@ test_expect_success 'index setup' '
>         test_cmp expected result
>  '
>
> -test_expect_success 'git-add ignores worktree content' '
> -       setup_absent &&
> -       git add 1 &&
> -       test_absent
> -'
> -
> -test_expect_success 'git-add ignores worktree content' '
> -       setup_dirty &&
> -       git add 1 &&
> -       test_dirty
> -'
> -
>  test_expect_success 'git-rm fails if worktree is dirty' '
>         setup_dirty &&
>         test_must_fail git rm 1 &&
> --
> 2.30.1

The rest looks good.
