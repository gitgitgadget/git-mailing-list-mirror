Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EBE0171095
	for <git@vger.kernel.org>; Tue, 28 May 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716902423; cv=none; b=MuEHdIqoSs2GeicdFNdlWQcWFxJwYMfwDvqsK3J2f0ittTxHtObqBeTt5iCkD3o9VY/VCWG+UgcYgIZKxW0nvnD3fpsWOa51z9CNYavSrgMcTN0MfP5bywkP1vysu+DnTqp9xw6s7yz1AdfU26lTLvkJUnSpf6AjZQpFUalpq1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716902423; c=relaxed/simple;
	bh=ScbxtxRVY7BvDNDG7QnFK5mVLA4N4IpmoPnnhaHxWWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+U+aleQyiZDIT0Ic7AZipBFjjmZrGlIIkefQFTM61z9kTfwRXAIZ5ZwGZa3LnWlGPYUkuMe/42LBq9nWMd68hEdzr7fmsQY6+Y5sJvP+xE20CS99mXabT6oFCtcTIrqiZjXpRAS/lCUZqstTQAthg4KHlbmKMMsTt0cPeAimPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W7B80Aja; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zyhc2/Xv; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W7B80Aja";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zyhc2/Xv"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E44F51C000CE;
	Tue, 28 May 2024 09:20:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 28 May 2024 09:20:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716902419; x=1716988819; bh=a3stTUnXPR
	TX5XKGDgiVGRkXSZ6rnznycNVKRgp/v28=; b=W7B80AjaS1crkpZlFvkEWoT4o9
	pFmnL5X5uE7r35gp22hjMencVAIxHLUi0Zsmv5xLdjgwyvPllgeOMipZw3+9fHzD
	CQd8JcJXOUS542nxzkTOWyqOZjDOaDb2MXWPtvwTf3EqxXMwK8aJIB8kxsg3wnL2
	X4vqasFsO7TR9FUYGNmGcD36TVLQYg0CBOQEuK3wqZAq9NsODxdG6CxYNiOxN3ln
	ydE3u9/RniaZTPObPMRmbgImmIUIQq4SaZT3uhWWmVOYdx/33et4YsqKfezmewEJ
	cCot19H/9VIzSfFEEwnnyjrCERwdqSYZO6V7Nrlgo38lGy3D8fFyZn//uVaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716902419; x=1716988819; bh=a3stTUnXPRTX5XKGDgiVGRkXSZ6r
	nznycNVKRgp/v28=; b=Zyhc2/XvXKvGMcapDJmMndDXS8gOvVzpMFAFgTRhIgCl
	JPOgjgyCqzvUx6sccyuE1pG2zfjfTC0BM4Y6dlXjacMvTQVECGXcgDwmKFtlQjur
	w9p7XECwng5CXh0svfKSeic6056HWhFJfdtdKN/b5RW+NXashc0ByFsrhlvtZhGL
	uCat2LQSbJpUIgpmXNBfz3sUuLDgdNL/P29g6q+ASkBXbgSIv2/ITkA33tLGJpcW
	EAlyreWrMa1EzKsG6MJuq+JNVUiQAjwHIuMpoF6sbBvSarCvbaoCWqu234NDr9qA
	EtNMv50uxLzd3BaSfKglQiG95p1f1hSnFaSzGAYE2Q==
X-ME-Sender: <xms:E9pVZtQGPhWyhod4Cx7M5zZQ4VMnYTpiOudlGHGZ2wzpke9wHW_H3A>
    <xme:E9pVZmx88TAwuC3-ZjvJ5BdEytqc2dy_XvrIve-QvyeMPHJu-97qh6P7BAZI4Lu0Y
    oBNRAPT6T7Olrz7Vw>
X-ME-Received: <xmr:E9pVZi1aix--sPtxZv9FqzFN3Sbza1AgR13a5vVhlM6jTR67_V5j5IusHmhthNzY2vXylq1waXz5MO_J5kYljAHZI3E7HobMWOrJUQIm6EB6lo4O>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:E9pVZlA_uQ3sBjy-wUuPvHBQrpYT2kLUloKr5PjT4V8MXpJzysAIBw>
    <xmx:E9pVZmiZxUA9D4KK6FcI4xtez8oaLWYekaVvfU3qL-JOACcv4u0FMw>
    <xmx:E9pVZppdvDjRrCERuwlo4otBvx6cATe4uYYQQwTGFc84KxPKPQPyNQ>
    <xmx:E9pVZhjI4axW5hn3KqrioK-8qiQj5EztHquciXNd6dbbws7NnwqjSw>
    <xmx:E9pVZqj5oiM_dcahX8ke87-vK8cQazdyqtQ0mUpXox3pkJYXTX56V7kK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 09:20:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5506af6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 13:20:03 +0000 (UTC)
