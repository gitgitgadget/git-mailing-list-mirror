Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B97767A0E
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463420; cv=none; b=Hw27HlPxQNlvg2GoTcowc3Xm8c8f/bNNsvW54Np5Rc9GudX9461aTSwhY9zs+R4UvSM1n8zeg0zwZ8UlQiZM/n1YbTwvVT7kcNqHZxccQd3jsQdv5MC8R66Qk+vSAsxH8l0kNLyJQiIX1/Ftb3zd9qXkexIQLO+luwcbjLc+Alo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463420; c=relaxed/simple;
	bh=mirPjs4Uxe0aClIAf3Hku5Y13ZaEQLHM0V+Q6o7oeuc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBPbggBROkZ2OATV4aVbhwQRIf6BtbE4E3W/w39PoO05GW2M7bRncod+XCwETXxFmaHigxPMoPDvjFR1OBNXz5QD/hJMQDxtEnRM7kdPnmpJYbKqdTBQo8I8bXkHlrRoxjnVXS/vTb7XB468583T4sVTLj7dtoWJ4XZO6RPVQ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CavgkAgH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ToZvW3wa; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CavgkAgH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ToZvW3wa"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id A7F633200A85
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 02:23:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463417; x=1707549817; bh=iJjXALrcxd
	uFLQSSNeGm+RKAriDy0n8cLKrR49I4tKU=; b=CavgkAgHsEnKU+tx9QXefIpuGZ
	8UvJNMkFh7e7P0KJLEs5lwWHDy2OEDWPUToGzidmAt5x8MJ9f07j+/WOET8E2ZHS
	ENdZcz21aRSya64LOu8EcQh12MtBUEyFqh241jQ5z4S2/2rdX+z5iQXPONpuopao
	UuPsOZ1JsRzZiinSA2ohNqsLlWwj5TWRStMb7dXoOiCebnvaBNGUEKy4iv4kXf5k
	9FA/NQAY8NF7v2VKm0+zMSM1Sw5ByQFvo4+XVrodI3zFL6/B4Dab35Fk+WaPnIA1
	vg9V3Bq5iupy2h276v2fEDvNzxZjMpo5PZYJR1fiVULiEIfZm27EqCKx62KA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463417; x=1707549817; bh=iJjXALrcxduFLQSSNeGm+RKAriDy
	0n8cLKrR49I4tKU=; b=ToZvW3waALX1vTr7pqcWw+mJuCuzGHwnupOxkaQqNcWY
	2+p0jCyjRGgZk+MeII3WCoybVjOzgp67WQ84AvKXOjSz1f9TUueYYmyC+ThHa+b1
	veVw7CWyDw9cEg+pSvHUUcsMY9pzc0dx3gbNp12sRwaEr8/U1RCD3g1iq4KRNN2i
	gjjtlhpz2Pbw2F27fiWWpbct7XIub/LOVzcx1GDmNUOZF8fwEUysj/fybv0u5GMD
	nVylZ8W8G25lLyXsYRhdMSPpGPnZ6lpRXzTNuuU0eqtFmNCCbJ+O08P/DL/piEhj
	92FDdZidX9ckJHSVPHoDbAWckfuzte4YGnCHPitDew==
X-ME-Sender: <xms:-dLFZT0ppzwGKkMSmymqUhnqoGWcwQO4in5ANsHQ3ngyt6nB-GN0FQ>
    <xme:-dLFZSF5azTK2hfdy2L5EV6dD7yWFbnlLjG4Gb4OoH52SC5JEszZVDKzTyCREP7Tr
    92GsyvK0w4YYGyjdQ>
