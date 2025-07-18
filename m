Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F98C21FF36
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873912; cv=none; b=IZN7xrcoFA9hbGcp2656PxynNLVp5nZCkmp3blSq7vmtzkmA1rQYrGjUsI9dV+3GKKNHgiXE9Hk9glEUZn8UsVsio+wJSZtP21m7wkyutZCrF4+9l2zpSCfu9JoF+VahTSQVyDwOPMBQChB0x/6J4oGbmQeN3MfQj1eMsaD08FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873912; c=relaxed/simple;
	bh=aKr+vsdDCV55pkGAk73iogdEmMATx4coHgNdY/7egcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oE85qTNtF8AgkIpQA7sbaH0PGB75cMxIkMzu2BO1BD8tVXU4csVCnFRdO+YC2eBrQDeJd7jn3LLBnKskWN3hhOaoVYOJg7UNxIFc6zqE5S/PoqRRVyOo/OW5seWVBuURsIqMOKerSqPGYaw+8m6TCAr9mVTPbot4gYPQThv5WCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0475633BF08;
	Fri, 18 Jul 2025 21:25:05 +0000 (UTC)
Message-ID: <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>
Date: Fri, 18 Jul 2025 17:25:01 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ezekiel Newren
 <ezekielnewren@gmail.com>, Edward Thomson <ethomson@edwardthomson.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
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
In-Reply-To: <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------C6U5U50Hy0RmrWxbhSXUydHt"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------C6U5U50Hy0RmrWxbhSXUydHt
Content-Type: multipart/mixed; boundary="------------DBn3vPkyOxPT3v2TvHFqV7Ad";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Ezekiel Newren
 <ezekielnewren@gmail.com>, Edward Thomson <ethomson@edwardthomson.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
Message-ID: <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
In-Reply-To: <f439958d-64ce-417f-8175-720f69387d48@gmail.com>

--------------DBn3vPkyOxPT3v2TvHFqV7Ad
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/18/25 9:34 AM, Phillip Wood wrote:
> Hi Ezekiel
>=20
> Thanks for working on this
>=20
> On 17/07/2025 21:32, Ezekiel Newren via GitGitGadget wrote:
>
>> So...
>>
>> This obviously raises the question of whether we are ready to accept a=

>> hard
>> dependency on Rust. Previous discussions on the mailing list and at Gi=
t
>> Merge 2024 have not answered that question. If not now, will we be
>> willing
>> to accept such a hard dependency later? And what route do we want to
>> take to
>> get there?
>=20
> As far as git goes I think introducing a hard dependency on rust is
> fine. It is widely supported, the only issue I'm aware of is the lack o=
f
> support on NonStop and I don't think it is reasonable for such a
> minority platform to hold the rest of the project to ransom. There is a=

> question about the other users of the xdiff code though. libgit2 carrie=
s
> a copy as do other projects like neovim. I've cc'd the libgit2
> maintainer and posted a link to this thread in neovim github [1]


A hard dependency on rust for Gentoo amd64 would potentially require
building https://github.com/thepowersgang/mrustc followed by building 13
and counting versions of rustc in order to get to the latest version.
What is the minimum supported version in this series, by the way?

bin packages for rust do exist but not everyone wants to use non-distro
provided binaries, sometimes for auditability reasons.


For Gentoo HPPA, Alpha, m68k it will simply mean the removal (or end of
life and staying forever on 2.50, perhaps) of Git. There is no rust
compiler there.

Even s390 support for rust is limited to a precompiled version not
everyone is willing to use.

GCC-rs will probably fix this general issue.

--=20
Eli Schwartz

--------------DBn3vPkyOxPT3v2TvHFqV7Ad--

--------------C6U5U50Hy0RmrWxbhSXUydHt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaHq7rgUDAAAAAAAKCRCEp9ErcA0vVzdS
AQDO3MJHmceh8VVFIoBDGRIcBoFXJa0Y7m2mcjpItCcPYQD/fVdRCNPswayCpovVEN9TPFi4j5dT
6Iqk32JVvgh0DQg=
=McrO
-----END PGP SIGNATURE-----

--------------C6U5U50Hy0RmrWxbhSXUydHt--
