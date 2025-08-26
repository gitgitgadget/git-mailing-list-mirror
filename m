Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B3B13FD86
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215048; cv=none; b=VYixB1cO2pFe6TLB5OL+ZghZu3ibH8A2kEaB6AW/XzVa5UidOwbIKQ5BzZDE2RRX17yRgj2e3UDPCFxp5tzYTkccuCoWzjw1yCtrQXxIR8IcYmZpU0IOtXeXWYBK18jzZBTp28MUakwKrYufQKKZ4tJaWKiJoEc8uB4TD5ccHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215048; c=relaxed/simple;
	bh=0RnF3LklZcYG05C7RUTFXbD5KKH04S/AR/qD007sykA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCtG6R6VDQLxaOPO1nbFvwO/jsSaJPGqT3DEnVS/1Ac54duinCUkJ36zaUVOYYdA3W32iiNGo3LjajcIHfAvCz0vnFkKrM5c1CpRCL8fGuoUCn4Xo/mYG+QFSKBGJbtVCe4YBcI1bEHXxfyJ0rwKgj0+IqH3WDUCaT21Udo4zcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHo5ywFc; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHo5ywFc"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-61c26f3cf0dso6288962a12.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 06:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215045; x=1756819845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RnF3LklZcYG05C7RUTFXbD5KKH04S/AR/qD007sykA=;
        b=bHo5ywFcb4F7i1ygMaS7VChlne7aliuTnSkMP3FgQF2xjn910hTxSIDONEocJa3L0N
         dm5SI4kWkNxJtElOHiO88ctjoYloNieyqis9glk2dyXSHm8/A7Yqmf9KP/yqd+tx0fbE
         2MIPW3oyIZh+GO2Rth3tlnxPmdGF1408XgH0lVs62kJJ1HHap5I01RwP6DX/CGOJ5q0k
         wE74rwOWLocfRyB5qDeqeeqlRAoH5WbX9y+jyDUeMMhwl1LmkSgMcErNRgBzweD2+pcC
         wvTSGvC/hEaCCVk8dIwL9EsWMMqoN8DJ7H2NHV8x3r4HJkUnGDfehPvKf8xw0C6xzHAs
         EBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215045; x=1756819845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RnF3LklZcYG05C7RUTFXbD5KKH04S/AR/qD007sykA=;
        b=sjPbYQrE7b2CYwXV8Uznz3gFhIDUfgHfnIhNXIkymflQ61S6Rfz5SYDFskqbfjTzYx
         ZS36XaBP+Bak0dIi6pO9P03ve4v9S/bLNjDOAyU2A/vbebpO7R++ev8mrxq2gkVsCxbP
         KwOToZLqa9+IMA1znN25x8lAhwCMa0Jjnyz9mVWkeE7KimjgHY6gH+e4BYBPMiegYasa
         P8lFPeKDYGrJmtD3yF6cTY+4b5iShdaOmQeCl3Eu8LLpdOeCWh9KA22w/AtCVWVuIHCX
         aEjQUzlBKlEZVTXP92o5UC5U9bGViIb5QoliGeTc8rgyTs8KI/707pXz8QPwCl/nAfi4
         MnDg==
X-Forwarded-Encrypted: i=1; AJvYcCVcgbA2Uxtek7/JpUL/OTByvu0vEmhILVl0AsPF+3MdraWpgnlFuYh5YnzKhIvqdZxrLxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfw1ZWvObMzfBn4OtU+KE2zkjyR72TwJn91JB0tRGOHvzITDLE
	SDcM+RzoJTmyIEeRDOimR+n6uYFALZUQQyE/9nP5MAKAN6M+HvyAEaspq70syDkQRhj4OGRkBvq
	03rU9cO348kZ0/x6XpqcZEVlW6+nniftMncAM
