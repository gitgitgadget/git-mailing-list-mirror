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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A26BC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBB4764E90
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 07:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbhBYHmY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhBYHlX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 02:41:23 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015AAC061756
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:40:42 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id s10so1156852oom.6
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 23:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0S3N6QsGoW2mP5nJmoHjZRnh7ubnkkjcoN0ErVDj9c=;
        b=cgAqabGTMwkbQ8u5NHtxwTc1Go24icT9CfUsVTha5DdU35eCT46TyxoMVHiWK81+Am
         AywaFqQsb23WNSIVwrOymkJ7aytDOPJT0BWpV31TPYnf81adOEv8k8N48jzaHiUPvLs/
         8EWAh7LWEPEOsSUZpmqAFjx6fzyy2MX/1fXJDs6vanMhExDykTW1IvRRs5LSNnf9iDcz
         AeCYNQJFqJQQdyECM1qSusApGGNnC5rNxXf/etQHrsuLK98EadKhyLlqV006QmE+tL/l
         CNOOAHSI85POKMGntpvFH2fKNdfC+FvhWNUBoosRwyqMu5rnyizcb+5zjThMI//G70PZ
         8X+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0S3N6QsGoW2mP5nJmoHjZRnh7ubnkkjcoN0ErVDj9c=;
        b=JO4ajVUiWW/GUl8SolqCkgTLlqzekNm2tCZHzkyZoVkETDogKU1Z4NkQn8ioKpHh0b
         1Mdkn6hQDDSvUPNkiJPhF9yooy6JgGXo91URqrp6EZeaiXQTKyHctt3cTbG1MNrCRLD1
         l/r8rJWoxh75bqJGqOTCwkDi2C+iO4p75ypWLzBrxsRAht3sR9tDhdQZsatQUNfZlFhL
         3lt51ier8rpnoo6rqhtxOEUXPFLlWPI0a2i0ci5nU55NArjRQ9bIa/UcTdPtjIFpYs2h
         ToejigHYj2PYQyty12oT2eOqauLFDTo3AxJmNJKaKYa4Kv3pEtsCYJOYuV3eHi/UMz5y
         UUxw==
X-Gm-Message-State: AOAM532ged2Sc78blHIcbb7qp9Y7YD0MJysCNpSF2mMIYNZTfPrgk7G8
        UylfMLCk/X6fyrY5LudGClv29UiEpVne6QUzCpE=
X-Google-Smtp-Source: ABdhPJweSicEnEJg5QBYWDDId1oeAUQKC6uXdvywm1LhbVKL56kUMF2xwViKZzPQppk7Kz/xBONBQpFcSqQL8Jb+K/s=
X-Received: by 2002:a4a:94a7:: with SMTP id k36mr1307452ooi.45.1614238841449;
 Wed, 24 Feb 2021 23:40:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.883.git.1614111270.gitgitgadget@gmail.com> <fda23f07e6a20408b0a10c8944d54e7c65a1d629.1614111270.git.gitgitgadget@gmail.com>
In-Reply-To: <fda23f07e6a20408b0a10c8944d54e7c65a1d629.1614111270.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 24 Feb 2021 23:40:30 -0800
Message-ID: <CABPp-BEMNavqAEG54VYkZvSiJ4=X3vZUXsubCmFfk3yxUWOjXQ@mail.gmail.com>
Subject: Re: [PATCH 13/20] unpack-trees: allow sparse directories
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 23, 2021 at 12:14 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> The index_pos_by_traverse_info() currently throws a BUG() when a
> directory entry exists exactly in the index. We need to consider that it
> is possible to have a directory in a sparse index as long as that entry
> is itself marked with the skip-worktree bit.
>
> The negation of the 'pos' variable must be conditioned to only when it
> starts as negative. This is identical behavior as before when the index
> is full.

Same comment on the second paragraph as I made in the RFC series --
https://lore.kernel.org/git/CABPp-BGPJgA4guWHVm3AVS=hM0fTixUpRvJe5i9NnHT-3QJMfw@mail.gmail.com/.
I apologize if I'm repeating stuff you chose to not change, but I
didn't see a response and given the three typos left in previous
patches, I'm unsure whether it was unaddressed on purpose or on
accident.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  unpack-trees.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 4dd99219073a..b324eec2a5d1 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -746,9 +746,12 @@ static int index_pos_by_traverse_info(struct name_entry *names,
>         strbuf_make_traverse_path(&name, info, names->path, names->pathlen);
>         strbuf_addch(&name, '/');
>         pos = index_name_pos(o->src_index, name.buf, name.len);
> -       if (pos >= 0)
> -               BUG("This is a directory and should not exist in index");
> -       pos = -pos - 1;
> +       if (pos >= 0) {
> +               if (!o->src_index->sparse_index ||
> +                   !(o->src_index->cache[pos]->ce_flags & CE_SKIP_WORKTREE))
> +                       BUG("This is a directory and should not exist in index");
> +       } else
> +               pos = -pos - 1;
>         if (pos >= o->src_index->cache_nr ||
>             !starts_with(o->src_index->cache[pos]->name, name.buf) ||
>             (pos > 0 && starts_with(o->src_index->cache[pos-1]->name, name.buf)))
> --
> gitgitgadget
>
