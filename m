Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B71C51F453
	for <e@80x24.org>; Sat,  9 Feb 2019 14:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbfBIOOj (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Feb 2019 09:14:39 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54058 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfBIOOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Feb 2019 09:14:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id d15so8588165wmb.3
        for <git@vger.kernel.org>; Sat, 09 Feb 2019 06:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sdJ5xpiaHpR4DJSKjxi4TWnn7D63Ui4w842mVT18ZJ0=;
        b=dvlepJIRrWLH2B1dpyT4uC+UGt0tiX1fQih5U+g7NMkBdygL4ngLxiZSY+vsLGjU7/
         WZrEaFU+3rX8i5+eVZ4lZMblQHY6mXAXbZzImhjQQC4zpKTiY8FDhKg8gCDoTD+dffw1
         G+8YxeF+l/Jz0+MOWqynfK+/UozA5VkG9Kl9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sdJ5xpiaHpR4DJSKjxi4TWnn7D63Ui4w842mVT18ZJ0=;
        b=YeYSb2+i17Z6zPuGiSbZrFTtqwRswlL54s+IyUkP34l/qk8YTUhwCUT/7e+WEtijwr
         xbd4d630xGGgE450ECQW7uXkQa4yae00ScQizbrJvcYaNbZH8izcPXG4PJKfZGuTcWcc
         9ADDo0jSR4jCgueQLWU1I57I986869FbPhQh+HD7Fq51yGtTJH8h0AfdkOgla2na6sgQ
         F85wAciBqpaEcUHfzFX3tkI2ZNS9Uo4Vs9Kfr4RYbUETI4O85nOTbAPD1Mr9FS6uFlFv
         OZnBeaF6tRYGuxE68QRAMdtxiHSrLg4G9XVK++fmHIGmafoVd1IWorq6NMCcynMkNrHN
         9frg==
X-Gm-Message-State: AHQUAubiOgu2rPCwNDTledSCVky48+se+OOXLUWhZGHuyQuyd9UbV3VB
        rjvcTfoQTqaNj9Gkm2ItYGXTykVu76EInYEJfooh8g==
X-Google-Smtp-Source: AHgI3IY7NcmxCq8wcJznydqqdQn63jNw2RDeTpOYocabrsCpugZooYymzekAgUU38w6WPeZQFCw2PKXyetGJIO325HM=
X-Received: by 2002:a1c:2314:: with SMTP id j20mr2968215wmj.142.1549721676374;
 Sat, 09 Feb 2019 06:14:36 -0800 (PST)
MIME-Version: 1.0
References: <CAE5ih79JYrcV9cxMBU88Hq=HHQOOyzpkq+kT2zAgDzs=ao+PMg@mail.gmail.com>
 <20190209112328.26317-1-pclouds@gmail.com>
In-Reply-To: <20190209112328.26317-1-pclouds@gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Sat, 9 Feb 2019 14:14:25 +0000
Message-ID: <CAE5ih7-0Qq6DOrE0Y7jQ++Jer0P5SGM38KA0n1_busAi08ux=Q@mail.gmail.com>
Subject: Re: [PATCH] unpack-trees.c: fix writing "link" index ext with null
 base oid
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 9 Feb 2019 at 11:23, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pcl=
ouds@gmail.com> wrote:
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

Ack, I no longer see those messages.


>
