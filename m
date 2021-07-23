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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FA5C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C5BF60E76
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 19:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbhGWTGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 15:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGWTGa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 15:06:30 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB78C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:47:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id f20-20020a9d6c140000b02904bb9756274cso3151298otq.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 12:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SBBlRaocuDeXpdHJg+sjFaIJaFj+/jXSF/9KiwyFkYQ=;
        b=kCPSXHqaoRrpw1I2QoJoJDEFhRCisyqPIjCkvFRCmGuF18ToCf9kQejIMLdtZh3Flo
         NvZBGfFVf4okzm5z3HwnHbdjdgcNDDONi/ZtLkjPuSEGepOljHE9izVPW08RpqXb+dBx
         u4YEXBoVXqpTE187a8vWJ9vlmb3c59p4ZyS6Gv+S+F+zy5rZbQRVbJtL7PnKgGyrQU00
         YDyrcdQy46qL24SLYVrhLdwBvE/D8UR1e7g4B37VgamAv35/fPtDsEjJKqj+cWlbG2h/
         3Lcux51EosYnbdI/KxqipFG2Qb4HF9WCkJ2OltzWUKjE9Lg8aFH0l4emmOz1VtG09f5a
         ORCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SBBlRaocuDeXpdHJg+sjFaIJaFj+/jXSF/9KiwyFkYQ=;
        b=qI7a3d8URAgmYZX+8dfux4EJC9WxF2Zvl/tJYf/fo2bZNzo45l7mdDE7CBTHHmpeRd
         UUxmqy4Ve3XYBQ37KOUTO8G6wsL3mHKphXOJlS2Y/zHYpY2LO3YvW+DOAyZl38HZjpUw
         0ppaOoNH6lCLMkArX1BFrnxYTsfr3GABChgyk4ZYPjhnaLOJI28ENc/9pxMRGTERy43K
         kirJtS7jGpGiej5ivL4YhBoRlBDGZAdil9tP9gKY9ReVke8Iuk7vbrWPcQ+H06P0OFU8
         g6MOB9N2p9TkPmnwD3sBk5qNlRnOvFitPCEj4HxAUnYdFhu8Lmr1Zrz9DX8HyRTckNXO
         bzGw==
X-Gm-Message-State: AOAM53257k/D16jRgQ6p5kwhlXiF8iT/UhB6pzm7Rii33RCSgjyCvEVp
        ONSuvZ1s7To4NfMnbXgyrNF85jrIv251OHuHbQ8=
X-Google-Smtp-Source: ABdhPJxztp+jw/8xUsnHC9+8rUxEfhjuCLoZNCDNjN7GMcfdQEag+Nvhxf1nBnVto4b5XxIa96jaEpsLTkPHY6oRy+4=
X-Received: by 2002:a05:6830:1d73:: with SMTP id l19mr4010683oti.316.1627069623387;
 Fri, 23 Jul 2021 12:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <pull.999.git.1626901619.gitgitgadget@gmail.com> <76066a78ce077add4bc69819b017516e12ac0d45.1626901619.git.gitgitgadget@gmail.com>
In-Reply-To: <76066a78ce077add4bc69819b017516e12ac0d45.1626901619.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 23 Jul 2021 12:46:52 -0700
Message-ID: <CABPp-BHNS=6xX2=NxZnoVgtE8MqR3Tj9RE9m9ocV_+oHRjogoA@mail.gmail.com>
Subject: Re: [PATCH 5/5] add: ignore outside the sparse-checkout in refresh()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 21, 2021 at 2:07 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Since b243012 (refresh_index(): add flag to ignore SKIP_WORKTREE
> entries, 2021-04-08), 'git add --refresh <path>' will output a warning
> message when the path is outside the sparse-checkout definition. The
> implementation of this warning happened in parallel with the
> sparse-index work to add ensure_full_index() calls throughout the
> codebase.
>
> Update this loop to have the proper logic that checks to see if the
> pathspec is outside the sparse-checkout definition. This avoids the need
> to expand the sparse directory entry and determine if the path is
> tracked, untracked, or ignored. We simply avoid updating the stat()
> information because there isn't even an entry that matches the path!
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  builtin/add.c                            | 10 +++++++++-
>  t/t1092-sparse-checkout-compatibility.sh |  6 +-----
>  2 files changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/add.c b/builtin/add.c
> index c76e6ddd359..d512ece655b 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -192,13 +192,21 @@ static int refresh(int verbose, const struct pathspec *pathspec)
>         struct string_list only_match_skip_worktree = STRING_LIST_INIT_NODUP;
>         int flags = REFRESH_IGNORE_SKIP_WORKTREE |
>                     (verbose ? REFRESH_IN_PORCELAIN : REFRESH_QUIET);
> +       struct pattern_list pl = { 0 };
> +       int sparse_checkout_enabled = !get_sparse_checkout_patterns(&pl);
>
>         seen = xcalloc(pathspec->nr, 1);
>         refresh_index(&the_index, flags, pathspec, seen,
>                       _("Unstaged changes after refreshing the index:"));
>         for (i = 0; i < pathspec->nr; i++) {
>                 if (!seen[i]) {
> -                       if (matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
> +                       const char *path = pathspec->items[i].original;
> +                       int dtype = DT_REG;
> +
> +                       if (matches_skip_worktree(pathspec, i, &skip_worktree_seen) ||
> +                           (sparse_checkout_enabled &&
> +                            !path_matches_pattern_list(path, strlen(path), NULL,
> +                                                       &dtype, &pl, &the_index))) {

I was slightly worried from the description in the commit message
about the case where you have a file without the SKIP_WORKTREE bit set
despite not matching sparsity paths.  I was worried that you'd skip
refreshing it, but I tweaked your testcases and couldn't trigger it.

>                                 string_list_append(&only_match_skip_worktree,
>                                                    pathspec->items[i].original);
>                         } else {
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index 73c48a71d89..c61424e2074 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -347,7 +347,7 @@ test_expect_success 'status/add: outside sparse cone' '
>         test_all_match git commit -m folder1/newer
>  '
>
> -test_expect_failure 'add: pathspec within sparse directory' '
> +test_expect_success 'add: pathspec within sparse directory' '
>         init_repos &&
>
>         run_on_sparse mkdir folder1 &&
> @@ -357,10 +357,6 @@ test_expect_failure 'add: pathspec within sparse directory' '
>         # This "git add folder1/a" fails with a warning
>         # in the sparse repos, differing from the full
>         # repo. This is intentional.
> -       #
> -       # However, in the sparse-index, folder1/a does not
> -       # match any cache entry and fails with a different
> -       # error message. This needs work.
>         test_sparse_match test_must_fail git add folder1/a &&
>         test_sparse_match test_must_fail git add --refresh folder1/a &&
>         test_all_match git status --porcelain=v2
> --
> gitgitgadget

This and Patch 4/5 look good to me.
