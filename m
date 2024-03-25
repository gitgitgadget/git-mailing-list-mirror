Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848EB2575B
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360969; cv=none; b=FhorjmUMW9djVqTHpMheCQl9lk0aAkZzlxbKwbg3h3tOPgDxxIZ0NtgjnDFvmGi4GqiZpAxQzGq0OEoXdfa/MJSt4XPz/u9xtCXbjFTB8MBnjt36jNnFyjqrt4kPaEz3GTzJNQXFYJaGyY09oalysr0EOZQBdLwCzdCpP6QZ9yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360969; c=relaxed/simple;
	bh=wJa8/EuvsqWwVY5PTcAoyHYWSiGUa11ae3aILn6cz1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETfYK8c9G6NaJA0/l+pV4F2u350Eq7XIcIhvqK7eTFtl+y8CmsvSraRCm+Xpi1P58h1BW3K/9Ctv/3s2/LRagIyNkLvaH+3gjvwBAmVrp2AiqP12Yf2pOItJy3PYfC2a5eND+42tBuONNCqZW6KKMYrV0cvccuQOg5ar7uhtv2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WvmN01eT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n+V0srz2; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WvmN01eT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n+V0srz2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 904961380088;
	Mon, 25 Mar 2024 06:02:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360965; x=1711447365; bh=2CYwPq2RDh
	d7vOyvaKjHP4wwleEdYhnfYVMO6Ohd9Tk=; b=WvmN01eTzxGSL3C9sdHRWNAhh+
	WPeJ0qqqovmKrwgu/mBay0xzVhIXe9C16CwivNjT1StVHFPNmlPLWjZ8bIjO1xbA
	mnpFkvzWle8W03HAi66G95aqVbdMd6KvIBjpF/L7D0mjuBewk1qwrJDngsU1FM20
	3oyrFs5x981XXzHC8OZxPtI9qypzPzbR1N0ax3wJ2qxk2nOVbYgT4z0zyzooxtpO
	X9AXvGf5fqhGIpIUmVKGBh/Sdq9y4GI8A1CK8O23O0Z05jayhRyf0k/rpAqU0cnD
	pKes9jXFI6WxyjXQGsWvlZla6zrwZ2XRDZXPdV912hNJ8idusYIbfMVyNbNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360965; x=1711447365; bh=2CYwPq2RDhd7vOyvaKjHP4wwleEd
	YhnfYVMO6Ohd9Tk=; b=n+V0srz2OAbcki7PTnqA4XYTRgm+rebS3NRuN/Qefkgr
	0sdionBSJ5oUupuKl+jfFs12kahMG3cG1Fo1utpnW5KD/rH4vN9Xfgs8VIcnhO4A
	LkydWG+XLdAUDzQUSUt/GEbrWZRVvvSvXCNaVrrSafiKqjuH0XzM+JgCjBKJa/ba
	yFUPdl8mc8Z0lxowBptQTYt4VkuwOlSMZu1QBo7j9uNKJzLsniQ4KBouNxEEoUUP
	TYtsC9Kc1pbfTiUiKiXUO+rNdi3C3B1g+KIvmYXEaDlyl96BXg115ljPZ9ec53NX
	gqIAnzG6JVCsbXeanvVMyefENPFxQ2712AY5nq+M3A==
X-ME-Sender: <xms:xUsBZoGa8x-vetRwX0bV4Rq4CMho_FivvQmXLOanI2h1svQ1jRKV6A>
    <xme:xUsBZhXLagz82qckQOg5DMwG9u2J-zTOAh1Ypsdwn1SqP7RPkG-BKnNbngq7PemUF
    SPorW-EpDCAsU-GAA>
X-ME-Received: <xmr:xUsBZiKuqaCH3l-iOyIi_haZmnPwBEIKhqtzucK2Q9EvPNESL7VGKHmTG5d6pLRPQyQYZjBZhrkUsdr6hyd7XlJZaKY2TKO8qHjgiL1Da5b7AA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xUsBZqEc7SI2xPrH_3Jn5J-pykUspEUjGKbQqDm70dBtHs38TXBr6g>
    <xmx:xUsBZuWaXSVdWvfU-Xyf1J6MlZgZW9TPGPLBm6lOWSHnw5s5Ef3tCQ>
    <xmx:xUsBZtNNB-RxICV_bGkGTgyFeDPw9yV7C85qi2s0lpWD7Xi7Hyp62w>
    <xmx:xUsBZl1GKdIBAtX2SL9c2a4mL3QSSwzx6ozF-xo59_UJC_Z_-CYKGg>
    <xmx:xUsBZsxjaP3NJlXdBquZdcxmgy0jIZaJJ9EyNdbjKXBGTZY7vvNIMQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:02:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 963c625c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:34 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:42 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 02/15] reftable/error: discern locked/outdated errors
Message-ID: <be7212006ba983be056834e29fc36f4d9a80413a.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DZ25eKQHsVAZQbJi"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--DZ25eKQHsVAZQbJi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We currently throw two different errors into a similar-but-different
error code:

  - Errors when trying to lock the reftable stack.

  - Errors when trying to write to the reftable stack which has been
    modified concurrently.

This results in unclear error handling and user-visible error messages.

