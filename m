Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA129CE1
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742330; cv=none; b=baUybSmSuZF4/e0PbtDiTv6sZTLuEyVhEVfM7s9rKMlFF6Ugw70j3Tf3SwdxEdCCzVoJzHgUUBsIgqUx45bPEas0sWjr/wNymnNAI5txcVxWzrTIEayL4MOykld4AB5B435eaYUbW5wCiBiN/rstYt+b68CmrgjeSE5UU0gLwUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742330; c=relaxed/simple;
	bh=j0XtrRuhFxHRveJMTQQilXmZtXEuJ4bimw72nifCZlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pO0KlT5zCMjdgiK+CioLR4sVZkw2PMRSNEbpNT4K6CO+QvRUZMgkABHDSTybEgzz616eHj/lqmPJWQELHJNMSZ2AVle3MO2biN/wTU6NkXK7OuYY9msMcEYrbHmJVZX+/KAs4X8ztwIocqURIaJSjSaYM5pGoSJGS+7U/rmQV7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h2qnEPWp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O43Jmew7; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h2qnEPWp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O43Jmew7"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id C716E13801DF;
	Fri,  7 Jun 2024 02:38:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 07 Jun 2024 02:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742327; x=1717828727; bh=VNd8ZOEIUM
	tMYU7iCOTOFJR1Rs3FvY6NHu01C5RKQMU=; b=h2qnEPWpxJBfgnQQDMlJrApy22
	IW0h+S1AcT6QzTHoFs2JwrbFICMXtY7/hZEm3Ws7OQ1FBY6oJPk3NQSHRmrBQc3H
	yx9g978C7vVS4YhXJ8PyXrqGfL5dh4avx9cBNsxEDqpZPPVJzxaup9AeC/c8tTXV
	nXlARv/hqpRh9funU+2axD8f0MXoUweaiY2eHVgqeJdWtx4bBObXwPW5IX6OY1tY
	FekkvQWPy0VtQjMFB7NiTQe1r2HWLFu0YN8fx5a8kKDCsqsi3CvIIX1L4latFt4H
	ap6u+o74NuGMlExrSnc/hABDjCjRQGJ6VsfrHcRDHjM4m4ocXvs82kyRTe6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742327; x=1717828727; bh=VNd8ZOEIUMtMYU7iCOTOFJR1Rs3F
	vY6NHu01C5RKQMU=; b=O43Jmew7LFq7VavtgAXla/WwJshP5fcoBbWnI/s9PZZ+
	YNjmgzF62XWw5lwDFwM87jvH7yAdyieFS7KbPcrADRSw5W/w1YlA0/wm9PaQ2YgX
	49texIDH+i1xQWiJO89gSAvqmdah2vDeUNIMVSLfbHGZGj6OJtSckd853dz5/XEM
	zCFQiAPJgrTvgcufBJLPU14kcCMjn1h//Wy5RIjRtgTWLlsAzaYjuaF3OpaXWrzT
	Sl0Hp3O8LtVqb448ovzRTpfOiW5qP4b7nAcrSNUWw2dcSqgIEGlf8rdWoT4dn1Ca
	RDg+b4RWFTiCHdnLh/fVWbFAvypIgz7xbIKBF/LeaA==
X-ME-Sender: <xms:96piZsZjNiwQJANWtBqjAF75kel0DUsoL5ALzVLmu6Gt9xbN7Djj2g>
    <xme:96piZnZ7Sqe13Bqg0UQTK9Jtm3DS9EUmd6lcdgZKyuEnsUtWeqjjGry7eZH6dd4fh
    7SofKn1RfjFwW7bzw>
X-ME-Received: <xmr:96piZm_tykE-YmbgKxu0ATMQQfLl_xabcsh4YXkmWhLIA69_eKB0HQwYrW5loaAyGb1a8Iy7c1CVppoSGcCWi2QzNPoibotwf5BwJKL2ggFqAjSD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:96piZmo-8L2Sc5rkK0SVJQlvSzYxhzI963u-Jp76893rawCuVV_9hQ>
    <xmx:96piZnqTWWn7giAeH_YfsBC0b5Ebt3gPWFoftXW6-mKZ13Hnd3ML6A>
    <xmx:96piZkQDApd1cjRW92ow6Zib_L1DXYTO9rPYaq_MvpedmJBy1almVw>
    <xmx:96piZnoNGIjHgB2Y59ZhiGmcfCIuvAJrfUpOq2kjaMtAKf18607PBw>
    <xmx:96piZokRDIkEDc0Xo88kCN8rqoMHgngOsEcI0Z9yxofIT74m8hBx4XHJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:46 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e8035734 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:46 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 15/27] compat/win32: fix const-correctness with string
 constants
Message-ID: <57402de20a36d1063c4abf0e0af3e3c3c647d868.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3RCcPgCPFvOxo1c+"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--3RCcPgCPFvOxo1c+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adjust various places in our Win32 compatibility layer where we are not
assigning string constants to `const char *` variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/basename.c | 16 ++++++++++++++--
 compat/mingw.c    | 28 ++++++++++++++++------------
 compat/winansi.c  |  2 +-
 3 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index 96bd9533b4..c33579ef61 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -10,7 +10,13 @@ char *gitbasename (char *path)
 		skip_dos_drive_prefix(&path);
=20
 	if (!path || !*path)
