Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2F4C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A747860F4C
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbhH0VTX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231570AbhH0VTX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:19:23 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99611C0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:18:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id y34so17026714lfa.8
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ipqnrTLkUMnbWhwb8q3IEKvMhywwEJquTBiyLhzCdo=;
        b=fldeA4MlH5GEJ9tgGvccXMwl2Oa3FPra0WR6cCMgmux1ZhfWQUXXUANqrquU8xgT+D
         WGOe+vKcMxCExtSN9h9GSPtAt8Cn/ApbjvMjELokT8xgFr3hzMG9OM9aNIDD9hJxXzjq
         ocp5IqJ/HoQCqp7WJDknIE/mDbt9uVmPwmiYAN1YPtn3yTTKs5qXiMoUJREnnonKEp3q
         H4g3VnmAIOoHmTNHB07KxvUyib3K1NgH3BiIj5VkmYdDMUdaNEfJXcYWst3D4YPslHZe
         0UQUox2kkUQCO0M7YDtf1sAS9N6jgpy3uySdrREieerdQvaNyyrCzjBM60YSCpyuj8RY
         ObYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ipqnrTLkUMnbWhwb8q3IEKvMhywwEJquTBiyLhzCdo=;
        b=CqjTYBEr94uY/lMej0NOt1JSrtqbHvt1QXA3ubLWleHuUwBCspPzxOHRr6WLbUHwVq
         wriKwgXZMA9l9zTBNZgI03y/INA/TpOukp+UdWwuFSveMqw4MXD0aFngYvrnMYqkjwXT
         aqGxkAhiQWuo6MqWUaZycskajIExpjPCn+svhusYPLvWD5vwrwckM/EUOwhqFOR9DrFy
         SA2JYtWjy1wBkUOyJ8QrKZMVRr0Mn46Glm0li0xB/GBLM0lfRQpWTK69TLIhTXJ9qn9s
         b/5G5QAjkukBhHtvF8yhpFi1x3sR013VZuH2j2UE94ev+/TVyAkW2ja5oejRJHRVUGJe
         +ukQ==
X-Gm-Message-State: AOAM531bs38Vu2TG+/IyGlytULfwYsjkc5IuL1boPX9psgl3pOjk9Evh
        7o71crEcdvyA+iE/zNeHVYoiy5rSJF7P15UpOzQ7Rg==
X-Google-Smtp-Source: ABdhPJxRDAlzZ2Lf7N3TVAWIPdZmyziCxf4HhQyNQkxJioLXltzYai/MSWoapy/3Umx0fWLecm39yXrh5AEedYyPajs=
X-Received: by 2002:ac2:4e68:: with SMTP id y8mr7995787lfs.527.1630099111986;
 Fri, 27 Aug 2021 14:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <5153accded46c8ced8784ec135dbc77d5bc1a306.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <5153accded46c8ced8784ec135dbc77d5bc1a306.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 18:18:20 -0300
Message-ID: <CAHd-oW50QSBmtdNhwur=OcgcPnMBgszCp7aPbmwvz7qMPFj0iQ@mail.gmail.com>
Subject: Re: [PATCH 10/13] rm: skip sparse paths with missing SKIP_WORKTREE
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 24, 2021 at 6:54 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 4208f3f9a5f..a6da03da2be 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -301,7 +301,9 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>         for (i = 0; i < active_nr; i++) {
>                 const struct cache_entry *ce = active_cache[i];
>
> -               if (!include_sparse && ce_skip_worktree(ce))
> +               if (!include_sparse &&
> +                   (ce_skip_worktree(ce) ||
> +                    !path_in_sparse_checkout(ce->name, &the_index)))
>                         continue;

OK. And we don't need to update the advice reporting code below,
because `matches_skip_worktree()` already uses the
`(ce_skip_worktree(ce) || !path_in_sparse_checkout())`  logic.

> +                    !path_in_sparse_checkout"

>                 if (!ce_path_match(&the_index, ce, &pathspec, seen))
>                         continue;
> diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
> index a34b978bfd8..44f3e923164 100755
> --- a/t/t3602-rm-sparse-checkout.sh
> +++ b/t/t3602-rm-sparse-checkout.sh
> @@ -87,4 +87,15 @@ test_expect_success 'do not warn about sparse entries with --ignore-unmatch' '
>         git ls-files --error-unmatch b
>  '
>
> +test_expect_success 'refuse to rm a non-skip-worktree path outside sparse cone' '
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       git update-index --no-skip-worktree b &&
> +       test_must_fail git rm b 2>stderr &&
> +       test_cmp b_error_and_hint stderr &&
> +       git rm --sparse b 2>stderr &&
> +       test_must_be_empty stderr &&
> +       test_path_is_missing b
> +'

OK.
