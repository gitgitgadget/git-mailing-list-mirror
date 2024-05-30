Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B9F17F50E
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073519; cv=none; b=MFDwS0DC8tVUySfRf6/ylpR/c4GJhmFnukeKonx7S3eYFQmavgDUDxpuw3p7Ku6ckUw5gC5I1d+0HWI6NTiBTDSQMkPXBbpo7j3KDlgvMVbBZZQb0xiEu5djahn4GCeSl608/odyfoCSZ8lo0ZbVsBs/Hhw/WL9Sn6nhuQcuXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073519; c=relaxed/simple;
	bh=oiMOjytGEh41qkvgLPqJoIpCqmNRG6x013gGAQjD/Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=scWRHCWijTTZ+C42PggOIiVMjExWQ/Y2EXDKWEvcdt+EZC67cTpeDX/x3po3nFN7Cvnh27SswtfU4DvzMxwgQVuDR7ZrHF6TJDZaQyySqIrt564Z5RiTV/gfCxxnt89zTYpJtNe5M7ThuKnwpuECLQV0QizNzouY9tmDjy1juTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lKpCrnh6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PwOaHfHr; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lKpCrnh6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PwOaHfHr"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2321A13800DE;
	Thu, 30 May 2024 08:51:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 30 May 2024 08:51:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073517; x=1717159917; bh=Z2qOPKSvKD
	xSv4gumtVnqn45hmzZZcRqSsb9bLcc8NQ=; b=lKpCrnh6cWqLnD3FSgmT7xQ43G
	4rVnBg0B1nuxhvaJvMJ9sstqK+ksA5vTEbpTM+YUrWVZE2CrZnzWLoF3kgaJNsmq
	tJg4/GFUOCjemSFwEGdSwwjf0sYnm5LL21oJZ/LUNcnGjAM2iqm1193Dl8Rew9so
	Blvg+31U87AcUAU3pyay3+sqaXom7WhcMDZ96TzrUF0Idp7Bofod6ip0Y+PaUnjd
	r3l6MGvyl2brez7xvJUkzW8S91HXd8NeHlvj39aWsC/mYkWP+Vb2RG89PKGZEBEs
	OnHqE/DkiQDFjnyzdoqlAnKupiZXs2ZJuAheeVVlmfKLlVl8ZA0wzbHhHnUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073517; x=1717159917; bh=Z2qOPKSvKDxSv4gumtVnqn45hmzZ
	ZcRqSsb9bLcc8NQ=; b=PwOaHfHr0KH9B8f3YrqTmMftpOXnWEHaMQew07+iXUY0
	o7hxchZXQRuPb5WkeCuXh7r2ObtgE7D2bO9kdYcrTSig+KImQ9fK7Jzme8JvGOSn
	UpXVwlPQ83+DU6egDgPx1oBq5lr//ZiMTNwV3r3wqmQddFSQTSWQ+nm6kKoY98g5
	lZFp1AiNUwj66Pgdb3OGtPU/g7eVlr2xatLwiqceBB6jXiNBbbA7mKKT6co5VawO
	UDH6bBF+OqUDryFMxTxkQ4dM/QwlCcq7G45X/oATbT1uDkyYn4q7ip8QWhKbO27N
	RsKPW58WE+mMVjTJ3Q+2ItiOgXhWpmH2sX3r2zaPqQ==
X-ME-Sender: <xms:bHZYZjuy4QcDt-nCPPGP_af_flND2ybwz73kH2TEzR5zy_xAI8PHNQ>
    <xme:bHZYZkcBlOH7zS-8-rgl5SnwoicKudfOkgU0lXLXTKnNiOND8HElMmyUzdICdw2EB
    9945xqkXlBITOEcYw>
X-ME-Received: <xmr:bHZYZmyt_ruqskxyIBahwug3LnZmoa1IhTPVMC3tBWyTZH7IcSDePMxbWGxjfOvQXZjM7EUeYVscPts1BiWQvDYxGf3vE840zmZZ0diyTZl6C69_xQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefgfedvfefffedvffefudeiuddtteeggf
    duieeuvdefiedtjeeufeeuieelueekfeenucffohhmrghinhepshhtrhgrthgvghihpgho
    phhtshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:bHZYZiNLsqeVIIyEZsfVMkq-7o-Xb-uxVDVSvwrHXZQRpZdTGjtu8w>
    <xmx:bHZYZj8083BFAcfCnS5bWiyeNTT85_DQYhe-g__X7AYTdsnV216PJA>
    <xmx:bHZYZiV1eOW28pJ6gs9KZF4HhZjryBDGVz4RCQl_AX07E1ErUmUNIg>
    <xmx:bHZYZkewQnQyVADNhECbfDWu2wFpdTqJr038ihAEhv98d7Bf1HSrug>
    <xmx:bXZYZmZ6SjSm8TMbyO1UMneC2h6JFXeV7nAQhSLvpmpjDeyhLHORfQxG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 69bb8213 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:51:39 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 17/19] builtin/rebase: always store allocated string in
 `options.strategy`
