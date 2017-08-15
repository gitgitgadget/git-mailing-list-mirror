Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFF5F208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753094AbdHOSRI (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:17:08 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33612 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752378AbdHOSRH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:17:07 -0400
Received: by mail-yw0-f173.google.com with SMTP id p68so9512574ywg.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rIHXssPitPvVxvlpc8xB69PPgyvTdVuEEtY294iBEgw=;
        b=BALKWf7on4lytOq/f/wt9XQo92LaERa57xdabrBFREN1T5562tDK1iJPH2DSEz0KPE
         +WAIv8HhOmhMooTVFqQnjBPdpsUkm1jImbOOFYA/1UVYyHR07ifzjEzac+h8GVfI7EwY
         uBfs+hHdTpOzylnMvR7Kp02AbiVlzJjzswaa4TttbS/QhgYBLs5gyvYXFdMSEvKYRCrj
         Z2Zt7evKJwmbbCQ3HBIGAnfy8NiNXZzhWWbzqk5nORj40xYXdzjsM2UD5Y/1eABeCMv+
         lzR58M2+uqaJnV75c/0GV/3vPsI/jvvLxLaMXF3ZyUyqPfEMvk1mCBATr7i6gw+sUW0a
         nCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rIHXssPitPvVxvlpc8xB69PPgyvTdVuEEtY294iBEgw=;
        b=qn2gcgqir0bfUgne3xTAfKaaz//dhUUwlLw9wavsW9sDu5zQfAc7Re62vLJ4WmEcv3
         IqzUEP2O3IrP1uHu0gfaZAdV4+OMiaAXCqLev67mfnw62Kf81I4MQPfYh73I44PGLJv2
         rT3MDwDyO42euVJ+AGXoqLh+bXlO12F+jqB4u8khrry71dPS6TY76Y3CuoHLAH1IoEOp
         o8xNlYTc1c9Qcq8A1DKE1jGKIVAHGiGU6dDzgpNvRwKUDCeGupy9bJmcFn4/Yu46m3eX
         a6hS/o7W2NBTAOHB2Ie83MZnFlDKcMaKmZSx0/nc7ylR4umVo+uv1eyves7kHoM3syR+
         ZFyA==
X-Gm-Message-State: AHYfb5ixoSaIA8vHM3HSb104w9S1Wtlfyh4NbPiyJUfb5gOpPw1yRkZB
        ZnHYJb2T4WunHZl8e5qrqclQYW2dtjfj
X-Received: by 10.13.212.3 with SMTP id w3mr23000009ywd.4.1502821026450; Tue,
 15 Aug 2017 11:17:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.56.142 with HTTP; Tue, 15 Aug 2017 11:17:05 -0700 (PDT)
In-Reply-To: <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 15 Aug 2017 11:17:05 -0700
Message-ID: <CAGZ79kbf52Uu-Th9W20QZV204A81kOAPTj2x6JkEP1rN=GTYtw@mail.gmail.com>
Subject: Re: tsan: t3008: hashmap_add touches size from multiple threads
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 15, 2017 at 10:59 AM, Jeff Hostetler <git@jeffhostetler.com> wr=
ote:
>
>
> On 8/15/2017 8:53 AM, Martin =C3=85gren wrote:
>>
>> Using SANITIZE=3Dthread made t3008-ls-files-lazy-init-name-hash.sh hit
>> the potential race below.
>>
>> What seems to happen is, threaded_lazy_init_name_hash ends up using
>> hashmap_add on the_index.dir_hash from two threads in a way that tsan
>> considers racy. While the buckets each have their own mutex, the "size"
>> does not. So it might end up with the wrong (lower) value. The size is
>> used to determine when to resize, but that should be fine, since
>> resizing is turned off due to threading anyway.
>
>>
>>
>> If the size is ever used for something else, the consequences might
>> range from cosmetic error to devastating. I have a "feeling" the size is
>> not used at the time, although maybe it is, in some roundabout way which
>> I'm not seeing.
>
>
> Good catch!  Yes, the size field is unguarded.  The only references to
> it that I found were used in _add() and _remove() in the need-to-rehash
> check.
>
> Since auto-rehash is turned off, this shouldn't be a problem, but it
> does feel odd to have a possibly incorrect size due to races.
>
> Rather than adding something like (a cross-platform version of)
> InterlockedIncrement(), I'm wondering if it would be better to
> disable/invalidate the size field when auto-rehash is turned off
> so we don't have to worry about it.
>
> Something like this:
>
>
> $ git diff
> diff --git a/hashmap.c b/hashmap.c
> index 9b6a12859b..be97642daa 100644
> --- a/hashmap.c
> +++ b/hashmap.c
> @@ -205,6 +205,9 @@ void hashmap_add(struct hashmap *map, void *entry)
>         ((struct hashmap_entry *) entry)->next =3D map->table[b];
>         map->table[b] =3D entry;
>
> +       if (map->disallow_rehash)
> +               return;
> +
>         /* fix size and rehash if appropriate */
>         map->size++;
>         if (map->size > map->grow_at)
> @@ -223,6 +226,9 @@ void *hashmap_remove(struct hashmap *map, const void
> *key, const void *keydata)
>         *e =3D old->next;
>         old->next =3D NULL;
>
> +       if (map->disallow_rehash)
> +               return;
> +


Once we have these two checks, the check in rehash itself becomes
redundant (as any code path leading to the check in rehash already
had the check).

Which leads me to wonder if we want to make the size (in/de)crease
part of the rehash function, which could be

    adjust_size(struct hashmap *map, int n)

with `n` either +1 or -1 (the increase value). Depending on 'n', we could
compute the newsize for the potential rehash in that function as well.

Note sure if that is a cleaner internal API.

>         /* fix size and rehash if appropriate */
>         map->size--;
>         if (map->size < map->shrink_at)
> diff --git a/hashmap.h b/hashmap.h
> index 7a8fa7fa3d..ec9541b981 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -183,7 +183,8 @@ struct hashmap {
>         const void *cmpfn_data;
>
>         /* total number of entries (0 means the hashmap is empty) */
> -       unsigned int size;
> +       /* -1 means size is unknown for threading reasons */
> +       int size;

This double-encodes the state of disallow_rehash (i.e. if we had
signed size, then the invariant disallow_rehash =3D=3D=3D (size < 0)
is true, such that we could omit either the flag and just check for
size < 0 or we do not need the negative size as any user would
need to check disallow_rehash first. Not sure which API is harder
to misuse. I'd think just having the size and getting rid of
disallow_rehash might be hard to to reused.

>
>         /*
>          * tablesize is the allocated size of the hash table. A non-0 val=
ue
> @@ -360,6 +361,15 @@ int hashmap_bucket(const struct hashmap *map, unsign=
ed
> int hash);
>  static inline void hashmap_disallow_rehash(struct hashmap *map, unsigned
> value)
>  {
>         map->disallow_rehash =3D value;
> +       if (value) {
> +               /*
> +                * Assume threaded operations starting, so don't
> +                * try to keep size current.
> +                */
> +               size =3D -1;
> +       } else {
> +               /* TODO count items in all buckets and set size. */
> +       }
>  }
>
>  /*
>
>
> Jeff
