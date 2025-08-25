Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A1123D7F8
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 20:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154435; cv=none; b=r/K2BLJH1EE3ch0txYrJuyj4C3QXanHJLAev3TBJLGE+u41LvqxYKNoQHxus3WNDneDFsJwRo4zHn5PYN911emhr3gb58ylAwGVoWfdQqVlgBMuulkS873oRXzQPkXpoGrKkaY/boumrjzev9MgnPDf+pwRJY1tXlaTjzCCbnuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154435; c=relaxed/simple;
	bh=9L2+rEPswf4Q065mhyAUxUevmyCDVE7a8uEnJ5F8OFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDvve2bhTp8YddFBnoU2bZe1FJEEs0kSLRg6b4CZNrdTP071+qVVU20YfoQIA6Oxct+PKA5a4Qjrlitng0cAxT/uoqeXV3PK+HawkYq3wz/e/KsCONYZUfBlq9XAByePI5LFz4p39IFhaex1SBY744Vioh2V0u9VtgkI1EtuOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iULH491G; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iULH491G"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55f3e4dfcf6so2312430e87.2
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 13:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756154431; x=1756759231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sd1Gr2Q9ZyOiqRzhJeZSWOfncd15RvFHV0Ijmx37jNw=;
        b=iULH491GCYTAcvq6HbnP6xslSchvAN88zo1fWZ4XjODxl7zz90ByjmAu5PQl07jZCN
         +vrL2ZYqqm1PEEPpBqAdITEHzFucSfSS4aTxztZgCT6ETO1GMVEt0Utu9Fkn2vV2fK88
         xtsinMHcZD8W/0yZoEzYPOcf5XxNMpjLweGdtg4T2RxesTpD4UDw4VgHHXPE2cX5PY2T
         6qYDntXdckesldoY4D/nPqlVcYyI3wI0Jq5iTUYK4dxx7QpqZ+D5fXSnl0Tn+tG/gbAn
         3PohsM4hCigEln7gPasPeNn9nySU7pq291IBIAQ7AuzEQUl5i2ADdWMSCtYe4JI3+6SB
         Vg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756154431; x=1756759231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sd1Gr2Q9ZyOiqRzhJeZSWOfncd15RvFHV0Ijmx37jNw=;
        b=k5eGii5gOf1/DkQtLvxtY7bjRHvOkDjQ45xTHGJzvlAGQDLVdel5CQvvHAyYZ1xB+A
         6P6tHUCT2DJovt7zSGNMF/Dd0Hgy1s09yq8T+7+6d3nRGuShivyUkaKxdFnOFa1c+S7w
         Ez6EeJyupAtFZDtKZpaac/XZZumDthF3Qct9sxBeL/69YIBp6Cm5WQ05JZXMqUcoq094
         P2o8aykGP+g57nLfqQJwqHyrveJRHcQgKIh42ggu9Xt/arORSi+J3EsWr6vIkUUvzg6h
         eVrRAXfUP82KhUuooifErrMxjTa3yhbd6GYOLH0PxC7Wg9A1Paj7lIk0KS9FjNczLQnH
         l3sA==
X-Forwarded-Encrypted: i=1; AJvYcCXSMacLAHw8WGKSbmS+IFJQ2VwZb+gUZ4iK7c65cuPvgPHZVKKlYuISwYtoQs2I/yU+4HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlgo6p/c6WNbTU9aGOWfjQLNHWny9cxDyJyleNWFC5XzM1CPg
	siRYxNWDTrFxreg87LZQiKdcrq6OqFpwGHFOTNXv/ydE4ZZKsgrrd+Uh+KTrFnaBgDoyx1ZCoz7
	rYW75lF5MiFNeqiVmuchMX2Z2gt50gqc=
X-Gm-Gg: ASbGncsZkzjcyTc0eeB124SlbTw8Hci6cvBFm+DZjc0+wvXFZa8U5UdW2b9SZCUA+Kd
	D0p4x4rPmZih1VxyRk2XsE4u1MDWasvurdskym41MLXq+Ow6t21Igjqv+lgNMKMwcfyRzDDQ4Pk
	NIJf9tip1y4bDwGMx8MBDvoMJ9njnwkEiuZfpq+G+sVNpKHqDlNLXv9REdrCLcZDqTRG0O+w122
	QO4zQYe45urSMdSuss=
