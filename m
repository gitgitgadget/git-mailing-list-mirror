Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E881AE053
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013859; cv=none; b=tQsPHftBrOWroJptdstUH7TsI7iDkJPrN6TyMM/oOanjk9piluSJPpg764HcExQddTEIKAE2+hwkyQQGAjz9Iz839wPEBHieNAhRTGM84K5arzU1euuTzrX3waNerROgEuVL1bzhanT64UyEa6Tzkl5TFzH7IYAGs9Lt0mYPLkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013859; c=relaxed/simple;
	bh=LC0PKfXFk0gm/tGvtQaaDamMvw8fooYBESM9GTDRoy0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMlSDbsHVlQhFAlIVhxfp0wJ7atdIX736FgiNpTChlACDz/OI2m21ocM4HTQX8CYcYFkYX3mZ0RcWyjkvt6DNhMiCGxcGPq4M8nJmTiVTuUTNr1kG33laC651iX/UpInG7eEpFaeP5KjbIU0VpYwVqA+b1T4+705VGi+Ys5/Ysc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OsJjdwdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nijoAmQU; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OsJjdwdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nijoAmQU"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9A4441151AAC
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:57:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 02:57:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013856; x=1723100256; bh=XbH2lsV1YW
	qoIi5HpGlVEtxIJmOXZLcFUaDB/QH5wsg=; b=OsJjdwdQ9yDwzKslTy5shNTZob
	asFKI0tpCCPy3M6kFy8Nm6yDAw8dsF8nxbetC6CO9xWhX4XGSD/m3vUFVywjn1tE
	jaC9bgl2PaRLofS8rDXhB0um4Cv0r/bA7IGBX+A/jkS66pfUuRjmgHZ+tvOY7aP3
	c8sADdcb0/FgQsHVb5grXZJZAU4ebdRz7MqgU2NnJxGSIxxqAqmiwXf6mAzltt+3
	lf79d6HkEuok/Y+/3lyqrmIo02N91ZqKRj50xiF3iIVSUcnTPHdBZEqmZseVA5Xl
	ioNYUt1U9RhRjpfF+hAonfKeVHHpUF/t3pkYTBt29blEsiD3mTbjvgiQiC/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013856; x=1723100256; bh=XbH2lsV1YWqoIi5HpGlVEtxIJmOX
	ZLcFUaDB/QH5wsg=; b=nijoAmQUBwXg0oo2l0zBcz7vU1Nd77WiLAH6wO8ThHU8
	+FKp9T4WjZ4vm0SqoJXxL+qRHMHgFPYtgZAJ0dKP7MqVTEbu2CTsvoAkQnPC7/tl
	I32OL2J8kVt1HK95NPk872CMIkTPXzIP+U7/61DjXqdFtiSclOx48H6Y8GmcMyyl
	Va3jRXB0iCmiRVu3Y2l62hcqLOXvvo5MOdkOp2agMZ0HKagN6d1zJeoYvZOmOuPu
	s0HxvatbLejsJ1H0MeCeUrIPvVTu1BJ6GS3uf+p5kO93lOk1qnQJdqKTx9jR9WZi
	bSLXTe1lJEu4q1ZwMCZPGseeJlwE4IHFXeqCuP6TGQ==
X-ME-Sender: <xms:4BqzZlacKwkKIy1Z4GyHB9zJ7TizFKZek20EOfZFsQ2r-acxOen4AQ>
    <xme:4BqzZsbwRBHUDhMtMGwUXucfj1jCStDljqjn67uLG9P66qi60rBKdL0GrG1Py585F
    bauWVqAgTuZvSTNCg>
X-ME-Received: <xmr:4BqzZn_AlOxPoP8qrsl8a-SUKKCtC1GIwZH5Jhuya9JH4SK3rxmHwRuVskn9rAzF3rzyd_5uDQVD8QBzSseCewKTGMAulKl3_toaMj-LC_gmTQ6i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:4BqzZjp8PzyPDN1yDglTKeY5PJQQMFdN-okdDl6yefyg8LB57s-JfQ>
    <xmx:4BqzZgrFX77IVc85WW_GrtsMfepQii-tHTd0RSdiQDY8p4gkHlkIAQ>
    <xmx:4BqzZpR97OtpeYAEXKsvU4N2v-zyNMf2Wf5RC9K9gYM1od4wxhZikQ>
    <xmx:4BqzZooBkns9-pipALHnrqt04IUpdeqs-1wfdS7WtlPbVCpzP-MKHw>
    <xmx:4BqzZtAUEEhT4HhuoPhiwAm2SioMMFA4Y15_V8JPl_Ibs5U7aImqyAv4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:57:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f8ab52c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:31 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:57:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 11/20] config: pass repo to `git_config_get_split_index()`
