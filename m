Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A88205E20
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372503; cv=none; b=EhsJOKpnGO3sgsrgRZf7qBVhc+Fniye83+OjfKsG6Mq13tybfAClSD43WDhfbV3rbaFPXgBtJDmJVAJtsZORwbquMEjIxKE6KBLR+vJ4XIfcyEXXht8gRgDHqIr7TECL7xoIE42aG41rC1Q54cyddnZQEgmKleP8tJLzqrb+6A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372503; c=relaxed/simple;
	bh=6/3q5ye10/q4hGO/MK7Q5sExjAMSk8QVkCB+pG8VJQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zc+XbfclP6q9R1D38DJWP9L/4TWizU3U4zo6ymIM2eoM2sWNwf4SonXBkhrOzSHlAesxPY9dKU2Br1R+JMKUrYLFAn42alfXI2oIB3Q6kWtVjZh9LEB9VzXjhr67r3iFhA7ZtPWrRsyHIDnHtVqabCx+xQ/JkG8bkVvpN0n2Yts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tL4xVTme; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLrBF6F2; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tL4xVTme";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLrBF6F2"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id D8E411380388;
	Mon, 29 Apr 2024 02:35:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 02:35:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372500; x=1714458900; bh=ghn+T6IGcB
	WBTZLwJu9fsAQ+aOJ+zVZ845wD6gsMkd8=; b=tL4xVTmeLv1iqkqbzovep4SzT8
	Ir2jSdcosYuJaop3fTNpApRUrl9vYDEVtrGwdo/16dv5dn7JRLFCRQJ6oH1I9ivz
	ZTDnI5z+l4cJCyxnGnWTy34rVdmBM9BbvcQhREgT7GzJ/Y8pdnadPh0doOsifHF4
	Ao2O1tpsphiaJmqT5XZWBD0ILIDlHF4x6XyAykqOFNq0mZRiHvPZCcJ9GgvNto0h
	vIV8zFtF04rRz7iLQeB0Tfw/LRU5/PIqTevWS822734IXJ+ndCzofI/rLPl+JuZu
	qHfdJTzvniv1c0ah0xaRxewoLH3b9e88Rr3tcYBdqf+40BVNhfjjTqiQKmRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372500; x=1714458900; bh=ghn+T6IGcBWBTZLwJu9fsAQ+aOJ+
	zVZ845wD6gsMkd8=; b=eLrBF6F245rQNUuk7V6jad9bM50VRwQQU+KEs1PQ8TgS
	zwRbLZ0jQ0Ihmskyt8ZEvo/cTsom5BdTnrUpx0m7ZjinwRM8QDNeN4tR/KxHyr+c
	xrG9rpaGW/Snz3ge/SqXdDNa3bx4tdUxdbgcM6hlhTC2vFKI/vmFKtIX0rGxlkcK
	3KCX6jpWcDM9UPjjwuLkF2+EBP7zO8wjoKgbl7U2fY9UWca3RPY/r37PDQyt80yb
	729doaXob/g6G/SJXRBZCH7+1DoBLP+aCiP4d5f2xA/gMEgNEWTtMa2Dy/3OMuPC
	eXxNJLqgeDOSM6tndMMVMhpLY+LcBA0wQf2NABO0OQ==
X-ME-Sender: <xms:lD8vZodG6fVSIOecziM9Jq4a30kmEeyzTsQ-p6oPXNefjTwtt1r00Q>
    <xme:lD8vZqNtGqhZVAZwDqRiBuWfEl65s-prTrOlotZ8ELCtju3nglmgN_VxB84Cx5VsP
    KOk2wu17N7RJgEhmA>
