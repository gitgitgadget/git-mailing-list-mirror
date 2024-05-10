Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9114171085
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340303; cv=none; b=K+DQL7iWmSUbWz0kWuliPgcNlwh5z7Htq0uEVFdqIFWKWcBH6d+/jyAY+A3hlCtJjwLM3sSctSFmFe4j5PkK1sAs4OxuS31PRNcwXMdbzWDyD9aNFufxt6d6X+wA64yB4HR/aYSAS9eCLMx95q0G9xR0YhftQbrm3ykRmQ9SjZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340303; c=relaxed/simple;
	bh=4HRggUM6OPFiayHrNNPpeW1M5Jmv2PEghx8vJytQF0g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTRr3T1DkI5YjVv45wQZ88es8zDm3XThtnXKnL+/QYaFQxkOyFxSIRVPqZ3TRIN2p4mk24htdKzfciBy66veHrOkBnxSmL7GohLGmfIVMHv5JEipjgdpfJc7y+jPDHllh6D9iEgksVBhDTYrIlRSEf9rEW71E2Bz/gMwB3kf1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=odbre1ol; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cFvyOykr; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="odbre1ol";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cFvyOykr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 00F1318000A0
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340300; x=1715426700; bh=TiAx13ZZQg
	M9TqFCkT9NZhd6gzjBX6vHOMgIBSlJwFc=; b=odbre1olkKiQQ46bphk4BkJ1oF
	Xv5I6RO3n1jBSM7tqIpmkrj4soMECex4GlB+OzY7bHPVUDncsxKBIM4ymrHLNIId
	pYWCgpm16z0EWZLzvt/1x/pg1b2+jyfszUUINicBNZtpjJlpf9WEObMpGhMS6DH2
	f+o6sc7hjEQoHXYoHrTO+iNFfWjKO5XMa0KKSa8QYCCpBWDQHzSzT/h0j9d/o3av
	ttDBhHKAZzw9Ptp9DxxjhkvWvGjz22bkq5V1RCtSmDjyn8+077v21RONcN66pn8M
	XS5zCu2xpjrCNlIFf39KiN3DpRusOEMFHqX4iyRqgTRNRrKU1cMtF3VyP0MA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340300; x=1715426700; bh=TiAx13ZZQgM9TqFCkT9NZhd6gzjB
	X6vHOMgIBSlJwFc=; b=cFvyOykrYL9Ytp28m7bFXkN7Es+kigaXKugM1favHlOs
	3a/wrHQKHOJqvwF6atGhJoYYq3MoL1CJEcdjCUo39nDj2yun49MSEccCkWM2LENF
	d/jRcaQAMSdpEy1q+NAA+4DSAt4BFGH+gGOAY7cP7wVWqV2TWTJroR1XDp91z9qx
	5mPuW4/YJsNYRCXMd9lCfYAZBcJrNobVCwfHJKYwxIku/4MNyUARltMRisxDqTND
	Lwk4p+kh8fFGI6kSGAWHU5RzsLmfYpSd0klvG/3hkl6Tlq1rSbE3/Ktc9Q8of0GT
	pi4jN3UJuM2CbByMNIUx5ApTClBLHVtW6eatH0Jmcg==
X-ME-Sender: <xms:DAQ-ZqKgd9StImgOI5ZpmGvir3l3iJDyHyOBNraSPPkCGFs_zLdhpA>
    <xme:DAQ-ZiINj8pDuyuh-o8O8byBsFVVT30yp2vqTNtNlPhJBHdNSKKDlw29tDvbEgU37
    YDXsdzONHNp_ItL3g>
