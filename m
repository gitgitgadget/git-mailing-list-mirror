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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA00C433ED
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E345613BA
	for <git@archiver.kernel.org>; Tue, 18 May 2021 02:03:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240136AbhERCFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 22:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236022AbhERCFK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 22:05:10 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380ECC061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 19:03:53 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso7303613otg.9
        for <git@vger.kernel.org>; Mon, 17 May 2021 19:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PTqzcxg/kBBx1KLxok9+SGk+1eQZvHhULVHFkwN5Hkw=;
        b=RNX4quQjlvGNKdDrC3w0YGIcNk36ksBEiHEDOUpsDRA5XvLi4Gt1lFNWstUSUmP8T3
         O6ypYUIKbpMTNClUiFpon12ZVMkLh97ggenRRPiCMredGEljhFLaO/2W0ad0ZhpxrVOM
         z6xWGn8LfvbDri0e36cINylYhzf6U+OoeKRn41yHZIx97/LGy9Bq9oWkG70+Edkomgjx
         e8kuHSfzlSNuZHEscd6uYuCZlgUDrcNZAxsBQzvXVztJs7JvtAdkKG3+/mXrP00yzNvY
         /MdG6iEjZxYkjCaSThLTdsls73QyLtGk/scG3iRhxCcGejfIO6FB4kdsoINMjqRQPw4g
         a5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PTqzcxg/kBBx1KLxok9+SGk+1eQZvHhULVHFkwN5Hkw=;
        b=HSxTtjUrESsWan6a/P7/SJjN0ltame/g71oxB1/nzHsVnwdKYwg5IxDbdtkgJhbsPC
         IINvMfWIgt3J2CLUEG0Nq89DX32bNNTTW0FRM1nUSoV4UYXb+gRa2gso94dsmCDSNssd
         Wu3ostzkjaOhNFQcbh/nfzdAgccllAWQqhG1uNq7le3HwwFbBvPUYl87mJFWlZEbqVQN
         9W5fzH850k5nTTZsbfPQM5yp1L535uKMX+OnY/Hj/jNu9GMffwZ7VH3anr0+M340c2HM
         E4F1jmC1fJWn3iwzDBnoOx5yhSpviQX1B8XdTHcYjfPxafa8fiUFCQz+Sl9ZBhoBIZzJ
         qBGw==
X-Gm-Message-State: AOAM533FYSWWUYQCkaTU+pRhXj2Nsyz4kd+yolnyj1fkdOFJjVev/ksY
        7jXmlGITselqpaw7wMWypgFuQwv0QcGkGHVdm7M=
X-Google-Smtp-Source: ABdhPJzr7Vef3sm7l0OFWLjsTO5YxOCCGXrHppIvde+sxe6pqOATy5UmS5Q4MkUOKy7TKlJd1BIOEP1Vn4qPha1LfJM=
X-Received: by 2002:a9d:7096:: with SMTP id l22mr2178477otj.345.1621303431629;
 Mon, 17 May 2021 19:03:51 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <598375d3531fabe8582cb6d93838df09e1bd06c3.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <598375d3531fabe8582cb6d93838df09e1bd06c3.1621017072.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 19:03:40 -0700
Message-ID: <CABPp-BGc_Cduk3aFJqk4MjJ2k6KMDWSnwZfJM+E-1oK8txsf7Q@mail.gmail.com>
Subject: Re: [PATCH v3 07/12] unpack-trees: stop recursing into sparse directories
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

On Fri, May 14, 2021 at 11:31 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> When walking trees using traverse_trees_recursive() and
> unpack_callback(), we must not attempt to walk into a sparse directory
> entry. There are no index entries within that directory to compare to
> the tree object at that position, so skip over the entries of that tree.
>
> This code is used in many places, so the only way to test it is to start
> removing the command_requres_full_index option from one builtin at a
> time and carefully test that its use of unpack_trees() behaves correctly
> with a sparse-index. Such tests will be added by later changes.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  diff-lib.c     | 6 ++++++
>  unpack-trees.c | 7 +++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index b73cc1859a49..d5e7e01132ee 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -322,6 +322,9 @@ static void show_new_file(struct rev_info *revs,
>         unsigned int mode;
>         unsigned dirty_submodule = 0;
>
> +       if (S_ISSPARSEDIR(new_file->ce_mode))
> +               return;
> +

Makes sense, but is this related to the unpack-trees.c changes and the
commit message, or should it be in a separate commit?

>         /*
>          * New file in the index: it might actually be different in
>          * the working tree.
> @@ -343,6 +346,9 @@ static int show_modified(struct rev_info *revs,
>         const struct object_id *oid;
>         unsigned dirty_submodule = 0;
>
> +       if (S_ISSPARSEDIR(new_entry->ce_mode))
> +               return 0;
> +

Same question as above.  And a few more questions...

What if the old commit/tree had a file at this path, and the new
commit/tree has a (sparse) directory at this path?  Shouldn't
_something_ be shown for the file deletion?  Or does such a case not
run through this code path?

Also, wouldn't we expect it to be an error for show_modified() to be
called on a sparse directory?  If two sparse directories differed, we
should have inflated the trees to find the differences in the path
underneath them, right?  And if they didn't differ, then
show_modified() should not have been invoked?

I can see cases where we wouldn't want to bother looking at the
differences between to sparse directories, e.g. a
--restrict-to-sparsity-paths option to diff/log/etc, but I don't see
you setting this behind an option here.

>         if (get_stat_data(new_entry, &oid, &mode, cached, match_missing,
>                           &dirty_submodule, &revs->diffopt) < 0) {
>                 if (report_missing)
> diff --git a/unpack-trees.c b/unpack-trees.c
> index ef6a2b1c951c..703b0bdc9dfd 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1261,6 +1261,7 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>         struct cache_entry *src[MAX_UNPACK_TREES + 1] = { NULL, };
>         struct unpack_trees_options *o = info->data;
>         const struct name_entry *p = names;
> +       unsigned unpack_tree = 1;
>
>         /* Find first entry with a real name (we could use "mask" too) */
>         while (!p->mode)
> @@ -1307,7 +1308,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                 }
>         }
>
> -       if (unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
> +       if (unpack_tree &&
> +           unpack_nondirectories(n, mask, dirmask, src, names, info) < 0)
>                 return -1;
>
>         if (o->merge && src[0]) {
> @@ -1337,7 +1339,8 @@ static int unpack_callback(int n, unsigned long mask, unsigned long dirmask, str
>                         }
>                 }
>
> -               if (traverse_trees_recursive(n, dirmask, mask & ~dirmask,
> +               if (unpack_tree &&
> +                   traverse_trees_recursive(n, dirmask, mask & ~dirmask,
>                                              names, info) < 0)
>                         return -1;
>                 return mask;
> --
> gitgitgadget

The unpack-trees.c changes make sense to me still.