X-Google-Smtp-Source: AGHT+IErFux4+ociUflO5Ni48MFSKzaSdP4bO/ApwKadYG6tUhoJC5dHmD3qpYasjUJX9gtyayJxeZ63MKxBn2dtHdk=
X-Received: by 2002:a05:6512:260c:b0:55f:4b01:3095 with SMTP id
 2adb3069b0e04-55f4b014131mr612223e87.0.1756154431216; Mon, 25 Aug 2025
 13:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <71B2DFE6-77E5-47FE-9FAC-AFC1B85DA0E2@gmail.com>
In-Reply-To: <71B2DFE6-77E5-47FE-9FAC-AFC1B85DA0E2@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 25 Aug 2025 14:40:19 -0600
X-Gm-Features: Ac12FXwVZMfh7tPC7-hylrM82zPTmFNbltxJzssm2Nmwh0n8JnVF9xYUy6tB49c
Message-ID: <CAH=ZcbA=-iEFnJ-TecAZL_EX-f3pAShDhdq=S2XWkQHYgRZV7Q@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: Ben Knoble <ben.knoble@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <johannes.schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 24, 2025 at 7:31=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> I=E2=80=99m mildly surprised Vec isn=E2=80=99t a good fit: isn=E2=80=99t =
it a pointer, length, capacity triple? But it sounds like the main issue is=
 allocator interop=E2=80=A6 which I would also have thought was supported? =
At least the current version is documented as being generic against an Allo=
cator, too.

Conceptually yes, semantically and syntactically no. On top of Vec<T>
not being defined with #[repr(C)] (which ensures field order, C ABI
layout, padding, etc...) the struct definition for Vec isn't constant
between Rust versions. I'd be open to suggestions for an alternative
to my ivec type.

=3D=3D=3D Rust version 1.61.0 =3D=3D=3D
from: https://doc.rust-lang.org/1.61.0/src/alloc/vec/mod.rs.html#400
#[stable(feature =3D "rust1", since =3D "1.0.0")]
#[cfg_attr(not(test), rustc_diagnostic_item =3D "Vec")]
#[rustc_insignificant_dtor]
pub struct Vec<T, #[unstable(feature =3D "allocator_api", issue =3D
"32838")] A: Allocator =3D Global> {
    buf: RawVec<T, A>,
    len: usize,
}

from: https://doc.rust-lang.org/1.61.0/src/alloc/raw_vec.rs.html#52
#[allow(missing_debug_implementations)]
pub(crate) struct RawVec<T, A: Allocator =3D Global> {
    ptr: Unique<T>,
    cap: usize,
    alloc: A,
}

=3D=3D=3D Rust version 1.89.0 =3D=3D=3D
from: https://doc.rust-lang.org/1.89.0/src/alloc/vec/mod.rs.html#414
#[stable(feature =3D "rust1", since =3D "1.0.0")]
#[rustc_diagnostic_item =3D "Vec"]
#[rustc_insignificant_dtor]
pub struct Vec<T, #[unstable(feature =3D "allocator_api", issue =3D
"32838")] A: Allocator =3D Global> {
    buf: RawVec<T, A>,
    len: usize,
}

from: https://doc.rust-lang.org/1.89.0/src/alloc/raw_vec/mod.rs.html#74
#[allow(missing_debug_implementations)]
pub(crate) struct RawVec<T, A: Allocator =3D Global> {
    inner: RawVecInner<A>,
    _marker: PhantomData<T>,
}

from: https://doc.rust-lang.org/1.89.0/src/alloc/raw_vec/mod.rs.html#86
#[allow(missing_debug_implementations)]
struct RawVecInner<A: Allocator =3D Global> {
    ptr: Unique<u8>,
    /// Never used for ZSTs; it's `capacity()`'s responsibility to
return usize::MAX in that case.
    ///
    /// # Safety
    ///
    /// `cap` must be in the `0..=3Disize::MAX` range.
    cap: Cap,
    alloc: A,
}

> Am I reading the patch correctly that the ivec implementation is primaril=
y C? I=E2=80=99m not familiar with too many FFI projects in Rust, but I mig=
ht have hoped we could write parts in Rust to gain any benefits from that, =
too. Is that a fool=E2=80=99s errand I=E2=80=99m thinking of?

The ivec type is defined and implemented in C (interop/ivec.[ch]) and
Rust (rust/interop/src/ivec.rs). When I started writing the ivec type
I didn't know if the Git community would accept a hard dependency on
Rust, so I made ivec usable in C without needing Rust.
