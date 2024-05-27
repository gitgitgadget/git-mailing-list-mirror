Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB3152DF2
	for <git@vger.kernel.org>; Mon, 27 May 2024 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810440; cv=none; b=kFF/kwT5q0S/aZ+GjvKQ+PSjElFrhupluabTNc8xPn9QXg3njUsIA7vwwHVwLdGY9svc5uGBWJH/FojcfFVCZmfBGs2Mt96xbEvo/5bSOzz5F1t4wKvb3PQZjEhVKIDiTm5fAU/OW3t4SeQ+AZGtrwFXKdWZLNTUoQ1I581j6B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810440; c=relaxed/simple;
	bh=nlgcwhZC6lE3I0UiwMB5m/8MBUyXOGoMhZYk8MDseVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjFqYqJDemqWhaPi4CtrUg02FdJ8PQLrSuCzdeBs9vgw56CgwjOSm7pGgaY7djEjR6ocGPD9erfnqCu7VRySimIqr9gkkSD4WIQEAJ0E/z/mAjNR4P03wbsXff11HFb5Y66jrehcxGNXDYjXEp5Bkjg4/4q1inRtuF40AhSSA5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QNCSRdzM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E29CONyD; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QNCSRdzM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E29CONyD"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CE1A5180009D;
	Mon, 27 May 2024 07:47:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 27 May 2024 07:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716810437; x=1716896837; bh=fF3/++Yo27
	6+O/gJ2QyAd1IBfI/MuLbvcVnIBTyjjQQ=; b=QNCSRdzMeBqZ/Q9agDEleMzwO1
	aSSjYc4D7WFBBOQ3diqzNCm3bEZ7u5jD32dnzt6ktEOU9h5kL/NGs+ASZTk2BM2a
	b+0YfJl1IOQsx8liGLj9rJFBICE7tnJw0PLZ1pBrZWG3BAxT1DcQ1NmvV64SfCzM
	LI4CVlpatetYHndpL9fYIT0/8Xgu+FEMAcRmDab4r7PXNhQ79lTGPxhH79Qn4Qm2
	6WlLOy5E0uKpRECdUMmubBq3R1wTO4dT/dJIxwkEQUcRMYsQlGXfi6h2dy+HSF+t
	DdQC7eOh0bG02th6+vNHGkqkKRsdI0UJsh3nqKu9s/c0H+XaeXZxb6YI7E4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716810437; x=1716896837; bh=fF3/++Yo276+O/gJ2QyAd1IBfI/M
	uLbvcVnIBTyjjQQ=; b=E29CONyDeAeTzZ9hrZn23oUSnpq2+sdg9DaVaJRSwHkD
	S1jr02GdFCLs5v8UmrMhhFgTd+A3tm9Q22VGJXmcLpMA0RWk38PX1T0eYItjneRp
	PlJEgzX955v0mavRvf3D4rO1njlkKn0zF+m+ddH8nE1ZK84v9x/+qm9ay0KSmS/L
	qLPuzpwta36+g949DzG5C7iYOIhY9xgKsxhKLluZmpoqowYwR8+R1du3vjTPMn+b
	dr/hCystPheFTR+qWkCoiIh2G4t3GeLEcAMjJNghjn77E1l7svp8QaQJ8RuXes8O
	JRTV3DPXKO0i4vth/6Qeiul7gOUVgFsM7I3aCVUxLg==
X-ME-Sender: <xms:xXJUZjJCcBJixUHgthkqj4ziMwZtytgHDbapm8fuIYlFbX3W9OrCQg>
    <xme:xXJUZnI3U1_bNZjV6j4258_yaTECkZEp_DF8gFZ9JkMPRuICCWJ6NSCg8lh0zaRSO
    zG0EcChULxxm9HFgw>
X-ME-Received: <xmr:xXJUZrtft0pXAnsJRvGU5eyFZv059ZXJAgt8lIpXDTzNWdkloS1jHyHWDkTfdTYQ-G44TtBU6omn0E9JdiIi6F3-lnrM8mNIlMT9TlJRm-KmXXZG9XU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejgedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xXJUZsYwXT_K6KqdKXTM0qVcCBdywcmynnGNg3OpCUZyPlyhezIFrA>
    <xmx:xXJUZqZsS5srfBegq42c4QEheqEpzGFpbc5RLWbk2hB8ydn7le9Oaw>
    <xmx:xXJUZgADqYCc-K4mRctV26jK6_WWL0MBjWw6dgdqGDrcyVpTzLJrbQ>
    <xmx:xXJUZobYRdeFThppW1olWkvsPvmF8bEWCekgIouQyjwj019jl8dczA>
    <xmx:xXJUZhynXs3EbD4u5cPdt8KnT4YSKGT_pP5jQ8enYfulDi7C2fGlnHKH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 May 2024 07:47:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 65945b32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 May 2024 11:47:05 +0000 (UTC)
