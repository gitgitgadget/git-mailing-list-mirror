Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD02FC18
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986729; cv=none; b=HiKTDNU0UVdvN+5FPbkMil4lNTcp6KYcDYvd2skFg8QS+g4kP6VM/iIy3fu8MTDrMcYSi9XitPLoGrDeg4XImb59DpFfPg3qMu4k2XrB6N5AopSD8YW2YuBcUaW/RZrbyA9csiU3+cxGGn0fRq6bUVH1LZF5RXNgW/eNgqaLJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986729; c=relaxed/simple;
	bh=a4UYU5oTgOdRXsPQfQWNDAejQS+pdoVEoMz8Oa7xOYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WEaX5wvDPp0NMLAaoHKgIVjxors1e0aLo3b+3dQoER/lB0yv7bAhi0cnWbFT+WUsuyc0i7hihoXZraEgDVrN9hRWMRuYvtfcpl5HfLe8aJyZIcKeFgEBxuc32ckPe1Dq14EN3aHaGjQSIKX4cYh0tj/aXfmqV+DxL9wUXJsPIJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dPyAR9zs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gb/rcT1N; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dPyAR9zs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gb/rcT1N"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 86FB81800116;
	Wed, 29 May 2024 08:45:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 08:45:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986727; x=1717073127; bh=eSG9/Sv/aP
	tLLKOoKAsckCx3k9HlNGqhzRzpg3U8b5U=; b=dPyAR9zsL/EbzteLw7FoHJ/bmG
	uRGO7PvxMY8rpyULhrB/rEub5MLj8AyCARFl34vmkOPENNiiyNBr10D272xot22O
	V8NYxBZS3FujkQtIGyybYIfefqyjFBhTYwIaHZkxpLiERw1r241PQzV1tmjyGLVA
	bwlZIyvfHeGciZhTdGQxMSLjcC9W+KV7hfVcCdtqooC6K53aa7BzZNmJVU9mFlhN
	9EkoWyobACczfbLLfu1sQlGxAMC4KA66uDlwzpOrVuc7vtcsfj3yafJuX9siSbhR
	KkSjvu2dxRcH5Y9z/0Ujl5tI/FYT8HXf2hiPTzknr4vKwBEg03yKwQrBQing==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986727; x=1717073127; bh=eSG9/Sv/aPtLLKOoKAsckCx3k9Hl
	NGqhzRzpg3U8b5U=; b=Gb/rcT1NuPzmcIZcKGzauy0JsbB01oCEbjljQvvBclVj
	iwL3vA1e2jPY64h5k8R8uPLxAmT8IfzvAu7teccJPkbiNr91NNqKJC5jhGEMH5mJ
	izTTok0ZFrfOSvhvPJOLwoKTqiHEUmP2dyJ+FzMN/NddDbwdulSHBBPW+hmtTK6K
	y1oWTqh+D5GMHzArJ9FVpgiUMRdZ1U7B7eB8rWTbWCliwLA6aqmRvAz6bpes67dt
	TrCK+5IPzE+PflLtpfx6602VY+ddOQhF642wIYWQE0IG4i5B4vAOfnuvFULNhMqu
	NeoxvP3Nkw4CXI+u7WCkr0eiSRioJeBCUjGJ7YQBHg==
X-ME-Sender: <xms:ZiNXZv02PFr1lQNC33OAwzTVANHFwwDm5-Pt7boDzV0A7OaZdfJwOw>
    <xme:ZiNXZuHTPORg1-qENHijdKjO_bK5HFrMQGaWHLGCFrrr3Ko7Yy-82ek79eSmnu5T3
    pa-EONmATKk4YOE4w>
X-ME-Received: <xmr:ZiNXZv60Dj39K1DBk2O2_PsFvCCkivJGiO1Yz-JS7ldQhR23MojjYRRYcEBwcyH_hMJSRVUlWpQvunaiPApBQrBHzzj68hW9-dozsDbppzKJFqX8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefgfedvfefffedvffefudeiuddtteeggf
    duieeuvdefiedtjeeufeeuieelueekfeenucffohhmrghinhepshhtrhgrthgvghihpgho
    phhtshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ZyNXZk2w6pijQpx2rylBn-PkJNO3l3Iu61kE7SR-jb-Gcdrva-sXjQ>
    <xmx:ZyNXZiEDkn8rz8Eus8aWMhAW05ElqSkuxGEYro77K656qflhVURfhg>
    <xmx:ZyNXZl-XTYFdwsXxd-cAyy2DNeHRl_3RPBsgWvXs-w8P_Rvcl8CI1A>
    <xmx:ZyNXZvleOiRUNlIjGE20MFsEPNrws5hFrIa-hO0p0cs7utstRV0qTQ>
    <xmx:ZyNXZnTzU9Eb_G5PUTjtng5LR5kt0vcWEJAjQKUFPL-7gXriYbwjclsK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:26 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e25543a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:45:11 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 17/19] builtin/rebase: adapt code to not assign string
 constants to non-const
