Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7F6C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 01:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiHSBCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 21:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiHSBCl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 21:02:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84D6C9279
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:02:39 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i7so2377726qka.13
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 18:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rtdXJjkLG08gUvrigzDlyDSh7pmyyJtbPjbE6pcs2Ak=;
        b=UbksPsE3jxgA8zsctlcBAtCRc2GjI75BTkVvw9M1SJtA4Xw1V/q35OyR7CjPvYq45Y
         k+8nDDcqNPwIUr8wGYFYBCT94cS4YSk/wZdFirYGjf0yNXxdXyd1K/t0IZUUI+B9Kzq0
         ATyFTbwgsC+C6lIyqtynZgE4AeVj7N8pejKXvEF80/NlStsurdru3xMVhNGY/+3Bc3GD
         z+synceVdbLAyr9sSJFMwtpIT9mwTT+P8JKaMQfhjI1dGGhpIWx9Vex1CQlxlkXdXmfm
         gFMs8BTGfQLaZt8Nt/bpd6GB2up+Gk51ELm1GHFIe5sZNq/GVj2Kg8zBxbk365QmgDQ0
         B38g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rtdXJjkLG08gUvrigzDlyDSh7pmyyJtbPjbE6pcs2Ak=;
        b=Q3IwO3KpmNK0bmAvfuOyA7oqZEfJX3FdPMyFeoBOkYkvg/n4vOIQYnejo8CjbqSn29
         jPnJ/77Ahr8LjLXvPP7ibGbTBj3/1Vcmvc9WcbpwGXd6Vgv4EtAlXGwdiIWKmtQ+je94
         aLPyg3WJut04WBzymXHYsCwyxGM9NsKqMACPgRO00rZ8fVs9BoHc7niz4ftpSCpK4Cno
         tREIyxhjxJX9QDB3dVNS58zkv1SO3rRlQrrB9VWAfmE4dQiuWJpnYFugktWsGOaohrEG
         d8EVoGF+uwZH4xWShJ0mloIF/V64Mmu4QCmI/AyOPhcbbCI1eNbyefIYo35ot0zlH2Vv
         FmMA==
X-Gm-Message-State: ACgBeo3xJVpkS7ThHTRWPWR4gT0Rji+9444BJQ90gxnUejHYZllOxU9h
        PXq7Wp0gZriQwpFoYjFOSZx2yBFwA8i/s3LYpZs3EwoCLRk=
X-Google-Smtp-Source: AA6agR69h/drFXymFQHlO4LVOkRgMOO202v/DpIyhFpj7c/GvWREPuAgzXDE9whgrjbuq6veCg6VaZTHTRe7ATH+Ayk=
X-Received: by 2002:a05:620a:1902:b0:6b8:d90e:cef7 with SMTP id
 bj2-20020a05620a190200b006b8d90ecef7mr4034531qkb.131.1660870958953; Thu, 18
 Aug 2022 18:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
 <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com> <f580ec6d06072ea6ed2ecc4f8142b94fccbe4c0f.1660803467.git.gitgitgadget@gmail.com>
 <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
In-Reply-To: <ee4a7a7f-d646-6357-233a-1fefde5607bf@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 18 Aug 2022 18:01:00 -0700
Message-ID: <CABPp-BGNG+E8ALs2rvRtzrw+m-kYYa+8yUuqphf=VJtstWr+zA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] revision: allow --ancestry-path to take an argument
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2022 at 8:30 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
> On 8/18/2022 2:17 AM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
>
> Code looks good!
>
> > diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
> > index af57a04b7ff..d3657737fa6 100755
> > --- a/t/t6019-rev-list-ancestry-path.sh
> > +++ b/t/t6019-rev-list-ancestry-path.sh
> > @@ -8,8 +8,13 @@ test_description='--ancestry-path'
> >  #   /                     \
> >  #  A-------K---------------L--M
> >  #
> > -#  D..M                 == E F G H I J K L M
> > -#  --ancestry-path D..M == E F H I J L M
> > +#  D..M                                     == E F G H I J K L M
> > +#  --ancestry-path                     D..M == E F   H I J   L M
> > +#  --ancestry-path=F                   D..M == E F       J   L M
> > +#  --ancestry-path=G                   D..M ==     G H I J   L M
> > +#  --ancestry-path=H                   D..M == E   G H I J   L M
> > +#  --ancestry-path=K                   D..M ==             K L M
> > +#  --ancestry-path=K --ancestry-path=F D..M == E F       J K L M
>
> These are good examples, because they help clarify what I had initially
> been confused about: you include things in _both_ directions. In
> particular, "--ancestry-path=K --ancestry-path=f D..M" you are kind of
> taking the union of the following queries:
>
>         --ancestry-path D..K
>         --ancestry-path K..M
>         --ancestry-path D..F
>         --ancestry-path F..M
>
> I did check just in case, but specifying multiple ranges such as
>
>         --ancestry-path D..K K..M
>
> does not do what is expected.

