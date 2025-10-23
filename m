Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4484262FE7
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 18:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761242437; cv=none; b=lEjK44uhwaeXOYrDeS0k82UHqBjrYFq2DZraEb0idz2NDtyudwzBPDR9bCskafFFLAV6HS4vLnOaliFIx8bI+PlGNBlonMrH8iF0iAJ+fGhHoTIECRwocyierQOdcB7MDgXMBN/lsBpsfMsvVhz/KSl6OXZj3Dz13au4bUm9E0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761242437; c=relaxed/simple;
	bh=hzIIkB7OHYuuwrkbo3UPDrynaWZX4itxrq0Fadhxpa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7lKfDIPzP/zN3Gf5TWJ9E9qmtYEFVsO6Y5nN5wSPrK/Qt0y4TP3s56PSRoIHLtGmPEsfqxV0BsrmVEU+3EoIPIJwnsVVZqKbDapNO4XA9hel4VEsA9EjUO1S6vkr5e06ll/2uMEam8AlxtPOOi74z2m3ZOJ5V4vilX3yzUPtb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvhH4vQ+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvhH4vQ+"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-378ddb31efaso10383341fa.3
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 11:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761242434; x=1761847234; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eJ/8zba+m2VWYjNI2kz+iMmpizxJ/fy6V7OMZVivSAM=;
        b=QvhH4vQ+qQ2wbcYSNnVW+soPUjIySpPlwRxXnZ1iRcKJmBpj3BabC1WvbEczvSkRft
         PyY06J+4f3FN+6IVP7f+S+B+mc7AcqgNYcjMEeDcXqETKtW50o46gdduCKVhxSYYk9bh
         pLBfv8bSVDOxar9lplhnABkJUxbj3+HPV7d/4t6nPK17prSrX1ZfQyL1GhTROsGL+NxE
         FQDV8QZHaoZLTv16Obqk6jQFoNnnDXeNSvR7FF7PY+Z3IXH2E3zJSv43gVQT2gZKW+AE
         yB2KoGOYYDidbkQ31glmONk0Bt1TWGkxx46+41p+K/XWjhZ0hlt/GLTAmHyu+EdsJfmZ
         +Y1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761242434; x=1761847234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eJ/8zba+m2VWYjNI2kz+iMmpizxJ/fy6V7OMZVivSAM=;
        b=gmXOeKot+EprQFYvugc8g6HdVhCBXkisn7eEWcQGflz0eFOMJ1XSLPCxxOZE6Di3nC
         UplMATdVJ4MeXy5/NfspeOPPmexzh1VbFAhRIbOS3E9yi3xH8/MG/Ap6zjc1JujtekWe
         7VeteqlVyDpEI7kXwNaRmXtlGUUJCm+xbIMxQUnFSBBhg4PEnuOaM9isEfEeJSe+KD4P
         WV/bs1yrLKaC9HQ3X7fy0Gm85V6UjmeRisRX6u4FP4XOOeldPuWvMzb5DiYv07ArP290
         UF++4kbzPr2WyVHI+bU+zUxWTXBrHZuv+Uc3lpIFj0UNjMoBRezQ85V5Icjv4vxBmGrn
         CqNQ==
X-Gm-Message-State: AOJu0YzxlhiYSJhwSSrBrc0LNjdlLGxDH3BQ3wBy4wM3VZR5kJdwArMw
	nI7o6UsaMV5KwrqxhTYfDWuJpL3t3WwQZeJIIqtNinckRiwNDY7uIuqXHWoE07zFspl0aSdMEtU
	88NzkIE+PAnnyc9cySsjOmizxhs5CCHI=
X-Gm-Gg: ASbGncsKIbJhRhwQW6i7bsyVD8CD7udIsPlUYzgGoZwm5+uYeEthkFNZDNi7xcc4UoK
	R8dsjFjGmaLb4G/Py8MYUlQdhOKmlKDok+LNfyfyXjihI8Y5RwaSzNQfaI3RFAlxwnuXQp9x1+n
	XSCy1mkiBxbH9iqWkSFHnzOvq2Mgita9LlRkBEB0ZmO+04n7JUJh1x13NVcKwXE/C58cNThXQtX
	ksrRXpiBYGUEYhripuemKOjCfLItuAtkggdBx+M9yG+ptRz1j729bEGqgQ25OW2J8I+c0cy
