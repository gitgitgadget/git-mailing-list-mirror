Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA2518CBF3
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122331; cv=none; b=buo03Uv3x2z4KH1yN1/FcrGXtR+snJDqXaJ8Tt1gYue2ag0TxV10Si2cY06EeQPhMhdGCWyAM14JuvdpsBzo6XGFgmzMBi1SaLy+0Lvp56in218lwdIqn1acmdNW0TNWT2Z6fr2b2m5MKJZ5MzA8C7PwfUGT3quJOS1prA4qwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122331; c=relaxed/simple;
	bh=cCknkQ8cHC0BKnLO+GyFMAEBzfkKukdmjxl2sHXBlso=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qCOqPwLSEsyVNcX2rkQq1e4hdI5yUYgPZ1rBZXXnzFnkIGdtkGeDtq+Xj8N8lnYJIXdv45+4V4BUAwvlumPmxekJkRiDGR+Iikh95Okko34HwK1Ig9xod4RsjZZUGSplGMhXpk6mn1yiituDQmYO7U2pmW//t7rmitf5kVhMHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A8J1KAeA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RH1lNHOq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A8J1KAeA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RH1lNHOq"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id A6C1B138FC76;
	Thu,  8 Aug 2024 09:05:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 09:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122329; x=1723208729; bh=xNKkWx7spq
	eIMsc2GxyV4YNLE+UzI9aCWagrMeyvfBE=; b=A8J1KAeAoj5w4hMaLO7u+dKkix
	wYgQcCcUNWRm4Lf1p/YCeUK0kAetHc9qEpTH4AExv5WopHME8A7Up8b0uxN8XWZ9
	rHAC8yD9KmbF8qs1+UrxvK9bXQwd982yDNvJE5LEW9KFPE4ra74RB/+FlddHmpz6
	MKERjTIqgvzVgpmenvWvWxTfnEcW6Oagsh0usVQ5S37WJpwCRHwZBYyGVpgmgKhR
	St1SpWsTZ60UuGTNvgnqe9e+y4CHDR6koSpEPQQcpqlpq1CXPCgaUfOK37FW+8Du
	nJqf1eo7F9Y5Hiu1oglXaJAom22jgwfy64I02d0Xsi+Dtb2Rzt9WLdTII51Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122329; x=1723208729; bh=xNKkWx7spqeIMsc2GxyV4YNLE+Uz
	I9aCWagrMeyvfBE=; b=RH1lNHOqg3qw2TYMMp/CL4hEuoo8mK0Kuuptp2CFRXrq
	XmajCM16Q4Nz0hx5CUwLArUswVvmrkzBmw2LmSGWManw1viIAewlJgSIft73MJG3
	elU+JjJ0Xtod/CFH3/U4aXq7jtkOrPt80mPJKu/fvd/b5DbFvq0FqtdnjeoLzkuS
	4zx6pcSu7MMQI0v/tG0GuCyekSkzIfhf4/1pgWyUS7FfRYxP63r6h857UZO20ZSG
	MfqY9eaWIWxHVJ5q/kb4+rd1OA7mrizl6YpgnrYyUMwV+mf/gWyd+mVjqT4x9wnm
	WAz2fR+ZBRcQ5VhMptYwpsgp6No+8i6dSODEqM79mQ==
X-ME-Sender: <xms:mcK0ZlxoKk2s98ikKFMG_6xGDf8kZ2rEB8r-NNIzDjgfjGtZ5vhFXw>
    <xme:mcK0ZlQzlzl1f7nejCT_WVKQm9YvKHvhMQ6Sw1lVybTCNtoZXDaVqFKzfqMVsvjTP
    sjjT1k9P7EBiXt9eA>
X-ME-Received: <xmr:mcK0ZvWqTn5U1NeGhM6Cysp3aXyQlapOKLRKkdB9Y-pVFfoSpBvrUSEI3lLu3K7JukIhwF08-4j3G9FeU0q5YCsVNqC9xY_IPCrqoXOAFm45vYbG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeegieffjeekteeluefhteetheegueethfetuefgtdeuffdt
    hfekueekkeeuvdeileenucffohhmrghinhepughifhhfohhpthdrnhhonecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrghmvghssehjrghmvghs
    lhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomh
X-ME-Proxy: <xmx:mcK0ZnhU1snybPW5aIae70M3U-0KOyGwv_vTVSkaoT8SC6854i9hzg>
    <xmx:mcK0ZnCLCasn2pZp7nLkeV-ceXwnuHnmyzrqQTauMpsDttP7K4omSA>
    <xmx:mcK0ZgKbfZJN61ROsst5YyAglEYmqXhFu2pSzOuCgxzUXXAVNg_UlA>
    <xmx:mcK0ZmBdNE1Sc4iO9AiwKYGkVzVCC3FrnYgbwtV96jCG_cccazCymw>
    <xmx:mcK0ZuOeaXB-m968G1RVR3kmYE9O88Z4WHMDEXAdWuxwMbd1LsEqoTex>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:05:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 752174d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:05:21 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:05:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 12/22] builtin/fast-export: fix leaking diff options
Message-ID: <fa2d5c5d6b7b9018c3271a3c955852d1aeaf44d9.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HG+kafOKG4nj5h/I"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--HG+kafOKG4nj5h/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before caling `handle_commit()` in a loop, we set `diffopt.no_free` such
that its contents aren't getting freed inside of `handle_commit()`. We
never unset that flag though, which means that it'll ultimately leak
when calling `release_revisions()`.

Fix this by unsetting the flag after the loop.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-export.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 4b6e8c6832..fe92d2436c 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -1278,9 +1278,11 @@ int cmd_fast_export(int argc, const char **argv, con=
st char *prefix)
 	revs.diffopt.format_callback =3D show_filemodify;
 	revs.diffopt.format_callback_data =3D &paths_of_changed_objects;
 	revs.diffopt.flags.recursive =3D 1;
+
 	revs.diffopt.no_free =3D 1;
 	while ((commit =3D get_revision(&revs)))
 		handle_commit(commit, &revs, &paths_of_changed_objects);
+	revs.diffopt.no_free =3D 0;
=20
 	handle_tags_and_duplicates(&extra_refs);
 	handle_tags_and_duplicates(&tag_refs);
--=20
2.46.0.46.g406f326d27.dirty


--HG+kafOKG4nj5h/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wpUACgkQVbJhu7ck
PpQJ1Q/+JJcRBT+l7UzxiX6oFdCatkMgg7+kiD+hSMi08Eb4ncnUgF6uGWf1FzoS
4YAS8xhO4gu940xbrESnt04WZrZFn2n/2FSdnDUjMq9QmbUZG5zk50X0o/5hN1IP
JSaVUV+ZStHdW7gG0G4AmR7WT9A84HGqoGlE83Pr6y9PPqLsVR2FYzp0x9qlpFGq
jwIJr+/vqu7xI/5VlQUSIHCXi6oEgvb+3ghY+OtGf3rKpkGBl8zeeluejWTbBXfA
glLnpUi3gCdyNWQYmEO73VZcvEBwsmVT/xS/etEdAysDpWNK7Ko5DHqDMs8t9gTv
w2PMLF4ATUfPC5/LGSicQM72SNOjekNmKcVRiz5mv7v1Ca7EsnIzXVpEoIMr8x/g
MsBsXaBfeH8pGhbsMfkLjayMJrs3N8C5cgk/Rlm2Sxz2lIrIkgJCaMtwbvOjj1K5
u7CCfYisxmY50+siDQa55S7Vs7Jt1lgoafxSTEzTMFZPp7X5B/pTa2/ZHX895cQE
7U3JmhDi7yGRM7/bxh4giGw7La2a0J8HNJ0Fi0IGjiCqjm1VlfrclEIx2CRCNgnf
CDdnGeUoQ5i+ToFQlqSwGpXtZrSO4LHhSGa657olHw/4mR0Dicif1TC4ecMvE6Lm
jV4LnYDRt/sOYiH8Z02xD8or4IY5YWZ5W1yPsIa+j9CFKenVUQM=
=aMJq
-----END PGP SIGNATURE-----

--HG+kafOKG4nj5h/I--
