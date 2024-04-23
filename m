Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5C20DC3
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848878; cv=none; b=cnJwaMhmAWWak91UV52ATk22w4vJTo8qQEa7PnEIoqsh5ulZMJRq95aVdcRvdWUZchVi+6G7DfusujgbqHtOgHv47rhv5zylDkRX0m5+dJnqSIU6C5aGGYxgcibXgGlHWeDvhgWR3LROeJXU1wABkvnVb2/1HCAqN1W35UPKGoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848878; c=relaxed/simple;
	bh=qHOxt3x+if9WEx2n/yXN6t2ZDi/B1Q7v5jhBpeC4xII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwqC1uQJc+BoKoNKTK/cDOiinxWY5bjsGfNuzomGr6v8R4UZdSZwuofZLZ/5+SDlu4wLz5fO0L9xB5mPQYBQOmXbrE7Kr8t+xyVuUGDZwwcckuiWSP5pjTLOvoJXxVbalYkpLt6MlRmMDoblPuC3Oxv9tWTysf46l3tTJnHJpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ubHXAM7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G9SXxgtg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ubHXAM7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G9SXxgtg"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 12D65138024A;
	Tue, 23 Apr 2024 01:07:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 23 Apr 2024 01:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848876; x=1713935276; bh=tb4QRUprRU
	DD7/A8Fskd9jH9xMQwdTtV/kLK/FihCg4=; b=ubHXAM7kAUMLz0PvVHD5L1JM+q
	3YcxwieZKeIMECL+GNs+oAKSn6XDneWJPy9lBNOVfqKsMDRrUsYkHhqqCjFdkcQn
	Wepr5mnL7XsdJ35qGnh2vv4A8SSFytfUyrkp77tIWiYypOW087VqOHNUOeKBsBWf
	RMOmJ3+PXqFw0iGG0tfIT89CEPJ0KYuE78PM18ETloI3Z812YKGkTnyFau4dKhEO
	v0rHQBBuqcDHE1CP26ob+I0o/jxJPORO1vN5S0uFqVTgO80LZJSSvIn2rigL49AM
	isNqT1mNBX2X0HxLaNSRtCuN+E+GjcfjnETuELdhrxUHOao+hlbpNuiTSjww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848876; x=1713935276; bh=tb4QRUprRUDD7/A8Fskd9jH9xMQw
	dTtV/kLK/FihCg4=; b=G9SXxgtgZY/KkJIeXIK/+hKokKbdFDVbjYLMWYZWLw7K
	nRLgbyxjQonUv1g1u7uBwN86hNtBOrmMeNjMLzsA63RYJ6eTUqZ10CtqrT+54WuX
	ANiKNHEOlUCPgvl/YzETiMhcrDv/w3l8PBj514LY+4vokVamFK7hqXK5lfStwnZs
	x7vwmCDTlMMyupRlrt2W2WZ7MclRThtdlYyiYdkNdSb+l1eSTrGyOhb9A6IS6D0r
	T4LOCLNY3I6zjypW5/fMu6Qx0XaaoviPMZrhhCdawnk2ATA1HBUTC2nCeiIWYg4N
	O70kHi9UZMRwLErm4JEUL2P6w2WD+si5T2x6ehEXvQ==
X-ME-Sender: <xms:K0InZk-dUYQ9NqOytr9qMlzLrMGwjh6qwnD3dZXjve4VqmtvPyyI6g>
    <xme:K0InZssQ33jZW6z1O4BWBJGrfKeZZOSuKkJvf7wALzmdPAZUXpNb3HYO0RJNBhrIx
    vqTiMVc2px-4bV9fg>
X-ME-Received: <xmr:K0InZqDglFyub_czIu51RdUJeZaMtSCUA9koPiLyGe41xVQZCnJaTfOUZ-L4B8psn-chWdy3sYGDv757aSmORS5lcjIB7ZtQ8nwt0wMvJl5LEv4s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepjedvjedukedtvddvleejjeefudefgeettdegffdtleekgeehvdfffeeitedviedv
    necuffhomhgrihhnpehhthhtphdqfhgvthgthhdqughumhgsrdhshhdphhhtthhpthhrrg
    hnshhpohhrthdrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:K0InZkfQlkWwz2YBSUAU53DZyVLDJcORo_62gPrhf3s57WezFN5NPw>
    <xmx:K0InZpM8DvAbUfnbBEh9WNyUWZIj9_MjWkYiahUwjAx9k6NhOgfHIQ>
    <xmx:K0InZul45tJCbudG63vJtq9M7shSyMlA1DoHsuPCCsrmx_nXl5rwvg>
    <xmx:K0InZrtiLNQD8zajYxgDaoxP2vEYabmcsvCVZx_KsW4DGZoKIWD98g>
    <xmx:LEInZuptA6q0hD8V8jkMTfiiCxGWXiZoaxBUVn7R9BysQXBHDfRfmxJa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a09528bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:47 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 06/12] remote-curl: fix parsing of detached SHA256 heads
Message-ID: <0b99184f504bdab56b6d2d49f609b74a3e5c9c40.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eA02uS+nksstlzY7"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--eA02uS+nksstlzY7
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
2.45.0-rc0


--eA02uS+nksstlzY7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQicACgkQVbJhu7ck
PpSvwxAAj3BYcXvPbCnhXHaK/dEKlSIfuz4yb3BoabZupke58bX3GORGZ2UfolO0
meRFxplzbe6FCSFfCabofHvL/mFt0tFtQFva2J0/cerR7ArbthWx4Pq1TQUlcmcd
PdSVhe3mJXuiZa3VxVwf94QliJATd9F61bIFi1oSTkdlrLcm+vUbq1b9AtNZQUVF
jQgG6YyQ/vQle15qZrLjCdbqPTgsUYKOGpq/3eXsjhp2XY/EreY9b0ZM+LwUVwx3
C3SYxTHXLBGNRzffQGwyJU/qLD3XX0+uPWVZ2AA9ee5eMC6dBiTwjrAbEt0JVgsE
GOWvatk0wProNfEb2aVHr+WCDWxeZwOrFFoek+s/ujCwRxOXXuUcYWpZ/9f9eai0
T9nu4b6JTA85ChL9KVQk4cGRsuFmit/uaTfnt1h5hjBUZvd4VX1G5NaOXi58BoUR
eS9Lkyn1oZtavzI4psdCV3wNDu19n20xihI7iNQMP5eh0G3kCEO0TpXwXwMq9TYb
jvb+mNgHeu8Wr6sYQia3rkPsL4uA9sOlPyBIwCokzLnAV5Wrdol4pCsxkVU/cpX8
BzIPpp+cwkzyPI9rxd/QTi1db0hFoq8riXrfXCu0CG3vzJwfbRfVcB+e116IXy4w
Jyt5GGPHCxLdEh41jLbcZb8UDQWMSgLzhkjlGIvvrCKGEpIIUyg=
=lJKL
-----END PGP SIGNATURE-----

--eA02uS+nksstlzY7--
