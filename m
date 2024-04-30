Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A0B14037E
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714480018; cv=none; b=qik9gVqeQoh1Oken4ENUGqnU1GrH+/aeiKBisZa01GI2H9zEAJfmCnh0sU3RHXLg8d2EIHiemUv1q4yk/kCE2p+sAiWk5eSj3eRRMpI0g88LME6s6j4IVwx4l83qm/v15IBo7bmd9T2rJjOrUO54fRPhxaKCUuyiGZ9VtjkFosU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714480018; c=relaxed/simple;
	bh=RTUdWAgX8wMZunTj7yaB0xjF2ZQrt/EBTNY0ZdpGEAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPmqUuL/BdWhQDYJaC2hVVE3dtEttDW3CntjwyqgzHoNALWZDBDM1w4SGB5YeX9TUR9EcVjzH01GztOElKQRhBhV8q7GXj7iq9OLx6PmahFss0sMI2DjZXLobVOshAENv/tfm3Faz1OaCkn02kRCkjc8n6odVu+6Cl/+KCaclgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=No8rxVku; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TNl1XR+c; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="No8rxVku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TNl1XR+c"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 22F2F1C000EF;
	Tue, 30 Apr 2024 08:26:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Apr 2024 08:26:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714480015; x=1714566415; bh=QY47j0rS+3
	a2TzzSkTXgGW/a4ow0u6ZQKvc0kQibxpQ=; b=No8rxVkuhB2atj2abX5jgfrSSh
	zgepRC5J5gnmqCQYgFMhjAEL8JECy/YwXEDjVpyA9l7b+ZeXJn1dngc0X0draDD5
	jXHX0nYoPaq3t+vcMXBQLhmb2WIxuvfviUCxoPc3B0raoHca35IxOKr8Cc91dgM4
	HFRed2VcXdsMksgpfnLBFKZp+Gk3ozCr2FZU/1y5axF7Df/LYzm8t9LK91XxXKzE
	NAcx6+H/ps9F257f19WtWM8QGFOpe4Bq0QyztccOUvBLG8cwJbwSxaxe7kKyp6i9
	Wf3iG3zQx2KxaHz5koAeH5nL4KiKBEKbiJcSiSKdyBJmrawZkDsXlGk9A7gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714480015; x=1714566415; bh=QY47j0rS+3a2TzzSkTXgGW/a4ow0
	u6ZQKvc0kQibxpQ=; b=TNl1XR+cBJMxyh20G7iRhnYuWR2y5jf/8j/iMUkBVWu8
	Qr/WxFM9HTtYv7dQSwkvUuDRxBhgoxNHKFqvRGt+mORo0wBX6kcsyJd3PtqmGuxz
	Jf12utF9trxStKGP8nk9YED7mWp0s951i4C3jSj5XkpvOm2P/fEXfNtTEJVCp99/
	GTMssguQgF1mAnSyf+Uepxow0GKoX15D3JVgPK1Ldl9a27bHmI+iYBD+aOLgI+ds
	I1BL5hIP8ZUhPut2HbSjlo6LMBc0a3sr+Xz33+nIadIlPdupXuGVw2BnnpdMeo+X
	bghUTKVxqbTIeQP8icx4wxNCAuYrvymorqZLOiHz9A==
X-ME-Sender: <xms:j-MwZo2w3MkxGoWf6IoEF_CXMCVIQPVDccKWBTeHJlr63CFGY908Nw>
    <xme:j-MwZjH2h4nTMCNgdYVG8QXsX5wTvk486fhd0OU6HUwY14vvV7HJ3bWtMSpzIyoJo
    YtpvWnqFi-RG5xwkw>
