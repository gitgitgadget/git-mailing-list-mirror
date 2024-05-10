Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BB171655
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340333; cv=none; b=Xf6SaRCluEef1y44zmgUd0DLmlBT6gCgbscsfacNCuDYB9tw30b+MIV605/WbG3+4a22/5mPkwDpANvz0LrHSo7WRCrL+iUQnr90H/n5CrngquSJPXwMTauXOJ6XGvgALTCtXvaNBsDNwOZKNNQ8xSDaSwXn5iXhWucxULhQ7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340333; c=relaxed/simple;
	bh=A7am5XZEJO/9I+CFBgqo866EJYKJsAl9YZ7vEKWWW2c=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6LHyazH8bfzL45IMNDrcVuYMD6fVIk+7Wjmlu2gys8jvhMEY/YpzkXN0JbvtP+GsQJUNp5UZiLgbJU6XcVGd9293wDApZe+ybC4xuirUnZGewOEXsqA5ZNaLDv9U6c48gxtY+437ljDtZbM+5hJLUQSb2WPw2kA6VkAgqLa51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P/M0tB9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P+acLU7D; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P/M0tB9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P+acLU7D"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 0F2341C00098
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340330; x=1715426730; bh=8AtDzK+N8E
	07RuFjO9WAk2d7HQpaHl9r4Mpd/noT9Ro=; b=P/M0tB9bfzmgWW3Qr/zlf/KIxS
	NjreE+g9EuVU8CvO7HZg8yjZnIAUSQkGECtvv5caxLz+U0d2cw8iEA1s+mXhL/sc
	zsXMS2CZE6/QbCSReZdyqnQ8dmXsYkN3ijRzWFrvAP9d3OD/VZTKVEPRNVOD1a7R
	qvnLQsDts+97YHG5d1tuA3sAtPST4CarU+s+btdCYBK2wX8cvew1LhffDtBBGspH
	5kwXWqFlqKFyVBLn232+t6ni37j26BYjGkCj7+78JV2ha2OI/iCuXNlYKzdKkJkV
	OWv1PeqCkLGqmx88pHVAATF+WPTo8OPbWzr/wginPcH1xFrVe1z8Vf7kYSig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340330; x=1715426730; bh=8AtDzK+N8E07RuFjO9WAk2d7HQpa
	Hl9r4Mpd/noT9Ro=; b=P+acLU7DomXVeY6bxGSNodOAfT25yWvW4VHPWSJxa5ga
	JaWx4zyjXameq7qNZ6euntNHTdpPIdU1HWz3FSpUz0y3YjkKxDd4SRfiw5kyRgNb
	Bk/Yu/BzFSu3nymGEjWyKy8jPQ0AE1BB2q+wWlRRxtgBQSsh3NwgcuRC9E9SstZr
	KcR2IvisK7ytOS7QB8EnxUoqR3ixHTdq80KRjpAmp4+NaodF8x8Cbn/PQFC3xf4d
	Cenb9u695tufzagKnhqYtrAXRqbhcXHJbYPWxz1vNeavNCQI6naV1sLkyRGT/yEB
	2AHvP2DrVOBbkE3GfptiAM4IYcKsywYUizkD3XSs6w==
X-ME-Sender: <xms:KgQ-Zqj63Z8vD2JpH9HMOUOPtIlSOBY01DM7TuqDi0Qj_Umk2VtG8Q>
    <xme:KgQ-ZrDFjItkxNtoshllIanKm3Ww610MHegG9DC9pMuJArP7hRLDJ--kSa4wt_s54
    xhyHRBKODoMHd0CcA>
X-ME-Received: <xmr:KgQ-ZiGkLLqV0kQY0IRZZs_0CQWnVERPANHBeEXC_X95BQLjKxIy1tXVW4Fpt6dKK5ueS5wPFoa3fmGLPmKvse2plw07rnjWq7zj4n3OPM0CtDGlow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:KgQ-ZjT0xpGW1bXu4PhitBUsZOGDM3c0s7QwdaJ4uw0xUg9sWMisew>
    <xmx:KgQ-Znx2UEWv84rwdShavLFX8nwcLGNuBi8cjGDhqIcw0R3n6nMIXA>
    <xmx:KgQ-Zh537BB35a5xmIqWEtQvo7pM8YV62ittnjF7zweaSNMwa1lbAQ>
    <xmx:KgQ-Zkw9-e3BnVNkMENtqTeYa7-SmK9QGWVV_X5cCVvNiwOQOPin2w>
    <xmx:KgQ-ZgrSLA90Rtcvugmdo0NVv8l8K12wUTA6wlH12Uu4Hj_EMuGOHBZK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f47202da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:16 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/21] builtin/config: move `respect_includes_opt` into
 location options
Message-ID: <b9ebfbd667d0ff0d500dc1088a4352d666fc8570.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BTndjL4LrdHM2x4T"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--BTndjL4LrdHM2x4T
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
index eca5179f5f..d11d0b4784 100644
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


--BTndjL4LrdHM2x4T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BCYACgkQVbJhu7ck
PpSZ9BAAm7RWlYZ2w6Vyx/xoZzv5RpztwWKBsIkBMqDEoWbZdqfWE++Szz2cn4yd
710pEG4GIkJe4I5HDd953lkVHBY5fw0vKEJ5mlpGfhoFupPM4PfdixNjd1x5lxZq
U+ML28p3eoqq0PTpOOAWdi9m+9CfPuaZ+U05jQtUXMYH86wN/KnmAIMLvBQ9rhbH
zmuUFEEcpRCvBup1nORgDGF0uP9W+x9cU6N9mZ5sySspRLbm5SxrN0tm5tYqhoA3
5QyYTnbs2iTtgQtqmJzUNEUJx666EApBJG1lUdc2o09iwnj4nVTD6mXg0/Pbxbz3
qRzWZj5+DgeGk5FmHE97hgnRFMQGpkmoGLRNqZ68h9Ynxqz0a0OEsWRiOgI8q8Xm
LpYJkoF8AGRZZU/b6kDKdX+0/nFgWAZM96ds2zfVMf9qMFWu6XUsippnOiixR7e+
1Bqzccmr0F5yGw0bG77w+Vzjhm11d1DLZ6dVQh4nMeaC1/WXEPMOAS6THXDGsA/E
hQOHhvNGtKrKthwUsRSa5NwAJBI9zaciynTVrcmFCF/EdP2UEQAAhEm/qz+slYHs
O2zdG4aszrE9CFVRdVkY/O2sVXZGZXdTHbCWYmuZLpZ0BauLzRPbNkbU82WiQQ7b
PJszkn+VtIIsG7Ya1RwAeADEKd1RNTVaWcLfn3WJef6MFwqGbSw=
=eybS
-----END PGP SIGNATURE-----

--BTndjL4LrdHM2x4T--
