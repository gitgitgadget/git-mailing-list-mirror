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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E8EC433B4
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E834A61412
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 23:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbhDTXBX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 19:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbhDTXBU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 19:01:20 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1F4C06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:00:47 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso35409322otb.13
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 16:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7CkexdQkQM93iAcZn+EmwGq8eVGg1VmUUjzj4nJZpc=;
        b=n/AIrF8d0chU0LAnhuLBsWQnSsG0QJ8LHGupAnClydeCX4iSkhAsTyO/SUA/KKUCjb
         hWIZpYMn5vAc/nNDyKJvZGR0Eu4MdZOyfXqOoJnebonhEQ00dYPdeudFBuvAljXBOqlI
         EOBJg77brxuPIHfXEOHMmY1DBCy7EER0VD4sjpCyAMoZcFW5dFqGJs8krGv6MMUzci/W
         TTDk0NG+3y7yKyZtYaKY6Eeka/7gW4sb+/gQaDhO2n0d0f/3ttfdm/BFPezhWZ1XSQUf
         WaMqNMf9OHsj7soQS8CQmcmnuwWebsGyUQt725aMzVf8B+WO+2Mu3FSl1KbH5ZqkUcfF
         Wu8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7CkexdQkQM93iAcZn+EmwGq8eVGg1VmUUjzj4nJZpc=;
        b=kM+roWupdhGPJLGDIHM+n+m2Yupt2syQGQGDRPDwC8UyffXWHf65331zxZ9hGk1bAq
         MV9QFLgaN1YGFYmhJKPBD8izkBbRuT11S4NCGbKx4jIEHPPUGoX6PO1W8uvtj+66P6wT
         tzr+LHD82ieQrEVV0Ot2sN2kGciGr/sbC1bICKLXaetGD/CdshgEgOLZVxdXIWfb0Sk4
         Ae7Vna0viOC5SgCm2xQPBVzdwHTwArVpjPSTlWInE1oHKdFyX4hKfNR4OgU5oWVMcKr+
         aaMoTExHNpgH8dpKPTkuhslb9F4Jg7EK3A+tFpc0/+mLtqYUchOYrm3BjMD6PogLWTSA
         i2xA==
X-Gm-Message-State: AOAM53106YrLF4EZSRquIzozTTNk6MpoYFklBL3pdyezuPmv9kqERUvu
        AfNHc52yN4gnzDvvtPnxFWxTA86LokmiEwCQ8VE=
X-Google-Smtp-Source: ABdhPJx6vWIiFR+CkvvwhXUiHBYyiuIKH5i5/SQu60CprZoNmHoCxGJnIfmuRgurupXR1qHdx3y8RtJqBcAc4PvJUqk=
X-Received: by 2002:a05:6830:108d:: with SMTP id y13mr15310202oto.162.1618959646315;
 Tue, 20 Apr 2021 16:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com> <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
In-Reply-To: <0a3892d2ec9e4acd4cba1c1d0390acc60dc6e50f.1618322497.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 20 Apr 2021 16:00:35 -0700
Message-ID: <CABPp-BHcdhO_kEdqR23sDdGAgoSu2R-HBWv-RmzQvJ0ysWtzxg@mail.gmail.com>
Subject: Re: [PATCH 02/10] unpack-trees: make sparse aware
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 13, 2021 at 7:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As a first step to integrate 'git status' and 'git add' with the sparse
> index, we must start integrating unpack_trees() with sparse directory
> entries. These changes are currently impossible to trigger because
> unpack_trees() calls ensure_full_index() if command_requires_full_index
> is true. This is the case for all commands at the moment. As we expand
> more commands to be sparse-aware, we might find that more changes are
> required to unpack_trees(). The current changes will suffice for
> 'status' and 'add'.
>
> unpack_trees() calls the traverse_trees() API using unpack_callback()
> to decide if we should recurse into a subtree. We must add new abilities
> to skip a subtree if it corresponds to a sparse directory entry.
>
> It is important to be careful about the trailing directory separator
> that exists in the sparse directory entries but not in the subtree
> paths.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  dir.h           |  2 +-
>  preload-index.c |  2 ++
>  read-cache.c    |  3 +++
>  unpack-trees.c  | 24 ++++++++++++++++++++++--
>  4 files changed, 28 insertions(+), 3 deletions(-)
>
> diff --git a/dir.h b/dir.h
> index 51cb0e217247..9d6666f520f3 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -503,7 +503,7 @@ static inline int ce_path_match(struct index_state *istate,
>                                 char *seen)
>  {
>         return match_pathspec(istate, pathspec, ce->name, ce_namelen(ce), 0, seen,
> -                             S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));
> +                             S_ISSPARSEDIR(ce->ce_mode) || S_ISDIR(ce->ce_mode) || S_ISGITLINK(ce->ce_mode));

I'm confused why this change would be needed, or why it'd semantically
be meaningful here either.  Doesn't S_ISSPARSEDIR() being true imply
S_ISDIR() is true (and perhaps even vice versa?).

By chance, was this a leftover from your early RFC changes from a few
series ago when you had an entirely different mode for sparse
directory entries?