X-ME-Received: <xmr:j-MwZg4xoCCIr5z0M5QP_MzgSUz9XyFc3Mf1njANajs_QV_4jGVTz5HuYTUGC-9b3o-yY9RaEpQhcjnlJU4EzcwrH7LR23VO8bctf8GG0TS9Ew5vH7_D>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:j-MwZh3jEnIJ1GaFDhrjf5wyfjpS4GSffZe0vsNcVViym_IiuanOmw>
    <xmx:j-MwZrGFFkv5BfNw7LvplhEA8yyw-1gS9U2fanL3T7e8o3G_NBvxvA>
    <xmx:j-MwZq-OxnJ-XWcS68i-IPCbXf85cQ4WkyPD2PY8VMPKH3lv3k6sRw>
    <xmx:j-MwZgmMrQC1lDeO_RWf720GsyBx7lUJVslM_xTvepcvWfDkA-izxQ>
    <xmx:j-MwZg5Tu4WDrC159cHUJTbEUCPT7sh4Wr9eyGrPfdCtJarCrbL726BF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:26:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 09210981 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:26:32 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:26:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 07/10] refs: root refs can be symbolic refs
Message-ID: <e90b2f8aa98493e9cd3f2c04cb58318780f9f6e5.1714479928.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714479928.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cYe2J1MwjSvcfgwD"
Content-Disposition: inline
In-Reply-To: <cover.1714479928.git.ps@pks.im>


--cYe2J1MwjSvcfgwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before this patch series, root refs except for "HEAD" and our special
refs were classified as pseudorefs. Furthermore, our terminology
clarified that pseudorefs must not be symbolic refs. This restriction
is enforced in `is_root_ref()`, which explicitly checks that a supposed
root ref resolves to an object ID without recursing.

This has been extremely confusing right from the start because (in old
terminology) a ref name may sometimes be a pseudoref and sometimes not
depending on whether it is a symbolic or regular ref. This behaviour
does not seem reasonable at all and I very much doubt that it results in
anything sane.

Furthermore, the behaviour is different to `is_headref()`, which only
checks for the ref to exist. While that is in line with our glossary,
this inconsistency only adds to the confusion.

Last but not least, the current behaviour can actually lead to a
segfault when calling `is_root_ref()` with a reference that either does
not exist or that is a symbolic ref because we never intialized `oid`.

Let's loosen the restrictions in accordance to the new definition of
root refs, which are simply plain refs that may as well be a symbolic
ref. Consequently, we can just check for the ref to exist instead of
requiring it to be a regular ref.

Add a test that verifies that this does not change user-visible
behaviour. Namely, we still don't want to show broken refs to the user
by default in git-for-each-ref(1). What this does allow though is for
internal callers to surface dangling root refs when they pass in the
`DO_FOR_EACH_INCLUDE_BROKEN` flag.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c                         | 50 ++++++++++++++++++++++++----------
 t/t6302-for-each-ref-filter.sh | 17 ++++++++++++
 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 5b89e83ad7..ca9844bc3e 100644
--- a/refs.c
+++ b/refs.c
@@ -869,7 +869,10 @@ int is_root_ref(struct ref_store *refs, const char *re=
fname)
 		"NOTES_MERGE_REF",
 		"MERGE_AUTOSTASH",
 	};
-	struct object_id oid;
+	struct strbuf referent =3D STRBUF_INIT;
+	struct object_id oid =3D { 0 };
+	int failure_errno, ret =3D 0;
+	unsigned int flags;
 	size_t i;
=20
 	if (!is_root_ref_syntax(refname))
@@ -877,30 +880,49 @@ int is_root_ref(struct ref_store *refs, const char *r=
efname)
 	if (is_headref(refs, refname))
 		return 1;
=20
+	/*
+	 * Note that we cannot use `refs_ref_exists()` here because that also
+	 * checks whether its target ref exists in case refname is a symbolic
+	 * ref.
+	 */
 	if (ends_with(refname, "_HEAD")) {
-		refs_resolve_ref_unsafe(refs, refname,
-					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-					&oid, NULL);
-		return !is_null_oid(&oid);
+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+					 &flags, &failure_errno);
+		goto done;
 	}
