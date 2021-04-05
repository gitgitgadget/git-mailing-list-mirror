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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7928DC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A8F613B8
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:32:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhDETcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbhDETcn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 15:32:43 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDCA2C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 12:32:34 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so12375360otk.5
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 12:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tLjN25q/uAesZ4ZOsNZxOkL1SZYOCFjzOLLjphzrqAQ=;
        b=dISLQyRRvgcBYQ1EdanEZYgMBTgBD6cEMN7QNeTFDAVUqLLIj+3Ds3w+YhBWxlYFw8
         zCQo7IOSmaAyVZfSIhgnry1eClbxUHRaEvsGeyXSvVeGrzfXVQkOfUpz5peoqN2oprCT
         96HfzVcPPd4VotSK7YzGL7O5Yk3D9P8BGgu9IfFfy6Uw+ksZVFFbu8+8dnnn4T7EPdsD
         2ZJTGUP+DrnUYrjeCI2Mfkk9oeXS3hkYJ6qh3ByRgekHFTsqPmOGkGkJu2WaWSsG3WC5
         dBlFVowHXYaWqqinvr+RNBN25Uga3VLwn8Z13y5gzEQvJN2E+QCF3onQyQ2bzLyOeHui
         acaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tLjN25q/uAesZ4ZOsNZxOkL1SZYOCFjzOLLjphzrqAQ=;
        b=XGU0njV7XHP8P5ZVc2W7X6sLQvXzWnqv8OF0/lYVtm+6dvDKmkgWBVEvK80N0cIrCR
         RNk6r7R5xGRndCOe9koPl0HVwkKrgidpLjNOucM0Ltr/FF+Lx+sYgDotYZS0aykTffP8
         cipiLGkOtfC3kz2HHFddMXcNyR4uu2seM/85NR+htc976JJnsSVfbGSlJ/osca8dFYBL
         dIQg+fMI6Eb7rXuS0r9x3P0Na0Mrvo3mKFxq9hkfLilylXlv8b2Zb4jDwF4HcXbTiTZX
         Vh8yz3YHeTY2JYYGtxAXad1HqfeODqFcK78+hGlHUyG9oPiEOqQZ2yx8SdKyTaEPsmIR
         GgBw==
X-Gm-Message-State: AOAM530IPsS7tP8oqS5dEY6UhhyralljO1+dB71Ptqa1UDqG8J1awHiQ
        Yl4feb/KRHVnQGHCK7xb6hzQg/Xzc80hzxC5aew=
X-Google-Smtp-Source: ABdhPJw/cTJtg8FqPutHi6aw13mCv/onhOBEQRENPsoXL+Czpk8OTXxDbm1WO20eU/n76L4d0P38XQaGmZUeMMVV2bA=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr23859739otf.345.1617651154233;
 Mon, 05 Apr 2021 12:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <pull.906.v2.git.1617241802.gitgitgadget@gmail.com> <d52c72b4a7b9a3ae10bd2daae85c1bd1bafcc2f3.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <d52c72b4a7b9a3ae10bd2daae85c1bd1bafcc2f3.1617241803.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Apr 2021 12:32:23 -0700