>  }
>
>  static inline int dir_path_match(struct index_state *istate,
> diff --git a/preload-index.c b/preload-index.c
> index e5529a586366..35e67057ca9b 100644
> --- a/preload-index.c
> +++ b/preload-index.c
> @@ -55,6 +55,8 @@ static void *preload_thread(void *_data)
>                         continue;
>                 if (S_ISGITLINK(ce->ce_mode))
>                         continue;
> +               if (S_ISSPARSEDIR(ce->ce_mode))
> +                       continue;
>                 if (ce_uptodate(ce))
>                         continue;
>                 if (ce_skip_worktree(ce))

Don't we have S_ISSPARSEDIR(ce->ce_mode) implies ce_skip_worktree(ce)?
 Is this a duplicate check?  If so, is it still desirable for
future-proofing or code clarity, or is it strictly redundant?

> diff --git a/read-cache.c b/read-cache.c
> index 29ffa9ac5db9..6308234b4838 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1594,6 +1594,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
>                 if (ignore_skip_worktree && ce_skip_worktree(ce))
>                         continue;
>
> +               if (istate->sparse_index && S_ISSPARSEDIR(ce->ce_mode))
> +                       continue;
> +

I'm a bit confused about what could trigger ce_skip_worktree(ce) &&
!ignore_skip_worktree and why it'd be desirable to refresh
skip-worktree entries.  However, this is tangential to your patch and
has apparently been around since 2009 (in particular, from 56cac48c35
("ie_match_stat(): do not ignore skip-worktree bit with
CE_MATCH_IGNORE_VALID", 2009-12-14)).

>                 if (pathspec && !ce_path_match(istate, ce, pathspec, seen))
>                         filtered = 1;
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index dddf106d5bd4..9a62e823928a 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -586,6 +586,13 @@ static void mark_ce_used(struct cache_entry *ce, struct unpack_trees_options *o)
>  {
>         ce->ce_flags |= CE_UNPACKED;
>
> +       /*
> +        * If this is a sparse directory, don't advance cache_bottom.
> +        * That will be advanced later using the cache-tree data.
> +        */
> +       if (S_ISSPARSEDIR(ce->ce_mode))
> +               return;
> +

I don't understand cache_bottom stuff; we might want to get Junio to
look over it.  Or maybe I just need to dig a bit further and attempt
to understand it.

>         if (o->cache_bottom < o->src_index->cache_nr &&
>             o->src_index->cache[o->cache_bottom] == ce) {
>                 int bottom = o->cache_bottom;
> @@ -984,6 +991,9 @@ static int do_compare_entry(const struct cache_entry *ce,
>         ce_len -= pathlen;
>         ce_name = ce->name + pathlen;
>
> +       /* remove directory separator if a sparse directory entry */
> +       if (S_ISSPARSEDIR(ce->ce_mode))
> +               ce_len--;
>         return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);

Shouldn't we be passing ce->ce_mode instead of S_IFREG here as well?

Note the following sort order:
   foo
   foo.txt
   foo/
   foo/bar

You've trimmed off the '/', so 'foo/' would be ordered where 'foo' is,
but df_name_compare() exists to make "foo" sort exactly where "foo/"
would when "foo" is a directory.  Will your df_name_compare() call
here result in foo.txt being placed after all the "foo/<subpath>"
entries in the index and perhaps cause other problems down the line?
(Are there issues, e.g. with cache-trees getting wrong ordering from
this, or even writing out indexes or tree objects with the wrong
ordering?  I've written out trees to disk with wrong ordering before
and git usually survives but gets really confused with diffs.)

Since at least one caller of compare_entry() takes the return result
and does a "if (cmp < 0)", this order is going to matter in some
cases.  Perhaps we need some testcases where there is a sparse
directory entry named "foo/" and a file recorded in some relevant tree
with the name "foo.txt" to be able to trigger these lines of code?

>  }
>
> @@ -993,6 +1003,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
>         if (cmp)
>                 return cmp;
>
> +       /* If ce is a sparse directory, then allow equality here. */
> +       if (S_ISSPARSEDIR(ce->ce_mode))
> +               return 0;
> +

Um...so a sparse directory compares equal to _anything_ at all?  I'm
really confused why this would be desirable.  Am I missing something
here?

>         /*
>          * Even if the beginning compared identically, the ce should
>          * compare as bigger than a directory leading up to it!
> @@ -1243,6 +1257,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>         struct unpack_trees_options *o = info->data;
>         const struct name_entry *p = names;
> +       unsigned recurse = 1;

"recurse" sent my mind off into questions about safety checks, base
cases, etc., instead of just the simple "we don't want to read in
directories corresponding to sparse entries".  I think this would be
clearer either if the variable had the sparsity concept embedded in
its name somewhere (e.g. "unsigned sparse_entry = 0", and check for
(!sparse_entry) instead of (recurse) below), or with a comment about
why there are cases where you want to avoid recursion.

>
>         /* Find first entry with a real name (we could use "mask" too) */
>         while (!p->mode)
> @@ -1284,12 +1299,16 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                                         }
>                                 }
>                                 src[0] = ce;
> +
> +                               if (S_ISSPARSEDIR(ce->ce_mode))
> +                                       recurse = 0;

Ah, the context here doesn't show it but this is in the "if (!cmp)"
block, i.e. if we found a match for the sparse directory.  This makes
sense, to me, _if_ we ignore the above question about sparse
directories matching equal to anything and everything.

>                         }
>                         break;
>                 }
>         }
>
> -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> +       if (recurse &&
> +           unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
>                 return -1;
>
>         if (o->merge && src[0]) {
> @@ -1319,7 +1338,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                         }
>                 }
>
> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> +               if (recurse &&
> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>                                              names, info) < 0)
>                         return -1;
>                 return mask;

Nice.  :-)


I think your patch was mostly about the recurse stuff, which other
than the name or a comment about it look good to me.  However, all the
other preparatory small tweaks brought up a lot of questions or
confusion for me.  I'm worried there might be a bug or two, though I
may have just misunderstood some of the code bits.
