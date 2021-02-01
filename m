Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 570A4C433E0
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1126664ED2
	for <git@archiver.kernel.org>; Mon,  1 Feb 2021 23:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhBAXzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 18:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhBAXzh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 18:55:37 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA39C06174A
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 15:54:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id k25so20854335oik.13
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 15:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e3B3bu2mx4Y6rajLCP53q398Qj8XzzZUwDd+XPdnIJw=;
        b=ZonPsblLRI4/NHAjIEOO5vV0ZK5ggrjtvnY/6AwUkHRA/16QioPDQimPLUpeuSgHC7
         gbj7rGSuF7NxIpCaC+dh6lMPvFvNIdzzSHBxGIQfPyzsBAa0DBnwtXkWTAH2VlYbeAIh
         p2F+ynpEBOzV/0ie7aU/1+bRh8QOQlGATplxixEQOB0O4xBMTPDSDvv0vqN+7w/W4t6+
         XiH9D/swaO6SgKyWr/vd4hgT6hGW6rN3Bqwv9MrHgyXvZhP54K1Joo6MhbpV8bkMMfiB
         DLFBu+6miVFdenvirLiAl2NUbBbj157vPKfEHlzeGa1pG22HonIt8lFLp6QCEn4pnBh/
         pOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e3B3bu2mx4Y6rajLCP53q398Qj8XzzZUwDd+XPdnIJw=;
        b=SAmauBng+XQpowzqc7MiTkn0wi23nEIgnuQj9IobtpI/lOx/2T1UOV6ArnrIpGdCHs
         nard08Q7AdsZx/VLduirnTmJN3EFyRDPHloLknCetWGd14dOEwMO1kXsL2/9qmknIysJ
         WrvHbzp3G3H4DX1QnsB8ZVIxbjvBG4fHsvMC95r8lHUYf/OLDsB2I1xkBKpPXYNI4SC6
         NdEoAyF8Y1LwENQNGIfM8fnBq2wWwW/4Idd24wrO85toFoZ4hEp/0NB+mGlPlcL2rHQk
         BJqo5JiuK4BrgVjFeGQkBcyyiOnir8KA7+rYc6cErXsd/K2yjlc3VkXTH4cq7Xu6Sj7v
         VLgg==
X-Gm-Message-State: AOAM533QwiCX3aeR3rBEIPZoocs/Aqx5EPT1YtTbcLvA6tL5iTX+DjI9
        35bbxakWNsh5v/n6mr6dhGNY208Jpm5yNWXQq3I=
X-Google-Smtp-Source: ABdhPJz3pDmZSknz4Sv6GXEjD2rgSf1Syu2PjnrCHViGXE9osecgulr0aMtEqrllfu1IoztVYyUMcnS9Pp8GTotxj4o=
X-Received: by 2002:aca:4e4f:: with SMTP id c76mr866119oib.167.1612223696618;
 Mon, 01 Feb 2021 15:54:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.847.git.1611596533.gitgitgadget@gmail.com> <05e7548b780da6b2bf2342d91d8757568df0a6b8.1611596534.git.gitgitgadget@gmail.com>
In-Reply-To: <05e7548b780da6b2bf2342d91d8757568df0a6b8.1611596534.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Feb 2021 15:54:45 -0800
Message-ID: <CABPp-BGtF+p7D8x0xvSwMz7XveqVcBWhr20iHQ4=Vrxw6LEoKw@mail.gmail.com>
Subject: Re: [PATCH 27/27] cache-tree: integrate with sparse directory entries
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 9:42 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The cache-tree extension was previously disabled with sparse indexes.
> However, the cache-tree is an important performance feature for commands
> like 'git status' and 'git add'. Integrate it with sparse directory
> entries.
>
> When writing a sparse index, completely clear and recalculate the cache
> tree. By starting from scratch, the only integration necessary is to
> check if we hit a sparse directory entry and create a leaf of the
> cache-tree that has an entry_count of one and no subtrees.
>
> Once the cache-tree exists within a sparse index, we finally get
> improved performance. I test the sparse index performance using a
> private monorepo with over 2.1 million files at HEAD, but with a
> sparse-checkout definition that has only 68,000 paths in the populated
> cone. The sparse index has about 2,000 sparse directory entries. I
> compare three scenarios:

How many .gitignore entries does this monorepo have?  What percentage
of those are populated for #2 and #3?

Can a testcase be devised that others can repeat?  For example, I
created https://github.com/newren/gvfs-like-git-bomb once upon a time
to create a very small repository with a very large index and a lot of
skip-worktree entries, mostly to test some stuff that someone (Ben
Peart?) mentioned as being slow and verify for myself that it wasn't
Windows specific.

>  1. Use the full index. The index size is ~186 MB.
>  2. Use the sparse index. The index size is ~5.5 MB.
>  3. Use a commit where HEAD matches the populated set. The full index
>     size is ~5.3MB.

I'm not sure I'm understanding the difference between #2 and #3, other
than #3 is smaller.  How did you form #2?  Also, what do you mean by
"full index size" for #3, when it's the smallest?  Isn't that index
the most sparse (or least full)?  Or is it an index for a different
commit entirely that has far fewer files in it?

> The third benchmark is included as a theoretical optimium for a

s/optimium/optimum/

> repository of the same object database.

This I'm also not understanding, but maybe this goes back to not
understanding the difference in how #2 and #3 are constructed.