Date: Mon, 27 May 2024 13:47:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>
Subject: [PATCH v3 19/21] builtin/mv duplicate string list memory
Message-ID: <9eeafac3650d6573c4ef09ccb499b75c5de2f3d6.1716810168.git.ps@pks.im>
References: <cover.1716465556.git.ps@pks.im>
 <cover.1716810168.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gy+yD4r0VTQrjEuv"
Content-Disposition: inline
In-Reply-To: <cover.1716810168.git.ps@pks.im>


--gy+yD4r0VTQrjEuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

makes the next patch easier, where we will migrate to the paths being
owned by a strvec. given that we are talking about command line
parameters here it's also not like we have tons of allocations that this
would save

while at it, fix a memory leak

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/mv.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 9f4c75df04..12dcc0b13c 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -183,11 +183,12 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 	struct strbuf a_src_dir =3D STRBUF_INIT;
 	enum update_mode *modes, dst_mode =3D 0;
 	struct stat st, dest_st;
-	struct string_list src_for_dst =3D STRING_LIST_INIT_NODUP;
+	struct string_list src_for_dst =3D STRING_LIST_INIT_DUP;
 	struct lock_file lock_file =3D LOCK_INIT;
 	struct cache_entry *ce;
-	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_NODUP;
-	struct string_list dirty_paths =3D STRING_LIST_INIT_NODUP;
+	struct string_list only_match_skip_worktree =3D STRING_LIST_INIT_DUP;
+	struct string_list dirty_paths =3D STRING_LIST_INIT_DUP;
+	int ret;
=20
 	git_config(git_default_config, NULL);
=20
@@ -440,8 +441,10 @@ int cmd_mv(int argc, const char **argv, const char *pr=
efix)
=20
 	if (only_match_skip_worktree.nr) {
 		advise_on_updating_sparse_paths(&only_match_skip_worktree);
-		if (!ignore_errors)
-			return 1;
+		if (!ignore_errors) {
+			ret =3D 1;
+			goto out;
+		}
 	}
=20
 	for (i =3D 0; i < argc; i++) {
@@ -566,12 +569,16 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
 		die(_("Unable to write new index file"));
=20
+	ret =3D 0;
+
+out:
 	free(dst_w_slash);
 	string_list_clear(&src_for_dst, 0);
 	string_list_clear(&dirty_paths, 0);
+	string_list_clear(&only_match_skip_worktree, 0);
 	UNLEAK(source);
 	UNLEAK(dest_path);
 	free(submodule_gitfile);
 	free(modes);
-	return 0;
+	return ret;
 }
--=20
2.45.1.246.gb9cfe4845c.dirty


--gy+yD4r0VTQrjEuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZUcsAACgkQVbJhu7ck
PpToRA/8D2MCUYZZsRhJSAx69W0hVpLFYVmE4tqJIjXLbiJ0S23yJ7v+DzGIaHMV
l4/vbe08YM0C80AQ12GPoG8dkDoZFzMboXxbrZlKrulIWI3cuAZ6paRGmbyTwiTu
m+mr0b0RdlcvQIpO2KRsHUY2PKwL0Y6lO/eFLw3FO+Z5NNphn6V53rFLdjXjin3h
VD/d8xrZEh6njk33XFtjWVpG3xBQRrNUMjgAkhW4J51xhcSrkVPv3IVPzOP0NjHS
jejv2OsX3psjTMqOM711bQgzWwo0g5JM8i8SlR7p5o4+o5Prr5fW/GF0HlF7IpmB
Wtisp72IJcUv73hCMJr9U6aKsjT79aEQH9xcLQ1IvtbJSJXKMJ3VPWE0cKduVwV8
uXYHzMTY7YusSRGEkq1VqRtRy/fiiRLGub6tFxxR7sFBQO2sBveqnJM7pEVKIB/O
jcxamvIBYpa0XpOx/1MZ9DV4qKjk0Bs7sUFBonQ5RbazKohKhhbZvgHkTeukTJNj
kWmvDFPOUIPzl1zoVXUGDtgMHf1Ery+Ffvn8BuMoljlJXBojaBlrQ68iXAKjsyGD
N0F/XAIdTb2jtBhXJjA0+KQ57SWhbD2/JShfk0KLJr3IDb9TVb+KSYXI5r7WARtM
VKd0XcbMbcymfczpvmdIDBrr7y/nfdZkFN7c8k27Lmi2GQGkRhc=
=LDBQ
-----END PGP SIGNATURE-----

--gy+yD4r0VTQrjEuv--
