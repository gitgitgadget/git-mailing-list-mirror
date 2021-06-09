Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFADC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89BF46124C
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 03:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhFIDum (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbhFIDul (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 23:50:41 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CBEC061574
        for <git@vger.kernel.org>; Tue,  8 Jun 2021 20:48:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so22612259otl.3
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 20:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SOMdDpAe28XoWx3ErcIEJKATmhA9TD360qGduRJ7D74=;
        b=PnY3v+Zz0TcMO9EvnmaH+GE0h81cChUyvE5QB2OIT3f7phpy90L2ARCi6y1eFW2wBy
         u4jxf36Bb3pqOf72hdyidl0TBgpBzBJ+CYAw3clvDCZ/Pid1ZRqaDQm4WGW4tZM9lbQj
         dukixn+70BZcour13V7coNwwKNE8Gce3OtGGaF8Su8i0Z9YdYXqjxMHEAttjPlmhLWrP
         9TprW0hUHC9s5K7CmvFbGWPS22vQ0zJeChvgkHZ+N5GNsl6zg36UjnXHISZrAqOnGpKl
         mOyWeetu3XHXoAH0YHvC/fJpJZkJffZ/Ogz6+Gg5by80sIz11adAgUOG2vsYmzP2fhRN
         7G2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SOMdDpAe28XoWx3ErcIEJKATmhA9TD360qGduRJ7D74=;
        b=WHMdMjjIP1NLUJyYj9hH9kuqErQlvQoHYA6LEaVYyjwhUT15S6oXtDYsWiIRem/LEi
         DDzQve3qTVjBW+EIfBhcAlIdxryE6ZXp444C3/nN4IHrV/XX13Fz4MLJGEfnEzsZcscZ
         AcxOfphFr21v81t0pXaz/0HyVz/SoB7A9/oxlCfevll4nzjRd5G5emKzMGZc84DTMiHu
         bUGpvZMdemBR7y0qLi9EHmErguOWaRmUEdndAvjfx0YJUKb1Zf7oPTFZ18rGJ/LlHBku
         wqtIzVvn0xe5kv7rQ2Btc/CCs0gnnqfMtdojTkZYHYMuYZHxxmmZcwIFl2AnJgz8V+Ka
         UQZQ==
X-Gm-Message-State: AOAM533OVvqbHMr2LT6SWqCtjTDII7pERIsHYrmMtsW0uFxa+PmnHdhQ
        69yTgpwEiStsjRzMXYBW8DPn/XDMiVpsfz0BtmI=
X-Google-Smtp-Source: ABdhPJy+U1YYKz5gF6i/bB2cXPOySQgv8EP7ylOIfFkuULOcCCk9Eopnevm7a+I4l/BMKi14+SCCSpSgS4zd9byyWSg=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr5350692otn.162.1623210518758;
 Tue, 08 Jun 2021 20:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
 <pull.932.v5.git.1623069252.gitgitgadget@gmail.com> <724194eef9f6d5514bcd7761daf0eb2bb87c0619.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <724194eef9f6d5514bcd7761daf0eb2bb87c0619.1623069252.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 8 Jun 2021 20:48:27 -0700
Message-ID: <CABPp-BGj0y1bKuyaZf14v==j2-mHoiEuV0Am3MBCK4hkbb085Q@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] unpack-trees: unpack sparse directory entries
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 7, 2021 at 5:34 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> During unpack_callback(), index entries are compared against tree
> entries. These are matched according to names and types. One goal is to
> decide if we should recurse into subtrees or simply operate on one index
> entry.
>
> In the case of a sparse-directory entry, we do not want to recurse into
> that subtree and instead simply compare the trees. In some cases, we
> might want to perform a merge operation on the entry, such as during
> 'git checkout <commit>' which wants to replace a sparse tree entry with
> the tree for that path at the target commit. We extend the logic within
> unpack_nondirectories() to create a sparse-directory entry in this case,
> and then that is sent to call_unpack_fn().

Does this presume that all callbacks are prepared to accept a sparse
directory entry?  Or do we have an external flag that ensures we do
not reach this code path when using callbacks that aren't prepared to
handle it properly?

I hope that the answer is the latter, and that the ensure_full_index()
calls are what prevents the code from reaching this point if a
callback would be used that couldn't handle a sparse directory entry.

I'd be particularly concerned that merge-recursive would call this
code with unpack_opts.fn = threeway_merge.  threeway_merge is kind of
interesting in that it might just happen to not die when passed a
sparse directory entry, but would pass along data that'd just break
stuff downstream in various subtle ways.  For example, if there were
conflicts in the sparse directory entries because both had been
modified, the merge should recurse and resolve individual paths
underneath, which the merge-recursive code would not be prepared to do
since unpack_trees() has already returned.  Also, even if there wasn't
a "conflict" because only one side modified, blindly doing a trivial
directory resolution will break rename detection.  I mention
merge-recursive not because it's worth fixing (well, it was and the
fix is called merge-ort) but because I'm most familiar with it.  The
other callbacks _might_ have similar problems, though its possible
that it's safe for one- and two- way merging and just fails once you
get to three-way.

