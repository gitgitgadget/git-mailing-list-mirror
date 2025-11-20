Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EE415A86D
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763667949; cv=none; b=FKZuqi9wIEYAwoGIFjwK0lDH8oQc8dnm9utVVDL+td2aAv5N/ao+yVHRJfRzfREUzrEtJ5JjGtbu1Z89mQTH1RrUC5KJNkf6EsoAxXs7hwe1okl+pKXdEILxLwA+F0l7AX+BAgp2T9B9sJHAn7ZQeyfH7KSAOpOhCXuewIP8Src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763667949; c=relaxed/simple;
	bh=2KnZf3SAhjqm3J1A5Z0xXhClTBPIXss5QVx8flw4958=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cvgey/zSNdt9dhAux7V+hSGtrfyCclTpSpSuxPxj+y5ibdWR4t9aFpRoNDWA/77oo4Z8NISkJmM1861Yzbb2Y7rvZe/Pa//kZh+3YzQ912AMLHy4E8VNNPfLtcZoI+DVttZTTsM+75vk9JmQ5YSNzX1b2JPSsOpnY5wJ2UJjULc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNa+sWlq; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNa+sWlq"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37ba781a6c3so10523531fa.0
        for <git@vger.kernel.org>; Thu, 20 Nov 2025 11:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763667946; x=1764272746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dTo8UB6gK1aWIFBnLz4nbjnLAby+P/li/Oqkn2DLNWI=;
        b=lNa+sWlq0znyTfocnTLYJcE/Gy9tOlzT3u0kKM2bk1eSTyRf3c6d/wr8j+5cC8qiTN
         dxiIvilWF9zMMVcCvps6+jsa74sR3VtriOxd70R80BR5T0ta7502w5DIIlu4iGmYP/De
         JWFkYSJ/Pzws/0CQD6Hu7ygkBQrvAdSwsl4PCICtoz2SZxYwtvTZ+Yq1YqyTDrRdmIB5
         yMgmVmQyBYV+EoBN+vuKBPFFdA4DfLdHSjI5aEWTlsyJ1V7a7HBjNxpQxikOrL7/cuyP
         WuByBTSc6JoDpLwtfFsNxZiNnHK8Jx2BMAamrXPC+VdvB2VAcz3OiGuY07q8sFZVfycw
         pZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763667946; x=1764272746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dTo8UB6gK1aWIFBnLz4nbjnLAby+P/li/Oqkn2DLNWI=;
        b=b04lfWhCy0G/c6KFC843Sjgldbi6Juq3Pn4KrWxzOcE/f5K2LAXpEKKMyA4WInsIoF
         BycSCLLx7W9Gl3YN9ndHHnOdOkbbt7JUhtUb8kHAUz7MXVgXbg1RgGwbqDodbaA2lpXy
         9t2+05urFj/uVqD9hp0/uPHVfA5GMgsMp+4BIfDqqGxbu4yFx+CFKKo2LL40Wxwi8bks
         jN7CRiSxvGGwD3OENcpdMB4yXbGwF2lGCb8t6p505HNwqgO5tq/Z/fdQLX/ziBnSG+xS
         0ORhKs/uR0gC8UBzE2ilKl8VSlz/5tV+UB3Dgy/oEFl9qV5UlCH3J1NonYEWSclbiCuD
         fOag==
X-Gm-Message-State: AOJu0YyDLQ1zfyiZlQNDTHXn47UdCD+hoFMdmW/H4KyFEUPFyxaFlXrj
	quEdx5iC/wPlRMmKwZtk3tuzXIrDOfFnkpV1o3P75UIEeyhYXS0Sc1RriAiVYw/zewESBLp0fvH
	28Ntw8n0owpvq8dMFySL87Z3x7yfRzeI=
X-Gm-Gg: ASbGnctq4NAUJB5U/sZCE4qF1ZSon3hP5aEdiCiKyxhTaQ/Fe+mHdRchNbMHXprfh2i
	WfhFqf3WjSMv4OfjvESe72a0k2SH5xQDQvd4/RYRxe80I0ICM+ETwi5eBl/RHiSiBN0XMqa2Git
	5fSNdpk6Qs/Hv82oXEiIDiD8EkXxQA1W8LSW0J3c9hrglgEiw2FEpQMXYAYM9k8O1uEZ5wd9ZmW
	FgUvzcnxxa3xAkenz5hvwZ60/Dp9nf9TOnI/tUdQhJuMCB5uJqF39BlGZFYlhf+ZIhMM/3H
