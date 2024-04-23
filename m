Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A496200CB
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848908; cv=none; b=TzJAhEp5Y++0YtwMExBU7A1YG+1PQI4y/0FT4qrcEM9WVKuvg8xJEyY75c0IdjKdpX7cW1RaH4NLBrVRD7GRsuqjFIHAKmGP9TaAwW1lBQx1Dxwev7cKNdxNAoAp7oDKJ9orXLDb4kKYG0upuvS2VMyBSckDuWcoL+awXQGqg+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848908; c=relaxed/simple;
	bh=LkFvzQ31gFEPKkDyg/BDaAYd014sozEQG4EVzp1sttU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXuLipHsavP3LbC0uceBzADlDHJbM9mbhe3DgoYHZsA00q/bDrQAlVbyFnhWwPpnFfDbNQ3IfNsEv+GJRHDA4nv0wZGX4gVrtYrG/epmo4d6/GxEaLup+YWjeVSggTuVNMLSyKMLS7MXs78I/G+fTAOp4GClu2l/j0aHFEejwqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=twGUd5+D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KtI8wYsN; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="twGUd5+D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KtI8wYsN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 74106114017D;
	Tue, 23 Apr 2024 01:08:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Apr 2024 01:08:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848905; x=1713935305; bh=qeA6lTHc3u
	pUQjo5QJeJ2VFY+gC/Vpk/hsdAwIYEDko=; b=twGUd5+DkNSictRRZlxQK3K/bb
	B4N+zG9PM9rnVElxguPoL3gj3qeauIZTeZ9e8aVEcQ9IslAwzn/1Y/6cZCcR8jhe
	7aB+iSodViB6yWeU0Q1I078BMnsO4lHaWqk0nQK6b1IsSZreI1uWlUEccG+n5szX
	aZTNDi8bbkB7M5kaVO1VGNllMwIHmueHjXgi3TvPKlKD8X1OAO4RKwrvcx4tP9OK
	tNN4B2NKnYZpsEgZDrV+wtvqviYS4VrzlD+yF5HpO+OZCoxJQdN0ak822vSLWN/X
	VqVw9d5je4UbG3wzz8U4uuu7Eg/VD4McuKCNBRjWjd2BmRlZCYFIs4vjMocA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848905; x=1713935305; bh=qeA6lTHc3upUQjo5QJeJ2VFY+gC/
	Vpk/hsdAwIYEDko=; b=KtI8wYsNawjqVkOJZQjlARf3Its7PFY6bjVtntKB94Av
	NcwSItuk/6xVZkojdAsn2qvBEvDojxNp/e658bQBpwGZaiuy4G0s4GKKlyYcq8oP
	gncu9MtvuCQMM/vrNe7L1TzdoRIW5eFtnP5pR04ElkhmIVcLnFEuymdXCA7xcC44
	7mHgCTWUZx9G2aMD8EfNZVauFuGg7v2v0CyHPCxfAql3vMRnEiV+YonuHtJsQnTH
	65XGAzyGMWYGuVXW1XAPhMwEQhSCCkDy5PnTJu4Uz5G00whY7VL/fpcahgrkoNiP
	KbGxXU2ajti035KFEwPd8IT2Y5cas+w12X5tG31zVA==
X-ME-Sender: <xms:SUInZqzJO0R2mJudnaYpjl6UgqcjbiPDu8tsBQuNNoZNn85AQUaamw>
    <xme:SUInZmSCKx908f_nfaLF31PU_5IZ_Xl7jHCtwC8SSaz8U6FgryTMbeaxBOmC6OocX
    cfHWsGKMR61lWdjBg>
X-ME-Received: <xmr:SUInZsW0PECOgFo3Jb-Hbo3ZaNx2yK5rXvG7MYACRYwN7fg0x18hzlwfpkdTpV8XRdiSZJk09x5tvSb5cg-loOGsjaS_xtWP2sIrOPBjWFAAaRdr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SUInZghiwaSTfmLBY9TZ2xS_SF_bAxwEFSK3plwOfQ9BllwNtQYmMA>
    <xmx:SUInZsCxDXAaQkcCs_Gff2oVHu3LgNsTVPQTIl7MXGDBHkB-tbXWUw>
    <xmx:SUInZhLLbeH-tFTQszGQ6niZoxEGM0YYmd7RG8pqjs3KhdKffHxBnQ>
    <xmx:SUInZjA0Z-MafPFrK_dTmcCxUxKiLlXhlgIpNGsTLTq8EOq_mRIhbA>
    <xmx:SUInZv8YmRkmy2dG-gk6E-18if98AXc3spuIVqsAKXIgVO0NQQAfwuPu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:08:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 61d4392e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:08:17 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:08:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 12/12] repository: stop setting SHA1 as the default object
 hash
Message-ID: <e8126371e1b8c4292d5e65a6a7822b56fb8e6fc5.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vICZAqG5karAo8iZ"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--vICZAqG5karAo8iZ
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
2.45.0-rc0


--vICZAqG5karAo8iZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQkQACgkQVbJhu7ck
PpSTYw//b5GpMdrNbp+c1RWGy49rFi/vyc79fHcEnr+ayhglLgY3BYP6Fgc5S70c
4PkDHS57ndvm1Fl7w3pj184nd1MwwT9HuRMdC8Un8ru0H4MsZJa73qxfC95S8lnm
PPllKS2whgdXf4B+KBZCkUIJlibn4+d7jvp39F6KVgQ8tIXNLTChi1m567OtjC97
N3WGuFgxCVygfSY+n1uC7b+z7LnNET/IFOyWYR1pQS4RXgh1umJXQlE4ud+Uk7Wc
RXySPqDjfayMpAZbaVR23BkrQjkv8pV6YXSHsTBqXGF1Ej7vCprtYPSFhrSbcAQW
84Wo59vgl9q6v6EDB2Kk340LIogHFI8NMWmpZU5ujk/RdmNcId8braWcK6YGKsbm
rvs6w3VcMQCB5PNMy+WndymV7UjlrcaIr+JJ7fCAPEqa1tROfq9GKCZEAEEUtlhz
y+hUCLHxKwox7d55JNEb1Wf2LoIbj4gt+btISSHeaIuyhrOlMc6LTk+EIyYt9Xz5
jVdxJUI3DvsJC6JyJSQhCNoe/A1yuZJ4RujnNEvmabChX80xMcDP2mtJOCeamt8G
wmMlT6NRHFca+a//ZERXOdj3TR7T11VeSmpmFPXeJkByjLfM/hYXde1Tj+ROcIhT
IqKj55/bDOv51aYyyTooDISr7I09ClmIJxWfl9AIhqKHHxQ6bxQ=
=3cCI
-----END PGP SIGNATURE-----

--vICZAqG5karAo8iZ--
