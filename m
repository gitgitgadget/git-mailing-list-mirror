Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1596194C61
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669742; cv=none; b=lsgD4ztZM1W9mUZ0POxmv+FmOqewguYbdWmhvvaxYXno06v2/4zN+kmXZBY5RLKJe10Tk5QA6uWh0hXHmqamckWdIV+2CTIdf0gOynJY+U5Ip5xOLqK3ulN4q9mP6d5TBSQZrus9LzCGK+VrOn2tT91TUPv8olsoa49R1NZm/JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669742; c=relaxed/simple;
	bh=HADRcnA8aUdey8lDKGJPiUf3LdUdQhbogqDnwWQzLMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ocSOVrpgCBIjgkjpywYhjQoRaF7057BawQqKh3K6W+fT2BitkKAm25y7nSsIdqPn6x/DHESzQLxz8yhYuXKOQ51TMQWzp9pUS2I88kN7d0fbda+veIG7DoR+3okPBYcgi7epvKMwe+NfSDjj0rvVe7kDVR3Ap6NBrBpYrdfMpMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KudKH7qZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CTl2izVH; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KudKH7qZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CTl2izVH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0145511401BD;
	Thu,  6 Jun 2024 06:29:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 06 Jun 2024 06:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669739; x=1717756139; bh=bgXaG8FObP
	gmvqsaMWtvjkhqBlF0RVym1vR/ryBMw/E=; b=KudKH7qZFkDd4yms971Zg1821h
	riIRAd3bzwOV7OC110Rj5LQ9vQfbqwRtWYGgdVHbKndCbZBJAJJJn9zlGtACx/wm
	5fMyIG/F2E9EPxAykSsGzsRq3ZWEsvhy5EI4fnMySNAAbSYms6MYkilABVisbZUX
	B7Yx7nqCvMgvURSR6rQNFfRKC1xaJLP63/Nm84DRA5V9w9SFUyz989+tV0j9aldc
	nd9zhz1lSaDQwhlLD0SZZbWQQlJt0xA8vZ/mJY64vbzScI9N7i8E0Yi2Xm4vmu4S
	h4Ov5ve0WU3ucEwXtDlI6yHfC8Z8/0rg6ittBGGCiFrgWBlGZ0lbQBBNn7ZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669739; x=1717756139; bh=bgXaG8FObPgmvqsaMWtvjkhqBlF0
	RVym1vR/ryBMw/E=; b=CTl2izVHu2FCQKd8Xc43QFDhGYJYSZpQrTCRcj6UOr8Y
	90Phesnk9sD513YSsHpdWfhTpAL4tj5Wo415xHqRNF1mllb06n8kP98AgVoTdpgQ
	jqIP+Uru+k87lE/X7yDieXsgMTHRehTAj8I21GBHcdtCUcnh2JeWYLHuo+z5Ayk3
	hBDYGdmaJ4UrxUv1WWFTQzMLWIccfviU1A+oAU3uihVsJYkcfvAQcGSQP7vmR6jJ
	PI12Icpx4MDKhikGbSQoi90qfcnK3m8zXYq2ACw4um2nOLZnKurjI/pVudy/OJz7
	vBRyUvRxWr3yfmVvlQKFJhvdUYTNzqIl2HkV38RvVQ==
X-ME-Sender: <xms:a49hZlzJXLHXMU9P3-wG3vAksSNmggeizqWcIhsL6DBn6S8mmGpYPw>
    <xme:a49hZlSAMJJW4nhS0O6jfl4vDlBhw2XmflmVeCdHzo8b5qQwB_97hbVnpOrjLZdqO
    XG3N4uFj1NA6Zv3Uw>
X-ME-Received: <xmr:a49hZvVzwu5X3t8NLCkel1o1gY2nwb4CmRnJsD4PokWLeHwk_PGECbGkoNGtHOQp9tN9uh1t6XlyyYtRDJ1xXlknhHHNNFAENTFUdhqKwexGOr15>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:a49hZnjpuP1rTeTkBUbrOUWzMQIJl4K3Zi_kEDUBPiDWzYncUST4hQ>
    <xmx:a49hZnD8YLDXGtedHh60o8gV1uWWss3_Iaf5-iE5qyujpJ--prHnrw>
    <xmx:a49hZgK4PpRdcbuDWY4Yp-pH3Pi90V2DllpnMS0OwXS7ZT8KEaGvlw>
    <xmx:a49hZmC2e0jlbNbynXhcw9JbV7Dq_6eFZFIj15CYmEt7L0S9q8nHAg>
    <xmx:a49hZi-xCX91GSVbCVs_5n4TUexFjM2qPuwPMmbV4JgupdY2c38bmyhw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 578ac27c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:27 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:28:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 15/27] compat/win32: fix const-correctness with string
 constants
Message-ID: <5953ae1dac6847c33033218658ec466ed69de783.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8hZ+so8bxIu9sokU"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--8hZ+so8bxIu9sokU
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
2.45.2.409.g7b0defb391.dirty


--8hZ+so8bxIu9sokU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj2YACgkQVbJhu7ck
PpRHbg//QR+HSgrl6fgpsf2UXtTPVuy0kjNP05ab+eR/t8jcA77ZCl3AzdbPp489
AnsqODFDZws4N92Gs7aHuJufbZGD7j5V+H0cuXdM4Cg5AniRIn3Lah0qFQ7UKDwv
edh7APGcZyrgCra21nwVNU0keGDhIJzMeI/DM7Nlobh+ru1sP0HdAVOSmAfxmO+v
3P4hCHCp1Jwd+yoo9o/8O5Azxoz0rqFNKJmqKj7xpCEVG3ZNXb/m4g38I1ZeDOZN
E4GpNjbXu8t4VMMy6Txb4GF86+wtQw3ierYd6vgAtcjelxT0OA7dRBULL9oIS6DO
uVLeLzPyC9FoVXwYUu/LRjalIhbJ9r6+Ekfque1guQY/lgi8SCCLCWaWj0nYXz0t
HQKJDOi3TqE+eKWP8RXe1O1y30a0rcwEnUBZPD3uIEjzTbhk90Wuv8gW5bMw7eks
oqYXvlLKwcF4qjSc9MzVIDWZphtGK9BXPS8YzF1jn69iFF/vZwy/AyB6tvZpaINx
V0mnymnES38wD0Q6ubXATxBySz0G88+tKnobw2FwETl4d8WMFw/9+BIMy1+8ttuh
0AYWHr/bUfhNPZEN2lnKhNQjtExVQAF38HjiuPtkB+xIdbE7laTbjtnWfwI3cWVO
/nZiOrAvLbGtwdr1t6k7g+ZWLQ5d/AIQYJih1Xu34GE7NaxrbdA=
=7IaF
-----END PGP SIGNATURE-----

--8hZ+so8bxIu9sokU--
