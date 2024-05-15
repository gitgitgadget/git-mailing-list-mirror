Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52E73EA95
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755389; cv=none; b=tbI0k8+DUPM/rCKQqxQ5USbO6Rx7r2dwl8dA0heuhwFhIST/tOoOcWf8ttsvFDZ1HGSf2SKNmdxfQ225B7xLGD2Z5QtDOk4E4qsClIQvGseUeYlC5h29HZPdje5QBbSFvOUXutkGpvG2wvHPGHbb9TzXjoRGPfFycqdKgy9FSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755389; c=relaxed/simple;
	bh=ewZi5KBZTD8S4VAHr9PxeM9soG2cyNCqjJ59rJ8RvcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=laB074RbAAer38RhIA7CSqbPh4TxbO2rcjNwPi+efFyVZnSlw0WNEncvNtUrqutiLIuAbDznqdKFDfO2q3d6cSd7R7NOO+nolkVYpOertCSMPGQRjx8i8/bKQOCzDykl1edU/3yNg6LQCsgTHz7fpU9ndhW0fhQW/eVuXddU6LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oa7AaZJe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vrsl13R4; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oa7AaZJe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vrsl13R4"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E8DE511400AB;
	Wed, 15 May 2024 02:43:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 15 May 2024 02:43:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755386; x=1715841786; bh=qr9yLRRohJ
	Z+o4hKxoFTNIqvGUizuD4zV7LinwpCOVU=; b=oa7AaZJecj89Fnm3cZUtdWI0de
	zhjqibmmph0aBM43Wh/E0lJDSIkWpo93hMTNOTeoG4Bifyg5ToBp4gGRPH20vD8u
	RzHaUQLHANuw49JXYvaba1pWd/Wk8/0XPkwePAQkSmL4cfTcitvQ+k12ubHL/QQ1
	fblJhD1MPGN7MGo2t6BSMvdkCQLVZ8lZd0zcEAXGO2DxuDSET1G7V0I5rLXHb6W0
	j6zXCTeyyRfQqxYEaAatY7s+kDg520OOHxqqIi+nAveT8bPGzbuSDpqBBSLNgpgQ
	ihzdWHoDfNELLqHXrLcb0Wn5pvfayO/nHUXzKMiV2QAGIMkjWN1UwkMoqb3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755386; x=1715841786; bh=qr9yLRRohJZ+o4hKxoFTNIqvGUiz
	uD4zV7LinwpCOVU=; b=Vrsl13R4I1324+iIJpuIlqewfy/PKZ2B3LEEvQqySX7Z
	ihLaxxj1Risclildg7JZliP5QfaQM0pajpIaeJkosi/PTFHaXwCkS0rdBnVvT4cd
	dJulJBVfJLqsDNcMN96ObTodUfil7z6p8lPY8dzVhFQ47yS1sulLUgjVlqP42x9S
	Er/jp/l/c1vCHoTnfPVKfYLAcIyQHV1LyG+YoTpLF3fLeRouA+bEssyuU5nIUnzr
	iqE5p4oyCINCVarOYXrK3OLphyPtPHxey7IqeXsOSCk58S7w2DGwc1nMLEOCezVD
	+Ml9z77gdAvkMOo4hpMJEOfwES08JD825nimLzvrqg==
X-ME-Sender: <xms:ellEZjnh-YsykAWHkgM1LnTG58pRadxTEPuiEABhu6HWPaznzKmmuA>
    <xme:ellEZm03QHDxvdy-fuvzWVgTrU0uHTCqNbHIxaLeGxr_Jd0rA2oJT2VnQn4VRFn4r
    ly7hj1pgp-SqiVEeA>
X-ME-Received: <xmr:ellEZprf_xKOs4SrhcTTtXFvbUUHjHLzsYsilHr7KGmBDLnA3CcgXDpAwQb1OPIYdndm7gdaMlaZL1sWHtmJjSCtKfzanlSU7N4Ykgt0zuLXnXVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ellEZrn8seyKAku7XOy2GnjTDKYXlZ0Lk7Kli7FS8O8i0vQHUf5OZg>
    <xmx:ellEZh2VplXuV0nQ8dm3vNW4ZR71nluIr0pvs9Q_L4aUOD5NRHd2Nw>
    <xmx:ellEZqsniD9T3KEbLEpAqTuUr752ny8FBcY4ZFONP3O898gjo6eUtw>
    <xmx:ellEZlUX3q4Z3AgOmGVRtf7gUnxj2h8RPD4Imppnr2zxBUzbpJLWIw>
    <xmx:ellEZsRbWfqcjAiSVL34E90BZ_EdxBl0o5cnyxaEAvN-G5deaeqIecwL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:43:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 741fb314 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:42 +0000 (UTC)
Date: Wed, 15 May 2024 08:43:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 19/21] builtin/config: track "fixed value" option via
 flags only
Message-ID: <e4dbb4707ec50b7b275cba7b7bd820ecdd05e6f3.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6EoFNdB/DZJirVsv"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--6EoFNdB/DZJirVsv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We track the "fixed value" option via two separate bits: once via the
global variable `fixed_value`, and once via the CONFIG_FLAGS_FIXED_VALUE
bit in `flags`. This is confusing and may easily lead to issues when one
is not aware that this is tracked via two separate mechanisms.

