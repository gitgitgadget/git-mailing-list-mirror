Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D959C1F461
	for <e@80x24.org>; Mon, 13 May 2019 12:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfEMMm6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 08:42:58 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45614 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfEMMm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 08:42:57 -0400
Received: by mail-oi1-f196.google.com with SMTP id w144so3652951oie.12
        for <git@vger.kernel.org>; Mon, 13 May 2019 05:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tgVf3EYfeS6rfcChj0MswrxSCZgMGX7TO7GVp6KPcVg=;
        b=WqWTZzidAcdk8ZoeKO7F5kyGDPiHg4DTyoGIcVHUzjfFnCFeo63daGCB5YXK9WK2T/
         3RO5vNTfKara6Bf1mUlk9Xg1sjxFeIhKOoGUR60cUOoCUZ/PghQgVCZsbJRG6N7l1w/v
         odD7kWs1I0ImVhLYyON6h59vwAZRQcljQDYigDyY+6Mt/IVI0bhL4LU++rQuTIFFeSYJ
         YyehS3mPdOI9vTM2ugceAGezhJLda3qqBAxVmPris3Gg/9MJhOta3q+NkvaytmcqXc2+
         kctuqlJr4YpmF2j7YmLq1vBXRKKKNrl4FCqW6OGC7rXNh9U5sbII7r+m+JaaNapQjZIv
         vT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tgVf3EYfeS6rfcChj0MswrxSCZgMGX7TO7GVp6KPcVg=;
        b=tdZ1Rc5HihWSAdHdEfBDDkTvkdo590oQSRk6FAx1u7v1E8SUXhntH31aS9hOYzBOCk
         jotDF/YlDDwkpKVVZOp8SkK4Rd6amhiAb6dIV7dV6I+OdJ9XOrr/DjClLj9+8l/ik5YZ
         3gy/wLdA+pduTo6Oz8rI58CE90NjO2BjRCHNwNwwT6CtDb8Yq7uH+1qFLSren0cv7/BM
         fZ+748KEykWmKVMd5qEutJQCiYiMWDZJMWyCs0rkfbgCEo4TMzhwCJ8cpiOWTjKO1uw3
         kvjEKSzF66KaMKWHRQ/wspcDDiexnyTpmxAmbuMs+iciBSvgousC6rRdwHSWt5Gj/i+7
         KeSQ==
X-Gm-Message-State: APjAAAUe/VQhvM8x+2iFMPUDHv8rfomokGwT1zr8szIRaHO/IVC8WSjc
        xXoOOyzzqRxdj9PBY2/Fz9ZViXOb96DqCRKP/zI=
X-Google-Smtp-Source: APXvYqwXdZ9eorUKZhfSj+0jPQLLAaG8ae997LNykGJRd2vbf9ni4+FJWpms3OziYStZwq3xVQQm0ccEyiou04X9qFo=
X-Received: by 2002:aca:bd02:: with SMTP id n2mr13364921oif.70.1557751376890;
 Mon, 13 May 2019 05:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHAc2je-Yz4oej-sqvp+G+2Wv+eBABeJWUMm4scRwF2z_diUXw@mail.gmail.com>
 <20190513104944.20367-1-pclouds@gmail.com>
In-Reply-To: <20190513104944.20367-1-pclouds@gmail.com>
From:   Shaheed Haque <shaheedhaque@gmail.com>
Date:   Mon, 13 May 2019 13:42:46 +0100
Message-ID: <CAHAc2jeFva3MLpuXEiBbwa7U5HuZiaqawkc3udsyPCaFR4FAnA@mail.gmail.com>
Subject: Re: [PATCH] worktree add: be tolerant of corrupt worktrees
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Nguy=E1=BB=85n,

Thanks for the quick response. While I leave the code to the experts,
I can confirm that restoring the missing directory (but no content in
it) does allow "worktree add" to function again.

One point may be worth clarifying...

On Mon, 13 May 2019 at 11:50, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:
>
> find_worktree() can die() unexpectedly because it uses real_path()
> instead of the gentler version. When it's used in 'git worktree add' [1]
> and there's a bad worktree, this die() could prevent people from adding
> new worktrees.
>
> The "bad" condition to trigger this is when a parent of the worktree's
> location is deleted. Then real_path() will complain.
>
> Use the other version so that bad worktrees won't affect 'worktree
> add'. The bad ones will eventually be pruned, we just have to tolerate
> them for a bit.

...as I mentioned, from my experiments, trying a "worktree prune" did
NOT resolve the issue for me. But since I don't know the logic that
prune uses, there may have been some other reason for this.

Thanks again, Shaheed

> [1] added in cb56f55c16 (worktree: disallow adding same path multiple
>     times, 2018-08-28), or since v2.20.0. Though the real bug in
>     find_worktree() is much older.
>
> Reported-by: Shaheed Haque <shaheedhaque@gmail.com>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  t/t2025-worktree-add.sh | 12 ++++++++++++
>  worktree.c              |  7 +++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index 286bba35d8..d83a9f0fdc 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -570,4 +570,16 @@ test_expect_success '"add" an existing locked but mi=
ssing worktree' '
>         git worktree add --force --force --detach gnoo
>  '
>
> +test_expect_success '"add" should not fail because of another bad worktr=
ee' '
> +       git init add-fail &&
> +       (
> +               cd add-fail &&
> +               test_commit first &&
> +               mkdir sub &&
> +               git worktree add sub/to-be-deleted &&
> +               rm -rf sub &&
> +               git worktree add second
> +       )
> +'
> +
>  test_done
> diff --git a/worktree.c b/worktree.c
> index d6a0ee7f73..c79b3e42bb 100644
> --- a/worktree.c
> +++ b/worktree.c
> @@ -222,9 +222,12 @@ struct worktree *find_worktree(struct worktree **lis=
t,
>                 free(to_free);
>                 return NULL;
>         }
> -       for (; *list; list++)
> -               if (!fspathcmp(path, real_path((*list)->path)))
> +       for (; *list; list++) {
> +               const char *wt_path =3D real_path_if_valid((*list)->path)=
;
> +
> +               if (wt_path && !fspathcmp(path, wt_path))
>                         break;
> +       }
>         free(path);
>         free(to_free);
>         return *list;
> --
> 2.21.0.1141.gd54ac2cb17
>
