Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A8326E950
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 19:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684407; cv=none; b=hy3yhh2gJyTPTSp2rKTDMR9GS3dVXnwZ4VsoOy/MAk6+ILG4JHXXEQ1ZnrBG+qSwWr1KydLHGmW3fPpC0PmI153//0XE9qa4QCssT6tqJ06rodXkpOTbpRiAlr9uewg2TNOiXA07WHDyZ/Qzh+6LSiCDWINR8qqfzG5JT+lnHZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684407; c=relaxed/simple;
	bh=e2XpflAsUS05ba19/Ka31VD6GKzzB2VxNDw/7A1aHic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmToOheIgdrCBg5+mDMM0laDCyuZU0kk/KujxVyJgFK/UG+NSEgel102EyviKi/rcGbVcPgUIzl/CdD85BaXZ5YWUunoH75puDhM4OtyOu7f23zZhclZCfbAvw09OU/QTvbxg2GBNFDRU7GRVeIWaGZYW5QwboOWB2MRHP4Lx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eTzQNtj3; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTzQNtj3"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855a095094fso37831439f.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740684403; x=1741289203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NFvYVWcf0MJvZUMGUll9OkO5jGNP1000I5jdvxc8NTQ=;
        b=eTzQNtj3QT2FZkmXpBBL/2YvFEYIuH3emg231sz5+6k7MrYgWjYhKtSYyyLku2Ixir
         0valnlOM/KeqHfaq8L46fxqCHAHZI0DzkfOd5Hnw3biY3C4R3Kz3XjzGAWlGqX+2Wply
         WazNnTVBFJWKn/yK2pg6AEeuqpgH/36PJaEu8078fstYQR0KZ+ism+ZxjJurgKALsPmk
         SfPJO1alQKGhQEauz/vEXBazEMPL8IYh+oe2zVxFlHk/hpMlPG9GskZzCb0E0cT8IKtz
         0G3tbnWVD4M+b9z+0TMDbsJ6h+5rASifurckFbAHhMBJQUYxIPIEIKHx4HOKHt48bWfZ
         uGHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684403; x=1741289203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFvYVWcf0MJvZUMGUll9OkO5jGNP1000I5jdvxc8NTQ=;
        b=VWadyXCnJAfqJB9FF+Ex9X2KRcFYeKFu8x5u+lkOVHZjofnbuos2XlRtYls0Xe84o6
         /8pc3wF6F51XM9q7BQ0s416psdfJle9oa7WboN43iljiTEegnHsOXr5QIlEmP4IzGXov
         AMTByyBvMgOtsYipSWRyc+L5oMWTuZ713FtTfZ8u/K45h+glddzu6CkQHDvsMT22KnN3
         mq/cOo5y9jajEB4FYPEyvJeaDMXIvRPvdEVwHZSpBvLhnpkD4k/O69LIX4+hFkr29Czm
         M1ScPW94Kg+gRLsoHZLDwSIcQKHBxSOdoRRxUobry9n15izcuNSvz4FmKIIHuC+LJhmM
         RbXA==
X-Gm-Message-State: AOJu0YyQgzXZwZzSLFlVyEu1vC/K6z9t6R2+dZOujT4B+EbM7mmDT5y9
	sEGeWyq8nlwdrKB+2xBwbFGg2Wpqk177quNq8St76VstcTD6jPai/6lOh113Z6Dlir6UtsBB+yV
	1vkI8LhU8wyiXMUnhZRPO1d0ylRWCyUHz
X-Gm-Gg: ASbGncsrtXIBIqvJXH7ke+R+zJDBz5eBiiuFp9c22Jvv+0L7tX/XAvMslxuaNLOiS6d
	RnjO1F6GY1X2AvpCu+P3Yog9bqlV4HBZMkgLA2+/+bJIvFjT7XD61BEpdmneclluPeGGgccmzuk
	dG85pHiXOCqQiVxegXhfeoocLVi1FBeuIpOIkx7T7z
