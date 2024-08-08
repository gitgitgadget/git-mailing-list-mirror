Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8EA188CAE
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 07:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723102561; cv=none; b=Ap4iX8jfsTu7XZJMraIEaS61M3T39wzWzvgUJ5/P6jk+i++OC5zNcgolJv5wzwAcDaJtprm/0sadbHv54yFp33rYSBfi8lsiJZ2TjcGYCRkh0/3vu+Bu0ppg1wLLuCo07YzWd/+fmBoOwvqS0f9MmbXyxdTmFq840BpArgr+ZiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723102561; c=relaxed/simple;
	bh=LGMkl10FM+0W9xFnf9XcL5J6xATPimqHtR/5EGh/NwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gjcxru+oqWrOaCWCuyWNbKWzgS+Id0lTLuzuMw8Tt4LRoUzMDVlFqYssr3ulqmX/8iCIohg1cYhY7o/iiXxBeQoNPzgdLCuoY/7mC/toeaR0VHfN3a2HhvAkrAo+NTm3qeOAPyqURlr/of+BVThWvVN0xIwLQfdhuuwiqVamNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KtJkIKV+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llYQNG4L; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KtJkIKV+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llYQNG4L"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EDA191151B80;
	Thu,  8 Aug 2024 03:35:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 03:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723102558; x=1723188958; bh=hv1CIfxmPF
	7BptPBkx+G6Dyrawma91txl0UC4/NUnzw=; b=KtJkIKV+uadlqyyGk0UYUsUJR1
	QJj5l44C6Sh2yVOu9E6Bajd2u/HJ9rWWiqhmUvyqDGTSh6rsnRAlzAFZlCNOa8v0
	Ap6YAEZkR7Epm8rvfuzuRAi+a7coUX4Zgu0GuC+OJPXZnSaF3B2vtnl23eCsqidv
	kM+OTvBpC9IwkUSjs5Tjfff+dSYs+ITNlT9VDAeSTuAp7ZGzom0tVxIztU/iad45
	0KnHLwfdEXpubauX9I7/Vz2TDSG4n75Ed2Jx4r5VrEplaQn7nctZwr+qBREn8gpF
	nw2Y7cZQ+d8xLTggJsYwczG2CmL+fIohkAeszdaOuVZGct9ufU4hkoQ9PIWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723102558; x=1723188958; bh=hv1CIfxmPF7BptPBkx+G6Dyrawma
	91txl0UC4/NUnzw=; b=llYQNG4LSzZlLz6ISKILWH+g2aFeimHnjrDgEUVKs/B7
	XnGtH443v3v/HuaSE+n7rzKgrtuMLLrf5NozF4swG7cX8oAmHk0z3TFtsrt+Tkk/
	boVlg6RH1MtLTNyOIlfXQFNbCLDu5ZM6zGBevmLy5ZtHtVy4LdDoXvU0tdGSnets
	pH9VdvkBclQsPoAUSrX8xnv0tuC+EbCp9XAsVjD1HuePEMCWBVTDzkHlyGjq6aCR
	l+7q+1qCTsKfs41n5I0+1qCL8P7I+KBCn59cZGZofjIvk05D4vkeZrIBsKJ/QGpz
	BUVGsQA+dFzbhrPjzv7H+nzQAcQPE5yAWtWHPekqMg==
X-ME-Sender: <xms:XnW0ZnYWFbhhp6Wv-JIv6QdkeL1SVzYG4z5Qc1dKO7Lgld85qSL2Uw>
    <xme:XnW0Zmaw5qNq0_aVmZbE3CdhAanaaR-NXbQMm4q5CXypGbs9gG1y48xOfLFpQJb8J
    g3imFuHxhT5BRkkvA>
X-ME-Received: <xmr:XnW0Zp8XHRXxS45kvgFejtXeSnYyfgjA3hAmenAEUa5aW-Jswp27pEz0RIlAZr0OL2EZLQTSXbGVAfACrHZI4PSlkTgVSKLOn3DHgxU06BLHms8m>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledugdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeg
    hefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhunhhs
    hhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehjohhlrghnugesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:XnW0ZtpUEw7eWTyzkE7UifG3TZBPT__-dtemfZ-8VG8lQVRjEW3gkA>
    <xmx:XnW0ZirBst0jQ7WCWogXaX3S2tlEvghw017MCEcu-B8EyBaAXbmOJQ>
    <xmx:XnW0ZjSXRv7ZmLhHDSThJTXBe10O8vcNcXwKLgNOOxZ5xbceZih5UQ>
    <xmx:XnW0ZqqqdJ6vvYki1ZjpF1YR12JOTpq0kp-eJfnzFV5uuQCBrBeylA>
    <xmx:XnW0ZrkkjXhRW8vcBpiXYeqbtUVlx4mkPMdNI9wZi51VnSE6dVxIpOpi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 03:35:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e562387d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 07:35:51 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:35:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] submodule: fix leaking seen submodule names