Date: Tue, 28 May 2024 15:20:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [Outreachy][PATCH 2/2] Port helper/test-date.c to
 unit-tests/t-date.c
Message-ID: <ZlXaDWy0lQA1FM7d@tanuki>
References: <20240205162506.1835-1-ach.lumap@gmail.com>
 <20240205162506.1835-2-ach.lumap@gmail.com>
 <tpaamfc3g5mrrbfufyvxi67ja2ko2hiihrptwxkbmdx4qpid3f@7aashrngiscn>
 <xmqqttkquxes.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YIQOMK0JvkSSWJHK"
Content-Disposition: inline
In-Reply-To: <xmqqttkquxes.fsf@gitster.g>


--YIQOMK0JvkSSWJHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 09:35:39AM -0700, Junio C Hamano wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
>=20
> > I believe the issue might not be related to the setenv function, but ra=
ther
> > with tzset(). As you can see here[1], when we set TZ before we call the
> > unit-testing binaries, the tests which were failing (EST5 ones that I
> > separated with t-datetest) pass on 'win test (0)', and the ones which
> > were passing (UTC ones, t-date) fail. (Although some tests on linux are=
 also
> > failing, but that can be explained by the fact that t-date runs first
> > and sets the TZ to UTC, afterwhich t-datetest runs and fails, although
> > this is not conclusive). Therefore, I am almost certain that the issue
> > is with changing the timezone during runtime on windows and not with se=
tting
> > TZ variable with setenv(). CC'ing Johannes to see if he has any insights
> > on this.
>=20
> Interesting.  Sometime before I started working on Git, I learned
> that no program did tzset() after it started running to switch
> multiple timezones and worked correctly on many different variants
> of UNIXes (there were many of them back then), and because I never
> got interested in writing a world-clock program, I didn't know, and
> kind of surprised to learn that it works on some platforms (like
> Linux and macOS) to switch zones with tzset() these days ;-).
>=20
> So, if Windows runtime is unhappy with the program calling tzset()
> more than once, I wouldn't be too surprised.
>=20
> Thanks.

As I was debugging other Windows-specific issues in a VM already, Chris
asked me to also have a look at this issue. And indeed, most of the
tests fail deterministically. I also found a fix:

    diff --git a/t/unit-tests/t-date.c b/t/unit-tests/t-date.c
    index dd5dbbb2e0..2d7b1f085a 100644
    --- a/t/unit-tests/t-date.c
    +++ b/t/unit-tests/t-date.c
    @@ -31,7 +31,7 @@ static int check_prereqs(unsigned int prereqs) {
     }
    =20
     static void set_TZ_env(const char *zone) {
    -	setenv("TZ", zone, 1);
    +	_putenv_s("TZ", zone);
        tzset();
     }

I have no idea why that works though, and the fix is of course not
portable. But with this change, the timezones do get picked up by
`tzset()` and related date functions as expected.

I'm quite dumb when it comes to the Windows API, so I don't have much of
a clue why this works. The documentation also didn't point out anything
obvious. Dscho, do you happen to have an explanation for this?

Patrick

--YIQOMK0JvkSSWJHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZV2gwACgkQVbJhu7ck
PpQJqA//Ui9vf7jHzioOJGx7n9CvOmeTg21vDzdP8fGw/QroYk/vhRNeKAZtH5ul
VEomDRFFxKjURvTNRtaKeq3qalxPyZWUKmi8BqcE/XHlYMjDUEI7KJSgJn6FO0zG
awaaxFqILcvZvq9eDq2/IOZGWwuM+XNb9M3jzc8QGG7PPC9EezewxyNr11zkQmz9
+fkknAX31N1KJZdHbdzZWegNLUwZuhZl12vw1S3dVHLZ1Y0GoXwkZ2mNXyf4f8pz
+ig8+rsj37lpG1amatouKFRZgYzF3m3gRKwKZDLHz8AC2vxJja3OAJFiHKFIIt7w
bJH6ml/fG5rz62qV+q4g/o1JTR9zZ2hf7E7RVfe4W7YzT6naWrJj5n3YnKOz7GGq
CL3/I2lSuutOpT+sLf3hFMYyVllL/4FyHO65xm+B4HZlZXaroFwbNZOB1LU3gK33
JolbDzW5cq8TKh9ED8XlY0QFXBNcHlynVn3l/ifu7JI5s7rwOAYgI8TfTfEJfmmt
uApohYBG3h8Q39poDsSMTzeyYLxcvvvP4Ae2Qh3XiaGB8GnfK03ey96IHOyBQ93K
HWgcTsO6Cib6W6KmcJJxGFPQfu6PkGqlPRmkPzI1LvvtNQbYHvoLNQExfkcwozMs
lcavPzUEHUCABfEqeCKUUIrdIFlkoAkibDH0J3mSD7sqT8tUKRQ=
=C3B7
-----END PGP SIGNATURE-----

--YIQOMK0JvkSSWJHK--
