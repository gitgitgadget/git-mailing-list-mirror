Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D6DF4EE
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714371211; cv=none; b=AdqfOpuN9Kv/iJp28Uq/PXBtlV6VKdiBOOgWOBavrWZv3++0rTXuA4zjpcDne6Tc/0b3fBeQyMaUTwUdQgBe1Kx35zb/MedqP95Za4NOB7HuYB58teX8fn7hdxzOp7w1kN5rocChqHRYKg6D+Ib1hs+oaXOVpfAmy8pWPxHLTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714371211; c=relaxed/simple;
	bh=HjGaP860jFBWZO4zbXuQ+mYF6bxfhY/h6y2bc2ZtD3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=cJRQ6F6F4Eydzz0/TAA3JDuII/yDYpQLJU0wWNICRKzi+uadxuHWDRFWETzT9fiFlqK+rqjLTQadVoV43Y0NPvljoq09oEigkKcUvqnvBYJeaK8AT8Hm/9fRSPkreSVvNM69duJoF0Go3hmOEjzhlocAjfET7hY8YWyy9gYIfO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BJ4/BK65; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J3B4ap42; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BJ4/BK65";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J3B4ap42"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1FC881140118;
	Mon, 29 Apr 2024 02:13:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 02:13:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1714371208; x=1714457608; bh=80PV5DUzm61kNmmL31OKKtgODFNXnWgl
	eVHi3bkqbAo=; b=BJ4/BK65hJrs7T4F7UzmIuuAN7ElxgytosRc72R62fCQl5PV
	ugOncaUlJvacfloFGL7WIymCObb/S4KN0JxXeU8mCEjwWT5nMZFN5B+61jI2mA9d
	ZTa6aX0ga385DMJCCK21uW/tTUwsUu2ctsEfLg4DaMOZ9AUZlBUleZWNkikoGWrB
	e9ad2Ew2mClqm38wd3m3QmdxHOhBYySPmyWH5BSUmTSqdkcXHGuJRfOEE9kq38KB
	KjAGrC8ppDGbL07XHLa4MvDUDwF+dDjUnDm/XSWhnlfkNgMOH5RcW3Lf4UZA2J3O
	7qh0/ulBTKM7uXNmxqG+CzDIVLEG+zEQPqOazg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1714371208; x=1714457608; bh=80PV5DUzm61kNmmL31OKKtgODFNXnWgleVH
	i3bkqbAo=; b=J3B4ap42zgAOI4tBtJ6ptpsVk40XVRTTz7sM9eVt8EU4KziaSqN
	pt8QACfZqp4z5HivPd31rDqgYWJ1N6yHtWcbj3Ma+n2P+xMeEJyCFIvJ3xfPL6+x
	kF+lpuDX3cKZFRKc2p69mL+7FMY14dJDwvriowqNrxzAWIDR7r5algz+ppCyCeLu
	F7kOTzD5b0ztMsxPF3RxN28x0TBKAtBhbmQOqAiX+aSDbgpWK8Ikq4wEKVcEaQDs
	lq7JEU5pKl7pohaXvYYxN9dPtxzw5PDfKJAmLjLeym35dkM7C7o34Xp5RWHZw7Ju
	5RNdgyJ7q0A/IIzLV2d5ie3BilPVeqeY8Xg==
X-ME-Sender: <xms:hzovZqeJ_hA7QeD1gJpHpwKhEe7wH71V8_hqLsFms5tcOucYYmd8Bw>
    <xme:hzovZkPC9uvf2QidSkcv0NZ8cnJfXoP_s4Em-5ovmCMcXNJG5_GGEBmK5BZG3L8-X
    pTaSKMUN7yUj-sh1A>