X-ME-Received: <xmr:-dLFZT6RYiB4mVWDiBp9M7h0zFqND-qW0N8CiDOcHX1R2HxjUFGOsAw9djWFkD06bO-Xgpj3-cP711fxHbP-NiCJjwfwREctT4uQxEwhjHd2JUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-dLFZY33gEbiCgn1K64Qo8HrkM0mY6GwtUwZoisPd6xfUbkaM1GDVw>
    <xmx:-dLFZWHZkZsWmLQTNPeishJPOQNnWS82Tyrz_6T1cfvUPd21sG7o6Q>
    <xmx:-dLFZZ9QuUpljjv2_6c9iXTlZDJH17pN3ghZvFIPNeWTFZoSnNYyDA>
    <xmx:-dLFZRNYLQ3I2f-IlcG8VuSHhLu5fhQlBOPaERRjE-izwmbxEx0fuw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6b5015e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:20:01 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] t7003: ensure filter-branch prunes reflogs with the
 reftable backend
Message-ID: <7adf510f7315f656490a71d2a19d6daec90a7eb9.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kqoehmnzjzTh989A"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--kqoehmnzjzTh989A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t7003 we conditionally check whether the reflog for branches pruned
by git-filter-branch(1) get deleted based on whether or not we use the
"files" backend. Same as with the preceding commit, this condition was
added because in its initial iteration the "reftable" backend did not
delete reflogs when their corresponding ref was deleted. Since then, the
backend has been aligned to behave the same as the "files" backend
though, which makes this check unnecessary.

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t7003-filter-branch.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index f6aebe92ff..5ab4d41ee7 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -396,10 +396,7 @@ test_expect_success '--prune-empty is able to prune en=
tire branch' '
 	git branch prune-entire B &&
 	git filter-branch -f --prune-empty --index-filter "git update-index --rem=
ove A.t B.t" prune-entire &&
 	test_must_fail git rev-parse refs/heads/prune-entire &&
-	if test_have_prereq REFFILES
-	then
-		test_must_fail git reflog exists refs/heads/prune-entire
-	fi
+	test_must_fail git reflog exists refs/heads/prune-entire
 '
=20
 test_expect_success '--remap-to-ancestor with filename filters' '
--=20
2.43.GIT


--kqoehmnzjzTh989A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0vUACgkQVbJhu7ck
PpQq9g//Ywd2DZO/oU1+R4U369d79fHaGWo/gMGm4zEytOgUrU5eokjjQpPfusOO
t7aXYdJqMNmZWiF5ggE2UoSCJteoWsMMJf3ZZQ6aime6l4Za9gRvB32kHkNhUbxA
qQnUcKNXoiGoQo1Zg7DRe4pq8+Nhqs3Q8rAJCTn0dLpgBHw9e++9Yd9DeTwTyG6y
kRq+zUdirqbSw0SrTWTDiuMATAuxDuAKiYDW1eSA90h2kle0YGqRBTJUCuW0xbbC
gSrFqgrM0fMRu+ft4ioig3xT1u/cZRUsN2IC1Y7N0mY8yJEVZjBvucZ5DCpU1kUd
OuiFKWrl760DXNSOMtpQ5hJm/cS1LI1wq4ySZJHDCMlEsRNmc/u9FnaaB5HEQ3k7
OJvT3zYletyDWu3XsVMZ1fTG/b1rm/2taFnrKXhbEXmfEnAfS5nO1QpyZ4bv9Nno
keIc1VEpDQAIxO+RY+8yr20ltlzam5AKMiNF3Yh1+O2hGlhcxjIfFO0QNU5q7bC2
7uqhovq2fjJHkyqDx6jq2rrcoJ+KqHfctFMc0AnK4KU9n+YhpKuhqdY/5K07ASmD
RUmCxH+QIB+aCsOUEJqq6THHO1FjJfz4ascfPejbIScr+qDN3Z0eKLrCk6BXuBnX
zAwZw8+PsCVWrqbHGcS8VBAky5VsmT+rHoQuum6X3B5Oud00hS0=
=h/SI
-----END PGP SIGNATURE-----

--kqoehmnzjzTh989A--
