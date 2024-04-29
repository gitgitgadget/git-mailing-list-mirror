Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46810A09
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372460; cv=none; b=Js78eU8Wjb96Y+kz3kE3TrUjwK5rieraH93GI+9Zi0S81KvzajDsEYnwnYijvImTftPC+oP/gWAkGYowrKM5TPZdllaTQt4SDRg+P5zlEn6ilB1CgAQ9rw909uRtPlpCK0ueVtnHF+jZpj0+kUrhtQ/P+LVByreHj6FDRowouiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372460; c=relaxed/simple;
	bh=d1Dn3I3xfnLEPKudiY60dhrflIRa3n03bCWMQLa4mX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ro4/PWFA8eYhNQEMsu5hckdhQffhtct5KuFM5JTqV9zPFtO+wpJjD+/N11aIGiK4MpdcffzRzsPiWQqiSveb/wxLg4QmBQem+yBCVMghJovOU/7H+nyN8AYUWs2MXtSaVSIX5fbAbWj4aoO+sjRRKsm2HicL+UirD0RKbe51lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=exVL4NWk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DzGaAMOa; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="exVL4NWk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DzGaAMOa"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id C25AC1140130;
	Mon, 29 Apr 2024 02:34:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 29 Apr 2024 02:34:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372457; x=1714458857; bh=D0ghfovaq2
	0IIn5GY0Y3kJWG//lxFNukmGwIdIwSSdc=; b=exVL4NWknlGsb6FTNb68CIgTqz
	uwsuGigsAiObAZLZV7nM9GZtidBei4tEZcZ+C9NrMc2p19e8NM8CmctPnJXSuITt
	Jx4QdBlcixUn2acLk7YMStNGLFI0gwVMyc2lCThsV+A3vhL++EH88laAX681YP6R
	yKI5Y+SyLm+SyffFGGMNPz/kEczHDUi59xV8T6V/9pJAT/vwqhBYLdS3n+AIzO6X
	gBVTvNwqdm0Y4z0FisqmBozxjSm7xRuzPFZpmvGXVnaRP4F4qCd7I/j3wqBoBAL9
	KTW/Cxk/Nwbra1STYEUAvYnlvTCZRIlsgOW7Gq8LxjRKNXCnYvlpICQIXoMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372457; x=1714458857; bh=D0ghfovaq20IIn5GY0Y3kJWG//lx
	FNukmGwIdIwSSdc=; b=DzGaAMOay/rbED9G8z+pTwZsKB2VDDi14wbGKzZ3I1rg
	sG48WRyKNYZG2aYpR1jZSFROeuxYE8kuWdiiuJgr49csd+mR0p3/H7+6VdrgaFLx
	BZ5D5mb9uQsBF96DX3rvhvlqhv9XbcD2309VDNbPvwMpRYslYFQ5QtJI5nzTJGxq
	tAz+C3dSvpnHOULyKh9PRHjGhIpIBpivxSALslTISbhNo/oPHrp0uctxDml39sck
	/C20zH4zwWTnu2Gzy1QMvWa1EWrfgSevFXZKOSIOZlHHco2+OcZ1Z1HGwfvJx8UT
	i2QkNB2ZHMGvA5vEKVMhx8KYCsqL+vM8yk+Eg2AViQ==
X-ME-Sender: <xms:aT8vZgVFyreQKRPXjvXzqjfnX7uKn96uEmmQOVY_feYm_07YFUqJ0g>
    <xme:aT8vZkn9szkwYjaYjOFmVXwg1Ypjei_Tx9dghdxj-bjr4U5VyBwkA5nAxuleVtH_w
    2S__mhJIVa-i3BVeQ>
X-ME-Received: <xmr:aT8vZkbG3gv9JinbY5iOAvAtnJtB0Ph3lQAXQ_o6TvkZ0iHYz9q2K614MHsT6uX3FUeCwo38oUifYxGjmcxn0ZCec_pZlx86kxSvweEHLJ2wW_fn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:aT8vZvW7aPXJCn17-g9DCiBd7UBm6S7E_gjkIfkBkfY3rK4RdH9J-g>
    <xmx:aT8vZqnplY652tgEUC1UMbqCplRuxBR-Pv1F8UeMpxLKW55yuhKZDw>
    <xmx:aT8vZkfvdNzBrcBC4iX4kTS42EFlQ-IN6Cj3ToJnD0rBZ-gG6esFVA>
    <xmx:aT8vZsE81YZKt28bnpP8hoIdxLKXTKjCOJlO4U1kRstmJl7XEEDG9w>
    <xmx:aT8vZrBCD84QtuDeGW0bOI08wBvXx-lPCXokuLCMUUxyxcxQ40OZQp4M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5dbbcfbc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:33:57 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 01/13] path: harden validation of HEAD with non-standard
 hashes