Message-ID: <85311d686e0b747a902efc55546246fc36faa05f.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n7fAbqGEuocFM/Fd"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--n7fAbqGEuocFM/Fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Refactor `git_config_get_split_index()` to accept a `struct repository`
such that we can get rid of the implicit dependency on `the_repository`.
Rename the function accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-index.c | 4 ++--
 config.c               | 4 ++--
 config.h               | 2 +-
 read-cache.c           | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d343416ae2..35a1f957ad 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1156,7 +1156,7 @@ int cmd_update_index(int argc, const char **argv, con=
st char *prefix)
 	end_odb_transaction();
=20
 	if (split_index > 0) {
-		if (git_config_get_split_index() =3D=3D 0)
+		if (repo_config_get_split_index(the_repository) =3D=3D 0)
 			warning(_("core.splitIndex is set to false; "
 				  "remove or change it, if you really want to "
 				  "enable split index"));
@@ -1165,7 +1165,7 @@ int cmd_update_index(int argc, const char **argv, con=
st char *prefix)
 		else
 			add_split_index(the_repository->index);
 	} else if (!split_index) {
-		if (git_config_get_split_index() =3D=3D 1)
+		if (repo_config_get_split_index(the_repository) =3D=3D 1)
 			warning(_("core.splitIndex is set to true; "
 				  "remove or change it, if you really want to "
 				  "disable split index"));
diff --git a/config.c b/config.c
index 387c7282e9..89fb7ce6b1 100644
--- a/config.c
+++ b/config.c
@@ -2801,11 +2801,11 @@ int git_config_get_expiry_in_days(const char *key, =
timestamp_t *expiry, timestam
 	return -1; /* thing exists but cannot be parsed */
 }
=20
-int git_config_get_split_index(void)
+int repo_config_get_split_index(struct repository *r)
 {
 	int val;
=20
-	if (!git_config_get_maybe_bool("core.splitindex", &val))
+	if (!repo_config_get_maybe_bool(r, "core.splitindex", &val))
 		return val;
=20
 	return -1; /* default value */
diff --git a/config.h b/config.h
index 3f68b30047..35cee9d4ca 100644
--- a/config.h
+++ b/config.h
@@ -711,7 +711,7 @@ int git_config_get_maybe_bool(const char *key, int *des=
t);
 int git_config_get_pathname(const char *key, char **dest);
=20
 int repo_config_get_index_threads(struct repository *r, int *dest);
-int git_config_get_split_index(void);
+int repo_config_get_split_index(struct repository *r);
 int git_config_get_max_percent_split_change(void);
=20
 /* This dies if the configured or default date is in the future */
diff --git a/read-cache.c b/read-cache.c
index ad09950153..12c2da5a8b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1945,7 +1945,7 @@ static void tweak_untracked_cache(struct index_state =
*istate)
=20
 static void tweak_split_index(struct index_state *istate)
 {
-	switch (git_config_get_split_index()) {
+	switch (repo_config_get_split_index(the_repository)) {
 	case -1: /* unset: do nothing */
 		break;
 	case 0: /* false */
--=20
2.46.0.dirty


--n7fAbqGEuocFM/Fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGtwACgkQVbJhu7ck
PpTPNA//RXItkFBwAW3UKSG2sIEherUwW+B7GwFyRLzsxtJRFKSXvN/1NYWnkCtD
zn0H98+dRHyr7s17tlBvbHDB8CD3s2h08R+EH+nAH5RV9iWL2siF9J7xEANSNRxm
PHvkw96XIURUUm36Mfo2lh2Dj78cRfL5LV1SirU61+ivIh7qQ4XkGkOvuOGupju9
H1tRYmmppgNoiNS6dNIENaXnXRNttQOIJ4n3PZSE19nLLEsx8565Yx591jAfwIRm
JmssjnNLvAVabihU3pxHD1XpzRjcYF+l81Nqft0vue377fvN8QiE3fzsQaQwbnd0
hfZhqFsrCupTcT19U4ILqsWY7GBgztA081aWvhhT3M9YZauDNUquNR8DFTh8cazb
S8CrqJ+tOf6Vt8qYyI4F9XpmuOe8iHRxGh09poKKA0qUjx+9igd5MoM2UTmHfhzj
EfaFrFBULFsI1x/B//NX1WJJxXaXdQhHHI8ImklRwmG6gZvfsuTh1Suh5vQ3EzNe
3xn+YFz+6UUz1Ht3B9bAjUPv0A9LN0/KCJcTzyq30SiLuNAkvSp+PX0pKOT/mMnX
eF3GwhDDVkz7aHyTaLduIAaEmgSwFn6es6CVoXCJ6rcM2FC/bG/exUC4Bqu+Wgru
WDjhNZy9nKVOpbpRIdN4gwiBaNStG7GNznFzBl+eRkNu9g8kVMI=
=dHzm
-----END PGP SIGNATURE-----

--n7fAbqGEuocFM/Fd--
