Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E0114A8D
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372518; cv=none; b=qnkMD5gxj5uF9c+3hD/AG517f7LS8VdwkX6EqOZwg76PkUp3tYu3V/UCTZmudI7X41bruGilr95D/xGeu4p4IBEul9/fdJkKIhGXZBPsQh3gP9eYrtYEgeZDaySGVQ/6LM4epcv4MSheafxEjtqu87dzK16o7WE+aDf5iecBnJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372518; c=relaxed/simple;
	bh=9Kcq8ym14PF+xovVHJ6p85QZ58aqIZ0PRjj5S/Xq90c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKnzBW7KpsgCra35hdl563LkfJJadMibK3vI+4dhlh0M7wx6wdeqEty66nukiHwSuOXfm3RZBc94fh0GN+mZzx0RffO3LwHd1ogtqhg3aeHedh8stfCzPfkI72hpdAEHx9otjp9hh/IiMx6p1voLdn/skgK2gUtPz1vhORLoZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p/xw/bxi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X0Kw9oiE; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p/xw/bxi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X0Kw9oiE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AF53B1380385;
	Mon, 29 Apr 2024 02:35:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372515; x=1714458915; bh=7CKxVZY8B7
	Pb6VP9IqjC0olkczPIa2rq1xIMq2/L854=; b=p/xw/bxiklapHC/7asdDtGSJOX
	h7BwEszbOLF5AGa/nGWhz3G47Q1JkGHIjmKls4zBmMByrPsqnkhby2TZpVf0IYqS
	hInsPSM/0rwSsDywL4ve2KfC7rDyYiOiKTmA7dYqjC5JysX9jQj2P1ZQALVGwPJ3
	gfHmckzldH/LGx8K8tx8V6wUXaLNOlqiAjRMCe1556bpd3rpTofcNp2eNrshapmc
	HtWHF1bB16KX3dwT0vczhA5N6z9YOVWn2Lkxupz85Uf3SxsB9c2JisGBbEJ3fzOe
	OFBHfwpaq/K1DikaiNQ1/lDzgbBQm3yNALKQhZrlw9kf4xVGlYJcMrckaPBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372515; x=1714458915; bh=7CKxVZY8B7Pb6VP9IqjC0olkczPI
	a2rq1xIMq2/L854=; b=X0Kw9oiEbnQdGkEtAebwVqOI/sWj356HOZfaY12Hw4hZ
	GfjWO38H2C3RgBKIDZKcd3QOGf4E0cs/liO2wVtCinDrWPO+JsWrnqCHrdZPU75L
	UZMe/V17036Qn5l9KkJF/0eNGbIC6zz/Y8t5RdxuB9A7mVJZDUaEUN7eWz2oh2Ge
	SZrJJcDeBw7qAm/pCOsVoOFFJOeFoGnqjAV9eY/wLHfwBzCh51Kn6n19l6pkzJB8
	+R5QBBgsMPwBTwKqGgRRLbVo6R6mBPgkSw7dLTo8l6VFhqKnlNXtEWliRTs3MO5/
	dNRWxaZzRGUdHS01jyVo2PJsHdjSq/U3pkpfED0mdQ==
X-ME-Sender: <xms:oz8vZpW9wkDadJ7FNaxLGcn8vwIcxlPI0QDiLeKzW65ZTa9aLezBNw>
    <xme:oz8vZpmykMzjdRLADA8sv6LDzNGwsKcLaDLkT5DM0pQi3KXgPdC8dMDaeMnh-SfYU
    YBra94TxpHq7zACVw>
