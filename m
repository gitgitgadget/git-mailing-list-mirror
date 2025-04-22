Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFC8139D
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745283533; cv=none; b=kZbNo4ksseuqOASCAO5qHlYSZxhPnCowjWlpGsN6y+ynK3kEe8pWDpO6AhdfraTYFjwGA+q3lHUSakmpCS10TQCWWQ4qIDKmIU9/O6ndNDQ2+JLf/lLhMyKKFut38RDnp+bmInfhupeiRMUwgon1xnN4DsJ1I6t0CPkCL1maBvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745283533; c=relaxed/simple;
	bh=6WxJlWQ2S3Q3kTrXzNH+NeeH+L+JffReXfGLd1HSf7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AYP/Y2AZ9eDEBIuVBs8mzF/fjOCO64DQ039UwCagOaGuYx0wiULpc/RWDwrIadj6AKMCgbEmTG+VsdeVG+gho4PN/jJ5Q+3m6baQsqFrvRKK/MCcyOWMOj5g765Zhqfoh5dET7zO5afj76lU6UmbDzULbNjot+ADroPg2eJON9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 50AC2341707;
	Tue, 22 Apr 2025 00:58:50 +0000 (UTC)
Message-ID: <f68460ea-2754-466c-8078-ca51bcb291ac@gentoo.org>
Date: Mon, 21 Apr 2025 20:58:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Patrick Steinhardt <ps@pks.im>
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
 <xmqqh62h591v.fsf@gitster.g>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <xmqqh62h591v.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------DscdXFR0X0tUNjOb1toUmm2I"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------DscdXFR0X0tUNjOb1toUmm2I
Content-Type: multipart/mixed; boundary="------------B9Cjf50uLu8DEz0l0g3aPMYc";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sam James <sam@gentoo.org>,
 Patrick Steinhardt <ps@pks.im>
Message-ID: <f68460ea-2754-466c-8078-ca51bcb291ac@gentoo.org>
Subject: Re: [PATCH 1/6] meson: simplify and parameterize various standard
 function checks
References: <20250421175247.240971-1-eschwartz@gentoo.org>
 <83d9fda5-8399-47fb-87b2-a8b376cf1625@gentoo.org>
 <xmqqh62h591v.fsf@gitster.g>
In-Reply-To: <xmqqh62h591v.fsf@gitster.g>

--------------B9Cjf50uLu8DEz0l0g3aPMYc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 4/21/25 8:33 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@gentoo.org> writes:
>=20
>> On 4/21/25 1:51 PM, Eli Schwartz wrote:
>>> This is repetitive logic. We either want to use some -lc function, or=
 if
>>> it is not available we define it as -DNO_XXX and usually (but not
>>> always) provide some custom compatibility impl instead.
>>>
>>> Checking the intent of each block when reading through the file is sl=
ow
>>> and not very DRY. Switch to taking an array of checkable functions
>>> instead.
>>>
>>> Not all functions are straightforward to move, since different macro
>>> prefixes are used.
>>
>>
>> By the way, when reviewing this I was having a slightly hard time
>> figuring out which stuff belonged here... specifically, because of the=

>> differences in macro prefixes lead me to believe it's not always so
>> simple as "does it exist".
>=20
>=20
> As there are non-zero number of meson related topics in flight, I'd
> like to know where this new series is meant to apply, if you need
> some of them before we can apply it, and what is the overall goal
> this series has ("there is no theme, they are just random set of
> changes to do such and such things" is perfectly acceptable answer).
>=20
> And the best place to describe these things is in the cover letter
> [PATCH 0/6] of the series.


My apologies. There was no big theme other than that they were things I
determined were relevant to more closely match the Makefile
expectations, while investigating a badly worded report (in fact, a
wholly uncommunicated :( local patch ) of git not building on Gentoo's
Solaris environment ( https://wiki.gentoo.org/wiki/Project:Prefix )

e.g. I simplified the repetitive lists because it made it easier to do
the followup patch adding a new check for getpagesize (which I needed,
because it needed to be checked on Solaris).

I think that I sort of subconsciously assumed that "if in doubt, assume
it's independently developed against the current state of the master
branch".

I do not need any other series merged, I think it should apply to
`master` independently of all of them. I can't see anything available in
origin/master..origin/seen that would clash, at least.


--=20
Eli Schwartz

--------------B9Cjf50uLu8DEz0l0g3aPMYc--

--------------DscdXFR0X0tUNjOb1toUmm2I
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaAbpxwUDAAAAAAAKCRCEp9ErcA0vV5fV
AP4nZaSkd9XqsGhVP1fFjwN/Ppb+uANmcMxJo081i3qYRgEAlogCqxwghJDB3OvgnV1F81qCaP5D
+GUAab1taVsUHQU=
=M/i9
-----END PGP SIGNATURE-----

--------------DscdXFR0X0tUNjOb1toUmm2I--
