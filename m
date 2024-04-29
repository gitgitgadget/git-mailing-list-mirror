Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294A314A8C
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372512; cv=none; b=e5oBO50OY4U2H0kjSBSUG11luuZS2ORry/kD+F9i7AEEpdyfgKozXMoUt1z+Sgjt+QIr6gX0dNKqnWiVMcI8aNambjmlobylc+CGYH4tg9i5mBFzpNn1yTmZqsDgol0h4r8x3EPx5pCo87bfr2f11vpdNAYjQ/hJCcQ6QHbWaQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372512; c=relaxed/simple;
	bh=9uAiE2bLIk+BTtCZX+Nao+Htl3qry7T7srMg5POJWis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Is9AO22dxcY36Dpwiz8ACj85698quB+/1k1ogxBjOjSWR25/7WH9wqQ3L8tR/CQ3e2aABYAx+3tvbI9dAwIdhSkOXZe5MLG/MopMxkR8x3YZWwXM8TuAIiiz9/8C60vtgdESLNGU+Tlyct9HEgbxDWIjWhw0pNZ50D2F+V2OE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=giN3Iuq7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MeiBDxVX; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="giN3Iuq7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MeiBDxVX"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 6C7291380389;
	Mon, 29 Apr 2024 02:35:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 29 Apr 2024 02:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372510; x=1714458910; bh=kFyyAw9IXX
	6+d21zMDW53IWMKwEbvCURjA5cBbrf+FI=; b=giN3Iuq745L7q9YBOs6EUfW2V9
	U6DbsrfFVVvQFJE0q1EQK05oHgr1aP+A+CMU1DzS/hkB74nmoYDN7QoeObViSQ2s
	1ovXcHgPehEZurusjl1EIbsgIE1w7yJPx3Sx9j7XXHRKSzDeMS/l4NKvAl+G7iEo
	u902DWREsTrT8XKVUT1fOc6SfbX7cV0kRffANWneuCbsOMh95rj5pl659oAUPW0+
	90Dt6pNyjgwvT51Xacw4i0U9WKlAdjOCTxmNqTydzG524lxc578pV8NLiuZ35bLg
	uEBpsjF963VB7l2Khw2UYbq+OA9XF8DfulOvVZwePLT6pzlZbD1NLwNQS8JA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372510; x=1714458910; bh=kFyyAw9IXX6+d21zMDW53IWMKwEb
	vCURjA5cBbrf+FI=; b=MeiBDxVXrH07lez1u7NcO033q0XirV4esY4AhC+Vq7BI
	KlC78JFT7wvhzxCnTyMwVbSnEeGug2MkPvkICb239EJRbyXzXq8OjDOB/BRNlN3L
	fQ/CsCTeNImECNWDOVLsSmn74OOUllhJLFmLlkXV+gSqm/RymFNsA/mQJ2KKlHG0
	XspLUuwtcZlyd06ZpBKgcKseKfrKmv00zh1rEHs+QEBx7IJdhpdWLvCaHNbIg5Cp
	/Ye3lz9idkr47EKb9d4djZYmA3Y4FsaHGrY454cfFqNVEcv7qFAt1F7NM2vNK9yL
	b0WSnBYsxOjf3GBmOumeBJhkMiD/avO25g3fOAJGGA==
X-ME-Sender: <xms:nj8vZqdbTxYiCC3lwlclA9BD18wVQq4tFGJYZrhTsUPxyMop78yWCA>
    <xme:nj8vZkMsDGSwnIpDUL67DsA-D9rCO4g5l7SjXsBCTy5JCGybIsHi6XUu38Ngqmc_9
    tBdkaId4x4FbFiF-Q>
