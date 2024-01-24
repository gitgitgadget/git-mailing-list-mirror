Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEFB17980
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085916; cv=none; b=J5sQyuFd37dBg07Z0OrKXDrDpdrGUlfPhX/AA1eSR5COL51GrRSnubELXIKM8VHtzYLlCgmL5AgJIQ0+uIrQKkG5JGxhJY90/bEAaaIL2GML96zdpu58WtkwnCdRW67nLm3k4C75fEovWL15n+SGoqyABpXC/UKgQKAlsIpsQNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085916; c=relaxed/simple;
	bh=LtW13U2VmlTsHGQsnt7YR3Ruzm2U7f1dOnU+x5CLoQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouvA3TltE4Kh+LupMFJb/6ZjI8M8AamRDo5yWw1LWUpr6KvYD+uDL45FqNhkTs1iCQMBz2hqe7heRhA9w+sL/UItHbS9G0jH1aA4JYqypE6IWczz79g/0ft296CFYmH0hytih7ja050HbJTim2SzIFSzsjCwKR2Bzh4TcJwl2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iS5WJ/6T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OI32yg0z; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iS5WJ/6T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OI32yg0z"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 179063200AFB;
	Wed, 24 Jan 2024 03:45:14 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 24 Jan 2024 03:45:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085913; x=1706172313; bh=EZ8jZgIsKV
	7VNtvWnvVvY5QB5O4qCYBdwhN0u3d2+7Y=; b=iS5WJ/6TJM6efHQYsyt2LPIPgp
	CZmPXdDaws0vhrJt0iLDdr+I/bdrNF9zaQbVka0OZjOAB2XQ1rnBCK7yJ0FcG5/I
	95YRRr6sWOwLkeFdmGc90gjq+J54bXhhkvPE+mFLqv9JrhWYhSok+1jS2rA+TUMz
	JKcAOL/HYYU3Pgb5LRoiI0NT4GfEt9LuUDycUUO9zDhZbEFZHcQ3Omd9QadNCs55
	32BrKGLaRcDhFD6UrZ9EeDlMT/Q5+NusrcVqRfVuLxS177DkxQRtR+OHesL0xr46
	7/NPL/L9gx3i2Wq3VDW+vczjsL0FUmicWGQ9fzgqir3CZm/I4h0wWuiXX8dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085913; x=1706172313; bh=EZ8jZgIsKV7VNtvWnvVvY5QB5O4q
	CYBdwhN0u3d2+7Y=; b=OI32yg0zgnM+ruOhIvOPNhE1zGVbhwB4uXynlfQjx3cO
	CwzsTGP6J4Ihb22ivOG5ganDD+arl9aaNNO8aAl4NszyevaZ50Cba1U+EudcT+lh
	hz5t5LMZ1wIctfzNcdcT9BjN7XkHzXXEGeA4cMqVU1/wENt4UJmJTlmMSdJSpoul
	p4ATWyrd1HtOktEPdesqz+J9WpgV580GdQ6A9UFchGyLqfUZWms1lFNXN+7argKI
	0ZLBBYigK9sJ2Hkx5CzTW+xzkvUzUKX7Al3uh8HWd2uScfhG6we3JgdBM8jzeT9m
	m1NOrnlP/6DS8kHwiKn4EhEs8PJ5yZ5KkuvTCtWyCw==
X-ME-Sender: <xms:Gc6wZesz7w_wz-OOyHHUhXVuUkp2rbWe8YSxOWqOSKX3DNHGoVP76g>
    <xme:Gc6wZTdZGKCd1qMWkL_S--8o0fcZ1iwMVw6CNtSNsxbh0pnvN5Au9lajY5U5_ydRA
    KjlU7RFObv83M5UVg>
X-ME-Received: <xmr:Gc6wZZy-mfKeyjFBtTKzIL4ylPps2EsVrimVFmWS-Gz3NAkDRo7LhgkwjRNg6gHb5rQHhsQMfPun31jE5lfX-0-dtOP0CBjRHtl4tmfrxEDNew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Gc6wZZO8abHZYn05fIg4Lj06QO_j0AEwNg4P222uXSVoQCA3beg0ew>
    <xmx:Gc6wZe8gORdE7rv-aLZaVpkqnjIuMoFgsotC2Ak_94QiUfk-uUoKFw>
    <xmx:Gc6wZRVcJFb3eyMnVFYlL8ere0036n53rBsPwoijRu1btV61hm9xzA>
    <xmx:Gc6wZSarbgQ6jE_rzSkEYF9vJ5ZZKTQWxNu9v7zBBivDt9acRxCakA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:12 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5ccedd32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:42:05 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 2/6] t1301: mark test for `core.sharedRepository` as
 reffiles specific
Message-ID: <fd6dd92c23dddb47bafd81d063c0d00b91f43204.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706085756.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nd2jSgRWFkxgXhux"
Content-Disposition: inline
In-Reply-To: <cover.1706085756.git.ps@pks.im>


--nd2jSgRWFkxgXhux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t1301 we verify whether reflog files written by the "files" ref
backend correctly honor permissions when "core.sharedRepository" is set.
The test logic is thus specific to the reffiles backend and will not
work with any other backends.

Mark the test accordingly with the REFFILES prereq.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index e5a0d65caa..8e2c01e760 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -137,7 +137,7 @@ test_expect_success POSIXPERM 'info/refs respects umask=
 in unshared repo' '
 	test_cmp expect actual
 '
=20
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedReposit=
ory' '
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.shar=
edRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
--=20
2.43.GIT


--nd2jSgRWFkxgXhux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwzhQACgkQVbJhu7ck
PpSUtw//aO3cMH5BXjiu8pHrmT5NA2pbPm8wen1AWYCiwNQsxwaiH3s4diaASBkH
Gep1uEui3+w4jy+hX/YUTVvA3YhhC/4pE3bP4MgzBKVuSiFlhRqmNq9bY0GTMa95
rbkJgXaOUmog95kcfE0ul2an8Xz4aUqfRXUCceHN+FqszDLOQhm0mUzG/KedkLmp
+gTxkZlPoSUldzeZsLSXS/pCXZIsH/JQAiXq68CgciMNxTprvZYRdMuM3a6W/yoO
OtlO/WXavt3cQ0XEEcvryDsZz8e7wK1UqtzPnX0kw8QZto0fDjMpYvutPFFVva58
TsLxBncFPMU2ZHv67lZ6vGPM77BQl9qWqI28H/9HsY1Dm2Qt2JXdVeub49Dp94Zj
vfHnPJAB6mhbkyn2FkFUHZcj/8rxwuxgi+Jmeok6foy3CYrZoBvbSEHb+SO1yw6d
UKPxn3VG4AQ0vyTziCzbneS/rTUbOh1mS+Y7GAt98efbWN+/s1Kgma+RDqdgRPfH
ScJfDhxUgJ/RK6hYI9E+5U4Ot8CslzaY7i6wIzZijpJeA4PRJjlS5tlbF7eFk3sO
8tqrC3/HDZ3IZ5UbEKPa1r4AMN3KavTAxTJCF1goMyCpJbeJsnfiDet8DDQscQT5
oVsFoXkh7jxeY3ZDUY3fQI8o+pBsGsjiW6bGBow7ZQ38p7JMlyY=
=nRRK
-----END PGP SIGNATURE-----

--nd2jSgRWFkxgXhux--
