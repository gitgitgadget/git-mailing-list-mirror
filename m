Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C782BC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 15:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237443AbiG2Pbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiG2Pbs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 11:31:48 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB7C6FA0C
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:31:47 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id m7so3851746qkk.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c2fORxL4ZCNTh6MfRZhiFiz9RQ5w1opeMATzsspFcx0=;
        b=FNMDDMCHHlircqF1sSDVZEwWUcHhYz7agtdKTlE0wP6GLNWAe/6HOVsyezvFRboPEN
         DzzqL69uLh8QVtLVi9g5QrJ4fC5n/Me6W8wUwx0kmDF4dDNy40H3ANdyBMGsUKWdeVIB
         jOc3R/IijqZkhWWAecosm+XNqtSd4nLSFByHEn8pCIW4fIs3TxuL3+Hv9qPAin8weVqS
         sdyb0LYw/RWES6ooidbJrtha2yYvzOw98R3azpgVtmaix5kTWsC8YYjr9Xn/HPP2iZ6g
         GOnPJCsw9SYqe1bIgkAL/ghF+EdfIGyzr2+GoQs9CISfmTjIcKFiZAve/A2dULr+l77K
         aRFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2fORxL4ZCNTh6MfRZhiFiz9RQ5w1opeMATzsspFcx0=;
        b=pmLt2s59VB+BYju/DPMCrroidW1y97PtUk0Fb2blQfHLIISiHLsehvmqcNCQ/0XhAL
         N9crnKN88xMInFxu3dJY5mzLnQ6A6OGpAL07tzWyeAD0Poj3gdof1PZ/Abx8KtZUA3Mn
         /3ULuo3dJ4S8rrlrvnftP4l/bgqbNOBxrOGet6njKu46ITzRaYPZngpfhs1wzM6A7f1Y
         5pBSZEABkgFxxN33pv2uTy6IW8xAu8eS/nAJJSfOH6i1YP8C9HGu/p4RVIetuz+qCCTZ
         2Q7JwPvz9y/nrufWS2pshqSPZd/5wuHWJFAgMYyIzAOIcp8CpyfhiUhAjOpJLAGcaGme
         HYuQ==
X-Gm-Message-State: AJIora+mr5iNcxomZEavoge39iIb++HXm0m/03imUZPKmDN4DqI1X/oh
        YguyFMwYfMscpz0S6jqD6sgf2EuWpAIB9jF+3aaR/2oYSUE=
X-Google-Smtp-Source: AGRyM1vZb5LBPXPvZjWa0+36oB1oiK+E0+FUQBA+ewBJnagk1+CDyTz73C6h+ngDH3hCkuZCMKtq2zhXndN6Ikqv7bs=
X-Received: by 2002:a05:620a:754:b0:6b5:eb92:42e5 with SMTP id
 i20-20020a05620a075400b006b5eb9242e5mr3109712qki.183.1659108706343; Fri, 29
 Jul 2022 08:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 29 Jul 2022 08:31:30 -0700
Message-ID: <CABPp-BEBVO+O8bJaQRwVpt1VC0dC+sMJduAtmHpYev9uhnF-Rw@mail.gmail.com>
Subject: Re: [PATCH] merge-ort: clean up after failed merge
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 29, 2022 at 1:52 AM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 9fefce68dc8 (merge-ort: basic outline for merge_switch_to_result(),
> 2020-12-13), we added functionality to lay down the result of a merge on
> disk. But we forgot to release the data structures in case
> `unpack_trees()` failed to run properly.
>
> This was pointed out by the `linux-leaks` job in our CI runs.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     merge-ort: clean up after failed merge
>
>     I was investigating why seen's CI runs fail, and came up with this fix.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1307%2Fdscho%2Fmerge-ort-impl-leakfix-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1307/dscho/merge-ort-impl-leakfix-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1307
>
>  merge-ort.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index ee7fbe71404..61b9e90018b 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1002,6 +1002,7 @@ void merge_switch_to_result(struct merge_options *opt,
>                 if (checkout(opt, head, result->tree)) {
>                         /* failure to function */
>                         result->clean = -1;
> +                       merge_finalize(opt, result);
>                         return;
>                 }
>
> @@ -1010,6 +1011,7 @@ void merge_switch_to_result(struct merge_options *opt,
>                                                     &opti->conflicted)) {
>                         /* failure to function */
>                         result->clean = -1;
> +                       merge_finalize(opt, result);
>                         return;
>                 }
>         }
>
> base-commit: 9fefce68dc85d96781090f86c067d83f7c50b617
> --
> gitgitgadget

Good catch.  Can you rebase on to a slightly newer commit?  I think we
also need a trace2_region_leave() call in each block as well, which is
only clear if you look at newer versions.
