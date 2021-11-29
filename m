Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCDBC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbhK2Wi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbhK2Whr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:37:47 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DADC1A1969
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:37:32 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so75872502edx.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 10:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UvkHauOUUcGqFx9+RC+5ZaCyTAtCoMcUU6KZG04vKZg=;
        b=WNoYyjYnZVlPNTeWlRJG+YJ/jR05rn6zVMzbvnIUuYHDAR6se3gl7S4zKSRM9b5f3i
         NwLCmbWOTCo8p3tnhfoVKgDHS/s5TErLkUIRv9MAvOFXQs7k39CLGVCtSG7dPHpf7g/j
         2bbuhTVXj0B9J/NNpbZS1FdAEH9H4fmWod5eQuUgEKG9XuhHsGq2FGfdT5499ASxf2F2
         NoQUMx0UwKa6maawyEDB/7sTEfaFHnAMNQjrOBwZcTx+BzaGeFEQusN6xDTrN56iaa1b
         K3TIQML1wQmM99JnY9tiVyMYuUa6tsUOwTKWvB83fb2a+7rz16JsXcdwlsUFMpJyFcYd
         goNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UvkHauOUUcGqFx9+RC+5ZaCyTAtCoMcUU6KZG04vKZg=;
        b=2QCn3Zxj6P4+WEQ7SdbUWdRz1y5DRDNTElg+R+YlS7IF+9gYabBQC9HLUFYUZiTqlv
         9I8nvLIrSc3K08lJfsOfe0TV/r7XG55e01/UfVn8pZmI8Ss+LMuSXThDqy+J7OzNOgop
         rlSnG2X8xQrzK3K22ienDTJVEmu3RQV29OyjBEefcbXPFeMcOEa8ePRHhXzgkOokXDJ4
         eMIGZd2Hl0czveG1znT51HM7k02cgIMYp12w1HmQt3S24zgU/dyAqgAuu6eH8VRebyE4
         Ftj7y9p5ES3e5VQZZQx2JZ3dq92GGinG68HKep0MSS7iq2kdTITYDjzlhPQ9lUTydGzX
         SB5A==
X-Gm-Message-State: AOAM533/BDFJKZLZnJxpwMjojUE0RbgcufKpLRBWE72QhjpD9exZqS5M
        /q+pUYw2mAghyHII0BSf7yk7sbHe4tK/8bRu/i4=
X-Google-Smtp-Source: ABdhPJzYqcpvXFyhjzi/hXR563UUH8DdWmNkUwT9p+k7BAHrn1WmnUcOZ9gfKd5V0mcuQD7A1NN96meAUAQumuicyYQ=
X-Received: by 2002:a05:6402:d73:: with SMTP id ec51mr77657474edb.175.1638211050738;
 Mon, 29 Nov 2021 10:37:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com> <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Nov 2021 10:37:19 -0800
Message-ID: <CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com>
Subject: Re: [PATCH v6 0/8] Sparse Index: integrate with reset
To:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, Nov 29, 2021 at 7:52 AM Victoria Dye via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Changes since V5
> ================
>
>  * Update t1092 test 'reset with wildcard pathspec' with more cases and
>    better checks
>  * Add "special case" wildcard pathspec check when determining whether to
>    expand the index (avoids double-loop over pathspecs & index entries)

Looks pretty good.  However, I'm worried this special case you added
at my prodding might be problematic, and that I may have been wrong to
prod you into it...

> Thanks! -Victoria
>
> Range-diff vs v5:
>
>  7:  a9135a5ed64 ! 7:  822d7344587 reset: make --mixed sparse-aware
>      @@ Commit message
>
>           Remove the `ensure_full_index` guard on `read_from_tree` and update `git
>           reset --mixed` to ensure it can use sparse directory index entries wherever
>      -    possible. Sparse directory entries are reset use `diff_tree_oid`, which
>      +    possible. Sparse directory entries are reset using `diff_tree_oid`, which
>           requires `change` and `add_remove` functions to process the internal
>           contents of the sparse directory. The `recursive` diff option handles cases
>           in which `reset --mixed` must diff/merge files that are nested multiple
>      @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
>       +          * (since we can reset whole sparse directories without expanding them).
>       +          */
>       +         if (item.nowildcard_len < item.len) {
>      ++                 /*
>      ++                  * Special case: if the pattern is a path inside the cone
>      ++                  * followed by only wildcards, the pattern cannot match
>      ++                  * partial sparse directories, so we don't expand the index.
>      ++                  */
>      ++                 if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
>      ++                     strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)

I usually expect in an &&-chain to see the cheaper function call first
(because that ordering often avoids the need to call the second
function), and I would presume that strspn() would be the cheaper of
the two.  Did you switch the order because you expect the strspn call
to nearly always return true, though?

Could the strspn() call be replaced by a `item.len ==
item.nowildcard_len + 1`?  I mean, sure, folks could list multiple
asterisks in a row in their pathspec, but that seems super unlikely
and even if it does happen the code will just fall back to the slower
codepath and still give them the right answer.  And the simpler check
feels a lot easier to parse for human readers.

But I'm worried there's a deeper issue here:


Is the wildcard character (or characters) in path treated as a literal
by path_in_cone_mode_sparse_checkout()?  I think it is...and I'm
worried that may be incorrect.  For example, if the path is

   foo/*

and the user has done a

  git sparse-checkout set foo/bar/

Then 'foo/baz/file' is not in the sparse checkout.  However, 'foo/*'
should match 'foo/baz/file' and yet 'foo/*' when treated as a literal
path would be considered in the sparse checkout by
path_in_cone_mode_sparse_checkout.  Does this result in the code
returning an incorrect answer?  (Or did I misunderstand something so
far?)

I'm wondering if I misled you earlier in my musings about whether we
could avoid the slow codepath for pathspecs with wildcard characters.
Maybe there's no safe optimization here and wildcard characters should
always go through the slower codepath.

>      ++                         continue;
>      ++
>       +                 for (pos = 0; pos < active_nr; pos++) {
>       +                         struct cache_entry *ce = active_cache[pos];
>       +
>  8:  f91d1dcf024 = 8:  ddd97fb2837 unpack-trees: improve performance of next_cache_entry
>
> --
> gitgitgadget
