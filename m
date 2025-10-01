Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE329BDBF
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 17:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759339301; cv=none; b=U3AldkcjFD2mp+GsAULnZcQbNEK0CMvbChLTO7uDnyiq9+oqt4ise4dbXf15iqIJS3xc7pjbsWFWmFRUFKJcFbmPsLXz+zCAyQFRT+koVNCGe0lTCuLGwE9wVdyzFp5mVM/I7mGquObKnP+PRNjQwHBuyjZg61ciPTdnA4UIuzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759339301; c=relaxed/simple;
	bh=9xlOg86kBHvYutyv99BChT8Kfu/WerEBRwwQJb1rbBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeX1tRcYiYz/hoCfY4nTLV2CeLEcRDv9FEyK8qI7ib3t21g0q53UcfIo10MRtOPj2J8S8Avo1mxx9VWUWk2U00pgK8sEz/7NQrFyDnYoM0ddDJ9ouvWXHecYAYY+7kHzlvQO3x6jJ4xRRYF8LcL/uCD7D91PRxvxCtF24WvWEzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZtEeXhCx; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZtEeXhCx"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36a6a39752bso776491fa.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 10:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759339297; x=1759944097; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAun6BdoUWTBDhNYIYcrqAnZP7qWcGb9JkIYIvJgCfw=;
        b=ZtEeXhCxAORFwgNY2wyOgIMXz5UDNAFj5Bk/OUw5hZKth/YJc6e0k2Z73W3D6aiRzd
         3MhvadAqMj5JKFFeei9VBNHanreMv/R/QRfsCEkmoyRZqlbeHMwi8MaOWJ7mqMqIgYC9
         DGbXYuMWr/tBRzz1k9P/kjc1LrF86azFMPDNfH792IgLLYmapusaGuZ6lgLiQf/RG/dc
         D3SaWwT1rx0yD8ITLvpJkQZ3n35weLwEzaB9qpOcTceFsjOaJj6DuvdWJOS79M2XylSM
         syuZeiQc6O+Q+F1r3QJTcY6dLGDlGZmPwKX+lYbSu3Dbdj1qNLX6tg5W7CmC1NO06TVy
         7d3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759339297; x=1759944097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAun6BdoUWTBDhNYIYcrqAnZP7qWcGb9JkIYIvJgCfw=;
        b=VHnYS8ntQNX6+uASvm1kwB59BPUX0l1u5SVw9qiaBSrSmKnyqbfeVUiNPW9GlAYiuK
         TUlOjyE2tAz1DtVPiNFXK0kizqgDNtozc9a+Lae6yOzjRMaEX6AAJ6hHJhmBk3AlBH8i
         sKaEdUSl8OD0+g3f/vGr6ZJWYNj1fYmiKDYpW4E5PLZmKiYzIra1ajWLmFStfXqRfy8l
         1nZ/kkYJCa+1oEFDs9DHHHJPTUBFcbzD/7hsLX/fu6OKh0nXK49kMNCvl5QeWNYFhqUM
         KULUUcj0CeAJhUsQjEOz0kMTX8Uqsd+OEFXCVZFdIK5Vbj9jqHMr2x9r/J47HcZ8BiTK
         qQRA==
X-Gm-Message-State: AOJu0Ywv4NLD2Tn8PhaLctGlEzRXf0lC+rram1rxFezSxm/5+lu/seJF
	Uc3u1DUGQbc3uCirxPCgBeNwnEg6f4LnYilN945ED9M0/Ep4Rhri0gNNAR/ruK6oDSDgYgouJzO
	F6q2rBZ6zKI+tmpS9aOvKkcNEAkXPvJA=
X-Gm-Gg: ASbGncu4kUV9uFHxtKtJONUwO49RevwjnpfqeQkgacOxDRgSoA+Q+AWzaZ75q/Gkjps
	Kpw17tMbj4EltmitR8f0yOqDS3CkCsbP0xSnfpSZizSx5NdDoB+uZJnFvmnslIraVi1V8mY5QwY
	JWOhGU7ggdORm8vpfhF5FZnCbmHRDO7KLMOg7tRTEyUQyTYtVqxdGoJhAjE/2Dopvxjm4g4EmDb
	KNEMYANgBareCbMdJJ5fT5t2yDvGGBQ
