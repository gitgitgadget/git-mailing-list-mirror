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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A283FC433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82996613AC
	for <git@archiver.kernel.org>; Tue, 18 May 2021 01:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345868AbhERBem (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 21:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbhERBel (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 21:34:41 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49D8C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:33:23 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z3so8263384oib.5
        for <git@vger.kernel.org>; Mon, 17 May 2021 18:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4eoJKNg6XdwVbSW+wyUWt6bjcJlbcCs2J0tTn84WSNY=;
        b=sZEZOugxvDScNB9lK6K7BkN22nBP0nXQuTsprhBzzRkFoUMMPXMj4LTdQCA1QjMqKK
         CuAph+bKctWaYpGJW2xnh1e9qnJ0AAJw/zuN10pHATD5OlqPT0+5TOLmtnzpmqrVOs2X
         hT3DwTq2oW0XJ/qv470+YCFWEgX59HX5D1kwRxzMyRcZLpVB5aazpZqd9p/TyZBGB5BM
         wJ2u5zpjYAmT8MEM/eTp+VLXbRemkPtS4NWntc8BuIrNPTlteGlR8iN5VdWe6YEsA2At
         0Xw+o5EfSqVTg2PNUcp2TBElFf1iWRjkgAcwUScu/tTiZVuSeNGGUwa9JybKvA/JZQwJ
         62Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4eoJKNg6XdwVbSW+wyUWt6bjcJlbcCs2J0tTn84WSNY=;
        b=fh+4SvWTQJduhRq5TCZppSjyINdF3Ky4Nm066yZeeiiCG40dtfVeC9WNR/D1mZOldr
         fMsHep5afXCC9Eg/61+XavRjb8vJt1hJO34pGEBwrZJmFuzDRElavlY/ey440ycZPAZo
         KNRk7oH17W6CugNCTHZpS8elOCQHSsG/stiXeMr5UEfnHiHlz/qmJs4MhWvGUbK7mCF2
         wtlXGpjr/9lGIFV64QkkXy2ZTwIHwGnc+blPEIGgHpFz4uzHrNERDIqo3IugNhkmeZcb
         vr5KfznQRpJIwKIeWYZeHQ2//m6Jvu1n9lYJdQqjqNyQbKHtvUJzeQM3aPMAF106dylM
         0t8A==
X-Gm-Message-State: AOAM532KCG9aSjsujNpYtol81BCpElb+8aljc+KgrixrGKggJPsgoiav
        +mnB7/KMRK1JN0IBeQauwWBZki2I9ms/wJZDY/g=
X-Google-Smtp-Source: ABdhPJwN3XeM7p3jkMQ4yvCqrwuKswfuaghDAGXz98pkGB5nOSqx6ycuGSIf1/FpqHY2ErXJ42nH3Sdok1BJ9Au2jh0=
X-Received: by 2002:aca:30cd:: with SMTP id w196mr1476963oiw.167.1621301603078;
 Mon, 17 May 2021 18:33:23 -0700 (PDT)
MIME-Version: 1.0
References: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
 <pull.932.v3.git.1621017072.gitgitgadget@gmail.com> <8aa41e749471df3bd9d593b8f55db6506eafea12.1621017072.git.gitgitgadget@gmail.com>
In-Reply-To: <8aa41e749471df3bd9d593b8f55db6506eafea12.1621017072.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 17 May 2021 18:33:12 -0700
Message-ID: <CABPp-BFx9=7j5LrLnQwzxba+i7_cAEXngzyt9rfOJfBuqOPBsw@mail.gmail.com>
Subject: Re: [PATCH v3 02/12] sparse-index: include EXTENDED flag when expanding
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
> When creating a full index from a sparse one, we create cache entries
> for every blob within a given sparse directory entry. These are
> correctly marked with the CE_SKIP_WORKTREE flag, but they must also be
> marked with the CE_EXTENDED flag to ensure that the skip-worktree bit is
> correctly written to disk in the case that the index is not converted
> back down to a sparse-index.

This seems odd to me.  When sparse-index is not involved and we are
just doing simple sparse checkouts, do we mark CE_SKIP_WORKTREE
entries with CE_EXTENDED?  I can't find any code that does so.

Is it possible that the setting of CE_EXTENDED is just a workaround
that happens to force the index to be written in cases where the logic
is otherwise thinking it can get away without one?  Or is there
something I'm missing about why the CE_EXTENDED flag is actually
needed here?

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  sparse-index.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sparse-index.c b/sparse-index.c
> index 1b49898d0cb7..b2b3fbd75050 100644
> --- a/sparse-index.c
> +++ b/sparse-index.c
> @@ -222,7 +222,7 @@ static int add_path_to_index(const struct object_id *oid,
>         strbuf_addstr(base, path);
>
>         ce = make_cache_entry(istate, mode, oid, base->buf, 0, 0);
> -       ce->ce_flags |= CE_SKIP_WORKTREE;
> +       ce->ce_flags |= CE_SKIP_WORKTREE | CE_EXTENDED;
>         set_index_entry(istate, istate->cache_nr++, ce);
>
>         strbuf_setlen(base, len);
> --
> gitgitgadget
>