X-ME-Received: <xmr:hzovZrhAvVG0JMs_4WQ1k4bhQTXKVnGMzO6dX4b6T5K7ZFni2jO81yG9yEOkeaYLjntrImmWME9tbQwOW0iBVHtcv-0zufdIn5J13zF-j7qFH5aj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfggtggusehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeeugfeutdeuieehteelveegudejkeejheelje
    ejhffhgffhvefgkeeukeejtdeijeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:hzovZn9KPVTddVQgymPoRcj5p9nePsIZ5VAsgxZrgtnTNdJ9kDFFIw>
    <xmx:hzovZmuWXvrYE-b72TQ8pIXAOLKSEAnOyuOyemtF43oqBTpae6zQPA>
    <xmx:hzovZuHJ9IoNH7Z9nWtM0Qxga_Nsa_iv5BD1D96XqJeAvRxgPEAvyQ>
    <xmx:hzovZlOso8MId01hVwUOS4ca5J46InfaAuiV_Xex0Fz1VhZBj6x7lA>
    <xmx:iDovZv7l3_TEL4aoL3UfIv0u6GU6RMwyjFB3eivYWQJeJyFW5wInfhvk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:13:27 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0243dc68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:13:06 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:13:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitlab-ci: add smoke test for fuzzers
Message-ID: <01fb94999f8e2014ba4d09ce7451a4f5d315ee72.1714371146.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpp7KiJ/WEhGrsgZ"
Content-Disposition: inline


--fpp7KiJ/WEhGrsgZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our GitLab CI setup has a test gap where the fuzzers aren't exercised at
all. Add a smoke test, similar to the one we have in GitHub Workflows.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---

As identified by Junio in <xmqqwmoi31aw.fsf@gitster.g>.

Patrick

 .gitlab-ci.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index c0fa2fe90b..33d53b3ec7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -93,6 +93,15 @@ test:osx:
       - t/failed-test-artifacts
     when: on_failure
=20
+test:fuzz-smoke-tests:
+  image: ubuntu:latest
+  variables:
+    CC: clang
+  before_script:
+    - ./ci/install-docker-dependencies.sh
+  script:
+    - ./ci/run-build-and-minimal-fuzzers.sh
+
 static-analysis:
   image: ubuntu:22.04
   variables:
--=20
2.45.0-rc1


--fpp7KiJ/WEhGrsgZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvOoIACgkQVbJhu7ck
PpSNVQ//UBm/KSK4BYFxdrRoNIfseYzRoW5CTIdSRbzE13qDyCgn36DqvT+gC1qb
mvPaIo4179ZkJJWohgOe56IEmOc/5M8bSt4VbQPLFRj+s70amxXK7UfzSenUfgg9
pKgAeYb4cmip/ijc061UzePepiEsu9RShrDl+iCeYVIbhI8z9eXsHKh8PNUZrjyT
8QzROcrH4nnqVVWFMfBrFeU+gSJ8p5NpsLzAhWHouWArH4MUAasRGN92/8HJtwUy
giei7UiyglLSN2FElFE9xWAvEm6dmvVRHzSkRkQHpK/jDL1o73W4cHAEkk1dYBCk
gygxNsJV8qAzCOKlJKDDktJR5uBpzqadha6auDXT/5B7rGs/CJHzugZU49yCdlB2
v+rs1wP119Oh9pl/7CHQsQxcqpJt4vIVO5jJw8+X+1XcElH4a/188WejpzuwmaC/
VYKRl0hyDvokPhqmdogYNBEL+VbXUwrKPT135HFb0KFrOK9QzhwTzh4OKZNpGYQw
V9q+yRQT4L+/dqAtbqLCPl5YJW7OXgk/xJ0lPgD3MkL6UdanDcp2TkLtl2cSnqPm
s/8e3A5v/VEvlvcTVAN/aD2eK2QVgydmDdyBKCdv34C/u90cpRANGgFSlbR7+ILl
hmjGfmpcGu3SOCv8CljoKJDmlEhrzzBZpBkdSjeZecJK7vBz2ws=
=/bu/
-----END PGP SIGNATURE-----

--fpp7KiJ/WEhGrsgZ--
