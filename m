Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E13EA95
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755360; cv=none; b=J9X8EXIaakn/bOHNbQ2UZDRyN/pOqjc1s5s0ow89014yRQ6+kpQMctPBNeL3td0uYD3BBPGzkIYaQkVhsjTrSvAq1Q1qUbE+JTd0RjtJKiJLzpstw+d0p0a0W5myVdAP/ZRgAdjCzMkzo3J6dsB6wrv3RDQqpulKglPfOZuzXNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755360; c=relaxed/simple;
	bh=Fef3VV9Xl6ZgF0Aj/2ts5PacsjR2n+9nLxKmawVd5Do=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDQNL5n1b3j0yvz+o0JgT/+jNqi/Tg+lLSpE2dFTalRwVOhH+a8QvLA9TbGVwXF3QTsdR0z5BjLY/hgreiTy6U8B/PSG/3MoyME6R/qUgOWe9aunyZSiFzmAac5D596Rp/NtY1p04N6tXKHqs2tTjLo7Eth7DNmvN6U7gCL17Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rfAdCwwB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2HgvY5p; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rfAdCwwB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2HgvY5p"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9D3F611400AB;
	Wed, 15 May 2024 02:42:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 02:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755358; x=1715841758; bh=tjf0GGkobq
	slKo9f90P1O9wJtLv2o7WYdiGgAOSPR2o=; b=rfAdCwwBJUBZ+G7mSR10VYLiDm
	6RxSp54TWDq3gvKhLL5O1i10HTVfjvieNPSpWEfUVYosAuIqfuj5r/oNStyoQbu6
	9iOjz6NsKg6Y68JpnXoNHfMzvoB0jqRoZK9fv6C9f/vqfCgUs7vs3JgAQlydMmKw
	N4ZXMDo+NQFUNqZoJ+Sn0stTfk88vFIZ2HOquJ5E1MLD/9fQ1ezWlq0H8ga80TlO
	I8I6/lm5U77UfxBHX0Mo0AW+IdXcPqFdeeFzijXoc5/sS0ddrm+aeKzqSJGsukj+
	2QVbHZm2bg+FqKTwwzVPuYBFrG3m/EHfg2HEgPPtP82L+okvHX3AhqXa7EhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755358; x=1715841758; bh=tjf0GGkobqslKo9f90P1O9wJtLv2
	o7WYdiGgAOSPR2o=; b=P2HgvY5pK9Bxw2Dj/PBnVhIzEHUDb+A9frRWphkVEjhH
	/9+7Q1UWDD/zyg+mVCF/pXBfTfy5zrl5xU034tHGinWCklvvuMkj/fgyBNPfMTwP
	i5kFU9wsv36SypKZ7ugI2lRtRUI7Knee6M/Qro2KMAWv5EWPlNt+vXiKwXQrQLEt
	JTeEnCgIBOFu+Cch6kIOcFimMGkhyktadbAFz2eE83xywL3Io/Ix6ptuptgTrtBj
	ALqzTtHe42A2GBpkuqvzZT7LCfqp7PPweZTZ/Behz3fP+G9ZwrIirkT0Ms1eHNt4
	REsHHWglAy0kKgBwGwlv9UlmRaaf2FHtLk0SvcNHXQ==
X-ME-Sender: <xms:XllEZkVeG1j2_7lHiouKre9bwT2waUWHZzaFkao-42cBh1mG2Iv09w>
    <xme:XllEZok96x9Cgb1qWLuAYj3lVL7-ipZBOca6n1AlPwAaY-jyKWqvi2M31EnlyCBiY
    ygLSo-7ffQLD9wR7Q>
X-ME-Received: <xmr:XllEZoahHnCgRxMiPY_aki5Vv2NXAp2yyDFvGLiG-U9w_hUV4Xu4pj5EzWKeittwsw-L3cihz_239-RwU_zVl1g5vYeNxu8zklHNRlGUPgCtgJuh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:XllEZjWWlKI5ydPI_ydlv3zcPZf7yFzbe5BxLN8xDlzvRy7mJEniTA>
    <xmx:XllEZulWV2OL24gpQBqNeg9AC4arpri3CkEdZMSmC8rWaMSqlYoKOg>
    <xmx:XllEZofz93G2qz6v-lfYBgpQ2IAQJaE-5UcZCO-k8i-di1jGwx7FPQ>
    <xmx:XllEZgGMb1B4jReuXgCoxDuRvutdKZG_WfCCz8Vjj6ZfeFg7WyDmnA>
    <xmx:XllEZvA5bNYWUd877pLRoQ_d8zGhp3CNMhpLDReDWTmxf3AurQL0pTca>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:42:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1be3ff23 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:42:14 +0000 (UTC)
