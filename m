Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CA484A38
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028859; cv=none; b=KKMqW2nHvirj+qfSUHH8aEkP9dOqrX9VUVrI+rwffRuZfE0VKQ6KeNEOED/1U6F7LRlK8dlWSZhWqSK0/ZnZat87IG6kBS7tfSD0GCqOhg95kvSkwVQpDj6+VAkyitrP5Nqjl2HcfZ/sFZeVt70YXrPOajZ+4FRVNedGzzWtCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028859; c=relaxed/simple;
	bh=NkihLRTa9bsnCPowSQqCiWIdACqEuKtERf/VEgFPogw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoPvuDh4Amo+dJinREpGo23Egcrl6K8heGDmYxOHH6HV49B2tWzEcSoY/1EjDJL9y8vkG4ECAylLksh3PT3Qnm3zkq/FW3aWQXBtdj7gZDEyTimOdlfx8DbNYdy14Jq9plF854vDA9MrBJnKINuE+4JRjsct3A2q6ioGfKU70Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lPSvIvQh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGqJw0Go; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lPSvIvQh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGqJw0Go"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id A22E91C000A5;
	Thu, 21 Mar 2024 09:47:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 09:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711028856; x=1711115256; bh=kTaFQ6P2lH
	Jnvy1x9NJxzX5SlnDtD2I8UHTbt0jas/o=; b=lPSvIvQhTuRV8Z5bB3EqljGZaR
	35bIjMc2P49oNRtxGt3ZJcdYb021NUUKNy02VrJ8Jt2P09twM8cJpo2XgN8u3+IM
	3+B2Zm9lSX65BbTNe7Ppn3VcCbikdlZKk53zxvz1TDT+5n2ijtPfhUi9Mg2gMLwG
	0APhGSUKS4ZV3O3IgmFxfM3+9OAbifVAbeUrICNmRhKuihwRQYqPKhwBmEcN4Loi
	noUcy3OHTStsCdjffir2hPyWmfXz5+TfpI20CjNiKw7qxApiDINntQglfxPkNPdF
	8A7tQG54srGggKw57DS1eyksV/4evZXM+kymUATY4PIqkTrQXt3QI0OJWdpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711028856; x=1711115256; bh=kTaFQ6P2lHJnvy1x9NJxzX5SlnDt
	D2I8UHTbt0jas/o=; b=nGqJw0GohuwIRT/98zGFlbfRAZD5liX16orpXAMa765R
	wWOhnHaXJCWLLrxzrzJWcYgfkkEJbE1i9acVL4Av1GAmXJFwydgl/vrdO4GtvTIP
	t1eImugZePhjH2Bgab7pN3AKLd7LIMFdJOOfgyeBOYJzWMOvGxB6rXonvIqYM5wg
	9fAXjAmr9h8lTbaG8v0G/TuHjyTVhfGgRsmiWqFf5KzwYX3hM8HbQaz9+li+qxZs
	jLJBlux/YpG36j+LiF/6fp4d9PlftpxidH5UKGhADZuNeG925fDauSKQyU7OrS/u
	SZskr2LquGrRIobewsSqetZBKnJW+qjaRCWUKRShlQ==
X-ME-Sender: <xms:eDr8Zcpks_0qXUzFP4DKeiL3okEtmLJ238dvDHbjDTF0rcCqYw9a2Q>
    <xme:eDr8ZSqCHZDJjaQOf-3kY_POllMNQLLmmifxbp6IlFpeb_lOkjsnp4bXrEoyzMh94
    0ejTX9RKm47hvusvw>