Message-ID: <16d3d28243a0480c929ae3740db92ade238dd325.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hJg1T2lV2e2avyCk"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--hJg1T2lV2e2avyCk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When computing the rebase strategy we temporarily assign a string
constant to `options.strategy` before we call `xstrdup()` on it.
Furthermore, the default backend is being assigned a string constant via
`REBASE_OPTIONS_INIT`. Both of these will cause warnings once we enable
`-Wwrite-strings`.

Adapt the code such that we only store allocated strings in those
variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 14d4f0a5e6..b05c3b6be3 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -135,7 +135,6 @@ struct rebase_options {
 		.type =3D REBASE_UNSPECIFIED,	  	\
 		.empty =3D EMPTY_UNSPECIFIED,	  	\
 		.keep_empty =3D 1,			\
-		.default_backend =3D "merge",	  	\
 		.flags =3D REBASE_NO_QUIET, 		\
 		.git_am_opts =3D STRVEC_INIT,		\
 		.exec =3D STRING_LIST_INIT_NODUP,		\
@@ -796,6 +795,7 @@ static int rebase_config(const char *var, const char *v=
alue,
 	}
=20
 	if (!strcmp(var, "rebase.backend")) {
+		FREE_AND_NULL(opts->default_backend);
 		return git_config_string(&opts->default_backend, var, value);
 	}
=20
@@ -1471,12 +1471,11 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
 	}
=20
 	if (options.strategy_opts.nr && !options.strategy)
-		options.strategy =3D "ort";
-
-	if (options.strategy) {
-		options.strategy =3D xstrdup(options.strategy);
+		options.strategy =3D xstrdup("ort");
+	else
+		options.strategy =3D xstrdup_or_null(options.strategy);
+	if (options.strategy)
 		imply_merge(&options, "--strategy");
-	}
=20
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
@@ -1522,7 +1521,9 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 	}
=20
 	if (options.type =3D=3D REBASE_UNSPECIFIED) {
-		if (!strcmp(options.default_backend, "merge"))
+		if (!options.default_backend)
+			options.type =3D REBASE_MERGE;
+		else if (!strcmp(options.default_backend, "merge"))
 			options.type =3D REBASE_MERGE;
 		else if (!strcmp(options.default_backend, "apply"))
 			options.type =3D REBASE_APPLY;
@@ -1833,6 +1834,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 cleanup:
 	strbuf_release(&buf);
 	strbuf_release(&revisions);
+	free(options.default_backend);
 	free(options.reflog_action);
 	free(options.head_name);
 	strvec_clear(&options.git_am_opts);
--=20
2.45.1.313.g3a57aa566a.dirty


--hJg1T2lV2e2avyCk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI2IACgkQVbJhu7ck
PpSw5A/+Iv1NaQ/FIc3jtLx/UfBKOsvZQf95+swbFkwgX+LHzIUG65w0vzcXx9v4
jFtUJ5jATO8wpEfT0UK7xAKngomoPNTsG6cvY2xWnANvwLdLF6pMPF7M54c6LH/v
G/LTCauj7ahwpkwLY5nIZoiFpr52Rm697YC2ioIv/VQa/awOiLXgj8XvgsCY8F0C
IJiwUIBFEAL97WUvLCco60WEqfj64fJE8XxzoktVlcmWSs28CFiMJqm5srNR0jha
QGimSUbIB4iKoF1V+vr4WLqWTHy6/MhiMSD/Ru2N+/I8lWLljV1/hZPc4opMeCvE
A4ZtKPu6fP7CdRxvORAkXZ9HO1z44Tc556J0mDuCBXEsoSWaiBx9TR1fk4orF6sS
mk34TN9YPWbZToCGY18nIvgAo/Si6joxuHcus3CnhwslRRuaezQrUVOvSltmv2Xr
+4AgDgUoSDOwqPvEl5F7uwpUYfUCi3ykhli4HnAnmz+dAy/kbpnEq2+V+kU75Yt3
w65ffXxvMNvuhU4ILwwPA0Sj0lm+JM09FTFYsyS+3HV9EAGwDOu5Kb/8b/atm7JV
F6GWYL0OG8VCFviaGC9dgE7YRoz6uAlr5Rst4dVFCObeUkOdyq98iFl5tn8qprri
3TXEZcm8RoKeh1GsFTaIR0e3SQXbR2sGcYA3/6okdcAq+8qJzag=
=W5T/
-----END PGP SIGNATURE-----

--hJg1T2lV2e2avyCk--
