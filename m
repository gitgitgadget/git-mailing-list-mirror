Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D9E45944
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755309; cv=none; b=NpPpRIqIkUmcEfheqMuK+TjA+bbCrLuv78P8mc3zwQykl1C3jiDnMKslneJzlVIckjSAb2TqKQ+nB/14a025sj500PWswYNVT1TJ4/qJi3YzXtDoTUD3+817vgfLuMhGFJwxTxceSRew7eY2XJcEmjxZzsZKCSjxxFWqIONdsQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755309; c=relaxed/simple;
	bh=2Mj6+IGUpdoEpDnIWEcZKlHSzWEr3xVg9nuBLn5NdSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvJioRcX/HuqAdcGvmUeCwnvUMpFh6zEDNc6RQepp7F07mgibKHd3wtdKEZynWumYa1oMFpBt+ZKkBhP2+Yy4cTMqVKMAIM75/TqMCCv0IAuOrjwuwqbm0M1N0kK6MUvlf7RRdopyXgpgUNi6lEQkblhY4TQy+eJe9E8Ui0eoxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EJ7KwLXv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6E1PIsM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EJ7KwLXv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6E1PIsM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 815BF11400F9;
	Wed, 15 May 2024 02:41:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:41:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755306; x=1715841706; bh=ojazCZhhmX
	wEUbSdyk+zK69H6RZAOlE0MPq6n6p9Cnk=; b=EJ7KwLXvvbECXt6Has28AlQCZ1
	3l31COSIm+xl9NejKKePzuPh8ctX3hMlZwFTRMonkcriofncJLPDJ+7MCVrR1vy4
	48PTYXWIlVGJP8rQrw1UWT0Myq8mT8FbQQXW2nt0bc45SSbZI064+OMvXQYA6E7n
	bLi/HCDQgBjKxfAO+1uGzZhRWA8pIOX7Z2XUrV8c5MCVRlNiViBqeeZNgN02hln8
	q4/fwDd27LD8HBIchV5lyeROCgw/dBvWRmALiersUCwcWqfY6yNVbR2o1QiJ9L60
	mt6QQckqmGnnlt8sBUfZXF6Wa8fRYdMAxnX8K54jOZg0Pgt04hNxgcS+fK3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755306; x=1715841706; bh=ojazCZhhmXwEUbSdyk+zK69H6RZA
	OlE0MPq6n6p9Cnk=; b=S6E1PIsM+FTd8k1I+6NliLdhNs32Nu4XYELNce8oy7Ne
	J4q9eVeOZTSvgjGLYho4SBAIO3M0Hg/mwsVZWZyYtjPlNoR8s9t4rtIQX8Y4W7nE
	53DV4Fs2ee9AzjZPS5cjsjG5cCTTOXgJV+cFbMWgbA0YqD0ZXQvkBlwylMHLVXVK
	t31TGAtjoLv4qbN+Ru1CMwkZNSCu5PFRJ2OFNOT7IBb+551G92617gpDLEn/KuSF
	+4nTSTYtBZpdGGQjmG54yl2GsJlpxveh3a6upTpDayju5G90bxqgYg2KNiZ6rVC0
	8RX/eDofTIeFa4c34OwifMwPg/X+Zii6tF/H+y5d8g==
X-ME-Sender: <xms:KllEZmqp0npc9gwi-aNJv8sN3h99czyrUVv7pBOCzcfxdi3NnjrEyw>
    <xme:KllEZkp6lfEMYPqcW1shH1ugduqOSiyPHgBepDuk_5i_W7K3MoZoeL51O41e1xjWR
    rqCXtHRShwn_Td3Fg>
X-ME-Received: <xmr:KllEZrPlGwgjrZvE0YZUftmFXuQwT12P3SVEVKaUHyWO5N9YeFejC_XFs3wD8Ady9tk4NsFrKPEXIT7KW3wlVPf88tb-b-XNPGtVFgAb5owDDpqt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:KllEZl4LJ8Sx8O4zEOL_yeC8bbHsYvtJRj2C7_lM3v-3PeY0wdIldw>
    <xmx:KllEZl4PwtMtWGYh-2xXoMKY_yKklWTtTPNmi4O1hKctBQih0Ww0QQ>
    <xmx:KllEZlib_bLydHikZNiStXLn8htiUsI3SUVZhKPfXOC-pvdJ6VwY_Q>
    <xmx:KllEZv7FSQdOlnESaDyz9aPU92e8p9S-SDs-8VoIlrffK13qcaNQDg>
    <xmx:KllEZo3WIndO-C2u7PJNXtI-3dp9R8KSwVPIr6gZHAGN0Q3jyONt4_Dd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:41:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a6c814a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:23 +0000 (UTC)
