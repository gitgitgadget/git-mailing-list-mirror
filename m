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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82055C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 02:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACCB60249
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 02:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbhBXCp0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 21:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhBXCpX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 21:45:23 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933F7C061574
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 18:44:43 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id a13so964739oid.0
        for <git@vger.kernel.org>; Tue, 23 Feb 2021 18:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p1wdT7HQYRBV9JLVnij6mTZ50uaEmhkZJpBCEexmoeM=;
        b=Jj5TyzbCEdAMrY/Zvv/05pHuFmb6L/JdeoiXYZpDWqP7HlPuHJHrB5jgs/pjGNz9R9
         LIoBBv09W14D1nj/9/7AcBawn4BiczrnuWz3/0ZBiSiQ8+v+OV5gZzt2rhAPYmBI/vgf
         +reT+4JciDHFu0/BN5EHP4uVLODDHOUhklK2ytQVXr23jrKsRJrKrF6QvoYp4/cTlVBX
         y/hKyLp9w3C1HJzCWNFMKMA4hXkGBHwlSBMlc1yxjrzE8ISUJ6ivHJFlN+jBA9R5h+j4
         Z02m6MPcDtGr8ZxJGMkHIT7+BHoTki/LykHXCQlPVVCnCD4BGZpk1KPjbjWXLULxdUdB
         7QaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p1wdT7HQYRBV9JLVnij6mTZ50uaEmhkZJpBCEexmoeM=;
        b=FpJgNY2Zft+h7E3UEWBJwtnKX+LzSHhcPNJnWjQyWWXVbnGhOgucf00ZpaV1GZ63Wz
         Z2RrokK+4eyL/1xDeIzDApxAAonm02mejqdPDM/PgtmnjeG5pgLAoCtTPxJ5e0S/SyZ8
         uoBmun4NcnrrhVaqCN215Mgy0QIuEGyrVFKauRYfEYKdfogqwF4o2yIHne5ENSwlMlvZ
         joWj+19aUaYpCycAKL9e2vkjh7VqEPkzHw1R2j3Xs+e3cQwd0y/rG4dZeRk55NF+GeOR
         ZXCoVdZMeHy3zneCeSo+pvS7FrielOv0VtUq7JLG+fi8QE9Zbv62iRL5uo+v+Jw1GVFA
         2C1g==
X-Gm-Message-State: AOAM531uXDQ78M2bTAUUTnymkJQkk/g6E1RJFubBop9dPTWkjKVsEISq
        G2WiKdZucEgZ4lMcmwbLodEDrI4dqLb9d1e1em8=
X-Google-Smtp-Source: ABdhPJx2267xzNBLz8435qBhZeuAuqXtkp2lzz4Tvn43c0M9c2/pbKgnQB19LPuiReZtLgCzS7QUUJEUNp+XmtwLZfU=
X-Received: by 2002:aca:c48c:: with SMTP id u134mr1291880oif.31.1614134682828;
 Tue, 23 Feb 2021 18:44:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <01da4c48a1fa94188faf45ab1e23b98ecb4164d5.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <01da4c48a1fa94188faf45ab1e23b98ecb4164d5.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 23 Feb 2021 18:44:31 -0800
Message-ID: <CABPp-BGBXviGFJS=pTGFA_dmoXxTuO560R1ru0phy13cyT8+ig@mail.gmail.com>
Subject: Re: [PATCH 04/20] sparse-index: add guard to ensure full index
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Upcoming changes will introduce modifications to the index format that
> allow sparse directories. It will be useful to have a mechanism for
> converting those sparse index files into full indexes by walking the
> tree at those sparse directories. Name this method ensure_full_index()
> as it will guarantee that the index is fully expanded.
>
> This method is not implemented yet, and instead we focus on the
> scaffolding to declare it and call it at the appropriate time.
>
> Add a 'command_requires_full_index' member to struct repo_settings. This
> will be an indicator that we need the index in full mode to do certain
> index operations. This starts as being true for every command, then we
> will set it to false as some commands integrate with sparse indexes.
>
> If 'command_requires_full_index' is true, then we will immediately
> expand a sparse index to a full one upon reading from disk. This
> suffices for now, but we will want to add more callers to
> ensure_full_index() later.