Right, because there's no such thing as multiple ranges.  Quoting from the docs:

"""
Commands that are specifically designed to take two distinct ranges
(e.g. "git range-diff R1 R2" to compare two ranges) do exist, but
they are exceptions.  Unless otherwise noted, all "git" commands
that operate on a set of commits work on a single revision range.
In other words, writing two "two-dot range notation" next to each
other, e.g.

    $ git log A..B C..D

does *not* specify two revision ranges for most commands.  Instead
it will name a single connected set of commits, i.e. those that are
reachable from either B or D but are reachable from neither A or C.
"""

>
> > +test_expect_success 'rev-list --ancestry-path=F D..M' '
> > +     test_write_lines E F J L M >expect &&
> > +     git rev-list --ancestry-path=F --format=%s D..M |
> > +     sed -e "/^commit /d" |
> > +     sort >actual &&
> > +     test_cmp expect actual
> > +'
>
> These tests follow the patterns from other tests in this file, but
> it also has bad patterns. Specifically, the 'git rev-list' command
> is fed directly into a pipe. I include a patch below that applies
> directly on this one to rewrite these tests. If you want, you could
> rebase to have that test refactor happen before you add your new
> --ancestry-path=<X> option tests.

Ooh, I like it.  I'll rebase and include this patch earlier in my
series.  Thanks!