X-Google-Smtp-Source: AGHT+IHlBMmBNu6R1hZFqCgdDyaOakaE+bH/VdevGisS7F5iSOJayjvozFmkWsm6vXJFU9AdnpITjtIofbcMbzM8KjQ=
X-Received: by 2002:a05:6e02:180d:b0:3d3:dcc4:a58e with SMTP id
 e9e14a558f8ab-3d3e6e42ed7mr5986965ab.8.1740684403498; Thu, 27 Feb 2025
 11:26:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740680964.git.me@ttaylorr.com> <c0c926adde2b7c8f4b53b7a274d5b8c040f77e62.1740680964.git.me@ttaylorr.com>
In-Reply-To: <c0c926adde2b7c8f4b53b7a274d5b8c040f77e62.1740680964.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Feb 2025 11:26:32 -0800
X-Gm-Features: AQ5f1JoYt6l9Fy2mzVNvMEpFKY0M8snhicEfXJVJdxWw1A0opMmMhtp524CU7gU
Message-ID: <CABPp-BGv6J307nTo1sUgAnE+7ZnueSPm4CJLb10wBGQGaPPDWA@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/pack-objects.c: freshen objects from existing
 cruft packs
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:29=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> Once an object is written into a cruft pack, we can only freshen it by
> writing a new loose or packed copy of that object with a more recent
> mtime.

Thanks for adding this.  (Side note for others reading: I reviewed an
earlier round before it was posted to the list).

> Prior to 61568efa95 (builtin/pack-objects.c: support `--max-pack-size`
> with `--cruft`, 2023-08-28), we typically had at most one cruft pack in
> a repository at any given time. So freshening unreachable objects was
> straightforward when already rewriting the cruft pack (and its *.mtimes
> file).
>
> But 61568efa95 changes things: 'pack-objects' now supports writing
> multiple cruft packs when invoked with `--cruft` and the
> `--max-pack-size` flag. Cruft packs are rewritten until they reach some
> size threshold, at which point they are considered "frozen", and will
> only be modified in a pruning GC, or if the threshold itself is
> adjusted.
>
> However, this process breaks down when we attempt to freshen an object
> packed in an earlier cruft pack that is larger than the threshold and
> thus will survive the repack.

...packed in an earlier cruft pack, and that cruft pack is larger than
the threshold...

(Otherwise, it's unclear whether you are talking about the object or
the cruft pack it is in being larger than the threshold.)

> When this is the case, it is impossible to freshen objects in cruft
> pack(s) which are larger than the threshold. This is because we avoid
> writing them in the new cruft pack entirely, for a couple of reasons.

...freshen objects in cruft packs when those cruft packs are larger
than the threshold...

Again, just to clarify what thing is "larger".

Also, this paragraph while fine on its own is slightly unclear whether
you are discussing pre-patch or post-patch state, which when reading
the next two items causes some double takes.  Perhaps just spell it
out slightly clearer here that for the next two enumerated items you
are discussing the existing state previous to your changes?

>  1. When enumerating packed objects via 'add_objects_in_unpacked_packs()'
>     we pass the SKIP_IN_CORE_KEPT_PACKS, which is used to avoid looping
>     over the packs we're going to retain (which are marked as kept
>     in-core by 'read_cruft_objects()').
>
>     This means that we will avoid enumerating additional packed copies
>     of objects found in any cruft packs which are larger than the given
>     size threshold. Thus there is no opportunity to call
>     'create_object_entry()' whatsoever.
>
>  2. We likewise will discard the loose copy (if one exists) of any
>     unreachable object packed in a cruft pack that is larger than the
>     threshold. Here our call path is 'add_unreachable_loose_objects()',
>     which uses the 'add_loose_object()' callback.
>
>     That function will eventually land us in 'want_object_in_pack()'
>     (via 'add_cruft_object_entry()'), and we'll discard the object as it
>     appears in one of the packs which we marked as kept in-core.
>
> This means in effect that it is impossible to freshen an unreachable
> object once it appears in a cruft pack larger than the given threshold.
>
> Instead,

