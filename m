Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4487B17164B
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340328; cv=none; b=VKwNMBjEB6VkkZB6Fh320Jm2LhifFPAjmaqSE4DTL8QW6fpRlS+uh/O+L1s2Gwa8pnqPXrNJpyRCfokEW4HYbIBhA59k8mRXzo0L+fkcJoqO2MSF8SF633TF72QGd4cI8C3u+IItQn/KEC13N93KO+y+zTMAv9oroJE3vWI02Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340328; c=relaxed/simple;
	bh=jXVDjUN1nrYYJZMQ0fa/b027PMfgBEKwLbx8MWB2qRc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBOwdEZfLAWxZkdkLcMmP6zsGfMIPhlQcxMPEiRJiEvdLTQ4b/pPx+eRk6LBYa5tRtuZ1uKpWyR8C/C8Od1zoX/lwL2Jn8T+h8hoVhjTXNRquBz7G+NazjiZDI7L41EgsxYfXFBKNVUQvKQRk6jBKEj8l69ppzEsUm08ndBVZio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O5bAmswh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JBakioU9; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O5bAmswh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JBakioU9"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 9351D18000A0
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:25:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:25:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340325; x=1715426725; bh=2+KdOU38XL
	uDpznGVM19P+VSpp8RlC9Vbmbr5VKq74g=; b=O5bAmswhMwhtQL2CKh8y9wLS6S
	turo4K6WUKyNLH7aUj1Z7hJ/Hvp4uM4P3yVXGaZFJC0WJwmXBdHJlyHX/MYJUpRD
	9lcEpvQ7v3AM76UX/eG2hKxHfQufrUPsD8pavYKa9/O1jBNuL6ACyt0qKFKGSdu3
	Kw8hk6nimI8JlFAmKc5uy34KC8ULYlB8kaNvXqF/A0RkTXM3vqtBbuRuMS9P8m2V
	OAbahcWnYL9Br+kud0tvwsy7BPGvLcgjNkqlJ+GfXtFntQiv5B1Qa53yGO835Dxv
	tEpxZ5EegzR+ybJBAaT7UJV/lcxGlOBXW9Wjgw9v0rrYSrS/J8pZxIoLMLzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340325; x=1715426725; bh=2+KdOU38XLuDpznGVM19P+VSpp8R
	lC9Vbmbr5VKq74g=; b=JBakioU9TnSSITVqI8mW3HLyBKQ7yvSxGUwkbFyL8lm7
	7/DV8V330KUPgQKxHeHbiMDWS9E8/DokT3JQFA0nrfGTpY8DDJgji1g1i4Qa9qrF
	28Yze28k0DZGwKAHJ22E00hSA9elmm1A0Xtn+cOOzJyvNNpPGYjylh1klnTEHA37
	lYF1dUl5EXgQ8qI/du1i2guQ51q3JADeDOc9OcShJrCzlhLGQI4EF5LA0ccE4K43
	STtJXezWf4jmDvvwMZjYf/eUhXupzKOm3zVvm+hwapqih97lFO1U2fJYJZtsd/sN
	//fowI86CE/PLMb8QHSDdRpMUyCiBzanQ8+ps3qiMg==
X-ME-Sender: <xms:JQQ-Zs-pMnyF-A4Wx_LqpPRTVqljG5ZV_LD8vWTnWi5mSsG0bA0NIA>
    <xme:JQQ-Zktj7Lp8ZRoxl3wuisMG4aUQcvX1MzPV4ewif7T_5KUM3Ha1XLNRAvwKOTuQA
    zHgYHspgaVpK3p8gw>
X-ME-Received: <xmr:JQQ-ZiABYIIuu6PUDqERcVw6eKsThKLLUc4Wy_G9qLp3lRydrsMZEjXRvqNmYH58lMmJgBzUL35MWlqZaZQjsGSh988nZvrcAFR9hhjY8nKEGymtSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:JQQ-ZsemRtLuWIEs8vFNAOSWtfi-d5LD2bTK7NSS1T8QbbgiqyTZXQ>
    <xmx:JQQ-ZhORo4_XvLisXtK1MqxxaJOEQU-ErYRfw3SogLbiRaswhGTAFw>
    <xmx:JQQ-ZmlzZtWncpPAtboqxcGY6LJA7M5vo0GQ8kx4QmeHKf2NqVYfJg>
    <xmx:JQQ-ZjsLuc1z8ZgDyI4LUQCgrXp2L_xQ_0BkTWv1XFonOrcP1eX83A>
    <xmx:JQQ-Zv0jy8sLKAC7pUPizlZJdMPu17zL36squuOKo6sb9rjj-MI3kVme>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:24 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5d3f73d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:11 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/21] builtin/config: move default value into display options
