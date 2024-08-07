Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44841B86DE
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013893; cv=none; b=NHZNMjLQNFRpyOvhot2StXEPSN1rWSAvMYc172nwsRuHFYmE/4JDbDiWci9wNjmc5joyZrGFl1y992dY8ceCCYx5A9vGbhCKOk+rh705Q71YsBKy7Ha9rTCHUkyqo6c+05lwMN0E1s5jsn9IS5aJaDTA0ZmNXP0hdEFoqlFJP9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013893; c=relaxed/simple;
	bh=CjiRi6lsWyFyEDMEqF8EsttcqnMNG+EmQIHHeue7XOs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkTJXyNXFbwmxz/+SawyEMm/wNUkPDR3qJQxXlO6mYgLRgRBi5DEMrUeB1nUv3lRVIcgswG8369/nQ6EKjejMRGH/dyyag1HT/sMc+KSFhh4pj3avS1IazhI9pML4aWU/SkrkyFv1icXsiNo8fNqWH8O2CkIiwJRYa0NB+KjDHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aDaFmZY9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xl/B+eMG; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aDaFmZY9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xl/B+eMG"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4D4EC138FCA2
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:58:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Aug 2024 02:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013889; x=1723100289; bh=kdV5Ru+0k9
	k0AbW4itgak8IApjsz5n4FCvVOWA+irV4=; b=aDaFmZY9n+Ow+PZZ5ktZANHmOc
	Ck+jOAr/5bIvOnSMBdPAR2WXkKWOaN2qmygmU4p8Vs/Wt8S32WORTOnL388Sxzgd
	I+GHr+h9vFrJAEIteeAa032PXX6ykmta8dYVgkY/WFrpZaoHoFAug2XNwcb/ABql
	u0ZS7l7ZTLS4dhTIUGqTbFzKUnTDCrssoMF4+2NQ0+CDNgeZ6ohof4crbNECIsbo
	oUckpEkNlWs/bwgYBDeJvSy5wyGiSb5CmKgU9wp7pmB6w1NvzRKEXI7sv7JZ3Tpp
	ZCnKsGSOpM05wVPc0wA9dGfdDaFKGEKSjSqVvj3aHf0ACaF5rVyZCxvYhsUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013889; x=1723100289; bh=kdV5Ru+0k9k0AbW4itgak8IApjsz
	5n4FCvVOWA+irV4=; b=Xl/B+eMG/9XvxsY6knQmsiWc2jEmH2lTisAYHyyj2b/y
	znTHC6BwsKxUOJ5XuMGPcFl9ovx5Bu+AmMDiTf74ozwokbjcrk2DHI7aMb8kvtB1
	gcXKrpsInaVnF0elK5REqHzanMQCqYrwRvA0fuXt2iidUJmOaEb/eOb6oXLkKbVw
	zCXiCC4tObPpMpr0juJXuXli7+1g6GMBFcDPzNuRzxEncvbLAynNfgyW6HiCnAAK
	lfxl4sw4GTMYvWuqzZKCqM5OxAV8631QGBhet/l/hxpdnuplONcJE8ST9p9+bq5K
	cuJE/VDNCbV3YSSKSouDiArwIi+tLR42bVLvUrjd4Q==
X-ME-Sender: <xms:ARuzZhTE2uoRDM2drJF9KSDoXJUkB_9JrWk4SW6RhUpQJKpbQFk6NQ>
    <xme:ARuzZqyQte3B5eV4ITK3E0e3fgx2wsckOBcbTI6zhUnij7WMrhCbD5jonvqX_6FH9
    7foYHhykTLf4lqgzA>
