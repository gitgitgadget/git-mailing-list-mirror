Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92573C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E9D620791
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 15:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MADM1XMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbgJ3Ph4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 11:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgJ3Ph4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 11:37:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A7C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 08:37:54 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w145so1392099oie.9
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 08:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3qB0J8AkM33oe+q//j4mkeUgkvZI45h37Z9MstqYOA=;
        b=MADM1XMHgYqLZ1WXr4h0mLTuJ2rDBAzktKh32vpCp3cTf+QP1rwuQHY/1+WO1OUU8X
         cP+Y7N6Kl3u3S7i6vHLbED27igwcDOxaoGNOREopOjsz2PXUrBH+R8fYKMj1j3jEWsji
         GK6JdATVISWaBYxxylyAedEJjw8N0mMdrwBT5nojOBsFKgkEKpmFlZV1mToqzPlaLtvY
         scmf7RM12tqfiBdxFzbf0s0IBMplor+rX7G0XpCIT7aPiWsU2oam9FsXMn8zvX5BX1zW
         p/V+6QnMWIS4tKxHcOuWKPdLB+cpz+zxqeBA4M0xhzD9nYidvDxchH/7FYGkoWGJYbxn
         YN1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3qB0J8AkM33oe+q//j4mkeUgkvZI45h37Z9MstqYOA=;
        b=LMA4JzQjiDY5gY6w0/9icpcKGc/Cpt9Fo6gRqgojpRjTsR/ZiPF54c5u9pMKugBX2N
         ePslIq7fiu1UH1S8SypLpu77p3AUV0E1XjAHP9TN2/rpuE6ONdgxkIRf1iBImuaqrZ4S
         Rt0tu12lLtrnpYpl9LSPrWQDOgwiQVsUuoBKtjX1u3aTimhnAlb2djSpKO1bd+ERwrOX
         K80LeRW131o38EwKKXsNW+GS4XRgPgtcH2piXKAfw6xKbys3uymvvcepC1vNlKzbsW96
         ZHHZKYH7m64knU5pcDFBRexNhig420LueA66I3v24CxImDGUxeuXpv8+9+lmQo24Y5ZA
         jmkg==
X-Gm-Message-State: AOAM531Pe1nVsFD0SoOzjtlyh5iHmptJkGh2h7QKmBSMLM+TzvJmiuoH
        UIfN3teXaGATnQFPF7bNpXswmjVvuczXXmupli7OaxdX5Zk=
X-Google-Smtp-Source: ABdhPJyX3S8ptBNgTGZH3bysiHt7G8D+Ain+SuSWv5Ky/9yD+gfLchm/fg1rU19gc0vs7ehEgtX+6qqYpMvzashPE88=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr1950619oic.31.1604072273850;
 Fri, 30 Oct 2020 08:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <a686d0758a2652c91363dcf68da7726093d00c23.1602549650.git.gitgitgadget@gmail.com>
 <20201030133518.GC3277724@coredump.intra.peff.net>
In-Reply-To: <20201030133518.GC3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 08:37:42 -0700
Message-ID: <CABPp-BHRSottxaYO+Ot5tPpNCf4scxmtwBLZicMJ4ChNEhmGHA@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] hashmap: allow re-use after hashmap_free()
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 6:35 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:43AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > Previously, once map->table had been freed, any calls to hashmap_put(),
> > hashmap_get(), or hashmap_remove() would cause a NULL pointer
> > dereference (since hashmap_free_() also zeros the memory; without that
> > zeroing, calling these functions would cause a use-after-free problem).
> >
> > Modify these functions to check for a NULL table and automatically
> > allocate as needed.
>
> Unsurprisingly, I like this direction. The code looks correct to me,
> though I think you could reduce duplication slightly by checking
> map->table in find_entry_ptr(). That covers both hashmap_get() and
> hashmap_remove(). But I'm happy either way.
>
> > I also thought about creating a HASHMAP_INIT macro to allow initializing
> > hashmaps on the stack without calling hashmap_init(), but virtually all
> > uses of hashmap specify a usecase-specific equals_function which defeats
> > the utility of such a macro.
>
> This part I disagree with. If we did:
>
>   #define HASHMAP_INIT(fn, data) = { .cmpfn = cmpfn, cmpfn_data = data }
>
> then many callers could avoid handling the lazy-init themselves. E.g.:

Ah, gotcha.  That makes sense to me.  Given that 43 out of 47 callers
of hashmap_init use cmpfn_data = NULL, should I shorten it to just one
parameter for the macro, and let the four special cases keep calling
hashmap_init() to specify a non-NULL cmpfn_data?

>
>  attr.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/attr.c b/attr.c
> index a826b2ef1f..55a2783f1b 100644
> --- a/attr.c
> +++ b/attr.c
> @@ -57,7 +57,9 @@ static inline void hashmap_unlock(struct attr_hashmap *map)
>   * is a singleton object which is shared between threads.
>   * Access to this dictionary must be surrounded with a mutex.
>   */
> -static struct attr_hashmap g_attr_hashmap;
> +static struct attr_hashmap g_attr_hashmap = {
> +       HASHMAP_INIT(attr_hash_entry_cmp, NULL)
> +};
>
>  /* The container for objects stored in "struct attr_hashmap" */
>  struct attr_hash_entry {
> @@ -80,12 +82,6 @@ static int attr_hash_entry_cmp(const void *unused_cmp_data,
>         return (a->keylen != b->keylen) || strncmp(a->key, b->key, a->keylen);
>  }
>
> -/* Initialize an 'attr_hashmap' object */
> -static void attr_hashmap_init(struct attr_hashmap *map)
> -{
> -       hashmap_init(&map->map, attr_hash_entry_cmp, NULL, 0);
> -}
> -
>  /*
>   * Retrieve the 'value' stored in a hashmap given the provided 'key'.
>   * If there is no matching entry, return NULL.
> @@ -96,9 +92,6 @@ static void *attr_hashmap_get(struct attr_hashmap *map,
>         struct attr_hash_entry k;
>         struct attr_hash_entry *e;
>
> -       if (!map->map.tablesize)
> -               attr_hashmap_init(map);
> -
>         hashmap_entry_init(&k.ent, memhash(key, keylen));
>         k.key = key;
>         k.keylen = keylen;
> @@ -114,9 +107,6 @@ static void attr_hashmap_add(struct attr_hashmap *map,
>  {
>         struct attr_hash_entry *e;
>
> -       if (!map->map.tablesize)
> -               attr_hashmap_init(map);
> -
>         e = xmalloc(sizeof(struct attr_hash_entry));
>         hashmap_entry_init(&e->ent, memhash(key, keylen));
>         e->key = key;
