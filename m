Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3085656
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407664; cv=none; b=IuAYSSSDX8i58fmKPR3QKJzd1iS+Nitq9Cok42pAUpASoVilntqEu3W1h477HMedjn8WqzhRt9usR+q9MCLTVQwbi0mGZfCmurAwfqVmhD/5vxuL+liH9QlEKOQYg3tbg7yWfOp5x/ptucDUuXPG9d/AyFYLUKhbn4U+rmdOIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407664; c=relaxed/simple;
	bh=KDkuENqhsgYGkz/7tezYltmnCjK65U27sAM8qU6pT+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9mOj8Z7lqleEyggDso9F1GCEu6yJm77kDPKN58QszIByORkqbRUA2M2HMm5J4BO9hX51hBLKdVvMZhBFi4vDdyj5tCCuhmSqoEW759VCfBiXWfL3HbeJwW+/hNVgBETnyhSgCw7QcDIcyJMoo+HNeEpzBcikf17eocBU5CckTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VyHeNkGJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e3Z3j6O2; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VyHeNkGJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e3Z3j6O2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 759FD1C000CE;
	Mon,  3 Jun 2024 05:41:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:41:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407662; x=1717494062; bh=gf0SnT2r+Q
	lFMi5mvBVk3CnyuU2/yObq6cSyMS6Uvw4=; b=VyHeNkGJGghJwSK8Eu59FWe3N4
	w7dBQWIjmwV3wwzXPCqInWJ7AgBp/JMW/KrqI41cwUPhX0e3MwD6PXs1GHBjRcpa
	kTCU3LwqCZv72PaNDJUSWnQB6Rvs8r3UFJWOs/Tc1H7x5BULP3o19CUhstfzkFGd
	OuCB2OSakpjRon32dqhSFSl/h5oSpPIbMicpNPJdvruLKV6puAgVPpZEYuOvoOLq
	HIeqLLI0x/lGpQYp2NRXtsqaeXLU00/wKfCIDqlEiujNJygIg76XoRVJJv6Yz1V6
	zZD6m7MGTw6HYieGP4K1cuI9JoTU4LW4JmbJ1Okmq0N8U+E/uNVjw65C78Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407662; x=1717494062; bh=gf0SnT2r+QlFMi5mvBVk3CnyuU2/
	yObq6cSyMS6Uvw4=; b=e3Z3j6O2eEZf9ndm+scQ9gC7zyhI7Lx3+uV3Aeh8LJKc
	8847TyHrVAiHRX/4O+EyjWfgNmdgkrJyP9vxG2kkMA8tntf4dzxMZotfGHF5MhpJ
	xN4JK8k4YPv6Cc6y1KmTfMAKW0/eS8pI5KHxHHsBaumI5ts1Yf/oNBBwAuQTsKIU
	3vS72OTdhdWZ9fhOhPo9yrHNA3Aog73lnPMuecqUL23BCqadkEzlbO431ntJzCmc
	s7s3G2naEZbFwvPqUeIf7SZAPp0WeGFtBH4x8MnZ9E+s9bv4iGkuXkvJwM4/ngrk
	tFq2ObAIBuNcoGTQ7zyFg7x4xuzWpaSc8f3TeRRyYg==
X-ME-Sender: <xms:rY9dZi9auSfxvdvCj-zlrzgpLoOodZoGevkqqfvlmhsVBizaY9sQIg>
    <xme:rY9dZiu8O54v0MEK8gJTjZD8mLPCve_jFsHI_jAXbOKZReLMXjK32cHeI9wjB-BIr
    BAZydsZkwteHUXp-A>
X-ME-Received: <xmr:rY9dZoAYgsON-GVbqKrbbClJhA7N9rlV93VcrJSgCPjqngdnLBMizL7u_hJXvTnT8hn796TKAKA6f7Yw-5hWS8LeH8YLeJRvAleY19fOJJaCIzIU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefgfedvfefffedvffefudeiuddtteeggf
    duieeuvdefiedtjeeufeeuieelueekfeenucffohhmrghinhepshhtrhgrthgvghihpgho
    phhtshdrnhhrnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:rY9dZqfaSvvVWPXIfk2Rh56pC7amfwuj_wYtbRT5O9CEO5VrMNeTZA>
    <xmx:rY9dZnPniN9JrzFgxfUZxaGOYFaeS-12vcBLsKC-akw7_wv26U8bww>
    <xmx:rY9dZkl6Jsb3xtbSC7KB_zQY7JLuFUZFRZa-b4wVzrxm9_4R0ucwIQ>
    <xmx:rY9dZps4KWwbNERjnAvBz4CEpdNb9ODFrj6Fwf3Y2uOBZogpgSFwdw>
    <xmx:ro9dZgqAHlrKXmUo94UTrxjRMe6Mua1X8LJrxHajJ4Q_Gb5g9kmhYZ8P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:41:01 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a401df27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:37 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 25/27] builtin/rebase: always store allocated string in
 `options.strategy`
Message-ID: <5c8bee3695e224fb1d7b1d0071e32e133065ee0c.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X0QOBMfB975Y2F7d"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--X0QOBMfB975Y2F7d
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
2.45.1.410.g58bac47f8e.dirty


--X0QOBMfB975Y2F7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj6oACgkQVbJhu7ck
PpQ/8RAAlw/Ttltrt9sJ/2wVu1j361vK6GlKjbBQp/6T3XPlhVvAX/oT6zaPflGj
HWuQgJ+uzicDlxG7vUUEQKybH9E94sacwkrFc5JAB0utb+/UOA1nmQY9DXl5CV6b
xnwIBKbb8wUBYW16PhOAmqzJmOs8kg2ZXbUS/n6QXyjxKnVL9EVmVUnjVkuHE4AT
0RAUXuwDVClfGMNAotOhSXW4E0ZGRfiyw/h7Q+1FNDaPB07kVGz+d4VIKgHLHq3T
+RxzeJmEkKVKgF11v20MVs9VTlBYzCMN4v+OP1E6veYdis9u469xBlcj1Syvh9GN
PQGCaHUCLY4GsKO1Zy5AHAxNA7CauhBvUMqeplltfpGY8hhaTFH5CNKuIoZMin6P
PRYQPbk5v0L8fksagHm3C8YBJoEoyrBK7SJJ1WwCcrFS+pCyKEghZea5K/vVmrsK
Hqb3l1I9EC4d+3gv2Z/5x/l8Nf+rqgTH5t9I4YTD9FYSzfiQemoZlHYHhIMybiBW
6C8yOEL4ABSsjNQ4imPR8Tu1snwr1yNdDFS5HxGYm0O1Nc5Is86Sc4qbYwBA98Bs
VVbYe8V1UVFzjj9Acgl2FYSt7Cj6XsWGPc0vg6I+wTyF2kPPiYXdUQvWaYLpBMuU
Y6E9sCKK4b3KzGSWHXlGvfttl6+VfSNpRFUkfLKWRBSvGAIUIQI=
=MlNW
-----END PGP SIGNATURE-----

--X0QOBMfB975Y2F7d--
