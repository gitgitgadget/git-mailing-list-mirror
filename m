Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904A0176237
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107146; cv=none; b=EAmpD2uKfY/x82YRDtmFmqNAex0q6/kuuBURuDN8ufv3eTPhOU4eXAZ1EF3FFVv+FH1SKCrglKlHt7hF5ObyxRCSexfuHvL7I+HOquBfi0aFxklL3JJqQDeAOcTkc3vBosH9SgmFyrLcA8+vKIXZYc3rMZCMkd5DiLBBJvFzAZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107146; c=relaxed/simple;
	bh=oJERV0BncOZC43m/AtVhMBeL1slxwq+4qrynXJzDHFY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N0JPE3yEOm14fXZA67rp/kQ8lUe046S9by9uHuWh3n5V85Apw0V5y6QhGqSy1/OBpHsdDIKcDsRRXQsRHw2lVKme9xOKctHA7NZ9aEMiW/vnJW9GvnwYhEBAbkHpkjSCtowGL2Lk53NkD967nH047z1+yOkVl7PaJCh3ynb9x1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mr5BeWlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X4u9WRYo; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mr5BeWlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X4u9WRYo"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id E3BB91C000F7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Jun 2024 07:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107144; x=1718193544; bh=MVzr+XAIE2
	mm0y8Ot73LrLOCL5052nwaUwKd8BRD0Jc=; b=mr5BeWlPr+gqhsIXbT2KyQMpx3
	9/wYiM0px8abMOdcRU21cbxcLgk7yGFh8X9/mYg31B4pDMwaU39l6J9Qgv+pSuoa
	mqdPPjXJV5XOtkd9MjO8cNcbz89VuA+hf07i01Bh6/Rc+RjGjtpws35Hxe+bMhF6
	+XI/gQP83FzyQ/r2mNqj5Vk0Xiff5nUl5E0QwFdmAV6wr9KH6gay7elKid75qhrA
	JgISeoI4RCrBQN9qT2xOt2tmVu2ZpqY1kMCURgxCgeLCsmrdqlPurykDY+bBp0bq
	SAlAL3fvrY5NmcJdXGQg8/6FsNAnhPEAGKHp0HJbHt1jw+yil6uJqn8j+Q2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107144; x=1718193544; bh=MVzr+XAIE2mm0y8Ot73LrLOCL505
	2nwaUwKd8BRD0Jc=; b=X4u9WRYoFxjQnScLnwtt+dD0ktAdSN+Dy8JkZBywtdYG
	wmYz9Ct/6ncmaXonUB7b/rWTCZMknnZ3UyBE7F1J1E7bvj9uePNwsv9sWWD5xU16
	DbZSx1Xpb7gmcg48hErAzrbhOnJq5rR+JaPqbEi4eeas+cOh+en6yMTPL8+/nMa9
	fl0GuGt+wAnkYdpnIhrjq43LreHf9gp9R8Xo4Q1ow4xG57174Pq2ZlVZ40ut0KoB
	ntj2JZCmc8xU3QeDXa76yydC/mdkV0X2iejgf2Ma3V+Cb9UxGlxuibPP3nv0rxS0
	92QduLu8AargPdQXDPCMMZz2rM5oy7mt6kWOn6QIYg==
X-ME-Sender: <xms:CDxoZmpR7dT4QsF65kR9BX2c8_34BgJHSwxY9dRwThG39NamG_Mcaw>
    <xme:CDxoZkoC3yFseasZuTwgskE4wyyoa0LF_WjYk5cDYmi0RepdEuv1-rSYoWO3IInok
    3ZKCJHwt4MtNgOK8A>
X-ME-Received: <xmr:CDxoZrPNmge_NSZ11t6D0i19LVAbMyQ-B37cClZ_ZQNZRHyfeMwz3sil1VdUZwaQmhH8HEvtwTzV7NeTt7YAUzRbJnLF-e1KSOtEnR2ZOKFtpuiPRsDv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CDxoZl7Tn3FPIE5DlXaBn7CjWPz4I5Hy6YEjbdWhzyE8F1s1rhA3BQ>
    <xmx:CDxoZl4335OM9RX4i3fE7zDYUYSnsYq6-K__5zU73qFA6onV2T0CsA>
    <xmx:CDxoZlijV5Ecmpu56HeZlcaEn9QFt1hdoM-vBGTcO2hT7Q5Lp8wYVw>
    <xmx:CDxoZv4tz_alpTKJVw4Uti0l3ZuWEYFp6rt4CbRwLZQwnj6knShTfw>
    <xmx:CDxoZnSszvOPIBv754Ry4w3F1zg-cWtXbQjOIoR2dZ0Pn7cdd7_FM8M2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:59:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9089a5f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:54 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:59:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/21] t/helper: remove dependency on `the_repository` in
 "oidtree"
