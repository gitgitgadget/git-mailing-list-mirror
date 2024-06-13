Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0AF139CE2
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259305; cv=none; b=coNM6QHYVCPA908fgRO78u1Wg7tJ+UVGKcuj7GILLIcfq8bVUcwRcvgmCjnaW5zfHh1WNn7G4PBzIW5yCFf+lNVe+pnfnQ3g7lmvc78ToPhRuBPqObjzhNPm6VD+PAjaSV9TBFN5xyX1OC3IMM8lquEHB7oaLIQHa78M+pwNLXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259305; c=relaxed/simple;
	bh=xz/jA/h5RqIbXweQBLvIXjUJT8wsr12q87zIJCnmpYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGkUFLxI4bGpNzEdk/q0cP5ojAb4RU5y3BsfuSaRdplicifSPu4UQoGHSUyPzpwLovXVJdns9Jn3vz0Wp0VxephdTcoaNHJbvuxwXD4GaneMRkbzHTdKYBINAfEjeEUdjcGgz8OtvdFfK3OYSxCb9SpsjgAFQaVjfJTL55StU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QZ1ZnwNE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FtmTyUaX; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QZ1ZnwNE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FtmTyUaX"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 52ABC18000AC;
	Thu, 13 Jun 2024 02:15:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Jun 2024 02:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259302; x=1718345702; bh=Cw5sEhsxn8
	YfrEeIbvbkiZdKDEpx04PcjSvMdddK6H4=; b=QZ1ZnwNEKwukgAyabiQnKI2ClD
	cze+zcHzMv/wx330urOBMHJTj96j6YTSF9Lq5PJLoKgK6gVsfWn3swDZF9Yw/pou
	8qmyF6WJKoegppiduFkIsGnqWuvTQA7PiXYy7lLJbiP7jR5aWGZbKipBbrShTjhR
	5gPEOo6wziGmjiDQfsXTuD0QW1a7q8WR07SRzLQGnAmBGV4vLkhMTNZMlsQHkYci
	qUyAH7jD4gYBICsZ4AbtY7/AcAnmed21hyAPmObxC17UDnSdyi6jpZNC7mlAWk/C
	8YnUVOA670i03bgvwoN18WFHyHa/jjmwYwRvmfpQUGgIN/wKYHH1sz89Ctjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259302; x=1718345702; bh=Cw5sEhsxn8YfrEeIbvbkiZdKDEpx
	04PcjSvMdddK6H4=; b=FtmTyUaXtx31jqgT58HCBnyhc+ljOUFkY6uXkfIvMEs8
	S8KPWq+oyQbIEgJyR7V8dn5GZCOMsi+t3mgyEQscFw1ro0hgIwt9STccP/I4kG7/
	XrbX30e81FktnIqMXUd5+Sg6Vaza0oRuIbwPJHDMpfCFI4Pz9qxST+gXUSkD3ATa
	AT4H4XjcYvjT4EoD3DuqWjk6WHlIyV1x0VSmnMOtYTaRajZO5xrMLSfqkT6Yt1qr
	rUdwRHsLbHghcn/awy6YlReWu1wFO5BFh+CH4o3RBqSoMnFNcyrusEkWx2CZzZ6A
	zGr28qbG3XfRgLMSdTyRh3Bk/CjZomvWGsPU9o5G9g==
X-ME-Sender: <xms:Zo5qZpKf5Ee4ovz0Gs18ACIAPJn6-TRbDwR5-UN9xUxNXNwHMD69ew>
    <xme:Zo5qZlI5QwKSQOJL8Qi0n3iUSKdzRmrdlt7eDMmZlM0Y3Ll09LW0PlSMmM-muU1jH
    1bCu3g6ufMMiGpHSQ>
X-ME-Received: <xmr:Zo5qZhtsF0foHwFsiobkjiI3iJt3yBGsXgYFX8DuhSxApncMfD_LDCqb4Po_Kmo9L2ndC_GnsWAbsUCg9i9RQr85t1T6W84ID_V4VTnVysOS36hBQZs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Zo5qZqa14KeLPh00W-YJy9TmuEWOTEMIsLWFniR5QiRIsd6lHYWxlA>
    <xmx:Zo5qZgZALANq9MsyyccVbAwjLkbDoz-50QFcrd_DGDXVDTjtLq5piw>
    <xmx:Zo5qZuBCy9XFRNAjJRPSYHTXzQxjg8utvoKQhhTVrixQvaUYnx8EGw>
    <xmx:Zo5qZuZKvv7TWs_WXIGqrooRMPY-4Z1nxjkg_4XcZWcE_E5-FYHWVw>
    <xmx:Zo5qZoEkxX3EUPwkrHo-roKG6BiQWdxfS-PEIFrzpYkxd98z5mz-x2Hs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:15:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8ba16cc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:48 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 20/20] hex: guard declarations with
 `USE_THE_REPOSITORY_VARIABLE`
Message-ID: <16fb86c2b296d6d3803fbdb25ac69b2acaf5a4aa.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="z6zBSoMVmiJBfq5Y"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--z6zBSoMVmiJBfq5Y
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
2.45.2.457.g8d94cfb545.dirty


--z6zBSoMVmiJBfq5Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjmIACgkQVbJhu7ck
PpRiKg//TKfpYIEEvkt0zoMCZ+9TNE9rAVVdlWGmx109yYG45QtE/3lzCxRSMu1h
6LV8uiC2CmEFEScAMoX81/kNQo26TxwTvSkVXqWrePEmK6tzNb6QD+9XeNhjhyLM
p8H4GWN1DL7xyogWOQBzdNXolrDiWRZoKULk4JceJUKny3YgENiQlaFCyXFp93eK
6Bb9LRU3xaWxNUlyNTD65MbUkasHbMDJIINgVTh1TCWpOY+TeErgQjAX2THEBN02
fVIBnmu9U0xNl31LSjwmo0DEtUQPEQsNRpmH8OqHinEUK3xvHJUuRQRZ78SEnY5D
OXa4mcxACCU/9dwNHFJ5ldCsxpmIQcFN+Yx63pilq+XoyB8SViDTwI93RHoeZc1o
uJGIF7g5LPSdMaMou72Ey9HYeQ2jyGm7NdeGxIl7zObQKVNmCKh5NpVJUF7a7STq
LBRtqMqCHZWLtVo2rC0evffWlSauHZGNLxMx2Zsnz7Mpm6KAu82qAX+CDqe/b7ka
Jtz0bqiGiFXJlAB5SeQiOEYLi2RXNvgayb4Rx7YT5USHx/L4LeIQX0rufOBs3JQM
OFpvdQFVPkFEHRpZTiBMZz6dntHBYp/dZ8aXigijfiD2jgKSBabVZXa1l8Skvglv
235hjD4OQdWfnnuSg9SHe8a2Cp4jQveUNczNyckOjXl7yQQ8OC4=
=UaiH
-----END PGP SIGNATURE-----

--z6zBSoMVmiJBfq5Y--
