Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69AC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E0660F5B
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbhH0VSv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhH0VSu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:18:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB81BC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:17:58 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id y6so13771289lje.2
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qJR5Y+P85lspAmUkRO77x5PSUa+5RBUD3qQTd++g0pE=;
        b=yRbS74LEyliKk/tMnhGsJoljPhZXkxsjLOMVlREexJ4Y4V7kflM1nA64rLR+ZpFXNL
         XxbdDRmYkXZqikJBKeE1P4JTqudUbYej+J4rtoFeH2w8TApBQHrYcM/LhwBMoUa8msjr
         ywF7VcMg6veA8MAS+f7gywMpNinwO+ektR7bCEo1sMw9J4clfPdTkxu2q18SYGPDDK7D
         YPKqU7H6Eov1cyVli9sTmanW1iMUS1TXx+X4ThVElMNrmXt+WcEprFlz7kJUuP2/vd29
         wJla69WmXXvb5WKK40ipt+V7B5hgiueylsTs7x06kChfS2B6+mnDx6Emc+9bXUsQGWlm
         EHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJR5Y+P85lspAmUkRO77x5PSUa+5RBUD3qQTd++g0pE=;
        b=XxkNLh1KL4DEiavzOu+OTCo4Hnfx+UNB9J8TZmACKE5P6agz8Lw7lQp11FtXqSd/wt
         oYNPxkzl0/4RoQL7idRHA/p9w0P0yc7l+uopgaiMTMzhtMHbiO3EuYTOlHn4/sMBLHMA
         yoh8pRrk7Zo8jkSyowesEoil6sA3oxunydSK860mr5UYKry4pFqz831ILF0LwMPNFjqy
         6Yq7xca4/YR0lapIzANYaBQrSb2Xint7ePTIiB87y8cVGo6fVdB+gxVuwUm2Ncop9puk
         7J1D7g/1dwM3KoY0u1VkGuPDsuJ/k8XQ6wJpwsfN9pF+tODnLIrwom83ufcN0wYIMwvC
         fRBw==
X-Gm-Message-State: AOAM531YEhXCIqrn+i/Ty9sZHQXdyjq3Ic6nnliT64lq797cKlgIt9gd
        TTKJZtTNrqHZ/YF7LtbyF+POBQZfcGyAlnWvL6Wa1A==
X-Google-Smtp-Source: ABdhPJyqBaIslDtybFR3Y3NdkcaWVg5cA7JUK7nqi1Jq/syQ6KxMED/8wYAZT20WlwlFjZKlJ+u9ZRw/hQpqhCpx0Ic=
X-Received: by 2002:a2e:9dcb:: with SMTP id x11mr364288ljj.137.1630099076967;
 Fri, 27 Aug 2021 14:17:56 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <6c9c986ff43fe7f065c27e61468534007e70d2a7.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <6c9c986ff43fe7f065c27e61468534007e70d2a7.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 18:17:46 -0300
Message-ID: <CAHd-oW5JD56UerW6N18Ap9Dmt9eVyd7dZKUhJR6-hSjzzM0s5A@mail.gmail.com>
Subject: Re: [PATCH 09/13] rm: add --sparse option
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
> Subject: [PATCH 09/12] rm: add --sparse option

Maybe mention in the commit message that, for now, rm's --sparse only
affects entries with the skip_worktree bit set? (Which will be changed
in the following patch.)

> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -298,7 +300,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>         ensure_full_index(&the_index);
>         for (i = 0; i < active_nr; i++) {
>                 const struct cache_entry *ce = active_cache[i];
> -               if (ce_skip_worktree(ce))
> +
> +               if (!include_sparse && ce_skip_worktree(ce))
>                         continue;

OK, we no longer ignore the skip_worktree entry if --sparse is given ...

>                 if (!ce_path_match(&the_index, ce, &pathspec, seen))
>                         continue;
> @@ -322,7 +325,8 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>                                 seen_any = 1;
>                         else if (ignore_unmatch)
>                                 continue;
> -                       else if (matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
> +                       else if (!include_sparse &&
> +                                matches_skip_worktree(&pathspec, i, &skip_worktree_seen))
>                                 string_list_append(&only_match_skip_worktree, original);

... and we also don't need to look for matches here as we won't
display the error/advice match.

>                         else
>                                 die(_("pathspec '%s' did not match any files"), original);
> diff --git a/t/t3602-rm-sparse-checkout.sh b/t/t3602-rm-sparse-checkout.sh
> index e9e9a15c74c..a34b978bfd8 100755
> --- a/t/t3602-rm-sparse-checkout.sh
> +++ b/t/t3602-rm-sparse-checkout.sh
> @@ -36,13 +36,25 @@ done
>
>  test_expect_success 'recursive rm does not remove sparse entries' '
>         git reset --hard &&
> -       git sparse-checkout set sub/dir &&
> +       git sparse-checkout set sub/dir/ &&

Is this change necessary?

>         git rm -r sub &&
>         git status --porcelain -uno >actual &&
>         echo "D  sub/dir/e" >expected &&
>         test_cmp expected actual
>  '
>
> +test_expect_success 'recursive rm --sparse removes sparse entries' '
> +       git reset --hard &&
> +       git sparse-checkout set "sub/dir" &&
> +       git rm --sparse -r sub &&
> +       git status --porcelain -uno >actual &&
> +       cat >expected <<-\EOF &&
> +       D  sub/d
> +       D  sub/dir/e
> +       EOF
> +       test_cmp expected actual
> +'

Nice!