X-ME-Received: <xmr:lD8vZph4ZbXNnpb_Lvqe0yLZLr9O4RVtjLIyKSkzXHS8SU8J3aPJHgpChGLwtUKhiUb_Owfy8BTYjUDifQ2NG_jz5Do21eP6OKBN0bWcJVUr87ZR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:lD8vZt9UkKdbukR8TmbLNfDEr68vN35NIK-zcCdwNNEV655J2P55tg>
    <xmx:lD8vZktBjOCCXRVfAx-sLAOmBADSbXpCpce0OjWiHr-1L8L2umhUKg>
    <xmx:lD8vZkHLa1q4eybx3CSxsqjuO96NHhzN53TuP1akCrn8t7ijTd0HmQ>
    <xmx:lD8vZjOCC4nT0gRyVpVQNhLniw0aqZpehJdDUclKNdN0VUfAEvQvWA>
    <xmx:lD8vZmIEqqPA7Kwc9wi6klMmfc5_wEDXeBA19nQCJ-FLhI7HewBDm5zV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e57f624f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:40 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 10/13] builtin/diff: explicitly set hash algo when there
 is no repo
Message-ID: <7577b6b96ca2d1d7070ff92e13fccd14d2e5f86e.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QGYc9x62jr34AWAw"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--QGYc9x62jr34AWAw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-diff(1) command can be used outside repositories to diff two
files with each other. But even if there is no repository we will end up
hashing the files that we are diffing so that we can print the "index"
line:

    ```
    diff --git a/a b/b
    index 7898192..6178079 100644
    --- a/a
    +++ b/b
    @@ -1 +1 @@
    -a
    +b
    ```

We implicitly use SHA1 to calculate the hash here, which is because
`the_repository` gets initialized with SHA1 during the startup routine.
We are about to stop doing this though such that `the_repository` only
ever has a hash function when it was properly initialized via a repo's
configuration.

To give full control to our users, we would ideally add a new switch to
git-diff(1) that allows them to specify the hash function when executed
outside of a repository. But for now, we only convert the code to make
this explicit such that we can stop setting the default hash algorithm
for `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 6e196e0c7d..58ec7e5da2 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -465,6 +465,15 @@ int cmd_diff(int argc, const char **argv, const char *=
prefix)
 			no_index =3D DIFF_NO_INDEX_IMPLICIT;
 	}
=20
+	/*
+	 * When operating outside of a Git repository we need to have a hash
+	 * algorithm at hand so that we can generate the blob hashes. We
+	 * default to SHA1 here, but may eventually want to change this to be
+	 * configurable via a command line option.
+	 */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	init_diff_ui_defaults();
 	git_config(git_diff_ui_config, NULL);
 	prefix =3D precompose_argv_prefix(argc, argv, prefix);
--=20
2.45.0-rc1


--QGYc9x62jr34AWAw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP5AACgkQVbJhu7ck
PpQYNw//YhejMwwulcazYuAp5M0Gbk64v14/SlOq22NgRdwB2Q6caPl13QnM/eR9
DFdrZ+UgccRbi+ppBJABgzTbtbUJDxAF2OZgS1zQuwW7kpDR+dahBmN7oFbP5bzm
P+/PVKiCNxjGhefFkIpwP5J2X+/BFTSw7tL+HkJ1DZeA6V8AAOuPam3hKBFtGg5a
kr8nRmryRVqVm2/4MT4jDKM7k/T/0snE3TgnmvG8cuDzAIYhwmPllJ/SMnK9BDgp
d/L/y3jf8UczX60VubDX4k4IjscZIDBBvc6/dEA+vbXbgqIDlM0TbFeuSKDy4LEE
VMMbFZqqRVlixjGylnKOqcppKYR96Xwf2ZKcCZhbOCDYPjyKNCmDqG3JmNS+Jc63
ic7p38FNWnRZ7MfA2j7Tn4H3LsNn+vJAiI57LGQIMDecCqmfvY/FeHCanrGJffA5
IBHOvbYp4c80xEsvvSn87POHujDbW4v+B3ZKYb0iyEPdkEtE93IPBJwr/0fXDhra
sex0Ij3wtjg/vRi5K5nkR5HCC6KB32MeulM29t6YdOVqgmJddmPMEjZp3rNN587B
WT/HzgmV5eUKiVwZdYcSN2NpkkIatiL7ARjtYtRb+ucTEU+5iZgAD7vvQ7adoK6Z
kL2n7IiOQWfUZdetCe5cgztQr3v1yXgLQXL2LCG4FR1uzdt9Umo=
=uJe6
-----END PGP SIGNATURE-----

--QGYc9x62jr34AWAw--
