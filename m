Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F4A146582
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504688; cv=none; b=YMZime5ScsP0B64oTeebrvuF+b6SMh0g8rUicxUhYe/s7xtz8YiN1vXOfq2hFa4BelAoPqPSwi3WT7TUaYLQInrlqeYhFZoMbGTMKSiEZQZ9z2dOWqundI14n4ECBa+ytIzVC/MkMXs7NM7f4e0Uw4wF1MpNjvMoriG7JuvcOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504688; c=relaxed/simple;
	bh=ZX0AJX76AnZF4S1M03ZZ9fg5qqI1e44y7k3SZQiLAlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U9zYdUYsElA/TDGFizpfyui0LAIb3AUNILDVehz2k6ZVWlNJ6mtN+8C+fbqve7OaK/s4u2mF1oTD8w+r7oigFj9TmZmbOEf4rAwx9tgxg/SwOGlVuK0jg9MzYJhznY+hjBDXy+JNW6bkv02f7zFJ8zNDBoISRYgiG6KEltDblYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DQDAnDQ6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YgINJNz/; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DQDAnDQ6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YgINJNz/"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB401138015A;
	Tue,  4 Jun 2024 08:38:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504685; x=1717591085; bh=ZvTxwRAhOe
	8l09b4lBYrEgVa/JZ13cX/kd8TIMt+myE=; b=DQDAnDQ6YGUJDbn0g/wK7oVlpe
	ZfqAAku2qTnrtMOeRl30Jx9A6zY92giLqVTNgb85QFwMNOLGmFJI79D7sF1HqQfC
	MXw2eMzVUh23SAHQx4/uhz0+58IbsM0n37fYcBHQQ0KKE6EiMqD4gw/X4Y0qGjBj
	oBpgTzoubrqnfSBUuNUQmgG84NHa8o+FKqYN3zgyNyBn7mic2aJ2Yz5COOx6tHBS
	c9kKanphRJgHPeWBeY+muzmlWinjllpPOL4Lk5h60ftuWd2bF4zKYyrKfTkM2tAR
	ShaJyk2pdQeb5fy0y4wzSFLbihd2Bb8q5CVJGv3w8KpJg7usK/5Hgtkq4Gfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504685; x=1717591085; bh=ZvTxwRAhOe8l09b4lBYrEgVa/JZ1
	3cX/kd8TIMt+myE=; b=YgINJNz/3gHGLU3yn0rZDS1PQfSsWK0UjZav+W9drr/x
	sBMPORk2q30Hzl0Pe+mnhM3/WWvJN6hGmYRaCfoERT2tm8z1QnY39XL49O7jD6nu
	GmIzWJwLuy5WsbZpl0V4ZLN6M5bq/90vpRzNM8Y+MiVSQeb6WgtH71NA9PWqQdVy
	7Xr6TTNHJxkqpZbXzjOAc6l8Is8/25cKoWDfJGVoP/GxQ5yhSGMuFOQLPjKADt8j
	HjnefT0HRYTK0g9HB0wiHZ9hHBPr3nR9kAEgqq94xMYCBaJNDjul55AJ40znFoaF
	AlTTPujAOuhmGpvDraNkvW1rknVraH2Dah/K+NDRkg==
X-ME-Sender: <xms:rQpfZuUrx2pcqipw8kYWmQzdIDtPe0ujSk0AxJKOqpuuqLlU-PZA8g>
    <xme:rQpfZqmKT73ApqmUoObmj7sb9GG0F6rOcTL0eRot86LprkCR5PhARFH7PtpLHiqGw
    JWe4TKyO7RBmo06Jw>
X-ME-Received: <xmr:rQpfZiY4nmo_LnXow3RSEMk-vSC1ytXGsCYF8fhOR6gGTJNX3c8YT95-ihqfIF70v3dRAXbbcirKZ2b2AaPE5fBjQx2fArwqbbOgPnpJQ5tqUAON>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:rQpfZlV4u4fFQQ5LWX-O2SKLkNJ685DNZ7BA1NCo5X8Ir31Czwy89A>
    <xmx:rQpfZolejhl01XrrYbuvkggi0q94QXyfXFbeyCP4dd9xetsIzUAm-Q>
    <xmx:rQpfZqfyvz-cgp-rZJ_t6uUaKYUCKFnS0Aa7avytixCd56umoNkHrA>
    <xmx:rQpfZqHsTY-Gz7aD5nYnAJ_kDz3Yd6pNUEE0WnNkPUJDpk_RRoXfKA>
    <xmx:rQpfZpAOOmaDQQjCLB5c3ataqt6ihauiQ--lH7lX4PgiRo7CqaUdD-8v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:38:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5c50c8e8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:37:37 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:38:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 15/27] compat/win32: fix const-correctness with string
 constants
Message-ID: <06b6120d266858ab4563781f9f2d47226681548e.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YGUQJHvrId2tg1Lf"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--YGUQJHvrId2tg1Lf
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
2.45.1.410.g58bac47f8e.dirty


--YGUQJHvrId2tg1Lf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCqgACgkQVbJhu7ck
PpSqbg//RdlJsbIvksdxB0quil8H7qgqjrl18woyx+i/2d615dyWYH2RXfdYNLrf
w+D4gUPo20Ac4EOnVzmyY6CnixaRY1ZYe2p19bC4RiHCfIkfqscu2HmebkobXblp
UKM0mA9QoXo8j7pAHwzaZcujIgBq7NuFltnEokTI3EzG1xu/cAjZeJXxZflIIrUf
vo7LLKBQ79ZZL/XwRXal+5SAJ3wr2dX6MgmTkmuzR0mEOdZSTYEIt7CoMsgsl6c9
BY8L1YFgg+oeKzXFeeL1CvRKLleUQVe3G8LqDJ89OKW3HBK79jq4P2Z5/XSh6S+m
ZzVr3Oos42dhVnRp7p/ts/OzJdP9FNB3CU1cMMr5Mu1a8CWV1560JkDmA3lQxlyo
QpUzPdzC46eySJlVbzS11yZEM2EkRq4UT5r5thG1E7p8buD2/hWuNmJwmkjbjzT1
dXDw8gB0QS4KGdB+l3MkvRCqrzwsOCkwecG/Eq6nSh5l4u6gxvpA1nVaQy2Wdkt8
cnKDy+TzRMXLB4V+EaaTBZyeRfyZkSshAyL8UxOJ0juoVs5gie42eGkK9PpSHdDH
AkeiwHfCJPG7F2XRDpenABklST16bnCA82cjQBxZjNAcVNGSihWMuYCWFxBSB4cR
vNCbOD+p2Gz6oldLc5x00qzcrdlJOBNq8OIFfYdQw8z86s6s7wA=
=fSG/
-----END PGP SIGNATURE-----

--YGUQJHvrId2tg1Lf--