Create a new `REFTABLE_OUTDATED_ERROR` so that those error conditions
can be clearly told apart from each other. Adjust users of the old
`REFTABLE_LOCK_ERROR` to use the new error code as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/error.c          | 4 +++-
 reftable/reftable-error.h | 5 ++++-
 reftable/stack.c          | 6 +++---
 reftable/stack_test.c     | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/reftable/error.c b/reftable/error.c
index 0d1766735e..cfb7a0fda4 100644
--- a/reftable/error.c
+++ b/reftable/error.c
@@ -22,7 +22,7 @@ const char *reftable_error_str(int err)
 	case REFTABLE_NOT_EXIST_ERROR:
 		return "file does not exist";
 	case REFTABLE_LOCK_ERROR:
-		return "data is outdated";
+		return "data is locked";
 	case REFTABLE_API_ERROR:
 		return "misuse of the reftable API";
 	case REFTABLE_ZLIB_ERROR:
@@ -35,6 +35,8 @@ const char *reftable_error_str(int err)
 		return "invalid refname";
 	case REFTABLE_ENTRY_TOO_BIG_ERROR:
 		return "entry too large";
+	case REFTABLE_OUTDATED_ERROR:
+		return "data concurrently modified";
 	case -1:
 		return "general error";
 	default:
diff --git a/reftable/reftable-error.h b/reftable/reftable-error.h
index 4c457aaaf8..e9b07c9f36 100644
--- a/reftable/reftable-error.h
+++ b/reftable/reftable-error.h
@@ -25,7 +25,7 @@ enum reftable_error {
 	 */
 	REFTABLE_NOT_EXIST_ERROR =3D -4,
=20
-	/* Trying to write out-of-date data. */
+	/* Trying to access locked data. */
 	REFTABLE_LOCK_ERROR =3D -5,
=20
 	/* Misuse of the API:
@@ -57,6 +57,9 @@ enum reftable_error {
 	/* Entry does not fit. This can happen when writing outsize reflog
 	   messages. */
 	REFTABLE_ENTRY_TOO_BIG_ERROR =3D -11,
+
+	/* Trying to write out-of-date data. */
+	REFTABLE_OUTDATED_ERROR =3D -12,
 };
=20
 /* convert the numeric error code to a string. The string should not be
diff --git a/reftable/stack.c b/reftable/stack.c
index 92d9a7facb..eaa8bb9c99 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -529,9 +529,9 @@ int reftable_stack_add(struct reftable_stack *st,
 {
 	int err =3D stack_try_add(st, write, arg);
 	if (err < 0) {
-		if (err =3D=3D REFTABLE_LOCK_ERROR) {
+		if (err =3D=3D REFTABLE_OUTDATED_ERROR) {
 			/* Ignore error return, we want to propagate
-			   REFTABLE_LOCK_ERROR.
+			   REFTABLE_OUTDATED_ERROR.
 			*/
 			reftable_stack_reload(st);
 		}
@@ -591,7 +591,7 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 	if (err < 0)
 		goto done;
 	if (err > 0) {
-		err =3D REFTABLE_LOCK_ERROR;
+		err =3D REFTABLE_OUTDATED_ERROR;
 		goto done;
 	}
=20
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 7336757cf5..2c3540d9e6 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -232,7 +232,7 @@ static void test_reftable_stack_uptodate(void)
 	EXPECT_ERR(err);
=20
 	err =3D reftable_stack_add(st2, &write_test_ref, &ref2);
-	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
+	EXPECT(err =3D=3D REFTABLE_OUTDATED_ERROR);
=20
 	err =3D reftable_stack_reload(st2);
 	EXPECT_ERR(err);
--=20
2.44.GIT


--DZ25eKQHsVAZQbJi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS8EACgkQVbJhu7ck
PpR/0RAApGfa60mZZvCoF74odspXqnjil8X7oKdD2saXKT3stym91V6FpkJfY7s5
6ubqwoHuGcMQO/R/YXksOpfMz9Lht5bl8PNzXdz9/wo/InLdtCsegSy6xfcXCj65
JlWITCLDjNYVJnajCxFhUimqlznsnCJRTNgOmeJFPKEJc0JBdLW+XAXG9kQCOxB+
KQDm8CbNvade9spGj/TDaz+uzIT94k8KJjW8GwS5UiSLInC7zCUI328quxvvfL9A
YT3fBj0FtOU9oJjDwfTEKTLgm2vjQgZt6zx7F0mdcPHmetv1AcqNMD4mGLiYEXJz
dyUMUN/X+oeow1uTkCg3DIwfFamHcFcMvuuW2B+vXcKTZAg9Sp/aurM8Gbnh/Q0o
WMMQ/7ggSjkPJC4ttZJ7+F/Zhw8vOwi9Znjvh4mBqSLYzoejS5pXZyE6kQuo1EcA
61oHGgJKt0sY9TeyaV0lo/5jEBnju84+mdz5bbFqR5YuW5zE9NSFt1BcSel28Gl2
8MsqL5MC+kaY6tM/Gbw6iZY7qCm/XGFaN686KdDXL92MTQYlLjp9QYiSNU3HyElY
pyc7upe+zFY3akU6lryuZnczkTI8H0PoruzPEYL/CMuJqdDXqzTvRn/7PzKlqoFG
tYe/UsEh5j9Q4liI7Mk21dJEeBDDq7Js8WcMq1MncMJAA5Ng7lo=
=9zoP
-----END PGP SIGNATURE-----

--DZ25eKQHsVAZQbJi--