X-Google-Smtp-Source: AGHT+IGIv5OEJcJlpktNOotrzBWDaCccxSfiMALt7ettoKPb4D8JC8Xr4IgOqInQIkfEUu0b9+SAH2S0DR4JCVyDvs4=
X-Received: by 2002:a2e:bd05:0:b0:338:10c9:5871 with SMTP id
 38308e7fff4ca-373a7430df5mr9640981fa.34.1759339297021; Wed, 01 Oct 2025
 10:21:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-b4-pks-rust-breaking-change-v7-0-4e49dcb904d5@pks.im> <20250925-b4-pks-rust-breaking-change-v7-6-4e49dcb904d5@pks.im>
In-Reply-To: <20250925-b4-pks-rust-breaking-change-v7-6-4e49dcb904d5@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 1 Oct 2025 11:21:25 -0600
X-Gm-Features: AS18NWDHaGqb_Lg8iXIVN09Jc5B_uLEu0hBdX_ST1_dFR8YdsRJHN5i2jmBxDVA
Message-ID: <CAH=ZcbC6jMUBMLrmwzksAzLM3t=XH+hBnf+=wLdjAcAiWTx7vw@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] varint: reimplement as test balloon for Rust
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 12:30=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>  Makefile        |  3 ++
>  meson.build     |  5 +++-
>  src/lib.rs      |  1 +
>  src/meson.build |  1 +
>  src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  5 files changed, 101 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 31e79342e1d..2a7fc5cb1f3 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1307,7 +1307,9 @@ LIB_OBJS +=3D urlmatch.o
>  LIB_OBJS +=3D usage.o
>  LIB_OBJS +=3D userdiff.o
>  LIB_OBJS +=3D utf8.o
> +ifndef WITH_RUST
>  LIB_OBJS +=3D varint.o
> +endif
>  LIB_OBJS +=3D version.o
>  LIB_OBJS +=3D versioncmp.o
>  LIB_OBJS +=3D walker.o
> @@ -1499,6 +1501,7 @@ CLAR_TEST_OBJS +=3D $(UNIT_TEST_DIR)/unit-test.o
>  UNIT_TEST_OBJS +=3D $(UNIT_TEST_DIR)/test-lib.o
>
>  RUST_SOURCES +=3D src/lib.rs
> +RUST_SOURCES +=3D src/varint.rs
>
>  GIT-VERSION-FILE: FORCE
>         @OLD=3D$$(cat $@ 2>/dev/null || :) && \
> diff --git a/meson.build b/meson.build
> index 234a9e9d6fd..37dfa286017 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -522,7 +522,6 @@ libgit_sources =3D [
>    'usage.c',
>    'userdiff.c',
>    'utf8.c',
> -  'varint.c',
>    'version.c',
>    'versioncmp.c',
>    'walker.c',
> @@ -1707,6 +1706,10 @@ rust_option =3D get_option('rust').disable_auto_if=
(not cargo.found())
>  if rust_option.allowed()
>    subdir('src')
>    libgit_c_args +=3D '-DWITH_RUST'
> +else
> +  libgit_sources +=3D [
> +    'varint.c',
> +  ]
>  endif
>
>  libgit =3D declare_dependency(
> diff --git a/src/lib.rs b/src/lib.rs
> index e69de29bb2d..9da70d8b57d 100644
> --- a/src/lib.rs
> +++ b/src/lib.rs
> @@ -0,0 +1 @@
> +pub mod varint;
> diff --git a/src/meson.build b/src/meson.build
> index c8d874b2106..25b9ad5a147 100644
> --- a/src/meson.build
> +++ b/src/meson.build
> @@ -1,5 +1,6 @@
>  libgit_rs_sources =3D [
>    'lib.rs',
> +  'varint.rs',
>  ]
>
>  # Unfortunately we must use a wrapper command to move the output file in=
to the
> diff --git a/src/varint.rs b/src/varint.rs
> new file mode 100644
> index 00000000000..6e610bdd8e0
> --- /dev/null
> +++ b/src/varint.rs
> @@ -0,0 +1,92 @@
> +#[no_mangle]
> +pub unsafe extern "C" fn decode_varint(bufp: *mut *const u8) -> u64 {
> +    let mut buf =3D *bufp;
> +    let mut c =3D *buf;
> +    let mut val =3D u64::from(c & 127);
> +
> +    buf =3D buf.add(1);
> +
> +    while (c & 128) !=3D 0 {
> +        val =3D val.wrapping_add(1);
> +        if val =3D=3D 0 || val.leading_zeros() < 7 {
> +            return 0; // overflow
> +        }
> +
> +        c =3D *buf;
> +        buf =3D buf.add(1);
> +
> +        val =3D (val << 7) + u64::from(c & 127);
> +    }
> +
> +    *bufp =3D buf;
> +    val
> +}
> +
> +#[no_mangle]
> +pub unsafe extern "C" fn encode_varint(value: u64, buf: *mut u8) -> u8 {
> +    let mut varint: [u8; 16] =3D [0; 16];
> +    let mut pos =3D varint.len() - 1;
> +
> +    varint[pos] =3D (value & 127) as u8;
> +
> +    let mut value =3D value >> 7;
> +    while value !=3D 0 {
> +        pos -=3D 1;
> +        value -=3D 1;
> +        varint[pos] =3D 128 | (value & 127) as u8;
> +        value >>=3D 7;
> +    }
> +
> +    if !buf.is_null() {
> +        std::ptr::copy_nonoverlapping(varint.as_ptr().add(pos), buf, var=
int.len() - pos);
> +    }
> +
> +    (varint.len() - pos) as u8
> +}
> +
> +#[cfg(test)]
> +mod tests {
> +    use super::*;
> +
> +    #[test]
> +    fn test_decode_varint() {
> +        unsafe {
> +            assert_eq!(decode_varint(&mut [0x00].as_slice().as_ptr()), 0=
);
> +            assert_eq!(decode_varint(&mut [0x01].as_slice().as_ptr()), 1=
);
> +            assert_eq!(decode_varint(&mut [0x7f].as_slice().as_ptr()), 1=
27);
> +            assert_eq!(decode_varint(&mut [0x80, 0x00].as_slice().as_ptr=
()), 128);
> +            assert_eq!(decode_varint(&mut [0x80, 0x01].as_slice().as_ptr=
()), 129);
> +            assert_eq!(decode_varint(&mut [0x80, 0x7f].as_slice().as_ptr=
()), 255);
> +
> +            // Overflows are expected to return 0.
> +            assert_eq!(decode_varint(&mut [0x88; 16].as_slice().as_ptr()=
), 0);
> +        }
> +    }
> +
> +    #[test]
> +    fn test_encode_varint() {
> +        unsafe {
> +            let mut varint: [u8; 16] =3D [0; 16];
> +
> +            assert_eq!(encode_varint(0, std::ptr::null_mut()), 1);
> +
> +            assert_eq!(encode_varint(0, varint.as_mut_slice().as_mut_ptr=
()), 1);
> +            assert_eq!(varint, [0; 16]);
> +
> +            assert_eq!(encode_varint(10, varint.as_mut_slice().as_mut_pt=
r()), 1);
> +            assert_eq!(varint, [10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0]);
> +
> +            assert_eq!(encode_varint(127, varint.as_mut_slice().as_mut_p=
tr()), 1);
> +            assert_eq!(varint, [127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=
 0, 0, 0]);
> +
> +            assert_eq!(encode_varint(128, varint.as_mut_slice().as_mut_p=
tr()), 2);
> +            assert_eq!(varint, [128, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=
 0, 0, 0]);
> +
> +            assert_eq!(encode_varint(129, varint.as_mut_slice().as_mut_p=
tr()), 2);
> +            assert_eq!(varint, [128, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,=
 0, 0, 0]);
> +
> +            assert_eq!(encode_varint(255, varint.as_mut_slice().as_mut_p=
tr()), 2);
> +            assert_eq!(varint, [128, 127, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, =
0, 0, 0, 0]);
> +        }
> +    }
> +}

Looks good.
