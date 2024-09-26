Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CECB14AD17
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 22:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727390874; cv=none; b=I0nFrM5I6ViGfHEg0G+yn8aOQlHOWKK3DuK8s6R96q3rX6mGRqthhJ3nWhdkIEzdDn5/IqfAsJyQhLTQZdQaNgodhh1p4lrm8UHR94miadl5QWyZR4mlZuuaBAlae+GWfMMhKVtz+yUdUZ8Wh8AwFneFY8GBxHvlDXi3oyUTnRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727390874; c=relaxed/simple;
	bh=QjvOVzPiRIFddk+Ua90o+TyHjVfbqViKX9gJ3g7GVio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCtd9jsVnXIXI1cBt4tbhIxcBMiqhf8KaSIGthCitr+Yah62G0ibobUUjTx0+qR3iz5AbnfiXEMuc0xDoSMdeXNibmKyKNnc7NpSLpmfP6/DTy3d5x5/OraYs0jRPDPczTpJRjhSasNg30kzTgvbArzrDCwWJF0W9SxBSaxhBRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8lMyhh+; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8lMyhh+"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-8349389f9b8so14254539f.0
        for <git@vger.kernel.org>; Thu, 26 Sep 2024 15:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727390872; x=1727995672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuvQVa+5Ab10A8NtCxHEy7L/579qLZAT/ea5KUgv9Xs=;
        b=g8lMyhh+2BBhW9P7UQWmhZz5DiMb2tems+w8HJpYoME0ZqUXY9pXfQKacXU5gSSADo
         XcxXKFQFK9EUYOFec+++SlWvqobFVO3DbkIuHWvggqiFb1iJTL6iOuPA8AMycT4w7XMm
         JEvqY1TazWYdD3waNCmogIjp75wuSE5ngsT0nf0ggu0eHUAqlrslPIoDq0WNWQyOSH/n
         kRnJySnFEnAHakb/ZwvKXbLQVlQIzjtGoIydaoqkR4WdVsmkZ9QQi9d3T5wJBLbcrubd
         xGwqrzcXIJuUxw9AAABrQQHfXPgXEYaGZJTdeQF7UDR6QxZRr7ozDetJUXwgY9rV7TnC
         TCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727390872; x=1727995672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuvQVa+5Ab10A8NtCxHEy7L/579qLZAT/ea5KUgv9Xs=;
        b=A/ZrtwXpz7c18XnG8f2a8bz62DkksD+KOeSm3GU6mYtJ1QL5PLGticArpb83vp52EH
         s+NZXx7PlnoSgHKu7V1bwzpSsvQSXF6+hHfTO+gdKsjnIkU/blthtqxPDyfLQlGPohjv
         hI5dkVWyEw6fJxlMWSyDCH8pqCFFk60FMRigB2MULEX0yfMYl5DXJpM8h1u/wTclkhKT
         m9FUrOtfKpZw/hYYqvCLTdVpVymq+hBKhedb4in8WJQtKt8kRtrQYi+1/csLEtnwGq5+
         n2XV396vAemvQia9ci+3JH0OM1yPJjSCM2KRFu2aeCQQOEmsO7MxXkSREBq/uzwz6uIL
         71EQ==
X-Gm-Message-State: AOJu0YyWjNCEmoBsCqk56gzNI3MomIYMtnS4xhMotfrnCx5HghEyNC/w
	0zMjOU8cG2dAdQ0vCEgiXBd4Dwi1MbacedTzqbyLtjik3FQmmkTUp7ai1bXCdSvhvdcRFWUjQGD
	y4a/7MyGqJUO7rHCnWj8iNvj9dEI=
X-Google-Smtp-Source: AGHT+IH4ZVepR29q+BVNtD9rLVuDHRUbpJ6DD9xzXH6EloFjUT2INYZXoIq52GI91AXaaeFvNIlCDW3r8YV14+xE7PI=
X-Received: by 2002:a05:6602:15c5:b0:82d:38d:1362 with SMTP id
 ca18e2360f4ac-834930db098mr145018839f.0.1727390871937; Thu, 26 Sep 2024
 15:47:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1725206584.git.me@ttaylorr.com> <cover.1727364141.git.me@ttaylorr.com>