Message-ID: <eb7946286177058405946d520708f32fbef76e84.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9dOoWd7V8hi4PYPT"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--9dOoWd7V8hi4PYPT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The default value is tracked via a global variable. Move it into the
display options instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 1f864f71c4..eca5179f5f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -107,6 +107,7 @@ struct config_display_options {
 	int show_scope;
 	int show_keys;
 	int type;
+	char *default_value;
 	/* Populated via `display_options_init()`. */
 	int term;
 	int delim;
@@ -125,7 +126,6 @@ static regex_t *regexp;
 static int use_key_regexp;
 static int do_all;
 static int do_not_match;
-static char *default_value;
 static int respect_includes_opt =3D -1;
 static int fixed_value;
=20
@@ -415,7 +415,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (!values.nr && default_value) {
+	if (!values.nr && display_opts->default_value) {
 		struct key_value_info kvi =3D KVI_INIT;
 		struct strbuf *item;
=20
@@ -423,9 +423,10 @@ static int get_value(const struct config_location_opti=
ons *opts,
 		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
 		item =3D &values.items[values.nr++];
 		strbuf_init(item, 0);
-		if (format_config(display_opts, item, key_, default_value, &kvi) < 0)
+		if (format_config(display_opts, item, key_,
+				  display_opts->default_value, &kvi) < 0)
 			die(_("failed to format default config value: %s"),
-				default_value);
+			    display_opts->default_value);
 	}
=20
 	ret =3D !values.nr;
@@ -848,7 +849,8 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
-		OPT_STRING(0, "default", &default_value, N_("value"), N_("use default va=
lue when missing entry")),
+		OPT_STRING(0, "default", &display_opts.default_value,
+			   N_("value"), N_("use default value when missing entry")),
 		OPT_END(),
 	};
 	int ret;
@@ -859,7 +861,7 @@ static int cmd_config_get(int argc, const char **argv, =
const char *prefix)
=20
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
 		die(_("--fixed-value only applies with 'value-pattern'"));
-	if (default_value && (do_all || url))
+	if (display_opts.default_value && (do_all || url))
 		die(_("--default=3D cannot be used with --all or --url=3D"));
 	if (url && (do_all || use_key_regexp || value_pattern))
 		die(_("--url=3D cannot be used with --all, --regexp or --value"));
@@ -1125,7 +1127,8 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		OPT_CMDMODE(0, "get-colorbool", &actions, N_("find the color setting: sl=
ot [<stdout-is-tty>]"), ACTION_GET_COLORBOOL),
 		CONFIG_DISPLAY_OPTIONS(display_opts),
 		OPT_GROUP(N_("Other")),
-		OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, us=
e default value when missing entry")),
+		OPT_STRING(0, "default", &display_opts.default_value,
+			   N_("value"), N_("with --get, use default value when missing entry")),
 		OPT_STRING(0, "comment", &comment_arg, N_("value"), N_("human-readable c=
omment string (# will be prepended as needed)")),
 		OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when co=
mparing values to 'value-pattern'")),
 		OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include direc=
tives on lookup")),
@@ -1170,7 +1173,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 		exit(129);
 	}
=20
-	if (default_value && !(actions & ACTION_GET)) {
+	if (display_opts.default_value && !(actions & ACTION_GET)) {
 		error(_("--default is only applicable to --get"));
 		exit(129);
 	}
--=20
2.45.GIT


--9dOoWd7V8hi4PYPT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BCEACgkQVbJhu7ck
PpTN4g/9GhWO6csUDZj4NF+EaDChDkcFyxSVzZKPtIfUD/XO7Gnub4shO/P6bLkM
kTzRRufHXXZQ3hfkUv381742uOtbgWaWNlcDl37M2Ack2k7M8q/O32oMO+BxHGBp
BI3aPo2hiCBHc10lDTLj4qxVYx6oX6DNR/X7VUKepsRWZRYpO47Sxq6U6QTvacke
nlcKD3+UH+UpSZWT73IGNA5KqTG5piJeLNPJeOjyp5jUDq6HsCo5S776hR4m+5pm
F4zB8poc0rpJkewpamdBVY9y+Rg9S5+C9BsFKDrUUkn6v8ks+Z64f68on3rhbUg7
LoMs7RY4ep1V20skjut3N52v5P/K87V/Z6zz1dPvvvGabIWzTPTjYjsEThR3Aj6I
ezN+ymEM+QMnzwtcOL717oalT5ZHJmRBOdJy08K0IL28ItlJQGyU7CbmhqrESrkw
MKEAmvfhz9Mwu0+NTVq9G6DcQbzGtKQBfymN0DR8lW7KF47Pbz4q6bzyNDuOyDWs
OqGgk/CcvA0cJCuZ9i6M0KCu2Pz+0YDEdv6DFBDMoc5VBexsTiwZ5a/6NkhF3xig
DqV6cPyX8yltK4mDyIhCAecXF9PutNOIZHdR41XhO1mNZu7S+GIBHkIxT/UZ+Jkh
oSEWGO3adeSY7dFj+ouurYHM+5sJrD/dkJQaGwR/LDk1gJZ+igc=
=us9t
-----END PGP SIGNATURE-----

--9dOoWd7V8hi4PYPT--