Message-ID: <CABPp-BE5xLMsVdamAb=MgiBnXKQrYDPJXa1TWutDK+nVYRPyRQ@mail.gmail.com>
Subject: Re: [PATCH v2 24/25] sparse-index: expand_to_path()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 6:50 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> Some users of the index API have a specific path they are looking for,
> but choose to use index_file_exists() to rely on the name-hash hashtable
> instead of doing binary search with index_name_pos(). These users only
> need to know a yes/no answer, not a position within the cache array.
>
> When the index is sparse, the name-hash hash table does not contain the
> full list of paths within sparse directories. It _does_ contain the
> directory names for the sparse-directory entries.
>
> Create a helper function, expand_to_path(), for intended use with the
> name-hash hashtable functions. The integration with name-hash.c will
> follow in a later change.
>
> The solution here is to use ensure_full_index() when we determine that
> the requested path is within a sparse directory entry. This will
> populate the name-hash hashtable as the index is recomputed from
> scratch.
>
> There may be cases where the caller is trying to find an untracked path
> that is not in the index but also is not within a sparse directory
> entry. We want to minimize the overhead for these requests. If we used
> index_name_pos() to find the insertion order of the path, then we could
> determine from that position if a sparse-directory exists. (In fact,
> just calling index_name_pos() in that case would lead to expanding the
> index to a full index.) However, this takes O(log N) time where N is the
> number of cache entries.
>
> To keep the performance of this call based mostly on the input string,
> use index_file_exists() to look for the ancestors of the path. Using the
> heuristic that a sparse directory is likely to have a small number of
> parent directories, we start from the bottom and build up. Use a string
> buffer to allow mutating the path name to terminate after each slash for
> each hashset test.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  sparse-index.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  sparse-index.h | 13 +++++++++
>  2 files changed, 85 insertions(+)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 95ea17174da3..8a1223041296 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -283,3 +283,75 @@ void ensure_full_index(struct index_state *istate)
>
>         trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
> +
> +/*
> + * This static global helps avoid infinite recursion between
> + * expand_to_path() and index_file_exists().
> + */
> +static int in_expand_to_path = 0;
> +
> +void expand_to_path(struct index_state *istate,
> +                   const char *path, size_t pathlen, int icase)
> +{
> +       struct strbuf path_mutable = STRBUF_INIT;
> +       size_t substr_len;
> +
> +       /* prevent extra recursion */
> +       if (in_expand_to_path)
> +               return;
> +
> +       if (!istate || !istate->sparse_index)
> +               return;
> +
> +       if (!istate->repo)
> +               istate->repo = the_repository;
> +
> +       in_expand_to_path = 1;
> +
> +       /*
> +        * We only need to actually expand a region if the
> +        * following are both true:
> +        *
> +        * 1. 'path' is not already in the index.
> +        * 2. Some parent directory of 'path' is a sparse directory.
> +        */
> +
> +       if (index_file_exists(istate, path, pathlen, icase))
> +               goto cleanup;
> +
> +       strbuf_add(&path_mutable, path, pathlen);
> +       strbuf_addch(&path_mutable, '/');
> +
> +       /* Check the name hash for all parent directories */
> +       substr_len = 0;
> +       while (substr_len < pathlen) {
> +               char temp;
> +               char *replace = strchr(path_mutable.buf + substr_len, '/');
> +
> +               if (!replace)
> +                       break;
> +
> +               /* replace the character _after_ the slash */
> +               replace++;
> +               temp = *replace;
> +               *replace = '\0';
> +               if (index_file_exists(istate, path_mutable.buf,
> +                                     path_mutable.len, icase)) {
> +                       /*
> +                        * We found a parent directory in the name-hash
> +                        * hashtable, which means that this entry could
> +                        * exist within a sparse-directory entry. Expand
> +                        * accordingly.

"this entry" is a bit unclear; it might be worth referring to the
"path" variable instead.  I think it'd also help to explain the
reasoning for using the '/' character, because while it's clear when
looking at the series, just running across it in the code it might be
easy to forget or miss.  Perhaps:

                    * We found a parent directory in the name-hash
                    * hashtable, because only sparse directory entries
                    * have a trailing '/' character.  Since "path" wasn't
                    * in the index, perhaps it exists within this
                    * sparse-directory.  Expand accordingly.

> +                        */
> +                       ensure_full_index(istate);
> +                       break;
> +               }
> +
> +               *replace = temp;
> +               substr_len = replace - path_mutable.buf;
> +       }
> +
> +cleanup:
> +       strbuf_release(&path_mutable);
> +       in_expand_to_path = 0;
> +}
> diff --git a/sparse-index.h b/sparse-index.h
> index 0268f38753c0..1115a0d7dd98 100644
> --- a/sparse-index.h
> +++ b/sparse-index.h
> @@ -4,6 +4,19 @@
>  struct index_state;
>  int convert_to_sparse(struct index_state *istate);
>
> +/*
> + * Some places in the codebase expect to search for a specific path.
> + * This path might be outside of the sparse-checkout definition, in
> + * which case a sparse-index may not contain a path for that index.
> + *
> + * Given an index and a path, check to see if a leading directory for
> + * 'path' exists in the index as a sparse directory. In that case,
> + * expand that sparse directory to a full range of cache entries and
> + * populate the index accordingly.
> + */
> +void expand_to_path(struct index_state *istate,
> +                   const char *path, size_t pathlen, int icase);
> +
>  struct repository;
>  int set_sparse_index_config(struct repository *repo, int enable);
>
> --
> gitgitgadget
