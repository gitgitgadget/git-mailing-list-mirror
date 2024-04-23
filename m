Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721761CA82
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848859; cv=none; b=toDiG1w755pOBIxmrPp/6rf3MPksFo5jZ0ux+T60IsqPQJyvFVRE/S/nI6L0Z5qh84/Eyfiji1i7qhJwUSpVsKaSpOa/m0RNim3iG4rvG1V9suqLiIIlIIBSs6DTUHYvHJLHaSnVIx3Jsn2PJwSL5vw4WipA3kOi4kCpVCqTwKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848859; c=relaxed/simple;
	bh=5Vt8BOrRcDEeufSce5pMHcdhHZXNyEF8Dcc0g/YyxOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifY06Rd8GQTy//aWRNd9kIkenGsATRqWu5YAe8RBASovhFjmrAkgHNA3tTSzA/HYwbPl/DEHtMAHWaOkZIB5jqm16YzLAC93GRorLRHXVIwAkcUKWbkmABir3GFDqdMFAbL6GI5gE4ekX+kJG7sBRExSU6ihVfIBzbnWOWgfU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YTjsk6iV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dafL+gqP; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YTjsk6iV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dafL+gqP"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 64F79114017C;
	Tue, 23 Apr 2024 01:07:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 23 Apr 2024 01:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848856; x=1713935256; bh=DX+5/JiZZ/
	Lhnrx9jIYNZb9TuWi/IQnto78432RzjIU=; b=YTjsk6iVBNrBcbowHyBbEnjOur
	po2nV7sngZyEKfb0jEtTfkK9BLknbET+/pld9fMRvY/dCKIMgAeCSQJCxcI2U2Qt
	7ipVcSuHqNRzbu7f6rRbfwLk2FmKbKWjrcMonW7x82LCCU8FqMj8jEa6vmLZjdYN
	TdNAb1eWBtuZh7Qvb04ZnjSy9r+O227eP7J1p4x9Rhs6s3NmZp3+UI+uYUWKxs7H
	ePQi3j5JNlT1AS2+nnlQ3u8aSPG7eVqOFvN0U8DZttiS8N15xx/b0QHAty6xDm8w
	+188eKt9VUuCekjBhk0r8LXtuRd8rifcZK6dKLaeqLg8yy9Tm+So4fKurBBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848856; x=1713935256; bh=DX+5/JiZZ/Lhnrx9jIYNZb9TuWi/
	IQnto78432RzjIU=; b=dafL+gqPzuhGnxjYpeAh7vyE76jNfbCDZBR9L9sgkOU/
	3K7ATMufUs8BxCvAFvK61YreVBQAtXaxkkQwd5ZSyhRVLMpEdBvX1AA4ptawgrLI
	Pwoe3ULjReTxhWO6VBqULd5UpJl9+lWcAyE8OPp0RYd75qzXkXNZjQRTl8wTeE58
	wS9muV2ByLO4cKCxCWDMVBsYuwGqieZ2BhcbmGOlXAFIMjudiYTHCv1JKYeL49V3
	7TGDHZCdN5Fu5DYTiRg61bJVpw46VoDhdvJhWT56aJCjlCrvadtpRCIWEW0fq4Rn
	+54ecyIhG7xA7XTeJMo5CpYRzhypBfQ4axTHb01oSQ==
X-ME-Sender: <xms:GEInZgiB1p2hRvBJTKNB0zkSkGCi4rIBwqTzLOPOo2uTN1vpYhf8mg>
    <xme:GEInZpA8mBf1mqN90avikJMIdBhoR_1gqrheiVcVDZMGSZQIfwTs1bBV5pnnB14cN
    jO6nxqhcuNvmea49Q>
X-ME-Received: <xmr:GEInZoGBW37fuHOrWflrG9qX3lItbmRxR2Q48YvXzXZdsdr0ChJAt30PfIzFzr8ikx9wDua0VW1AZW2Mi0XuFpm18V2rSw4NZc7-5bEa_mpbEqRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GEInZhR2H4mftt8DvFeFxVI4b_lqa_dqmfIS2qkNd-uaJ-You3jLzg>
    <xmx:GEInZtwCLxUyfX0TuUw-sm01R2e9NHMMwrmKaRs-wJFXhGgrJSRx0g>
    <xmx:GEInZv57TC19Xoi9jUobWQIM4CxiDVRR0633XjLni0n2gzILD81lew>
    <xmx:GEInZqyQvAWIvArtGJjyG_Z2u9fckUsxUuU9dmBj-akXzZju2Id5xQ>
    <xmx:GEInZvsI9-zcN4iPZ2UEnunQ_v1hnpsmUg_48U1-eNl2x9DItChPEg6e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:07:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 69d16cfa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:07:27 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:07:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 02/12] path: move `validate_headref()` to its only user
Message-ID: <a347c7e6cae257e35c84ace191a8079f1dddc0d4.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LpK5uIR9cNVDoLHK"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--LpK5uIR9cNVDoLHK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While `validate_headref()` is only called from `is_git_directory()` in
"setup.c", it is currently implemented in "path.c". Move it over such
that it becomes clear that it is only really used during setup in order
to discover repositories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c  | 53 -----------------------------------------------------
 path.h  |  1 -
 setup.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 54 deletions(-)

diff --git a/path.c b/path.c
index cc02165530..bd6e25245d 100644
--- a/path.c
+++ b/path.c
@@ -5,7 +5,6 @@
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hex.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
@@ -647,58 +646,6 @@ void strbuf_git_common_path(struct strbuf *sb,
 	va_end(args);
 }
