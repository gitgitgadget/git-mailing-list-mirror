Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7D6A8C1
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057599; cv=none; b=Z263GOPBubB1IOXF2n5BmkS0R2qhv5e4JWx38R8eKgX80VMD435W7wO6TRzLUYmZ6vlgn4Gs/1bhsHpA4f0YJKDN0x0cJ2IfxL+ygQ+HUMe+4cXmrxormUPvWHrkhglWYaK9XYARi06CWnTYZUMBsXAkXRT3na8bCvIFUZ9luxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057599; c=relaxed/simple;
	bh=GFI2JGbExCAMSOpN0wtY8xvHAByNkoq+sYaPRxtSIHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmP1znWyp2RB0+Z1/YXp0SpjBssE/R8QWXABBkN9MWTgYaoVf8jhdBdcS7HQ0ym9xAYKkBpUEscRFsPlAgUdv3FJEQo8qQmUmx5n24oYIKaujXkAkyeaBHHK1rZ9w/YDn91EmhYL2I8SiYVQUozWO3D5qq15+feozx1bqFq26gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bEpLH8iz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TSvgWG1l; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bEpLH8iz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TSvgWG1l"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2895114012B;
	Tue,  7 May 2024 00:53:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 07 May 2024 00:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057593; x=1715143993; bh=3Sxt1xLk90
	E0Xa30iUrw3cey+3Vp1+vDyrXofV66Jd0=; b=bEpLH8izK1R0j3QLcPDkRaNdRU
	DKgPnFbo+tK3Wk6xW4nr1spVNxzepyx0RSnOWbgHlp6dXsT6rMCEHi6J/e+NDjVP
	dRKQfvB2I0xo3nSg6ppkt5Bi41hS3xfQFl4QjUinHdsaD8vuhbQfyGV4hSa/oatl
	9lJxTt77IKvcOY6RbO6DjVdgi9WNJKPYNm3zsE1CibxK4KkbbZ8dQPx595iSaU0c
	VHnmLps1DMy5qXL3+gc2Gwouj36jGzqszKnRrXwuMWiFwzhGXvjje/kcx+vcWorp
	USFw1ZExxR6+zLMx8lCNK2GXh6tMgu6zt89/X5T5izvS8ZuK4bXBNXLGZtFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057593; x=1715143993; bh=3Sxt1xLk90E0Xa30iUrw3cey+3Vp
	1+vDyrXofV66Jd0=; b=TSvgWG1lq+LvA2f2V/zZHlEgh4GyWa85J6Q2e+vOS4dF
	84EZCnDNBLhZWWAPdH5sn2AhfzJHzSSTV4AG1y3zHsKfGrnnMcASNfKc1OCRXNPG
	JyNOzahe8FcG0Y85cfIDdv+p5k83023ywyx4+wG2sLd7tQq6WKhqiDPL72/m6Jyl
	yWeh+JblCmXuuThVC0MirtKyNPxdA+0gWo0SgtT96PDUggutrBXmC0CFApc1e7sa
	cYZifERVYWvDBYVjISPO0hcL/ImXkXAq6y4O+PD8zo4wEgDJm0ZYJlI8cJDRMuGR
	RbT4iPDfMMuHN946nfnTRg/xQ3+8+LsRiuSYwGVubg==
X-ME-Sender: <xms:ubM5Zvdut3q2lbRlX631WhXexlReTqRSWh0sQ30l8qloyNC6umun4w>
    <xme:ubM5ZlNFdtOdARzf2psQN2HNqawn76IdmyFo8Q8MVoYTrv2ZWt5I6Ob0kCMFzsQJ1
    Z-Yc3iTchzEywcswg>
