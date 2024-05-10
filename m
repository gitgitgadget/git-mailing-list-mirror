Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC888BE8
	for <git@vger.kernel.org>; Fri, 10 May 2024 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715330938; cv=none; b=jZYfeWgnRWWiPWNlqQZkEQgmiMJHkbNoEsmbRSKUxvarIPdMW9oaitoH4hXnqhbtrkVWGQtNF/qna9sDKvD6YejovoRKkUaATPP0ahc5rud6MirJHY5aMzdGH7w5bc10AvgM5GjqDuT0fqRQeN2AfFhE1jVrRskUdofA7ny2kiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715330938; c=relaxed/simple;
	bh=O+h3lDmgTU2pdHkz0t/J+aJRbmfIHbMINiYGjfozrIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXI1NAJf7/za67uBDnq5GZH/GQE72kq06u2g6QKbvwrnIaswmek9bKVH8+xwfX8MBXtb2et9gkMXDkz6OCbV9EkUR7DN9HQ6p74AfqZ1jczhzm8XB7Dj8CpSzuqVqp3NywmbdfmHWV7t3H+L/+pp0KpHIn5410xIX8eBwcvdH+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mMNaPhYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfuK2p19; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mMNaPhYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfuK2p19"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E60641C000F3;
	Fri, 10 May 2024 04:48:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 04:48:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715330935; x=1715417335; bh=SeomFHX+9n
	iIhonAM4APdY+geeUveyCLqfU682b2QRg=; b=mMNaPhYaESM1uIANzUmeo67US3
	CiMwBQMXDk9dKbWIQs05WSLzwV5BhW72AWXQZsCi9pxZaW/Wm+deMMRZuQ5PeFX8
	sRTEcAd7d1k6Q9bANfQL8cmP7OWhEOAVHXFjF+Emnlpv/ZhqhGGwFQSgbMIERdKW
	giPBdQkcHm+FP0HhP9YxiaZf6FciguqOK3eDRhpL04lXx0mzcoTx2S02p5tDd0vr
	j5O11nEFIjIcnC/z3RPuJbR6G5WkvxT+2oDT98GtsY+0atX4Ouijv6InQZW4G0PN
	OpycNd0t11nEUeQlQV6NNLbMU+DGe2rzQIf3D5xwl8CCEon74wkPZ9ZJjFgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715330935; x=1715417335; bh=SeomFHX+9niIhonAM4APdY+geeUv
	eyCLqfU682b2QRg=; b=cfuK2p190sX85wC3oUasTNTb5KYqb5hf6C5ZQAmoNtYg
	x/hpR6lXcbgVHi1KMmKqItWrVC+CyTzkfc9+Pkg5oRgCbc/fZvlUSNiZoK1Ura7k
	7k/G2FCv5JCEsJ1tCOxTHQVXZWu+fkR7JeP1kX0gmwucIRfo9WPyCWMcE4bXw2R/
	+eLgAuJ5ptbNae/F5+o4gKTn81cB+rPW16wYIL4fAfyAn+JiMAcgNypmrq2UUVwe
	1+dRZe/9Lw3s4QlZqkTbaJwnrzGYwJr1xBOJ7AUUx/KFBVyZYdIi0dJJreiPx02a
	zPH+2bOiyDAy0+Nb1cfyZKx2lt7IEhwmOJPJGI6IsA==
X-ME-Sender: <xms:d989Zqty86clbVFqC4mvdc5QuUtRs5Y6R1y4GCcwu7S8Y4wbeLHocg>
    <xme:d989ZveQR4OraF82QWXOaEm9NuLUuy8JItSaN2rnSp3zW6_RDmUNvtND0kJdhdhHl
    VZHSjB19LpCCV6VqA>
