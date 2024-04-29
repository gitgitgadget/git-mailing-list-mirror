Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444412E6C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372465; cv=none; b=gq1I+DW0HdWzjde1Lv/lH1p2S965xR5HpC8vN+VuHQs6Tiqhq5/4VPsaj2EOsGHkyRqswBO0XyClOSWbjzgFvhcFLeKIR/b0jKJj4qpKCqio9ICWdWY9+pLSF7TH8Kqczh0UlmV7voCE4aQMr6b04e6nyLxcl7thoC3I5mqegaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372465; c=relaxed/simple;
	bh=hzAUqwYVuhPIYWWYP8bBt3yVGWUwzLNc6EQ0Ldz8+yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUET31IFedmhRZzRWEB3Wl7iKcjL/Wj93FTN/bh+xrr+afpI3zQ+NCcuCSrcVuQCmtdw2VE9c13KfOZ2S0qvu+waujEZ4AsJ87shGED9Z8Ndvi15sODBhO7LhzP/9IA/I8KcLV7kTmdhvuEcvQEv+tyw0eTKsjwEFh5YRD06TNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PAI6k7DX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GrQiltKb; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAI6k7DX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GrQiltKb"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 02E0D114013A;
	Mon, 29 Apr 2024 02:34:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372462; x=1714458862; bh=8g+TjoU8t9
	ypQnLOQD3udlc1e6VSJOF+bZzXtimWr2s=; b=PAI6k7DXCiYSVzm+g9yOTEcHO6
	vBR0nmS1CRx2NQzQvlclc6us2fgf2pr434IyWm4I8BiqXZff/z1qArgtooK1DVcR
	lqnn9MQCyjusbm08VQNFZvGwsBA0poV6gypNDrWpfgsifL7S7r6kkjJDdXKmL6CM
	Gk5KbNkZgMZpLZX4oEgWOUxQd/az7ueq+2C5h3wv9PaPlvvPFk5TwTGeEFrUyXKL
	6MN1M/3tvP96b8VdMZuhI3r2A0bYNuCTkFE8x8khCeigWYjkhohAr5wLNC/H5A55
	9crk9QGxYSxxlSD2lzLwizeo9DwHu3RHEKuS2krS4IfqLfHbSsXfciwRw4fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372462; x=1714458862; bh=8g+TjoU8t9ypQnLOQD3udlc1e6VS
	JOF+bZzXtimWr2s=; b=GrQiltKbtDFFdqFCIk/snsUuTxE4EYzF7+DyuUfZK+7c
	AtedZ7eqtnrvgLQJLPbsiz0WgSk14Nxx0Km61iPbRC2lJtO7kX1mRJUBN/f2tWej
	1PrRG26gbOayK+Jq7peVfrFrSQnw7k36e9hwZENSCARKaXHBXX7Xe8W89GJs/AJS
	4WAFFCZuQMs2XzbqnTar6c11B2a07vY60cc2jYlKw8f1gMYiN4gZpkKBHIlUSDVz
	9zT1d2drlT/nL3atOTAdLPXF5yDuCXP4na0BxkUzYMjBc1jK5NI02i2yBZ0mcms8
	z46NXg+8UJ9vANd5LWyZ55t7uKtUQbH5mDNZPn3eTQ==
X-ME-Sender: <xms:bj8vZsrwAGzSHtnJqONy1uUb5w4-mTytXa3UV1HSgcej7GDju_P_8Q>
    <xme:bj8vZioe6kKJZfmN2Uk42YcJmdfq_tlZStcyJXf0qJrvoMoXMXbHyaqUSefVUEkQ4
    sOmq7BFvxBVA_-vig>
X-ME-Received: <xmr:bj8vZhPs4AYlKa_fObpyD0u5OXXzNcJMmlgfymNyjWW4EvxTNQTTHajDqLU6t3YdPDP2n8NIfizCpbJWeGonnZ4MbcV5U0WOjJ-uJsU-HSXo7z8L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bj8vZj4CRWJgyP_BdM2ImD4CW1mBxiqr2Y-9tZjdajYHYv_Pohfjig>
    <xmx:bj8vZr5s0ejUn-Sy4cnLaP886JZHX3kIFvnFBhoFGq6gXb6dpAMf-g>
    <xmx:bj8vZjid7MzAOKw8QWAaCiJ-SWdGNv3xBm_GG4NIDUqDUqpTcJEUUA>
    <xmx:bj8vZl7SPMg6BtJyVdY1nCwx1RX92Op1boLhpFkyg4D-Ep8VKSV0Cg>
    <xmx:bj8vZu0OB7V02LQ9-2h2KVvGjJ4Le9QoO-69Hwpebytx1WhhadDwm-uy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0b9b6f41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:02 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 02/13] path: move `validate_headref()` to its only user
Message-ID: <589b6a99efffc9d3f5800cc3dea8ce3367d1e9fe.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TS/QWh14D8nFzASh"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--TS/QWh14D8nFzASh
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
2.45.0-rc1


--TS/QWh14D8nFzASh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP2oACgkQVbJhu7ck
PpQChxAAkugO7w28Z1cGQdpQb6SXOdvFWRp+jg0otytRv27mz6k87sbU9s6p6mg+
KAcgAp5CvBLGMpAxik6sn+sNYftBVfLC2rDOs7T79nXanOyz2C8xcVqwF1IbS6MQ
4RihSCKctvXuW/WJwAT2LfSMaqSaQniRW5ilKtj/FGTaq7uUDYZJmT0NFYoSOHrP
95ko6J5Q2aBB/s9xjcFPTutx7gb8erqvwiq+4DlbR5orQJw1h0S0+4Jw0liPeZsn
2S3fwH2eW/1W2lFGF7Qt2Ma6gvwfraPkY4mhGr9R6s0ZcnSnxNYRZhMB2X2CDn1C
8I/a165a+dhIUvjwjtNNJV8ZofNxUhgpj2yLbz3S/86sFmdhOE8ykDycJiF0g1KA
MBehGxgESmzUK/lp8y/ZgAItcHo84H7OCtIGo9aXCwi3Bej2LH71vKubSp9/0xYK
0rI2p494869JeIZBD49zuXsaDxeef8TsnGNUiSLXBsE3Bs9sEXdxbEp3HdpA1+u0
Ewc/zXU4By0f/gU+GqDlVlnUXZVwh4yzd2xuzbtzwo8kffnWZQGiyUV6h5HqiSdw
8kJ7PSX0XoFFHEZzk2lJHleHg4mbBXKtnmBI8H9kNSVXvLyWeKe7mlKrXVgV0hJ0
HLz86zdAcqy2RorjdqQ3c9Jtkc3EE91oFWrTZRgY/Fa3azWTvzY=
=Vc2J
-----END PGP SIGNATURE-----

--TS/QWh14D8nFzASh--
