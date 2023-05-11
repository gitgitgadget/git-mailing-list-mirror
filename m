Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697EBC7EE22
	for <git@archiver.kernel.org>; Thu, 11 May 2023 06:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjEKGfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 02:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjEKGfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 02:35:09 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2211713
        for <git@vger.kernel.org>; Wed, 10 May 2023 23:35:07 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso9126978e87.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 23:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683786906; x=1686378906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpUPaVugkbefu+vHryvhkrVgmpOl9+4hqnS67g6RzAQ=;
        b=b48kY6ZxtH9Y268ld4H39YKriGjrbB/gDEnEm7YPxAekuGulQSwtMAisfdv83dw3LD
         F9+nHLBtHBFabByjhtP1j8n1ZTGrZjKUkICUgsUgePDO4bYwY5ufhFUPq/YvdGQm+f9K
         a302S6gR+BR6bgc1/Oh/kWXOh2GUtL7RHUbK0p5tXXd3BIGueG2ZnWBf+5qU3Q36mFzx
         6JEBJoyTotjMCL+mJW5c/fyn5qA4cO02eBKkzFhYnp5Ri46xWZR86iC9bBN5ouUBaOBd
         QPGego0H3nc5giYzZuSAZZ+YnHHW6hPU8aUn5FgNKUwrtMpJt8wE64RE7v7bpDpbFOpy
         Extg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683786906; x=1686378906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpUPaVugkbefu+vHryvhkrVgmpOl9+4hqnS67g6RzAQ=;
        b=g+xkcrOCe/cqTSNMOrUP6Cf2E+ky8d/cPujuQYCBlknayH1KAx9qk5tCgF+sRaMv+T
         0LFYW5wLsNzxge46iHlTqjx4l9g0N3ZFLWVGodLD4CwbZeEAFj9nydgeSshJILAI8yOp
         gKPJZjehSr4c81t+iIAwCuVg7+XKnyA/NoGpfvh0Z3o7Jnl+VeGqgYvwmM4AAP5FZctM
         /HnhmV9UiOmrjGQ5IDtxz3lMeuHwQV02+bqOES0Wh2rqIukrNzhs34DiKoRd24W3wHEf
         o8X2Ro7lc6MOoDzTMjv04NEJcgBhjkDwY6hmK2sKVMGLeqj68ZUiE9OmihGPPV8txyvC
         xCEQ==
X-Gm-Message-State: AC+VfDzCK2/ZYLk/YWNePWP4qjaSnNX4USiUReSIfcMbgeU8HdK8IELa
        tsX1PiieQXLB0lHsTOQImTMNp9GnoM4aRgH4HK1Rn7zOFr57/g==
X-Google-Smtp-Source: ACHHUZ65o1ikI7ZJp5JJ2l4CKlMLRQz32mpLQ91qsr8hh5hx+8wQsNLVuVPnbynZWWeyuP/wsce7ZBQkfoPCTXpU6Lg=
X-Received: by 2002:ac2:48a3:0:b0:4dc:4fe2:2aad with SMTP id
 u3-20020ac248a3000000b004dc4fe22aadmr2070923lfg.41.1683786905578; Wed, 10 May
 2023 23:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
In-Reply-To: <pull.1530.git.1683745654800.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 10 May 2023 23:34:52 -0700
Message-ID: <CABPp-BECZgACeEUqG3pajJpHAaY=-orNwwOUEX5qqzAKVRMFdQ@mail.gmail.com>
Subject: Re: [PATCH] merge-tree: load default git config
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        christian.couder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2023 at 12:33=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <derrickstolee@github.com>
>
> The 'git merge-tree' command handles creating root trees for merges
> without using the worktree. This is a critical operation in many Git
> hosts, as they typically store bare repositories.
>
> This builtin does not load the default Git config, which can have
> several important ramifications.
>
> In particular, one config that is loaded by default is
> core.useReplaceRefs. This is typically disabled in Git hosts due to
> the ability to spoof commits in strange ways.
>
> Since this config is not loaded specifically during merge-tree, users
> were previously able to use refs/replace/ references to make pull
> requests that looked valid but introduced malicious content. The
> resulting merge commit would have the correct commit history, but the
> malicious content would exist in the root tree of the merge.

