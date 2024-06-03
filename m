Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698601292D3
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407037; cv=none; b=LGwiW+BrqjjXouUUp79PxQCoKZbO5Y48DFIDNLcnR6gtYOm2LW0uEz0ukL64DzPkcl3NuBtvGf/rOefkO6rcshBrreKN+ADx5Pkc6Pqrzeuy2tCuLBL7t/nR6kcpuxUdzWoB/QaYJJsbW1+ykg20NisMpt1nRQZHvo/UyCzTIs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407037; c=relaxed/simple;
	bh=xPdg47XABQd9W8LiQCuzjVJCOQmaYUntOXOU4YvYGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOuv8B7GjxloSPE1oQiEa8bnDcBt7v4FXRV7qpOP8UNrR6XkE5jL3mJp8bqA8syGsczvpeoJOiKjKsioxlMkXvGArtEPxk+rRaJ0ND3xMRACgz4b6Vj0F9LcgvqHlest95a+EFsN9oDMUoI+zM+U9au8aSQ2sADJRhsjefYlahk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ro+ALmGP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hMXvtw0h; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ro+ALmGP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hMXvtw0h"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 798031800107;
	Mon,  3 Jun 2024 05:30:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:30:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407034; x=1717493434; bh=hj+LpBOrQP
	dhbdOzakeTiy0VVSU33NIpJ1Yc/TmS8sQ=; b=Ro+ALmGPUiqIvo+J15LuWCqIax
	08TY72SluCr5HlhsJ31840vavjJ9wC6dlKocbAv6F0b5BCxQF6qB6uJjxcgzLXEE
	/Hrfc+OWVRF9N+Wn2+u6li/PgsxPtlTqMe2Tj8R+m9b+vWLMA6w0pZao3lCM5vKU
	EYeCxDJgXBOVo+BFFrJy1xeiSMyq0gJchCwhClZld5Han11WuHWlhkUGrI9w29s4
	HRioDFT/AHHVo+I7H4oGp6AWDeRu9iCfaJp800LEa73/vafOqhpo5wfudAX8jvhC
	I726TQlMdT1yj3HIwNyBJmOqQS2/ebhxEFaDcTiL0NQq+qL1KZdzw/ogwPKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407034; x=1717493434; bh=hj+LpBOrQPdhbdOzakeTiy0VVSU3
	3NIpJ1Yc/TmS8sQ=; b=hMXvtw0hxRDk69G3SnUzJXc04tiwt2Mwgh0TkNy3+Uqp
	5M67k3HZ87wLZumE349oion99K3e+UAr8KN8HoGk3DiyXf7G/I16Wwnpqu/3CHjB
	B3IOAxE/apQzE+kR8PCEOPEolVZTSN2FEn4Am22NXIpWtJGzViRKOp+lFY/wUQlK
	WR0G6az1s6vH5fR0fjZRN0zP73naFEkhL0yDfIrKqdQ7ffYzgUMv0xgoeM9lIz7U
	pTcDmEFHYgmb0J65DkKYKNNYXOcWsVJyfdwN+XIADmUbdmrJdlI/JB6538rrNH9P
	21D6gQTTPMYl10E0E85iMWteN8TdxGSAQVTVxDfw/Q==
X-ME-Sender: <xms:OY1dZhEweek1M5hRC9uLRJpvfQM3DMhPZ3zlbRIqmng3ufUI_ZlncQ>
    <xme:OY1dZmXZap_KGPZNlZmS6wYebl0GFY6lvFA1JXK5gIWaz6-sfYwp6Q0Pf3i5ZyVph
    RO2iBWCsdA4tshWlg>
X-ME-Received: <xmr:OY1dZjKmS9ahklmgI22koabIUOA75K5NSD02nEDJbIhkTLz6BMSC4p0TjXbLHM6ueB4oAEOtHrKtBrKyIv9D_DNB4IpLP06qlMiD5XWD7ohFtu3c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:OY1dZnEbggxK8RbhY4lyem_5lSaDnAwz6fmMzNJhRLJMw8g5NypdNw>
    <xmx:Oo1dZnX5fL4vWNdKp_yOULzJAiJ6Dogc3JXYOlYp1a3yQ2bj6fWhsA>
    <xmx:Oo1dZiPxF1IYpibl26QYIey_2nuKxxX5KogIYhDigp5gNJ84gE2UnQ>
    <xmx:Oo1dZm2vuI8knxJvwACB3WykqI9ltBLChjSYuyZLDvMKoM8yGbL4Yg>
    <xmx:Oo1dZteBgs02eTfdCwb9zvdTR4Vlh_JuWAi0gnDOGXIRhahxc3N1567Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:30:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fe2d3231 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:30:08 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:30:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 05/12] refs/files: refactor
 `add_pseudoref_and_head_entries()`
