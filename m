Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C989C4CB37
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360984; cv=none; b=JakbgiyksobUgTF1zkSw5vPzG6sDKDb8/PjcRmgLCoxGDpYPMFwkjXw/UXy0McJi4Ny2OxTkOdq0qkT7oa2InZlqrWQcgyXPnegig5IPOKCsXHcU6e3YNYe7vz+JZ0DK0P6U4Pfm/CVnqbof51r9xWPCgr9lHFA66y+4kXDctlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360984; c=relaxed/simple;
	bh=pFCXwAfAt3miG2crjRX/AJahxbhde3+nWa/0T92++vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryT5NglxPkxgWb/MlGvFl/VP63+Qzsv1I5oM9YkxxG18Mz5L86FXv4Z4aX0Cq0Edu/raWbpp84jXxBM5U9C96DUCdaoYhB+13pKXqcIkMLc46mOll5IHkxGGfEuW6KiBkES88PBZh0kKoWzO/bF1uJNXjqa7U+IR5st+BnHY53Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lPb93p3O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IVBiviVH; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lPb93p3O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IVBiviVH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D8A1413800AD;
	Mon, 25 Mar 2024 06:03:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 06:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360981; x=1711447381; bh=YmTp9GjzMl
	qtRVUd/3jFfpraHis1beNHwRqud3gsvEQ=; b=lPb93p3Oj45tWNVGmQBU9jdoYP
	buW7+G8L7ddLSa8dJU/dYw3JWsel9vA2Tehwb0SoW611ZrvfyN0s4ENk1zvw3cAi
	k2e3u/40HjmJnogmZp8EaUZWVIb+EvGoTG7QKjtpmugngzOKqzwur9+ka6n4nKzw
	Y0K20mXzbeGKh78vkEv84LqcnkMNaa1a/VUIjAcRci2mS68BWweNYfqKndZ8/x6c
	YsmnQknJLM42WBzSsZv4NHFYfqrzsqPXl8p76akf37SFR4R4yU5BoJZm5pcb4fbM
	y+c002wpd0H+zFUR1g1nZ0trsPqfG92HdlHkWdaJsrVIb3OTT60TiL8dXCKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360981; x=1711447381; bh=YmTp9GjzMlqtRVUd/3jFfpraHis1
	beNHwRqud3gsvEQ=; b=IVBiviVH85fS9sFt153t+dOXIEJlMLFbIJ9uOqfm3U2R
	SL44BP5z8uk/jRagPzMi/qx38pmVlSdRfS7LCkHPExZNaw+qxFXCHlssLsOycmkb
	mZdsGNo1mK7ihhid2QnM4QV0cmlEIGV88B99uTMgtUjxk1v/IZvtcgwN6WVLr+9r
	wQvLy3omfeN68g7eoNfdbw1EtWLY84NiS8twlROSPwhBQwbr2+MdpSgLRoNUsZ5w
	Du3kJtIfCktHLizf451r9K7wPvTh+oJTX6B+q7c9aK8RPwI6Uj3yZiPmZsrRgPB/
	xSwWSac5Grogx0Du+fz8JnTrLvAF5FnEna/0YD3GAA==
X-ME-Sender: <xms:1UsBZpvrHsnhBBBzwH6LkEo1mJSCGDEFSkCvrkZTM2TF5SkJVP6yrw>
    <xme:1UsBZievsU7L3cIHiip3VaCchgagRCoIAkN6fDVo--TosKNQoYDSZt7E1TDTn_1Hj
    dhW--QWijAkR5ngVw>
X-ME-Received: <xmr:1UsBZsz1WGaTBIlM3xstH4WzfYVBjoWbin9mohuo4knt7mHdl8RtxTnEh7fJ_AjoIK8evR8dkrVnZkXNnRUYOW7r1EepadpGMvu2pUWGwFq_jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:1UsBZgNcqUW4YvrV03pqCTMIaDz41IxTxeYpimSLBt5HT23iK5DpCw>
    <xmx:1UsBZp-jznpIFJoeOAHm2acLKrOFFnE6-Rye34kuovws6J2pssoC1w>
    <xmx:1UsBZgUhdyojmOl4kAP1dGMjnDzkDUBk69LLuD8T6qH0y4DSo6PDKw>
    <xmx:1UsBZqcenVUM5DbJKwRfJ3D76A6o2Su7WVxfx81RIDcCeqv87ed1Zg>
    <xmx:1UsBZlY7XxtNlSYP_dU_Qucf4031kz_lrQMWttgZiseEtgTFsZFFDQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e7db634 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:51 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 06/15] t/helper: drop pack-refs wrapper
Message-ID: <e84b7977287d5e2b9fbdbe1cceadf33c109a55e7.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eLcMuvH+EZTICWB9"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--eLcMuvH+EZTICWB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The test helper provides a "ref-store <store> pack-refs" wrapper that
more or less directly invokes `refs_pack_refs()`. This helper is only
used in a single test with the "PACK_REFS_PRUNE" and "PACK_REFS_ALL"
flags. Both of these flags can directly be accessed via git-pack-refs(1)
though via the `--all` and `--prune` flags, which makes the helper
superfluous.