X-ME-Received: <xmr:d989Zlz7yv44Z8xyo62sOR3NbqYJ1vJuNSIOx7JpzG5J8pmyErt2J1UN4HnYjfq7FyUmgeDKcL5RgrN7BmdIDSEsZ3wV_6VPlDmyBCBKe-1-56Elzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgtdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:d989ZlMa9Z9b1zWHko2TTnn0Zx5kiCLnyiLUnfWTKepI1JIa-gIqbA>
    <xmx:d989Zq-Lysukbigz_AirYOayrJX_llDgodL1ScmGYkhl-NJZwYRwXQ>
    <xmx:d989ZtVP98ZyEOCgKuj0GYCs_F3EDJGlo9nudRKjxDF1PRxVVzKdGQ>
    <xmx:d989Zjft_6kHhVMs3BGpYo5Wky6YMVqwXBzyvwkJK84QxODGKbZn8g>
    <xmx:d989ZuRy3-SZZ92QrhcPUn2lNCog9JJiUAoli8VCiekJ41rIXkilFJvD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 May 2024 04:48:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 78c28c2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 May 2024 08:48:40 +0000 (UTC)
Date: Fri, 10 May 2024 10:48:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <avila.jn@gmail.com>
Subject: [PATCH v4 10/10] refs: refuse to write pseudorefs
Message-ID: <640d3b169fc6abaaf121b90f43f5f4c4145ec08d.1715330206.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1715330206.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lATdjkItUUcLaoWe"
Content-Disposition: inline
In-Reply-To: <cover.1715330206.git.ps@pks.im>


--lATdjkItUUcLaoWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pseudorefs are not stored in the ref database as by definition, they
carry additional metadata that essentially makes them not a ref. As
such, writing pseudorefs via the ref backend does not make any sense
whatsoever as the ref backend wouldn't know how exactly to store the
data.

Restrict writing pseudorefs via the ref backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c           | 7 +++++++
 t/t5510-fetch.sh | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index c882ece6e7..f2507c5a74 100644
--- a/refs.c
+++ b/refs.c
@@ -1285,6 +1285,13 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 		return -1;
 	}
=20
+	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
+	    is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return -1;
+	}
+
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 33d34d5ae9..4eb569f4df 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -518,7 +518,7 @@ test_expect_success 'fetch with a non-applying branch.<=
name>.merge' '
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [1]' '
 	one_head=3D$(cd one && git rev-parse HEAD) &&
 	this_head=3D$(git rev-parse HEAD) &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -530,7 +530,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 	one_ref=3D$(cd one && git symbolic-ref HEAD) &&
 	git config branch.main.remote blub &&
 	git config branch.main.merge "$one_ref" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -540,7 +540,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [3]' '
 	git config branch.main.merge "${one_ref}_not" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
--=20
2.45.0


--lATdjkItUUcLaoWe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY933IACgkQVbJhu7ck
PpSvgA//UsXS5LKEykQ3MDVxNvKVZmpHOVLKwynj/cJdPz941+vjvMa84FdICdRF
GtuFnJXu33AhDnrKjULR1Hhx3/E1PJJ4GzXfvU8CDU6Ay3/J5g+SL//ZCglCjbqC
1adK09O6jISD/XVg7eW2iBvoqKr2Q1uiH956vQo1d9POcDejbrV8/aq1o/nyWRj5
Wl4pBiaZnaRs3k6sEiPVv/yjw3uK5scbgjGjOA+kERvmc0GHAS8KWIQzjaX611UI
9syKGrkc42phoFGKinnD/cRNIqzrkb1JdiGmXnSqeIfb+jem00sbnsNBXQ6jCiOl
PnL3V7qaX5bQshr8Vm7b82wBqI56NU/RrzgYpO1dvsn2b9KZoNYrsi9h/M+Tpe0W
gZ8ZQTZzkdFnsjvb2JMjAIB7ogp8O/zSUpUGIV+FHKnDAYcw765geBfDYquo9Ec3
hvA4BCH6IdUBJEHLUaLnN+yMna336JOyodLdlZOcEufNEmArxbcMRUvs+QnZgTji
kHyVO6vfz4jFzYLvV8/PyEnD230SfFxhBr5CsjeJ+YzJhFzLvuXihw3l4Mm7Wv8t
Wfkk1aPrKJl9nj3AS5Ne5ZmoP/Zgdol9uSnc+dx76Aj+UE6FIpfxDWr2VjyTvt+f
gvtI0x0mVPO8AfUKlVSIelJvww0gPoar7QLsx/ZLvYDoJt1YzGA=
=Q5rS
-----END PGP SIGNATURE-----

--lATdjkItUUcLaoWe--
