Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8F1C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2CC60FD9
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 21:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhH0VV3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 17:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhH0VV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 17:21:29 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F42BC0613D9
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:20:39 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m18so2908220lfl.10
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 14:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61Roge+KRXJM7Y2m/XZnMBROt6VmegTylBKH8FQbHHU=;
        b=pQnL8UiQx5OX2toN3/FItKPIFWfIMfOvwOCoNg/GWLtLrJSLdbUibluSUkuur8aas0
         MFK++w8oMszknGOTHOjT/sgDdQa9BC94HJyeJJiud2wdBdYQEh1MMGUBrnEcOiw6a9Sw
         e3ansBqyHIENVOv9+NPIdkYAOYloddHO2AlViTXyYKopw1g9++uCxJJLxOBfMCm5EXLP
         9iEguZViGrON025wggMHt+1b/xa8zczvUhpX5M+e5qCzSIXhT7kQdmY4Jq5YTYWhnXUo
         gB7sWzFUdp7T156K+6AewE4pPrdlfSbRZVll4A/jgKMoYDMUEKWwfVeaxTZAcVodnFCb
         FI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61Roge+KRXJM7Y2m/XZnMBROt6VmegTylBKH8FQbHHU=;
        b=rxZAdrhR9aByiEOYwEMyjO4WORc/S1AxhmIpAGnJTtK0M2LSu5Tkaq7cfmBCfXB2h8
         uc7AnVo+0FCwlmTnvcBKh7RTjNXuTWl2jUZUCJnrdLNGJtYAMCSmZ1bpc0n47yEs6dyE
         dl6NW13XJYW4lloGmwSsakNqroAUvdYTx3eWhRHBELKc9jJbpG7lOChYUuVq20c3kA6o
         onhtiebRipiPAIILyFY3f5Xmb4pKeyhQQWcwNYJ80DQ37l7a/vrS7BC4Dzq3BwCxmLJv
         C+FzyBKNvWcIGP95yeGSIsTyS2tHxtx+eKcX5dKZ45H0exNUvgi4XhRhbGJQFNEZtetx
         YE/w==
X-Gm-Message-State: AOAM531k/Two+0aIQIs7V+KTyqenx7J3Gx/Tss0N1HX9blF7kgjU5Yup
        AkWs5vicz9gkuNKdFJKcKXTpk0lK01N+tFARLz7UFA==
X-Google-Smtp-Source: ABdhPJwRotiWdsB5MPExO5ywj09DXgPnOFgUNWBadM1i4htNzIf1c7Jaguy98X2GECF9g1KeeDI7pvGLSys89LuURzc=
X-Received: by 2002:a05:6512:3905:: with SMTP id a5mr8272352lfu.354.1630099237836;
 Fri, 27 Aug 2021 14:20:37 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com> <d31c641180645ee4059aab9230841ad90f9244fe.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <d31c641180645ee4059aab9230841ad90f9244fe.1629842085.git.gitgitgadget@gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 27 Aug 2021 18:20:27 -0300
Message-ID: <CAHd-oW5-f2Kb5DR-UTfu1qB1fm63oHf62WYsbGd5ajZueOWHtA@mail.gmail.com>
Subject: Re: [PATCH 11/13] mv: refuse to move sparse paths
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
> diff --git a/builtin/mv.c b/builtin/mv.c
> index c2f96c8e895..b58fd4ce5ba 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -176,10 +177,22 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                 const char *src = source[i], *dst = destination[i];
>                 int length, src_is_dir;
>                 const char *bad = NULL;
> +               int skip_sparse = 0;
>
>                 if (show_only)
>                         printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
>
> +               if (!path_in_sparse_checkout(src, &the_index)) {

`git mv` can only move/rename tracked paths, but since we check
whether `src` is sparse before checking if it is in the index, the
user will get the sparse error message instead. This is OK, but the
advice might be misleading, as it says they can use `--sparse` if they
really want to move the file, but repeating the command with
`--sparse` will now fail for another reason. I wonder if we should
check whether `src` is tracked before checking if it is sparse, or if
that is not really an issue we should bother with.

> +                       string_list_append(&only_match_skip_worktree, src);
> +                       skip_sparse = 1;
> +               }
> +               if (!path_in_sparse_checkout(dst, &the_index)) {
> +                       string_list_append(&only_match_skip_worktree, dst);
> +                       skip_sparse = 1;
> +               }
> +               if (skip_sparse)
> +                       continue;
> +
>                 length = strlen(src);
>                 if (lstat(src, &st) < 0)
>                         bad = _("bad source");
>
> diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
> new file mode 100755
> index 00000000000..5397c6d07bd
> --- /dev/null
> +++ b/t/t7002-mv-sparse-checkout.sh
> @@ -0,0 +1,99 @@
> +#!/bin/sh
> +
> +test_description='git mv in sparse working trees'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' "
> +       mkdir -p sub/dir sub/dir2 &&
> +       touch a b c sub/d sub/dir/e sub/dir2/e &&
> +       git add -A &&
> +       git commit -m files &&
> +
> +       cat >sparse_error_header <<-EOF &&
> +       The following pathspecs didn't match any eligible path, but they do match index
> +       entries outside the current sparse checkout:
> +       EOF
> +
> +       cat >sparse_hint <<-EOF
> +       hint: Disable or modify the sparsity rules if you intend to update such entries.
> +       hint: Disable this message with \"git config advice.updateSparsePath false\"
> +       EOF
> +"
> +
> +test_expect_success 'mv refuses to move sparse-to-sparse' '
> +       rm -f e &&

