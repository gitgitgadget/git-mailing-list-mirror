Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC5901F453
	for <e@80x24.org>; Sat, 27 Oct 2018 14:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbeJ0WqF (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Oct 2018 18:46:05 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:38605 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728651AbeJ0WqF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Oct 2018 18:46:05 -0400
Received: by mail-it1-f196.google.com with SMTP id i76-v6so4882359ita.3
        for <git@vger.kernel.org>; Sat, 27 Oct 2018 07:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0EX4bMwOedJJUYDdWXsH+XTo++xO0CNrBeg6+RDCXk=;
        b=qfImcUcDEAbAWSclwZRtd3ApqW6LBIgcCoHUoNKU7Ia+O8hidxnIMevmY9vg3JM+ed
         baRY2ZGaQHUyi9S8KIpeepzaNqhrmy4f1AeOgsbYYcwZ7d2duHdWWKZz0pjD6DX3RR29
         TiLSjxLXiaAz6D4q0Elh0WBoHNnREUo5+VsSt9MvA/qZ04QjUKsgc2/3rsvW3o55NTy5
         T4wuIwt5J+4/ajkfYJrfhth8suPePpDPsgbVVGvymPGXPPx9OKUrsxOQ6EGRSyN2lN2m
         IQY8twFeeULWqbi5R3eQz7Jq6OgQj0D2HWOgTWCaaO3/ze6ByvQcdPG3VxTWZl11TKXa
         ETYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0EX4bMwOedJJUYDdWXsH+XTo++xO0CNrBeg6+RDCXk=;
        b=PitrAqEPj4loQAupfUnj0uJK+6AmW/FFYQyWnr7tVSTxoJvLTmYs6ocZhI8HuVe7FF
         Xlx0LcJQOyQ3ghUwgcCpbvNiA76JLEk8B/aBR6GZ1bqrAUX+ur22BCMgd7ddFvkWqDpR
         Bi2aDKt/NJzW4g4D4wyGzb0s5UvA1VSmkOCMJ/VTPqBudfe7tMc7opbMrGAKogUXwn38
         uqX1zfcoT40CmQfpz2Gzbui4Y+176/MqDCm74td0A6ddibBZzyHEl16WD7nNBAvqxklI
         MxANp6D4h7/uJ0E2RRuyYVdGwkRqn8uPB1hNDRd1s6p8HTjNV7bCJx8ryFJot+0jZkkn
         cV4Q==
X-Gm-Message-State: AGRZ1gLvk/ipfxh5Kk6e/NVG/Cr8ExRyzdghoSlRNCsG2rkC0HFo2UvE
        wxkzns0fY6R7SmcIapVTdoRgqiWXi7oBxB0EkRU=
X-Google-Smtp-Source: AJdET5cefLqa4VgifMKOllqd43xBEIx2uJ3v75SQhStrowtYFiYDzhQXM0SHF4zW7DSuXSpEHcuEY9d7VlK89unbgjY=
X-Received: by 2002:a24:7804:: with SMTP id p4-v6mr6182142itc.123.1540649098705;
 Sat, 27 Oct 2018 07:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <ED25E182-C296-4D08-8170-340567D8964A@amazon.com>
 <xmqqk1m5ftgj.fsf@gitster-ct.c.googlers.com> <87o9bgl9yl.fsf@evledraar.gmail.com>
 <xmqq1s8bc0jp.fsf@gitster-ct.c.googlers.com> <20181027093300.GA23974@sigill.intra.peff.net>
In-Reply-To: <20181027093300.GA23974@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 27 Oct 2018 16:04:32 +0200
Message-ID: <CACsJy8A2MFbZQ-y5ufw-D6zzc-ye_gJmLVbDbgA+=2mhFiTusQ@mail.gmail.com>
Subject: Re: [RFC PATCH] index-pack: improve performance on NFS
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        gerardu@amazon.com, Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 27, 2018 at 11:34 AM Jeff King <peff@peff.net> wrote:
> Taking one step back, the root problem in this thread is that stat() on
> non-existing files is slow (which makes has_sha1_file slow).
>
> One solution there is to cache the results of looking in .git/objects
> (or any alternate object store) for loose files. And indeed, this whole
> scheme is just a specialized form of that: it's a flag to say "hey, we
> do not have any objects yet, so do not bother looking".
>
> Could we implement that in a more direct and central way? And could we
> implement it in a way that catches more cases? E.g., if I have _one_
> object, that defeats this specialized optimization, but it is probably
> still beneficial to cache that knowledge (and the reasonable cutoff is
> probably not 1, but some value of N loose objects).

And we do hit this on normal git-fetch. The larger the received pack
is (e.g. if you don't fetch often), the more stat() we do, so your
approach is definitely better.

> Of course any cache raises questions of cache invalidation, but I think
> we've already dealt with that for this case. When we use
> OBJECT_INFO_QUICK, that is a sign that we want to make this kind of
> accuracy/speed tradeoff (which does a similar caching thing with
> packfiles).

We don't care about a separate process adding more loose objects while
index-pack is running, do we? I'm guessing we don't but just to double
check...

> So putting that all together, could we have something like:
>
> diff --git a/object-store.h b/object-store.h
> index 63b7605a3e..28cde568a0 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -135,6 +135,18 @@ struct raw_object_store {
>          */
>         struct packed_git *all_packs;
>
> +       /*
> +        * A set of all loose objects we have. This probably ought to be split
> +        * into a set of 256 caches so that we can fault in one directory at a
> +        * time.
> +        */
> +       struct oid_array loose_cache;
> +       enum {
> +               LOOSE_CACHE_UNFILLED = 0,
> +               LOOSE_CACHE_INVALID,
> +               LOOSE_CACHE_VALID
> +       } loose_cache_status;
> +
>         /*
>          * A fast, rough count of the number of objects in the repository.
>          * These two fields are not meant for direct access. Use
> diff --git a/packfile.c b/packfile.c
> index 86074a76e9..68ca4fff0e 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -990,6 +990,8 @@ void reprepare_packed_git(struct repository *r)
>         r->objects->approximate_object_count_valid = 0;
>         r->objects->packed_git_initialized = 0;
>         prepare_packed_git(r);
> +       oid_array_clear(&r->objects->loose_cache);
> +       r->objects->loose_cache_status = LOOSE_CACHE_UNFILLED;
>  }
>
>  struct packed_git *get_packed_git(struct repository *r)
> diff --git a/sha1-file.c b/sha1-file.c
> index dd0b6aa873..edbe037eaa 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1172,6 +1172,40 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>         return parse_sha1_header_extended(hdr, &oi, 0);
>  }
>
> +/* probably should be configurable? */

Yes, perhaps with gc.auto config value (multiplied by 256) as the cut
point. If it's too big maybe just go with a bloom filter. For this
particular case we expect like 99% of calls to miss.

> +#define LOOSE_OBJECT_CACHE_MAX 65536
> +
> +static int fill_loose_cache(const struct object_id *oid,
> +                           const char *path,
> +                           void *data)
> +{
> +       struct oid_array *cache = data;
> +
> +       if (cache->nr == LOOSE_OBJECT_CACHE_MAX)
> +               return -1;
> +
> +       oid_array_append(data, oid);
> +       return 0;
> +}
> +
> +static int quick_has_loose(struct raw_object_store *r,
> +                          struct object_id *oid)
> +{
> +       struct oid_array *cache = &r->loose_cache;
> +
> +       if (r->loose_cache_status == LOOSE_CACHE_UNFILLED) {
> +               if (for_each_loose_object(fill_loose_cache, cache, 0) < 0)
> +                       r->loose_cache_status = LOOSE_CACHE_INVALID;
> +               else
> +                       r->loose_cache_status = LOOSE_CACHE_VALID;
> +       }
> +
> +       if (r->loose_cache_status == LOOSE_CACHE_INVALID)
> +               return -1;
> +
> +       return oid_array_lookup(cache, oid) >= 0;
> +}
> +
>  static int sha1_loose_object_info(struct repository *r,
>                                   const unsigned char *sha1,
>                                   struct object_info *oi, int flags)
> @@ -1198,6 +1232,19 @@ static int sha1_loose_object_info(struct repository *r,
>         if (!oi->typep && !oi->type_name && !oi->sizep && !oi->contentp) {
>                 const char *path;
>                 struct stat st;
> +               if (!oi->disk_sizep && (flags & OBJECT_INFO_QUICK)) {
> +                       struct object_id oid;
> +                       hashcpy(oid.hash, sha1);
> +                       switch (quick_has_loose(r->objects, &oid)) {
> +                       case 0:
> +                               return -1; /* missing: error */
> +                       case 1:
> +                               return 0; /* have: 0 == success */
> +                       default:
> +                               /* unknown; fall back to stat */
> +                               break;
> +                       }
> +               }
>                 if (stat_sha1_file(r, sha1, &st, &path) < 0)
>                         return -1;
>                 if (oi->disk_sizep)
>
> That's mostly untested, but it might be enough to run some timing tests
> with. I think if we want to pursue this, we'd want to address the bits I
> mentioned in the comments, and look at unifying this with the loose
> cache from cc817ca3ef (which if I had remembered we added, probably
> would have saved some time writing the above ;) ).
>
> -Peff
-- 
Duy
