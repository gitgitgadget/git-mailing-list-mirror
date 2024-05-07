Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877F86BB37
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715057578; cv=none; b=Cm8nQlZRylQfluion4dwPKjoYjPMSsFnwH9KeknkkIDleaE0ZtXbXetI+6xiASUxszvJPSbcJw816l12woFlYJ0Xr9vQBNV68cuThuXMfRR6Xy4Nx5r1lKlaWrUSasKKFQoinZTxaeoL6fwb2y4kJVDplk50SgmbIrHdHwUxUrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715057578; c=relaxed/simple;
	bh=dQzwMM8u84+++nfOuIWCkgTXNVxMebP3HAlJR3crkIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cGKjcxpFdueeoxH/vRaMOmaRvPplO8ZycDt7zo/b79ZjNkP0FbyGMvq2A0v3DM1j9jsZ6HVWOpDa0P0tmaC+LN99/e+YcQwb0jjmzZ8Cy2GM2BPkWmQMJBjUG0/I1gb8S4NSb2vKHnqM1IK+QqVjoWBI0fx4htYkfgVg7NsQj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uB509TeB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YjPkI67m; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uB509TeB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YjPkI67m"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id A14101380279;
	Tue,  7 May 2024 00:52:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 May 2024 00:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715057575; x=1715143975; bh=rjo3FkQIrX
	VOfVyprqTfwXD0A20m+BvdiDJGKWsrMPw=; b=uB509TeBmCFb7U3sQGEo3GBOPK
	ESW7r759PLvEXz2oBuOZPwEndSfunSpUSw+ueI24EGojEonmE7dxaaU4kyEqODXV
	xrAosOPQLzVOkfmBn5XLMRYspyxzTx11EHSo+WV4cRxvpAAhfyPsTFmntBJQhXcL
	Bzqugj9q/+98h2bZl/Dx3FqV0zLEr1UdrDCeuOgO9pDn8EaQtUmmRqimwNE/1X4d
	yRfwsW2UNzLagXBeKktr8ACfZ1jnROmn4vK/cHP53pfhF9milJb/PWaRUviP2v38
	KQbZdmHbVG91fHRYkurL0HYI1qy93PHOPTem1ahISZQIWMQVE48XY5TysaPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715057575; x=1715143975; bh=rjo3FkQIrXVOfVyprqTfwXD0A20m
	+BvdiDJGKWsrMPw=; b=YjPkI67mhgEG0EK4oA+ij4gYQM3suymm/c9fOXLUE5eY
	sFDbwAjUrY2lA+Ij1WKUuak85bMuH/UoBv450YO4Ddh+w022BPQwbUlePlYpfug8
	ekVJuu08/CTj5LrD+5HZZPBQECbWULR9vK60b7beke+1PTUBVkccPsgUujFieT5G
	6WHNl9OIzEPkO1Svlf2jcAksQBKYehJudTsCGHcbEbe3SA+3QbUX/E+CDVN1isgI
	9GQ+l7r2jIP2uNfBbs3BK/GN6wETjujnhKzaETv+AB+10L2gI4J/OZP4cf00vZuz
	iS0Z+7pdi9OTwHjWp2yde/ajI7pd23VR4tSlRuL9Sg==
X-ME-Sender: <xms:p7M5Zsdn1qESLioeJYAQLcQQx1MmpgmaSFp7seA4DVdgqEvWg1ZqQQ>
    <xme:p7M5ZuMV8Q4uQAmvbRDogsgYpCbRZ3ar_fegDjRcOzhSbwxE_WgAwdwmUwy43X5du
    Na4PNke16JHCGAWzQ>
X-ME-Received: <xmr:p7M5Ztib9PStTiLXlyLPbJsy0KGEYqO7S13ITnLr10esWT3LJLCP5NfClX7hZ8z7AzmNkyx3XDx9lLGsf25XYjUT9JnsV5F4OjUCwpbWuA5oHrEJrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:p7M5Zh_XLVCYTql0iy8f0kvQn17KxvdDR2x2FPSB-4Vsgkfp8VW3Ww>
    <xmx:p7M5Zos2osGzJq9MfBAeryFn8GrTWvbDfcH3ni7YVy4zBoQkkRsFZw>
    <xmx:p7M5ZoG3HILNj5jXVF1JEKvLdKpLYwV0uvfEQI93B5Hpx2TDEqVZNg>
    <xmx:p7M5ZnOZoa41a10nqvt2mNBmFZAzyWkPu5cp5J8YSbyi7S2l0TSO_Q>
    <xmx:p7M5ZqLDs9DlD85YHCK3P8ReXW7iQBgZvEbg2aas-fytqFUbSJZMC_WH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:52:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 82364892 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:52:46 +0000 (UTC)