X-ME-Received: <xmr:ubM5ZohuiCVr_AX5LXQrtB-Z_JA5cgJJc3u_p4etTftZMtxAKGkdeCK4A-a4vpog10T6Bz9752VIUhGsRLi5FPSmCvE72kENQ0IxcbXkQYwOTdpaPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjedvjedukedtvddvleejjeefudefgeettdegffdtleekgeehvdfffeeitedviedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhdphhhtthhpthhrrg
    hnshhpohhrthdrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ubM5Zg-sqKjRMvtsujKvptVFaHjq4iAdFHoAJ9wDKmtRzfUEjpRBRg>
    <xmx:ubM5ZruAfjYu2kWkACnkw0HbU79ML3KaYMi76XbDAf14M6znSGI6sg>
    <xmx:ubM5ZvFtzzKCCs5ekSXTzqf44zTtqeVcViIE0NLImyeXzg-WXDJhLg>
    <xmx:ubM5ZiPn4cnosE-cf_mhhU-ogowmuR0ucQYvO0c_9rdv7HEbpkhSgA>
    <xmx:ubM5ZlIXrs6M2BGNGdKTbZuumudMD8jzjtG19jNepAOMTBOsHFn4DKDs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:53:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5df331ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:53:05 +0000 (UTC)
Date: Tue, 7 May 2024 06:53:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 06/13] remote-curl: fix parsing of detached SHA256 heads
Message-ID: <e8876052ada5845e9a5ea4e910ff9da2c0837c07.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V5RGFHjihPaGKd8C"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--V5RGFHjihPaGKd8C
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
@@ -265,14 +265,25 @@ static struct ref *parse_git_refs(struct discovery *h=
eads, int for_push)
=20
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
 		return NULL;
@@ -294,8 +305,14 @@ static struct ref *parse_info_refs(struct discovery *h=
eads)
 		die("%sinfo/refs not valid: could not determine hash algorithm; "
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
 	while (i < heads->len) {
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 4c3b32785d..5f16cbc58d 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -54,8 +54,23 @@ test_expect_success 'list refs from outside any reposito=
ry' '
 	nongit git ls-remote "$HTTPD_URL/dumb/repo.git" >actual &&
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
 	       "$HTTPD_DOCUMENT_ROOT_PATH/auth/dumb/repo.git"
--=20
2.45.0


--V5RGFHjihPaGKd8C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s7UACgkQVbJhu7ck
PpT0eQ/8DZ1/f14Jbo4THFqveO5ettniIzRWyFc3QTeeTwmDYXRVN6+Nf3w4+UUo
S7IzSogq3oozHN9drFFkolDRCTZP5dFJZABfQc7lptKJkDdBbegFtlKhBVgab99Y
YtQ1IhxWMEkrTvc2vJs+LpajWLoiyTouqdc1B9emyO8aE4CdHDD/rRzHWardNbLR
ExJugOffpzEUi2i0GTR8ISHgPhSltrULjylAErSVAiIQ1PrOQNlnPmPHfP0R1hf9
+TqH2Q/56nmJOHR5cL1AzC2o2T4/our2wyeVIAnzSwymVJEPabEn5/dsT8nLiIW9
OyrnpPFExHwLOCse1lBTIEIo8eS2dYRHQA+ZlZJzS8V2T3jc+JqdOLVtfy9ZMEXZ
W0yO6U04ikCEEKBotZ48PP0G2RB/XIS2Ajz+ymhIvOskA7RUENafhi5NqN06oUS8
WK++aJmpB9BYLRXSBls8/pDOAI4wS6MXOrV/D4sSz7VKBYE/u21FvR2pk0/StNoY
37Tm2A7UtzIjUwD5pLhQXYqG+138pz61DYnqJeahnQNY775Nb0jdx9APx/FwUxs7
qyNfGC9Xy7wkOhtiW+1iyJP+auXOu+V2YW0Dd+f6rYS6ppAqqrsG8FHY89IebBN3
GXLOKBEoKrar2ZpRLQZOVQWX3ZeARhSx2FxKOezrXXMpdt72bHM=
=s9pB
-----END PGP SIGNATURE-----

--V5RGFHjihPaGKd8C--