Message-ID: <5134f35cda5ab47429411293dbc0a987a306c9d1.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CdRhNj0oJoc+IaPL"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--CdRhNj0oJoc+IaPL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `validate_headref()` function takes a path to a supposed "HEAD" file
and checks whether its format is something that we understand. It is
used as part of our repository discovery to check whether a specific
directory is a Git directory or not.

Part of the validation is a check for a detached HEAD that contains a
plain object ID. To do this validation we use `get_oid_hex()`, which
relies on `the_hash_algo`. At this point in time the hash algo cannot
yet be initialized though because we didn't yet read the Git config.
Consequently, it will always be the SHA1 hash algorithm.

In practice this works alright because `get_oid_hex()` only ends up
checking whether the prefix of the buffer is a valid object ID. And
because SHA1 is shorter than SHA256, the function will successfully
parse SHA256 object IDs, as well.

It is somewhat fragile though and not really the intent to only check
for SHA1. With this in mind, harden the code to use `get_oid_hex_any()`
to check whether the "HEAD" file parses as any known hash.

One might be hard pressed to tighten the check even further and fully
validate the file contents, not only the prefix. In practice though that
wouldn't make a lot of sense as it could be that the repository uses a
hash function that produces longer hashes than SHA256, but which the
current version of Git doesn't understand yet. We'd still want to detect
the repository as proper Git repository in that case, and we will fail
eventually with a proper error message that the hash isn't understood
when trying to set up the repository format.

It follows that we could just leave the current code intact, as in
practice the code change doesn't have any user visible impact. But it
also prepares us for `the_hash_algo` being unset when there is no
repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/path.c b/path.c
index 67229edb9c..cc02165530 100644
--- a/path.c
+++ b/path.c
@@ -693,7 +693,7 @@ int validate_headref(const char *path)
 	/*
 	 * Is this a detached HEAD?
 	 */
-	if (!get_oid_hex(buffer, &oid))
+	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
 		return 0;
=20
 	return -1;
--=20
2.45.0-rc1


--CdRhNj0oJoc+IaPL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP2UACgkQVbJhu7ck
PpQNJQ/9GS8u7sDpp7SUCUN6kGI38z1F2HaBnm0P85CsgQCLf53KhASGVqsOAvn0
f9Da9dO3F0sby0Sm/r+4i6E1YKMsaA1TwMshGEN1W7Y3qWK4WC6LN9a++2cM54np
74asuKJIOAEUXUek6bmYqLR0eUCDyaw1B/188UKkP7oftsa7V/F7ixTVAze4jzcE
htmDl8DsTExAz4ZlY54EXt9rURaePdXgRTTZkGdNjIpRCvaCqaaF7COID/pyXLJO
Rk+lvEAQupcuIWonKwrM1vVfxLkbuzw7hW2k/tEIRkKCA8CoS/XBeIB8ZSUHzB7G
yJXUw67f9IQJcWXy1QsHo6EkF0gfyXw9ylwePpThgG30syjCRkcurh6Q/iBLnbmn
UzaMW+qpEJMiNvX/7RI534Gj5Lavj45DJns49P/I4B3XpMB8unjfqyAUz4ZZuB1r
sGrA0BkmXnNZaX6YmLz71W2fiFcHeOnkTGbJ8KTJ7ZD/VbQJTkuDftctXDr7OlEQ
PaOmsH8XBo91kYQ1e4mSKgssRcjlsWuGiztD1cSIOvsiulPnLH3cseyc3b998nrr
Xp62oaenEvuNLPLRlb54xEMtkgXZPuZ4K9LWRsC120+vGxUzGJNEwB1Wm7afLBE4
BhB9VU+4z+rO8cF9or3kn86njeA/17EQUh9DKn9K95iNH+6s3bU=
=VYGd
-----END PGP SIGNATURE-----

--CdRhNj0oJoc+IaPL--
