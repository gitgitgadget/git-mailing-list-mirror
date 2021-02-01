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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26FDC43381
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DB164EBB
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 22:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhBAWfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 17:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhBAWfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 17:35:01 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16811C061573
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 14:34:21 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 123so1407254ooi.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 14:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9CpGezL/WTMoJwP7dAzEcxnZBcezEo1VJaaQ7ZVRZiM=;
        b=YIpM5CeiaD2T5HG/ZV/oJh62DoZTEYlrQ6kW7J/kWPi1eN6OdqoYWhrxe0kZKPergh
         DlM41opDfOhxdwJV9s8q3XQPlJR+Y2jEkhrcsm7CQr0gLUokWUS6OKFp9z9zuK7Vpn9b
         UwuXBViIAC142qSjz+Y3erFbPIwE1+kBtyMdPXb/UpukhosmiqF/s2t/EXa97HWdl3v/
         piDotv3ZBMcCS2Hrl0M14q4JhrBGiIgtCuoGEQUPJDfnOtkw7dmS/9Yz31r9qighXVuw
         nBo7UGQQYz8xCq9BLrpNokTOChtaFTF6zeMbamU8209TEY0OsipwVtdBLnRVjv2nNtgB
         k+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9CpGezL/WTMoJwP7dAzEcxnZBcezEo1VJaaQ7ZVRZiM=;
        b=lSGS9cCtvVnI4AkfUSBN/xrWqN3UpOA5NLOd9dQjKdtzl5Xux3T25W4xHFtQBVIg7y
         VEGQFog6PTW3HdBNd8W+QgiSSuHzVXSFJOxAjrhekVVLs/LgXWEYtt/PL8P5z9AwjaFb
         +6/Lab66tLt8mqHm8i1gBpBRv7TcTgFxqCwZDZyIyVTBlVwzW1zlJ8t0xF91Wa/hMcXN
         OF5nM17z/RsCDA7xsrWgS8VQwzDgad8H4xeZmt6hAGVUnowiEx8CFABl7LQPd4S835ev
         Jq/blWacsDkurEHcWnfOjf5huOvGq+0Fm3Hj130AWUtSPqQjr/s5zsRcUugle/29xmVA
         aA6g==
X-Gm-Message-State: AOAM5326JPhALLE7uGLtYkFrs1veLuTq9RzrhN1ypOF6EV91DRvm0fdH
        x2VO2YEV/LoUpiXMXsg6PfVIKTz+B1jwPZ4lz5k=
X-Google-Smtp-Source: ABdhPJxVJO+DAEqApEyNPcCP2zRxShYiJUuxjKwi/fWN63eJxR7OTi3+cqyKK76IuaeoD/QRSua0pMk/r5gWu9tuoSg=
X-Received: by 2002:a4a:ea5a:: with SMTP id j26mr13179622ooe.45.1612218860442;
 Mon, 01 Feb 2021 14:34:20 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <dfbafbde3f54333dc27a18e46b5b79573f015e60.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <dfbafbde3f54333dc27a18e46b5b79573f015e60.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 14:34:09 -0800
Message-ID: <CABPp-BG5+cjN3OPRUPSKdDaJWmtagn1NhRJ9sYXg_0UeCLUOPQ@mail.gmail.com>
Subject: Re: [PATCH 21/27] sparse-index: expand_to_path no-op if path exists
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> We need to check the file hashmap first, then look to see if the
> directory signals a non-sparse directory entry. In such a case, we can
> rely on the contents of the sparse-index.
>
> We still use ensure_full_index() in the case that we hit a path that is
> within a sparse-directory entry.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  name-hash.c    |  6 ++++++
>  sparse-index.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>
> diff --git a/name-hash.c b/name-hash.c
> index 641f6900a7c..cb0f316f652 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -110,6 +110,12 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>         if (ce->ce_flags & CE_HASHED)
>                 return;
>         ce->ce_flags |= CE_HASHED;
> +
> +       if (ce->ce_mode == CE_MODE_SPARSE_DIRECTORY) {
> +               add_dir_entry(istate, ce);
> +               return;
> +       }
> +
>         hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
>         hashmap_add(&istate->name_hash, &ce->ent);
>
> diff --git a/sparse-index.c b/sparse-index.c
> index dd1a06dfdd3..bf8dce9a09b 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -281,9 +281,62 @@ void ensure_full_index(struct index_state *istate)
>         trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
>
> +static int in_expand_to_path = 0;
> +
>  void expand_to_path(struct index_state *istate,
>                     const char *path, size_t pathlen, int icase)
>  {
> +       struct strbuf path_as_dir = STRBUF_INIT;
> +       int pos;
> +
> +       /* prevent extra recursion */
> +       if (in_expand_to_path)
> +               return;

Maybe "prevent extra expand_to_path() <-> index_file_exists()
recursion", just to be extra explicit?

> +
> +       if (!istate || !istate->sparse_index)
> +               return;
> +
> +       if (!istate->repo)
> +               istate->repo = the_repository;

So, we assume the_repository if istate->repo isn't set.  I guess given
the number of the_repository assumptions we have in the code, this
isn't a big deal.  And instead of a
USE_THE_REPOSITORY_COMPATIBILITY_MACROS we have a
NO_THE_REPOSITORY_COMPATIBILITY_MACROS, so there's nothing to mark
this either.

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
> +       strbuf_add(&path_as_dir, path, pathlen);
> +       strbuf_addch(&path_as_dir, '/');
> +
> +       /* in_expand_to_path prevents infinite recursion here */
> +       if (index_file_exists(istate, path, pathlen, icase))
> +               goto cleanup;

Shouldn't the editing of path_as_dir be done after the
index_file_exists() call?  In the case that the entry already exists,
writing to path_as_dir is wasted work.

> +       pos = index_name_pos(istate, path_as_dir.buf, path_as_dir.len);
> +
> +       if (pos < 0)
> +               pos = -pos - 1;
> +
> +       /*
> +        * Even if the path doesn't exist, if the value isn't exactly a
> +        * sparse-directory entry, then there is no need to expand the
> +        * index.
> +        */
> +       if (istate->cache[pos]->ce_mode != CE_MODE_SPARSE_DIRECTORY)
> +               goto cleanup;

This looked wrong to me until I tried to come up with a
counter-example.  Here you are relying on the fact that before the
comment, pos is going to be the index of a sparse directory entry --
either for path_as_dir or some ancestor directory.  It would be nice
if the comment mentioned that.

> +
> +       trace2_region_enter("index", "expand_to_path", istate->repo);
> +
>         /* for now, do the obviously-correct, slow thing */
>         ensure_full_index(istate);
> +
> +       trace2_region_leave("index", "expand_to_path", istate->repo);
> +
> +cleanup:
> +       strbuf_release(&path_as_dir);
> +       in_expand_to_path = 0;
>  }
> --
> gitgitgadget

Looks good otherwise.