Message-ID: <7f9ce5af2eb316477160224aa087ba6290cad672.1717402363.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1717402363.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WayycnOwHDXg1Ihl"
Content-Disposition: inline
In-Reply-To: <cover.1717402363.git.ps@pks.im>


--WayycnOwHDXg1Ihl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `add_pseudoref_and_head_entries()` function accepts both the ref
store as well as a directory name as input. This is unnecessary though
as the ref store already uniquely identifies the root directory of the
ref store anyway.

Furthermore, the function is misnamed now that we have clarified the
meaning of pseudorefs as it doesn't add pseudorefs, but root refs.
Rename it accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index bd0d63bcba..b4e5437ffe 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -324,16 +324,14 @@ static void loose_fill_ref_dir(struct ref_store *ref_=
store,
 }
=20
 /*
- * Add pseudorefs to the ref dir by parsing the directory for any files
- * which follow the pseudoref syntax.
+ * Add root refs to the ref dir by parsing the directory for any files whi=
ch
+ * follow the root ref syntax.
  */
-static void add_pseudoref_and_head_entries(struct ref_store *ref_store,
-					 struct ref_dir *dir,
-					 const char *dirname)
+static void add_root_refs(struct files_ref_store *refs,
+			  struct ref_dir *dir)
 {
-	struct files_ref_store *refs =3D
-		files_downcast(ref_store, REF_STORE_READ, "fill_ref_dir");
 	struct strbuf path =3D STRBUF_INIT, refname =3D STRBUF_INIT;
+	const char *dirname =3D refs->loose->root->name;
 	struct dirent *de;
 	size_t dirnamelen;
 	DIR *d;
@@ -388,8 +386,7 @@ static struct ref_cache *get_loose_ref_cache(struct fil=
es_ref_store *refs,
 		dir =3D get_ref_dir(refs->loose->root);
=20
 		if (flags & DO_FOR_EACH_INCLUDE_ROOT_REFS)
-			add_pseudoref_and_head_entries(dir->cache->ref_store, dir,
-						       refs->loose->root->name);
+			add_root_refs(refs, dir);
=20
 		/*
 		 * Add an incomplete entry for "refs/" (to be filled
--=20
2.45.1.410.g58bac47f8e.dirty


--WayycnOwHDXg1Ihl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjTUACgkQVbJhu7ck
PpTslg//ZgIQevvaC3yS8SZBkLJJ4Ujb2Z1EsuhpVPnHiH8bGuq8SqzG5dWhkNb7
V5xnR9LMJlNwMlW/cL+JI4OOylFx8OrWf1UgXiBcVTUi6c16Jgm4/04Plg5Yt9az
7D67KhuP1bw4f+YzT+ahkyLBe/02uvimQKcYVOhrAmomSztrH679U1i1L2OeJrbj
pMkZQpiFznfW8uBOEvWb7ooS8YVUs5yrW2cgKmO0kOcWytX6gavzjVjueu7tpEG7
+7hcppmf6F18jSIfI6Gt7cwP/rez44Pi38ffV6PQJXBd9h0v48BcNGDtKu/8q7Hw
vXfBQXHjI3wHqAfDbDWH95jDBjKiZjjf1zTSbcvCPqPeZHag7/MGf1ZMPbua7Tu4
dp3w++xAKZ+9uHA8dmfxjWFig/kgQSTk4M4zskrTviABEy/MPiE/sLV1eUBaQsOX
UcX+3FKH7MXe8MiMAX6VqixGHhw1y1+Ul9WBolArXQxdfhH41iA7Fy6yFW+bYPQa
EvvF0tMm4rte3ppJ7z5gmEERQr7A7jPntbFO9UOTokmPXxYLlFzuC7jGu0qMAhEB
LWux5K+awc7BgnL4WuwZnrmSAEf1pDrmkFcsc1EXBy6Hwf+nzZcIKBB0hWVGKWGu
kpcEqVfL3oIW2JhT9oXEiWPcmAdwETvNIDrH6Q1g4unuZ1V+A+U=
=Lb5L
-----END PGP SIGNATURE-----

--WayycnOwHDXg1Ihl--
