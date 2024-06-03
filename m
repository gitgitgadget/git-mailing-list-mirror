Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321284FBE
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407612; cv=none; b=kgR5fKILyZI7B/TZ63D+YF3YD9ymbIJkx4qEDtUdL+Em1GfSxkUsA1UKZjMoPZBN0r0TGASiakdpEbLOpX0XKs9kIWwv6aqk12663Pw68rmRvHI9EiG30JFaQNjF268y9dDItGTEBMUXGrD0o9/zjoeshiDiN9Hl72TEep+4TLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407612; c=relaxed/simple;
	bh=TvAujvPxsvjUgwZ2ZeriH35X6QJrSPO9bdvi1KNw/CY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQxL661EcdBPvFTljTNSVIJmYIc03WnjuAwSkzmHaLzK/4XH2CXwZJKZ9lDVIhgtSOS45SWZUHHWFLDHoO278PRjJyCO6QIpo9Dzjvb07BtQtQBiF8V4pqRHG8gCjzL8QGE91wLDac01BFf3/rUvXE94aIh+r/sQs2S1ewsH9ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YXk81w9t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G66UaHe6; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YXk81w9t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G66UaHe6"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id E48621C000FC;
	Mon,  3 Jun 2024 05:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407610; x=1717494010; bh=TFAxKTk6Wk
	1scea461w27IjOmc6mMIR40vAtYfV4q1M=; b=YXk81w9t3jNUT+SXxL5ELoqjEH
	4E4h3VecL3jyCeqxgT8DhW7GkZ4j3yRmu4fKfan/a8UvbK9Zhc/xp4CCSq0A1C+7
	L0VRI7hDnPt/9d0Ve4XvFo6MVrqrKpRNOhjrZDBUa1jxceXljZq13y//lKHmNn8z
	CkAQ+2uzwe348D29BLhvr1nkCDtnl+MoKJXbjrisP+4KNohQ0H8VsE7e6BQPhtf8
	iZor8EChxkILJyxAVnwtslp/ZZVk3jK8BSwIXNiUY8CDcHDOzNEE4WiZReZZ3fVN
	e7iwzxhAOLHvKsuNGli2eflNDZ/mJrcDnOzNaHxmNxjayWGoTFkwkXgxO+rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407610; x=1717494010; bh=TFAxKTk6Wk1scea461w27IjOmc6m
	MIR40vAtYfV4q1M=; b=G66UaHe6LKCkyrX45MZ1S1MAAWYOPh0yCK+fZXqzBW/b
	CPU6P6k4X9P/MdRaT0VmHsfVjSPYAZb3mLJdOUFPTiH+tNN1aB5gFy08J3LnrbIg
	dSzXTWd40quaAt/molJuH/2T+LgisxhCV3LRKOZ67zkIJDb277+BDM1s1wr6dBBs
	PG0nkpqo7EbA/y69E292A7IR3+2TdVWEZ5qY89lFnWKzK8geQkAXpC+QnXjTcI5i
	iI7Ra2wwybSHdQ9f/T4MJbQCXF3v2I43SJF9xTHO7XscYczTKDPh+MKgKxtc/jOW
	DibMRWH8S4rQwk2yzzb8PzxLtwZtPIld7yj3snmfDQ==
X-ME-Sender: <xms:eo9dZriMMGzFf-Xx5dIFb11K2lOsgYJgkhMBWtR2PSgt_Zd__Y3VPA>
    <xme:eo9dZoBWr0CUBnl-bMJX1hxDcWeND_gUltg8jIERQSYq31ev2vjWjo2OXAJbC0lfp
    RdLWfUQl7XQ9KA-_w>
