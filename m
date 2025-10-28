Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1575A345751
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 17:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673358; cv=none; b=OIOktkVejj6Zf8qPkhwGhNtd+NLzn4tk+1JvR3eMYKoiCHOhXbmdaAc84HF/f0cXTpTT7HCs2ChxRTW6acrfbAQfDnGRYtC1EMzNUwudj8Q0pPka5HQN2V/cr55eTnNT6Lq9wo14HthiMKK4TRzoK039Qy5AFYzo8S5gnqusfBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673358; c=relaxed/simple;
	bh=94Qa0cMrTG3jbA57xOkbWf5X5M+vyMRSMJV3lO0xyHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nO9Cz7ApCVTG/cZbhE6cHEuqHR/TdTYQrr2Ac6EiKBx7FB09gUYFsfSAay4bcuy2lvq45pyuiS3G5tr9QORFdBoLe/n8Ywrp7zDYDk6p1aodl02zpzesYZEWxcXEsZimnAFUc91EguSdb7NWiTky+bk952RRmzuBc5oW1vL7Ork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xc2zzEr6; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xc2zzEr6"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-378d65d8184so14483501fa.0
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 10:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761673354; x=1762278154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LoLBL9a3lZ9i9C2d0OJ72CwaWF6mY6bi9PP0LHoWqI=;
        b=Xc2zzEr64xqvkSnyWNSH1kdxg6T9F8RdBFOBVgxGFnnnD+ZQWx/1Guuz7oJLeuiURg
         SM1sbyZo1bDkBYUH2gfyjgC8c72cDqDRdju/EiVLfDvHyyAugXIiZCOKV4+bKmTvP6EW
         7AmS8y35Ss7qkJMNPwEabcGkP5TLQszZ/NP0uDvz7eg3ulwzWD8Jjs1BcfarYubaUHiC
         Y8rKI2ECCOQoRNRFz6QhRJzTjMKl6vEhLf+COoljXADafIawWNZBr6U+nrAE0IGhUwmr
         lGM4EtqgjWIwXK5FlrDsWtN75rNvb7ztHaEoGepefuvWliXTZBE4Ei2lAcuvnucynWhp
         vEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761673354; x=1762278154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LoLBL9a3lZ9i9C2d0OJ72CwaWF6mY6bi9PP0LHoWqI=;
        b=C0IsOqVKiosuiL9UySWFHIaZ0A9fqttLifFCWWeBgHK4d3qEDoLgqaKHv9kHHJ+WM7
         zcRa5iXJaulOBoW0S7VQFS1XeFKixftkuxZ0LvYyn/7/6RZwKAmUMMocjqhjBvDvCo4O
         mVAtpwVEW+vrfejbMm7kPVDDG29uufV2g2sTCDuV80egeUTRax7/zTmzHTrKMrfKEmq6
         mq9LBou6YyXit/DPQwNNYx3ShS+0n4icyDNbxhgTW7O33KzwGKNDcTg6mZECkFtmVpdU
         ZRXGeBOSvrd/TQiRP1RFXdToQKmai3OSc3WuYEpy7CEhnJqy5QcpAPzN5TyPZNrx3rtz
         eYUw==
X-Forwarded-Encrypted: i=1; AJvYcCXKh1on7LwYbWL25TNgN9l8m+q1WBpYlwRDiyPJUA08mkByL6tH82fweyu7acSXpdgdArc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGY3cj6aY2tNtkGbnpgDjxIOZtNTC0b7hTGt9kVRRMmU4q8VU+
	KZlwini4hwU5RTfzazt46puP3BOXcpHEeBzmc2FdCkSb6ytGQxqhOIjIOAlxq2j+evUFPlAfgf0
	3XyAEFFL/fD5uD0whANY+bgvdGN8oUw0=
X-Gm-Gg: ASbGncsuybX2Dk27EqwQCk/9FPsXWtARuCo9fZ3RO5ZDOtfMyw7rpEy9ZCmfJgeeMXx
	KpzBMl+enYmLo6RY2KGBegH9JAX92/su2sSEWqkksCWxErnP98ikeC9hS6kRC3IItJ0F16Zysqc
	84yv31VfpJc4rEtACMSi9mk0CmRQp3RYZXmAlS37TgJsGnk0EKvMxKN67AGR9phZsFpO6Hk8WxC
	In0OlqEdcIoLRbcW0CC1tksyT2v1M1m7Ie7i2UniSpJV//Q/ZN1RkabkmNjWg==
