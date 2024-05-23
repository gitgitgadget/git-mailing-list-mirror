Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B9F13B5B1
	for <git@vger.kernel.org>; Thu, 23 May 2024 12:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716467156; cv=none; b=jqMa5rUONwQIFylRWqP9UCQeffzsDP63CdbNzI7/NXpT9VHwoOIhCJyvOFZf8ywngDaj+FeBGghBby6F8n5YoEorI1jyGZX6pRQiwJPFW2Ce1Z6jOXjhHaI+OryDqGa8q7sTrCuOcO2OdQ4PU6Eu8gjsOOZ8b6WaRl/QHOk4u0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716467156; c=relaxed/simple;
	bh=R9T5gJEmrjtg5EdNyWgtTC9hfo9aPEJZ+ED6wIPnUoM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWN+cBGJ1gx+QqZLoxPXjjPlD/hae+jumAmquReVvQCPyUnUb5rKTcwVkXq6CyrfZy1ocWiSfrGpXhKqPLynqYa2NqgnUpgMwCNs/89L9VSeSeuJokh8HYRotW8Fso/gG2LqoUZncXn5ROhYYkJWmesiOsP35VLIaAPf1P1azpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W+8NvqV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LpQyAxx3; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W+8NvqV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LpQyAxx3"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id E06881C000C4
	for <git@vger.kernel.org>; Thu, 23 May 2024 08:25:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 23 May 2024 08:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716467153; x=1716553553; bh=ZQ2tzDVwNJ
	aIwQWfjK/xrKYYKZc5u8CtKJeFOYLsY1I=; b=W+8NvqV2WXkAMTgf8FnGaOG+Is
	ToW9/RimDZq/dARZg5d5R94LUJ+mDHmS+LWiH7y7sdLqzPRbqrNAbQPc21zdLqJn
	dzu0qjGwsZI1vBQ5hLoM1jubfm5k/Ehi5+YPOM54YVu8RN/Jyc8E/OEErtcx6spa
	BZkvnwpUX8CkG/32LYXeFDu1HOVUJdeS2EtK61SZ9GY12TedZEX3kLWgvPjauD2z
	nBCu/kxaq3jQosYCrzDHpV9yxQCLnAUManeSaVsHSMdx9pfHxsIS3qNKJgZnnlVA
	9VbvqJsPIRqFBzZIF/J3igYsdAka5le1qcx70sgjZ7kWNcHLAOimml+6fg/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716467153; x=1716553553; bh=ZQ2tzDVwNJaIwQWfjK/xrKYYKZc5
	u8CtKJeFOYLsY1I=; b=LpQyAxx3bYbDG58TifPf38ETuW71iPySNtTA1nFLIJDB
	gN5GVWei+YEctpEgbJxgLug5aFf9ZUfT5wCUXLZYEv8eiesO6HI1Kb86Gf7+F9/N
	JvPbneFdP76SkFas/9TKcBqmyUEspRrMnzONwLyjKhq4glT5DYOD1/vIZdl5eOgg
	Y5TLjFAYvihRi6L42fwh6F4yBkt+2ZO2gNeQNVZw/zGW6u5FcsXMHpD3yuZCvV8R
	yCmXXIjGH7QHNhf5Y0De0A5qXbzwKye46a8k9soLgzEmDA9rN448BzIebXgOXkdY
	nilHotQJpeVVluB+KOV20MB19kxE0NCnftuC0S232Q==
X-ME-Sender: <xms:0TVPZhMSWZzXmka4Mv5Hl-sP8hvqwOIuawbVTcnt7w2pKCXHLrPovw>
    <xme:0TVPZj_gowOmljI5b2JxshBoKjHPCRS9TBXzo9aocorvBrb78N7S7Pu5KJNUh_ctj
    mOarZOg6Er6_G-XxA>
