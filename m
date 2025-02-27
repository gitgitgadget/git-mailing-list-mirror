Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EB826E65E
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684196; cv=none; b=ETNif/i8OBxtJp603ecMaVwbCp1wHW7/LgDHG9Pbszv6Fe33mS9dmGpS2Y4FYUqui3ss/N7kf4Y+aKlwdHKzWRp7aLx1RC63W9zPhaY9HoC56v5Qi7xrWw80xI0FZ+7gPU6U4amrbtj0nCiPVyp7287oMN5W/dDtWN6FvW5FV5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684196; c=relaxed/simple;
	bh=vzQb6WESrmUJadVJpdl2H7DW7+VzsvjwT4vv4H/rSi4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GLj0vlgmISzrfYItOsblqhvv5fn448jFBBYilfPrnCq9aOhdaiwE7BfW6FpfAI+AwuZJb0TtwHZ7vOi9WEaNMUFPInOyQsmxoRgGp+23WJFo6di68jvImMswNvcF287KyW/B33IORYbYaaqqSbwowXmudGgt1rq+DMWrELjC/Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD8KJUwa; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD8KJUwa"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855b09fca35so91877339f.3
        for <git@vger.kernel.org>; Thu, 27 Feb 2025 11:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740684194; x=1741288994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lml0Hs3PeknU+HgTuN9qZCE3mwn4z+jaStZ2CapxM1g=;
        b=dD8KJUwadA2jHsB0+29tnlSjYj5183Grw7v/UHy3hqlPbzdSv2ha9c4A4F2WMI3A9D
         8InhdM+/Q1uYFhWemW5uSn13uZDsI1MXKVpujySLzsWlJh4VcGF33svpKELrWAPt9aMi
         /cB9EVZDK1FpCtCpCS3UMy9l4LuSkTagSdE3mLZMVP960F6Z8/H9KtSTisgsjmO2TOqG
         J06dKLhIWq+0tTSOKHoq2PkAIQ9+ihtxw+AdmsLJsp3Omze7oD1v3WkVWHkXbbFtrPKY
         qfk901q2YXZrPZFQNOYLOn1fN7OebrPuypiUoBmFdT2VhRJDinHL5cZgZM1Ogww6me+u
         oQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740684194; x=1741288994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lml0Hs3PeknU+HgTuN9qZCE3mwn4z+jaStZ2CapxM1g=;
        b=nKQVpnaSiCTrWYl5f2JadcnSl6ZPCC6wevSeol+qi/b1U7GEprRFTABa04BtHMRK91
         hhFXZ3GR3RbxsvNzvZjHcUmv3qHFeuizucF5Fo4UkxuEm+af9Ylrh3XPuRvywfvLTzNT
         1v6+HnMKxz5ukphYnBvguVZbq/dFpeyLl8T4lERFhJmIdlK1U7RLQtVSuFSGP95aXGTg
         KB+MINVc0KG2TTTEWSkWsk5jA4KHJz+Xg4gdu5aJIVXZ3Hqv464mHlDQwIgp5AwJt9rR
         Rx0c5KeRJNeB2qBePoea32KRkc8z/z9R4EFEtLWqpoL9rX0x9a/daGG/WfQUu/rS+kqi
         EJLA==
X-Gm-Message-State: AOJu0Yzkw8odN/O87o0UkUQR8UwnZqL4UgAV4YVLvy8TUuemNco2mhHX
	J8RiT7UCCbceUNenZGWyTt3ISID6B9/u/uPbgKHMszakl6R5brR1yxkcgXPXdtZHWX5N0vcF8GP
	AtWZ4hCdqsEM9Umxs85o9xdL0hDxjcA==
X-Gm-Gg: ASbGncsIfjgI3y/VBnXtVJU5cyA9z6Dy1Aqmye3girsZZKOxszbMHe6RPIzx0bKlZBM
	A6LZ0hndJWSQhu8lt80eGnhGFtqs7VOhR59FubzFujCN2vYkp8w9bo9YB3qPJ6qRWuhLmtquFcW
	TbhD/KclFMU+B1YGZAdntpqRTV0o2+C1AVKNAN1QCX
