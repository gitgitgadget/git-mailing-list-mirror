Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9023FC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 20:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7089961A10
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 20:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbhCZUaY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 16:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhCZU3o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 16:29:44 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672ACC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 13:29:44 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hq27so10257608ejc.9
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 13:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4/eeoDMpbLT5UmHhOeMGUvn59iQQ0gJ0IjI2MQw9t0Q=;
        b=tW0FxtMsdkex/ptCtgAEMGOaQOObM7I4SlnsFc/dvBzkcneQ5x6arfpnG601cUkKgU
         W3jsT0FkY4ZQNtM2ypZZWGpbtUSf3X+Q6+QTYXVanzcMGdgPRLqB7vWK1kg/Hdwf61uO
         dmJyEaif8Sv5mv3l/CGuujx6p4MV7TD1mH+vPWdWLnqvZyu3Zlq4Dplh3jsJp7t0WQxT
         UM/hewsQRn9rRZEpPpmAKjS8VEtXInFApRiI59JOY8dDTM+x+zeJct1zJrGVcm34kQAz
         HnoFVSQ3Ca7zSsFdQsijNhi4AvDAxCKNyrFad2tso1J07Dm2eUnGeGGOHofT0WXMqfla
         bCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4/eeoDMpbLT5UmHhOeMGUvn59iQQ0gJ0IjI2MQw9t0Q=;
        b=flqFz5PzKxMJ3UFCGE8/wpo2n24h6a8866OP3RYawjKiNV4sVMOyd0VnS16u+2iMop
         A4GB1PiBpsSLfPy8yQZ961+FK3Cj6vniGluKUXIVNhjp0a6pkpRd5eYvvCaOWw+vaFa2
         2j+4u+6UoZsklkWMaP+JMljHaHOCYU3DPxAIL5dk4Bg7XcT3ARAYg/2/9+UYviURHcj3
         xmj/gwyJzUHQepJIXulDOWanMPysSHnLAVHTPJotwa6mTfPRyvPJKb8XoYGNnvVFUD49
         v6JswQymEHRqMhJGi9hJPp969c0kdiwHxZ0vIKeVzIArfCa8+EmrXogbahn3GObulM+K
         fwUQ==
X-Gm-Message-State: AOAM532+JzBvPzl7mQJZYkRTAZfaBpUDjbNpjIUHf8Ko+G4JNEZEmpTV
        o8xMM5lMcjlRdtdmq4a0Uzw=
X-Google-Smtp-Source: ABdhPJy/RFaaogVNEosQ9mOzqtdywmviUExjGKEJ69IQntBtII+w5loA+BqCulk0zLvg0JfdGktePA==
X-Received: by 2002:a17:906:5689:: with SMTP id am9mr16658432ejc.298.1616790583058;
        Fri, 26 Mar 2021 13:29:43 -0700 (PDT)
Received: from szeder.dev (84-236-109-92.pool.digikabel.hu. [84.236.109.92])
        by smtp.gmail.com with ESMTPSA id z17sm4327241eju.27.2021.03.26.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 13:29:42 -0700 (PDT)
Date:   Fri, 26 Mar 2021 21:29:40 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, gitster@pobox.com,
        pclouds@gmail.com, jrnieder@gmail.com,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 01/20] sparse-index: design doc and format update
Message-ID: <20210326202940.GC2271@szeder.dev>
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com>
 <6426a5c60e53e30091360c00c61c9123803fe9c1.1616507069.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6426a5c60e53e30091360c00c61c9123803fe9c1.1616507069.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 01:44:09PM +0000, Derrick Stolee via GitGitGadget wrote:
> Currently, the index format is only updated in the presence of
> extensions.sparseIndex instead of increasing a file format version
> number. This is temporary, and index v5 is part of the plan for future
> work in this area.

> diff --git a/Documentation/technical/sparse-index.txt b/Documentation/technical/sparse-index.txt
> new file mode 100644
> index 000000000000..62f6dc225a44
> --- /dev/null
> +++ b/Documentation/technical/sparse-index.txt

> +To start, we use a new repository extension, `extensions.sparseIndex`, to
> +allow inserting sparse-directory entries into indexes with file format
> +versions 2, 3, and 4. This prevents Git versions that do not understand
> +the sparse-index from operating on one, but it also prevents other
> +operations that do not use the index at all.

Why is this not a non-optional index extension?  That would allow
older Git versions and other implementations not understanding sparse
directory entries to still perform any operation that doesn't involve
the index.  More importantly, that would prevent older Git versions
and other implementations not understanding repository extensions from
potentially wreaking havoc when the index contains sparse directory
entries.  Notably JGit's current version (5.11.0.202103091610-r) does
still completely ignore repository extensions, and e.g. happily
attempts any operations on a SHA256 repository, so it would do the
same in the presence of 'extensions.sparseIndex' as well.  JGit does
respect non-optional index extensions, see e.g. 87a6bb701a
(t5310-pack-bitmaps: make JGit tests work with GIT_TEST_SPLIT_INDEX,
2018-05-10).

This really should be a non-optional index extension.

> A new format, index v5, will
> +be introduced that includes sparse-directory entries by default. It might
> +also introduce other features that have been considered for improving the
> +index, as well.