-		return ".";
+		/*
+		 * basename(3P) is mis-specified because it returns a
+		 * non-constant pointer even though it is specified to return a
+		 * pointer to internal memory at times. The cast is a result of
+		 * that.
+		 */
+		return (char *) ".";
=20
 	for (base =3D path; *path; path++) {
 		if (!is_dir_sep(*path))
@@ -34,7 +40,13 @@ char *gitdirname(char *path)
 	int dos_drive_prefix;
=20
 	if (!p)
-		return ".";
+		/*
+		 * dirname(3P) is mis-specified because it returns a
+		 * non-constant pointer even though it is specified to return a
+		 * pointer to internal memory at times. The cast is a result of
+		 * that.
+		 */
+		return (char *) ".";
=20
 	if ((dos_drive_prefix =3D skip_dos_drive_prefix(&p)) && !*p)
 		goto dot;
diff --git a/compat/mingw.c b/compat/mingw.c
index 6b06ea540f..d378cd04cb 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -2279,7 +2279,11 @@ struct passwd *getpwuid(int uid)
 	p->pw_name =3D user_name;
 	p->pw_gecos =3D get_extended_user_info(NameDisplay);
 	if (!p->pw_gecos)
-		p->pw_gecos =3D "unknown";
+		/*
+		 * Data returned by getpwuid(3P) is treated as internal and
+		 * must never be written to or freed.
+		 */
+		p->pw_gecos =3D (char *) "unknown";
 	p->pw_dir =3D NULL;
=20
 	initialized =3D 1;
@@ -2800,16 +2804,16 @@ int is_path_owned_by_current_sid(const char *path, =
struct strbuf *report)
 			strbuf_addf(report, "'%s' is on a file system that does "
 				    "not record ownership\n", path);
 		} else if (report) {
-			LPSTR str1, str2, str3, str4, to_free1 =3D NULL,
-			    to_free3 =3D NULL, to_local_free2 =3D NULL,
-			    to_local_free4 =3D NULL;
+			PCSTR str1, str2, str3, str4;
+			LPSTR to_free1 =3D NULL, to_free3 =3D NULL,
+			    to_local_free2 =3D NULL, to_local_free4 =3D NULL;
=20
-			if (user_sid_to_user_name(sid, &str1))
-				to_free1 =3D str1;
+			if (user_sid_to_user_name(sid, &to_free1))
+				str1 =3D to_free1;
 			else
 				str1 =3D "(inconvertible)";
-			if (ConvertSidToStringSidA(sid, &str2))
-				to_local_free2 =3D str2;
+			if (ConvertSidToStringSidA(sid, &to_local_free2))
+				str2 =3D to_local_free2;
 			else
 				str2 =3D "(inconvertible)";
=20
@@ -2822,13 +2826,13 @@ int is_path_owned_by_current_sid(const char *path, =
struct strbuf *report)
 				str4 =3D "(invalid)";
 			} else {
 				if (user_sid_to_user_name(current_user_sid,
-							  &str3))
-					to_free3 =3D str3;
+							  &to_free3))
+					str3 =3D to_free3;
 				else
 					str3 =3D "(inconvertible)";
 				if (ConvertSidToStringSidA(current_user_sid,
-							   &str4))
-					to_local_free4 =3D str4;
+							   &to_local_free4))
+					str4 =3D to_local_free4;
 				else
 					str4 =3D "(inconvertible)";
 			}
diff --git a/compat/winansi.c b/compat/winansi.c
index f83610f684..575813bde8 100644
--- a/compat/winansi.c
+++ b/compat/winansi.c
@@ -139,7 +139,7 @@ static void write_console(unsigned char *str, size_t le=
n)
 	/* convert utf-8 to utf-16 */
 	int wlen =3D xutftowcsn(wbuf, (char*) str, ARRAY_SIZE(wbuf), len);
 	if (wlen < 0) {
-		wchar_t *err =3D L"[invalid]";
+		const wchar_t *err =3D L"[invalid]";
 		WriteConsoleW(console, err, wcslen(err), &dummy, NULL);
 		return;
 	}
--=20
2.45.2.436.gcd77e87115.dirty


--3RCcPgCPFvOxo1c+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqvMACgkQVbJhu7ck
PpTuVxAAgI2pXfauqrpg1SKoMOiEbQor5RMAkGO5UzfmcC4MYU53gsYpW+6gFsdY
+rg4OSrhMpDAduPxoIXA0leUSyqBwOKJYjJmSojj4zgUkGAyl9qX7dQpqv5FtA9m
3z02MHSi3eH037/eXExeXkecof0qmjbvxUZx6U3L7t+13USU8FkJMUSFRmvXKblt
57Mo9TWTbyBRKWXjEO6ZaWRf6PXbm7tKcFdeBL2AzCC10oJ5iNzq3ntgcu/mHfnX
kajhwmjQa6QBFFyprRh3fmAxvxy9UGww2t4ounEHuFxwSVlNQrHeQ22MChPsaErT
tueKCW2FJdPIA6SSSKug0f1PRTLI3+1krv12A/+z7wMafSUtIbPNJu3+WRLm5iHP
sUCjT4uLiv2fXCRQdD4ZbUh/m/jR2Hv/kIfq1gPvA1yiNrKxDFBl7iKU3MEWe8kY
i8KdbF4Jc7vA1zAU33XtfP+ooLfDHTgIINa750lbuoYUpbXj+KfSSI0/6buDjMLC
KrNUXdu7hUjS/ZLNCOh+TxeZSY1FQF3pXrR5+z19GHUCimnr+Y8W95Em0R+0MZT5
euwebOGhHIZZ/V7rvccBH64Gw2zOW6kguoz2njh+DIcU0ddyKNLs4DpWrCJ4glTn
POj3iT1tp03Nl+m93anY18sye5Bwyai+HK15V3mGyvXD+ATxLdk=
=56OY
-----END PGP SIGNATURE-----

--3RCcPgCPFvOxo1c+--