X-ME-Received: <xmr:0TVPZgRtsxsfuWAiwOcqsW0TECgcXeo4eqAeyUeXLZo2Nkm4u59TyDu4SUD5hRT1exmTnAod35SN_1u4eEERCR8uDFFF4QHimFp5RGN-zMPWvQ7ejw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeiiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:0TVPZttu6js9PcrQiLY7y1hnUvqeQwcu1hejiExtq2nfThGCxSD0kA>
    <xmx:0TVPZpe5kXo8qPemG-q-UmP4vWyaTtP5dWCRMmguGcEQi5XZqSK32w>
    <xmx:0TVPZp1L5Ka9rhCRajAU56_zjnAgUMEGglT0mdeqK7rpxy_tfbY7cg>
    <xmx:0TVPZl_RfHiZBOKIeTnbclpGGbuzyK1o3SH1E-tPJ0SOLVWIU_v-vA>
    <xmx:0TVPZpFaEHrypHiGn8e5QnB2PbElw3geVCA5ix2BgAyOhdZFKvqUQFrR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 23 May 2024 08:25:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b38d97e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 23 May 2024 12:25:46 +0000 (UTC)
Date: Thu, 23 May 2024 14:25:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/20] convert: refactor code to clarify ownership of
 check_roundtrip_encoding
Message-ID: <667eb3f8fff8053ddcbe3ff3f328223b70539fda.1716465556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="e7d6qT7HphlpUKnW"
Content-Disposition: inline
In-Reply-To: <cover.1716465556.git.ps@pks.im>


--e7d6qT7HphlpUKnW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `check_roundtrip_encoding` variable is tracked in a `const char *`
even though it may contain allocated strings at times. The result is
that those strings may be leaking because we never free them.

Refactor the code to always store allocated strings in this variable.
The default value is handled in `check_roundtrip()` now, which is the
only user of the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c      |  6 ++++--
 convert.c     | 24 +++++++++++++-----------
 convert.h     |  2 +-
 environment.c |  2 +-
 4 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/config.c b/config.c