In-Reply-To: <cover.1727364141.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 26 Sep 2024 15:47:40 -0700
Message-ID: <CABPp-BH3y96DjapzLPJ+vCoChQiD_wR9uLc3QPsXqzSUr4AFvQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi...

On Thu, Sep 26, 2024 at 8:22=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
...
> I think most of the review dust has settled up to this point, so I'm
> imagining that this is the final version of this series for now, or at
> least very close to it. But if something new comes up, please let me
> know!
>
...
> Range-diff against v4:
> -:  ---------- > 1:  6f1ee91fff finalize_object_file(): check for name co=
llision before renaming
> -:  ---------- > 2:  133047ca8c finalize_object_file(): refactor unlink_o=
r_warn() placement
> 1:  ed9eeef851 ! 3:  41d38352a4 finalize_object_file(): implement collisi=
on check
>     @@ Commit message
>              object name, so checking for collisions at the content level=
 doesn't
>              add anything.
>
>     -        This is why we do not bother to check the inflated object co=
ntents
>     -        for collisions either, since either (a) the object contents =
have the
>     -        fingerprint of a SHA-1 collision, in which case the collisio=
n
>     -        detecting SHA-1 implementation used to hash the contents to =
give us
>     -        a path would have already rejected it, or (b) the contents a=
re part
>     -        of a colliding pair which does not bear the same fingerprint=
s of
>     -        known collision attacks, in which case we would not have cau=
ght it
>     -        anyway.
>     +        Adding a content-level collision check would have to happen =
at a
>     +        higher level than in finalize_object_file(), since (avoiding=
 race
>     +        conditions) writing an object loose which already exists in =
the
>     +        repository will prevent us from even reaching finalize_objec=
t_file()
>     +        via the object freshening code.
>     +
>     +        There is a collision check in index-pack via its `check_coll=
ision()`
>     +        function, but there isn't an analogous function in unpack-ob=
jects,
>     +        which just feeds the result to write_object_file().
>
>              So skipping the collision check here does not change for bet=
ter or
>              worse the hardness of loose object writes.
>     @@ Commit message
>
>          Co-authored-by: Jeff King <peff@peff.net>
>          Signed-off-by: Jeff King <peff@peff.net>
>     +    Helped-by: Elijah Newren <newren@gmail.com>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>       ## object-file.c ##
> 2:  3cc7f7b1f6 =3D 4:  611475d83e pack-objects: use finalize_object_file(=
) to rename pack/idx/etc
> 3:  8f8ac0f5b0 =3D 5:  9913a5d971 sha1: do not redefine `platform_SHA_CTX=
` and friends
> 4:  d300e9c688 =3D 6:  65de6d724d hash.h: scaffolding for _unsafe hashing=
 variants
> 5:  af8fd9aa4e =3D 7:  3884cd0e3a Makefile: allow specifying a SHA-1 for =
non-cryptographic uses
> 6:  4b83dd05e9 ! 8:  62abddf73d csum-file.c: use unsafe SHA-1 implementat=
ion when available
>     @@ Commit message
>
>          These callers only use the_hash_algo to produce a checksum, whic=
h we
>          depend on for data integrity, but not for cryptographic purposes=
, so
>     -    these callers are safe to use the unsafe (and potentially non-co=
llision
>     -    detecting) SHA-1 implementation.
>     +    these callers are safe to use the unsafe (non-collision detectin=
g) SHA-1
>     +    implementation.
>
>          To time this, I took a freshly packed copy of linux.git, and ran=
 the
>          following with and without the OPENSSL_SHA1_UNSAFE=3D1 build-kno=
b. Both
>     @@ Commit message
>              $ callgrind_annotate --inclusive=3Dyes | grep hashwrite | he=
ad -n1
>               59,164,001,176 (58.79%)  /home/ttaylorr/src/git/csum-file.c=
:hashwrite [/home/ttaylorr/src/git/git-pack-objects]
>
>     -    , and generate the resulting "clone" much unsafeer, in only 11.5=
97 seconds
>     +    , and generate the resulting "clone" much faster, in only 11.597=
 seconds
>          of wall time, 11.37 seconds of user time, and 0.23 seconds of sy=
stem
>          time, for a ~40% speed-up.

This round looks good to me.
