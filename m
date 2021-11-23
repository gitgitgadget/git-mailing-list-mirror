Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C80C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbhKWRYk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 12:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhKWRYg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 12:24:36 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E84C061574
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:21:28 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l25so78304518eda.11
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 09:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y6jbMhCKX6KJ9M6rcgf30i2z5GaBfAbFBzNauY9Nzn8=;
        b=ktCUP/73g7wyZhDKEk4KBSxqHV7f/aeA/QSDfIQsaGqPJg17X7uf7+SWv91zJkWRlH
         7qbvdRCQ/SHJfsNuBxsIaEcAgJmE25BlWqh/6vv6HrNe5w/IC+dMPvpqhuEPZ4T2VExx
         G/7a3NwB/gAk85NRV8sMDXkf+7Bj1ue67IbKL2Dfp0XQtIRkxQ/+RcyUyXh3CEAD+fgo
         x1h5LmpJSSPJRZP4aOfKN+17LwD2Woq80i9h3UBq51ErdiWKJlpPNNMfgE7BDs4fzfpM
         FSXwGw5eru/pgeFkRGrPIVkKutz6aff65M3II7NA0bswQ472QDusLOT2IBskCYGvViCc
         A1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y6jbMhCKX6KJ9M6rcgf30i2z5GaBfAbFBzNauY9Nzn8=;
        b=Yobrj29kpTqGceOvd5x2vL5DFUBdrCdBXz+/cyDw7UqQlcnqqsjUNaX7dUa8n05w9I
         MHtojef/YbacML0+hZ3KYiv9tzQR9MredV1ndyxxMcoK0Ntxdpborqrs5AQH3uj9gANb
         qe53sVSWAfHd8uB0Tx9advde0lvtwWK8NBGYOkWdfPhDjQA5WOd47ojlcycT/O/f86MA
         aSfo64L7Hr5BTKDL9M4oYtBlv4X88hBCXZPSN/qmzzAh5sUTrmEgXgurnmasOcVu8bmE
         kTFOvA+Vwve03zomUkhYeKi6j/joC3UUP9yDaYftKgdNubR+C2sTV/YihEA8F9qF/wOu
         5SZw==
X-Gm-Message-State: AOAM533DCx7wmMKNgTuxUZTrzX8j7FhykqjYWbG3+u1wWK4DVtCeEEKb
        trDc6lGos476nMRvDSv2gbIhG/3hEzxo43XUndc=
X-Google-Smtp-Source: ABdhPJwYL15+GXzhGtjmRiQ9B6S9MmabJg6qVub2403aXu8U1wfp8xz4s3yuPnLcnOygHNDJ+sbRPMbfPTHZFnidEGA=
X-Received: by 2002:a05:6402:405:: with SMTP id q5mr11706545edv.62.1637688086966;
 Tue, 23 Nov 2021 09:21:26 -0800 (PST)
MIME-Version: 1.0
References: <pull.1059.v4.git.1635515487.gitgitgadget@gmail.com> <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v5.git.1637626833.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Nov 2021 09:21:14 -0800
Message-ID: <CABPp-BHkjvzSCihDnwRL5R-JDA1LZx23oTm7cp8gtueo3h9+LA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] sparse-index: expand/collapse based on 'index.sparse'
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 4:20 PM Victoria Dye via GitGitGadget
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
>
>
> Changes since V4
> ================
>
>  * Updated patch 4/4 commit message to better explain practical reasons for
>    making this change.

Thanks.  This version looks good to me:

Reviewed-by: Elijah Newren <newren@gmail.com>
