Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495C0C433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B37B60F6C
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbhI0PxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbhI0PxM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 11:53:12 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6331C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 08:51:34 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id s24so23562133oij.8
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 08:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMbubLFmy8dyvPRyzDJnt53G9ei5T0Y1ze4zQ9wn96w=;
        b=P1eSwXoxqQxSYAUnZBwhlOf1klFtWUMSIU6CvnzRWQUlAKtuDxct7hDgVjQcHsoGMa
         wPV30U6e//YnjdTnDIa0waSO3uM1h0Fcx7mCzLQ9pW/b/KqVPOLmZhsKlF2N+wPmx4Vk
         NPo47lmsSp5RxTL3oiNNahGUudxpdfb+WUNJAJ0goRwvNB2nwHOOPP/epofPAKoVYXwa
         BnPZ0p+mwc9Iyreet4mLEBG5JHGIKFxPqroeH561LhNp7TjpD/zDsyonlsEjgxLmFy6Y
         +pGdTCRwbTZrykYxkRArthylQ4FcadgqlD7kd8F7rJQ5pwTQofCXG6GwerecTLsSyQQr
         BGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMbubLFmy8dyvPRyzDJnt53G9ei5T0Y1ze4zQ9wn96w=;
        b=S0v6VU2PjkLyD1Hxkgp+d8PBzbdNhrBmXoHbYFM2Zo6mnP8Q6/tq487YDacNxw2QcV
         h+858D8ktlik2NCGPde+8d7bsuCZTCJa8S1LaEGFKFCmDKV3oedt12C+7wngW1yNxVud
         /jCqpueIakf2PE0CzjRO/gX9ZXSLheRhQPcexdYagLj/NeUZyfncPC30wY1P7QrSzWzr
         N1uaRDUxJb8pcQW5J3RyhbiUINPfHplNf+ufz9/TUJ16QDTWV+GQTYMFlc/IqjDhTU60
         NShgQpLHjvIFhJBcpf90VgVjIdZxRj6g8QFR89piDSV4TH77imbcVKdxIJVxWzJt+CEW
         AlOg==
X-Gm-Message-State: AOAM531z/C6Jfb2aX9akpcyX7jcesTWUzWIfBczDGxQ9zshDan+Jp74Z
        c+TpHlY3rh7MiAXZscYN1tjrGtsCrliElPsWFqU=
X-Google-Smtp-Source: ABdhPJw6pl8lCA0Or/bPmNaFUQNw1o1y+/lw+bC7mmQjqGBuZyMk7vAQG5eHMqIn0yA7cUjG7vSQU4v9RS/q3WnZj8I=
X-Received: by 2002:a05:6808:20a:: with SMTP id l10mr486633oie.31.1632757894240;
 Mon, 27 Sep 2021 08:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com> <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v4.git.1632497954.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Sep 2021 08:51:22 -0700
Message-ID: <CABPp-BEks6ntKbVAK2_eJCYXejSArFKEgD5v28W2K5RAHCjp0A@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] Sparse-checkout: modify 'git add', 'git rm', and
 'git mv' behavior
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 24, 2021 at 8:39 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
...
> Updates in v4
> =============
>
>  * Instead of using 'git status' and 'grep' to detect staged changes, we use
>    'git diff --staged'. t1092 uses an additional --diff-filter because it
>    tests with merge conflicts, so it needs this extra flag.
>
>  * Patches 3 and 4 are merged into the new patch 3 to avoid temporarily
>    having a poorly named method.
>
>
...
>
> Range-diff vs v3:
>
>   1:  ea940f10a7c !  1:  642b05fc020 t3705: test that 'sparse_entry' is unstaged
>      @@ t/t3705-add-sparse-checkout.sh: setup_gitignore () {
>        }
>
>       +test_sparse_entry_unstaged () {
>      -+ git status --porcelain >actual &&
>      -+ ! grep "^[MDARCU][M ] sparse_entry\$" actual
>      ++ git diff --staged -- sparse_entry >diff &&
>      ++ test_must_be_empty diff
>       +}
>       +
>        test_expect_success 'setup' "
>   2:  c7dedb41291 !  2:  58389edc76c t1092: behavior for adding sparse files
>      @@ t/t1092-sparse-checkout-compatibility.sh: test_sparse_match () {
>       + file=$1 &&
>       + for repo in sparse-checkout sparse-index
>       + do
>      -+         git -C $repo status --porcelain >$repo-out &&
>      -+         ! grep "^A  $file\$" $repo-out &&
>      -+         ! grep "^M  $file\$" $repo-out || return 1
>      ++         # Skip "unmerged" paths
>      ++         git -C $repo diff --staged --diff-filter=ACDMRTXB -- "$file" >diff &&

Wouldn't this be more naturally spelled as --diff-filter=u ? (Note:
lowercase 'u', not uppercase.)  Then you could drop the comment too.

Other than that nit, this round looks good to me.  Feel free to add a

Reviewed-by: Elijah Newren <newren@gmail.com>