Same as 01/27 of your RFC series; looks good.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  Makefile        |  1 +
>  repo-settings.c |  8 ++++++++
>  repository.c    | 11 ++++++++++-
>  repository.h    |  2 ++
>  sparse-index.c  |  8 ++++++++
>  sparse-index.h  |  7 +++++++
>  6 files changed, 36 insertions(+), 1 deletion(-)
>  create mode 100644 sparse-index.c
>  create mode 100644 sparse-index.h
>
> diff --git a/Makefile b/Makefile
> index 5a239cac20e3..3bf61699238d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -980,6 +980,7 @@ LIB_OBJS += setup.o
>  LIB_OBJS += shallow.o
>  LIB_OBJS += sideband.o
>  LIB_OBJS += sigchain.o
> +LIB_OBJS += sparse-index.o
>  LIB_OBJS += split-index.o
>  LIB_OBJS += stable-qsort.o
>  LIB_OBJS += strbuf.o
> diff --git a/repo-settings.c b/repo-settings.c
> index f7fff0f5ab83..d63569e4041e 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -77,4 +77,12 @@ void prepare_repo_settings(struct repository *r)
>                 UPDATE_DEFAULT_BOOL(r->settings.core_untracked_cache, UNTRACKED_CACHE_KEEP);
>
>         UPDATE_DEFAULT_BOOL(r->settings.fetch_negotiation_algorithm, FETCH_NEGOTIATION_DEFAULT);
> +
> +       /*
> +        * This setting guards all index reads to require a full index
> +        * over a sparse index. After suitable guards are placed in the
> +        * codebase around uses of the index, this setting will be
> +        * removed.
> +        */
> +       r->settings.command_requires_full_index = 1;
>  }
> diff --git a/repository.c b/repository.c
> index c98298acd017..a8acae002f71 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -10,6 +10,7 @@
>  #include "object.h"
>  #include "lockfile.h"
>  #include "submodule-config.h"
> +#include "sparse-index.h"
>
>  /* The main repository */
>  static struct repository the_repo;
> @@ -261,6 +262,8 @@ void repo_clear(struct repository *repo)
>
>  int repo_read_index(struct repository *repo)
>  {
> +       int res;
> +
>         if (!repo->index)
>                 repo->index = xcalloc(1, sizeof(*repo->index));
>
> @@ -270,7 +273,13 @@ int repo_read_index(struct repository *repo)
>         else if (repo->index->repo != repo)
>                 BUG("repo's index should point back at itself");
>
> -       return read_index_from(repo->index, repo->index_file, repo->gitdir);
> +       res = read_index_from(repo->index, repo->index_file, repo->gitdir);
> +
> +       prepare_repo_settings(repo);
> +       if (repo->settings.command_requires_full_index)
> +               ensure_full_index(repo->index);
> +
> +       return res;
>  }
>
>  int repo_hold_locked_index(struct repository *repo,
> diff --git a/repository.h b/repository.h
> index b385ca3c94b6..e06a23015697 100644
> --- a/repository.h
> +++ b/repository.h
> @@ -41,6 +41,8 @@ struct repo_settings {
>         enum fetch_negotiation_setting fetch_negotiation_algorithm;
>
>         int core_multi_pack_index;
> +
> +       unsigned command_requires_full_index:1;
>  };
>
>  struct repository {
> diff --git a/sparse-index.c b/sparse-index.c
> new file mode 100644
> index 000000000000..82183ead563b
> --- /dev/null
> +++ b/sparse-index.c
> @@ -0,0 +1,8 @@
> +#include "cache.h"
> +#include "repository.h"
> +#include "sparse-index.h"
> +
> +void ensure_full_index(struct index_state *istate)
> +{
> +       /* intentionally left blank */
> +}
> diff --git a/sparse-index.h b/sparse-index.h
> new file mode 100644
> index 000000000000..09a20d036c46
> --- /dev/null
> +++ b/sparse-index.h
> @@ -0,0 +1,7 @@
> +#ifndef SPARSE_INDEX_H__
> +#define SPARSE_INDEX_H__
> +
> +struct index_state;
> +void ensure_full_index(struct index_state *istate);
> +
> +#endif
> --
> gitgitgadget
>
