Return-Path: <SRS0=BZy3=CN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D16C433E2
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 19:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B632083B
	for <git@archiver.kernel.org>; Fri,  4 Sep 2020 19:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfYuieE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgIDT2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIDT23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Sep 2020 15:28:29 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BF6C061244
        for <git@vger.kernel.org>; Fri,  4 Sep 2020 12:28:29 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id v16so6863515otp.10
        for <git@vger.kernel.org>; Fri, 04 Sep 2020 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6lE7xsLnocYdinJI2JGZKKMYh2Mj7S3uCNdVXtCUyoQ=;
        b=PfYuieE+BXIjXHIBuiU1fZrOlqhfp/A5MfISEzmbhznPougEzr2DxlslTpCvU/TLw4
         WSWkGw7uNgfudEL9xXb9ZEmS5sCzrh6/Q5eOuROJbUyF7urGnj5kc18alKPBKqJiYcIr
         zne3jSukQfQFhiBT+ZzyRmi2cdltgO3Lr8P8DNVAhRoBJyEdUPc0FLxAzk9g8CY3jWU6
         VOPfDH9530i/YDk/rOF0RJMXPe0rj9jLO8YEfeFxXij6IN53AyudP1xDQdnRX7E7qgEp
         lbz1QNzCIId0gmAlD8tCtxOhwSL7Rg8c9YY35mFUqBZ+tq+jB/51pjgW2OlwrU06OlVq
         VXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6lE7xsLnocYdinJI2JGZKKMYh2Mj7S3uCNdVXtCUyoQ=;
        b=Fud7MkcjRqCgEMIZyjeTW49t2wawLsCW7S4zp31MK2lzszGFEHkL+4kl3XkgbbeAOI
         W9bKu+/pp41WG8W4HvxNTaLxD1WFKgvihVJ8BiqanvPCKlwR6MX7wKv1xfBEzRvCqlTG
         ox2bSmeFIyYrnkrsZd1+pgPu1x9IvD6ug6qDUfVhF6d0oRVXZC9y2u8qGiIrOoPwiPLq
         6eP8M+5AEO0lXtquGdqfcU5lVLZlpbUrpNeoaAzUCZshMvJegRTvgY1T1Npq7AJhoE8m
         jBS4MDDZup2DJAOEP13D4CjFdDIeSjqzf41vMD3o41gAyx9yJ8b+Wei2/WYgR/VlG2Ij
         7mXQ==
X-Gm-Message-State: AOAM532lftWGnvG/YZY55yEYihvhCHlUEixYAOqDGVoX5pLib4w2o/c0
        pG7lkSZWZRQk3BL4mi3vYFoS8UzCDWOkxQzNTaE=
X-Google-Smtp-Source: ABdhPJwfh2RKNe3I/VvEuc1KA+LTbXJNGiGQ2qq0MlQt6qlBbDMRqyOdG5bgaN6TeiYZ9k40ph7/Vy/dhH2MeoQr5jE=
X-Received: by 2002:a05:6830:1be7:: with SMTP id k7mr6631226otb.162.1599247708531;
 Fri, 04 Sep 2020 12:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <CABLWAfQhWUSUS8p2XoGcNMUAp-vatD+-pDMngiJJW5qHG2CYCQ@mail.gmail.com>
 <dbccbf13-9ebb-2464-4325-cac4c7767f74@web.de>
In-Reply-To: <dbccbf13-9ebb-2464-4325-cac4c7767f74@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Sep 2020 12:28:17 -0700
Message-ID: <CABPp-BGQA98SOr4-+8LKd-V=oqB98hoDGh+AsvOGHjsM2ko=iA@mail.gmail.com>
Subject: Re: [PATCH] read-cache: fix mem-pool allocation for multi-threaded
 index loading
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Sandor Bodo-Merle <sbodomerle@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 4, 2020 at 10:34 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> 44c7e1a7e0 (mem-pool: use more standard initialization and finalization,
> 2020-08-15) moved the allocation of the mem-pool structure to callers.
> It also added an allocation to load_cache_entries_threaded(), but for an
> unrelated mem-pool.  Fix that by allocating the correct one instead --
> the one that is initialized two lines later.

Whoops; that's a somewhat embarrassing mistake.  Thanks for fixing it up fo=
r me.

Reviewed-by: Elijah Newren <newren@gmail.com>

>
> Reported-by: Sandor Bodo-Merle <sbodomerle@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> "GIT_TEST_INDEX_THREADS=3D3 make test" passes with this patch, but fails =
a
> lot without it.
>
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index fa291cdbee..ecf6f68994 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2101,7 +2101,7 @@ static unsigned long load_cache_entries_threaded(st=
ruct index_state *istate, con
>                 nr =3D 0;
>                 for (j =3D p->ieot_start; j < p->ieot_start + p->ieot_blo=
cks; j++)
>                         nr +=3D p->ieot->entries[j].nr;
> -               istate->ce_mem_pool =3D xmalloc(sizeof(*istate->ce_mem_po=
ol));
> +               p->ce_mem_pool =3D xmalloc(sizeof(*istate->ce_mem_pool));
>                 if (istate->version =3D=3D 4) {
>                         mem_pool_init(p->ce_mem_pool,
>                                 estimate_cache_size_from_compressed(nr));
> --
> 2.28.0