At first glance, it confused me a bit that we are removing `e` when
the setup didn't create it. But then I realized the test itself might
create `e` if `git mv` succeeds in moving the `b` file. Could perhaps
this and the others `rm -f e` be a `test_when_finished`, to make it
clearer that it is a cleanup?

> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       touch b &&
> +       test_must_fail git mv b e 2>stderr &&

Here we try to move a "tracked sparse path" to an "untracked sparse
path". Do we also want to test with a tracked to tracked operation?
(Although the code path will be the same, of course.)

> +       cat sparse_error_header >expect &&
> +       echo b >>expect &&
> +       echo e >>expect &&
> +       cat sparse_hint >>expect &&
> +       test_cmp expect stderr
> +'
> +
> +test_expect_success 'mv refuses to move sparse-to-sparse, ignores failure' '
> +       rm -f e &&
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       touch b &&
> +       git mv -k b e 2>stderr &&

Maybe also check that `b` is still there, and `e` is missing?

> +       cat sparse_error_header >expect &&
> +       echo b >>expect &&
> +       echo e >>expect &&
> +       cat sparse_hint >>expect &&
> +       test_cmp expect stderr
> +'
> +
> +test_expect_success 'mv refuses to move non-sparse-to-sparse' '
> +       rm -f e &&
> +       git reset --hard &&
> +       git sparse-checkout set a &&
> +       test_must_fail git mv a e 2>stderr &&
> +       cat sparse_error_header >expect &&
> +       echo e >>expect &&
> +       cat sparse_hint >>expect &&
> +       test_cmp expect stderr
> +'

OK.

> +test_expect_success 'mv refuses to move sparse-to-non-sparse' '
> +       rm -f e &&
> +       git reset --hard &&
> +       git sparse-checkout set a e &&
> +       touch b &&
> +       test_must_fail git mv b e 2>stderr &&
> +       cat sparse_error_header >expect &&
> +       echo b >>expect &&
> +       cat sparse_hint >>expect &&
> +       test_cmp expect stderr
> +'

OK.

> +test_expect_success 'recursive mv refuses to move (possible) sparse' '
> +       rm -f e &&
> +       git reset --hard &&
> +       # Without cone mode, "sub" and "sub2" do not match
> +       git sparse-checkout set sub/dir sub2/dir &&
> +       test_must_fail git mv sub sub2 2>stderr &&
> +       cat sparse_error_header >expect &&
> +       echo sub >>expect &&
> +       echo sub2 >>expect &&
> +       cat sparse_hint >>expect &&
> +       test_cmp expect stderr
> +'
> +
> +test_expect_success 'recursive mv refuses to move sparse' '
> +       git reset --hard &&
> +       # Use cone mode so "sub/" matches the sparse-checkout patterns
> +       git sparse-checkout init --cone &&
> +       git sparse-checkout set sub/dir sub2/dir &&
> +       test_must_fail git mv sub sub2 2>stderr &&
> +       cat sparse_error_header >expect &&
> +       echo sub/dir2/e >>expect &&
> +       echo sub2/dir2/e >>expect &&
> +       cat sparse_hint >>expect &&
> +       test_cmp expect stderr
> +'
> +

Ah, these last two are very interesting cases!
