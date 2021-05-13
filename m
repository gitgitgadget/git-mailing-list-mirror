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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87542C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F24B610F7
	for <git@archiver.kernel.org>; Thu, 13 May 2021 03:26:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhEMD1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 23:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbhEMD1c (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 23:27:32 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4DBC061574
        for <git@vger.kernel.org>; Wed, 12 May 2021 20:26:22 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id v22so19303105oic.2
        for <git@vger.kernel.org>; Wed, 12 May 2021 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WbKuIQhgn/LSkDS7ioPwTkPLLwCnSTwhMmKSlbhRaqg=;
        b=Ba9xPMyPDpsCZVFAwsbHc3qEkazo4lFiGMBMDbO07mtkHgfYyXXoNQfxefa8vniKuu
         DdvnibPsNvYgmt2vhia2PBnzjmi1cBJDDla6Ty4HV3+frcv6anU3nfFVeT8cnsQ12mB3
         FD+whUabKI32Lk8H5Wu3LBf5DNIkQDiew+xkLbt+mHnuR4EVlVeqjkNKfcvsx4eIK2g2
         lMCKIl2SAUiCLnNW+aKS7xFDqyA1KygipUaozOqA/KQg4YsXYYRd5e2d6zTz61MOv1R7
         bb93BIx9P3lttQQ4xNToNXZ0NogrcTtmG/iO3NLvBB4IcRebQwsjqh8PGEoESdCvi5ze
         PZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WbKuIQhgn/LSkDS7ioPwTkPLLwCnSTwhMmKSlbhRaqg=;
        b=BVvYiQ3vJ5CGySHWl5oJs9z1BilQUDQOkkW/mihm5FVeF+zAb7oWOQDy6JJFTuQ9y7
         T/6nlZFQyr39hkWsXIl0gWn1/eqK+lDq6RjKvdSlgqVo8tHtzI+0kZM5WAh2+m01WeTz
         hv8JMrlYER9ytQX/mQFSaopeq/y9dA4pbNPb/jLAjvGKLM384aSQXOiHJDSCL0TVloex
         Fe0dNYdwkn5ERxM9kCmsgffSjB5ZKqfiuy+Yp6D9noii+4g/1BfW2T/JjRhxyyhfaPNT
         FVCL0bM5Jt+XpvR8lVFk0Q//0+k5qWDlJ2HlYIw58DwQcfmLbMsVJiNSVD1J0LDPsYkO
         SiCQ==
X-Gm-Message-State: AOAM533z3uJ37ltdKFB+GUkTQwyOSef7EYvq211JqilUDPLRe/78XQNp
        qe44kOOr0ehXvGyWRtZGsGaCDlqkDSmqnYHJ5N8=
X-Google-Smtp-Source: ABdhPJwtQzWJB8aXKN8pVVvVEUH/C+csXX14IsK14xa9MYerqBP/CxcnOApB91Kapif90TH4A7+Y4Rm6x1qDbeIQ3uI=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr13058358oiw.31.1620876381435;
 Wed, 12 May 2021 20:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
 <pull.932.v2.git.1619213665.gitgitgadget@gmail.com> <24e71d8c062239be9b995bcc31dd12edf84106e3.1619213665.git.gitgitgadget@gmail.com>
In-Reply-To: <24e71d8c062239be9b995bcc31dd12edf84106e3.1619213665.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 12 May 2021 20:26:10 -0700
Message-ID: <CABPp-BHoy9U21tdPtq==MrjcT3m2w0FpaG46pnnzW+VwcoFUcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] unpack-trees: compare sparse directories correctly
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

On Fri, Apr 23, 2021 at 2:34 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> As we further integrate the sparse-index into unpack-trees, we need to
> ensure that we compare sparse directory entries correctly with other
> entries. This affects searching for an exact path as well as sorting
> index entries.
>
> Sparse directory entries contain the trailing directory separator. This
> is important for the sorting, in particular. Thus, within
> do_compare_entry() we stop using S_IFREG in all cases, since sparse
> directories should use S_IFDIR to indicate that the comparison should
> treat the entry name as a dirctory.
>
> Within compare_entry(), it first calls do_compare_entry() to check the
> leading portion of the name. When the input path is a directory name, we
> could match exactly already. Thus, we should return 0 if we have an
> exact string match on a sparse directory entry.

Thanks for splitting up patch 2 from the original series; it's much
easier to understand these separate patches.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 1067db19c9d2..3af797093095 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -969,6 +969,7 @@ static int do_compare_entry(const struct cache_entry *ce,
>         int pathlen, ce_len;
>         const char *ce_name;
>         int cmp;
> +       unsigned ce_mode;
>
>         /*
>          * If we have not precomputed the traverse path, it is quicker
> @@ -991,7 +992,8 @@ static int do_compare_entry(const struct cache_entry *ce,
>         ce_len -= pathlen;
>         ce_name = ce->name + pathlen;
>
> -       return df_name_compare(ce_name, ce_len, S_IFREG, name, namelen, mode);
> +       ce_mode = S_ISSPARSEDIR(ce->ce_mode) ? S_IFDIR : S_IFREG;

Ah, so here the fact that S_ISSPARSEDIR is defined as
   #define S_ISSPARSEDIR(m) ((m) == S_IFDIR)
whereas S_ISDIR is defined as
   #define S_ISDIR(m)      (((m) & S_IFMT) == S_IFDIR)
turns out to be critically important, because if you used S_ISDIR()
here, then we'd get ce_mode = S_IFDIR for submodules and break the
sorting.  S_ISSPARSEDIR() gives us the correct value.

> +       return df_name_compare(ce_name, ce_len, ce_mode, name, namelen, mode);
>  }
>
>  static int compare_entry(const struct cache_entry *ce, const struct traverse_info *info, const struct name_entry *n)
> @@ -1000,6 +1002,10 @@ static int compare_entry(const struct cache_entry *ce, const struct traverse_inf
>         if (cmp)
>                 return cmp;
>
> +       /* If ce is a sparse directory, then allow an exact match. */
> +       if (S_ISSPARSEDIR(ce->ce_mode))
> +               return 0;

I think the comment from the commit message belongs in the code; the
comment in the code is too jarring without the more detailed
explanation.

> +
>         /*
>          * Even if the beginning compared identically, the ce should
>          * compare as bigger than a directory leading up to it!
> --
> gitgitgadget
