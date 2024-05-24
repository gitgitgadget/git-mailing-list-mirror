Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAE883CCC
	for <git@vger.kernel.org>; Fri, 24 May 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545038; cv=none; b=di7TLBuUwOSHc7Go3OoWgR9qf0x0rhHSuOSqj1iiL5K1kTJs45L3D1tgGnJGrD1mY2RltIZG8SqEo7AgkUWkGKNc1udh7/2U2RsWjyIcBCHaSem2EOC4+OefbESGQUTIQVyXb7cnCr3ZztHFKIQznICyTv5ygU2vSG237dHyMok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545038; c=relaxed/simple;
	bh=iECjYeWr1tYxW7w856QIssL3n0xN6CmantgMbqzNYnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OcIaCEsL/h2BVlMVMRgxwtK0fWOesUHP5LGS0oDCkgpTJuEnLNdxSOrvPfTlkYjePL1HpUMIiPL3rqaKy/cIUpD3Z97U+RXrdFVQRuYhc7GCYh/neb0wTbFxVkDP2nToRCmRUjRMCMyfZoDUSA/aDyeFgBAssdD7PfPIzGlt6eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hwT8AskO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XY95E75W; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hwT8AskO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XY95E75W"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7913213800AB;
	Fri, 24 May 2024 06:03:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 May 2024 06:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716545036; x=1716631436; bh=HvnCLsAzCw
	mvOLb7HHL2Q2AykTB9dwA471IboOfvAlg=; b=hwT8AskOlxBXwLjkcegAExxsEO
	mHpG8OBaMtZhwVkNy3rIZyrLXK1lLKgCggj7BP1Wr8hbI/dmq45To4wrt/XA56jA
	wTKx63GKNv5T5O9kRf/oreuUyZoCT4uO8jTYn2sS90A2VOCqiEpY6LnDC2wj+YkZ
	sUEn+IiXX3WhMXX4XvI0rKzqKs2EFSIpBC14eAY+wkq4cG1Wh3DUvGNA836iErjc
	ccopf0lKeydfHzlNu2Udas/5QmA4xTtwQpWO517cNkvQ864/0oDkiVqtEYQavpHo
	lyv64PZVKO6T23ssTaiF0c/U9ILfLtMDegV3Ur+Wr2aQzif1TDmB9S7N1OQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716545036; x=1716631436; bh=HvnCLsAzCwmvOLb7HHL2Q2AykTB9
	dwA471IboOfvAlg=; b=XY95E75W7Z7rad/zdMpOirDhkB3q+P2EGzjsE14crisw
	64OsIcyAZg7QFPIHM0AYNmSclp4r4hVP+M/m5oYrh3/rLuN0iTFsBT9BqeRr884n
	ipaKQ28LIjBEXrUM3N01jlPGxKDW0N4cVkqPcF9Ov/EbBjmTmY3GQMDMUn3IXMgV
	b5XTvheDrdHWnpTv3sLkHuHjXYY73i6VuzL3YE/OYVKgk4Znrhkam4Uiw+EDtngb
	UOLPm1/zVX4PP8D9VlEeKBGizlpq6rakw2UdW4iI8D5E2D6thjSGxXr+CMmu4hhd
	AJczKHbl6n5mpwgsr6K5ELOW/6x+O16tKOD/MuaE+Q==
X-ME-Sender: <xms:DGZQZiIsTzefy1p_M7U2rHMoWW6bnMD1F4wr7PNsWlqxxzdusLlclQ>
    <xme:DGZQZqJyqiESNnbikdQTcszSsY7qERhoX0sz5z3tCy9s1ArKntk8IfcGFJA8rzii_
    1ejNnsB05xxNYYfBA>
X-ME-Received: <xmr:DGZQZiuzSJnPiPU2_W3LQ6OnMzdtYcOZf8EBIkQ9QZ8YMd14VyxSWY1op0xJbBtUEZrM0N2z3mbdXOMmpIEBpX3sor8c4Bx56kFrP4q2aDIHeoI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DGZQZnZXdE-O_LNJ_eksuFbabKXe0050_UqQqLyJYf5xpoFtBZp1rg>
    <xmx:DGZQZpYFKYw4ngImkX0QtBGwWByUrg_xlb68l4tjxn6lSPJK5dTPnA>
    <xmx:DGZQZjDBqkPz7cLxwZT8SsFQPyoUy91fYEFMBfMI8SFTX1RsLgVrdg>
    <xmx:DGZQZvbyImQZ_0wpzmQClqXUJInG5xS4V3YWzjojMMaU6rcpdopM-w>
    <xmx:DGZQZtEcmGi9qOQ2Q2IkmdQmedt--B8hRosglPgNBQEjTN4Gk9VSk7sZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 06:03:55 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9475615c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 10:03:52 +0000 (UTC)
Date: Fri, 24 May 2024 12:03:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 09/21] convert: refactor code to clarify ownership of
 check_roundtrip_encoding
Message-ID: <eb7fce55b0d2035ab93c466d24de6ad742af72a8.1716541556.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716541556.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t1nY9/64MxjNMIuR"
Content-Disposition: inline
In-Reply-To: <cover.1716541556.git.ps@pks.im>


--t1nY9/64MxjNMIuR
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


--t1nY9/64MxjNMIuR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQZggACgkQVbJhu7ck
PpTasQ/+KLg2WkYf+xgJ5O0M5CL0gwHOCl9Ri5hDDWOavCG+qEGhuvkXx/8g0oTX
XF9LrCt3XwjnlPXzUHSfMtcIAxUthQ1vEeFxueovevyMzoBlmDdg99GBTykALNox
HoapfFClyR+ZoemFIpE7q3fcqpWB6Ua9KZd9kgmsipJeBtvxj4UUKoDXLZTJqnH7
c64H+274y4ph7V/wIXigUEYkaGqTB+nsXx7WnQvtqrONvla6+toL8snaBKqwa0w5
RDRYRrU236RUAPkKaw0oVcmCk3CwpFK4miYbyI+EWh+XRGydODyM2mjIMBSX14lO
suWMmw1D/BiYZWgROUgqTAJUQs9kg6TQJlwOzeFylQR2KKcZVC7MKEpICy3J8uiP
Sc7jx27fmuak/AGRHg3mmGB7M9xk5ToBErZFKqNoOTBGWbG8TjFTzlEqeBZFOYSr
A8QL30PKUWkpb6ALuemb5O0leh/GhtKYeU1N8+Z57xSTMfPfICsBw/MQiPcSIjqU
3VwRzIb2UIo1FOW2vJmerX8tnpA3vskxGkVcy9wKWl0K0s4HGk0G3z7fk2RZoTKT
oBb1zTu91AfBBGbjRzY0Fy9w1NPZIuUfr1kGz5DadpRGBmd+gNvLwx8/6HImgvPA
j8OJ6VmiK4JnaTveM0nqY1R3OTyvuHlSOK7trRsq58ltPLdj8lE=
=V2dE
-----END PGP SIGNATURE-----

--t1nY9/64MxjNMIuR--