X-ME-Received: <xmr:eDr8ZROAmkFKCsQJQdAgpqGsAUXreDTnK04QKUnOF4_zmOwmDPPdxlKs3XkMMRL4PQ-r9b539zGulLy9NRSD1KR4bWpbzh3t77D26NHffnVZ4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:eDr8ZT4GQY51992rXhwoo9A9bbArA0qf0Y7r_KxywCnQ5vxSXwHEsg>
    <xmx:eDr8Zb4gt77BnoY6wp6OqRavmKvqg5xMJareNHTKKDyQZO_zhDO1-A>
    <xmx:eDr8ZThBci9kqLTbMdp2XfliFMvEgPLYH8QiDWXRUleFMpyLQkOh4Q>
    <xmx:eDr8ZV6me_zKy9O-t1Y1ebNmSSZl9TTkndWlvhRPKZzTWNk-dkQ2IA>
    <xmx:eDr8Ze1izBoGnu58PBhcvSw2qMGXE3nx1nfalT3GPQtAie5xb6BwCqHg08k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:47:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d9d0659 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:47:31 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:47:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/3] t/README: document how to loop around test cases
Message-ID: <326fb7965036fccc1c23ad02f200251f6388e6dd.1711028473.git.ps@pks.im>
References: <cover.1711028473.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3qf5pvsj31jAMiwR"
Content-Disposition: inline
In-Reply-To: <cover.1711028473.git.ps@pks.im>


--3qf5pvsj31jAMiwR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In some cases it makes sense to loop around test cases so that we can
execute the same test with slightly different arguments. There are some
gotchas around quoting here though that are easy to miss and that may
lead to easy-to-miss errors and portability issues.

Document the proper way to do this in "t/README".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/README | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/README b/t/README
index 36463d0742..d56401a254 100644
--- a/t/README
+++ b/t/README
@@ -721,6 +721,25 @@ The "do's:"
    Note that we still &&-chain the loop to propagate failures from
    earlier commands.
=20
+ - Repeat tests with slightly different arguments in a loop.
+
+   In some cases it may make sense to re-run the same set of tests with
+   different options or commands to ensure that the command behaves
+   despite the different parameters. This can be achieved by looping
+   around a specific parameter:
+
+	for arg in '' "--foo"
+	do
+		test_expect_success "test command ${arg:-without arguments}" '
+			command $arg
+		'
+	done
+
+  Note that while the test title uses double quotes ("), the test body
+  should continue to use single quotes ('). The loop variable will be
+  accessible regardless of the single quotes as the test body is passed
+  to `eval`.
+
=20
 And here are the "don'ts:"
=20
--=20
2.44.0


--3qf5pvsj31jAMiwR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8OnQACgkQVbJhu7ck
PpSZAA//SOOMlAgWoLmm4vWAPZ3fLfxIO2/ZBNk8gfK9Mp3ntNyHqW/N+swunAuo
yugDZWBLphG4X4PiG2Put/TGkqgSyNtqu9gZ4F3Lqf0LleK9Hev19kmHKnvufTfF
r2RVLJYs8m85NEDFJNx+Gc2cYMIuXVrnfao7aNMo2BtsA+pqkzzr/LEZq1KJAe+2
d3NomJCit2ctSOwyeiTGxyObQ1ul228KoqI1Vm7mYn7v8iER6iU43yiG6Bqw6QoN
HQ4Yu03psilsgf+9iW0he/aLVPe329B++j/ktDlcbl3MMslKSNMm9k6Bjcjt8TFA
4kEp1UWh2lcpTm4sHEO6SAbfEbMhnbE5yT6f8XAECbsnH3Gsavfw4rYq+GoiN1nv
fzvIv6+LqV3gpsUUrz8GDunxwxrmpK4QMnjmQeg1pzJ40it2+HbIU+6lAxneg4P7
35JqcF5gGuZk4gc9bmgDLQjjVAU2+e6ULl0ixjVbaZSBM5wp7LmrauBsXJ0S5CfJ
EFqnqJxEmiEBt8f2bd9L7oRWPnQIM+kY8bb1cj97kMahL2iRkebTw6Dldy4RoMT9
7/AsgxUNbiXcpUmQHAj53BM9JJn3DDvTnSAKw9F8ZtfgeH1ADR7yU+fpyuTHUxAD
LKPlf2K3jYg3F+hIi3EYtwCyFfjM60x6yJDifXV6DOe4qMGfdOs=
=j64K
-----END PGP SIGNATURE-----

--3qf5pvsj31jAMiwR--
