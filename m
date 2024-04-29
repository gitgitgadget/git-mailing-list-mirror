Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E658213AE2
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372484; cv=none; b=FQTUmBLOW3Sf9gO05V89UqZx+2vD2Sj4Gmm+V4FMHyskxPF0O+Mw06Qgg6Vu4hv07XfbhDrl+Daa3c2ld6vJjWzJUzyTzLfudeWjCYYgwisCJ5h4ZkbTVbtNI0BYbsWCqq5MgWmOttYZCkfHzEO9X3QPrDyIU9gdhONcAvVJb1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372484; c=relaxed/simple;
	bh=VtRXmU3OY1pf6shxLSkWHvS4cFLELcUan2P9dGNOFDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gcPAwz2QGrQSfSxQKwyuVa3DoHwfwWGzv73u6x1dEtyavIEPFCYNWVnGFKavoOtcGbU4K5CVlK2KSMpxW+TqiZ9/Ntg8cNmR6xCOQC1xNLmKCaj5FTEALEZ94ma1wMYaCJWZGvjI7Y7tvtxgSn46qlTPAV/S9sGFeXQeYq1Qz+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CzRcwNeS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UbYBbC8U; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CzRcwNeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UbYBbC8U"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EA36011400DC;
	Mon, 29 Apr 2024 02:34:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 02:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372481; x=1714458881; bh=0KZMQVqegZ
	OlKViKapt//A9VOtNn9wYHnoX3582WEIY=; b=CzRcwNeSG6RsgDRkzBuFZyzlR8
	FxFIZx37LAWgwnOBia1+UIKGc377wiPC9Hq7pLrQc0SNz+De0C/z+8XdHIwQzPOi
	8hW5WA9TgIH9z7DyWw/7wdrbhAFXjtkyUBkY6SmrrskNsBrdmlt2TdVqv0Yju9nS
	EyrBeE71r70mKjiFAlYbCWxoZnv3hZpNVpc24I671FqL4G1Xb9QA7SYFOGSF49or
	GxWg6nkf77aHBodg4ttodp5gH8gd5xg4sCfj5gjG/HR5xFf2dTmEk1eYOseCo/d/
	q/bEL/3lAUap2PWRvtaBnNjXJ1VANJ7U4yz//HOo/T5xHQ2Rwb0ctJHz3AvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372481; x=1714458881; bh=0KZMQVqegZOlKViKapt//A9VOtNn
	9wYHnoX3582WEIY=; b=UbYBbC8U/bTKz0qwHZgCoYEGEYcdbRfcpa8GQcN594zY
	VKKT8W2L2xAAP35qy6E1YWMTYBUwfEQceXgIM3vTUH5Ghwo4cwE4k8BVIFmfk2K1
	lMYQIt6dl1yeyvgStiVyfhBkUds367coXd9UTdJFH6kVe+bm5+PyV98mIk/iSI6/
	NMGbuN9KKRvPeL2kIIo7+cO9+Po0oR3KqFOfqtONKqEEuFDkl7GHoqGn5yIb5eP4
	Nnrd8mDLSOp1K39ziL4KiLGzOOdwPd2Fjn+rz/KTVO8rKX4F5gEDloldFHXIkIez
	TFvNsq0TwU40ZvleWLfdQ63wmW9O5JIG0xbX2o+sMA==
X-ME-Sender: <xms:gT8vZvHaT1j0b3rmq0SQI8FoDp56kSP72TtD21DRSOOzPsOiHy1iRA>
    <xme:gT8vZsXa1nSyPKd6Ds0G9AhlqZegxe_oI2EDaaCM-h4UMvaosCkc6LsfW7dbilPNJ
    mmkhiFIqwS6zHqvig>
X-ME-Received: <xmr:gT8vZhJ8BENUrfudkE6NpIu6dI_EsTaL_Etp-_fRKohrJfVshUH4gP39uIXm6XvzCvrM473p2qitJceSF3YphuN2bWqTS7q5n6dyKgVdMkVEEN59>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjedvjedukedtvddvleejjeefudefgeettdegffdtleekgeehvdfffeeitedviedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhdphhhtthhpthhrrg
    hnshhpohhrthdrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gT8vZtFr3NEciApEjO5H8OeMiFBHNyRKYxz0I1WYVniq-QoQMYiElw>
    <xmx:gT8vZlVyp0KijXMrQUBHmgfY_a6HGGIPUL7Lc2F8VHz-9Q6i2ulDmg>
    <xmx:gT8vZoOoRm9oUZzdWiiJrUwCvHvOJuo4uGSNTlsQajTpKyE3Fpo_7Q>
    <xmx:gT8vZk0D3UHPJgMYK_gZyrUZzTqVgETHv21wwJQC-xZII3Xbs8ptwQ>
    <xmx:gT8vZrzOnGQE7RIN-PC6_2Vxafa1H5PklsOdujCq3NWCGNo0cwMTKDF5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bed9a6bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:21 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 06/13] remote-curl: fix parsing of detached SHA256 heads
Message-ID: <53439067a1e94075c3f432b6c2774b1cfb11e88c.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="C3an7qiP+h5x+o4H"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--C3an7qiP+h5x+o4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The dumb HTTP transport tries to read the remote HEAD reference by
downloading the "HEAD" file and then parsing it via `http_fetch_ref()`.
This function will either parse the file as an object ID in case it is
exactly `the_hash_algo->hexsz` long, or otherwise it will check whether
the reference starts with "ref :" and parse it as a symbolic ref.

