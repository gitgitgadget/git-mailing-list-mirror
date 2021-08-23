Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42175C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BA6661184
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 17:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhHWRaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 13:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhHWRaH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 13:30:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC858C061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:29:24 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id ia27so16379109ejc.10
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 10:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3slzitd3AhAQRua2F4S3qnHxzWAZg0zxfXRIQvdZaCI=;
        b=lUUlagh35MJK4++haTVmzYN5Cuc533BR07Av+Nfd2zlc+dxfb+yDs/UcXboX1RYQ8G
         6WKL0XT2EXoRMUiJOH9PhkCgPlISFEIr7tTWreIF56wLOcLhIRvjPh0dlHtOBNRx+CTn
         f9UkNSE1sQItTFIyIFzLDB3u6gTIW+/exDFVDBXodl4pOTv8nARs1rT93oC8PftnPGnC
         FQvGP8UONi+rV/tcuc18KqohijJWVdCsw/TAfy2c7leeZHrVyTLQXoCOLrtFlnScjlck
         TeqFr7w1FJPZwh/w9r+NNIFnA1yOBr2z7iZZPm3G7t4afB+rMUVu7nYatPCro/l167Qy
         f2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3slzitd3AhAQRua2F4S3qnHxzWAZg0zxfXRIQvdZaCI=;
        b=Kx0RmWpN89ZzHxPYO3ZdY60v2SJsyjNWHzGKp57wOZ0Fkk3xR1Li4n1ClAt77z4RwE
         BxBeqsO+TG8Xl244KYqunAbAUIZxPEyOPX8H94uAKXVpV0kcrtdlU9no/qS+rLLsFvgG
         Y03EmHDLVItWYL1tcY4Ekmh8eG4S7JNeCzLoEoxzCCsEV+oz9OOq4db90yR/8GisdzK3
         7ml53/tKjq17xcusY87zM/CwInnNdSWQnxkjacRvVSFZk1JifNeAGjMap1E9hiKKTGGs
         eUsQShLvZ9+UsA/WRBxqbYIo/Oj8RBY+BmreAD4RNwR5WIjYfX+p64BtOpCgKHz8P35n
         CyoA==
X-Gm-Message-State: AOAM5313Ku9zTRbtIBSWmvhGeOl1d/jkl7juAM01i7ISK1rP+oVhpeJO
        1RYJAXpJxlISnLg5VlXPfEJG5hIrVuM3tXzGhb8=
X-Google-Smtp-Source: ABdhPJyAjNJ3LIzmpiy43uQn2v6mnw8ZKS6rX1+9ZNcHwElbRx5w8mXV1ICNOY+TQ93zTOgj129mxHN8wd8kuGte7M8=
X-Received: by 2002:a17:907:2452:: with SMTP id yw18mr37454914ejb.191.1629739763179;
 Mon, 23 Aug 2021 10:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <patch-1.1-54eb94f6e7a-20210823T130724Z-avarab@gmail.com>
In-Reply-To: <patch-1.1-54eb94f6e7a-20210823T130724Z-avarab@gmail.com>
From:   Pratik Karki <predatoramigo@gmail.com>
Date:   Mon, 23 Aug 2021 23:14:10 +0545
Message-ID: <CAOZc8M8QFbiLaQDOc9moQeTjuRmKA8e0JscXy3Z9EQXhAuLrMQ@mail.gmail.com>
Subject: Re: [PATCH] rebase: emit one "fatal" in "fatal: fatal: <error>"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 23, 2021 at 6:52 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> The die() routine adds a "fatal: " prefix, there is no reason to add
> another one. Fixes code added in e65123a71d0 (builtin rebase: support
> `git rebase <upstream> <switch-to>`, 2018-09-04).
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/rebase.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 33e09619005..66a0a0f0d03 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1918,7 +1918,7 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>                                                    &options.orig_head))
>                         options.head_name =3D NULL;
>                 else
> -                       die(_("fatal: no such branch/commit '%s'"),
> +                       die(_("no such branch/commit '%s'"),
>                             branch_name);
>         } else if (argc =3D=3D 0) {
>                 /* Do not need to switch branches, we are already on it. =
*/


Makes sense. Thank you for fixing this.

Best,
Pratik Karki