Date: Wed, 15 May 2024 08:41:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 02/21] builtin/config: move legacy mode into its own
 function
Message-ID: <8b07b280a9a8cdadbffb649d4cadc8750ed797ba.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NcMovXEYSq9NFThM"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--NcMovXEYSq9NFThM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `cmd_config()` we first try to parse the provided arguments as
subcommands and, if this is successful, call the respective functions
of that subcommand. Otherwise we continue with the "legacy" mode that
uses implicit actions and/or flags.

Disentangle this by moving the legacy mode into its own function. This
allows us to move the options into the respective functions and clearly
separates concerns.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3a71d3253f..f6c7e7a082 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1069,31 +1069,13 @@ static struct option builtin_subcommand_options[] =
=3D {
 	OPT_END(),
 };
=20
-int cmd_config(int argc, const char **argv, const char *prefix)
+static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
 {
 	char *value =3D NULL, *comment =3D NULL;
 	int flags =3D 0;
 	int ret =3D 0;
 	struct key_value_info default_kvi =3D KVI_INIT;
=20
-	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
-
-	/*
-	 * This is somewhat hacky: we first parse the command line while
-	 * keeping all args intact in order to determine whether a subcommand
-	 * has been specified. If so, we re-parse it a second time, but this
-	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
-	 * line in case no subcommand was given, which would otherwise confuse
-	 * us when parsing the legacy-style modes that don't use subcommands.
-	 */
-	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
-			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
-	if (subcommand) {
-		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
-		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
-		return subcommand(argc, argv, prefix);
-	}
-
 	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -1306,3 +1288,26 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
 	free(value);
 	return ret;
 }
+
+int cmd_config(int argc, const char **argv, const char *prefix)
+{
+	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
+
+	/*
+	 * This is somewhat hacky: we first parse the command line while
+	 * keeping all args intact in order to determine whether a subcommand
+	 * has been specified. If so, we re-parse it a second time, but this
+	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
+	 * line in case no subcommand was given, which would otherwise confuse
+	 * us when parsing the legacy-style modes that don't use subcommands.
+	 */
+	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
+	if (subcommand) {
+		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
+		       PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
+		return subcommand(argc, argv, prefix);
+	}
+
+	return cmd_config_actions(argc, argv, prefix);
+}
--=20
2.45.GIT


--NcMovXEYSq9NFThM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWSYACgkQVbJhu7ck
PpQwtA/9GqfwcSRbYfJf+RyrRp+TilIgWj0LeArRL28R+Smliz6fpVugD6LCyY4K
v4XfdnkJgTfoZV7K5IwnXp4jImTvS+T+hJHMl+da5tBFUCWbMoT7eGQjP2qvqKCO
JGfE2A0QCEayle65lz+oMtwlds6LSEla2scfh+fIU4PvPWKhMbAOKhox5ltdYDNj
izdbqBL5SChO1H45B34YeSkzM+Qb5n39jHXA0BUDprOz21ELKUCS6ZJ39pHrQj7b
yn68XDRMQ/awfZGVvIir13t1rH3ruB/oI8sTOy3enqFVc5FRRb2xg+o/ihhvuZWK
N3XFf5ghYMGOFXDgerb8SR9a/GzZYej/2z0f6VncYx0EJdBiuhTrqVH0aFbImZYN
A1CuqYEA5vxQkbTzu0Hiuz2Zi39AFfQIFIXoFLwO87qz8Zc5KSlljyZoZq8Y53zM
d8bM4KbsrQPoGE/01AIXPSBY9w4mxrwaZ/mZXer6KzC4MqgGd99O8aua8edY0klq
FMcrbizmTyLDoB9u09I3LaFfqmF+VjkY1gb+4RhXw/riWQ1JqEDtofAji2ECYmnQ
FFxy9DsurD48YHMMeDVyxmA5pM6UXL9rdcCgOK2vj0tTYIhdPAClElujP04jLomt
JgTQc+tSSHqzdzxmoIlSCMnbJnN73ZA0UtbkVyIYJ3goBk0/Q+s=
=9zDk
-----END PGP SIGNATURE-----

--NcMovXEYSq9NFThM--
