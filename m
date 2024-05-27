Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9554C13A3EF
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810393; cv=none; b=VnU3vzD07m/uj6AoQLPhKGxh50AtbEpV73KZf6zeTD5enjAU5q72Qshc25y1HFkuAQNYSWK18pdhcIAzNp64G+qhGjKSM8QdCL5UciKQjdxOmfvSK+Ach9d8uJnod/AoNJcIa4MBqMzbzwJkJEZyJMBz1PXRCbVGOxTMH5b206Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810393; c=relaxed/simple;
	bh=b2gqpt5ZZPejjF47esf1R7c4o9/NG2olCfvAr/79PC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoVmVRJv2CPWAV+Hpv2zF+jInnjqwZA4YJzln9CIrilwi26eli3+8KK3OPJnZx794Pe9z2IcEcZ24mnmNKwFI+9cEdEUZmWeNce50GTeenytPmFHtpqsnLVFNtoVUvPuhh3pPTZUxsfPFMsszcG3miqYF6+N/ZMGJkmQhgZV+Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ppp5OmQa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T7VA2Svl; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ppp5OmQa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T7VA2Svl"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id C44601800097;
	Mon, 27 May 2024 07:46:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 27 May 2024 07:46:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810389; x=1716896789; bh=7FvUCN62jL
	DPa60g9XvJcmpiTH53FRhB3035OxJsbmE=; b=ppp5OmQaYH9fIfeRTGgoF96iv6
	t0kNpvlsFR6JU78ClDFsZ1TR1rGLq9AD+9JJPAemu54P2H7V0tR6zg0eyFu+pZNF
	S4zqu0RWz24UlYQi0IC6H4de8SW7AqwU92QtiLc9zpACtdoSYE7tt1jeUz9QeEWk
	pfZmlEPJRXQP/l6qg/Bs5wTZoloZf/+bPgdC3keyA+er9+xw5j35Dt4sTcJOXvS3
	2NqlQNS0Engh+X40HEBPkWFbnx6bS8eSpHanlF87SVnjGxvi8G3hdeCgAKYFxyVB
	aaxGNca700Z31B7VU9ettmvXjyxY/f4XWaR/JSSQprtKPAJHAcujH6SXA/SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810389; x=1716896789; bh=7FvUCN62jLDPa60g9XvJcmpiTH53
	FRhB3035OxJsbmE=; b=T7VA2SvlFqbUt5wC13MY1iZWAtrY0uQr3AFc2J6E52HQ
	zSFxwOGsx4XqCSPIDqU7bbsWovydiPXCF6d3KVyXFov3KBUk9k0/l5RSJlpj5RB2
	/D5srF1yYkxjsVs7pSc5wQVOcLxN36UvY2v3vNchdMuEXhb6OihuT4E0jnXxofXE
	lXwjmUkDC44NCq0ADwHVccaUx1gdeJVPIFWhp9WQ02SAQ76dZO1ko4cJvNSd3Op0
	HPReO2ORXiHylyRG9LRWUsQ1wi62LXsrBxfQMGq98bPrxYxQliMAUIAe07QslmRR
	XFSreNDZfUggzLZNUVATh0QvyeYGH6SsVd4MM+A2JA==
X-ME-Sender: <xms:lXJUZnQ9Ke2yDL5IIDYqhl9BejNwkZXGRiV1v_E7ORJtm46RqkBjzQ>
    <xme:lXJUZox-q47D5g3jInEUd32AYZbDwNZBj9opgr-d8z9EJg5eVAuyx8WEydEe1HH9q
    nhDA6MyFnf7OrS2Hg>
X-ME-Received: <xmr:lXJUZs0BJ9t14Ktm_-Hmj7Bo-s_c2P5ym7xThs_fjYmaAXIDkQySOGWvLeswabP955l3I5HpkT30wGbdYhPxKMZEKz-kEQdIxKFH5HigDKxUVxiQcPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lXJUZnBeGQ_FhVh9WJ-2GiyE11G2izbwk4WZdGuie_rs3U87dP_IUA>
    <xmx:lXJUZgiaKaQqC-_EYN0yXVbtnrp2obTQBvSv29uCmdmKc2fE-Zg7sg>
    <xmx:lXJUZrphYLbaMgdQuU4SvAhCQiXtD_e4_jD0sgfffH6bozhyVKO2lQ>
    <xmx:lXJUZrhJ7BR6MDV1LN1WssK1RpdtWpav-YNw5LcGGarQ58d56zxp6w>
    <xmx:lXJUZqaEraIc_fzHGJ3fRKyi0OQh32shDqikUXPyHqJXnMviDuaLbwnO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:46:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2c440a8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:46:17 +0000 (UTC)
Date: Mon, 27 May 2024 13:46:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 09/21] convert: refactor code to clarify ownership of
 check_roundtrip_encoding
Message-ID: <dae00f1b63ebaed67550aba4b7df4bb6139a164e.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+cJvtgqkKMKv4fxO"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--+cJvtgqkKMKv4fxO
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
2.45.1.246.gb9cfe4845c.dirty


--+cJvtgqkKMKv4fxO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcpAACgkQVbJhu7ck
PpSZAg//eWauENL1jsSOZm+0YOVsklgZ/7mcMUT3WwZiuMkuHjbmnyrjWsY51s+y
2IJrVqUuMfxjYj+gY48i0Z4PCm1YYn4Nehpd6uQy1UnGPB0HrBUKQO+A9aE46NrN
9OBP9vWIl0XRrrMtFPAm+xhMMiilDR0Fs5T2jpgbbURplcFroPOaJEiM0EEcyaNa
20lPUmwKUnZAQudsIb/K8ZNvB/cehqR4g0yW0kcI0wRXJk44mar02WX4hP5V0Gz/
rN7hojRSPK6NmzjTj7CmhVEH2bRuaZG5zNCPQxpJRLxNQgapyQN7BmpOPq2mZnO5
20tjCbpLHTfzD7dLJAwW+LtRad5bguxuiX1IzLaQM5Z76I2IiMvWt2UC36vuHkkD
woKOFt8qvkAK2sx4kJaK6ipQrVXNWZACQA/z0WCoJ++GdIGjIlmpq2wz2Emp3GQ7
zRC1rLss1kZstrjJ4T+3AauB10ScWyTl7MS5HmD6l6ZuPzQoPkGJB8N8Df63x1ys
/dto4ld4f8ygTjshlXAAH7okotilOLOWbtcfJy+B/cuskkF2ylLeZBD4G3hpHWG3
LSk5N45vlWZt+t8mJQ3i8c4fg1Ooi/vdmNUflOZkmuXBKK7Dx2Pf+zxdgRiAO9rK
g9bcnOcqKsyiupjl4wIpBqdEx5I8jheQijAOiaWYmxFE1UCIfAk=
=rI4W
-----END PGP SIGNATURE-----

--+cJvtgqkKMKv4fxO--