X-Google-Smtp-Source: AGHT+IFfx1GNSqNWVmE9q68q9EPwd5BChX+ICu5IfBNW2V8/uXXTvBGosM6Nvhdzmbn3SUfma+9jGGW+KpJj6ODN3Ek=
X-Received: by 2002:a2e:8a98:0:b0:37b:991a:544b with SMTP id
 38308e7fff4ca-37cc67aa94amr10430611fa.34.1763667945465; Thu, 20 Nov 2025
 11:45:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015-b4-pks-ci-rust-v3-0-13810af33bd5@pks.im> <20251015-b4-pks-ci-rust-v3-6-13810af33bd5@pks.im>
In-Reply-To: <20251015-b4-pks-ci-rust-v3-6-13810af33bd5@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Thu, 20 Nov 2025 12:45:34 -0700
X-Gm-Features: AWmQ_bnzk3-PsRBQYvGayuvlxmSjCRj8mvSo_o4jMC8QDnzdq_AP2Z08zPBzQMs
Message-ID: <CAH=ZcbB8cRgCTp-Q_CxJ4VFNY1+w+C20zgx9bMre4-hNmPrD7g@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] rust: support for Windows
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Eric Sunshine <ericsunshine@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, Chris Torek <chris.torek@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This is a retrospective review. I completely missed this patch series,
and only noticed its existence after it was merged into master. The
core problem is that these changes assume that windows builds only
ever use the MSVC compiler, but that's not true.

On Wed, Oct 15, 2025 at 12:04=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> The initial patch series that introduced Rust into the core of Git only
> cared about macOS and Linux. This specifically leaves out Windows, which
> indeed fails to build right now due to two issues:
>
>   - The Rust runtime requires `GetUserProfileDirectoryW()`, but we don't
>     link against "userenv.dll".
>
>   - The path of the Rust library built on Windows is different than on
>     most other systems systems.

That is true, but the build systems also need to check if the C
compiler is gnu or msvc. Also you used the word "systems" twice.

> diff --git a/Makefile b/Makefile
> index 7ea149598d..366fd173e7 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -929,10 +929,17 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
>  LIB_FILE =3D libgit.a
>  XDIFF_LIB =3D xdiff/lib.a
>  REFTABLE_LIB =3D reftable/libreftable.a
> +
>  ifdef DEBUG
> -RUST_LIB =3D target/debug/libgitcore.a
> +RUST_TARGET_DIR =3D target/debug
>  else
> -RUST_LIB =3D target/release/libgitcore.a
> +RUST_TARGET_DIR =3D target/release
> +endif
> +
> +ifeq ($(uname_S),Windows)
> +RUST_LIB =3D $(RUST_TARGET_DIR)/gitcore.lib
> +else
> +RUST_LIB =3D $(RUST_TARGET_DIR)/libgitcore.a
>  endif
>
>  # xdiff and reftable libs may in turn depend on what is in libgit.a
> @@ -1538,6 +1545,9 @@ ALL_LDFLAGS =3D $(LDFLAGS) $(LDFLAGS_APPEND)
>  ifdef WITH_RUST
>  BASIC_CFLAGS +=3D -DWITH_RUST
>  GITLIBS +=3D $(RUST_LIB)
> +ifeq ($(uname_S),Windows)
> +EXTLIBS +=3D -luserenv
> +endif
>  endif
>  ifdef SANITIZE

This is not fully correct for Makefile. If Windows AND using MSVC ->
gitcore.lib. However this bug doesn't show up because github ci
doesn't test the windows+msvc+makefile combo.

> diff --git a/meson.build b/meson.build
> index ec55d6a5fd..a9c865b2af 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1707,6 +1707,10 @@ rust_option =3D get_option('rust').disable_auto_if=
(not cargo.found())
>  if rust_option.allowed()
>    subdir('src')
>    libgit_c_args +=3D '-DWITH_RUST'
> +
> +  if host_machine.system() =3D=3D 'windows'
> +    libgit_dependencies +=3D compiler.find_library('userenv')
> +  endif
>  else
>    libgit_sources +=3D [
>      'varint.c',

Same issue as above, but it doesn't show up because the github ci
doesn't test the windows+gnu+meson combo.

> diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> index 99400986d9..3998db0435 100755
> --- a/src/cargo-meson.sh
> +++ b/src/cargo-meson.sh
> @@ -26,7 +26,14 @@ then
>         exit $RET
>  fi
>
> -if ! cmp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a"=
 >/dev/null 2>&1
> +case "$(cargo -vV | sed -s 's/^host: \(.*\)$/\1/')" in
> +       *-windows-*)
> +               LIBNAME=3Dgitcore.lib;;
> +       *)
> +               LIBNAME=3Dlibgitcore.a;;
> +esac
> +
> +if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/d=
ev/null 2>&1
>  then
> -       cp "$BUILD_DIR/$BUILD_TYPE/libgitcore.a" "$BUILD_DIR/libgitcore.a=
"
> +       cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
>  fi

Same issue again. This needs to test for windows AND msvc.
