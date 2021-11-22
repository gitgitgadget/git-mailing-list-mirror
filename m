Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00041C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239534AbhKVRkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbhKVRkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:40:14 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A24C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:37:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r11so80400862edd.9
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1yFOPo/3sPHo2WxanU8/rETvqZSDAP34mJPQmQI303g=;
        b=mrvAx+Za5fZkubaTVWWjg/uJClX3hh7PGKnM7Ty1E8wBnd0ui0CJVRn29jsAR4SjOG
         Llakn+bengCsaU8qcc6C0Q3xgA+wet7hBLJOFTXKJi/45EQGzLznU2/VRa8IwIn8tWeB
         OseVfrQs4VvYrnjLBelU3nKd/re97NVA3UjHWG3Wn7STyLk2WCtdlPPxAfCqXy4HRDcB
         BKDsmpxWSBuO5iWUw3IzzPhRH3Qdc+uDLqM0RFjaB18vFAu+cY2WHcZnq3Hsa6MUrTEo
         11Lif9kEo5zXis4iiWSoVzWuR+SjRHhXnEuoTR+pLf2pAH8STM/l32qTFFbTxybF1JUO
         avaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yFOPo/3sPHo2WxanU8/rETvqZSDAP34mJPQmQI303g=;
        b=hPb2UUD1QOCzMsvozwqmi8x8MbmvLrun2Fl9GRWx4PYJqomMdstfIyajk2uYf2g20R
         NIxiePqLsdH4s9fsU4fSqb3i2ZJQw6t5abkcSOnM8s8z5/I7nnXh0uNMng4t5FwGWc+L
         HEGhnnKXYjp9jZHeQcmtRJDn/qvCVm8wOoy4i0CL57kxwx3l4jqlTcqdKAVW9I8OqRwb
         3fC16snmEplq9+a+HsFmhQdQSrXOk/LzKrIJ3sTO/Ld2n3cXb0JyUQxKXz5p+KzKnhsG
         S3ByZJfB2kIGwrxZW6gRtBxTxV7DJyTy3SIdtau8P/jukGH+eBhmor5nRl0NxeQWukNJ
         GkoQ==
X-Gm-Message-State: AOAM533m/eKttNngZ9F8myoIEl1XqdWcgbQBi0JvUlka1tr9Ze2c1xAx
        mFrByfVJSoXBL3B1k0AMs5a0LlggmGGSvBOnsKo=
X-Google-Smtp-Source: ABdhPJy8JijaSuPSW9mYp7iOIv+StcjCdHHedD2pAl3ZNYpeMZqGSOp8UWqI1GOK0dCMmP1zimgmNQzcaJOkRPHDSqY=
X-Received: by 2002:a17:907:75d3:: with SMTP id jl19mr43200007ejc.520.1637602625961;
 Mon, 22 Nov 2021 09:37:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com>
 <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com> <b67cd9d07f8a3802e5b50d58965f283620cd3876.1635515487.git.gitgitgadget@gmail.com>
In-Reply-To: <b67cd9d07f8a3802e5b50d58965f283620cd3876.1635515487.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 09:36:54 -0800
Message-ID: <CABPp-BGU=HHeydt3arF=RF2P81cFbe3NfX6tqiBHb8xkhOALgg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] sparse-index: update do_read_index to ensure
 correct sparsity
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 6:56 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Victoria Dye <vdye@github.com>
>
> If `command_requires_full_index` is false, ensure correct in-core index
> sparsity on read by calling `ensure_correct_sparsity`. This change is meant
> to update the how the index is read in a command after sparse index-related

s/update the how/update how/ ?

> repository settings are modified. Previously, for example, if `index.sparse`
> were changed from `true` to `false`, the in-core index on the next command
> would be sparse. The index would only be expanded to full when it was next
> written to disk.
>
> By adding a call to `ensure_correct_sparsity`, the in-core index now matches
> the sparsity dictated by the relevant repository settings as soon as it is
> read into memory, rather than when it is later written to disk.

I split up reading this series across different days, and when I got
here, my first reaction was "Okay, but why would you want that?
Sounds like extra work for no gain."  I went and looked up the cover
letter and saw you mentioned that this "introduces the ability to
enable/disable the sparse index on a command-by-command basis (e.g.,
allowing a user to troubleshoot a sparse-aware command with '-c
index.sparse=false' [1]).  That seems like a good reason to me, and
sounds like it belongs in this commit message.  But it sounds like you
had other reasons in mind.  If so, could you share them; I'm having
difficulty understanding how this would make a difference other than
in the troubleshooting scenario.

>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Co-authored-by: Derrick Stolee <dstolee@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  read-cache.c                             |  8 ++++++
>  t/t1092-sparse-checkout-compatibility.sh | 31 ++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/read-cache.c b/read-cache.c
> index a78b88a41bf..b3772ba70a1 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2337,9 +2337,17 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>
>         if (!istate->repo)
>                 istate->repo = the_repository;
> +
> +       /*
> +        * If the command explicitly requires a full index, force it
> +        * to be full. Otherwise, correct the sparsity based on repository
> +        * settings and other properties of the index (if necessary).
> +        */
>         prepare_repo_settings(istate->repo);
>         if (istate->repo->settings.command_requires_full_index)
>                 ensure_full_index(istate);
> +       else
> +               ensure_correct_sparsity(istate);
>
>         return istate->cache_nr;
>
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index ca91c6a67f8..59accde1fa3 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -694,6 +694,37 @@ test_expect_success 'sparse-index is expanded and converted back' '
>         test_region index ensure_full_index trace2.txt
>  '
>
> +test_expect_success 'index.sparse disabled inline uses full index' '
> +       init_repos &&
> +
> +       # When index.sparse is disabled inline with `git status`, the
> +       # index is expanded at the beginning of the execution then never
> +       # converted back to sparse. It is then written to disk as a full index.
> +       rm -f trace2.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index -c index.sparse=false status &&
> +       ! test_region index convert_to_sparse trace2.txt &&
> +       test_region index ensure_full_index trace2.txt &&
> +
> +       # Since index.sparse is set to true at a repo level, the index
> +       # is converted from full to sparse when read, then never expanded
> +       # over the course of `git status`. It is written to disk as a sparse
> +       # index.
> +       rm -f trace2.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index status &&
> +       test_region index convert_to_sparse trace2.txt &&
> +       ! test_region index ensure_full_index trace2.txt &&
> +
> +       # Now that the index has been written to disk as sparse, it is not
> +       # converted to sparse (or expanded to full) when read by `git status`.
> +       rm -f trace2.txt &&
> +       GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
> +               git -C sparse-index status &&
> +       ! test_region index convert_to_sparse trace2.txt &&
> +       ! test_region index ensure_full_index trace2.txt
> +'
> +
>  ensure_not_expanded () {
>         rm -f trace2.txt &&
>         echo >>sparse-index/untracked.txt &&
> --
> gitgitgadget

The rest of the patch looks fine.
