Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17115B96E
	for <git@vger.kernel.org>; Wed, 29 May 2024 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716961797; cv=none; b=KZZBm5IHNqjCoPC+rFfCuKbBz7GJuuDbEuvK6bK8dAbziuB4aXl2rsWj9FXzEVngAHct4FMky31H8v8cqUD6GDZWvTYUwP4y8OEPnbajsEtgBwjjcrGZ6cdBdhVbafBXvGcwzIXl/vmCcWgoW2ngAsx7KsioAhl2/UhIuGee5BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716961797; c=relaxed/simple;
	bh=P95kGpjYKRaPaOfD5JvE4bFKEDh/s5GttejFuAXyc9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wcv+vDOIoIICk05n04zHuuaawcY+F6K4fPZE7LhC88GZaYjl2pLL4romn6yAP9M4+bROKEhH8qqAwWJVyCXBXvDvm7S21yl/lOZ48KWWIuFE7WJ8ui8YifZlwaXxxkTepoDG/RCied6dU2BPukKpMJ00jReXnXxVcupCZnEj3Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q+w3UU91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d8MrBwj+; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q+w3UU91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d8MrBwj+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F1A6B114006D;
	Wed, 29 May 2024 01:49:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 01:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716961794; x=1717048194; bh=Lopx1YVwK/
	YVoSoVw0ci9bkPUner3W+BCxBP5UFiRMA=; b=Q+w3UU91PSwbFAV2Jt62MZgKhy
	oQj/UnOqRJDBTu3X1uSglpJjVV0AhA1t0lvCn9+RUSiUe++Lcyn9u3N6Dm/Xe8Y9
	jvUz9IK8pk33IN+TVNwIl0eRxQnpr+2U0eirWYOopkyCNW6SwCl1MWr/3lbDhTRc
	oP+AGKp04Nicv09HDEM/EaGpdLIXaQV3HDEavAf97QWji/9nO4G0/OWKxbp8kiMK
	0G+Mkfqvz2dAQtC38M/DWU6fUM6jQMStwFHH50z3+VLmqFfCxPlFBBeyWExzaOeQ
	5ODChYAvWHVBJkmqmLH4v/sZzsp8P9N1nOlZa9GHamQlA8j4edKpcQOEyLGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716961794; x=1717048194; bh=Lopx1YVwK/YVoSoVw0ci9bkPUner
	3W+BCxBP5UFiRMA=; b=d8MrBwj+DsZyMRG3uK6XD5/QwnxAYPAxcgamA+GliAFp
	3nwpClKvYuxL34KQL2+ZqOuNw+U/08A6Z4fsSkisnhPr5Im2zqBmCXi0VnwNZIHh
	lOOBRQ27kU/uIkto2watCrof1nal7in1qBuGrCWzD0/1OLGhHPLuyjAwIzFRJ48k
	1ga1sp9XQFBGfpz+8HTcrWyjZfIVDLhNdvhlLZYNW3tWeazmQpp0INJl6qtLt9KD
	wtRdHAJiQr2BbidL7hpMqUoxFN3vEOLDcef8FMwqNy6sYmqkFo+x2sqnOUf8ZxTN
	kVngS9PVTHsllT374tNQRSDLdd9+d4HZyjEaphGK6g==
X-ME-Sender: <xms:AsJWZmUCTKiEtLGB7QPC1kCsT2HUwEQMOk-ETJ5DCIoP9etd0L-afw>
    <xme:AsJWZinflQX18eywS6IZ4AMduGh3jANtHqHiEQFC8RY2O72SodvcwQoq3Vm60myn-
    ENfADj4VWXV5VZewg>
X-ME-Received: <xmr:AsJWZqYye0apPGWb9GKWwUcH456gCnnAkHC-cedOR69yzWvALtVW0J4SVH2BWbOlB0EssnVfvV644eZ0vNHUh-cwGggNAOJVApMCKwjFohgnANm2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejledgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepvedtteektdefjeevhfegkeffjeetgefgieetjeeguddtgeegfeevheeufffhgfev
    necuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:AsJWZtUg4ZsJDYTw3QChwtBahSBCoGl7AM-PSW4p6OqrTojaIVeY4w>
    <xmx:AsJWZgkd-ti5piNwLgvKYTYWaC148leGwv32uM37hmyt3ow5Q7rruw>
    <xmx:AsJWZicPxysRpq807oSEStHPWc1YGTWPvxgVMdwfuO02cHsw5Lv6kQ>
    <xmx:AsJWZiEP8LcuUHfEOdU7nmmYCquT3RhN1NhU20niWEAI0dZXYAHU3Q>
    <xmx:AsJWZqWFyQffyytjbW1vQ5g5f6wPU0UVgmUmokzwqFuUSWjfeXt78WlV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 01:49:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d7444728 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 05:49:38 +0000 (UTC)
