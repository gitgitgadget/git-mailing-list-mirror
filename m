Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1951791FC
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107155; cv=none; b=BUd9ORw5wnlR2RSAhmMWesYztyzZADSioQ5ao7IHBW9x6tcDaO0yTG1iv8wR/bJjpCuq45cCgm0PqWa0PzsyGYOUzgqfKBBzdyOr7hiOfHFCjIvxAd0I93/86Ydx2dHhjlgtI3IAwVCSE65jPy4f3hmuGborA3PNCNyOOY2GaZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107155; c=relaxed/simple;
	bh=9QwrYhq0ao72UpCAL51+2uCWnA0HUmqQnGFPS8q9hs4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WliAZenQZEUGpjhl8gAnhN+iFWzd6qYFi40djkTWUJdJ8GbCf3QYgEpb8xeyLuk1pMwy5BYIpES/896boGjsTkcqagvZXc0hTH6E6/hpPH8E4JzLxWG7iKjw55muIKecmk15+M6kOPqgW60f25yAcxgjYokIRSrDISkFANQTlnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kqou2uGZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ln7GWL3p; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kqou2uGZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ln7GWL3p"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id BDAE818000BB
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 07:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107153; x=1718193553; bh=OhmhE8wptJ
	l6MpdatXeLKb7wBgtiYMxLaKapXzjerVc=; b=Kqou2uGZktIRFzQ2/j8W/aFmxi
	m5l9ziUNsOmsyYhbbmtRnulFtYoL1+bSNRWBG5HvAWbDdbrbKvAkcx3pmJ+kJhzC
	07IkEIjX45nVsZYsaga2cmxpSBZ/QWcZJaMSXEXbSHwC9JLGM1SoHrbGIeovAlDP
	JdBJueJO/oIbbI7XBQmuy0fbZdqfQt5kZ+10d3/fjotTSz/9LBc9nZnJsu6UDpvp
	AQ35Jq9qjx00PijwfkFeATkj7Au4ZoYO3sqBlNE/FnRrlirLh67jvJUhj7zqhAvV
	KO50HRGjtJlMnHtpu6BZu86ICIf7zAiiWJJmeAntfBN8F4uatqYPPvdPTamw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107153; x=1718193553; bh=OhmhE8wptJl6MpdatXeLKb7wBgti
	YMxLaKapXzjerVc=; b=ln7GWL3p1TScuWne0E1ZJcaETq59gTwncTfOIa3kdVGc
	gcNBr8WUPXRoVs3WSeEINdq8HE+npLXQGlBcXE5LzGrgJmI0fZGDO29jPzG8MSWR
	EgUr2V8z2bB94jw6HF4p7HIcMPiJxoz3vp9TOOIBFNYxlw0tuYEgwzqtpoBREmkP
	IhfMd4BX/smPd48Oqyifn3K2ixfLJj/08OKAqeAd6bg6l5uMP3jPwCIrhPVPN4EL
	lfPWsxMlcDCvqpsIg3BGuzq5yfZZ8iCezdng1ygR9YzJX5e31JIO4dtak78H1S5/
	jO8pzxMJQ9vMRlbppLUJ2iBH45oRYaJSt2AtGOy2Jg==
X-ME-Sender: <xms:ETxoZnq4st5aKrQJuWbpgiSi6CIzckh1eAPuYkam3_NPU5nJycCEtw>
    <xme:ETxoZhpERIieIZO0SNBjq4-c2thgAcXrIpURv7aq3W034ZDBPXbk4f59m25ZDZu7F
    -iRSU3nL5p3WueOqA>
X-ME-Received: <xmr:ETxoZkOzmKVzn0sVSUPOizvb77riq99-fOx5lkciy-cATuwWyIMtCXht8uAyHVedrzf8EMvWHq28weMFXinYSwv2DsjhQjW2x5dxDPa8cbddcL1uC4Te>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ETxoZq7xuVNoce41hg5jQheKXGVrw63nlkxOggeqODeB9CLLOuN5Ug>
    <xmx:ETxoZm7_-aEMUJhV-lDCzFHSWwbBIlIT0txpZ6J5DpSuQdhQa2Ks_w>
    <xmx:ETxoZigyPfGihxNm_6E2HzW9yUSg2QwFekcmqZDfxZHHu5QacFPKkQ>
    <xmx:ETxoZo7cmxHUI8WQlJmiCzvgXHgepMrvRjE6NFs6C0XJEVsFBKCXkA>
    <xmx:ETxoZsREkGO1PpYo_4ppRV__-zDS5qe7KIpcJa9v3-JV7oy-uYNV3Bij>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ae8b6b17 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:59:03 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:59:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/21] hex: guard declarations with
 `USE_THE_REPOSITORY_VARIABLE`