Ouch!  So sorry for creating this problem.

> The fix is simple: load the default Git config in cmd_merge_tree().
> This may also fix other behaviors that are effected by reading default
> config. The only possible downside is a little extra computation time
> spent reading config. The config parsing is placed after basic argument
> parsing so it does not slow down usage errors.
>
> Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>     merge-tree: load default git config
>
>     This patch was reviewed on the Git security list, but the impact seem=
ed
>     limited to Git forges using merge-ort to create merge commits. The
>     forges represented on the list have deployed versions of this patch a=
nd
>     thus are no longer vulnerable.
>
>     Thanks, -Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1530%2F=
derrickstolee%2Fstolee%2Frefs-replace-upstream-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1530/derri=
ckstolee/stolee/refs-replace-upstream-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1530
>
>  builtin/merge-tree.c  |  3 +++
>  t/t4300-merge-tree.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+)
>
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index aa8040c2a6a..b8f8a8b5d9f 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -17,6 +17,7 @@
>  #include "merge-blobs.h"
>  #include "quote.h"
>  #include "tree.h"
> +#include "config.h"
>
>  static int line_termination =3D '\n';
>
> @@ -628,6 +629,8 @@ int cmd_merge_tree(int argc, const char **argv, const=
 char *prefix)
>         if (argc !=3D expected_remaining_argc)
>                 usage_with_options(merge_tree_usage, mt_options);
>
> +       git_config(git_default_config, NULL);
> +

Always nice when it's a simple fix.  :-)

I am curious though...

init_merge_options() in merge-recursive.c (which is also used by
merge-ort) calls merge_recursive_config().  merge_recursive_config()
does a bunch of config parsing, regardless of whatever config parsing
is done beforehand by the caller of init_merge_options().  This makes
me wonder if the config which handles replace refs should be included
in merge_recursive_config() as well.  Doing so would have the added
benefit of making sure all the builtins calling the merge logic behave
similarly.  And if we copy/move the replace-refs-handling config
logic, does that replace the fix in this patch, or just supplement it?

To be honest, I've mostly ignored the config side of things while
working on the merge machinery, so I didn't even know (or at least
remember) the above details until I went digging just now.  I don't
know if the way init_merge_options()/merge_recursive_config() is how
we should do things, or just vestiges of how it's evolved from 15
years ago.

>         /* Do the relevant type of merge */
>         if (o.mode =3D=3D MODE_REAL)
>                 return real_merge(&o, merge_base, argv[0], argv[1], prefi=
x);
> diff --git a/t/t4300-merge-tree.sh b/t/t4300-merge-tree.sh
> index c52c8a21fae..57c4f26e461 100755
> --- a/t/t4300-merge-tree.sh
> +++ b/t/t4300-merge-tree.sh
> @@ -334,4 +334,22 @@ test_expect_success 'turn tree to file' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'merge-tree respects core.useReplaceRefs=3Dfalse' '
> +       test_commit merge-to &&
> +       test_commit valid base &&
> +       git reset --hard HEAD^ &&
> +       test_commit malicious base &&
> +
> +       test_when_finished "git replace -d $(git rev-parse valid^0)" &&
> +       git replace valid^0 malicious^0 &&
> +
> +       tree=3D$(git -c core.useReplaceRefs=3Dtrue merge-tree --write-tre=
e merge-to valid) &&
> +       merged=3D$(git cat-file -p $tree:base) &&
> +       test malicious =3D $merged &&
> +
> +       tree=3D$(git -c core.useReplaceRefs=3Dfalse merge-tree --write-tr=
ee merge-to valid) &&
> +       merged=3D$(git cat-file -p $tree:base) &&
> +       test valid =3D $merged
> +'
> +
>  test_done

Thanks for adding the test case too, as always.

> base-commit: 5597cfdf47db94825213fefe78c4485e6a5702d8
> --
> gitgitgadget

Looks good.  I am curious for other's thoughts on whether it may make
sense to add parsing of core.useReplaceRefs within
merge_recursive_config().