Date: Wed, 29 May 2024 07:49:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH 2/2] Port helper/test-date.c to
 unit-tests/t-date.c
Message-ID: <ZlbB_T8DkgmPeWQp@tanuki>
References: <20240205162506.1835-1-ach.lumap@gmail.com>
 <20240205162506.1835-2-ach.lumap@gmail.com>
 <tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn>
 <xmqqttkquxes.fsf@gitster.g>
 <ZlXaDWy0lQA1FM7d@tanuki>
 <xmqq7cfd7ut0.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dbI5hzJC/16n2kOf"
Content-Disposition: inline
In-Reply-To: <xmqq7cfd7ut0.fsf@gitster.g>


--dbI5hzJC/16n2kOf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 09:41:47AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > As I was debugging other Windows-specific issues in a VM already, Chris
> > asked me to also have a look at this issue. And indeed, most of the
> > tests fail deterministically. I also found a fix:
> > ...
> >     -	setenv("TZ", zone, 1);
> >     +	_putenv_s("TZ", zone);
> >         tzset();
> >      }
> >
> > I have no idea why that works though, and the fix is of course not
> > portable. But with this change, the timezones do get picked up by
> > `tzset()` and related date functions as expected.
>=20
> The header compat/mingw.h already talks about implementing its own
> replacement by making gitsetenv() call mingw_putenv().
>=20
> gitsetenv() emulates setenv() in terms of putenv(), and on Windows
> mingw_putenv() is what implements putenv(), so the difference you
> are observing is coming from the difference between mingw_putenv()
> and _putenv_s(), I would guess.  As the former is isolated within
> compat/mingw.c, it would not involve any additional portability
> issues to redo the former in terms of the latter, I would imagine.

Ah, thanks for the pointer. And indeed, `mingw_putenv()` uses
`SetEnvironmentVariableW()` to provide the functionality. This is what
MSDN has to say [1]:

    getenv and _putenv use the copy of the environment pointed to by the
    global variable _environ to access the environment. getenv operates
    only on the data structures accessible to the run-time library and
    not on the environment "segment" created for the process by the
    operating system. Therefore, programs that use the envp argument to
    main or wmain may retrieve invalid information.

So calling `SetEnvironmentVariableW()` will not affect calls to
`getenv()`. See also issues like for example [2].

This works just fine for us because we also stub out `getenv()` to use
`GetEnvironmentVariableW()`, which is its counterpart. But everything
else in the C runtime that uses `getenv()` will not see the new values,
including our date-related functions. We don't ever set any of those
environment variables though, except for now in this new unit test.

Now the question is why we use `SetEnvironmentVariableW()` over
`_putenv_s`, and whether changing it would be safe. If the answer is a
strict "yes" then we could do that, but if it's a "maybe" then I'd
rather not want to change it just to make these unit tests work. In that
case, we might aim for a localized fix like the one I have posted.

Patrick

[1]: https://learn.microsoft.com/en-us/cpp/c-runtime-library/reference/gete=
nv-wgetenv?view=3Dmsvc-170
[2]: https://github.com/curl/curl/issues/4774

--dbI5hzJC/16n2kOf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWwfwACgkQVbJhu7ck
PpRwNQ/+MgN9xk9XZBgFv79/IKyiu9rtLJ/FLbI+IEMLSJdY9pxfO3aQJ1/A9aCf
7YISyLM47tGUgBSQ/tOEAMDL2in6zIDjP3u2Asw8RvUkmJmHEft7gyllTK/c1Pjr
5BivxPP9jZ4VnL7cwcd3jv9rFKobU5dLyWMLeEzGtOVbyb+0/HAGLgu7SBp2Uztj
aF/hxjNSUF7Mqh+eWnXgJ4qia3S/X4SbVQfYzWHAs8C9mYhulb9Hyls1FUE59omX
AbBEjYdt+55wa6WCajopoeEL8YVkNHksSAFAp7n3lNwVuruqq7O2VGSOJi2hlFnX
KXSRAuagGvIvCeOLc5dul6qL8sG+HEGYmGgTnA55FsrR6tlNfVeQ1Qw3/SrPACab
hgQ5hp2FL3vvaJAtZvfWzlTppuHnRwXdZlufmizOjFn/vVmRvNLwKS8goSvwpvZh
+4Vc88ySQmUKsJoOHJYzj3WebJmH9iR2LpbMof4QF6FpVyNGW/p4d88KTFtBlfyO
E+6k5oikgVOt7j3fFTzEK4znTNwvWho1j2cS2WludZa3PS4y8D3VFE5UT1ykAmtc
rj8QXtfK25f4Eci8RfbBNxGdPda/NINq06Ka+q+4GuY3AzZPl4IaNdjew3rd4jia
83CzOeztqYGZ3FPZ1AokFOu9vKeyhF/j2YRmHc6cASANFpyGaOE=
=HH34
-----END PGP SIGNATURE-----

--dbI5hzJC/16n2kOf--
