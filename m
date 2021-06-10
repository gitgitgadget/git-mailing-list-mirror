Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6BDC47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6384613BC
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 15:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhFJPW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 11:22:29 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:37475 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbhFJPWY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 11:22:24 -0400
Received: by mail-oi1-f170.google.com with SMTP id h9so2493057oih.4
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MJkIJZES8lpOfzVi369BhNLHM4eERGBd/GWSEXCmZfw=;
        b=HPVaEWJ+hCIy9obZpJZ8aIClrtIbUFtSn8SU2OksAWuV7gG6LiGQqzJdkMV5/m+Q1U
         AdC472AmslRQx7AZLknqP5MxEmKaznRMGcMgqRvO9ST+DHqWyFK/9JTRh5kr/9BkToKb
         1dAYfqGIkjGlVyX6yRwyAS3prIH0RyKKHHbbSxvuHvxJugpUgwR/7GMiJJyST+SDV77v
         p5cZWI+d0I5Tl6njkz+G30nyOT9o4ZgTlmhSOy7y941/G5YiL5MaddjT1RPPY7T3MfnB
         8zzKd5sBwF6PVKDSANoIghC/bLW6Bl5aGsMFsNYZNGEEqpabp468258Y5SIQuZ40wfgq
         0QjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MJkIJZES8lpOfzVi369BhNLHM4eERGBd/GWSEXCmZfw=;
        b=Wutspi+cLocPKALIY5P/u7Iep3DQMvWuqfXkGw/VG7G/6p2rz9w6neqwXW2ojhLtw7
         PpPXYc20u+wz3Imrm/9blnmf2lyCu3jVXF7UeHE5jTzvmydFXG+dyEDpBOZIGHEoitRJ
         qRrhoG7yt1Y11TvGAGO1NK7yXz8D6TFXupH9dAW3qamKJpu23nqeIou0dxgbQkFpdOtn
         n+USHc3M3WSN575rRI41Keh6b/rVNTWiAoxjBX+MMGebnipFjXcG4e/FDJHAc1YNEGsr
         LrhzyYs3O/TMgb/44ujRBHKI2R5W/mrbhiiP3L9yAfkfAseE0NkjFEDC/BS/0YKBXF7D
         19Bg==
X-Gm-Message-State: AOAM530vWjqq9w4Yi7tMNTj/eEqtNcxTBDZqQDlWWscdhMZp5DJqAL7+
        eDmhVk7kFWS4oAZUfeExIsmqBgIubKixOyQGYjU=
X-Google-Smtp-Source: ABdhPJwEFt597jgegSi7Bx40csQxBwFtovgt7QobB5vTiNRBGy/WH4ep+bexyH42/7eBfxK2XfqXNTAQ7CmHiHGJYVU=
X-Received: by 2002:aca:f482:: with SMTP id s124mr10357281oih.167.1623338353701;
 Thu, 10 Jun 2021 08:19:13 -0700 (PDT)
MIME-Version: 1.0
References: <YMIKwsEFnkqz6PWa@coredump.intra.peff.net> <YMIMg+uXDjzS70g5@coredump.intra.peff.net>
In-Reply-To: <YMIMg+uXDjzS70g5@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 10 Jun 2021 08:19:02 -0700
Message-ID: <CABPp-BFu0dJa=KxVtzzDG0RrcPo6bGCVx8P8VhB9sV8OjaYQNQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ll_union_merge(): pass name labels to ll_xdl_merge()
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 6:00 AM Jeff King <peff@peff.net> wrote:
>
> Since cd1d61c44f (make union merge an xdl merge favor, 2010-03-01), we
> pass NULL to ll_xdl_merge() for the "name" labels of the ancestor, ours
> and theirs buffers. We usually use these for annotating conflict markers
> left in a file. For a union merge, these shouldn't matter; the point of
> it is that we'd never leave conflict markers in the first place.
>
> But there is one code path where we may dereference them: if the file
> contents appear to be binary, ll_binary_merge() will give up and pass
> them to warning() to generate a message for the user (that was true even
> when cd1d61c44f was written, though the warning was in ll_xdl_merge()
> back then).
>
> That can result in a segfault, though on many systems (including glibc),
> the printf routines will helpfully just say "(null)" instead. We can
> extend our binary-union test in t6406 to check stderr, which catches the
> problem on all systems.

Nice catch (as is your 1/2 as well).

> This also fixes a warning from "gcc -O3". Unlike lower optimization
> levels, it inlines enough to see that the NULL can make it to warning()
> and complains:
>
>   In function =E2=80=98ll_binary_merge=E2=80=99,
>       inlined from =E2=80=98ll_xdl_merge=E2=80=99 at ll-merge.c:115:10,
>       inlined from =E2=80=98ll_union_merge=E2=80=99 at ll-merge.c:151:9:
>   ll-merge.c:74:4: warning: =E2=80=98%s=E2=80=99 directive argument is nu=
ll [-Wformat-overflow=3D]
>      74 |    warning("Cannot merge binary files: %s (%s vs. %s)",
>         |    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>      75 |     path, name1, name2);
>         |     ~~~~~~~~~~~~~~~~~~~

So the warning uses path as well as name1 and name2...

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ll-merge.c            | 2 +-
>  t/t6406-merge-attr.sh | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/ll-merge.c b/ll-merge.c
> index 145deb12fa..0ee34d8a01 100644
> --- a/ll-merge.c
> +++ b/ll-merge.c
> @@ -151,7 +151,7 @@ static int ll_union_merge(const struct ll_merge_drive=
r *drv_unused,
>         o =3D *opts;
>         o.variant =3D XDL_MERGE_FAVOR_UNION;
>         return ll_xdl_merge(drv_unused, result, path_unused,

Should we also rename 'path_unused' to 'path', since it is actually used?

> -                           orig, NULL, src1, NULL, src2, NULL,
> +                           orig, orig_name, src1, name1, src2, name2,
>                             &o, marker_size);
>  }
>
> diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
> index c1c458d933..8494645837 100755
> --- a/t/t6406-merge-attr.sh
> +++ b/t/t6406-merge-attr.sh
> @@ -221,7 +221,8 @@ test_expect_success 'binary files with union attribut=
e' '
>         printf "two\0" >bin.txt &&
>         git commit -am two &&
>
> -       test_must_fail git merge bin-main
> +       test_must_fail git merge bin-main 2>stderr &&
> +       grep -i "warning.*cannot merge.*HEAD vs. bin-main" stderr
>  '
>
>  test_done
> --
> 2.32.0.529.g079a794268

This patch has a minor textual conflict with my remerge-diff series,
but since I haven't submitted it yet, that's my problem rather than
yours...and it will be an easy fix anyway.

Anyway, good catches.  Other than maybe considering fixing the name of
'path_unused', this looks good to me.
