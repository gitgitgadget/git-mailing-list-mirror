Return-Path: <SRS0=1Io1=D7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE821C4363A
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 10:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997BC2176B
	for <git@archiver.kernel.org>; Sat, 24 Oct 2020 10:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BQTHJ05G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761061AbgJXKr0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 06:47:26 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40315 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759092AbgJXKrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 06:47:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id 23so4298537ljv.7
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 03:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=73Sfse/iSuzumSU26pmE/Ev2N6pop1KfgWCZvGYjFmM=;
        b=BQTHJ05Gb+zlVeBn6PHOLhh8QuuvSde4yRSEUiRiyE0E7wh+1vNV781jd1R46tSLXq
         KWByJzHSjfHd9cf57Hlc9/+tqHAyjDqFBr9RcJcQJPlHQQcbrOyVt3O1Ke9LN5q1uyUV
         sFiX2reTzR3bqxVnVq/8tBiqc21Ifyr/+5YdRHKzhxfhi0sc5XIQPV8XuBcXMKVxzD/Y
         J3LBybkhQa5UfaK0BR1oG0fsbO1hUPZhh2caNwKFfTH/Rh5naSdKmRt1+VXzjEGeyu1g
         iG8p0Rf7bRUdE2aZdKRYWCJVWhP8G4gDqH5fYdLmveZvOCKGUzTjX9/1sYwypIRfDhcn
         oi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=73Sfse/iSuzumSU26pmE/Ev2N6pop1KfgWCZvGYjFmM=;
        b=sGoPy1e3VOxDQQXp/h/nyNtwskWZE5DLnFajfFMRvVIATQr23dp4jq819B8qHxThMG
         oYdUQ28UONqlc7kwxyu2pJNBoEG8pQPVYxvRlcD94BBzP4N3PZJD0CudWdnkl4QDVJL4
         78r2c2KytX/TGSHatmnX+u1ipxmYb6hteyhqjQHGV9rvtmugA6uwpfrglib7OJyJUcX5
         xSowsXIhaq9x7vfhAoAl2MMhU7mdCUCPVU8CmMzNvnjkfzKUzXC9Tndha4No/rKmuuQV
         uj+S9wUP+J6oF0/MAzk5YZ/Wi4S3c/idlXidQ/XffDo+TYBL0XcdJPjxE2RVnoNyI+A8
         dRsQ==
X-Gm-Message-State: AOAM530gV9cMvfj541bMMDWNXrD0NzKg3QRVuKL1UC9oZzW4ygNPCs6c
        Rk8A7mt4b7umNVXC5QJeWiCDJjeddVegPjGzlRc=
X-Google-Smtp-Source: ABdhPJzUKQQfzEvpwViUjf0UqLMh3g643x5ZUt2G25jOcOmbbzfeincuqobpepdE+vRPqc+YkMV0dNWP0TNVkLILm6g=
X-Received: by 2002:a2e:b8d0:: with SMTP id s16mr2549406ljp.198.1603536382915;
 Sat, 24 Oct 2020 03:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <pull.895.git.git.1603286555.gitgitgadget@gmail.com> <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
In-Reply-To: <54ef18182cf3a4b5d02889c139e495fa68588652.1603286555.git.gitgitgadget@gmail.com>
From:   Peter Baumann <peter.baumann@gmail.com>
Date:   Sat, 24 Oct 2020 12:46:12 +0200
Message-ID: <CAJm9OHcEGfkgEsTZhD4qKG9Ns5fu=COToWz0XkHhPuJ_DtGzgA@mail.gmail.com>
Subject: Re: [PATCH 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Do., 22. Okt. 2020 um 03:28 Uhr schrieb Elijah Newren via
GitGitGadget <gitgitgadget@gmail.com>:
[... snipping a lot of unneeded context ...]
> diff --git a/merge-ort.h b/merge-ort.h
> new file mode 100644
> index 0000000000..9c655cd3ad
> --- /dev/null
> +++ b/merge-ort.h
> @@ -0,0 +1,49 @@
> +#ifndef MERGE_ORT_H
> +#define MERGE_ORT_H
> +
> +#include "merge-recursive.h"
> +
> +struct commit;
> +struct tree;
> +
> +struct merge_result {
> +       /* whether the merge is clean */
> +       int clean;
> +
> +       /* Result of merge.  If !clean, represents what would go in worktree */
> +       struct tree *tree;
> +
> +       /*
> +        * Additional metadata used by merge_switch_to_result() or future calls
> +        * to merge_inmemory_*().
> +        */
> +       unsigned _;
> +       void *priv;
> +};
> +
> +/* rename-detecting three-way merge, no recursion. */
                                                                   ^^^^^^^^^^^^^
> +void merge_inmemory_recursive(struct merge_options *opt,
                                           ^^^^^^^^^
> +                             struct commit_list *merge_bases,
> +                             struct commit *side1,
> +                             struct commit *side2,
> +                             struct merge_result *result);
> +
> +/* rename-detecting three-way merge with recursive ancestor consolidation. */
                                                                  ^^^^^^^^^^^^^
> +void merge_inmemory_nonrecursive(struct merge_options *opt,
                                            ^^^^^^^^^^^^
> +                                struct tree *merge_base,
> +                                struct tree *side1,
> +                                struct tree *side2,
> +                                struct merge_result *result);
> +

The comments don't fit to the actually method name. I assume they
should be switched?

-Peter