>
> > +test_expect_success 'rev-list --ancestry-path=G D..M' '
> > +     test_write_lines G H I J L M >expect &&
> > +     git rev-list --ancestry-path=G --format=%s D..M |
> > +     sed -e "/^commit /d" |
> > +     sort >actual &&
> > +     test_cmp expect actual
> > +'
> > +test_expect_success 'rev-list --ancestry-path=H D..M' '
>
> nit: needs extra whitespace between tests. The above test pair
> needs one, too. This becomes moot with the patch I provide.
>
> Thanks,
> -Stolee
>
> --- >8 ---
>
> From 9ac4e81dba0d7801513a09f5fe307d01357123dd Mon Sep 17 00:00:00 2001
> From: Derrick Stolee <derrickstolee@github.com>
> Date: Thu, 18 Aug 2022 11:25:04 -0400
> Subject: [PATCH] t6019: modernize tests with helper
>
> The tests in t6019 are repetive, so create a helper that greatly
> simplifies the test script.
>
> In addition, update the common pattern that places 'git rev-list' on the
> left side of a pipe, which can hide some exit codes. Send the output to
> a 'raw' file that is then consumed by other tools so the Git exit code
> is verified as zero.
>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  t/t6019-rev-list-ancestry-path.sh | 131 +++++++-----------------------
>  1 file changed, 31 insertions(+), 100 deletions(-)
>
> diff --git a/t/t6019-rev-list-ancestry-path.sh b/t/t6019-rev-list-ancestry-path.sh
> index d3657737fa60..18941a80ce67 100755
> --- a/t/t6019-rev-list-ancestry-path.sh
> +++ b/t/t6019-rev-list-ancestry-path.sh
> @@ -55,111 +55,42 @@ test_expect_success setup '
>         test_commit M
>  '
>
> -test_expect_success 'rev-list D..M' '
> -       test_write_lines E F G H I J K L M >expect &&
> -       git rev-list --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'rev-list --ancestry-path D..M' '
> -       test_write_lines E F H I J L M >expect &&
> -       git rev-list --ancestry-path --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'rev-list --ancestry-path=F D..M' '
> -       test_write_lines E F J L M >expect &&
> -       git rev-list --ancestry-path=F --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -test_expect_success 'rev-list --ancestry-path=G D..M' '
> -       test_write_lines G H I J L M >expect &&
> -       git rev-list --ancestry-path=G --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -test_expect_success 'rev-list --ancestry-path=H D..M' '
> -       test_write_lines E G H I J L M >expect &&
> -       git rev-list --ancestry-path=H --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'rev-list --ancestry-path=K D..M' '
> -       test_write_lines K L M >expect &&
> -       git rev-list --ancestry-path=K --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'rev-list --ancestry-path=F --ancestry-path=K D..M' '
> -       test_write_lines E F J K L M >expect &&
> -       git rev-list --ancestry-path=F --ancestry-path=K --format=%s D..M |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'rev-list D..M -- M.t' '
> -       echo M >expect &&
> -       git rev-list --format=%s D..M -- M.t |
> -       sed -e "/^commit /d" >actual &&
> -       test_cmp expect actual
> -'
> -
> -test_expect_success 'rev-list --ancestry-path D..M -- M.t' '
> -       echo M >expect &&
> -       git rev-list --ancestry-path --format=%s D..M -- M.t |
> -       sed -e "/^commit /d" >actual &&
> -       test_cmp expect actual
> -'
> +test_ancestry () {
> +       args=$1
> +       expected=$2
> +       test_expect_success "rev-list $args" "
> +               test_write_lines $expected >expect &&
> +               git rev-list --format=%s $args >raw &&
> +
> +               if test -n \"$expected\"
> +               then
> +                       sed -e \"/^commit /d\" raw | sort >actual &&
> +                       test_cmp expect actual || return 1
> +               else
> +                       test_must_be_empty raw
> +               fi
> +       "
> +}
>
> -test_expect_success 'rev-list F...I' '
> -       test_write_lines F G H I >expect &&
> -       git rev-list --format=%s F...I |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> +test_ancestry "D..M" "E F G H I J K L M"
>
> -test_expect_success 'rev-list --ancestry-path F...I' '
> -       test_write_lines F H I >expect &&
> -       git rev-list --ancestry-path --format=%s F...I |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> +test_ancestry "--ancestry-path D..M" "E F H I J L M"
> +test_ancestry "--ancestry-path D..M" "E F H I J L M"
> +test_ancestry "--ancestry-path=F D..M" "E F J L M"
> +test_ancestry "--ancestry-path=G D..M" "G H I J L M"
> +test_ancestry "--ancestry-path=H D..M" "E G H I J L M"
> +test_ancestry "--ancestry-path=K D..M" "K L M"
> +test_ancestry "--ancestry-path=K --ancestry-path=F D..M" "E F J K L M"
>
> -# G.t is dropped in an "-s ours" merge
> -test_expect_success 'rev-list G..M -- G.t' '
> -       git rev-list --format=%s G..M -- G.t |
> -       sed -e "/^commit /d" >actual &&
> -       test_must_be_empty actual
> -'
> +test_ancestry "D..M -- M.t" "M"
> +test_ancestry "--ancestry-path D..M -- M.t" "M"
>
> -test_expect_success 'rev-list --ancestry-path G..M -- G.t' '
> -       echo L >expect &&
> -       git rev-list --ancestry-path --format=%s G..M -- G.t |
> -       sed -e "/^commit /d" >actual &&
> -       test_cmp expect actual
> -'
> +test_ancestry "F...I" "F G H I"
> +test_ancestry "--ancestry-path F...I" "F H I"
>
> -test_expect_success 'rev-list --ancestry-path --simplify-merges G^..M -- G.t' '
> -       test_write_lines G L >expect &&
> -       git rev-list --ancestry-path --simplify-merges --format=%s G^..M -- G.t |
> -       sed -e "/^commit /d" |
> -       sort >actual &&
> -       test_cmp expect actual
> -'
> +test_ancestry "G..M -- G.t" ""
> +test_ancestry "--ancestry-path G..M -- G.t" "L"
> +test_ancestry "--ancestry-path --simplify-merges G^..M -- G.t" "G L"
>
>  #   b---bc
>  #  / \ /
> --
> 2.37.1.vfs.0.0.rebase
>
>
>
>