Refactor the test to use git-pack-refs(1) instead of the test helper.
Drop the now-unused test helper command.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-ref-store.c     | 20 --------------------
 t/t0601-reffiles-pack-refs.sh | 13 +++++++++----
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 7a0f6cac53..82bbf6e2e6 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -112,25 +112,6 @@ static const char **get_store(const char **argv, struc=
t ref_store **refs)
 	return argv + 1;
 }
=20
-static struct flag_definition pack_flags[] =3D { FLAG_DEF(PACK_REFS_PRUNE),
-					       FLAG_DEF(PACK_REFS_ALL),
-					       { NULL, 0 } };
-
-static int cmd_pack_refs(struct ref_store *refs, const char **argv)
-{
-	unsigned int flags =3D arg_flags(*argv++, "flags", pack_flags);
-	static struct ref_exclusions exclusions =3D REF_EXCLUSIONS_INIT;
-	static struct string_list included_refs =3D STRING_LIST_INIT_NODUP;
-	struct pack_refs_opts pack_opts =3D { .flags =3D flags,
-					    .exclusions =3D &exclusions,
-					    .includes =3D &included_refs };
-
-	if (pack_opts.flags & PACK_REFS_ALL)
-		string_list_append(pack_opts.includes, "*");
-
-	return refs_pack_refs(refs, &pack_opts);
-}
-
 static int cmd_create_symref(struct ref_store *refs, const char **argv)
 {
 	const char *refname =3D notnull(*argv++, "refname");
@@ -326,7 +307,6 @@ struct command {
 };
=20
 static struct command commands[] =3D {
-	{ "pack-refs", cmd_pack_refs },
 	{ "create-symref", cmd_create_symref },
 	{ "delete-refs", cmd_delete_refs },
 	{ "rename-ref", cmd_rename_ref },
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index c309d2bae8..b1cf587347 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -32,11 +32,16 @@ test_expect_success 'prepare a trivial repository' '
 	HEAD=3D$(git rev-parse --verify HEAD)
 '
=20
-test_expect_success 'pack_refs(PACK_REFS_ALL | PACK_REFS_PRUNE)' '
-	N=3D`find .git/refs -type f | wc -l` &&
+test_expect_success 'pack-refs --prune --all' '
+	test_path_is_missing .git/packed-refs &&
+	git pack-refs --no-prune --all &&
+	test_path_is_file .git/packed-refs &&
+	N=3D$(find .git/refs -type f | wc -l) &&
 	test "$N" !=3D 0 &&
-	test-tool ref-store main pack-refs PACK_REFS_PRUNE,PACK_REFS_ALL &&
-	N=3D`find .git/refs -type f` &&
+
+	git pack-refs --prune --all &&
+	test_path_is_file .git/packed-refs &&
+	N=3D$(find .git/refs -type f) &&
 	test -z "$N"
 '
=20
--=20
2.44.GIT


--eLcMuvH+EZTICWB9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS9IACgkQVbJhu7ck
PpQm/xAAhadzeYwHBxe4J0jxkg8PbLH07O/jZGJUB5XneX9QvE8TB9HlIH23PtD4
Nu2Vm+nOpwSiZpxO1et9o6kd8g43r5Hw0KtynPYwW/z3tuVqs8vqB+BE0Wuffnmf
mQcKwgHjJs0R0r9cqru0XyFnjyC3XldnG2qXY9Nd8iLCRPxwjGMlpZ3I4se09VlP
fdcU7bUa53JRS4GDWXbtreBTfkDUES1cOZ67hIzK3nVAc5vDHsONfz3U+jM7vo28
m4NaO0EfreHCnisMkucJp5uDkIkZrSEtbJ5zGfNSmCTeprH74lJ+Bgf22Fdx2TlK
0LxjsILvV+p4y7I6zoJMp3VdXjqzFDBSycaG8WIq0B/B+xb16Dysst2CVq0i8HdM
9amigLHpobQ1t3Z2rqmDFOM7zK8VPvvP3CgKB1tC+GIoeKjPkTSmB7p9c66koTEM
oCti9VzSWU6KF24FWElpAYsuAJnmEyLhDj3ul6/oTwWTcZDD1XyyommWPi6rdXHt
q7zoKqcDzNtyZSZLEwssq1IYKdRaowXX/zpQGfPrWjWljc06B2RQ9mvMcAyGUOyx
pJFhzGHrM+iugUTUPWc9y0yrfqwavNEWYeoYwzmIpOvF7BkejXxrS6q5bjnaiuOE
ADywqOj32wNMCrCTwnK2OHDpa/OAWfzWejewkwIr9sv2FsRfK7M=
=mO4j
-----END PGP SIGNATURE-----

--eLcMuvH+EZTICWB9--