X-ME-Received: <xmr:ARuzZm15OdQ-2-0STG-OfAn0leQSoWe4EzF6_EKEmS8h1nTh6hBF1vbW4LiBfWL6-ZYvJtEVMm8txmsfI6E9jfkkVif8DIuLp7SrtwdhSnYO-qad>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:ARuzZpAN8Lq5OY80T5oq-m-pv8UNmVWBdamU8JJiU4DOVXVyj5w2aQ>
    <xmx:ARuzZqjqaOHLoIsAKRnXJdtEwchOctdEDBmSC5Cr0SoDq_HEt72-Qg>
    <xmx:ARuzZtp1RcADRD-vylHcBI_PvNFuPpEdSP4dA73_pGl8gwopyhkA6Q>
    <xmx:ARuzZlibCmm_UwEEEsY4o-284fEzPEAe2l-8ugrCoG2hk_qSYfpbsQ>
    <xmx:ARuzZuY6hbKM-hUdHtGGSqXq8GrneE0UD1H9tTGo-AGLjcamfC_1EvDB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:58:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2e86fde4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:58:03 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:58:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 18/20] config: don't depend on `the_repository` with branch
 conditions
Message-ID: <d8530a300b4cf0f854f2b0d03c79876c11d81116.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="13aS7Rkw0CfqpFup"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--13aS7Rkw0CfqpFup
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When computing branch "includeIf" conditions we use `the_repository` to
obtain the main ref store. We really shouldn't depend on this global
repository though, but should instead use the repository that is being
passed to us via `struct config_include_data`. Otherwise, when parsing
configuration of e.g. submodules, we may end up evaluating the condition
the via the wrong refdb.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 831c9eacb0..08437f75e5 100644
--- a/config.c
+++ b/config.c
@@ -300,13 +300,14 @@ static int include_by_gitdir(const struct key_value_i=
nfo *kvi,
 	return ret;
 }
=20
-static int include_by_branch(const char *cond, size_t cond_len)
+static int include_by_branch(struct config_include_data *data,
+			     const char *cond, size_t cond_len)
 {
 	int flags;
 	int ret;
 	struct strbuf pattern =3D STRBUF_INIT;
-	const char *refname =3D !the_repository->gitdir ?
-		NULL : refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+	const char *refname =3D (!data->repo || !data->repo->gitdir) ?
+		NULL : refs_resolve_ref_unsafe(get_main_ref_store(data->repo),
 					       "HEAD", 0, NULL, &flags);
 	const char *shortname;
=20
@@ -406,7 +407,7 @@ static int include_condition_is_true(const struct key_v=
alue_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
 		return include_by_gitdir(kvi, opts, cond, cond_len, 1);
 	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
-		return include_by_branch(cond, cond_len);
+		return include_by_branch(inc, cond, cond_len);
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
--=20
2.46.0.dirty


--13aS7Rkw0CfqpFup
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGvwACgkQVbJhu7ck
PpQ2QA//UBhWXmxiKv2+OYaY9fIyfeqEbUlOjqEsMYz9vIuv9T2y0+yu3S1LCm5G
lc5IQrYe6Apiaa+gWvbznvXrpGWWgppvbLFYyain1ve2mZ7LI+j9CCuTJmYy+QKW
S6DgbN3hjBEZs3OH4HqS4Lob2+RO2nayJR4Rrnoe+txmDD24YrWrObyqIE6hyiqH
QD9U0FaTw7RPjhcg6t06lxzlmWM9qS3+W7+Sqvc10EN2+YGhYjOPECvdIrfLt4Dx
zhiVaJX5J5MgLZYWW2RlOxCCb5KxBRGojsfHpRNnntLUTCQ98qpdLyvV6G4tNfVv
t+KMIcLRYVHYKwl6G9a7ue+AsvCNvXJXLXpDxNalBe2DdxsludoniOFOYR/acoMC
Z8KNKeklS3pkU7DDXQXd0OY9ABBaNKTHLqlia6FYccifvcKRmFWlBWE+niQL+XRS
b7vbOUcS2aDk/0H+cnCD7luAvxHKF5xAjKdTkdNssNv2AVwwoudAUa+RMS0nrkJ+
iUGXXGo+qjA/AC+y5tznQzZvWgvnJh4tenS5X1TuwGOs9quVFBAQ5kU//PG5hTql
FZBvbl+TPz587kOp4yGLMbwHJ03rlJxnkg/5DSrH2ma4LW48XRvS0ROWwUf+sc0M
7XiLs2WMTtLdoCA7LKpLOey/pNGXi4NYnMHP+HGDdWgzI+U621Y=
=OnMt
-----END PGP SIGNATURE-----

--13aS7Rkw0CfqpFup--