X-ME-Received: <xmr:eo9dZrEsv8cKo5TcYzAjI2xe4v7EvOD-qvDqwCzqnXKZlZPjMU82uQhxH82pFpNFiygFWZVpala0Xytkh7C659JILkPfvbKctyoRJtYicadGRlHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:eo9dZoR5nMQafua3HLUxr_EmTKOEh-0bsXVhzg3mKWYyiDgHX0h-yw>
    <xmx:eo9dZowZwAWGkLsCIJAMKELzJjcnB3y1cIxw_WQQ2O1SQhgMwiw3XQ>
    <xmx:eo9dZu5EtX8ZX31rjSrqsRhBqhKCpg_xO4Xbv4ZGOzs9JU_i1M9-zw>
    <xmx:eo9dZty-IZ6QV6jsI7dig90kNYjJeatt4D9egs5ITKD69UXjHEh54g>
    <xmx:eo9dZk8aPLqWJeolFB75UC8ZXQRoaw0Do3VXw7VAAepvz0uq_GDmSOYU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id dca03202 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:45 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/27] compat/win32: fix const-correctness with string
 constants
Message-ID: <3d92528125ee419aefdac790dc1a4106be632c60.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fYkaMbLXfy5y16ZX"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--fYkaMbLXfy5y16ZX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Adjust various places in our Win32 compatibility layer where we are not
assigning string constants to `const char *` variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/basename.c | 18 ++++++++++++++++--
 compat/mingw.c    | 28 ++++++++++++++++------------
 compat/winansi.c  |  2 +-
 3 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/compat/basename.c b/compat/basename.c
index 96bd9533b4..5aa320306b 100644
--- a/compat/basename.c
+++ b/compat/basename.c
@@ -1,6 +1,8 @@
 #include "../git-compat-util.h"
 #include "../strbuf.h"
=20
+static char current_directory[] =3D ".";
+
 /* Adapted from libiberty's basename.c.  */
 char *gitbasename (char *path)
 {
@@ -10,7 +12,13 @@ char *gitbasename (char *path)
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
+		return (char *) "";
=20
 	for (base =3D path; *path; path++) {
 		if (!is_dir_sep(*path))
@@ -34,7 +42,13 @@ char *gitdirname(char *path)
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
+		return (char *) "";
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


--fYkaMbLXfy5y16ZX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj3YACgkQVbJhu7ck
PpQe1Q//SUi6JZvGnZSlnaC5maEv5tfe96c12/aSLBRL4ukw562C/L5dEmbScbyE
lSlvV/1FM8NC8g02xYYD6nlktK6aNwZf8cvv7XohaVgHoiTFmS3Fn6vw02S9XIca
VqQwBMK9VM8OdQCluvQZWG/mksREgfy4k+OshYXtg6fheIZT0uTXUcmO8BDOAcTx
ZW0ZQp531ig+LAqFOJYDoqhpK05S13l8ItzZTOhYvm6UF4RDjbAXO/PvXqzSti51
J91+BQju4Rn7srHDvafw7nSIFrgyzEg5W5rn+SpAAt+OYMwI+k2N1q28FRN0ZFDE
HFkCE9CYfJ31dy7sqMouhZ4dTecqP0WgqBL9pyouDeMwDAtdeRvcbiee5a4nR7a0
/RmwSeq0zvfelOuye9ixCeOYwrNbjpswJEIdJZVMpWju5r1Y688GhHrkMwI2V7bJ
GEkZ2JB33IZEzNuZGihJpxwPfNKHeK6WnHhljQs+BJYsrcHt9mu19rpi6n6VUdru
h67ZumhwsJEyKWHwrdb6FZg7PUewoe4P+3ogEUePmg9D4TbazcjbR00EYpoBMMhd
7OWSjVC2fSZD71YgcPexu/8zl+SGx8YfoOGCgwC9Aeox6oFKgC2HwPTu9QEJ8GO4
t0B5kwlfpOVKwQKyuXslOvOVVMH5zCtM/0JVCiEPl9AXyTOcbNk=
=I/GL
-----END PGP SIGNATURE-----

--fYkaMbLXfy5y16ZX--