Date: Wed, 15 May 2024 08:42:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 13/21] builtin/config: move `respect_includes_opt` into
 location options
Message-ID: <15d45ef7d42d49623577f9b856e3f791c9a65948.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zWFoxoM51ePRRm16"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--zWFoxoM51ePRRm16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The variable tracking whether or not we want to honor includes is
tracked via a global variable. Move it into the location options
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8a327e770d..c54bdcbcdb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -79,8 +79,11 @@ struct config_location_options {
 	int use_system_config;
 	int use_local_config;
 	int use_worktree_config;
+	int respect_includes_opt;
 };
-#define CONFIG_LOCATION_OPTIONS_INIT {0}
+#define CONFIG_LOCATION_OPTIONS_INIT { \
+	.respect_includes_opt =3D -1, \
+}
=20
 #define CONFIG_TYPE_OPTIONS(type) \
 	OPT_GROUP(N_("Type")), \
@@ -127,7 +130,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static int respect_includes_opt =3D -1;
 static int fixed_value;
=20
 #define TYPE_BOOL		1
@@ -776,10 +778,10 @@ static void location_options_init(struct config_locat=
ion_options *opts,
 		opts->source.scope =3D CONFIG_SCOPE_COMMAND;
 	}
=20
-	if (respect_includes_opt =3D=3D -1)
+	if (opts->respect_includes_opt =3D=3D -1)
 		opts->options.respect_includes =3D !opts->source.file;
 	else
-		opts->options.respect_includes =3D respect_includes_opt;
+		opts->options.respect_includes =3D opts->respect_includes_opt;
 	if (startup_info->have_repository) {
 		opts->options.commondir =3D get_git_common_dir();
 		opts->options.git_dir =3D get_git_dir();
@@ -808,7 +810,8 @@ static int cmd_config_list(int argc, const char **argv,=
 const char *prefix)
 		CONFIG_LOCATION_OPTIONS(location_opts),
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
-		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
+		OPT_BOOL(0, "includes", &location_opts.respect_includes_opt,
+			 N_("respect include directives on lookup")),
 		OPT_END(),
 	};
=20
@@ -850,7 +853,8 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 		OPT_STRING(0, "url", &url, N_("URL"), N_("show config matching the given=
 URL")),
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
-		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
+		OPT_BOOL(0, "includes", &location_opts.respect_includes_opt,
+			 N_("respect include directives on lookup")),
 		OPT_STRING(0, "default", &display_opts.default_value,
 			   N_("value"), N_("use default value when missing entry")),
 		OPT_END(),
@@ -1133,7 +1137,8 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 			   N_("value"), N_("with --get, use default value when missing entry")),
 		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
 		OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when co=
mparing values to 'value-pattern'")),
-		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
+		OPT_BOOL(0, "includes", &location_opts.respect_includes_opt,
+			 N_("respect include directives on lookup")),
 		OPT_END(),
 	};
 	char *value =3D NULL, *comment =3D NULL;
--=20
2.45.GIT


--zWFoxoM51ePRRm16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWVoACgkQVbJhu7ck
PpRWHA/8Dj5WLUo8nIHgOoCyqUjvKLb5eJA8teLdrTBc/N+j645CHJ4GRu1UYt4i
oi8RqK4hj7d1jLOplK4Ahzmbs0UDCV5KQ6ox7jbwskPPk1N+fAzP7/4Hh7iF9xER
NE5R+UzX16r7A4Ly02ox4OvDkOH4QPl3D1EhcJaCaXhPhI3CFxCBV5vpOIs7WutD
COIjz/6/50ASaOZjDuwDpAPpH+vxBYMk7qstX5n+4K2Eu6OYyRZKogMyaSe9QufT
RhknSEdIVKjHDgMQznTiX3DWt66q30g68rK0YZd8slCMyUoSps0pnghjxV8PG355
oYX1eHfXL3mx/ypeRXyvZ8h3pRW/lkKtMLd8wAR8faXkV8emHhHU2eFooEy9htvl
x5TsqJLPYjzKopZyDlyB8X37k9M6iALDxgIYHAoUkAsr5VXio1H+eTgPh1hkfiiw
oNWNlo40ysvKdZDcrCWpRm6EnfrrlHYYrf5DPAM3Xez5NUdTkmBcoc+YLfbimeeP
x/GRXosfW5blTr2X5ca9LNrghM2kkH8+/5GyOu39q7PS+tUyZJipl/2Wb2ICDzFD
e6MNsi/pfNkVaio+htL4HF24HKIGHSjynX6Q6iIdAeHj3GLZROv3GZqmM8OjS56u
Yikbi0LT1qxm4WN/WECKo65f7XdqK7wEWq4t9uTEr5YBLXQ1UGE=
=rE8A
-----END PGP SIGNATURE-----

--zWFoxoM51ePRRm16--