X-Gm-Gg: ASbGncu489aTSG1YnFiTX4sVP46j/unBXmMqJ6vj2kQI+s5eq4vG3TpueIXtQZw72Ym
	b0a6zj1UD3/FW7uZHMTvDkKvuzZe7z+kNNaikwYh7UAPFcgmP5yvdfH+49FX2UASlRIUHAdH32Y
	+/Nnh4ouUF/vtFeES7cA6AnL3s3VHPLZlN6XlkIt16DP6g6cJzzf5JB7g5rbCEsja9AEJjqXy+p
	chJ/RekuAzY7YgRTmySUlrExKtuXzwK/vG8hWMh07lMOPlleTbV
X-Google-Smtp-Source: AGHT+IE5V3HIo8Y5HQ+FwDPvI3uIn1gqi38pJpOZ8f+6e2KqCTZcXk94k5sEuJDgG4eyII158Dr4+ByCkMBuVr0d7b4=
X-Received: by 2002:a17:907:3d4c:b0:afe:69ec:dea5 with SMTP id
 a640c23a62f3a-afe69ecf359mr949627966b.0.1756215044858; Tue, 26 Aug 2025
 06:30:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <db5d22b188740bcb830e4ccf7f19dcc4e6b557bd.1755921357.git.gitgitgadget@gmail.com>
 <71B2DFE6-77E5-47FE-9FAC-AFC1B85DA0E2@gmail.com> <CAH=ZcbA=-iEFnJ-TecAZL_EX-f3pAShDhdq=S2XWkQHYgRZV7Q@mail.gmail.com>
In-Reply-To: <CAH=ZcbA=-iEFnJ-TecAZL_EX-f3pAShDhdq=S2XWkQHYgRZV7Q@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 26 Aug 2025 09:30:30 -0400
X-Gm-Features: Ac12FXyJUslVy9-Y-ZE6AE7t9AMxAntBUBNE2XvKB0TGieSrJ-kl-hU5tGB6C_4
Message-ID: <CALnO6CASgMQ=cbQ_ijWXV0RMMSZgvS47r8ucTro7Wc4pgZ9_jQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] ivec: create a vector type that is interoperable
 between C and Rust
To: Ezekiel Newren <ezekielnewren@gmail.com>
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

On Mon, Aug 25, 2025 at 4:40=E2=80=AFPM Ezekiel Newren <ezekielnewren@gmail=
.com> wrote:
>
> On Sun, Aug 24, 2025 at 7:31=E2=80=AFAM Ben Knoble <ben.knoble@gmail.com>=
 wrote:
> > I=E2=80=99m mildly surprised Vec isn=E2=80=99t a good fit: isn=E2=80=99=
t it a pointer, length, capacity triple? But it sounds like the main issue =
is allocator interop=E2=80=A6 which I would also have thought was supported=
? At least the current version is documented as being generic against an Al=
locator, too.
>
> Conceptually yes, semantically and syntactically no. On top of Vec<T>
> not being defined with #[repr(C)] (which ensures field order, C ABI
> layout, padding, etc...) the struct definition for Vec isn't constant
> between Rust versions. I'd be open to suggestions for an alternative
> to my ivec type.

Ah, thanks=E2=80=94I had forgotten about the #[repr(C)] needs and changes. =
Makes sense.

> > Am I reading the patch correctly that the ivec implementation is primar=
ily C? I=E2=80=99m not familiar with too many FFI projects in Rust, but I m=
ight have hoped we could write parts in Rust to gain any benefits from that=
, too. Is that a fool=E2=80=99s errand I=E2=80=99m thinking of?
>
> The ivec type is defined and implemented in C (interop/ivec.[ch]) and
> Rust (rust/interop/src/ivec.rs). When I started writing the ivec type
> I didn't know if the Git community would accept a hard dependency on
> Rust, so I made ivec usable in C without needing Rust.

Right=E2=80=94I saw both implementations, but it looked like C did most of =
the
work, which was my main question. Re-reading, it looks like Rust does
more work than I thought (with implementations of insert/push/etc.)

That said, I think it's sensible to leave the type useable from just C
unless/until Rust becomes required (and then we can move things over).

Thanks!

--=20
D. Ben Knoble