=20
-	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++)
+	for (i =3D 0; i < ARRAY_SIZE(irregular_root_refs); i++) {
 		if (!strcmp(refname, irregular_root_refs[i])) {
-			refs_resolve_ref_unsafe(refs, refname,
-						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-						&oid, NULL);
-			return !is_null_oid(&oid);
+			ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+						 &flags, &failure_errno);
+			goto done;
 		}
+	}
=20
-	return 0;
+done:
+	strbuf_release(&referent);
+	return ret;
 }
=20
 int is_headref(struct ref_store *refs, const char *refname)
 {
-	if (!strcmp(refname, "HEAD"))
-		return refs_ref_exists(refs, refname);
+	struct strbuf referent =3D STRBUF_INIT;
+	struct object_id oid =3D { 0 };
+	int failure_errno, ret =3D 0;
+	unsigned int flags;
=20
-	return 0;
+	/*
+	 * Note that we cannot use `refs_ref_exists()` here because that also
+	 * checks whether its target ref exists in case refname is a symbolic
+	 * ref.
+	 */
+	if (!strcmp(refname, "HEAD")) {
+		ret =3D !refs_read_raw_ref(refs, refname, &oid, &referent,
+					 &flags, &failure_errno);
+	}
+
+	strbuf_release(&referent);
+	return ret;
 }
=20
 static int is_current_worktree_ref(const char *ref) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index 948f1bb5f4..92ed8957c8 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -62,6 +62,23 @@ test_expect_success '--include-root-refs with other patt=
erns' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--include-root-refs omits dangling symrefs' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git symbolic-ref DANGLING_HEAD refs/heads/missing &&
+		cat >expect <<-EOF &&
+		HEAD
+		$(git symbolic-ref HEAD)
+		refs/tags/initial
+		EOF
+		git for-each-ref --format=3D"%(refname)" --include-root-refs >actual &&
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'filtering with --points-at' '
 	cat >expect <<-\EOF &&
 	refs/heads/main
--=20
2.45.0


--cYe2J1MwjSvcfgwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw44sACgkQVbJhu7ck
PpRnbw/8DTsDZOfqpiydD59Cp/pB2GWtIdwhJJe6bWAzTDAeTVRot0CSFNtSi90Y
R5kT8AYkjNk8jKLApHlkpNCk4dXzE/Z3/IaShWL7FpqqCaZx0tndXOZtyRpP5lsO
CmGKe/HvJ7pb3nABQq/ScTsmZs5ity3XgV0/R3UNXi62Q33EAbu6fuPCGLU/9ZPy
8f2VWokpDPXr9Qdsw49rDmJwN6zinrT03Ij8KK2FxzS2WqtH6XnwvDZaYbwOVqa8
oNb9oU4AEQDqm37tnv5xbuLjvQ0JqUe4rHeXt0EodUx+oKtc+Xhxn51Sum2IKniK
CuoG6i5ObfEQ0B5jqwR8Q42AUvFVJ2qfYp4KNoBicQ3b6oOtrS7nEGtqgoW1oHFi
1LB7Rh1ICr2a/tIMPPUpovKqnFiJ3zsXYgO+n36n456s5P8bt54DWj7LDkdlu61p
0stWtibARalGb9+EvK1qSerfC3sZcw3OWTT17+2xQUp4M18Y4HjLKwJ6XVcC6R3K
bbVqTQCD1cegZ0bDOxDqQkTuMC8UFWrvKDdPyimpOPE3Ma5y/9lheXpuTPNslQFX
CGrfqfCp0sAVjIPD6KAXojDAZy7SqTUbmwps91vmD2ECVKz0vWXMa6Qawg13YaGA
vM5h16Ode39o7p0b2FO7bgx60kwUEuycNsPyRXyxVtAalARL6pw=
=NdNJ
-----END PGP SIGNATURE-----

--cYe2J1MwjSvcfgwD--
