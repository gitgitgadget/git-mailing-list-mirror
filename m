Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A1117BA7
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085923; cv=none; b=iFFyR0HTOxbJfsNCrysSECmg7l4a+MB3T6Y1/NKlXSBwxK0hO798YVQjZC383rorJz/TFkio6Lo2b4x3AjecUMviAM0HWL44VOf/HmLyt7QD9XIFIXT3IdkxYztNLb5I2H/qVGeIiVUWtjQnlfseo7q9geY3PVAtfG6dY2kr/ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085923; c=relaxed/simple;
	bh=zmrDUjBK5c7fykf7U/U1qFg3JqSkYlm7daF1YoUfUig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stMuDszX7uJUbQCMJCPfotN0wsLGcj9CLnImV4Y7Vb3bN1TtWUhCqXeimXJbFEdzZtYbAIaFdTysAX5ngjmkY3na6I5miGXeISvoo20PvxMhrxNgT9MIdKryqeIqb6e0uePV3xAbRMagb6u0UbDMkMOZnTo7kCaVpOdJD0G1jfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XxEFSM8K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICwthGfJ; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XxEFSM8K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICwthGfJ"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 65BFB3200AF4;
	Wed, 24 Jan 2024 03:45:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Jan 2024 03:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085920; x=1706172320; bh=74P3FhOlAU
	MZfr/nd8aURIExKvc24D/TaOswH9k9aCo=; b=XxEFSM8KwqIbrRYTwQl//usJ+D
	C4ctZTZu/5iBSiATeBq98z+qVlpfJ7GV/n64ZIUIRowr8JCQ4H2qF8jh4C71taV7
	RwmPflLUiNQAJUsEkVgyxYFbUCMywwm0aJ+XRiie5cGYd2OO1HRmautN+qlowpj6
	HEl0oDfgpHiBRAbFDgnbnYxk7SuN21Zy2tKKRn3rjn0l10UsRBjMAbz7HR13VCqr
	6cy1zrfI/kaBj0jg/DxBlNAeIm8F2EC2crHfHODSmw15d9jfeR2XewnQ1FW2DPAe
	BswVVuU+I+UopMl//t3OnNq1KQ71Z7izzZ/5mGv8ixzzKjewnMFUSEnEugXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085920; x=1706172320; bh=74P3FhOlAUMZfr/nd8aURIExKvc2
	4D/TaOswH9k9aCo=; b=ICwthGfJGtYTGxqftMN/mAEQmeyzwLeNBM3QP1sWzZnd
	siQ9dQa2GaXuSDM7kpKNIMJ/D5gP/ALnL4pjn3gXqlDy7lI/QOoPGid0dtraZkLy
	Sb70ZcYhJAbbtVgS6+vwr9s+bVXNqg6idIpmh+/1diUs9H7I/CtUVIXCumMS9n46
	gYqJ8gZ/WJVYHvlbMFBXsAbCadaVqVLEZ+rRyNwRYHd/95G+DdyevK0pE6gb17/Y
	HgCMty4nWjGTXuqzHMvrZjOSCvTeiFt5rH02E3NYazGXWo21LeDC3gPydVb1Ogx1
	ou7EviDSj23AW3MbskyvRk1VgSpCMtyYBxSzDptBcw==
X-ME-Sender: <xms:IM6wZeGSrtZxsBAuk8yOq4RVRuqfcMtII3Bcc9alVnkVLcJ1o35Oxw>
    <xme:IM6wZfXLrA3fEViyKh1Kb3QNOkogk7ElX0EZwWgqoQh58vFhA2mc_Q8y9OyO9shQr
    Wv08tXHlNs1NOz-Xg>
X-ME-Received: <xmr:IM6wZYJNDYWuyM3PCBn3oCOqJoOkS8RTzCE2GMnXl1PTGzV1WC1TIkK978XNi1-k6Aj2FfNbbZC1MDMcwk9pOyYq0gwvLiFfXNoK8Vvh7jZPPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:IM6wZYE4CA-cI8-CsL7xgL3kCuVtYJ6w6dIT_m7mD06wlrhcabnMnQ>
    <xmx:IM6wZUW5c_pWYjAvHwa-72VcRyB35ZBD5eGyGsO1NWEqPZ0Y6i4S2A>
    <xmx:IM6wZbN8PL4CIiD5WI7QyTts6I6fLuukxzx97wjc7JoCghUdljGhNg>
    <xmx:IM6wZSzl94KoFN_OcPfIrugev1NtlGj9aWXN1TOx2Dox6ddSPywtJQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2725060a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:42:13 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 4/6] t1419: mark test suite as files-backend specific