=20
-int validate_headref(const char *path)
-{
-	struct stat st;
-	char buffer[256];
-	const char *refname;
-	struct object_id oid;
-	int fd;
-	ssize_t len;
-
-	if (lstat(path, &st) < 0)
-		return -1;
-
-	/* Make sure it is a "refs/.." symlink */
-	if (S_ISLNK(st.st_mode)) {
-		len =3D readlink(path, buffer, sizeof(buffer)-1);
-		if (len >=3D 5 && !memcmp("refs/", buffer, 5))
-			return 0;
-		return -1;
-	}
-
-	/*
-	 * Anything else, just open it and try to see if it is a symbolic ref.
-	 */
-	fd =3D open(path, O_RDONLY);
-	if (fd < 0)
-		return -1;
-	len =3D read_in_full(fd, buffer, sizeof(buffer)-1);
-	close(fd);
-
-	if (len < 0)
-		return -1;
-	buffer[len] =3D '\0';
-
-	/*
-	 * Is it a symbolic ref?
-	 */
-	if (skip_prefix(buffer, "ref:", &refname)) {
-		while (isspace(*refname))
-			refname++;
-		if (starts_with(refname, "refs/"))
-			return 0;
-	}
-
-	/*
-	 * Is this a detached HEAD?
-	 */
-	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
-		return 0;
-
-	return -1;
-}
-
 static struct passwd *getpw_str(const char *username, size_t len)
 {
 	struct passwd *pw;
diff --git a/path.h b/path.h
index ea96487b29..c3bc8617bd 100644
--- a/path.h
+++ b/path.h
@@ -173,7 +173,6 @@ const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
=20
 int ends_with_path_components(const char *path, const char *components);
-int validate_headref(const char *ref);
=20
 int calc_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
diff --git a/setup.c b/setup.c
index f4b32f76e3..7c996659bd 100644
--- a/setup.c
+++ b/setup.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
+#include "hex.h"
 #include "object-name.h"
 #include "refs.h"
 #include "repository.h"
@@ -341,6 +342,58 @@ int get_common_dir_noenv(struct strbuf *sb, const char=
 *gitdir)
 	return ret;
 }
=20
+static int validate_headref(const char *path)
+{
+	struct stat st;
+	char buffer[256];
+	const char *refname;
+	struct object_id oid;
+	int fd;
+	ssize_t len;
+
+	if (lstat(path, &st) < 0)
+		return -1;
+
+	/* Make sure it is a "refs/.." symlink */
+	if (S_ISLNK(st.st_mode)) {
+		len =3D readlink(path, buffer, sizeof(buffer)-1);
+		if (len >=3D 5 && !memcmp("refs/", buffer, 5))
+			return 0;
+		return -1;
+	}
+
+	/*
+	 * Anything else, just open it and try to see if it is a symbolic ref.
+	 */
+	fd =3D open(path, O_RDONLY);
+	if (fd < 0)
+		return -1;
+	len =3D read_in_full(fd, buffer, sizeof(buffer)-1);
+	close(fd);
+
+	if (len < 0)
+		return -1;
+	buffer[len] =3D '\0';
+
+	/*
+	 * Is it a symbolic ref?
+	 */
+	if (skip_prefix(buffer, "ref:", &refname)) {
+		while (isspace(*refname))
+			refname++;
+		if (starts_with(refname, "refs/"))
+			return 0;
+	}
+
+	/*
+	 * Is this a detached HEAD?
+	 */
+	if (get_oid_hex_any(buffer, &oid) !=3D GIT_HASH_UNKNOWN)
+		return 0;
+
+	return -1;
+}
+
 /*
  * Test if it looks like we're at a git directory.
  * We want to see:
--=20
2.45.0-rc0


--LpK5uIR9cNVDoLHK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQhMACgkQVbJhu7ck
PpRr3A/9G6zH1vGcfqNJM1MU1qeoGc7HRcw3TJNRnfahMpqLcBqWPf2q2cHvQML2
HbhsLg4zUgBQ05KIIMoo8n4raUsQdlUpc/mY5yDBbgUgc01Rp1I6D8KAY5wX2NGB
TvV3Yt6Y+MeWmlmqbA6ZDFlG5GXSum0leDTPuPXVwxGE8pyABkC+NsM7jVdqA9vY
ToKRdr3ZUutwxmEVkBXOmuG6yRjkDlU3BOmD2w+HBGvtySzlpHa7eneFUsJ+VLFr
PmdW5kldVs5YP2O01tg4mPlDgXqGi+go9DCpPE8m0b9IZNm3pogscSZW9dEWCafV
W8dHQIM23Eewsak6+lbwSqT5LnMkFzYvX3CWpdzeTwGd85h9JS2s6Kwq8Ugdu1fv
nkuV9HbhOFslFRdXvAEtLfh7QF7zARMDwhMHAZcjfKN+YYaRuC52XZZxID/tT75z
W2y1Hg/xS/7TiGe+srK3KEx+wT4syJuqfxd93wTH3u+tnWyqboSqRNJxoSMGCc3P
HwgQUQ0gCFagHAe+KfO095q3KF0RYFBcQ7KAFRellNl3iIDk/vETYT8V7m8+u1un
Xfcet5SBx5xtGe9Lp+5BMXYMzxVlSQcPExK1ynhwchTcmchouQ/D9Jacw3YqCqVT
fK/YX+weo0PMHxFK48faMkfyLX2lEGwbirpL1v8r5OkMGZ96M54=
=sR8B
-----END PGP SIGNATURE-----

--LpK5uIR9cNVDoLHK--
