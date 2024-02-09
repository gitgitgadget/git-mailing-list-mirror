Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D42C65BCE
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463411; cv=none; b=klam9VNqgtOA0EfSbK43Oa/UJUVJa1lJ4n7vGK2ax8f8v6zzwId2s3lMtBPlGI8JdWI7RJ5QeuMe+deHHC/mTmyvNNpr2U7Nbz1jyup7UDBSZgZ/3AtIW0oyiD1DtUk/Z8Di/ILibNGexw8TxeQadbl3b/YEo2NoWUoHRc0UJ4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463411; c=relaxed/simple;
	bh=FnsNsfn/FKbJ3k+BCAXFfqE8ngkXcwETwbFsmayExvk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPFm18JZVf7LCrvXtkESDyXdNWFqpIRv/Q1PWD8FkBIG5U90e1fu+w7NETAUYMNYEVDulvSDgCSMEqitadn8feStYH4JflZJxVyxDulLfjwyaEBKinAKP24dZJy+vjYb2BDKmze+bzD8xDDBpkbNBKrCCYEHVWKOtB73HV49/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WbCov43N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pZzlqpPo; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WbCov43N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pZzlqpPo"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 8570F3200A67
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 09 Feb 2024 02:23:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463409; x=1707549809; bh=167F3Yrh1N
	Vrq/xpqRV0pGSHaJ5OxzcZwB/FNXd/olg=; b=WbCov43N+cQ1mjkWx+h/PVojQr
	VZWZ3gjeXcfTl/gcbl27sy94MD7/5FsPYjwWCVviMtEpS9Zx7PPICC2G0j/RnZEJ
	gZIB5RGI0Kzzo011df6sk2ZyPhefeBdsO18n5KF9PaOvDhAhh4AcQxukhtq89sMO
	tSz/t7Y3TugLMEP3zRaGntdjHyLroaWvMlcecErBlFI8DWeKZ2RfEBSGCIHHIU7z
	uUGN1plSnhZk+P+0BLxS/IkoZQCrJ+O+d2Z0AYC6UZFKu6PUvxhbRzUZQxgcZ34J
	i2I1wP2asHHISpTl0MOcVoqx+qCi5A0HSvOXNM1Z1Gmm0KIFs8Ur68oSk1hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463409; x=1707549809; bh=167F3Yrh1NVrq/xpqRV0pGSHaJ5O
	xzcZwB/FNXd/olg=; b=pZzlqpPoAYa5gasFxy/u00L3sq1jgso9nx7MKknkmPbD
	jVZCbb2pwSQHyZ9usYTk1D1VSZrRujd7VvbN6kl+yOpKyeoyg0nUvC47wh18zTr/
	lq+heI7t5RQej/iMlyBpFf/hFCCNd+4UM8pEtnRksUGxKQHMMGYnsNGIDUXzlMPy
	mTBvsDH4izpOqc5gZHtKsBq60rMfdk/XPoK+PG1ze6mWMDp2bKWLtx32sbaFcUOG
	TZ++x42R0x/LNqiq8ORE82frYC377jS73Bo79MZFbwN2p5djxi/sP4RdL2+KiZ+9
	9PLWjCU4jUaSRkxCLF18nXTQOhNxFtARuNxhnLz0Rg==
X-ME-Sender: <xms:8NLFZYNTr9wjyngn19rbADma6nt8ZL6gbuahiD3yZsrILM_KrOKWFg>
    <xme:8NLFZe9caFoOTct8vztbA5CslYcvFX5d-AnhWaASp43Zafz4n4jSp9jFgKc2Ln6Yx
    L1XByhGrWcFeFN49Q>