> First, a clean 'git status' improves from 3.1s to 240ms.
>
> Benchmark #1: full index (git status)
>   Time (mean =C2=B1 =CF=83):      3.167 s =C2=B1  0.036 s    [User: 2.006=
 s, System: 1.078 s]
>   Range (min =E2=80=A6 max):    3.100 s =E2=80=A6  3.208 s    10 runs
>
> Benchmark #2: sparse index (git status)
>   Time (mean =C2=B1 =CF=83):     239.5 ms =C2=B1   8.1 ms    [User: 189.4=
 ms, System: 226.8 ms]
>   Range (min =E2=80=A6 max):   226.0 ms =E2=80=A6 251.9 ms    13 runs
>
> Benchmark #3: small tree (git status)
>   Time (mean =C2=B1 =CF=83):     195.3 ms =C2=B1   4.5 ms    [User: 116.5=
 ms, System: 84.4 ms]
>   Range (min =E2=80=A6 max):   188.8 ms =E2=80=A6 202.8 ms    15 runs

Always nice to see a speedup factor greater than 10.  :-)

>
> The optimimum is still 45ms faster. This is due in part to the 2,000+

s/optimimum/optimum/

> sparse directory entries, but there might be other optimizations to make
> in the sparse-index case. In particular, I find that this performance
> difference disappears when I disable FS Monitor, which is somewhat
> disabled in the sparse-index case, but might still be adding overhead.

The FS monitor wording is unclear to me; it feels like multiple negatives.

> The performance numbers for 'git add .' are much closer to optimal:
>
> Benchmark #1: full index (git add .)
>   Time (mean =C2=B1 =CF=83):      3.076 s =C2=B1  0.022 s    [User: 2.065=
 s, System: 0.943 s]
>   Range (min =E2=80=A6 max):    3.044 s =E2=80=A6  3.116 s    10 runs
>
> Benchmark #2: sparse index (git add .)
>   Time (mean =C2=B1 =CF=83):     218.0 ms =C2=B1   6.6 ms    [User: 195.7=
 ms, System: 206.6 ms]
>   Range (min =E2=80=A6 max):   209.8 ms =E2=80=A6 228.2 ms    13 runs
>
> Benchmark #3: small tree (git add .)
>   Time (mean =C2=B1 =CF=83):     217.6 ms =C2=B1   5.4 ms    [User: 131.9=
 ms, System: 86.7 ms]
>   Range (min =E2=80=A6 max):   212.1 ms =E2=80=A6 228.4 ms    14 runs
>
> In this test, I also used "echo >>README.md" to append a line to the
> README.md file, so the 'git add .' command is doing _something_ other
> than a no-op. Without this edit (and FS Monitor enabled) the small
> tree case again gains about 30ms on the sparse index case.

Meaning the small tree is 30 ms faster than reported here, or 30 ms
slower, or that both sparse index and small tree are faster but the
small tree decreases its time more than the sparse index one does?

Sorry, I don't mean to be dense, I'm just struggling with
understanding words today it seems.  (Also, it seems like there's a
joke in there about me being "dense" in a review of a "sparse"
feature...but I'm not quite coming up with it.)

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  cache-tree.c   | 18 ++++++++++++++++++
>  sparse-index.c | 10 +++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/cache-tree.c b/cache-tree.c
> index 5f07a39e501..9da6a4394e0 100644
> --- a/cache-tree.c
> +++ b/cache-tree.c
> @@ -256,6 +256,24 @@ static int update_one(struct cache_tree *it,
>
>         *skip_count =3D 0;
>
> +       /*
> +        * If the first entry of this region is a sparse directory
> +        * entry corresponding exactly to 'base', then this cache_tree
> +        * struct is a "leaf" in the data structure, pointing to the
> +        * tree OID specified in the entry.
> +        */
> +       if (entries > 0) {
> +               const struct cache_entry *ce =3D cache[0];
> +
> +               if (S_ISSPARSEDIR(ce) &&
> +                   ce->ce_namelen =3D=3D baselen &&
> +                   !strncmp(ce->name, base, baselen)) {
> +                       it->entry_count =3D 1;
> +                       oidcpy(&it->oid, &ce->oid);
> +                       return 1;
> +               }
> +       }
> +
>         if (0 <=3D it->entry_count && has_object_file(&it->oid))
>                 return it->entry_count;
>
> diff --git a/sparse-index.c b/sparse-index.c
> index a201f3b905c..9ea3b321400 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -181,7 +181,11 @@ int convert_to_sparse(struct index_state *istate)
>         istate->cache_nr =3D convert_to_sparse_rec(istate,
>                                                  0, 0, istate->cache_nr,
>                                                  "", 0, istate->cache_tre=
e);
> -       istate->drop_cache_tree =3D 1;
> +
> +       /* Clear and recompute the cache-tree */
> +       cache_tree_free(&istate->cache_tree);
> +       cache_tree_update(istate, 0);
> +
>         istate->sparse_index =3D 1;
>         trace2_region_leave("index", "convert_to_sparse", istate->repo);
>         return 0;
> @@ -278,6 +282,10 @@ void ensure_full_index(struct index_state *istate)
>
>         free(full);
>
> +       /* Clear and recompute the cache-tree */
> +       cache_tree_free(&istate->cache_tree);
> +       cache_tree_update(istate, 0);
> +
>         trace2_region_leave("index", "ensure_full_index", istate->repo);
>  }
>
> --
> gitgitgadget

This is very exciting work!!
