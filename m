Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7547C14A0B3
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595791; cv=none; b=IdGRqgJa5qxUPoTjSRQcEKjfE6mAdlUtaPwITe3JygoevzfUrNi3ex116jo/AiB3KaOksekjpLJFkSXeALuxd5LozcikTlj5xU+VvCsIgcrrDgxgtC6lLZ3PnE5klZQESKaQJHSBfDPbFFFGRdGxXHn2iFkmlP/9mY/VonCRjQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595791; c=relaxed/simple;
	bh=wKFiycv++UqKM/uMcRbrn9g55w9IPeMzxhQIisrFL98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OL0FBhGqPaIiIxF/IqnipuwmHa/Yh72f6Qk8Z2NLySAqt7rnn3ObRnfAnXeVi5uTsjcd2ZDf6s+h+dPMgLY7+LAKhoRRCSmfCQE2DgJMoFg8PlqN6snaruDBPBDk+LAJCEzyy6D+JyqXi+DrChtsSy1UQJUvlCTCDqNoT5q453g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N4wECiY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBATKGm+; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N4wECiY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBATKGm+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 816DF1C000F2;
	Mon, 13 May 2024 06:23:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 06:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595789; x=1715682189; bh=dI48/ibUBF
	a3LKZ8yvFIJi5AZcLU7Qk4IOTEvqCst4A=; b=N4wECiY6o5GfbSJK1Eix3QNcEv
	4+x78FJRjgb11q/pfyVCSqOYNPAH1q9lKYx3qvpIJ5d1mNQGbHmDA4U/nW0V1yrd
	g2TauvatcKRRtPWxqr8tP6voPyGWq/7WG0dDR4n/t0SG8GLoFivOuO4bNVqPiZA5
	Wj4/jmF5Csqye9KlN38Loi4gcEkLumb4PDWLTYIvuLwsHSsHyBAy4CnqaG57SHG1
	TVR6whAiJqlAgP8YWhTTFfmQrKQB+ivCM/xnUkEgw4oDPYXhSj8qsZkiypSIecrT
	ZrFePhyvs3PUMlV676ir/e41hQ00w/tTiEBXZF9zlpkF8vKeIsEo41fiBOlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595789; x=1715682189; bh=dI48/ibUBFa3LKZ8yvFIJi5AZcLU
	7Qk4IOTEvqCst4A=; b=lBATKGm+t0s7pmfBxtCoxu23s6rVtImHHFGWw4c6DVDY
	5tIzyzmCESz3o6bbUIV5ubCxnawZBfqiSk82vV38ofrxO9DoD3MjbVKJJ51gl4UY
	iYAyNSiofY53IHIew+FRvxJfJb+fRlQt96H30dQfJvIWwCtn9lOeDzcJE1NybR/F
	Fgd+v5FzGZD/Da4yQTyIA1b7lhYHoN8yuY4XBt3cYVBHQqAkQGrBdYyUBGPFwnAQ
	V4vEqCijW+C/NZVD1JCkZwmmDez6SzlO6AS3bFDIla0dZo6iJExlaoISS6ai7Ajv
	TeLEsK6faVICrDLh0vV4lRfULOO2RXmI4YEPzNhi8Q==
X-ME-Sender: <xms:DOpBZjbAI3LS47hVIXj1NrbVozU01nVuZzIEUrpwEbKHlKA2AmvR4A>
    <xme:DOpBZiZ3pwUQk3EozrESR2zwXoV_8vhblv7xlapXW4jUGR3JRB9xSAlJtxSIkQHao
    _FB0ihvEAuyhBTazw>
X-ME-Received: <xmr:DOpBZl83wp89-EF3wfRCa4jc8PcQAECLSLD-aNBVc-Cxmygg9a5MFdwmbVaMfXHsdwRJJBxe357fKip1h6_gGIGG_F8Gx23v4l-YM3EZdPTFR30>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:DOpBZppZ6DWhV7PK6mCgjuP-rh_N4MQkiRpRYbh3KVaXnh6YWkbhpA>
    <xmx:DepBZupGqhbjxKdMxNWkUICog70Jaschuq0FfhVVu1Ki43ct5tpGmA>
    <xmx:DepBZvQJ1W4Ot832BkWnGHQOU2HiElsWwZXvBxKCpu1T8zWeHXsZpw>
    <xmx:DepBZmoGNM8KZdnaVB4wstXSWPGeE8Ig6DkUkY-4PcZ9y3kJKgWIQA>
    <xmx:DepBZnk49B1n1t5Np66Trfe_M6RNIhG9UDqHPN2Pncb37ejv04326Y1b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:23:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ec6955b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:49 +0000 (UTC)
Date: Mon, 13 May 2024 12:23:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 13/21] builtin/config: move `respect_includes_opt` into
 location options
Message-ID: <8a6b555b58ef4db5d7fe7e427fb4d6403f228095.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6nj2F6ilmNnwiNmy"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--6nj2F6ilmNnwiNmy
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
index dcccb89037..3424d602f2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -78,8 +78,11 @@ struct config_location_options {
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
@@ -126,7 +129,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static int respect_includes_opt =3D -1;
 static int fixed_value;
=20
 #define TYPE_BOOL		1
@@ -774,10 +776,10 @@ static void location_options_init(struct config_locat=
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
@@ -806,7 +808,8 @@ static int cmd_config_list(int argc, const char **argv,=
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
@@ -848,7 +851,8 @@ static int cmd_config_get(int argc, const char **argv, =
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
@@ -1131,7 +1135,8 @@ static int cmd_config_actions(int argc, const char **=
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


--6nj2F6ilmNnwiNmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6ggACgkQVbJhu7ck
PpSFVA/9FkJlTVf2cGH5pDA3Aphz7xVXfo8q78UrQ2fTvd+VJMBhwPVCcvn+IIR6
QznRPvNaqXfxizR71OYCY2tYYPQhhulpu3KE6MuTtA4VIRF5XI+r2C8wmfhf0bh9
PskhrODbH0W0Jru++OQrUFlsfLTrEdW0t1n+V7APcul/fixSka78s9M86RjVPdXC
rSwQbVmZD4uzZQvpRXSHeBSX7Za83aD88M430qIa22BGpfv/7aE4ZIVtwgSL3ogW
y2CtBw2I4Iq9+G3OklJqRvvUjuYEWkT+KxPQmN9XJiFrwal3Ywaan/t6fVnmdEc3
RXDCc9tyJ26myCqG8Qbwn2M/6mIsYy18j4RO/N1Pt0sc60EdmmxiJ2LvokTQhv3d
X7PT2/RQLz5cOWpQ9vYAN6jJdBsUzqd1WZXSd8Y+DMbzdIyWf+NoN+D7Tw0/Bc6g
UIBuXPj+RvrPPHipGyJ3XuzEY27iD5j0YQM8AzKXO2LItzcJSibdh9VmZAdNsvfs
u5AgMGmNLlWo5BnCfdzIGm7hZKObskZ7weLRyrc1HbKQ55dni4W1wxIrs2lBweRe
728jmLyYe/ZQtm+kWHs8bm35cN4ciqD/oh/UDZa5kTBOCTPrf7zankB4YrUpTXAE
8EoF39/jnaRBx1dlBoMWMS9gqmYPHeSGFLSeUXGwyiVWTIvyOr4=
=wI1G
-----END PGP SIGNATURE-----

--6nj2F6ilmNnwiNmy--