...it does become clear here that the above was about the previous
state rather than the new state after the patches, but that's a while
to leave the possible confusion dangling.

> we should pack an additional copy of an unreachable object we
> want to freshen even if it appears in a cruft pack, provided that the
> cruft copy has an mtime which is before the mtime of the copy we are
> trying to pack/freshen. This is sub-optimal in the sense that it
> requires keeping an additional copy of unreachable objects upon
> freshening, but we don't have a better alternative without the ability
> to make in-place modifications to existing *.mtimes files.
>
> In order to implement this, we have to adjust the behavior of
> 'want_found_object()'. When 'pack-objects' is told that we're *not*
> going to retain any cruft packs (i.e. the set of packs marked as kept
> in-core does not contain a cruft pack), the behavior is unchanged.
>
> But when there *is* at least one cruft pack that we're holding onto, it
> is no longer sufficient to reject a copy of an object found in that
> cruft pack for that reason alone. In this case, we only want to reject a
> candidate object when copies of that object either:
>
>  - exists in a non-cruft pack that we are retaining, regardless of that
>    pack's mtime, or
>
>  - exists in a cruft pack with an mtime more recent than the copy we are
>    debating whether or not to pack, in which case freshening would be
>    redundant.

s/more recent than/at least as recent as/ ?

>
> To do this, keep track of whether or not we have any cruft packs in our
> in-core kept list with a new 'ignore_packed_keep_in_core_has_cruft'
> flag. When we end up in this new special case, we replace a call to
> 'has_object_kept_pack()' to 'want_cruft_object_mtime()', and only
> reject objects when we have a copy in an existing cruft pack with a more
> recent mtime (in which case "freshening" would be redundant).

Again, s/a more recent/at least as recent/ ?

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c  | 118 ++++++++++++++++++++++++++++++++++------
>  packfile.c              |   3 +-
>  packfile.h              |   2 +
>  t/t7704-repack-cruft.sh |  64 ++++++++++++++++++++++
>  4 files changed, 169 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 58a9b161262..79e1e6fb52b 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -206,6 +206,7 @@ static int have_non_local_packs;
>  static int incremental;
>  static int ignore_packed_keep_on_disk;
>  static int ignore_packed_keep_in_core;
> +static int ignore_packed_keep_in_core_has_cruft;
>  static int allow_ofs_delta;
>  static struct pack_idx_option pack_idx_opts;
>  static const char *base_name;
> @@ -1502,8 +1503,60 @@ static int have_duplicate_entry(const struct objec=
t_id *oid,
>         return 1;
>  }
>
> +static int want_cruft_object_mtime(struct repository *r,
> +                                  const struct object_id *oid,
> +                                  unsigned flags, uint32_t mtime)
> +{
> +       struct packed_git **cache;
> +
> +       for (cache =3D kept_pack_cache(r, flags); *cache; cache++) {
> +               struct packed_git *p =3D *cache;
> +               off_t ofs;
> +               uint32_t candidate_mtime;
> +
> +               ofs =3D find_pack_entry_one(oid, p);
> +               if (!ofs)
> +                       continue;
> +
> +               /*
> +                * We have a copy of the object 'oid' in a non-cruft
> +                * pack. We can avoid packing an additional copy
> +                * regardless of what the existing copy's mtime is since
> +                * it is outside of a cruft pack.
> +                */
> +               if (!p->is_cruft)
> +                       return 0;
> +
> +               /*
> +                * If we have a copy of the object 'oid' in a cruft
> +                * pack, then either read the cruft pack's mtime for
> +                * that object, or, if that can't be loaded, assume the
> +                * pack's mtime itself.
> +                */
> +               if (!load_pack_mtimes(p)) {
> +                       uint32_t pos;
> +                       if (offset_to_pack_pos(p, ofs, &pos) < 0)
> +                               continue;
> +                       candidate_mtime =3D nth_packed_mtime(p, pos);
> +               } else {
> +                       candidate_mtime =3D p->mtime;
> +               }
> +
> +               /*
> +                * We have a surviving copy of the object in a cruft
> +                * pack whose mtime is greater than or equal to the one
> +                * we are considering. We can thus avoid packing an
> +                * additional copy of that object.
> +                */
> +               if (mtime <=3D candidate_mtime)
> +                       return 0;

Here is where you have the logic for avoiding packing an additional
copy when the mtimes are equal, leading to my above wording
suggestions for the commit message.

> +       }
> +
> +       return -1;
> +}