X-ME-Received: <xmr:DAQ-Zqt7bVO6tQc_U5k1s13H1akA--aCcKp4xfWcoTWbAuHa1RzVyl8L0TAXKRsNW0FoTelksXnXYJmbmKrpEyYwPpGdVTMsyQxQf8-fX_0cMCEuCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:DAQ-Zva1QHNaPlk3rf1LotkbtFqTplEW_3-5aC6M5JZyVWo60LqUmw>
    <xmx:DAQ-ZhZCFIU6QZ9s8tZGCPlBDcnkBC4QyibjmaDVycgeZ9pgG-nYhg>
    <xmx:DAQ-ZrCDLl7txHAFu7BQ1wNHbeVRTjvuUaM1CWxn-XTC4ZNQrL44uQ>
    <xmx:DAQ-ZnbD-1yBBmpjT1bF50olOCVQztUhukva3ohfcfRtqWGy3tIRoQ>
    <xmx:DAQ-ZgxKQD4pnp3_eIxxV9kMODTQNyuJR3dV6VFSLLitMzBreZvPM5bc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ac126b4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:47 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/21] config: make the config source const
Message-ID: <bfba68aa1e0b19fa16a2cfc5dd04df28ef337505.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Upg5RIfPV/Dwc8S9"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--Upg5RIfPV/Dwc8S9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct git_config_source` passed to `config_with_options()` is
never modified. Let's mark it as `const` to clarify.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 4 ++--
 config.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 13cf9eeb16..bc0c005039 100644
--- a/config.c
+++ b/config.c
@@ -125,7 +125,7 @@ struct config_include_data {
 	config_fn_t fn;
 	void *data;
 	const struct config_options *opts;
-	struct git_config_source *config_source;
+	const struct git_config_source *config_source;
 	struct repository *repo;
=20
 	/*
@@ -2105,7 +2105,7 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 }
=20
 int config_with_options(config_fn_t fn, void *data,
-			struct git_config_source *config_source,
+			const struct git_config_source *config_source,
 			struct repository *repo,
 			const struct config_options *opts)
 {
diff --git a/config.h b/config.h
index db8b608064..e66c84520b 100644
--- a/config.h
+++ b/config.h
@@ -232,7 +232,7 @@ void git_config(config_fn_t fn, void *);
  * sets `opts.respect_includes` to `1` by default.
  */
 int config_with_options(config_fn_t fn, void *,
-			struct git_config_source *config_source,
+			const struct git_config_source *config_source,
 			struct repository *repo,
 			const struct config_options *opts);
=20
--=20
2.45.GIT


--Upg5RIfPV/Dwc8S9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BAgACgkQVbJhu7ck
PpRzzBAAqBFsMSheA7YlZWqFep+9clxpY5CCwTC0Ehod7Jucrvy+bDQGiEdoyGto
oU2iMailSgm7gRVTqZlQG+i+0aZqJAvxT5aB2DP2T7y4GpPLvS2+A7NSXHu2tsSx
BaUrWmLLBLkMf9PhP5eygJhlg05j/RarsAfUxDw+faO04SvC6lbYCrIxJGDirRkU
LU9ery9ce/sQk74nG6bDvQYa1XtR0Ab4RyEV5gmcYqSw9jiRikIgaUwZP1G2Ydny
UY/+XBm9oTbFG49UHPonMYk6smfR1nzwh0muNMNPTQay82TAO854W+O1bEnFj4Pr
+o2OEOQIKpnygSsmPKRlsnezRm+kB3rE+7HlciFyvilMagMmy51UcWwl7eco9GFc
+bDVA8FmLtZICIPeh3ilnFy7NYyuZ7Z5wictYqknkIu1RPKQnrKTsvXZFgPzorou
Ujuj6IUtST30PwbR5Yn24jZbhbmar2dUwwk0hOeI0Ht45z2x677eiBx8EBvb/k5h
oVakmxudqZ6xzGsHPGlHpjxHatq6If87YOTUSkaPFPiu4FZk9VNFHj62POed4/Ll
YC+PCYUSmIYcF06jO3lRXhC+vyEkgX1B04wbkaEDDRbWB8Q12PMvT3uf3ucnGiHY
VFuPBqbC6CXCei3/HbFueU4u6hzaTySya2HiAXZV6oW3O5yntbA=
=R9Ik
-----END PGP SIGNATURE-----

--Upg5RIfPV/Dwc8S9--