X-Google-Smtp-Source: AGHT+IH0UWHFoGAOGgT1m4qv/FlL2oUFKnTyuBZe+AclBQwYb2Iuwiy4KZBBwZBkA99Ex+12Ft6Ghh4qZc9fBc7FwEM=
X-Received: by 2002:a05:651c:541:b0:378:cd74:a288 with SMTP id
 38308e7fff4ca-378cd74a6c3mr19934961fa.10.1761242433430; Thu, 23 Oct 2025
 11:00:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im> <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 23 Oct 2025 12:00:21 -0600
X-Gm-Features: AWmQ_bmcgemypF6WIu-w5wJ7BCPjepcPd2UwmGbkb7042Z7ln8SOALNebTZG0XU
Message-ID: <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 1:17=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> +C_BINDINGS =3D c-bindings.h
> +
> +GENERATED_H +=3D $(C_BINDINGS)
> +
> +$(C_BINDINGS): cbindgen.toml $(RUST_SOURCES)
> +       $(QUIET_CBINDGEN)cbindgen --output $@
> +

My preference is to store all generated header files from cbindgen
under interop/ that way we don't pollute the root of Git. It also
makes ignoring generated header files easier (if we choose to) since
we'd only need to specify `/interop/` in .gitignore. For platforms
that can't compile Rust how are they going to build C if they depend
on those generated headers?

> diff --git a/cbindgen.toml b/cbindgen.toml
> new file mode 100644
> index 00000000000..ba4b2d63672
> --- /dev/null
> +++ b/cbindgen.toml
> @@ -0,0 +1,7 @@
> +language =3D "C"
> +
> +# Don't include standard C headers. These are managed by "git-compat-uti=
l.h".
> +no_includes =3D true
> +
> +# Use plain structs instead of using typedefs.
> +style =3D "tag"

This is what my cbindgen.toml file looked like.
```
sys_includes =3D ["git-compat-util.h"]

autogen_warning =3D "/* Warning, this file is autogenerated by cbindgen.
Don't modify this manually. */"

language =3D "C"
no_includes =3D true
usize_is_size_t =3D true
style =3D "tag"
tab_width =3D 4

[parse]
parse_deps =3D false
```
tab_width is the number of spaces, there is no option to use a tab
character in cbindgen.

> diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
> index b7b3cf35edf..3bce6f47f87 100755
> --- a/ci/install-dependencies.sh
> +++ b/ci/install-dependencies.sh
> @@ -37,7 +37,7 @@ fedora-*|almalinux-*)
>                 MESON_DEPS=3D"meson ninja";;
>         esac
>         dnf -yq update >/dev/null &&
> -       dnf -yq install shadow-utils sudo make pkg-config gcc findutils d=
iffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel cur=
l-devel pcre2-devel $MESON_DEPS cargo >/dev/null
> +       dnf -yq install shadow-utils sudo make pkg-config gcc findutils d=
iffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel cur=
l-devel pcre2-devel $MESON_DEPS cargo cbindgen >/dev/null
>         ;;
>  ubuntu-*|i386/debian-*|debian-*)
>         # Required so that apt doesn't wait for user input on certain pac=
kages.
> @@ -64,7 +64,7 @@ ubuntu-*|i386/debian-*|debian-*)
>                 make libssl-dev libcurl4-openssl-dev libexpat-dev wget su=
do default-jre \
>                 tcl tk gettext zlib1g-dev perl-modules liberror-perl liba=
uthen-sasl-perl \
>                 libemail-valid-perl libio-pty-perl libio-socket-ssl-perl =
libnet-smtp-ssl-perl libdbd-sqlite3-perl libcgi-pm-perl \
> -               libsecret-1-dev libpcre2-dev meson ninja-build pkg-config=
 cargo \
> +               libsecret-1-dev libpcre2-dev meson ninja-build pkg-config=
 cargo cbindgen \
>                 ${CC_PACKAGE:-${CC:-gcc}} $PYTHON_PACKAGE

cbindgen is a Rust crate and it should be specified in the Cargo.toml
under [build-dependencies] block. Also I think that we should convert
from using a Cargo crate to using a Cargo workspace, so that we can
generate multiple header files (1 per crate) rather than a monolithic
generated header. This is because cbindgen operates at the granularity
of a crate.