X-ME-Received: <xmr:nj8vZrhiF2j1T6P1Cp1qRgehvn_pp8w-hFpv7WCPtg5urebJQ1z7u3D5QvmreqhqCqtvHoxTj_8QXemdOM-0qr6B9tXf9pGTHsx1-JiwQzDtqRl9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:nj8vZn_EKStZDX9IqkYvkwHiVBiquOsliv4ZedVz6P6T4bFgj9m2jA>
    <xmx:nj8vZmuIqmpLzhRqp8WPMkz4DJ1j1ZoLNQIlMzuBr7S5jngeWB_JTw>
    <xmx:nj8vZuHTtq6yMN1JXSyAzwDNzHKE3MZZarztatipmtM0IFboOLjIGg>
    <xmx:nj8vZlPuPYrWWS7OTvbN1JtlCNL4tw-fRCYYP6h8s0iNIJSRU7w5iQ>
    <xmx:nj8vZoLU8Zw9cE45UKgbN95mwxfYCdTQF4sOKr8VHBVAIXr5zUDHq2CE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:35:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 26ac040b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:49 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:35:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 12/13] oss-fuzz/commit-graph: set up hash algorithm
Message-ID: <660f976129ece3398465053884fbac62a6341bee.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/RyOl1P34Aij5e8j"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--/RyOl1P34Aij5e8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Our fuzzing setups don't work in a proper repository, but only use the
in-memory configured `the_repository`. Consequently, we never go through
the full repository setup procedures and thus do not set up the hash
algo used by the repository.

The commit-graph fuzzer does rely on a properly initialized hash algo
though. Initialize it explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 oss-fuzz/fuzz-commit-graph.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
index 2992079dd9..94ecbb9242 100644
--- a/oss-fuzz/fuzz-commit-graph.c
+++ b/oss-fuzz/fuzz-commit-graph.c
@@ -18,6 +18,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_t si=
ze)
 	 * touching the disk to keep the individual fuzz-test cases as fast as
 	 * possible.
 	 */
+	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
 	the_repository->settings.commit_graph_generation_version =3D 2;
 	the_repository->settings.commit_graph_read_changed_paths =3D 1;
 	g =3D parse_commit_graph(&the_repository->settings, (void *)data, size);
--=20
2.45.0-rc1


--/RyOl1P34Aij5e8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP5kACgkQVbJhu7ck
PpS+Xw/+NLIqSjOoy7tfrBy9VtWYP5SwvsF8FrCBQPoIA+OJ7Euhdsx1JDFvw/Ll
Hl0mPUyjSxwQtE1yiFCZnp6AJbThr0F94qlzc6wYZmx94jplQpsonRniZM7MdxB6
VcmgoZg/tsJORQHnpaLsfS9eETqhjr4wmD5PQG/xQYKeofzLlz1J9WfmP6YiipZ5
pvPN+/zsIrglOzZWiIDbeqfA8sN2WuBRQJlzVAJ6VjuM76SeMNtJrZWcWa8OXLPv
T+zOHjPD5hIrfSaJ+mBOdhoa/3+licHjTwD0gEqUpoINrxBV+RkV6C+T5rkHJTWZ
lklQmSxHs0ym4q9jo9Zik71m1m4QSmYLnSj9J0lr7KY8SgtBms8XW4WddCFmXoxk
kAIUemgE/1L74vwnho9/lSmieBIV9hQsfx8ZCfFDacojyXVruj2QVrHYUISS6DNz
B9VsI6JFxTOnf9lyHCGRhDM+TKWl6kA7RJYKmVlA0Sa5WuraRRgXTW1BT7o1BsWV
vdf8QCWc1KVR6cAA3dUwDUlWYgCox3RsuCAufpVB8ISHMy5O+qAkc5JQ+/svWBea
X+kx3FjZChG0w6U72q0+tQC0rsZeXttz18pTiI46yLv7RRmbJ4BmPGuh6U0mKmxS
8SNDDNS4Fn5Zk9BInhPBR0aSfrmx0hTJ06rSyn2auqNmGDe3vMw=
=wHyK
-----END PGP SIGNATURE-----

--/RyOl1P34Aij5e8j--