Date: Tue, 7 May 2024 06:52:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 02/13] path: move `validate_headref()` to its only user
Message-ID: <ece0ab94a80a8f0d0541185ddfe584b43a468cb1.1715057362.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1715057362.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XzJafoyS61eEWmi6"
Content-Disposition: inline
In-Reply-To: <cover.1715057362.git.ps@pks.im>


--XzJafoyS61eEWmi6
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
@@ -4,9 +4,8 @@
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "environment.h"
 #include "gettext.h"
-#include "hex.h"
 #include "repository.h"
 #include "strbuf.h"
 #include "string-list.h"
 #include "dir.h"
@@ -646,60 +645,8 @@ void strbuf_git_common_path(struct strbuf *sb,
 	do_git_common_path(repo, sb, fmt, args);
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
 	char *username_z =3D xmemdupz(username, len);
diff --git a/path.h b/path.h
index ea96487b29..c3bc8617bd 100644
--- a/path.h
+++ b/path.h
@@ -172,9 +172,8 @@ const char *git_path_merge_head(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
=20
 int ends_with_path_components(const char *path, const char *components);
-int validate_headref(const char *ref);
=20
 int calc_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
=20
diff --git a/setup.c b/setup.c
index f4b32f76e3..7c996659bd 100644
--- a/setup.c
+++ b/setup.c
@@ -3,8 +3,9 @@
 #include "copy.h"
 #include "environment.h"
 #include "exec-cmd.h"
 #include "gettext.h"
+#include "hex.h"
 #include "object-name.h"
 #include "refs.h"
 #include "repository.h"
 #include "config.h"
@@ -340,8 +341,60 @@ int get_common_dir_noenv(struct strbuf *sb, const char=
 *gitdir)
 	strbuf_release(&path);
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
  *
--=20
2.45.0


--XzJafoyS61eEWmi6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5s6IACgkQVbJhu7ck
PpQhAxAAlJtD4ReW9Nnc9Fg4ESy3GOoqoZBr7H9zGDJasgcibHW1MRS2ydNmkP/1
97/4FhSisT7mc2ToDrqj/UewB3lfypZ9iPIsVvg5glUwCjkIoL9mpOr0Q+jWgFlR
0UvI6Y+cDAxndPQ93PDeP1LofcZ7oKWg6PCEmxX/8JenrbmB+UMQmVREuGeYNBj6
VBuKHcsfbNPNtT8QmrjBCRLk20dvMbjUiWABFduy9p8PncZTYOIkaHMUl+1bukSR
dpnda4r02zE0fQWsN2GaDZuJL6VVpdGT6+p2oJF1UgoFZXrkprnraj+AVxbvr6/6
Sofi9hZyrEG5ewCG6NhZY3Jeagwc5s1ckRdg99VOUvtxYebqGc59If6Ne0snPVty
jKw5GmIwo4BHj6j12dzxmG3FJbGDZrNIECLgckV2hpeN4QDRAOWjwW8NvaRGSCnf
mRJ3XEVWEcp3MFmTx7pY6scbYpz6LGiyxIe6fpJg6j02HpRXu0zNAt5kUPBcYcY2
OFmeJEGIvX1DFsxZxDpYoQWBnwRIwsf3m3dcFBEQGfArnqpJvvDVrFZe4YL7mkcL
GaQa31rQ2ZA7LGKlFUf8E5izfdZ3yTQ4s7htD9Lrs+fJ0PzPvvpS+dXqyHXbOKE5
5Iam9DxUkqo6EKt+lSAid3tYOqKT9Yybw1TZZVrF9mpQKHnKISY=
=ovEV
-----END PGP SIGNATURE-----

--XzJafoyS61eEWmi6--
