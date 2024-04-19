Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965077F499
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520296; cv=none; b=qfc1W33TXsOClWMBRIHt4uS5aJGqmAXBBQkIKPIjd29hUPCrSpFu5Xi9WzHMjKF+RIuTlG6EMO6+EJmz+stebczVrb5tHR1hwQKshR2MhHFRS8jOx/ZA1bMoVSPXCP0Jpe69pEwCokMCoYPTGeDPiAMzMW+ts8CI/Q/q0kc1O3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520296; c=relaxed/simple;
	bh=MJjmsqplFL8VDYSUFuiJ8M4wKfIXj7jSTU+yaF+FGLQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=miuY/beVkAE7MB2240ji17gftIqh3MljgKWRx2zvVljl5A+CZ01/0AjZin1uxB7ffKuPrmFVgNC6I6j4rFcasB/FsJ73xY6jSuXSKc/L586K2R40SvwstUm6ASJ1ajNSR2IELtfg9iAIK8CWSLM6bdEmZ0P4LpWfjNdUGi/ouvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kWsh64Wl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XDPYbCif; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kWsh64Wl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XDPYbCif"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id B14211800096
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 19 Apr 2024 05:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520293; x=1713606693; bh=uxJtBXlUKy
	MrsIw/cigzKcFa2mOXYyqTNB0W9iCI1uM=; b=kWsh64Wl06mhYeuPlt/+bgeUuE
	HXGOhssleL60YxBbi8F2mqANzQRNXumwbY2lON8YZsvFcJB5oPKG/H+gP2Kw6lQw
	TujW6SrLfs3IrKpBk/zqG3GvP63RSDGT4lQGGmlqm2PAr6/W8fr1jZ46GFQah2v0
	/iXomXfA1kHgLrdxiHdXGx1r/qkByho8QUpzF+8agnVZbtRsA/SgpmMpYnHRgfgp
	tMel6Dwo0m7ENXTfMCfScM7gOdupqnr9w30gAQfs4Vmr0HZIOqXt0zEmebfxwIRW
	UfW0vcYiqQZ/LuCLB1QbmgJlT7a8b58VyhPya8rK1yOuRBQfcsed5eZ3rpCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520293; x=1713606693; bh=uxJtBXlUKyMrsIw/cigzKcFa2mOX
	YyqTNB0W9iCI1uM=; b=XDPYbCif6e1f5bPWYIFFoKpcpFzw8Z0bl0CqLWmWn77G
	e7T/CF8B57Fw47hM/eHstWKoYyQK4AhoxLO4VVrNsERc6BCjmtN2NHzV4ccRjHjx
	9A7ee2lGFrR/zK9jRva9Ijh5YWd5Qu8KU77/diBvMcveYKDCJtHamKVU7WqpzCQl
	jH5Al3A6ff9Lm/YdgCO5B6/QHPkg11WdEKu33iJGO9PI4aj/yjpWzORCM81iPaUd
	phDXeCtQS44rLD/sEYssj3OIaJRmgf7SQPYLFtQ7b1JWA1EOiu+4uQ4OStPe47wD
	I2DWVeeXf76fv+KYMFB204VFzcp9yprTnurHO9QKsw==
X-ME-Sender: <xms:pT4iZuUmDvSZ37eSGs5ik6Fk9jSXLoZkqywzFp63IPMGRlFoLREXjg>
    <xme:pT4iZqlpClqEaglJu6uUv9WhXms1TUzc0_hN51sO8xx25aizWqkZQGXImQwWdMSOk
    gbbYcJDtdRtEkNQmA>
X-ME-Received: <xmr:pT4iZiYriZ75kVBXpLM93LbUPTP-uKwSZAV5DlJ9-OHS399D5pS0b2gIEqHzdCDPemF2mv0rDDcrf2fXScNM3UTUFG8AHGM7V-r-1eFzsA2B7WI5-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepvdelgeekfeefjeelfeethefhheetvdejhf
    ejkeduieffjeeklefgteekieeffeejnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdq
    ughumhgsrdhshhdphhhtthhpthhrrghnshhpohhrthdrrghsnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pT4iZlXvFr297n-GNkXJs1j8zWYDXIwPB8TgfQzeD3nkzJavmjSlYw>
    <xmx:pT4iZokJarKgpelCRaya86EW1t2f-K2BGaZUgOLTc97GnZKFTorYSA>
    <xmx:pT4iZqfB6VSZ57MRaNMPJm1V2vhd0MlgpnQUWQpmUdDWwPcGox91ug>
    <xmx:pT4iZqEPFfZvmVx7ltZ8yOB2XxU3tJrWb3n45V56y0J6-x8p1KA4EA>
    <xmx:pT4iZkuwOhw1uF9fenYHI9cvd-CM52PcFMKvOoI0t1_6tAanFkg7SYhJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e731274e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:05 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/11] remote-curl: fix parsing of detached SHA256 heads
Message-ID: <32a429fb60e4a7e80afdbcf9f874d2b2d921badd.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="L7b/ikGEhpj5bsvG"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--L7b/ikGEhpj5bsvG
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
2.44.GIT


--L7b/ikGEhpj5bsvG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPqAACgkQVbJhu7ck
PpSLwQ//dVsVhrTMiqYGvI+1LIMV1c/Yx28QJMDHC9dc5k0PzBc6MWnhaNo/kgVr
p7JbOI+NS3rAPgf2tWQAQBnkTmWp7cRD8wIGeXV7fePw3gDT2hkPDRabADhGFbq3
QdJh398nQiTrAejXpwfzSXrE+bEHXLDOd40tpBMmzeJIvAV8oGyN6MHKmTSEQX0i
f4hb/wN7Kth5WE7vP4fbEqd84kVYgjfON49Qu6m/QLaX5oGN8+ZnAhpqvov90qgU
x1yJ7cFiK8OYvA/WfnoRkSij3cHY8BQcoc50Wqihzs3IypGWMboVA1RSzMO98y2I
B6iBC7cAgrlYDVNeP8HltMQb9DZ1k9SXaLFKmab0Z/cLo0w3ptQMnaxymecMM84L
9eTkUmqsgZuvigaieSaDVz8iOnLwjwm2YZHqNeuuzrhuh6sLxJN9ajj24SK1iBRr
p/v5KHDnKQ/8GgygGF6d7pGjC0zCtktTiiq3Ph/BaTagg/vO/LxYDCbJajNnAFV8
E4VvgvPdRnb7eKpm3VWQgTmJ6u89uoketmEzbFgL606K93r+G6ylZsDkr4Y6kKqq
qssMuNLnvUQRcBe+x8e+L2+yg83zJTsk1zh6hWYq1qUhMmmGoic3aw64OAgElU4K
V8uxu3z2hcYHhuxudND2tV9L9gImoK8PYxTpKREI0lNq69dowM0=
=8UUt
-----END PGP SIGNATURE-----

--L7b/ikGEhpj5bsvG--
