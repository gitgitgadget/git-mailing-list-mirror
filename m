Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C581B8EA8
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013850; cv=none; b=kFKULyRR/tKmiGjzRAXz6j1Wq5VxqK/V9/h/r8KR+gnQK7XGVL7YMb6ai5UIS2JzvZflG3zBJIkx3yugi61a5fyUBgL4+QBLo6rR+X25DzUcBLxsCjL8aJZJbWDV4JwdrG2tlAiyOFp8womBVi9M8eBefTNXd6I6/WEdoovsHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013850; c=relaxed/simple;
	bh=yZ7yuUXkJ0zjyzgAkCkYTZQcrXhI2/NuYOILePnSykM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcduQ4uP1lgq8zDSumC69YV71McHzxgiXGK2Kcf3GMBUfSLxbPika5cOPFA7eEeekBT7FS+ngIl03eRVE/accKU5TT6vXOWeB3WVzTSY/WD7pTKksoqi74xOf/rlZ9BHNanMlrcQ9ijwE1ZJeUBlhCZY8ttuh+2eZ10eQLPDRu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MYcFMaA3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VFQMLaif; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MYcFMaA3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VFQMLaif"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 01167138CDF7
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 02:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013847; x=1723100247; bh=SMPzZ45r17
	ezP+iDwALzHCTPtjSYAJ6W7FXGE7PHd2k=; b=MYcFMaA311C2aeVyoSCBUqOEOW
	04rB7XxCYkljo6CNkLaZZ/lbOUIeBY6gFZPH1go2VHT9zIkCV9/TT8udVP7HgWvJ
	9PKJClfTJwcv3nSdkfhaBLnS8UoIO40eXHXQYCg0F6D6L0wF7d5SKuZ/vc4YI+qE
	jL9U66wvTn16tzujPmtrK3Fg1uyyUfRZKHSOtfaAgZbOMqHSD3K/0U+sdpzx60i1
	Cgr2pwoK2V4+DH3g6ZukzYBlBF+oaYPLZuGE4/FwOqOJH7TJJ5nIVJ9sCRuQSexo
	B2xoeDvIMF4pIh9S+zET8PJ+vkjGXu1E+LPGdTE4VJtQ2XuMyuwD4ud89BLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013847; x=1723100247; bh=SMPzZ45r17ezP+iDwALzHCTPtjSY
	AJ6W7FXGE7PHd2k=; b=VFQMLaiftw9AXD+7wH7g+cqgNo4uhR+3Z7Z8b66IonEI
	aYDH4FaNhrtohsDCqsAyW25V6NjqK10xVEPAevGOXFKoIGP2CEk6XRGSNPnxRiqH
	WRwD05/mVDRc3gLRDVPI7s4rNN55YVrrLfBo2FVacZ78r/kUxzpHnTvqN4MLiPuy
	wbcJmSv0rr9uEwXvta64vTsAhoTOCQKol/Qa98PjGAb+0fWr2RUt1VG+TE8BJCJJ
	twhaq9h359508XFyK95FOF00fOWkSRO2rA+FFmXS3Hdo9CsRZmjcCfqovJX0z/2p
	WrKhnoXlHWPeZqqjByXqVAHca0XvfVHBh2VPOJrbJg==
X-ME-Sender: <xms:1xqzZlXVMobwcr1SLzWB9CcGjbuHR2f3mvBCWiGaU3FYTBu15XD4Wg>
    <xme:1xqzZllPoXdxM8qn4hnNf61ttzPeUTVHjvh-o8I0_fQXSgCnIQ9XhHbfyTqZwprFA
    ObgRlMI2Gxl9QHtGw>
