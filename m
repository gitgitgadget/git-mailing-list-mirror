Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF82673A8
	for <git@vger.kernel.org>; Wed,  9 Apr 2025 14:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744209429; cv=none; b=hDInVdsRtxo06zO5L1WWpW9mgpEp27bjdOq9Iflqf4CH4dEqdMWrc6V2p8i/hcGkTUg90eLtLr1vAKy2HoahOO61ikHHh6SDiol3ZD7E5pRiYlhtEpbnNb0zGacJzKGajDdsaucYV5W+Lk7mW3o31vW2Yf+AwegLMIr03isz1Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744209429; c=relaxed/simple;
	bh=E3l7BXDoDwkL3Jyky/fWpnGh+gsEssP1Kdjf3qZhrH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h9lZ5+72yHYYtVIQPNyY4j+2gIx5cIkWJylE95Aej1JQTgSXIHdzV7bd5/Ioz6MbvHRMK7f0VISwHMFu0U8Z86/RamENEeTZbhGHdc22+NpGUFajBOJemVpN/BuFfoL9VR7uG9y7TizuQA9wjXPZvgPEOX+SF64blTKaj2ldfqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V6jgUVS4; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6jgUVS4"
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-85dac9729c3so447616239f.2
        for <git@vger.kernel.org>; Wed, 09 Apr 2025 07:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744209426; x=1744814226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MLxUsaZTdJ0vl+NpHVYl7VsEGlwEsshSjfaOqc5JqQo=;
        b=V6jgUVS4vfZDFuV6Zho6RwUihZT6yudbCKir5j5Oy8JFxr1Oy2IkMCFOoAG9bfEGgb
         jZYufAcsDnz8DuiLtF7TAJiAtw8gj/jSvTcGn4o2gli+CHnTGHkwxTBICR75uBAoRKDH
         F152mGWGgf/TW52uZMcf23+AjhsN7y2h8hoK4Z3s2Wa8o4ZVVRQHo30jQcbok9HzePKR
         x4NKIpINU38d/Ct5fu6hewYbX6kZ+D1BV1ew5WFkW8ORQgP/R3BWFvM31muJgwwOJUFF
         gFu3wdcqUS08/pqgGE9ELU3RBYUYks/rhLij9irS3npds3l8sMtvbYLy+Lx2XsV5hMRv
         JoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744209426; x=1744814226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MLxUsaZTdJ0vl+NpHVYl7VsEGlwEsshSjfaOqc5JqQo=;
        b=kLTyhga+fasJ/LgMYYuVDf+ONXdLdxlJfvNNjhC1QpAExTIBJxZCLHu4zOTna+JfBW
         7D95tR2+B2Ib6vCLkOFHj9BaJRoUomXkzmbYFHzQElsBWdDzM3jgT6I+kU4YdPldRIq8
         QKbMAU8WjBA9R/0GmmXT0T7pjdwGQXhbDAL3orU5lTH0dTelp1D2VsEIVyGgGz82Bedp
         M4Nidby5++1rIV6au1CLqSdTHbtLxMSwSJf7omLqMYvo9j2Nl0C+n4YHFb8UlvDI/qG6
         lEeU9QFnk6IIGGqINkewPKeqenNdbWbGsHt8P0ELxCIzeqRZUYDEYG0cpy7V1T8fndCj
         Sypw==
X-Gm-Message-State: AOJu0YzA7a39Ife4SFvURZoB7jTGNcvpS1Nyw72T3mJ/h3/M4C7nkYI2
	77FavY0sEslbJEJXUXTClRE8RuwL8bxgoTVYEP/JfHMw6DPKfUEvZE61XjLyMwdnfHYe4b4N9IU
	oxAP/zeHCggvIjvr586UfpNDKs9Zh4Q==
X-Gm-Gg: ASbGnctlaMwDqOrk+cjMJrvTM0UDVXOR4TYep2UPIokwE+BygAqgcZmOg5lKkzEFA9c
	8p75V7SlN0GtfPiZ+bJgfUJwbpIZTbDjJIomP+kCQjRAweC3LU64AnW9dyQEILujTmYLcAPL521
	8YH4u9+C1GC7KJV8JFLC8/jph471CPclYIIzUXrVWmHn9kXnH/OfWVzuw=
X-Google-Smtp-Source: AGHT+IH21a3NpFK85BEMeyLknhtbzbWyxiNB45OoRiV6ZvNftDTy4BCNLppmevLsogGjY3/IEfcyugIbYNOKDDwJSbc=
X-Received: by 2002:a05:6602:4c02:b0:85c:c7f9:9a1c with SMTP id
 ca18e2360f4ac-861612bb38bmr303886139f.13.1744209426508; Wed, 09 Apr 2025
 07:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im> <20250408-pks-split-object-file-v1-3-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-3-f1fd50191143@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 9 Apr 2025 07:36:54 -0700
