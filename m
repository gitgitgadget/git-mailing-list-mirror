Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1906B80BF3
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520323; cv=none; b=YTXpg2sUHjyw7jg62apwdwYequ+ZvtaohwSVL8w8KjWM14u7Ouj/GiN3I7fO6wTmtJNrzq+jhoTvmZ73Jmyb45a/bFYsg4KGBaIO+0WKTYJ70cjgxOCdbqAMRu/R1hvkzt1jO8UFRa98N8tgOQovy2Gm7K7Us/Z3zYoYlbcDSVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520323; c=relaxed/simple;
	bh=5JTYXzFQk62mTmsgeQkqpATIExe8gePNDzfOGW08YRY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s23SBuctr60nezAvItV5xgm/1G8mWb3a1otAe1L7PG0Heq/IYAhACiuP+KKwnYz3kUyvjnzLA40ZcYiVWcqYIrXgIyamTkkZYCshfNRyGJxlqi3Wa23RYDzETB86N/nkgUcL6WuPOOTEj9bTplpYTWVMpHU4ZLcUNLFHTWE0eT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rxDJLcGc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yuinbsnl; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rxDJLcGc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yuinbsnl"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 32FB71C00101
	for <git@vger.kernel.org>; Fri, 19 Apr 2024 05:52:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 19 Apr 2024 05:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713520320; x=1713606720; bh=GSrw647tXA
	LmlW53RqGKmtmsZCk1pmApVoVZpiGYsfM=; b=rxDJLcGcyoLNMIg6Ps601vkE/X
	eR6/KAIlNTtduOlwYcCRNJLsWb0ujFSTuoQda4vAsWOMUNLTqPGffG+8i2fJD6xy
	V5Hs9mJaVHK2QKLTzBVYQbPgp/1asq5gbbS9VHfH93FPAP3QPs1vnIn10d7OlSaw
	VV7kdWh88DD9zpvwQxE8XyCE/anVBlIZkgbpGVEqeEX+Lf6+d/Fr48TW4u85dhK9
	doXUyMrQJrLG/KoFbioFs2cJK/eFmrrZrSGxfI/ba0dVol/oryfnhOel2Kheyayb
	YA1gBkPeAb9lw4K5wFecZdWlnYhY+ggSVMFmBrGpFjFB3qeOlzSAPhlBGQ2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713520320; x=1713606720; bh=GSrw647tXALmlW53RqGKmtmsZCk1
	pmApVoVZpiGYsfM=; b=YuinbsnlVh+S/l4i1oPqLV0xvXGT5yU67z+mkCeKYz53
	xnGliBBNyJN9liAGGvwy1rMMd/aj9Bhm02YCtDfKs9E6+GwmZaX//2eGh+gw4Oo6
	AvaHtL0HyUyBTLHG9KjhiVRwBjk/s5UfGA5ev6tV80B2UTNa7Zlg4A43ecEMe78f
	xqAca6DwfjX/dVaoOVoci+87o5nP4Qw4eUWDpY8nCP6Av1EoQ8tthdl82eiw3Z8t
	bdTaaDwRXaXlmxL3B9lqeC03QzQ9jMNtwW5tSpEJ0x35kqkiImOKOBWLvOeGdUVl
	2f049EMtjSRRUIIJgxqCdIFxRgHtV5ZJwlHKnznhsw==
X-ME-Sender: <xms:wD4iZqB46Ev17OptJAy8kGbfGeT08hJ-arYv4aEaA0i9XxDxPeABvw>
    <xme:wD4iZkg40Wm1LR7Ui0-2MnK2d3vrof4QkT69RRnZeSqKkCVYgEhvQIGHVbA7yIjRJ
    G54YDrph4PfjzsV-A>
X-ME-Received: <xmr:wD4iZtn-ZVAzvmwplG_mjFkcV4uj42w6yi3A8p4cjUuCDnvQcAZF46OfXiF6KK0ec4rNXjGLNseHccrXoySDpi842G0kAnUK31HrVKDl5I_aKOEK7A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekvddgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:wD4iZozkU0HJxzRRLlDxeKbkE0goig00dZTwVvrQVbAGQa2QB62Q4w>
    <xmx:wD4iZvTbYYUwul5w6mE4EmKBkO5vubwfDgjfdFq8OUtxbOt23i0NAw>
    <xmx:wD4iZjZ7HpSe5UO3s1Kv-Cl1ZyipuTHqpKpJiZOog9SVuaVyh6QUyw>
    <xmx:wD4iZoSLElCFgUH7IzgNngNP0d-OSgd_Bg9F3-Omyb6wl59Ihd6prw>
    <xmx:wD4iZmJ1Vp5qx9fIOQlWSkEsEd205ih7Ba2RIj5Pfly_8GUaPXdZsGs8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Apr 2024 05:51:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ba95ce2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Apr 2024 09:51:33 +0000 (UTC)
Date: Fri, 19 Apr 2024 11:51:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/11] repository: stop setting SHA1 as the default object
 hash
Message-ID: <f86a6ff3ba1b910c4f050598b7187cc917e77428.1713519789.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvse01QyOjfPJvV4"
Content-Disposition: inline
In-Reply-To: <cover.1713519789.git.ps@pks.im>


--hvse01QyOjfPJvV4
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
2.44.GIT


--hvse01QyOjfPJvV4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYiPrwACgkQVbJhu7ck
PpQwiw//a+LVtJ0W1mOb7GqgoMYLkPgAIorQfxXSMiXIawEkKq4d/qVXL2ZqE1CY
Z759Auy9k9INjJUTztZj3sBYutE1KA8mkzMSAPcINbOdBLGiIYxVSpdIWuEomO5g
UU7VavFu7ZmNBaaBWmyHwpWolXvQbPkeFPVcfoclcWydb3mmFA9DubSMZs3YP9+h
cng08dbJiuDGsSjl7WutW96PbhlwvS68i74v6yO9Jccs1nJnhuU7Gqu047d37A1b
XwEmzq8e1REa9CPBoMZRmirgMK2KcQIfSmdJuPxg2TgZJPKafv/HSzgAV8ZLSNSe
G2rDvX/Z9lrmFXZ8vSUvOi4Mskvas6LG4k98jLJlYCF6MgdydzXhT1WB+KoEYqdh
aYOoU2S5IRXiwBNxrg7eflz2SYTVg61YJeAQP2Muqqb0MLXCUY0X7tdf26f46z/h
1J4xj24mViVEvSZyf3tB8QiGjcj/nvH6UkVNyvdKHa5nRGQkIXZ2BJl6QoM6boLi
RSstO6Q+IfrGXDS1I6DUJExArOXGR3FETpAUaXu/hOk6NOj69/oxgpF+Ee6cssrA
/LpkzQ+gu++FKFnyhKEqEAFAs9hVvcdUHKu78LbUc571y9LmgnVvf1aa3VlM90zW
xJmDFiCS84urFKkZt5/WNCna95LogCyDn8hV7tb68g0D6AzIFlc=
=DAXC
-----END PGP SIGNATURE-----

--hvse01QyOjfPJvV4--