Message-ID: <d0d70c3f18d79e9f24f912a4944ccb4c862223fc.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706085756.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rEl8bUPTzcdfbA7+"
Content-Disposition: inline
In-Reply-To: <cover.1706085756.git.ps@pks.im>


--rEl8bUPTzcdfbA7+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With 59c35fac54 (refs/packed-backend.c: implement jump lists to avoid
excluded pattern(s), 2023-07-10) we have implemented logic to handle
excluded refs more efficiently in the "packed" ref backend. This logic
allows us to skip emitting refs completely which we know to not be of
any interest to the caller, which can avoid quite some allocations and
object lookups.

This was wired up via a new `exclude_patterns` parameter passed to the
backend's ref iterator. The backend only needs to handle them on a best
effort basis though, and in fact we only handle it for the "packed-refs"
file, but not for loose references. Consequently, all callers must still
filter emitted refs with those exclude patterns.

The result is that handling exclude patterns is completely optional in
the ref backend, and any future backends may or may not implement it.
Let's thus mark the test for t1419 to depend on the REFFILES prereq.

An alternative would be to introduce a new prereq that tells us whether
the backend under test supports exclude patterns or not. But this does
feel a bit overblown:

  - It would either map to the REFFILES prereq, in which case it feels
    overengineered because the prereq is only ever relevant to t1419.

  - Otherwise, it could auto-detect whether the backend supports exclude
    patterns. But this could lead to silent failures in case the support
    for this feature breaks at any point in time.

It should thus be good enough to just use the REFFILES prereq for now.
If future backends ever grow support for exclude patterns we can easily
add their respective prereq as another condition for this test suite to
execute.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1419-exclude-refs.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
index 5d8c86b657..1359574419 100755
--- a/t/t1419-exclude-refs.sh
+++ b/t/t1419-exclude-refs.sh
@@ -8,6 +8,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+	skip_all=3D'skipping `git for-each-ref --exclude` tests; need files backe=
nd'
+	test_done
+fi
+
 for_each_ref__exclude () {
 	GIT_TRACE2_PERF=3D1 test-tool ref-store main \
 		for-each-ref--exclude "$@" >actual.raw
--=20
2.43.GIT


--rEl8bUPTzcdfbA7+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwzh0ACgkQVbJhu7ck
PpTKXA//VE9pZIyB/PZEZ/njO1Co6GJBv+qPovuBnjjjcbR2v7iGSnA8tvrmlTN0
Ba/SQGP/WPmvOu5gk9timpOXy9tttEWj3y5hVv/HRBnUq0w0XlSGCZ9uY7xgjnru
tEz94cBqQ/GhYeyg6Pav3Gv5VpitpqH9Fp6zkJscXKCXP2Bkd/DvaqgUP+hmcbKS
U40+pHUNnvZbxICm9JhvOs/DlocBmWsw3+RYk1Z55JkkIhDBP3PcNz6Kd9/vYEwH
ifwtLzRqdzpBDWY/AipxA5YbwdnH5YfK5rP6GoWs2PpRlXKh3+Jpc2Ns4R+nm07X
hv4ylLs3MdRxaqo944a8+KG0IAWV+a3Gb/VGkv5Ssap8J8X4hxb8gomFwUcEoI9U
ORLdSr6GydxyR/wT1Ur3MAr8wgcp0nzaHW/dal5NE+kFvxzy+knwKTP7r/FcYhBO
hKk58/PlJnhe1F5qJFY19ninCzIC16sYL9hjpJBL0XM32qZyPRUt8tbEgF3aJIca
XnBSQ7caJilS7t7XpT+Y+kbkljcS8NOwDx/vkbSwblb4svg9U+OjVVLPKFsqODSs
hy0x4vozKsqCMSS7jkRkInGuzj85dwqJfTpjV3g4ZaK8Meb6G6z4YWbQE+U8LNKc
3e0zsbGlpn6jfVjOVMrpQ7yWqMzUbeKTS0pPF/4hF9mUiokQEL8=
=uZfa
-----END PGP SIGNATURE-----

--rEl8bUPTzcdfbA7+--
