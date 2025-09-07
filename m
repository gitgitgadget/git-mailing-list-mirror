Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C1522F74D
	for <git@vger.kernel.org>; Sun,  7 Sep 2025 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757275650; cv=none; b=blKwQv0cR25MKqswpltMD9TyUcHNOmbjkDOP/mq/SrSj1ueKhCAlBs7spkTRYtJmbDv/r973VKnyAO1V+XTaDMU3bhs8RT5BcEjQzvrCrgF+ZzbVOH5Ecq3kd4+runFJASmBqqiXxjhAjD2NfVoIjs1Bv1CErRC4z7TCwcpfenI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757275650; c=relaxed/simple;
	bh=WCefACXZyKrKYBEhNASyISv5V+t87SrRTo5f0sonw4U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=Z5TrTAoHZD6AuDzPLH7PJgsmRQYGImDuEsoH44T4g3HFoGtuW5FupoMOGIzwDhIhQBIOnUasoFNfjx1Fwc8QQSHYN6qdyoLQZr15m4PGE+5oH3HUrK4HXwLkuLc8QXbBblQPFOijGaMwsW9DuG5i4aAw8mNwSMk9+yH4YxDTfXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2TDgLoQ; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2TDgLoQ"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-ea059954d52so401109276.1
        for <git@vger.kernel.org>; Sun, 07 Sep 2025 13:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757275648; x=1757880448; darn=vger.kernel.org;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ecuzf5CyhuU4X5ACuYUrjIVsjK5ifKQIH6HfxAfEDH4=;
        b=c2TDgLoQuL5wk7EfVEn/kVpelXaLgKwk6KLIBR7JlB0IowuT+sJRH33wDkjmVmAlaQ
         CsPqC+LGEDavXo/FG17OvQSjAslG+wF1zxf0VjbA8PYANUhApB3cdGmUkCXN2P63ik0o
         Wl2R0dbwX3sNyEjn2K3Bn8ZJOZ3UuzrXCCbUFYXPDMxL5uneKrbBI+WMyXtgylkgeZOZ
         IaAdOo4yDh+OKFeoQBt7Flh3wVHwP08QmvRjbF0PeQmAvGDSTdGsfsxNtkE4ugjxGan3
         Xc8BlydAkw839hhzzn1rvLHC39zY7XXeMR2hHSStbvyO+j8OCyxF6XCqNyMYbMAJi3Q8
         pXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757275648; x=1757880448;
        h=to:references:message-id:date:cc:in-reply-to:from:subject
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ecuzf5CyhuU4X5ACuYUrjIVsjK5ifKQIH6HfxAfEDH4=;
        b=YZe8Q3mwGaeJhe9mMqtyDeeBil9cv67qgFFGg1ybnNf6pGsdDdmE1yzGtjW7vxd6l8
         wTaKYWQpFRMs56SsCVaIfsmrJdI8uod+ARQh8YR+TqQRF2F72dKqte+jzFXdJswPU/bm
         MRsTQRQHIYPtT/rD+UjgyGb2m6wl2okY+p38yNvOmZHPGosOBJe9CDCQZI6ZmvzcGOjZ
         +bLTk5CkMV/P3/JsO03WXFB+y8fId2IhQLxmbeyWITSC1ATNam0SiAySAdixY8avYPRh
         /pKtmfEyMzYkBA5DOlrRIERrR8MrgmjqQtp+0Fcaumvbck5Q4s/mNatUb70zfGW9t3gu
         wigQ==
X-Gm-Message-State: AOJu0Yz+kwrTDMz/46G2DRV+gzXHakZ2RgIfKTRxi2j01WRxo1BDIyO0
	z7Dchhc4kWm4DPrrEEE0vmGwNdCZFYo2c5G7KCx28Us5a5FxcLSjwm8n
X-Gm-Gg: ASbGncus8VuC6hhG3bc/6eoKdBjOQAISOcl5AuA8964s/0yy5F+ALFgJi1LwelXEjU9
	YAe1rzCqCtgsUwhzCScgXtgzmiXS+I7w/OixiSXUK5x+IychVy26ZkgXQvvly+sJ8wDpWylfCan
	uWhYJ5LwpCk+beitpdyWzr3dz54zZdiyGbFJwIGfV5i3no2SHhL44IyPUdSjpsXf+mPgAfKVrRR
	a1KpaE5ScIEyaddZYczDDN4bKPtcWxdnf3pZwnAaWSlxCN+br/tBfzUxYxfY9+aV+ZpTc2JBhHJ
	UrFxsi68RnxFIl0wLd6AeYnBrtNR6JRoB+6Ypk3medXRYFSTHeQ0ojkwz8PUNYMkslNqc7lngxR
	9gUTzjnnL1KL1V1d2HthDYQHx4R8nDANiDgh1LpB2vqruPSzp/1Am5ugFNzK1CA==
X-Google-Smtp-Source: AGHT+IHJm6wjZCJiT8b6TAzktCYMDaWU0WM4l5/+qkqxD3J6oyNOI40fmEyshMVwwO0Z6fQyY8jGPA==
X-Received: by 2002:a05:690c:7108:b0:71e:715b:a988 with SMTP id 00721157ae682-727f583dd24mr50084287b3.42.1757275647956;
        Sun, 07 Sep 2025 13:07:27 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:656a:2d24:478f:190b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8324cb7sm45967207b3.17.2025.09.07.13.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Sep 2025 13:07:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint" subsystem
From: Ben Knoble <ben.knoble@gmail.com>
In-Reply-To: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
Cc: git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>,
 Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
Date: Sun, 7 Sep 2025 16:07:17 -0400
Message-Id: <8A7DBC60-286A-48FE-A3D3-CAFC11FD3AEA@gmail.com>
References: <20250904-b4-pks-rust-breaking-change-v1-2-3af1d25e0be9@pks.im>
To: Patrick Steinhardt <ps@pks.im>
X-Mailer: iPhone Mail (21F90)


> Le 4 sept. 2025 =C3=A0 10:27, Patrick Steinhardt <ps@pks.im> a =C3=A9crit :=

>=20
> =EF=BB=BFImplement a trivial test balloon for our Rust build infrastructur=
e by
> reimplementing the "varint.c" subsystem in Rust. This subsystem is
> chosen because it is trivial to convert and because it doesn't have any
> dependencies to other components of Git.
>=20
> If support for Rust is enabled, we stop compiling "varint.c" and instead
> compile and use "src/varint.rs".
>=20
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> meson.build     |  5 +++-
> src/lib.rs      |  1 +
> src/meson.build |  1 +
> src/varint.rs   | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
> 4 files changed, 98 insertions(+), 1 deletion(-)
>=20
> diff --git a/src/varint.rs b/src/varint.rs
> new file mode 100644
> index 00000000000..3d41760a555
> --- /dev/null
> +++ b/src/varint.rs
> @@ -0,0 +1,92 @@
> +use std::os::raw::c_int;
> +use std::os::raw::c_uchar;
> +
> +#[no_mangle]
> +pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> usiz=
e {
> +    let mut buf =3D *bufp;
> +    let mut c =3D *buf;
> +    let mut val =3D usize::from(c & 127);
> +
> +    buf =3D buf.add(1);
> +
> +    while (c & 128) !=3D 0 {
> +        val +=3D 1;
> +        if val =3D=3D 0 || val.leading_zeros() < 7 {
> +            return 0; // overflow

Hm. I thought overflows panic in debug builds, in which case checking afterw=
ards is too late? Does unsafe change that?=
