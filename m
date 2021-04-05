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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3155BC433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01982613BB
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 19:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240256AbhDETxs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240243AbhDETxn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 15:53:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF415C061756
        for <git@vger.kernel.org>; Mon,  5 Apr 2021 12:53:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so12406084otq.8
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csL/3Fp9LoImo3b7qAi0PGndDIfkK1vk4XCTb7VB9+o=;
        b=McdSCuOVIrUJ45OsL9gN6+O8GhmbO0VcDM6F2wLc2DRLSc8YHjSG5ulIIItZxwJZv2
         Q1KeGLHgx/9j50Zj9iGwPdxlJIwKYoir82uerxyHbciEiMlXQEsU2S4SmMetfu7M1Ykp
         s6EBz2700vbOtMESikXqSjxm+4G3gcbQ3JuCrXCwQYHV7v+R86qpCQ2t7RKjqjsvBqT3
         q3GXnNMjUtjNS6lXCr9fjDgUOKObaQJNRkMPchm3hFKhDkM3xLTAc0jnLlIV48NF0jMl
         BawpKtg4v8bCv+VdoZMfSy/dY0ELFxhK/57YqxBch9mvB5S2qxZUteJ5HbPAXlKF0otR
         1jnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csL/3Fp9LoImo3b7qAi0PGndDIfkK1vk4XCTb7VB9+o=;
        b=FqMnvUcscdDzFhMiAU3kx4AmNNELnchWJYf861js+lpxsTHTAH7MydeIN0WPt0BJzi
         VCf6/tevwF7PU4eg3fastxZH9uwtunShWLtlX0pawZhZ3OOIL7syhUAqmRTYuLKv1lg4
         dWWiKcT0/Jk95Yr4Y9mM73i2hfxtiDjro7d8Q5KQ84QCLx1PJq5FsQBeMwcHrwE3xqlz
         KPF0WQ7Nt2x2yzTUY8aKQjua5ds9gzzy4WslpVxgAQGhyNrvsH1fFVsV1x00D3775wh2
         afGv1Wa0HOWN7CZvEyezwQjGUNFJr8Cg/tRuYG/4q/XJbhN9X1G06i6/VCI+IweLNhBO
         kpgg==
X-Gm-Message-State: AOAM530JhYpXdisyudV63Hm5dAMI8wOg/K6C/6TfxjEDzxvmEysfJJ9f
        gublYJkDCW0JTMdfk/5K6MgQv4phm+rYuG6PHro=
X-Google-Smtp-Source: ABdhPJzuAcxNXxfr4NeTgP0S76IXOhrtn0DosdJsWOcL6BCW4yhtjgtXpgOUkTS4pdi0DWoxKaBZ9nECJuFMo0Bw8xA=
X-Received: by 2002:a9d:8ae:: with SMTP id 43mr23253205otf.162.1617652412114;
 Mon, 05 Apr 2021 12:53:32 -0700 (PDT)
MIME-Version: 1.0
References: <pull.906.git.1615929435.gitgitgadget@gmail.com>
 <pull.906.v2.git.1617241802.gitgitgadget@gmail.com> <7e2d3fae9a2a0574d2f881d0bcd4931a2cad6b45.1617241803.git.gitgitgadget@gmail.com>
In-Reply-To: <7e2d3fae9a2a0574d2f881d0bcd4931a2cad6b45.1617241803.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 5 Apr 2021 12:53:20 -0700
Message-ID: <CABPp-BHvMa5Vf-fpmd7mK8awTU2WK_Gr7Mc8PA-r+NHxqzNu6w@mail.gmail.com>
Subject: Re: [PATCH v2 25/25] name-hash: use expand_to_path()
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 31, 2021 at 6:50 PM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <dstolee@microsoft.com>
>
> A sparse-index loads the name-hash data for its entries, including the
> sparse-directory entries. If a caller asks for a path that is contained
> within a sparse-directory entry, we need to expand to a full index and
> recalculate the name hash table before returning the result. Insert
> calls to expand_to_path() to protect against this case.
>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  name-hash.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/name-hash.c b/name-hash.c
> index 4e03fac9bb12..75c159e06eeb 100644
> --- a/name-hash.c
> +++ b/name-hash.c
> @@ -8,6 +8,7 @@
>  #include "cache.h"
>  #include "thread-utils.h"
>  #include "trace2.h"
> +#include "sparse-index.h"
>
>  struct dir_entry {
>         struct hashmap_entry ent;
> @@ -109,6 +110,12 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>         if (ce->ce_flags & CE_HASHED)
>                 return;
>         ce->ce_flags |= CE_HASHED;
> +
> +       if (S_ISSPARSEDIR(ce->ce_mode)) {
> +               add_dir_entry(istate, ce);
> +               return;
> +       }

I don't see how this relates to the commit message.  Was this meant to
be included in another commit?  If it is intended to be included here,
could an explanation be added?

> +
>         hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
>         hashmap_add(&istate->name_hash, &ce->ent);
>
> @@ -680,6 +687,7 @@ int index_dir_exists(struct index_state *istate, const char *name, int namelen)
>         struct dir_entry *dir;
>
>         lazy_init_name_hash(istate);
> +       expand_to_path(istate, name, namelen, 0);
>         dir = find_dir_entry(istate, name, namelen);
>         return dir && dir->nr;
>  }
> @@ -690,6 +698,7 @@ void adjust_dirname_case(struct index_state *istate, char *name)
>         const char *ptr = startPtr;
>
>         lazy_init_name_hash(istate);
> +       expand_to_path(istate, name, strlen(name), 0);
>         while (*ptr) {
>                 while (*ptr && *ptr != '/')
>                         ptr++;
> @@ -713,6 +722,7 @@ struct cache_entry *index_file_exists(struct index_state *istate, const char *na
>         unsigned int hash = memihash(name, namelen);
>
>         lazy_init_name_hash(istate);
> +       expand_to_path(istate, name, namelen, icase);
>
>         ce = hashmap_get_entry_from_hash(&istate->name_hash, hash, NULL,
>                                          struct cache_entry, ent);
> --
> gitgitgadget