index fb56e11276..f9101045ee 100644
--- a/config.c
+++ b/config.c
@@ -1564,8 +1564,10 @@ static int git_default_core_config(const char *var, =
const char *value,
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.checkroundtripencoding"))
-		return git_config_string(&check_roundtrip_encoding, var, value);
+	if (!strcmp(var, "core.checkroundtripencoding")) {
+		FREE_AND_NULL(check_roundtrip_encoding);
+		return git_config_string((const char **) &check_roundtrip_encoding, var,=
 value);
+	}
=20
 	if (!strcmp(var, "core.notesref")) {
 		if (!value)
diff --git a/convert.c b/convert.c
index 35b25eb3cb..03c3c528f9 100644
--- a/convert.c
+++ b/convert.c
@@ -345,30 +345,32 @@ static int check_roundtrip(const char *enc_name)
 	 * space separated encodings (eg. "UTF-16, ASCII, CP1125").
 	 * Search for the given encoding in that string.
 	 */
-	const char *found =3D strcasestr(check_roundtrip_encoding, enc_name);
+	const char *encoding =3D check_roundtrip_encoding ?
+		check_roundtrip_encoding : "SHIFT-JIS";
+	const char *found =3D strcasestr(encoding, enc_name);
 	const char *next;
 	int len;
 	if (!found)
 		return 0;
 	next =3D found + strlen(enc_name);
-	len =3D strlen(check_roundtrip_encoding);
+	len =3D strlen(encoding);
 	return (found && (
 			/*
-			 * check that the found encoding is at the
-			 * beginning of check_roundtrip_encoding or
-			 * that it is prefixed with a space or comma
+			 * Check that the found encoding is at the beginning of
+			 * encoding or that it is prefixed with a space or
+			 * comma.
 			 */
-			found =3D=3D check_roundtrip_encoding || (
+			found =3D=3D encoding || (
 				(isspace(found[-1]) || found[-1] =3D=3D ',')
 			)
 		) && (
 			/*
-			 * check that the found encoding is at the
-			 * end of check_roundtrip_encoding or
-			 * that it is suffixed with a space or comma
+			 * Check that the found encoding is at the end of
+			 * encoding or that it is suffixed with a space
+			 * or comma.
 			 */
-			next =3D=3D check_roundtrip_encoding + len || (
-				next < check_roundtrip_encoding + len &&
+			next =3D=3D encoding + len || (
+				next < encoding + len &&
 				(isspace(next[0]) || next[0] =3D=3D ',')
 			)
 		));
diff --git a/convert.h b/convert.h
index ab8b4fa68d..d925589444 100644
--- a/convert.h
+++ b/convert.h
@@ -92,7 +92,7 @@ void convert_attrs(struct index_state *istate,
 		   struct conv_attrs *ca, const char *path);
=20
 extern enum eol core_eol;
-extern const char *check_roundtrip_encoding;
+extern char *check_roundtrip_encoding;
 const char *get_cached_convert_stats_ascii(struct index_state *istate,
 					   const char *path);
 const char *get_wt_convert_stats_ascii(const char *path);
diff --git a/environment.c b/environment.c
index 279ea3fd5e..ab6956559e 100644
--- a/environment.c
+++ b/environment.c
@@ -64,7 +64,7 @@ char *excludes_file;
 enum auto_crlf auto_crlf =3D AUTO_CRLF_FALSE;
 enum eol core_eol =3D EOL_UNSET;
 int global_conv_flags_eol =3D CONV_EOL_RNDTRP_WARN;
-const char *check_roundtrip_encoding =3D "SHIFT-JIS";
+char *check_roundtrip_encoding;
 enum branch_track git_branch_track =3D BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase =3D AUTOREBASE_NEVER;
 enum push_default_type push_default =3D PUSH_DEFAULT_UNSPECIFIED;
--=20
2.45.1.216.g4365c6fcf9.dirty


--e7d6qT7HphlpUKnW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZPNc0ACgkQVbJhu7ck
PpSj+Q//ZmxV1y6KDOFGYIKGgKwof8HP6+AN7bbNPipHad+RUoePVEqS55sLlOVO
re51FpZxcQqPX1FiSPOag5kF6PCAeZRTyCiAK+JGkcSvjNhASGqHHYiAxDmtRjuT
yS9O0Lw8rpXvrTsxcFb4kUyANbn3d1yTKLOLZnUleVnknc1ADXFjJdrUDY6yTlz1
wT2dhm3Ra6BAo/9eIeuHTdMgH2n5Xz5QGrtVKW2RST2+ZDDxgkTdNWxftWQ2gseU
8j2hIieNo7J+aDw2kWe2plpFu4PCRPiKtvG3zt8p7jU3jgDdI80nxgoR5JA8JOIV
XdQKkBBOsNtmIvlRE/QG4Iu0mzmeLYQMRkOht0GpPEoMR7w3ut79LFeAvnVFYWS9
VoSVsdPdirkCHyQCQdSybYj6TASK1P6YdcHNH/hbzLBjhB4eJv+sDRpfHqjU5bF/
QgkgUxqPAW5HtYVzKcWYxGs3ifpoPCFkSG9E0gyQTHRbzQj9aa2VHBWqWpiwblAB
fgTgDj6B7rJiuxTOgzE/xR821/OgpWsoz9H0Dr42ldpSlvKSx5NvFBxr1Vep1m72
gRJEHhh6PskWdAFtsa8gKMAr/izB6t92A6ak2NXMPI8vk1nNIpBmzpEWjUIFvj0X
Rq7wmt4WOV+aA7/U1RZhcty9I8UVlBl1yK1voIlwEw70U23eL48=
=NJZZ
-----END PGP SIGNATURE-----

--e7d6qT7HphlpUKnW--