X-ME-Received: <xmr:1xqzZhYXZSjW3_Pad_En373ul3c7_Zs8swTmn1MzSHoghb0v3cH2-enjPT15gFw9jJimfA6xbT64MRLbeygKx3pMJXLcQjDnArqNMmaBvJ9_uZtx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:1xqzZoUE9KYTad8nkEuchEBom6D1SpH2x0il8mRqfMfzUea0TdRBtQ>
    <xmx:1xqzZvku1Q5Cx18PYqNWzqPvxJf7zTLSiOivbUVLgKsx5hPpCdZpTg>
    <xmx:1xqzZldSa5VFD-xyoY4_cTwcjmOnv90raSMgqcMLHjc8-qER9Htmag>
    <xmx:1xqzZpHKfdeTruwBdYFGM0vdSHAn0eYOydb9gjZZXIf6LNW_IBajmg>
    <xmx:1xqzZns703GOHONJsSnTKgM_tMfWv0z3epljkrrKUCulEzHSvG2ufBZc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 059363da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:22 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/20] config: expose `repo_config_clear()`
Message-ID: <63da87696eb361cd4c6952523941172f2f50f438.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LUg5hQEqPeZicW2K"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--LUg5hQEqPeZicW2K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we already have `repo_config_clear()` as an alternative to
`git_config_clear()` that doesn't rely on `the_repository`, it is not
exposed to callers outside of the config subsystem. Do so.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 2 +-
 config.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index ac89b708e7..476cd73c9e 100644
--- a/config.c
+++ b/config.c
@@ -2564,7 +2564,7 @@ static void git_config_check_init(struct repository *=
repo)
 	repo_read_config(repo);
 }
=20
-static void repo_config_clear(struct repository *repo)
+void repo_config_clear(struct repository *repo)
 {
 	if (!repo->config || !repo->config->hash_initialized)
 		return;
diff --git a/config.h b/config.h
index b13e1bfb8d..8eb3efa0c4 100644
--- a/config.h
+++ b/config.h
@@ -651,6 +651,7 @@ int git_config_get_string_multi(const char *key,
  * Resets and invalidates the config cache.
  */
 void git_config_clear(void);
+void repo_config_clear(struct repository *repo);
=20
 /**
  * Allocates and copies the retrieved string into the `dest` parameter for
--=20
2.46.0.dirty


--LUg5hQEqPeZicW2K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGtMACgkQVbJhu7ck
PpRGCA//X1w9tFuEguOBItp1IHOoO2vnKGhFW5zuCWtQeXC+Ig6z6vVs5IvTAfZw
pRdlPAY3rxpvYm8ac8fRmQf32QyLqc8RELVUTXWtf2iBn85h48QknJ/bl6wycS1x
KKbT1MzmpM8rcLC5d4k2F+TeN86I04OACn2F+6nGL/7jB6JPYf4cobygrZP1oaR3
5USRGa5ss/9hRLjRG0lrf2newJOX/Sc4V06wCanwLe8nil27joQZFucwapOWFcLF
zic7b9gCbNZBccuvR3xyRyOsPMoWsaDQ4/ZVCecYCCqLkm0MvNjR8xbpWMqf2MQ/
s7kHlDHLnGQ6tLSc7hnX+WDdKG3m8JXVHrSLtKx+ODUZy7jhwhl8LC8V+X3bpBel
gPQLKrOSQAedAr1oozI/wQB6RC9KPFwNMzPZRyNm6Tp/ikfXeyCiquIMeSak6N3m
E+8cRDISxSQU/kPD7l1NA2ualiKC2PX7juCtQ0zwVW+3FPm2y8xhnemv0AzZR9PW
gUF5sFhDCWG57CY3txw7qcZTunboKpQyUM1qTUfgVngh98uphxTzkklX7Rh0jKn3
tOokI8dK9aze6FblgnjvvfTknW4PKad7u5LaYm+4zWwOlHzZRGYkJvZyeRqys4eL
6hEQs4Qy6Q3puLmCigZ2SUGXnxIOpBCSBZzO9xhoCQKgBPTd0hc=
=rlJD
-----END PGP SIGNATURE-----

--LUg5hQEqPeZicW2K--
