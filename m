Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26B21F3FED
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 00:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757379000; cv=none; b=GU+SpXqJzKCk4SqFRa8lhC1hnD7h1o+ZsxXaZM1Mr2EjZonI0EVoYLAGE9huuqGLblM2i70+wxbQxwG9LHlgdDupBQpHjgSoxxRYzDuc5N1y9q9ReGcFiinZKvTK0sYgjXPhVdVW94epbHLd9s7e0V3E4M8BwC0afqzi7UV2T94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757379000; c=relaxed/simple;
	bh=/zfnvIQuDvDo+89GKLuOBhprSX/h09j3Qke/i00HrAY=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=nWshFcOgpICb/95wy6LvapX43Kp0AOfysNvJdx4Rrbn9FY0VndXmKxoKJVeQVCLqVSdkN4lVfUMY7twRzxN6mwGcxfDwN+4xOmv5C0hPx6WZtcUSkBwPxVmbxGkVue5lMo4nAqL+NO8jvJT82fdzY7jNsQ4F/0u/opW8GYFvwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhXSvBxI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhXSvBxI"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e96ff16fea1so3913612276.0
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757378998; x=1757983798; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YMnyYVgCg3qKF+PPve252RMoYWr6JBdmF8IU6PuvgMQ=;
        b=fhXSvBxIGZDzPXbDVG106k3VOyBwXbo9qI07V0957GRMkRH0r1K6ka9AUQXnT75Sh6
         JUsyOfkQr5/3r2ECQsWYSd6W8t5K8HAjxAPriMtOWuuRak8ium3ASk4lOH+VqUYuxdnR
         bxpnhBg8gv0Hgja33nTlrJePLRUGcrrGQr6Z17oXXbJhEXrCsnx6JsKTTQC/Lti4uRMW
         V+XOnbplLicBg4L4w3APy+ljXDtiS5B8pIpW45CzS0ITkx+0SjVAb1gpdJZNrz6QP90T
         VwSvcFmxj9fSWVt2czbT2pY44mTVubQIMrl+l7irJR9eK7xSMURwK+jJkytopm4UHdl2
         i2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757378998; x=1757983798;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMnyYVgCg3qKF+PPve252RMoYWr6JBdmF8IU6PuvgMQ=;
        b=r2MDFOluHXEq0K8oljbehf9DqCZmZLWvBZFBVd0xRQlmHZbYo99MgfYkxpL0To6/ju
         AkozxXwc3946dTfiFVtYeJvv2JzRkrp5QKws7XSYTGALrXHlWtFwqQMqexBrjtD2PmY7
         c/gIipWfnu5N/U92xwE9onuetnZOZv2IUFo1PCDXnmkJxqvZrOs3/qNJce0ZNc/Gycvw
         9d2n6I6GFCuJaN1OqgmKNJHjBqG4lp5uZtmFd+/1jz409IRPXH37Xl0LdEcotSPpJ4XZ
         esRcQr93ooUFCR99GFoirycy/KPG8AEyaY6pANM1ZLyp4RtD6HRLDKTIRFnzFfK7Q4mn
         YyRA==
X-Forwarded-Encrypted: i=1; AJvYcCVv+bwKD/iYCMmtlUGaix+rrpJPvadraLBl9rvpDoNPBLsNoSc1qQlqg9QpbCDJ2Gm7nM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX1JZuz6PtXnEDcawQ+xjbnORMB6+LuWw08tMSB/IH3+cKUani
	k9aob/wM/lSOCIghuIOLOBc3zX4YhFpFCoZW1eSVyvH8UwgR2WXNXg/z
X-Gm-Gg: ASbGncsvrtJtkuXG5aW0JPSY5cLW0zTXf7rBZt6FMGv0o0JQGnVMfQFIHOjdIoSNinY
	Bno9w3AN7TnN8uViGWqntUkvBRiW6jE47EamvPu+hPRln4pOTJ8P0M5LC1sOBS2JOafHfZDTXjd
	zEOtg4b/dY/Zfvf1O3LTYQVXcronwWHblS2E/MHK1rGUfCiiAej9frkAt+Ytsih9r16QginskMN
	BWBJfpuUtwl7iRBJLA23zv5pd4O7rQ4+HLboQZMFc8nPCkNZdodIBmOgvFhkkiDs8So0SeSZkcm
	F5SlPpFQZYfx9Rh+2gRnqz6rkuLy11lFtm6mmgZ+R1BX273pM7ZjLVTfUl1fIuHLYGOHjU+vu46
	WImuqojosrm2u8XWfET+wjre/hHug2j1+rQLHJAMC1I26Cvd3Au4k+lA=
X-Google-Smtp-Source: AGHT+IFci0q2E/OPJnoA+XNJdEK9/enbSJCQYekPN9tmP5IgEDgw+1STFP2I9rAZkJgSvozrG7rKQQ==
X-Received: by 2002:a05:6902:1892:b0:ea0:5995:4a02 with SMTP id 3f1490d57ef6-ea059954dc4mr5828221276.8.1757378997628;
        Mon, 08 Sep 2025 17:49:57 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:11c5:d173:855:6516])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbe05caf7sm6079304276.18.2025.09.08.17.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 17:49:56 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC 2/3] rust: implement a test balloon via the "varint" subsystem
Date: Mon, 8 Sep 2025 20:49:45 -0400
Message-Id: <EF337F13-64D2-4A17-BF7D-FE77E3064E35@gmail.com>
References: <xmqq8qipzhg3.fsf@gitster.g>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>,
 Eli Schwartz <eschwartz@gentoo.org>, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>,
 Sam James <sam@gentoo.org>, Taylor Blau <me@ttaylorr.com>
In-Reply-To: <xmqq8qipzhg3.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (21F90)


> Le 8 sept. 2025 =C3=A0 00:39, Junio C Hamano <gitster@pobox.com> a =C3=A9c=
rit :
>=20
> =EF=BB=BFBen Knoble <ben.knoble@gmail.com> writes:
>=20
>>> +#[no_mangle]
>>> +pub unsafe extern "C" fn decode_varint(bufp: *mut *const c_uchar) -> us=
ize {
>>> +    let mut buf =3D *bufp;
>>> +    let mut c =3D *buf;
>>> +    let mut val =3D usize::from(c & 127);
>>> +
>>> +    buf =3D buf.add(1);
>>> +
>>> +    while (c & 128) !=3D 0 {
>>> +        val +=3D 1;
>>> +        if val =3D=3D 0 || val.leading_zeros() < 7 {
>>> +            return 0; // overflow
>>=20
>> Hm. I thought overflows panic in debug builds, in which case
>> checking afterwards is too late? Does unsafe change that?
>=20
> This code is a very faithful conversion from C so if somebody does
> not read Rust well, they can safely refer to the original in C.
>=20
> In either variant, the leading zero's check asks "can we shift val
> by 7 bits to the left?" _before_ it actually shifts val (and or'es
> in the lower bits of c), so the "overflow" check is "if we processed
> any more data we _would_ overflow, so we stop before overflowing".
>=20
> IOW, the code _is_ avoiding the "too late" condition.

Maybe I wasn=E2=80=99t clear, sorry: don=E2=80=99t we already have overflow i=
f after val+=3D1 we also have val=3D=3D0? In C with unsigned types AFAIK tha=
t=E2=80=99s the normal modular arithmetic, but I thought I recalled that suc=
h (unsigned) overflow panics in Rust in debug builds (not in release).

So that=E2=80=99s my =C2=AB checking afterwards =C2=BB above.

I=E2=80=99ll see if I can double-check my memory though.=20=