X-ME-Received: <xmr:8NLFZfSjoicRtslh5t6PWggdjD5ehmeO2JFZdF7ygH3pKDpkskGKlz7vt_9bTifrJN8l54FzjCXKqCIGZSdGPqF1JyRI5NvcS81Rvxzn6TexoHc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8NLFZQtzYAHR4_1IdaUKkuxonkCgffwm7GxGUSOfmJukk9AJA7CDfA>
    <xmx:8NLFZQei1BG7fzk-HPzhlk3Uo6cmQd87FRLzPsqwhRCzc366ysBgyQ>
    <xmx:8NLFZU3jdZIsc6wPLmX_O4GZZgangMHP9ma4z8TsLJkwQtQp0EFZMg>
    <xmx:8dLFZYnLXIY9iVlD5BJqiaOqirHCdiMmaeu43AlF5MZEamxOXW9Hgw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 219306cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:52 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] t1405: remove unneeded cleanup step
Message-ID: <25cf00c36f715edc6b4e86001a36a093f4c4b2e0.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jIh3zPRBoaAn7Mjr"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--jIh3zPRBoaAn7Mjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5e00514745 (t1405: explictly delete reflogs for reftable, 2022-01-31)
we have added a test that explicitly deletes the reflog when not using
the "files" backend. This was required because back then, the "reftable"
backend didn't yet delete reflogs when deleting their corresponding
branches, and thus subsequent tests would fail because some unexpected
reflogs still exist.

The "reftable" backend was eventually changed though so that it behaves
the same as the "files" backend and deletes reflogs when deleting refs.
This was done to make the "reftable" backend behave like the "files"
backend as closely as possible so that it can act as a drop-in
replacement.

The cleanup-style test is thus not required anymore. Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1405-main-ref-store.sh | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index 976bd71efb..1183232a72 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -33,12 +33,6 @@ test_expect_success 'delete_refs(FOO, refs/tags/new-tag)=
' '
 	test_must_fail git rev-parse refs/tags/new-tag --
 '
=20
-# In reftable, we keep the reflogs around for deleted refs.
-test_expect_success !REFFILES 'delete-reflog(FOO, refs/tags/new-tag)' '
-	$RUN delete-reflog FOO &&
-	$RUN delete-reflog refs/tags/new-tag
-'
-
 test_expect_success 'rename_refs(main, new-main)' '
 	git rev-parse main >expected &&
 	$RUN rename-ref refs/heads/main refs/heads/new-main &&
--=20
2.43.GIT


--jIh3zPRBoaAn7Mjr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0u0ACgkQVbJhu7ck
PpQ+mBAAq2av2KuEvskN2LaXt0iiItyxXZjuLtzh+gN2izu1yTJnxEEyoa97U+9K
6L+npIRfHpN24bglchQemtbx4IVFUFTTOVKfXBM5VeoBTjTpve9aHlXyrmClqvRh
iFPDQltZI3PEiOLuIagoW/gHJrZA67lfg7jGzu5mIXaKFnueCPD0BMQfQ76skU1N
0+VU8PcnUAnoU7qywMJdaxuv2jeiMYmcG1C6FO3Vy9FneToPD4EVNN4MVm9IRhUd
WU+DJfzFXVw7jrHAjdeuR6hMs2jwJGZCZbqnN2VZrPKhpONkTw3PR5uQA6WSQ31E
kpSzR6iXD1mLMfTftPJ8O8QjyVI/WT0/mZdRoZgCTwYkyPQqtUXJkNVuYnKE0RPb
bSoDQDHFBfYogfSc9muyyeZkJIupXKwXQM2NLsNXBbwM1QrNslLX3UtjSKX3Cuhk
EPUsU+04VJZVX/I1nLsHX8FkRZvoQpXHGkk1VAGdTwmUmdHK3KppD2nC3phhgixb
liyRoZ71WDtveLuzj/7OiBDflbG7ZzGzgmr6Mv5jl5vl6sAZBcDJmd41P0VDSGTv
R2e4VLWC9JLfXPeG6ElwrjIkqrWAg0XJ8iXWK2q6SCOcASucw9T6TYxwFb7yaBvf
zNM0/3fGqbgeaWwHcdjIL1uANnVtczIALHoeG7h4NINoQgQepfM=
=cLP4
-----END PGP SIGNATURE-----

--jIh3zPRBoaAn7Mjr--
