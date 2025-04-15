Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FD62DFA41
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 03:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744686650; cv=none; b=cRN7ZKgsI65eCpGBcIW9PdgLZ8eykymeNWT24Hm9mV9zkLiiZRMHp0NtkZE1SrwykfkTM6JcAe+Kq1eTQu2AnvdM09YZt3Ewz/m4gkK9aXb88P0zV4E+CdLXm6ZQUm+Vj6X1WgmuJww6jI0fu+RynliHtJi3xvDnQDj1sWYxTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744686650; c=relaxed/simple;
	bh=xAYrLuNv0R//QBDnm94A1sfWUNl+75MNgu1tK01nsP8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNSbTfvcUMPCp9bwx7o/kYWXR9Ss5rXW1qloriCkyb4m7EZrPYlB4aYqVkgfoYriRYHhASnq4qLBdLbqouw71mpERZiF3fY7FEhgGAIeL89PdJzIL/iopi8EyjMmaf6ddr4pJHtSgOB82XPJb0Jrf00Gd3q0xvjSWfrS/EO3MAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZyRt+c5; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZyRt+c5"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d5e2606a1bso44031005ab.0
        for <git@vger.kernel.org>; Mon, 14 Apr 2025 20:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744686648; x=1745291448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=05L7Jnccey2+k6gcQifwe9jYR9p0gPfLLmE+M12+A6o=;
        b=LZyRt+c5Pct4Bm138Zj9518s/Ocop2XIrA0Y+pSJ+lfQulefZZ/NjgWRp1Ca2RQ4MY
         88dnVW6qjXGdT3pF7DLeCujT9fsigvXrz4yqYB0GsU7yFX8fB3O6NU4JL16DDZYfI9KQ
         jKfp9ZrHLqOGv6xpegRjp06D/RbsFysSYaTDCnVboMvgRNN493TlgdcvxjbLEuXkq57l
         QPnKRAxmuLRumnceARCTu/AiJxVN6G1kPGsde45xV8dzJLB7v/SHTFXWM6A1Q5V95/lh
         XDDhj8rMjMMDJQADX0rWzopl7pcj4xTukZ7FC+0HHlX/kqmGhC19ta9b8BKZBik39F55
         q++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744686648; x=1745291448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05L7Jnccey2+k6gcQifwe9jYR9p0gPfLLmE+M12+A6o=;
        b=clDdbn2pXeMCfkirDai6ol8tbmCH0jpNq5qgCRQ/DNMIe/DW8jvziQIMci0V96MCVo
         XYk4DQn6Myced0lOofG18jnqejdytZBfThBBMAF+YkakW0QuhxQ1j6PojeOz3ltd2sct
         6GN9js23bmsXqM2XN+K8hRWmLYrNzW22cY+7erQkd8kvDLOznfS4/S3TLstZBlm5/g5F
         L/HJniALlSUjG2ZkxjaOZT2v5EXmjgiV9AXVHo/6ONIxBNO/OMtluAXRJWs4b7qv+iZO
         9XdcTE7KaP9BcBUabmKTk5+dXe6UZ4kXfTZT9FnkQdZUdVYx72lNyr1KfOhmRU8BszNO
         73Aw==
X-Gm-Message-State: AOJu0YxYm3rHJ0Cl57qlg+lyJwTbcQ1bOK1ocCFO8mDzonRo1pSfYntB
	9oEL7vcfk1f8aYUOSi/VHM9+kZ7SJ5n7ayCS4H/F0m70/EBe4IumdcdrFhZaPnY9FOoYY/6z09g
	0ThNvRwI+B2MOJac6uCtI2uoJDCcWcBy2
X-Gm-Gg: ASbGnctQX2Xtm07ruqCrWxKbYC2drVhGPAujNWtzt8dE90j8XMBqolDvrg/ug9WpZRi
	HMh7Zt7yN2+Er5D70AEjMfBpagpOH/pDaT4HBBylUdLLykAd8xhF2CB4wflcDbB58OJmEsbNYIl
	lggZHGly2BYuQ9zi/YYBcmp7vFVqLTZjmUoDb+PiSY51r6ybAOrsR6mS0=
X-Google-Smtp-Source: AGHT+IEqJOkxhQzkFeAmyhs2a6hnxBx4O7d07BXTB56K+mVZkMbosxq1GrIVw4t0tCvq7PU2zJaGXMADez0sgU5QHNU=
X-Received: by 2002:a05:6e02:2165:b0:3d3:d28e:eae9 with SMTP id
 e9e14a558f8ab-3d7ec201fa6mr159357955ab.7.1744686648267; Mon, 14 Apr 2025
 20:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744413969.git.me@ttaylorr.com> <cover.1744661167.git.me@ttaylorr.com>
 <f8ac36b110b91ff3723f5049cfc6bf9f624521bd.1744661167.git.me@ttaylorr.com>
In-Reply-To: <f8ac36b110b91ff3723f5049cfc6bf9f624521bd.1744661167.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 14 Apr 2025 20:10:37 -0700
X-Gm-Features: ATxdqUEtC2wzWJOc2u1Txaq7dPphrwZfTXJCGtEZFajQawqfzzWCw22A8jIzFVo
Message-ID: <CABPp-BGDgMBE4zJqaeL=m=MwQQ4_1r=kdC69Dg7nErSuz3N7qw@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] pack-objects: limit scope in 'add_object_entry_from_pack()'
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 14, 2025 at 1:06=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> add_object_entry_from_pack() handles objects from identified packs by
> checking their type, before adding commit objects as pending in the
> subsequent traversal used by `--stdin-packs`.
>
> There are a couple of quality-of-life refactorings that I noticed while
> working in this area:
>
>   - We declare 'revs' (given to us through the miscellaneous context
>     argument) earlier in the "if (p)" conditional than is necessary.

Fair enough.

>   - The 'struct object_info' can use a designated initializer to fill in
>     the structures type pointer, since that is the only field that we
>     care about.

I prefer the original; it's more future-proof against someone making
OBJECT_INFO_INIT be something other than an all-zero initializer.

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/pack-objects.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index aaea968ed2..540e5eba9e 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3490,14 +3490,12 @@ static int add_object_entry_from_pack(const struc=
t object_id *oid,
>                 return 0;
>
>         if (p) {
> -               struct rev_info *revs =3D _data;
> -               struct object_info oi =3D OBJECT_INFO_INIT;
> -
> -               oi.typep =3D &type;
> +               struct object_info oi =3D { .typep =3D &type };
>                 if (packed_object_info(the_repository, p, ofs, &oi) < 0) =
{
>                         die(_("could not get type of object %s in pack %s=
"),
>                             oid_to_hex(oid), p->pack_name);
>                 } else if (type =3D=3D OBJ_COMMIT) {
> +                       struct rev_info *revs =3D _data;
>                         /*
>                          * commits in included packs are used as starting=
 points for the
>                          * subsequent revision walk
> --
> 2.49.0.229.gc267761125.dirty