> There are some subtleties in this process. For instance, we need to
> update find_cache_entry() to allow finding a sparse-directory entry that
> exactly matches a given path.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 101 ++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 91 insertions(+), 10 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ef6a2b1c951c..ff448ee8424e 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1037,13 +1037,15 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
>         const struct name_entry *n,
>         int stage,
>         struct index_state *istate,
> -       int is_transient)
> +       int is_transient,
> +       int is_sparse_directory)
>  {
>         size_t len = traverse_path_len(info, tree_entry_len(n));
> +       size_t alloc_len = is_sparse_directory ? len + 1 : len;
>         struct cache_entry *ce =
>                 is_transient ?
> -               make_empty_transient_cache_entry(len) :
> -               make_empty_cache_entry(istate, len);
> +               make_empty_transient_cache_entry(alloc_len) :
> +               make_empty_cache_entry(istate, alloc_len);
>
>         ce->ce_mode = create_ce_mode(n->mode);
>         ce->ce_flags = create_ce_flags(stage);
> @@ -1052,6 +1054,13 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
>         /* len+1 because the cache_entry allocates space for NUL */
>         make_traverse_path(ce->name, len + 1, info, n->path, n->pathlen);
>
> +       if (is_sparse_directory) {
> +               ce->name[len] = '/';
> +               ce->name[len + 1] = 0;

Should this be '\0', for clarity?

> +               ce->ce_namelen++;
> +               ce->ce_flags |= CE_SKIP_WORKTREE;
> +       }
> +
>         return ce;
>  }
>
> @@ -1064,16 +1073,24 @@ static int unpack_nondirectories(int n, unsigned long mask,
>                                  unsigned long dirmask,
>                                  struct cache_entry **src,
>                                  const struct name_entry *names,
> -                                const struct traverse_info *info)
> +                                const struct traverse_info *info,
> +                                int sparse_directory)
>  {
>         int i;
>         struct unpack_trees_options *o = info->data;
>         unsigned long conflicts = info->df_conflicts | dirmask;
>
> -       /* Do we have *only* directories? Nothing to do */

You've removed the comment, but not the code.  So it still returns
immediately if there are only directories...right?  Am I missing
something?  Is this code still correct?  Or is the comment just
misleading now that src[0] can be a directory?

>         if (mask == dirmask && !src[0])
>                 return 0;
>
> +       /* no-op if our cache entry doesn't match the expectations. */
> +       if (sparse_directory) {
> +               if (src[0] && !S_ISSPARSEDIR(src[0]->ce_mode))
> +                       BUG("expected sparse directory entry");
> +       } else if (src[0] && S_ISSPARSEDIR(src[0]->ce_mode)) {
> +               return 0;
> +       }

This code reads like "If sparse_directory is false, but the cache
entry is a sparse directory, we'll just keep it as-is and ignore
changed or conflicting directories or files from the names name_entry.
However, I think this has to be coupled with knowledge about changes
to unpack_callback() you made, where you introduce an extra call to
unpack_nondirectories() for the sparse directory case, and in the
second one you would do useful work.  So "no-op" is kind of
misleading, it's more deferral until the later unpack_nondirectories()
call.

Or, at least so I think after trying to read over this patch.  Am I
understanding this right?

> +
>         /*
>          * Ok, we've filled in up to any potential index entry in src[0],
>          * now do the rest.
> @@ -1103,7 +1120,9 @@ static int unpack_nondirectories(int n, unsigned long mask,
>                  * not stored in the index.  otherwise construct the
>                  * cache entry from the index aware logic.
>                  */
> -               src[i + o->merge] = create_ce_entry(info, names + i, stage, &o->result, o->merge);
> +               src[i + o->merge] = create_ce_entry(info, names + i, stage,
> +                                                   &o->result, o->merge,
> +                                                   sparse_directory);
>         }
>
>         if (o->merge) {
> @@ -1210,13 +1229,44 @@ static int find_cache_pos(struct traverse_info *info,
>  static struct cache_entry *find_cache_entry(struct traverse_info *info,
>                                             const struct name_entry *p)
>  {
> +       struct cache_entry *ce;
>         int pos = find_cache_pos(info, p->path, p->pathlen);
>         struct unpack_trees_options *o = info->data;
>
>         if (0 <= pos)
>                 return o->src_index->cache[pos];
> -       else
> +
> +       /*
> +        * Check for a sparse-directory entry named "path/".
> +        * Due to the input p->path not having a trailing
> +        * slash, the negative 'pos' value overshoots the
> +        * expected position by one, hence "-2" here.
> +        */
> +       pos = -pos - 2;
> +
> +       if (pos < 0 || pos >= o->src_index->cache_nr)
> +               return NULL;
> +
> +       ce = o->src_index->cache[pos];
> +
> +       if (!S_ISSPARSEDIR(ce->ce_mode))
>                 return NULL;
> +
> +       /*
> +        * Compare ce->name to info->name + '/' + p->path + '/'
> +        * if info->name is non-empty. Compare ce->name to
> +        * p-.path + '/' otherwise.

p->path, not p-.path

Also, you state in both cases that you are comparing against a
trailing '/', but...

> +        */
> +       if (info->namelen) {
> +               if (ce->ce_namelen == info->namelen + p->pathlen + 2 &&
> +                   ce->name[info->namelen] == '/' &&
> +                   !strncmp(ce->name, info->name, info->namelen) &&
> +                   !strncmp(ce->name + info->namelen + 1, p->path, p->pathlen))

You only checked for one of the two '/' characters here.  Are you
omitting the check for the final '/' do to the S_ISSPARSEDIR() check
above?

> +                       return ce;
> +       } else if (ce->ce_namelen == p->pathlen + 1 &&
> +                  !strncmp(ce->name, p->path, p->pathlen))

Here you didn't check for the final '/'.  Is that intentional because
of the S_ISSPARSEDIR() check above?  If so, should the comment above
this block be corrected?

> +               return ce;
> +       return NULL;
>  }
>
>  static void debug_path(struct traverse_info *info)
> @@ -1251,6 +1301,32 @@ static void debug_unpack_callback(int n,
>                 debug_name_entry(i, names + i);
>  }
>
> +/*
> + * Returns true if and only if the given cache_entry is a
> + * sparse-directory entry that matches the given name_entry
> + * from the tree walk at the given traverse_info.
> + */
> +static int is_sparse_directory_entry(struct cache_entry *ce, struct name_entry *name, struct traverse_info *info)
> +{
> +       size_t expected_len, name_start;
> +
> +       if (!ce || !name || !S_ISSPARSEDIR(ce->ce_mode))
> +               return 0;
> +
> +       if (info->namelen)
> +               name_start = info->namelen + 1;
> +       else
> +               name_start = 0;
> +       expected_len = name->pathlen + 1 + name_start;
> +
> +       if (ce->ce_namelen != expected_len ||
> +           strncmp(ce->name, info->name, info->namelen) ||
> +           strncmp(ce->name + name_start, name->path, name->pathlen))
> +               return 0;

What about the intervening '/' character?  Could we get a false hit
between "foo/bar/" and "foo.bar/"?

Also, do we have to worry about the trailing '/'?

> +
> +       return 1;
> +}
> +
>  /*
>   * Note that traverse_by_cache_tree() duplicates some logic in this function
>   * without actually calling it. If you change the logic here you may need to
> @@ -1307,7 +1383,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                 }
>         }
>
> -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> +       if (unpack_nondirectories(n, mask, dirmask, src, names, info, 0) < 0)
>                 return -1;
>
>         if (o->merge && src[0]) {
> @@ -1337,9 +1413,14 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                         }
>                 }
>
> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> -                                            names, info) < 0)
> +               if (is_sparse_directory_entry(src[0], names, info)) {
> +                       if (unpack_nondirectories(n, dirmask, mask & ~dirmask, src, names, info, 1) < 0)
> +                               return -1;
> +               } else if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> +                                                   names, info) < 0) {
>                         return -1;
> +               }
> +
>                 return mask;
>         }
>
> --
> gitgitgadget