X-Google-Smtp-Source: AGHT+IECUmJ0Oq2MZm6JafTUiVTJBLdzoILaxUriC+9mD2UGK9Z8qXEgun9oS/Jt1xaZCIGi6aSCnnNmuSfFDQ1Ri5g=
X-Received: by 2002:a05:651c:23d3:20b0:352:6aa4:3cee with SMTP id
 38308e7fff4ca-37a023c83eamr883471fa.17.1761673353761; Tue, 28 Oct 2025
 10:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-11-sandals@crustytoothpaste.net> <aQCKWtgcYQVPzIPz@pks.im>
In-Reply-To: <aQCKWtgcYQVPzIPz@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Tue, 28 Oct 2025 11:42:21 -0600
X-Gm-Features: AWmQ_bko5M-OT9aFUSUx9YO02lZZmvIWBakhOaCTuDUWvnBK7a1v1-OC936TB98
Message-ID: <CAH=ZcbCAzxAcxdcriLz7cafeuy0ZOMp+=05b++gdX-Vx8kbuGw@mail.gmail.com>
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:18=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> On Mon, Oct 27, 2025 at 12:44:00AM +0000, brian m. carlson wrote:
> > diff --git a/Makefile b/Makefile
> > index 7e5a735ca6..7c36302717 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2948,7 +2948,7 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
> >  $(LIB_FILE): $(LIB_OBJS)
> >       $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> >
> > -$(RUST_LIB): Cargo.toml $(RUST_SOURCES)
> > +$(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(XDIFF_LIB) $(LIB_FILE) $(REF=
TABLE_LIB)
> >       $(QUIET_CARGO)cargo build $(CARGO_ARGS)
>
> We have recently removed the separare xdiff and reftable libraries, so
> it shouldn't be necessary to have these anymore.

Patrick is referring to my Makefile update libgit.a patch series that
has been merged into master [1].

> But one thing I'm curious about: don't we have a circular dependency
> between the Rust and C library now? I guess that's somewhat expected, as
> we'll want to call Rust from C and vice versa. But on the Meson side I
> think we need to adjust our logic so that we don't pull the Rust library
> into libgit.a to break this cycle.
>
> > diff --git a/build.rs b/build.rs
> > new file mode 100644
> > index 0000000000..136d58c35a
> > --- /dev/null
> > +++ b/build.rs
> > @@ -0,0 +1,21 @@
> > +// This program is free software; you can redistribute it and/or modif=
y
> > +// it under the terms of the GNU General Public License as published b=
y
> > +// the Free Software Foundation: version 2 of the License, dated June =
1991.
> > +//
> > +// This program is distributed in the hope that it will be useful,
> > +// but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +// GNU General Public License for more details.
> > +//
> > +// You should have received a copy of the GNU General Public License a=
long
> > +// with this program; if not, see <https://www.gnu.org/licenses/>.
> > +
> > +fn main() {
> > +    println!("cargo::rustc-link-search=3D.");
> > +    println!("cargo::rustc-link-search=3Dreftable");
> > +    println!("cargo::rustc-link-search=3Dxdiff");
> > +    println!("cargo::rustc-link-lib=3Dgit");
> > +    println!("cargo::rustc-link-lib=3Dreftable");
> > +    println!("cargo::rustc-link-lib=3Dz");
> > +    println!("cargo::rustc-link-lib=3Dxdiff");
> > +}
>
> How do we ensure that the correct libraries are linked here? E.g. for
> libz, if there are multiple such libraries, which one gets precedence?

I solved this problem in my own Introduce Rust series [2,3]. When
Makefile or Meson is invoking Cargo it sets the environment variable
`USE_LINKING=3Dfalse` and build.rs doesn't link against libgit.a or any
other library. When `cargo test` is called it will link against
libgit.a because if USE_LINKING is not set then it assumes true.

[1] Makefile update libgit.a
https://lore.kernel.org/git/pull.2065.v2.git.git.1759447647.gitgitgadget@gm=
ail.com/
[2] Ezekiel's Introduce Rust
https://lore.kernel.org/git/6032a8740c0ba72420f42c3d8d801e1bdeec12d0.175807=
1798.git.gitgitgadget@gmail.com/
[3] Ezekiel's Introduce Rust
https://lore.kernel.org/git/6a27e07e6310b6cad0e3feae817269b9b8eaed69.175807=
1798.git.gitgitgadget@gmail.com/
