Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D5971F404
	for <e@80x24.org>; Thu, 19 Apr 2018 20:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeDSUsL (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 16:48:11 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42433 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753295AbeDSUsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 16:48:11 -0400
Received: by mail-pl0-f66.google.com with SMTP id t20-v6so3929393ply.9
        for <git@vger.kernel.org>; Thu, 19 Apr 2018 13:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8zbkNYUw2CGUQlOBDWWJ/PQFdLTNb7D9Uem5H63nI5M=;
        b=fURM7g6Uz3MYC5dREBYHYK8GEvOLOG1gTgpjM9IHkBL4dNdwaqq5OUxjgPvEI6zA56
         AM6WQjPqq/m3obsCT3kWs8iHJcDpwQ8iNFOrNui3VwAZJJ7426EhVaMnqrziBq2gFyH+
         YRvot3mXnQzLk9SZ3hwJqybKD8eT9AyK5bR8jy7kTcclmK3t9OT0Xo6Ti7qXQQI1gpCb
         MaYiup3sRT+0iJK4PMhbXjMZXOkyz3OobNmwPYjqulQpajUaWMHfPA4nzs/EM/siRWmg
         L05ik7eKWUpjBLEUhTLiZeTBkO6Qr8WddQ9k+YwMwVFpO3++YBEDie4JnGUGaNcz21qR
         SdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8zbkNYUw2CGUQlOBDWWJ/PQFdLTNb7D9Uem5H63nI5M=;
        b=U5E2EzXA+gFhVgzHRmbTQhwsvgFFOUHKf1ZWfFF2CCcg+nWKgzsAZKE0W6D9dQ2yuQ
         Lzqf6MmLbxxtX+HVRp4YeVmnMXof8hRHW2U9XvdldVuMEUHqYF64kuz25m03wPEs+lw8
         bPzh23y1JTMRwAE4DHaOuBLApyDZl+jlJdyZCGWF4rdFB5zZpsoxZT8TdnJq0KoamvnF
         Vh9UfZKujcp+KLMmYwO4I+AzjvNSpJZlFG3v4saGtOXDwgA60+EUSjhiQAtM0CTuijEO
         RGU9eZTd2Ajm/7YhA2SuS6S4zpsKzMYp1eZ8MNpmvKpj/TyS6fUx/ZbLj66/VzlVvmdR
         KLyQ==
X-Gm-Message-State: ALQs6tBgLCOy6nnZb2ULRCoCsE5pnD2sWaG6Hm+L+Rbl6HGSnL8t8jJk
        k3sVyGX2VUDkDon07/9AfzAaGe17AwToUZLRGeFeBg+RmSE=
X-Google-Smtp-Source: AIpwx4/f1CAF2+bh2viMKYA3d46ekbB4kk0r2fbdzgpY7+QiZuF+Krv5PeJ1w9tOD4GblZXGbtrAbhljT0MQPoz81+w=
X-Received: by 2002:a17:902:1c7:: with SMTP id b65-v6mr5271338plb.298.1524170890736;
 Thu, 19 Apr 2018 13:48:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Thu, 19 Apr 2018 13:48:09 -0700 (PDT)
In-Reply-To: <20180419175823.7946-26-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-26-newren@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 19 Apr 2018 22:48:09 +0200
Message-ID: <CAN0heSrSn1wYGoRD6+c_Jk+rAUTbY94JLspwfiki6z4h=mnPSQ@mail.gmail.com>
Subject: Re: [PATCH v10 25/36] merge-recursive: fix overwriting dirty files
 involved in renames
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 19 April 2018 at 19:58, Elijah Newren <newren@gmail.com> wrote:
> This fixes an issue that existed before my directory rename detection
> patches that affects both normal renames and renames implied by
> directory rename detection.  Additional codepaths that only affect
> overwriting of dirty files that are involved in directory rename
> detection will be added in a subsequent commit.
>
> Reviewed-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  merge-recursive.c                   | 85 ++++++++++++++++++++++-------
>  merge-recursive.h                   |  2 +
>  t/t3501-revert-cherry-pick.sh       |  2 +-
>  t/t6043-merge-rename-directories.sh |  2 +-
>  t/t7607-merge-overwrite.sh          |  2 +-
>  unpack-trees.c                      |  4 +-
>  unpack-trees.h                      |  4 ++
>  7 files changed, 77 insertions(+), 24 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index c1c4faf61e..7fdcba4f22 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -337,32 +337,37 @@ static void init_tree_desc_from_tree(struct tree_desc *desc, struct tree *tree)
>         init_tree_desc(desc, tree->buffer, tree->size);
>  }
>
> -static int git_merge_trees(int index_only,
> +static int git_merge_trees(struct merge_options *o,
>                            struct tree *common,
>                            struct tree *head,
>                            struct tree *merge)
>  {
>         int rc;
>         struct tree_desc t[3];
> -       struct unpack_trees_options opts;
>
> -       memset(&opts, 0, sizeof(opts));
> -       if (index_only)
> -               opts.index_only = 1;
> +       memset(&o->unpack_opts, 0, sizeof(o->unpack_opts));
> +       if (o->call_depth)
> +               o->unpack_opts.index_only = 1;
>         else
> -               opts.update = 1;
> -       opts.merge = 1;
> -       opts.head_idx = 2;
> -       opts.fn = threeway_merge;
> -       opts.src_index = &the_index;
> -       opts.dst_index = &the_index;
> -       setup_unpack_trees_porcelain(&opts, "merge");
> +               o->unpack_opts.update = 1;
> +       o->unpack_opts.merge = 1;
> +       o->unpack_opts.head_idx = 2;
> +       o->unpack_opts.fn = threeway_merge;
> +       o->unpack_opts.src_index = &the_index;
> +       o->unpack_opts.dst_index = &the_index;
> +       setup_unpack_trees_porcelain(&o->unpack_opts, "merge");
>
>         init_tree_desc_from_tree(t+0, common);
>         init_tree_desc_from_tree(t+1, head);
>         init_tree_desc_from_tree(t+2, merge);
>
> -       rc = unpack_trees(3, t, &opts);
> +       rc = unpack_trees(3, t, &o->unpack_opts);
> +       /*
> +        * unpack_trees NULLifies src_index, but it's used in verify_uptodate,
> +        * so set to the new index which will usually have modification
> +        * timestamp info copied over.
> +        */
> +       o->unpack_opts.src_index = &the_index;
>         cache_tree_free(&active_cache_tree);
>         return rc;
>  }

As mentioned in a reply to patch 33/36 [1], I've got a patch to add
`clear_unpack_trees_porcelain()` which frees the resources allocated by
`setup_unpack_trees_porcelain()`. Before this patch, I could easily call
it at the end of this function. After this, the ownership is less
obvious to me.

It turns out that the only user of `unpack_opts` outside this function
can indeed end up wanting to use the error messages that `clear_...()`
would set out to free. So yes, the call to `clear_...()` will need to go
elsewhere.

It does sort of make me wonder if we should memset `unpack_opts` to zero
somewhere early, so that we can then `clear_...()` it early here before
zeroizing it. So yes, we'd be constantly allocating and freeing those
strings. Am I right to assume that the code after your series would do
(roughly) the same number of calls to `setup_unpack_trees_porcelain()`,
i.e., `git_merge_trees()` as it did before?

All of this is arguably irrelevant for this series. It might be better
if I clarify this memory ownership and do any adjustments as part of my
patch (series), rather than you shuffling things around at this time.

Mostly thinking out loud. If you have any thoughts, feel free to share.

Martin

[1] https://public-inbox.org/git/CAN0heSquJboMMgay+5XomqXCGoHtXxf1mJBmY_L7y+AA4eG0KA@mail.gmail.com/