Message-ID: <3552ab9748bec8efd62145f590e888aeed7c9b43.1717073347.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rbK4V/a1PZnuPQcG"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--rbK4V/a1PZnuPQcG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct rebase_options::strategy` field is a `char *`, but we do end
up assigning string constants to it in two cases:

  - When being passed a `--strategy=3D` option via the command line.

  - When being passed a strategy option via `--strategy-option=3D`, but
    not a strategy.

This will cause warnings once we enable `-Wwrite-strings`.

Ideally, we'd just convert the field to be a `const char *`. But we also
assign to this field via the GIT_TEST_MERGE_ALGORITHM envvar, which we
have to strdup(3P) into it.

Instead, refactor the code to make sure that we only ever assign
allocated strings to this field.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rebase.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 11f276012c..26068cf542 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1063,6 +1063,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 {
 	struct rebase_options options;
 	const char *branch_name;
+	const char *strategy_opt =3D NULL;
 	int ret, flags, total_argc, in_progress =3D 0;
 	int keep_base =3D 0;
 	int ok_to_skip_pre_rebase =3D 0;
@@ -1177,7 +1178,7 @@ int cmd_rebase(int argc, const char **argv, const cha=
r *prefix)
 			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
 		OPT_BOOL(0, "fork-point", &options.fork_point,
 			 N_("use 'merge-base --fork-point' to refine upstream")),
-		OPT_STRING('s', "strategy", &options.strategy,
+		OPT_STRING('s', "strategy", &strategy_opt,
 			   N_("strategy"), N_("use the given merge strategy")),
 		OPT_STRING_LIST('X', "strategy-option", &options.strategy_opts,
 				N_("option"),
@@ -1488,13 +1489,12 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
 		}
 	}
=20
-	if (options.strategy_opts.nr && !options.strategy)
-		options.strategy =3D "ort";
-
-	if (options.strategy) {
-		options.strategy =3D xstrdup(options.strategy);
+	if (strategy_opt)
+		options.strategy =3D xstrdup(strategy_opt);
+	else if (options.strategy_opts.nr && !options.strategy)
+		options.strategy =3D xstrdup("ort");
+	if (options.strategy)
 		imply_merge(&options, "--strategy");
-	}
=20
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
--=20
2.45.1.313.g3a57aa566a.dirty


--rbK4V/a1PZnuPQcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdmgACgkQVbJhu7ck
PpS/8g/5Af+r7CXRH5XvIlhpdauH/AfKCt5yAwbKbBHUkyFvdyT5OZAxUu2o3q9G
5C2SCfZsEi0ho5fsJBFkBkUdASoAm2+SLhbRbQq46jROBhyRt7rommdo/Lpoi7WE
GrUpsC7wowE9P26g05QE2XbkJZmPwHRA/ofaFCUCcV27koXxa/29XywH31Ehch75
7tJbWnc4WPjLhkVERCvtP3qqDeEA0HtJyXD5X34XseQPYnG7GG+dwNeMsjFWi0XF
oajjomkq3ddhpLYzNLaJGnxXkw7jtafuyU+V8B2nUU5AX1K/U73zbnHzQRJi0Wy1
EMGznP5cK22DHgBBROmZUEbZsFrkLZosXrIMN2xhttO7vk3o2f5pR47EpS4+FUsO
IkoUzHk47jnHfPJc3qyOuffuO9KjcOWUanJ6JLDzHUSwIS3QAfmamkhJE10VVr05
Hqy9sFdZWOnMT1hPdevRRE8kE9U9jjpxBscokApa6p7z2levUH8GdpR4HaEiA0eG
CaRfdSCncPRE6OSHua166pAQi/XEHWM/r0FF/XQ/kakCQNXpnuR6MNTJtLYqO0Ap
A8X/nRMgiFe6ewiVC7K+Dsda36b/8Cj7VMo66fqS+5yUvw9MPdtgidrXeRzhrYr7
XG7b7DnBMCWcf7EXFAzS+irtculHzdMpL3EP316ESmH5Zj3qN2A=
=a3gY
-----END PGP SIGNATURE-----

--rbK4V/a1PZnuPQcG--