X-Google-Smtp-Source: AGHT+IHEbbRgQTWfPNyP06hq2Ef9F7gBVUhHxVNRw82bZGC2FsnzSqBsMGqUMoaR5bsRhp4d4/I3/kI0LwbTZfSSIno=
X-Received: by 2002:a05:6602:1643:b0:855:9c88:78a0 with SMTP id
 ca18e2360f4ac-85881f9fb05mr22456739f.9.1740684194082; Thu, 27 Feb 2025
 11:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740680964.git.me@ttaylorr.com> <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
In-Reply-To: <8564f98259727225391edcb5ab3b47dd53f00e48.1740680964.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Feb 2025 11:23:02 -0800
X-Gm-Features: AQ5f1JqAjI2y85QG0JH8vtmhbdClLZIMuB4AwQjeiAq9xDebpI5fVVBkXqGIzgg
Message-ID: <CABPp-BE9=WUv1typWB7JB4HvP04Q_Bh6h23D=LzcpsAsggQ+7A@mail.gmail.com>
Subject: Re: [PATCH 1/2] builtin/repack.c: simplify cruft pack aggregation
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 10:29=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> In 37dc6d8104 (builtin/repack.c: implement support for
> `--max-cruft-size`, 2023-10-02), 'git repack' built on support for
> multiple cruft packs in Git by instructing 'git pack-objects --cruft'
> how to aggregate smaller cruft packs up to the provided threshold.
>
> The implementation in 37dc6d8104 worked something like the following
> pseudo-code:
>
>     total_size =3D 0;
>
>     for (p in cruft packs) {
>       if (p->pack_size + total_size < max_size) {
>         total_size +=3D p->pack_size;
>         collapse(p)
>       } else {
>         retain(p);
>       }
>     }
>
> The original idea behind this approach was that smaller cruft packs
> would get combined together until the sum of their sizes was no larger
> than the given max pack size.
>
> There is a much simpler way to achieve this, however, which is to simply
> combine *all* cruft packs which are smaller than the threshold,
> regardless of what their sum is. With '--max-pack-size', 'pack-objects'
> will split out the resulting pack into individual pack(s) if necessary
> to ensure that the written pack(s) are each no larger than the provided
> threshold.

That doesn't really "achieve this" though, unless the antecedent of
"this" isn't what was described in the previous paragraph but
something elsewhere.  I suspect your actual meaning was something
along the lines of "There is a much simpler way to combine cruft
packs, however, which..." ?

> This yields a slight behavior change, which is reflected in the removed
> test. Previous to this change, we would aggregate smaller cruft packs
> first, whereas now we will opportunistically combine as many cruft packs
> as possible. As as result, that test is no longer relevant, and can be
> deleted.

I like the idea, since it sounds like it should be simpler...

> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c        | 38 ++-----------------------------------
>  t/t7704-repack-cruft.sh | 42 -----------------------------------------
>  2 files changed, 2 insertions(+), 78 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 75e3752353a..4d83d40f39f 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -1022,29 +1022,13 @@ static int write_filtered_pack(const struct pack_=
objects_args *args,
>         return finish_pack_objects_cmd(&cmd, names, local);
>  }
>
> -static int existing_cruft_pack_cmp(const void *va, const void *vb)
> -{
> -       struct packed_git *a =3D *(struct packed_git **)va;
> -       struct packed_git *b =3D *(struct packed_git **)vb;
> -
> -       if (a->pack_size < b->pack_size)
> -               return -1;
> -       if (a->pack_size > b->pack_size)
> -               return 1;
> -       return 0;
> -}
> -
>  static void collapse_small_cruft_packs(FILE *in, size_t max_size,
>                                        struct existing_packs *existing)
>  {
> -       struct packed_git **existing_cruft, *p;
> +       struct packed_git *p;
>         struct strbuf buf =3D STRBUF_INIT;
> -       size_t total_size =3D 0;
> -       size_t existing_cruft_nr =3D 0;
>         size_t i;
>
> -       ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
> -
>         for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
>                 if (!(p->is_cruft && p->pack_local))
>                         continue;
> @@ -1056,24 +1040,7 @@ static void collapse_small_cruft_packs(FILE *in, s=
ize_t max_size,
>                 if (!string_list_has_string(&existing->cruft_packs, buf.b=
uf))
>                         continue;
>
> -               if (existing_cruft_nr >=3D existing->cruft_packs.nr)
> -                       BUG("too many cruft packs (found %"PRIuMAX", but =
knew "
> -                           "of %"PRIuMAX")",
> -                           (uintmax_t)existing_cruft_nr + 1,
> -                           (uintmax_t)existing->cruft_packs.nr);
> -               existing_cruft[existing_cruft_nr++] =3D p;
> -       }
> -
> -       QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp)=
;
> -
> -       for (i =3D 0; i < existing_cruft_nr; i++) {
> -               size_t proposed;
> -
> -               p =3D existing_cruft[i];
> -               proposed =3D st_add(total_size, p->pack_size);
> -
> -               if (proposed <=3D max_size) {
> -                       total_size =3D proposed;
> +               if (p->pack_size < max_size) {

Look at all that deleted code.  Always nice to see a simplification in
action.  :-)

>                         fprintf(in, "-%s\n", pack_basename(p));
>                 } else {
>                         retain_cruft_pack(existing, p);
> @@ -1086,7 +1053,6 @@ static void collapse_small_cruft_packs(FILE *in, si=
ze_t max_size,
>                         existing->non_kept_packs.items[i].string);
>
>         strbuf_release(&buf);
> -       free(existing_cruft);
>  }
>
>  static int write_cruft_pack(const struct pack_objects_args *args,
> diff --git a/t/t7704-repack-cruft.sh b/t/t7704-repack-cruft.sh
> index 959e6e26488..5a76b541ddd 100755
> --- a/t/t7704-repack-cruft.sh
> +++ b/t/t7704-repack-cruft.sh
> @@ -194,48 +194,6 @@ test_expect_success '--max-cruft-size combines exist=
ing packs when below thresho
>         )
>  '
>
> -test_expect_success '--max-cruft-size combines smaller packs first' '
> -       git init max-cruft-size-consume-small &&
> -       (
> -               cd max-cruft-size-consume-small &&
> -
> -               test_commit base &&
> -               git repack -ad &&
> -
> -               cruft_foo=3D"$(generate_cruft_pack foo 524288)" &&    # 0=
.5 MiB
> -               cruft_bar=3D"$(generate_cruft_pack bar 524288)" &&    # 0=
.5 MiB
> -               cruft_baz=3D"$(generate_cruft_pack baz 1048576)" &&   # 1=
.0 MiB
> -               cruft_quux=3D"$(generate_cruft_pack quux 1572864)" && # 1=
.5 MiB
> -
> -               test-tool pack-mtimes "$(basename $cruft_foo)" >expect.ra=
w &&
> -               test-tool pack-mtimes "$(basename $cruft_bar)" >>expect.r=
aw &&
> -               sort expect.raw >expect.objects &&
> -
> -               # repacking with `--max-cruft-size=3D2M` should combine
> -               # both 0.5 MiB packs together, instead of, say, one of
> -               # the 0.5 MiB packs with the 1.0 MiB pack
> -               ls $packdir/pack-*.mtimes | sort >cruft.before &&
> -               git repack -d --cruft --max-cruft-size=3D2M &&
> -               ls $packdir/pack-*.mtimes | sort >cruft.after &&
> -
> -               comm -13 cruft.before cruft.after >cruft.new &&
> -               comm -23 cruft.before cruft.after >cruft.removed &&
> -
> -               test_line_count =3D 1 cruft.new &&
> -               test_line_count =3D 2 cruft.removed &&
> -
> -               # the two smaller packs should be rolled up first
> -               printf "%s\n" $cruft_foo $cruft_bar | sort >expect.remove=
d &&
> -               test_cmp expect.removed cruft.removed &&
> -
> -               # ...and contain the set of objects rolled up
> -               test-tool pack-mtimes "$(basename $(cat cruft.new))" >act=
ual.raw &&
> -               sort actual.raw >actual.objects &&
> -
> -               test_cmp expect.objects actual.objects
> -       )
> -'
> -
>  test_expect_success 'setup --max-cruft-size with freshened objects' '
>         git init max-cruft-size-freshen &&
>         (
> --
> 2.49.0.rc0.2.gc0c926adde2

Looks good to me, other than the misleading/ambiguous wording in that
one paragraph of the commit message.