Good comments making it clear what is going on in this function.


> +
>  static int want_found_object(const struct object_id *oid, int exclude,
> -                            struct packed_git *p)
> +                            struct packed_git *p, uint32_t mtime)
>  {
>         if (exclude)
>                 return 1;
> @@ -1553,12 +1606,29 @@ static int want_found_object(const struct object_=
id *oid, int exclude,
>                 if (ignore_packed_keep_in_core)
>                         flags |=3D IN_CORE_KEEP_PACKS;
>
> -               if (ignore_packed_keep_on_disk && p->pack_keep)
> -                       return 0;
> -               if (ignore_packed_keep_in_core && p->pack_keep_in_core)
> -                       return 0;
> -               if (has_object_kept_pack(p->repo, oid, flags))
> -                       return 0;
> +               /*
> +                * If the object is in a pack that we want to ignore, *an=
d* we
> +                * don't have any cruft packs that are being retained, we=
 can
> +                * abort quickly.
> +                */
> +               if (!ignore_packed_keep_in_core_has_cruft) {
> +                       if (ignore_packed_keep_on_disk && p->pack_keep)
> +                               return 0;
> +                       if (ignore_packed_keep_in_core && p->pack_keep_in=
_core)
> +                               return 0;
> +                       if (has_object_kept_pack(p->repo, oid, flags))
> +                               return 0;
> +               } else {
> +                       /*
> +                        * But if there is at least one cruft pack which
> +                        * is being kept, we only want to include the
> +                        * provided object if it has a strictly greater
> +                        * mtime than any existing cruft copy.
> +                        */
> +                       if (!want_cruft_object_mtime(p->repo, oid, flags,
> +                                                    mtime))
> +                               return 0;
> +               }
>         }

Here's the core high-level logic behind this change.

>
>         /*
> @@ -1577,7 +1647,8 @@ static int want_object_in_pack_one(struct packed_gi=
t *p,
>                                    const struct object_id *oid,
>                                    int exclude,
>                                    struct packed_git **found_pack,
> -                                  off_t *found_offset)
> +                                  off_t *found_offset,
> +                                  uint32_t found_mtime)
>  {
>         off_t offset;
>
> @@ -1593,7 +1664,7 @@ static int want_object_in_pack_one(struct packed_gi=
t *p,
>                         *found_offset =3D offset;
>                         *found_pack =3D p;
>                 }
> -               return want_found_object(oid, exclude, p);
> +               return want_found_object(oid, exclude, p, found_mtime);
>         }
>         return -1;
>  }
> @@ -1607,10 +1678,11 @@ static int want_object_in_pack_one(struct packed_=
git *p,
>   * function finds if there is any pack that has the object and returns t=
he pack
>   * and its offset in these variables.
>   */
> -static int want_object_in_pack(const struct object_id *oid,
> -                              int exclude,
> -                              struct packed_git **found_pack,
> -                              off_t *found_offset)
> +static int want_object_in_pack_mtime(const struct object_id *oid,
> +                                    int exclude,
> +                                    struct packed_git **found_pack,
> +                                    off_t *found_offset,
> +                                    uint32_t found_mtime)
>  {
>         int want;
>         struct list_head *pos;
> @@ -1625,7 +1697,8 @@ static int want_object_in_pack(const struct object_=
id *oid,
>          * are present we will determine the answer right now.
>          */
>         if (*found_pack) {
> -               want =3D want_found_object(oid, exclude, *found_pack);
> +               want =3D want_found_object(oid, exclude, *found_pack,
> +                                        found_mtime);
>                 if (want !=3D -1)
>                         return want;
>
> @@ -1636,7 +1709,7 @@ static int want_object_in_pack(const struct object_=
id *oid,
>         for (m =3D get_multi_pack_index(the_repository); m; m =3D m->next=
) {
>                 struct pack_entry e;
>                 if (fill_midx_entry(the_repository, oid, &e, m)) {
> -                       want =3D want_object_in_pack_one(e.p, oid, exclud=
e, found_pack, found_offset);
> +                       want =3D want_object_in_pack_one(e.p, oid, exclud=
e, found_pack, found_offset, found_mtime);
>                         if (want !=3D -1)
>                                 return want;
>                 }
> @@ -1644,7 +1717,7 @@ static int want_object_in_pack(const struct object_=
id *oid,
>
>         list_for_each(pos, get_packed_git_mru(the_repository)) {
>                 struct packed_git *p =3D list_entry(pos, struct packed_gi=
t, mru);
> -               want =3D want_object_in_pack_one(p, oid, exclude, found_p=
ack, found_offset);
> +               want =3D want_object_in_pack_one(p, oid, exclude, found_p=
ack, found_offset, found_mtime);
>                 if (!exclude && want > 0)
>                         list_move(&p->mru,
>                                   get_packed_git_mru(the_repository));
> @@ -1674,6 +1747,15 @@ static int want_object_in_pack(const struct object=
_id *oid,
>         return 1;
>  }
>
> +static inline int want_object_in_pack(const struct object_id *oid,
> +                                     int exclude,
> +                                     struct packed_git **found_pack,
> +                                     off_t *found_offset)
> +{
> +       return want_object_in_pack_mtime(oid, exclude, found_pack, found_=
offset,
> +                                        0);
> +}
> +
>  static struct object_entry *create_object_entry(const struct object_id *=
oid,
>                                                 enum object_type type,
>                                                 uint32_t hash,
> @@ -3606,7 +3688,7 @@ static void add_cruft_object_entry(const struct obj=
ect_id *oid, enum object_type
>                         entry->no_try_delta =3D no_try_delta(name);
>                 }
>         } else {
> -               if (!want_object_in_pack(oid, 0, &pack, &offset))
> +               if (!want_object_in_pack_mtime(oid, 0, &pack, &offset, mt=
ime))

Stuff since my last comment was plumbing the extra parameter through
the right places; makes sense.

>                         return;
>                 if (!pack && type =3D=3D OBJ_BLOB && !has_loose_object(oi=
d)) {
>                         /*
> @@ -3680,6 +3762,8 @@ static void mark_pack_kept_in_core(struct string_li=
st *packs, unsigned keep)
>                 struct packed_git *p =3D item->util;
>                 if (!p)
>                         die(_("could not find pack '%s'"), item->string);
> +               if (p->is_cruft && keep)
> +                       ignore_packed_keep_in_core_has_cruft =3D 1;

And here you set the necessary flag for enabling it all.

>                 p->pack_keep_in_core =3D keep;
>         }
>  }
> diff --git a/packfile.c b/packfile.c
> index 2d80d80cb38..9d09f8bc726 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -24,6 +24,7 @@
>  #include "commit-graph.h"
>  #include "pack-revindex.h"
>  #include "promisor-remote.h"
> +#include "pack-mtimes.h"
>
>  char *odb_pack_name(struct repository *r, struct strbuf *buf,
>                     const unsigned char *hash, const char *ext)
> @@ -2107,7 +2108,7 @@ static void maybe_invalidate_kept_pack_cache(struct=
 repository *r,
>         r->objects->kept_pack_cache.flags =3D 0;
>  }
>
> -static struct packed_git **kept_pack_cache(struct repository *r, unsigne=
d flags)
> +struct packed_git **kept_pack_cache(struct repository *r, unsigned flags=
)
>  {
>         maybe_invalidate_kept_pack_cache(r, flags);
>
> diff --git a/packfile.h b/packfile.h
> index 00ada7a938f..25097213d06 100644
> --- a/packfile.h
> +++ b/packfile.h
> @@ -197,6 +197,8 @@ int has_object_pack(struct repository *r, const struc=
t object_id *oid);
>  int has_object_kept_pack(struct repository *r, const struct object_id *o=
id,
>                          unsigned flags);
>
> +struct packed_git **kept_pack_cache(struct repository *r, unsigned flags=
);
> +
>  /*
>   * Return 1 if an object in a promisor packfile is or refers to the give=
n
>   * object, 0 otherwise.

You need access to one more function to do your work; makes sense.

> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index 5a76b541ddd..2b20d66333c 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -262,6 +262,70 @@ test_expect_success '--max-cruft-size with freshened=
 objects (packed)' '
>         )
>  '
>
> +test_expect_success '--max-cruft-size with freshened objects (previously=
 cruft)' '
> +       git init max-cruft-size-threshold &&
> +       (
> +               cd max-cruft-size-threshold &&
> +
> +               test_commit base &&
> +               foo=3D"$(generate_random_blob foo $((2*1024*1024)))" &&
> +               bar=3D"$(generate_random_blob bar $((2*1024*1024)))" &&
> +               baz=3D"$(generate_random_blob baz $((2*1024*1024)))" &&
> +
> +               test-tool chmtime --get -100000 \
> +                       "$objdir/$(test_oid_to_path "$foo")" >foo.old &&
> +               test-tool chmtime --get -100000 \
> +                       "$objdir/$(test_oid_to_path "$bar")" >bar.old &&
> +               test-tool chmtime --get -100000 \
> +                       "$objdir/$(test_oid_to_path "$baz")" >baz.old &&
> +
> +               git repack --cruft -d &&
> +
> +               # Make a packed copy of object $foo with a more recent
> +               # mtime.

s/$foo/foo/ ?

> +               foo=3D"$(generate_random_blob foo $((2*1024*1024)))" &&

I thought this was creating a completely different foo, which would
defeat the point of the test.  It might be worth adding a comment that
because generate_random_blob uses a very simplistic and repeatable
random character generator with the first argument as the seed, that
this will regenerate the same loose object as above for foo.

> +               foo_pack=3D"$(echo "$foo" | git pack-objects $packdir/pac=
k)" &&
> +               test-tool chmtime --get -100 \
> +                       "$packdir/pack-$foo_pack.pack" >foo.new &&
> +               git prune-packed &&
> +
> +               # Make a loose copy of object $bar with a more recent
> +               # mtime.

s/$bar/bar/ ?

> +               bar=3D"$(generate_random_blob bar $((2*1024*1024)))" &&

Likewise, this isn't a different bar than above because it uses the
same seed, "bar" that the previous one used.

> +               test-tool chmtime --get -100 \
> +                       "$objdir/$(test_oid_to_path "$bar")" >bar.new &&
> +
> +               # Make a new cruft object $quux to ensure we do not
> +               # generate an identical pack to the existing cruft
> +               # pack.
> +               quux=3D"$(generate_random_blob quux $((1024)))" &&
> +               test-tool chmtime --get -100 \
> +                       "$objdir/$(test_oid_to_path "$quux")" >quux.new &=
&
> +
> +               git repack --cruft --max-cruft-size=3D3M -d &&
> +
> +               for p in $packdir/pack-*.mtimes
> +               do
> +                       test-tool pack-mtimes "$(basename "$p")" || retur=
n 1
> +               done >actual.raw &&
> +               sort actual.raw >actual &&
> +
> +               # Among the set of all cruft packs, we should see both
> +               # mtimes for object $foo and $bar, as well as the
> +               # single new copy of $baz.
> +               sort >expect <<-EOF &&
> +               $foo $(cat foo.old)
> +               $foo $(cat foo.new)
> +               $bar $(cat bar.old)
> +               $bar $(cat bar.new)
> +               $baz $(cat baz.old)
> +               $quux $(cat quux.new)
> +               EOF

Makes sense, but only once you understand that the second foo and bar
objects really were the same objects as the first foo and bar objects.
