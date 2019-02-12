Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C6BB1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 05:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfBLFns (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 00:43:48 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46598 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBLFns (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 00:43:48 -0500
Received: by mail-ua1-f66.google.com with SMTP id j8so463487uae.13
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 21:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=4/rLpA25+Ki5eGMLURWbi5CmDHtGUPvBTSZa69ylp0o=;
        b=hIu01g/eMtBjD5+u/iJh5M6rLXb6LyVmvoiqmYJZfeJh+lKjerz/g8L/ocDH+S4Gz8
         97dC0wUtI1gqePyhcWjnn47PYd1sOCOBTh4n63vDjsikipdvNwucz+oz6BHXd3pRiWu/
         /3JRJHufsn/jJqRVVmeRHHzy1G+IXALFKRkiSnzNaUTilYDxEmIQQGsgBA9JJEb5dPl8
         zUzfty+EtubXIlK/7XK8K3B8djyYky/MiJDP6EgDA+kPUnTVNrcv2TISikJKiAO+9HGs
         wMtp1Y5KlMi69Iu12Nz7QxvLVuj/4EzfHDbTlwiZ1k8obwxYk3N2/siRy8PCg0LoZgS8
         BA4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4/rLpA25+Ki5eGMLURWbi5CmDHtGUPvBTSZa69ylp0o=;
        b=oEAxaHY6cE90Wk5gFdm42Vu5ZLapj9T+DVzXO5XHYepIqzrrVwKCkNj1YIAMyrbmLe
         6SoP8HJ4vdroplHxxK60SsHp2NujPEmPBBwgsbRr7N/u6daG5SncgUqybq0mt098gGhB
         s+ae1gZpurFnYOBMyofFuQPXFbvZrHK+vVHmrM2JXjFHMknIR6LSkV0ATkMOCjPzITns
         pGKK4OBScqbulvYwt2wfivSeHzaPVvBFCJV5VQWxWz0ILTB29I8JpY4NgRa7Bu+HqwqR
         jI19bzeIbS7p2uXxvwuAPUa1UVCnmYamCyz3RdoXUNG06zxdilrBW5WBzz3Q9+aWRc3c
         JHWg==
X-Gm-Message-State: AHQUAubtq7HVpjodT8fYktPF3LWtGONoFzWakCbwX1ZpDIwbEsgf+aJx
        4SWPn56/v8zAzKQXZnvqvStKpCDUtlXpUjoQH08=
X-Google-Smtp-Source: AHgI3IYNn2/w8xS//sBWDPP6KyXIvueUp309+t+y6Y3opRGsO3KjfFnNqBKNXZ1+rOq1vCSetXEVazDLfDTmgYU8ssQ=
X-Received: by 2002:ab0:2b93:: with SMTP id q19mr791348uar.130.1549950226577;
 Mon, 11 Feb 2019 21:43:46 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
 <20190209112328.26317-1-pclouds@gmail.com>
In-Reply-To: <20190209112328.26317-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Feb 2019 21:43:35 -0800
Message-ID: <CABPp-BF+q0QY1YAKOk4iSrCRuEc7xsG7iqCzeDD9v8+jmvQvzg@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees.c: fix writing "link" index ext with null
 base oid
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     luke@diamand.org, Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 9, 2019 at 3:23 AM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <p=
clouds@gmail.com> wrote:
>
> Since commit 7db118303a (unpack_trees: fix breakage when o->src_index !=
=3D
> o->dst_index - 2018-04-23) and changes in merge code to use separate
> index_state for source and destination, when doing a merge with split
> index activated, we may run into this line in unpack_trees():
>
>     o->result.split_index =3D init_split_index(&o->result);
>
> This is by itself not wrong. But this split index information is not
> fully populated (and it's only so when move_cache_to_base_index() is
> called, aka force splitting the index, or loading index_state from a
> file). Both "base_oid" and "base" in this case remain null.
>
> So when writing the main index down, we link to this index with null
> oid (default value after init_split_index()), which also means "no split
> index" internally. This triggers an incorrect base index refresh:
>
>     warning: could not freshen shared index '.../sharedindex.0{40}'
>
> This patch makes sure we will not refresh null base_oid (because the
> file is never there). It also makes sure not to write "link" extension
> with null base_oid in the first place (no point having it at
> all). Read code already has protection against null base_oid.
>
> There is also another side fix in remove_split_index() that causes a
> crash when doing "git update-index --no-split-index" when base_oid in
> the index file is null. In this case we will not load
> istate->split_index->base but we dereference it anyway and are rewarded
> with a segfault. This should not happen anymore, but it's still wrong to
> dereference a potential NULL pointer, especially when we do check for
> NULL pointer in the next code.
>
> Reported-by: Luke Diamand <luke@diamand.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>

Thanks for digging this down and fixing it.  When I saw this split
index bug bisect to me that my heart sank a little; there's so much of
that code I don't understand.  Nice to see you've already come along
and fixed it all up.  :-)

> ---
>  I considered adding a test, but since the problem is a warning, not
>  sure how to catch that. And a test would not be able to verify all
>  changes in this patch anyway.
>
>  read-cache.c  |  5 +++--
>  split-index.c | 34 ++++++++++++++++++----------------
>  2 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 0e0c93edc9..d6fb09984f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2894,7 +2894,8 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
>                         return -1;
>         }
>
> -       if (!strip_extensions && istate->split_index) {
> +       if (!strip_extensions && istate->split_index &&
> +           !is_null_oid(&istate->split_index->base_oid)) {
>                 struct strbuf sb =3D STRBUF_INIT;
>
>                 err =3D write_link_extension(&sb, istate) < 0 ||
> @@ -3189,7 +3190,7 @@ int write_locked_index(struct index_state *istate, =
struct lock_file *lock,
>         ret =3D write_split_index(istate, lock, flags);
>
>         /* Freshen the shared index only if the split-index was written *=
/
> -       if (!ret && !new_shared_index) {
> +       if (!ret && !new_shared_index && !is_null_oid(&si->base_oid)) {
>                 const char *shared_index =3D git_path("sharedindex.%s",
>                                                     oid_to_hex(&si->base_=
oid));
>                 freshen_shared_index(shared_index, 1);
> diff --git a/split-index.c b/split-index.c
> index 5820412dc5..a9d13611a4 100644
> --- a/split-index.c
> +++ b/split-index.c
> @@ -440,24 +440,26 @@ void add_split_index(struct index_state *istate)
>  void remove_split_index(struct index_state *istate)
>  {
>         if (istate->split_index) {
> -               /*
> -                * When removing the split index, we need to move
> -                * ownership of the mem_pool associated with the
> -                * base index to the main index. There may be cache entri=
es
> -                * allocated from the base's memory pool that are shared =
with
> -                * the_index.cache[].
> -                */
> -               mem_pool_combine(istate->ce_mem_pool, istate->split_index=
->base->ce_mem_pool);
> +               if (istate->split_index->base) {
> +                       /*
> +                        * When removing the split index, we need to move
> +                        * ownership of the mem_pool associated with the
> +                        * base index to the main index. There may be cac=
he entries
> +                        * allocated from the base's memory pool that are=
 shared with
> +                        * the_index.cache[].
> +                        */
> +                       mem_pool_combine(istate->ce_mem_pool,
> +                                        istate->split_index->base->ce_me=
m_pool);
>
> -               /*
> -                * The split index no longer owns the mem_pool backing
> -                * its cache array. As we are discarding this index,
> -                * mark the index as having no cache entries, so it
> -                * will not attempt to clean up the cache entries or
> -                * validate them.
> -                */
> -               if (istate->split_index->base)
> +                       /*
> +                        * The split index no longer owns the mem_pool ba=
cking
> +                        * its cache array. As we are discarding this ind=
ex,
> +                        * mark the index as having no cache entries, so =
it
> +                        * will not attempt to clean up the cache entries=
 or
> +                        * validate them.
> +                        */
>                         istate->split_index->base->cache_nr =3D 0;
> +               }
>
>                 /*
>                  * We can discard the split index because its
> --
> 2.20.1.682.gd5861c6d90
>