Message-ID: <e9421189ca0886e81511e191ace1af6e65c0e292.1723102259.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723102259.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J1N2HVGjkzHTG+NI"
Content-Disposition: inline
In-Reply-To: <cover.1723102259.git.ps@pks.im>


--J1N2HVGjkzHTG+NI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We keep track of submodules we have already seen via a string map such
that we don't process the same submodule twice. We never free that map
though, causing a memory leak.

Fix this leak by clearing the map.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 submodule.c                            | 1 +
 t/t5572-pull-submodule.sh              | 1 +
 t/t7418-submodule-sparse-gitmodules.sh | 1 +
 3 files changed, 3 insertions(+)

diff --git a/submodule.c b/submodule.c
index f027a6455e..13b8f8c19c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1880,6 +1880,7 @@ int fetch_submodules(struct repository *r,
 	strvec_clear(&spf.args);
 out:
 	free_submodules_data(&spf.changed_submodule_names);
+	string_list_clear(&spf.seen_submodule_names, 0);
 	return spf.result;
 }
=20
diff --git a/t/t5572-pull-submodule.sh b/t/t5572-pull-submodule.sh
index 51744521f7..916e58c166 100755
--- a/t/t5572-pull-submodule.sh
+++ b/t/t5572-pull-submodule.sh
@@ -5,6 +5,7 @@ test_description=3D'pull can handle submodules'
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=3D1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
=20
diff --git a/t/t7418-submodule-sparse-gitmodules.sh b/t/t7418-submodule-spa=
rse-gitmodules.sh
index dde11ecce8..e1d9bf2ee3 100755
--- a/t/t7418-submodule-sparse-gitmodules.sh
+++ b/t/t7418-submodule-sparse-gitmodules.sh
@@ -15,6 +15,7 @@ also by committing .gitmodules and then just removing it =
=66rom the filesystem.
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=3D1
 export GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.46.0.46.g406f326d27.dirty


--J1N2HVGjkzHTG+NI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0dVsACgkQVbJhu7ck
PpSYiQ/9E/S8ZcmT5YvjIt7qwL+jQzr2NgAyll3tQCN1xq1nnwD1Gv/96Tl6Pgir
dcPYZRoLA7WVksSsc5VELofUJ3ARx1Hmh3g4bITSJ8WLfrk+7Q4gqdZMoPpOs2IP
blIcfDGVI34mPjK+5piai2U7mGNKNT0G6+mhzg02AQuvJTGQ/PCWOsWWFLWpSVmy
irTjEkf40jpxtq5V0TJrby+Lmv9SDGFgtVxr8qhxFoZCT0GBLN2OFO5HqV/rHIlg
RzYdjcWl4o75moPSQs7et67QudtH9tJ0EmEPjAx5FepSZCzsVia2s5/AgXACpD+C
fbpYfME0n/ikczxxuXm+ayyyVZivzjhK6xiPqmthShT5Ug2lbSJqx5jOOSk5FC3/
2MiButD4rG1W6ckqNZEqUu1khUuPPgAOlFZdWEa1JXWf53jiQh+oftJYS7ptwCYK
8raecOvcJB1Mbgo41kEjq+0msrf95h/l4M1mThPE0usqiRmhl3oNwqNv6/YLKyrT
roiidsvGyFKyFPnoMt+lmUSyA0C+nN/iOjUkfjjIUKx+moq3NHhjjtSqqISnsehT
8qjhZBgRM6dUtuO8mV/7m166CLj7Rk/9oUwYuyyU/TWsLBLtSWonLQNIrXvp9B0P
itof5LMheus9ptWkJHQeTGtF0hGZ8UjmhJ4tZofMPm7mcSPaEW8=
=9dEO
-----END PGP SIGNATURE-----

--J1N2HVGjkzHTG+NI--
