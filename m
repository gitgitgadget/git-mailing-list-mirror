Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D50C4332F
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 12:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240748AbiCNMLf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 08:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbiCNMIL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 08:08:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5832B1BB
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 05:04:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z26so21500366lji.8
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 05:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=La7XIqZG/XPlSAFiUru+cbwLXQlhbx0WNpTIejAXyAM=;
        b=LloTibEAFPN0uVZinaL/ZXn6XtR3Sf1k+CnEV3G5EySQEyqps6RdenRmeQ1HgeD/Uo
         qHID0y+pJl6NEN3ZNZeYgBIu7kib27E0wmI/6POSrZAddXnk0n4kaSRW3+LsllHpqdIE
         Xj5FLaW26KRGAsc8HTyBc1bSRS02KUZfJuxdRPJLWvH4Fv35QVusEamOjyY6tP1MZnLG
         HeTvIgWFX8bjVBlrGnTwcIZJ/zHOE4xCGkKRu3qMUyqVwYG6x19kIxFnmQdjxt2u7YZ0
         lWNqx2RNjHfPHGncpSqTOLt6TzSUcSvAli7VOk7W46BV+83NCT9o/fTNeG6tf+KGjiwP
         TP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=La7XIqZG/XPlSAFiUru+cbwLXQlhbx0WNpTIejAXyAM=;
        b=OqKp3j0vZx3F0+u3EwE4xsvKTxkwBNQJoTPSEgEqzzMpnUKreI7/m+T0ArwvUjxhkU
         ML80pq9l4p+RTpvmlsCOZo7twv3PmZhQoumSn9OGWb7gwx9X1RY/3N6kqFqspD6m63+E
         6T5DFdcFqH9olJIreJE48DGCj5u4ObZAjqVcpf7HeOiwbjJKvCyd8MrlsLAB4uasIKy/
         aNy/5IES5HOlUWwQw3MjLm6GngGE8sN/GAUA9vxvLiT7imIDp0pEBdOIOlPUwwK6DoRm
         DDZ2growWGJxHYB+0F4r6AVL1E5Ytr4BlKOdRaJtRZlZJgOneOnBB46xpOpKDjMsI6Aw
         xmeQ==
X-Gm-Message-State: AOAM531RgLrHhW7TOv9aWnbGSiWFGUbNIU11Ub7/tfykR9BRHdkejOCu
        Cnu+G3IbKKYihiwPBZHpRlK+LcV1Eh5/2NHX7J2m4WVdpraduA==
X-Google-Smtp-Source: ABdhPJxrJg+jG05XdRl4feDb1gI6JDzqE8uEsG8NyTFiT/B6KqAF/bqwbyq7G17gAo6LSCGpfermJN/Y59QM5W/ShXg=
X-Received: by 2002:a2e:b5b9:0:b0:246:b30:64c8 with SMTP id
 f25-20020a2eb5b9000000b002460b3064c8mr13766242ljn.17.1647259452586; Mon, 14
 Mar 2022 05:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220314080601.10504-1-gaurijove@gmail.com>
In-Reply-To: <20220314080601.10504-1-gaurijove@gmail.com>
From:   Jayati Shrivastava <gaurijove@gmail.com>
Date:   Mon, 14 Mar 2022 17:33:57 +0530
Message-ID: <CANsrJQd0v2V9H8HPkiH2179C1c-NOSTRRB8YXt8v6R0YAbFPDQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Use reverse_commit_list helper function for in-place
 list reversal
To:     Git List <git@vger.kernel.org>
Cc:     johannes.schindelin@gmx.de, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch addresses https://github.com/gitgitgadget/git/issues/1156 . I have
left builtin/merge.c unmodified since in its case, the original list
is needed separately
from its reverse copy.

On Mon, Mar 14, 2022 at 1:36 PM JAYATI SHRIVASTAVA <gaurijove@gmail.com> wrote:
>
> From: JAYATI SHRIVASTAVA <gaurijove@gmail.com>
>
> Here, a reverse copy of the list is being created by looping and the
> original list is no longer used by the code. Therefore, instead of creating a copy,
> we can reverse the original list in-place using the reverse_commit_list helper
> function a copy.
>
> Signed-off-by: JAYATI SHRIVASTAVA <gaurijove@gmail.com>
> ---
>  sequencer.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 35006c0cea..bccbb9e352 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -3749,7 +3749,7 @@ static int do_merge(struct repository *r,
>         int run_commit_flags = 0;
>         struct strbuf ref_name = STRBUF_INIT;
>         struct commit *head_commit, *merge_commit, *i;
> -       struct commit_list *bases, *j, *reversed = NULL;
> +       struct commit_list *bases, *j;
>         struct commit_list *to_merge = NULL, **tail = &to_merge;
>         const char *strategy = !opts->xopts_nr &&
>                 (!opts->strategy ||
> @@ -3984,9 +3984,7 @@ static int do_merge(struct repository *r,
>                       git_path_merge_head(r), 0);
>         write_message("no-ff", 5, git_path_merge_mode(r), 0);
>
> -       for (j = bases; j; j = j->next)
> -               commit_list_insert(j->item, &reversed);
> -       free_commit_list(bases);
> +       bases = reverse_commit_list(bases);
>
>         repo_read_index(r);
>         init_merge_options(&o, r);
> @@ -4002,10 +4000,10 @@ static int do_merge(struct repository *r,
>                  * update the index and working copy immediately.
>                  */
>                 ret = merge_ort_recursive(&o,
> -                                         head_commit, merge_commit, reversed,
> +                                         head_commit, merge_commit, bases,
>                                           &i);
>         } else {
> -               ret = merge_recursive(&o, head_commit, merge_commit, reversed,
> +               ret = merge_recursive(&o, head_commit, merge_commit, bases,
>                                       &i);
>         }
>         if (ret <= 0)
> --
> 2.35.1.455.g1a4874565f
>