X-ME-Received: <xmr:oz8vZlbZfWQvtTcafyRVQF8X_v2myrya2HMkVfHGVkasqva0QPZp7FI5czR6LklkwNcNJHupidmlzIexAwkzGnoAshKhFZHgcxxlnVic7pClRn07>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:oz8vZsU5BA92WHB5-LVuyVJkwnk3yaMn-7jp2VLZ0ZErxXRqgz625A>
    <xmx:oz8vZjlbk4SP3Z7a2gyqWpUZ6ZHb0J-MD6BHoeDWk8RaW_eBuGmi1w>
    <xmx:oz8vZpepJd4uruX2-U3PMJ4LoSZePS6-9jXRbqGb4ONE9K2EbgzaJA>
    <xmx:oz8vZtFwOCiS9eqtdREyuFA4nXBRUPITSioOjmC3r8p7T6KFfe4ctQ>
    <xmx:oz8vZsDofq_bErvgnv0FgJXgdD9b4HzvuMciSZlnXuRbG-3l813qy7Eg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:35:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bb257c41 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:54 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:35:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 13/13] repository: stop setting SHA1 as the default object
 hash
Message-ID: <95909c2da57f6d9814561c94d75be4582195bb5f.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3mglyLHSmk6DGUO4"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--3mglyLHSmk6DGUO4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

During the startup of Git, we call `initialize_the_repository()` to set
up `the_repository` as well as `the_index`. Part of this setup is also
to set the default object hash of the repository to SHA1. This has the
effect that `the_hash_algo` is getting initialized to SHA1, as well.
This default hash algorithm eventually gets overridden by most Git
commands via `setup_git_directory()`, which also detects the actual hash
algorithm used by the repository.

There are some commands though that don't access a repository at all, or
at a later point only, and thus retain the default hash function for
some amount of time. As some of the the preceding commits demonstrate,
this can lead to subtle issues when we access `the_hash_algo` when no
repository has been set up.

Address this issue by dropping the set up of the default hash algorithm
completely. The effect of this is that `the_hash_algo` will map to a
`NULL` pointer and thus cause Git to crash when something tries to
access the hash algorithm without it being properly initialized. It thus
forces all Git commands to explicitly set up the hash algorithm in case
there is no repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repository.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/repository.c b/repository.c
index e15b416944..b65b1a8c8b 100644
--- a/repository.c
+++ b/repository.c
@@ -35,8 +35,6 @@ void initialize_the_repository(void)
 	the_repo.parsed_objects =3D parsed_object_pool_new();
=20
 	index_state_init(&the_index, the_repository);
-
-	repo_set_hash_algo(&the_repo, GIT_HASH_SHA1);
 }
=20
 static void expand_base_dir(char **out, const char *in,
--=20
2.45.0-rc1


--3mglyLHSmk6DGUO4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP54ACgkQVbJhu7ck
PpTQjxAAhtqKf8yw+36U0QEdnSVZeSoTGPbBVWIpkn2Beq2m2e/UcuJjTFru5Nbc
UxOlvPVTVvqSf61YCe0vxu7lcqEQdeRKoY8Eb9PnU1gAgEn5nTVHWbUDOI+lDO4t
NRhQ3iAvba7ZWg7gplKD9dj20pddgV7yAZY135wFKx3WryCQrcE9okPlcBUHUFQ8
nkXBV1Mv/QCh4OhjT+q63xUJGYCtNmKA5fM5m9cxjFGDGZZmyj10gQetv994d3Go
a+TCL9fbFZFUalE+VftYpzIjcZdDWc75FvW0RfOfbDhhgd7EZoLkgkDUPpooRuvM
kkpOfKQGEdvm96KENLIx0j7eK/8ngPvOsvZh2b6d2Ld4ODuxSaXc5OJuQl+EZnMJ
M8ME+QVTmhI5w1QSFX9Ee+5NmW9s7cpkzmRCdh+klI9YoS5V/9OcCJM4X/CPZDHU
8eS5wXA6tGEKrAccX5N9gL+uRNWkCt1NsyjgQY4q+isuhIfwATulXqzR7Du9J3gC
4u5H4JMPe7CY0XB0+uQtTkGPbAxg8SxqxYdXeDHV7nMhQreinOas9GgXK6Tt/TKv
2/gMp5Rz4K4sFJWNXCEP6uBbb9XVtLH+LCrsMgjU2VFBiA3/KRjwWOrzDUsLn67r
6Sbs25ZNk09PDA6WL+Y+8xT7pfEAZMQGF8wOfCbB6wrekquV3iM=
=iAWD
-----END PGP SIGNATURE-----

--3mglyLHSmk6DGUO4--