Refactor the code to use the flag exclusively. We already pass it to all
the required callsites anyway, except for `collect_config()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 5a03dbb452..1f673ebee7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -125,7 +125,6 @@ struct config_display_options {
=20
 static int use_key_regexp;
 static int do_all;
-static int fixed_value;
=20
 #define TYPE_BOOL		1
 #define TYPE_INT		2
@@ -328,6 +327,7 @@ struct collect_config_data {
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
+	unsigned flags;
 };
=20
 static int collect_config(const char *key_, const char *value_,
@@ -341,7 +341,8 @@ static int collect_config(const char *key_, const char =
*value_,
 		return 0;
 	if (use_key_regexp && regexec(data->key_regexp, key_, 0, NULL, 0))
 		return 0;
-	if (fixed_value && strcmp(data->value_pattern, (value_?value_:"")))
+	if ((data->flags & CONFIG_FLAGS_FIXED_VALUE) &&
+	    strcmp(data->value_pattern, (value_?value_:"")))
 		return 0;
 	if (data->regexp &&
 	    (data->do_not_match ^ !!regexec(data->regexp, (value_?value_:""), 0, =
NULL, 0)))
@@ -363,6 +364,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 	struct collect_config_data data =3D {
 		.display_opts =3D display_opts,
 		.values =3D &values,
+		.flags =3D flags,
 	};
 	char *key =3D NULL;
 	int i;
@@ -1117,6 +1119,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	const char *comment_arg =3D NULL;
 	int actions =3D 0;
+	unsigned flags =3D 0;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Action")),
@@ -1139,13 +1142,12 @@ static int cmd_config_actions(int argc, const char =
**argv, const char *prefix)
 		OPT_STRING(0, "default", &display_opts.default_value,
 			   N_("value"), N_("with --get, use default value when missing entry")),
 		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
-		OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when co=
mparing values to 'value-pattern'")),
+		OPT_BIT(0, "fixed-value", &flags, N_("use string equality when comparing=
 values to value pattern"), CONFIG_FLAGS_FIXED_VALUE),
 		OPT_BOOL(0, "includes", &location_opts.respect_includes_opt,
 			 N_("respect include directives on lookup")),
 		OPT_END(),
 	};
 	char *value =3D NULL, *comment =3D NULL;
-	int flags =3D 0;
 	int ret =3D 0;
 	struct key_value_info default_kvi =3D KVI_INIT;
=20
@@ -1195,7 +1197,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	}
=20
 	/* check usage of --fixed-value */
-	if (fixed_value) {
+	if (flags & CONFIG_FLAGS_FIXED_VALUE) {
 		int allowed_usage =3D 0;
=20
 		switch (actions) {
@@ -1226,8 +1228,6 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 			error(_("--fixed-value only applies with 'value-pattern'"));
 			exit(129);
 		}
-
-		flags |=3D CONFIG_FLAGS_FIXED_VALUE;
 	}
=20
 	comment =3D git_config_prepare_comment_string(comment_arg);
--=20
2.45.GIT


--6EoFNdB/DZJirVsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWXUACgkQVbJhu7ck
PpRRWA/7BLSC1PF+/UYG6uuqES7mexDUoPRRouiMsVIteza+3l7Mr30/Qml92Ihh
LBD7bq2sy+I/WuNOusP0/CdvQdSF22BgmpNKOkBnn3ht26I6BfEHXRnjHCxPsaEe
MH3c+d8QwRApiNCbzC/3cYBr9lUHKReh6ns4CKwn1VlOzl8236eRd+G1rpOV+nCu
CW+rpNCnhsWjNXUlGr5ixRq6oB12TAm+9Nc1W49H+tum+9B65mbc40E1Ksxhu+US
rRwUa9VN2Qi5jyhhzotNkKDyP1G7daTjmPjLWy9FWJ/h4wTLYTJdzyBHy0zMoLvx
hBT/zeoc6QEtwu7yPQ8Y47SmScXmFBAM8utiwTWZKCpxKwSy49Exy8Fo4HcmcbYK
W+zIOiaWWkz3DajX8lsiLtV43YJoST4N2XZof74a1X0y53qtTuoLrSo6WUcvhfc8
vYJ02Cszn1hDHx1D40U6l56MZ//18gOO9JylDy6oDPgTmTpgPCbRtrITuD9Ad/d4
ny14hRVnK29E+Uz02oVjoKfTIUhMj/tIUX/SgwsoGQlIoLF5ZQ9dJSpZp0CAJFC+
p3abyYhi8jDYJnf1gvA/F9HmCbQVR1X8ZNT1+xpqyMLsgM2whSBmsHJV68GXqb+k
cMAJhcbG3tMFLrq7GUo5KqjXZhf2XLRApNOKT/yjRxZxWp7Qagg=
=T1pM
-----END PGP SIGNATURE-----

--6EoFNdB/DZJirVsv--