Message-ID: <339d668da837ab5b4b11399ece4efaf5bc27d313.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rXDDBrQmlpvdL4xN"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--rXDDBrQmlpvdL4xN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The "oidtree" test helper sets up a Git repository, but this is really
only used such that `get_oid_hex()` can parse both SHA1 and SHA256
object hashes. The `struct oidtree` interface itself does not care at
all about the object hash of `the_repository`, and always asserts that
inserted object IDs have their hash algorithm set.

Stop initializing the repository and instead use `get_oid_hex_any()` to
parse object IDs for the "contains" action, like we already do when
parsing the "insert" action.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-oidtree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/helper/test-oidtree.c b/t/helper/test-oidtree.c
index c7a1d4c642..04ec24cc84 100644
--- a/t/helper/test-oidtree.c
+++ b/t/helper/test-oidtree.c
@@ -1,7 +1,6 @@
 #include "test-tool.h"
 #include "hex.h"
 #include "oidtree.h"
-#include "setup.h"
 #include "strbuf.h"
=20
 static enum cb_next print_oid(const struct object_id *oid, void *data UNUS=
ED)
@@ -14,11 +13,9 @@ int cmd__oidtree(int argc UNUSED, const char **argv UNUS=
ED)
 {
 	struct oidtree ot;
 	struct strbuf line =3D STRBUF_INIT;
-	int nongit_ok;
 	int algo =3D GIT_HASH_UNKNOWN;
=20
 	oidtree_init(&ot);
-	setup_git_directory_gently(&nongit_ok);
=20
 	while (strbuf_getline(&line, stdin) !=3D EOF) {
 		const char *arg;
@@ -30,7 +27,7 @@ int cmd__oidtree(int argc UNUSED, const char **argv UNUSE=
D)
 			algo =3D oid.algo;
 			oidtree_insert(&ot, &oid);
 		} else if (skip_prefix(line.buf, "contains ", &arg)) {
-			if (get_oid_hex(arg, &oid))
+			if (get_oid_hex_any(arg, &oid) =3D=3D GIT_HASH_UNKNOWN)
 				die("contains not a hexadecimal oid: %s", arg);
 			printf("%d\n", oidtree_contains(&ot, &oid));
 		} else if (skip_prefix(line.buf, "each ", &arg)) {
--=20
2.45.2.436.gcd77e87115.dirty


--rXDDBrQmlpvdL4xN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoPAQACgkQVbJhu7ck
PpTqVw//X7+vZXodHHQdsV9AVQ8UeipahTonx1SMvLs799NvUVa/dcVbMW/IQuV3
C4b2tpNs1Q3FSz2eqaLqtalbyEulMfKOlLOvn3XSesDVuzNVuj3FIMJj3KVITaE0
0I11OOmNIM3OgGHBl0YTZYr2/V1Mr6XMgORMDhym2PTyNZzRe7DkTEFAJSW3H+6x
biMjUV5ku0D58GppuWuH1UVR0YyWAqMYPaVyY01lSamnHsQQkAnwHK1jPfRXu7l5
sPjfvvAuO/N623SGAFNQbka66yaPILZhCuRiGP3siXyXkz3xdOkUqJISjWX1pP94
RcLXSUrJD8RpV9kVcQn4dNzQjbEHNuiGmMY1vOpGBj9qofCL+QHs9zykdnqu7bge
MIM8XFiDq72Ieo8zahbV6DD7066qSo6IRtAjBoEeIPbiYqWoJ2DKJq0WVC5OnpmF
2Yg5XE/v+aj9/fuvGT63ELsDpAQ/vAyFsHRLGlcipZZ+CwxcUo3ZCOQp3XUVS/zl
D53q2so2V7NeDkFHyZeWFOSxntTxNfZ513XmSMmajG4cq1/4h34lcpWvmiN0AVQO
5ViQWv0PE6vMb8i/Pj/TRLhrHmcPJKQUs6METcxouY+EOy5dvZaCu0jodgY/X+RY
5L/e/lefxgItQTNLeIkbHA8+/4tMx8TrUYXBXP7mTrrqomBhoQM=
=mRm4
-----END PGP SIGNATURE-----

--rXDDBrQmlpvdL4xN--
