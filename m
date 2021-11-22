Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF36C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240052AbhKVRoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbhKVRoR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:44:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061DAC061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:41:10 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w1so80602688edc.6
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 09:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wtCSTQMreXO/DUDCB8XvUd+06KkSV9hpsydQhJA6EMU=;
        b=XF7ztGuwQ19NrM8Y/cq4uiNmGqAViHMLdX0NM1F1k9DU6hXySEWdSurnoi9DKh8PzA
         FcnCDfOTyX2zyIkfNpmMSVrVr0E39kDpwEyKyogAw6HT6UL0tXDj1uc4MxcV1Psdek5L
         ysFp36C9fLP6CIUlFuY2BanLkIjlUos2WttrKTqDqceJ/1NFDLwKsfAgH2efLOY56OTS
         l+W2xLcAZk1ktr/0P//gi5NVfpmq7A7EBgxdJaaPwhlling0/82679s7+Z3TjdYwMWx/
         Wc1a71xnIZyvBPJtGZ4VNyEeSfbsRS1plbdS6MRf17kuhGmcczcYPaBKAfyUxCQr43/6
         IptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wtCSTQMreXO/DUDCB8XvUd+06KkSV9hpsydQhJA6EMU=;
        b=CCaAT4/ndyceCdMsaBifLgJj45iJYzPd2NDadurWfZLg1IiJw2ToYh4TqfKfelddRI
         SmW6KCmx6A4VETRi3XnCp0FOZROtnE1l278KfTmRFregxgEoZWpgRiJlvz95NlYcJnDf
         KERUxAEtf1kyGRI0Vljlq4nSg9ddx2XdrUsY3cH/qaKoqtg/J/N+nCoG+P4sIEGBhwpz
         k7Jw+q4axOSm7Ptlxjp5tSKspUFQFlrf97EOPvp1qKQZQSOSD3zmpCbC2ZsYUJ1rT5ao
         2J/vAQ7SxqDuwsUQL3zOEmaYPsVFDUlOposbKnN9i7ZNDrnW+mAxj8I1Jx8xZ/NgyvQx
         swYA==
X-Gm-Message-State: AOAM531uBGyXi4Gx8rQ5MUCY8+LEm5UWZL2joV3GQ4t47saU81D+pN3t
        Tr6M5y3VjqghxZaTMyUbkHJszeAB1mvycN9xKbpVWNgu
X-Google-Smtp-Source: ABdhPJz0EUGeftf897QzfcNn57J4mvmg/L4SB8MaDQWKuMp2d9stGhR303Hw9sf7kn/5Y2+ANYn2MLh9yBQzMCSdKaw=
X-Received: by 2002:a05:6402:27c7:: with SMTP id c7mr45261846ede.0.1637602868514;
 Mon, 22 Nov 2021 09:41:08 -0800 (PST)
MIME-Version: 1.0
References: <pull.1059.v3.git.1635358812.gitgitgadget@gmail.com> <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 09:40:57 -0800
Message-ID: <CABPp-BH8NLCaif6FmjNza4EUyeUr2-ocxJqx+ODCeLmUuNDozQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] sparse-index: expand/collapse based on 'index.sparse'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 29, 2021 at 6:53 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This series updates do_read_index to use the index.sparse config setting
> when determining whether the index should be expanded or collapsed. If the
> command & repo allow use of a sparse index, index.sparse is enabled, and a
> full index is read from disk, the index is collapsed before returning to the
> caller. Conversely, if index.sparse is disabled but the index read from disk
> is sparse, the index is expanded before returning. This allows index.sparse
> to control use of the sparse index in addition to its existing control over
> how the index is written to disk. It also introduces the ability to
> enable/disable the sparse index on a command-by-command basis (e.g.,
> allowing a user to troubleshoot a sparse-aware command with '-c
> index.sparse=false' [1]).
>
> While testing this change, a bug was found in 'test-tool read-cache' in
> which config settings for the repository were not initialized before
> preparing the repo settings. This caused index.sparse to always be 'false'
> when using the test helper in a cone-mode sparse checkout, breaking tests in
> t1091 and t1092. The issue is fixed by moving prepare_repo_settings after
> config setup.
>
>
> Changes since V1
> ================
>
>  * Add ensure_correct_sparsity function that ensures the index is sparse if
>    the repository settings (including index.sparse) allow it, otherwise
>    ensuring the index is expanded to full.
>  * Restructure condition in do_read_index to, rather than check specifically
>    for the index.sparse config setting, call ensure_correct_sparsity
>    unconditionally when command_requires_full_index is false.
>
>
> Changes since V2
> ================
>
>  * Rename can_convert_to_sparse to is_sparse_index_allowed to more
>    accurately reflect what the function returns.
>  * Remove index-iterating checks from is_sparse_index_allowed, leaving only
>    inexpensive checks on config settings & sparse checkout patterns. Checks
>    are still part of convert_to_sparse to ensure it behaves exactly as it
>    did before this series.
>  * Restructure ensure_correct_sparsity for better readability.
>  * Fix test_env variable scope.
>
>
> Changes since V3
> ================
>
>  * Add a new patch to avoid unnecessary cache tree free/recreation when
>    possible in convert_to_sparse.

I read over this series.  I only spotted two minor things, both with
the commit message of the final patch.

Reviewed-by: Elijah Newren <newren@gmail.com>
