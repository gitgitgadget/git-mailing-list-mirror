Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C031879F5
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 01:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915129; cv=none; b=hbLQz6fuLfZkDeaZPs8RtWCFpHHJYnbOaO1si3+WAF3cJ2AzUYh14KdrJVmi9m2WjpoJ7bCbDUhA7KWHV0OqejULEp4h+UnzIHiX+Hw5iksmlAiWroptlA7TVivTCrmpEX36vdDAt4TYB7932XyeVuu3eLvADw8YzXQp1TO01nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915129; c=relaxed/simple;
	bh=Drbhqb0i6GOjYSlMGZCdXWcjj4oyZ2yeL6XdHCtavHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2LJKbK7bgXUzmMinI4o+BEIdpv4Dz8/hWfInNyeh7aG2HflunXLmkITqRy4vRvth+9wkDEy4dW5lcphlpzf8IYr3vxCQozpGmnUM1Q4vCifnhQmUQYt7iFIwn6qdOP3mNaKYTl03LiZfBiefOsK8/X0C2Djh02fzV6WJXayI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VYLuyhRJ; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VYLuyhRJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1741915124;
	bh=Drbhqb0i6GOjYSlMGZCdXWcjj4oyZ2yeL6XdHCtavHE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VYLuyhRJ6e51P8V35xlfTfMl0eB2gci1DU2KqHwaKEdhmWwabjGiaG7gn12Vglozw
	 nFqZsxA9zjSQSiL8FBCs1jxOM4TW+hbxT8yhWtVIGD2GgQvwG/bAKWUKTv9VPBccFf
	 ynS9et3A0AEr4IaxUTgB+X2G8LNEUBVJdlXJuyDQkn8ctPcBcOtT7tl0qjuRsLZ8ap
	 dggd6pX47ZpG5uVEAV8Bj99Nv3gq7lLmrJT4gTv8CDOntoR2PrhUiCmQz/x/n+BLGK
	 JLIGwQlLHNDn0pQLbxHBGe9iYI0QxXjyy36Uc4bWij+iy7UC4mUe2Zo/c0T0262Tjl
	 ysK0kIKAlUWrzl/Ibqgn4cAQmMffdczZYg5iVqXJr0ONJGx0uIjtleB/QtXQWwdMQ8
	 zG3i4My79itrKofonynMepYfCkhoGapRnFyhOO5yJV7uB673Oh845hdyN0pUsYaF5t
	 x2lUICtSLSnf16umXOKJHep4dwyqvqgkNJMke7+tqvQgN6rz/8g
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2006920073;
	Fri, 14 Mar 2025 01:18:44 +0000 (UTC)
Date: Fri, 14 Mar 2025 01:18:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/3] ci: add build checking for side-effects in assert()
 calls
Message-ID: <Z9OD8ihB-tiCdBmp@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.1881.git.1741911652.gitgitgadget@gmail.com>
 <80dcc2ba3aa0ef72abe18f8525d571ea39ac6382.1741911652.git.gitgitgadget@gmail.com>
 <xmqqy0x8l8tu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R7RoNmHPaGORmKHC"
Content-Disposition: inline
In-Reply-To: <xmqqy0x8l8tu.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--R7RoNmHPaGORmKHC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-03-14 at 01:06:21, Junio C Hamano wrote:
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > diff --git a/git-compat-util.h b/git-compat-util.h
> > index c3415ad7e0a..0aefd763751 100644
> > --- a/git-compat-util.h
> > +++ b/git-compat-util.h
> > @@ -1584,4 +1584,10 @@ static inline void *container_of_or_null_offset(=
void *ptr, size_t offset)
> >  	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
> >  #endif /* !__GNUC__ */
> > =20
> > +#ifdef CHECK_ASSERTION_SIDE_EFFECTS
> > +#undef assert
> > +extern int not_supposed_to_survive;
> > +#define assert(expr) ((void)(not_supposed_to_survive || (expr)))
> > +#endif /* CHECK_ASSERTION_SIDE_EFFECTS */
>=20
> Cute.  As this checking assert is in void context, the optimizing
> compiler knows that the entire thing can be optimized away ONLY IF
> it can somehow prove that (expr) has no side effect.  And if it does
> not optimize it away, you will hit an error from the linker, saying
> that the undefined variable is being used.

I agree this is very clever.

> This requires a fairly good optimizing compiler that can peek into
> (as in "inline") what is in expr to notice, so it cannot be free of
> false positive, but at least when the optimization works as expected,
> it is provably (modulo optimizer bugs) side-effect free.
>=20
> Is this something we can use in our project?  I am just double
> checking.

I believe it's valid in C99.  Certainly some compiler might be bad at
optimizing, or a user may have compiled with -O0, but this is run in CI,
where we have known good compilers and can control the optimization
flags.  I doubt GCC, Clang, or MSVC will have problems here, and since
this is not on by default, users using something less capable (the Tiny
C Compiler, maybe?) or a vendor compiler won't even see it.

Was there some other case that you were concerned about?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--R7RoNmHPaGORmKHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ9OD8gAKCRB8DEliiIei
gXJHAQCRZn48iMU76DWPg5xTyrAe28FwPue2bBr/8P6QdK46YgEA6sAo/twm/3ae
ZuGEGSOiZDlKrstQqJ+nUQEkz+EdTQE=
=2FDB
-----END PGP SIGNATURE-----

--R7RoNmHPaGORmKHC--