X-Gm-Features: ATxdqUHN4pqm_idHmFDMWnuc0GcOs6ml44tRbr4zW_yZLqfa1yq0Pu82QfMccEA
Message-ID: <CABPp-BFL+4=vggNR8unMR9-TN04NmzqBqtd+sM1J27k70DMFGA@mail.gmail.com>
Subject: Re: [PATCH 3/9] object-file: move `xmmap()` into "wrapper.c"
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 3:33=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> The `xmmap()` function is provided by "object-file.c" even though its
> functionality got nothing to do with the object file subsystem. Move it

s/got/has/ ?


> into "wrapper.c", whose header already declares those functions.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  object-file.c | 48 ------------------------------------------------
>  wrapper.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+), 48 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 1a20c7fa072..ea2ed7628e6 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -719,54 +719,6 @@ int has_loose_object(const struct object_id *oid)
>         return check_and_freshen(oid, 0);
>  }
>
> -static void mmap_limit_check(size_t length)
> -{
> -       static size_t limit =3D 0;
> -       if (!limit) {
> -               limit =3D git_env_ulong("GIT_MMAP_LIMIT", 0);
> -               if (!limit)
> -                       limit =3D SIZE_MAX;
> -       }
> -       if (length > limit)
> -               die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX=
),
> -                   (uintmax_t)length, (uintmax_t)limit);
> -}
> -
> -void *xmmap_gently(void *start, size_t length,
> -                 int prot, int flags, int fd, off_t offset)
> -{
> -       void *ret;
> -
> -       mmap_limit_check(length);
> -       ret =3D mmap(start, length, prot, flags, fd, offset);
> -       if (ret =3D=3D MAP_FAILED && !length)
> -               ret =3D NULL;
> -       return ret;
> -}
> -
> -const char *mmap_os_err(void)
> -{
> -       static const char blank[] =3D "";
> -#if defined(__linux__)
> -       if (errno =3D=3D ENOMEM) {
> -               /* this continues an existing error message: */
> -               static const char enomem[] =3D
> -", check sys.vm.max_map_count and/or RLIMIT_DATA";
> -               return enomem;
> -       }
> -#endif /* OS-specific bits */
> -       return blank;
> -}
> -
> -void *xmmap(void *start, size_t length,
> -       int prot, int flags, int fd, off_t offset)
> -{
> -       void *ret =3D xmmap_gently(start, length, prot, flags, fd, offset=
);
> -       if (ret =3D=3D MAP_FAILED)
> -               die_errno(_("mmap failed%s"), mmap_os_err());
> -       return ret;
> -}
> -
>  static int format_object_header_literally(char *str, size_t size,
>                                           const char *type, size_t objsiz=
e)
>  {
> diff --git a/wrapper.c b/wrapper.c
> index 8b985931490..3c79778055e 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -829,3 +829,51 @@ uint32_t git_rand(unsigned flags)
>
>         return result;
>  }
> +
> +static void mmap_limit_check(size_t length)
> +{
> +       static size_t limit =3D 0;
> +       if (!limit) {
> +               limit =3D git_env_ulong("GIT_MMAP_LIMIT", 0);
> +               if (!limit)
> +                       limit =3D SIZE_MAX;
> +       }
> +       if (length > limit)
> +               die(_("attempting to mmap %"PRIuMAX" over limit %"PRIuMAX=
),
> +                   (uintmax_t)length, (uintmax_t)limit);
> +}
> +
> +void *xmmap_gently(void *start, size_t length,
> +                 int prot, int flags, int fd, off_t offset)
> +{
> +       void *ret;
> +
> +       mmap_limit_check(length);
> +       ret =3D mmap(start, length, prot, flags, fd, offset);
> +       if (ret =3D=3D MAP_FAILED && !length)
> +               ret =3D NULL;
> +       return ret;
> +}
> +
> +const char *mmap_os_err(void)
> +{
> +       static const char blank[] =3D "";
> +#if defined(__linux__)
> +       if (errno =3D=3D ENOMEM) {
> +               /* this continues an existing error message: */
> +               static const char enomem[] =3D
> +", check sys.vm.max_map_count and/or RLIMIT_DATA";
> +               return enomem;
> +       }
> +#endif /* OS-specific bits */
> +       return blank;
> +}
> +
> +void *xmmap(void *start, size_t length,
> +       int prot, int flags, int fd, off_t offset)
> +{
> +       void *ret =3D xmmap_gently(start, length, prot, flags, fd, offset=
);
> +       if (ret =3D=3D MAP_FAILED)
> +               die_errno(_("mmap failed%s"), mmap_os_err());
> +       return ret;
> +}
>
> --
> 2.49.0.682.gc9b6a7b2b0.dirty
>
>