Message-ID: <92c7f542d244c76e3573244f7c3f969a30275c9a.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IQ/2ujAS2S4Tu8aA"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--IQ/2ujAS2S4Tu8aA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Guard declarations of functions that implicitly use `the_repository`
with `USE_THE_REPOSITORY_VARIABLE` such that callers don't accidentally
rely on that global variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 hex.h | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hex.h b/hex.h
index 9809667f33..e9ccb54065 100644
--- a/hex.h
+++ b/hex.h
@@ -13,10 +13,6 @@
  * input, so it is safe to pass this function an arbitrary
  * null-terminated string.
  */
-int get_hash_hex(const char *hex, unsigned char *hash);
-int get_oid_hex(const char *hex, struct object_id *oid);
-
-/* Like get_oid_hex, but for an arbitrary hash algorithm. */
 int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct=
 git_hash_algo *algop);
=20
 /*
@@ -35,7 +31,6 @@ int get_oid_hex_algop(const char *hex, struct object_id *=
oid, const struct git_h
 char *hash_to_hex_algop_r(char *buffer, const unsigned char *hash, const s=
truct git_hash_algo *);
 char *oid_to_hex_r(char *out, const struct object_id *oid);
 char *hash_to_hex_algop(const unsigned char *hash, const struct git_hash_a=
lgo *);	/* static buffer result! */
-char *hash_to_hex(const unsigned char *hash);						/* same static buffer */
 char *oid_to_hex(const struct object_id *oid);						/* same static buffer =
*/
=20
 /*
@@ -45,13 +40,9 @@ char *oid_to_hex(const struct object_id *oid);						/* s=
ame static buffer */
  * other invalid character.  end is only updated on success; otherwise, it=
 is
  * unmodified.
  */
-int parse_oid_hex(const char *hex, struct object_id *oid, const char **end=
);
-
-/* Like parse_oid_hex, but for an arbitrary hash algorithm. */
 int parse_oid_hex_algop(const char *hex, struct object_id *oid, const char=
 **end,
 			const struct git_hash_algo *algo);
=20
-
 /*
  * These functions work like get_oid_hex and parse_oid_hex, but they will =
parse
  * a hex value for any algorithm. The algorithm is detected based on the l=
ength
@@ -61,4 +52,19 @@ int parse_oid_hex_algop(const char *hex, struct object_i=
d *oid, const char **end
 int get_oid_hex_any(const char *hex, struct object_id *oid);
 int parse_oid_hex_any(const char *hex, struct object_id *oid, const char *=
*end);
=20
-#endif
+#ifdef USE_THE_REPOSITORY_VARIABLE
+
+/* Like get_oid_hex_algop, but for `the_hash_algo`. */
+int get_hash_hex(const char *hex, unsigned char *hash);
+int get_oid_hex(const char *hex, struct object_id *oid);
+
+/* Like parse_oid_hex_algop, but uses `the_hash_algo`. */
+int parse_oid_hex(const char *hex, struct object_id *oid, const char **end=
);
+
+/*
+ * Same as `hash_to_hex_algop()`, but uses `the_hash_algo`.
+ */
+char *hash_to_hex(const unsigned char *hash);
+
+#endif /* USE_THE_REPOSITORY_VARIABLE */
+#endif /* HEX_H */
--=20
2.45.2.436.gcd77e87115.dirty


--IQ/2ujAS2S4Tu8aA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoPA0ACgkQVbJhu7ck
PpRvEg/9HZS/4kD445Wf5sManY7Mc/2rUhzJ6TITfECQab1XRK/Jy8QqbYZqXmuM
xoV9YH8rDwjXjb+iIyI//06BtmGvbQKP0j7yk02uoNgPc+D7C8KJr3HgQSU+F8cC
l2i4yWgyU4KYMTPo9C9csLgL2eyQyQFYoWHsrytzSltbaN4X0+H3QTCSs+QG/WrD
kqFOfX4nShJT3Sk4iKvHcf8mYVNuWoMrim3wRQku9aMmXwodsDdPetlrjdekQqK9
6dRtjAktRYXKqthvt7vQlPaGZD7mzra336AqvwUJ3y2t5xIpiYovvjyHZ70DEfqg
j7aVyh7aU8VXuABcI7tcBqGk06Rm4h50IkzXc5Y0gMs8+Y5kgwSE/nKtl/1GhGDw
pGP9dvsET8uWFC822DJqPP+TM3zDayq+Ud6GoDpvTQKLGYdJrpT/ndfJFAs0myGt
YNYORT4BuVA8nEXuserygU51qjUc1mSpPH5HAvuwAy6zoIY5Z2/BX8utTy/6fS5y
95q9fzx4ETvxnX2NzbGw3FuWwQzEnQUH2PTRhAPc5NPvfzGWBj4fWhdgfJjFuw2r
u0fpquMLbilBiwBv/9y5fl4qRnYtxt+5kHABJQwKVTzoPz4dE1J7411XXoLNDLej
5dhh3nL86EQx5eGpIjqgjn3KcON40H3KXwApiVsThK4NHEDtg6Y=
=/t9Z
-----END PGP SIGNATURE-----

--IQ/2ujAS2S4Tu8aA--