This is broken when parsing detached HEADs of a remote SHA256 repository
because we never update `the_hash_algo` to the discovered remote object
hash. Consequently, `the_hash_algo` will always be the fallback SHA1
hash algorithm, which will cause us to fail parsing HEAD altogteher when
it contains a SHA256 object ID.

Fix this issue by setting up `the_hash_algo` via `repo_set_hash_algo()`.
While at it, let's make the expected SHA1 fallback explicit in our code,
which also addresses an upcoming issue where we are going to remove the
SHA1 fallback for `the_hash_algo`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote-curl.c              | 19 ++++++++++++++++++-
 t/t5550-http-fetch-dumb.sh | 15 +++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/remote-curl.c b/remote-curl.c
index 0b6d7815fd..004b707fdf 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -266,12 +266,23 @@ static struct ref *parse_git_refs(struct discovery *h=
eads, int for_push)
 	return list;
 }
=20
+/*
+ * Try to detect the hash algorithm used by the remote repository when usi=
ng
+ * the dumb HTTP transport. As dumb transports cannot tell us the object h=
ash
+ * directly have to derive it from the advertised ref lengths.
+ */
 static const struct git_hash_algo *detect_hash_algo(struct discovery *head=
s)
 {
 	const char *p =3D memchr(heads->buf, '\t', heads->len);
 	int algo;
+
+	/*
+	 * In case the remote has no refs we have no way to reliably determine
+	 * the object hash used by that repository. In that case we simply fall
+	 * back to SHA1, which may or may not be correct.
+	 */
 	if (!p)
-		return the_hash_algo;
+		return &hash_algos[GIT_HASH_SHA1];
=20
 	algo =3D hash_algo_by_length((p - heads->buf) / 2);
 	if (algo =3D=3D GIT_HASH_UNKNOWN)
@@ -295,6 +306,12 @@ static struct ref *parse_info_refs(struct discovery *h=
eads)
 		    "is this a git repository?",
 		    transport_anonymize_url(url.buf));
=20
+	/*
+	 * Set the repository's hash algo to whatever we have just detected.
+	 * This ensures that we can correctly parse the remote references.
+	 */
+	repo_set_hash_algo(the_repository, hash_algo_by_ptr(options.hash_algo));
+
 	data =3D heads->buf;
 	start =3D NULL;
 	mid =3D data;
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 4c3b32785d..5f16cbc58d 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -55,6 +55,21 @@ test_expect_success 'list refs from outside any reposito=
ry' '
 	test_cmp expect actual
 '
=20
+
+test_expect_success 'list detached HEAD from outside any repository' '
+	git clone --mirror "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
+		"$HTTPD_DOCUMENT_ROOT_PATH/repo-detached.git" &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo-detached.git" \
+		update-ref --no-deref HEAD refs/heads/main &&
+	git -C "$HTTPD_DOCUMENT_ROOT_PATH/repo-detached.git" update-server-info &&
+	cat >expect <<-EOF &&
+	$(git rev-parse main)	HEAD
+	$(git rev-parse main)	refs/heads/main
+	EOF
+	nongit git ls-remote "$HTTPD_URL/dumb/repo-detached.git" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'create password-protected repository' '
 	mkdir -p "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/" &&
 	cp -Rf "$HTTPD_DOCUMENT_ROOT_PATH/repo.git" \
--=20
2.45.0-rc1


--C3an7qiP+h5x+o4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP30ACgkQVbJhu7ck
PpS/yQ//YCVR14XY3Pxq7EpSLbcUvaCu9Acs2KwOKibZJqNLGoNI5G60Maq7mBaN
AeN0ZK43axQCA0vu778eSEqV9/SvlLi51wpJWp1li8HmFT4p3CtncgWE9TEobUGC
Nee04kXCr54ZYyOK4bg9zdH69hOmhgJ+DSmG01NeG0Te+yv4IZ1cCeZ274D7D7gm
R4QMgAZftoWQhggCOGlQ0AxP2XQKoAMkZNfa+P1B+MemYY1vCu9odRBdXsbSHRPg
wzNNeU3JbsZ/mj8fwkf88DJN4ndf9Q7Qax8Z1y9tmDY6OFbRyw3DE+hWxghSbijZ
eujbvElcQkdPFoVtxvtnIH7f2JMxRF8XK5IWFaCJEbVhTjAHPJJBE+tJkPmifPoi
isYpLTQNPawtv8jBqJJUWu593Y1I5L1sKNSvAvnUSv+J+XDrG77XMh8YXb/a7ivA
mcix6+qJA7ge6Jy76sXYZbvQO8ZFImcCs3Vz3ocrUCUQk8HyJSOaSiaLd2CZyH0d
5M5w8XcGVMwvNhmyR5YH6WcIpauOs1NNFxEOkTKBz2qsbLfXZtVSwGRXSlMmlAS7
Z2wnAuIFzODbjMi98sxHirHBTVMNNHW3gmDbpLq8hJ8ioIOHKyuz5aSHu2Cmm8MO
gCKui5zjkt88u2cBF4qD8fxHJ39tURGnR/sbpVl/N37Liky07xQ=
=Vmdc
-----END PGP SIGNATURE-----

--C3an7qiP+h5x+o4H--
