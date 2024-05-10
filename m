Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFA1172BCB
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340372; cv=none; b=Ccwq7Tqr3qZr0XA5cdzWbYNneS3aiKMlVip7LUdAvVOHF8+exoFARKwTtPWlBipwQMQAA+fDPTXGDFDMuU4bmdfDkGy7tCwIuPEmMbfU+H5seH2OeES+Eou0SQWOMoqtt+mhjeW7ECWTa433Q55fNsPneWZ5xrbD3KUe5gY58yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340372; c=relaxed/simple;
	bh=ZXIuJbZVLx+/2gobyieSpUcCmrzq4hJ2u/DyULi/JUI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6gq5xgvJVov5QeN+imxxFOI1M1loK7iPGS41xnEPB+IW1cUBNE+PewAdys8sN7XG9RgoTJ5GWP//P76Fq2qKMJulhqNdrvID71yP4jQSTuClwP1E4yTriRdwbI7OklHbvDjmyKMGgG8174sL3n7H5ZUcpkHPX0l3I7578j8B9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AiWPyvwD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PnchUF9+; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AiWPyvwD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PnchUF9+"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 79A261C00098
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:26:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:26:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340370; x=1715426770; bh=//SFfkeRuj
	ruQIUAlXSQ+/LT5NPVmkd3QqKz5wTVb5k=; b=AiWPyvwDSDDZClAf8/i3vFkCQF
	FwsirADJHf52kFj7314TdZHaGHQ+DzmyR6TW/SgaYeY0BIYJVE4EGUE5tFvW8aGC
	DHI7eSKDhCLc6vPaGv8EAashA3jPxPkdMLhkvp8q8Aqc/poMI4R1FJtbR5sr5+RP
	r/ETPjSftfJqNA8bNMrtmzNyjXJ/+monyeXoTw0uy6vcjnB4NFCxUcxKcHUObE1d
	JiCrPt4GnND6dgojexL9RHUlxP2hpUuMN7nHeZAjh8doIhAHN9Cr78EucX9DUue+
	3jySKzNYc22twJvOh6d8/2UPSJI8J8PMQX7gUQWQbhre7merLc/qrl93u+fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340370; x=1715426770; bh=//SFfkeRujruQIUAlXSQ+/LT5NPV
	mkd3QqKz5wTVb5k=; b=PnchUF9+uf0JeZZtzUHE2QWbZVjrwxy8yHsDTxH+e+Ve
	voBmzRBIWAliyywfOF0p+ezO7Chg9JHYbwHR4vQw7Q9/UC3D98olw3Fya44/M3li
	9MGjb5QO4bsDyB8XiYkoyvhzecPHmy+L0s1+8JEZwx6+tCXJv5dNoxxFwuJOBIic
	9v5lJ+pZ/B0nHBXwdrKBiIopMVcOB3VBMZNvOSUzr05hE0rpq6JHoCCVOJLynZ46
	pgniPcwM0wD566s5GnDGb3EFmYAk+kswbKwBrLfqqIZjLVxEGWSD0QsuGeqVHf81
	2jwm3jnbwkeQs4OypUkTFLSBO0DzlYWxZTaAD5ALOg==
X-ME-Sender: <xms:UQQ-Zp4xiFFGp0UTw3X3Sgs8wiUwXcZLe8zQEVv7Tzs0enLTcmmwLQ>
    <xme:UQQ-Zm4wLx0RAEydqcoB0JLg29uHBIV-cOsIl8wQs7Oa68RRe4sdDzG-QWT7flQcI
    EpVl2D4nAcQIP7Z3Q>
X-ME-Received: <xmr:UQQ-ZgfLYtNQPV3BXd2yqeD7DPwV5an1kyZrM-X2zw0z7-hksxE6a4JR5SgfrLRFPejYRZgxSpOKUZqbm_UJY3MdRcSnD2a8ZPkdsHQCFBvOm5YiCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:UQQ-ZiIo0ETZXBqmLe7iAh6sw4ClBWoMNtCvw8WEWyokmDVdynZ0zg>
    <xmx:UQQ-ZtJmSwg2MUIFxwBlyUkbzMxeWsiRHY1m7-U6vNVaGNlAvyPVPA>
    <xmx:UQQ-ZrwP-qzU7K9bRvFoxFklB6Swks3jRZQzBo8EptQQPBi7HX9WBQ>
    <xmx:UQQ-ZpIsiUwYQvXdkswQAtVl4p6fb8eiI8VgPD2IhZbXQAIPMISpeQ>
    <xmx:UgQ-ZrhVAy4d8J9Fiqug_Gbm2Erq4i2baV5hqRp5SeBB7VqEKD8kUQnf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:26:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ae43f801 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:56 +0000 (UTC)
Date: Fri, 10 May 2024 13:26:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 21/21] builtin/config: pass data between callbacks via local
 variables
Message-ID: <3a5f059789ae550002e08155faacd4bb3998a489.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zE/WnIZb0e9znfnm"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--zE/WnIZb0e9znfnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We use several global variables to pass data between callers and
callbacks in `get_color()` and `get_colorbool()`. Convert those to use
callback data structures instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 90 ++++++++++++++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index bbb6864453..127bc097b2 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -517,21 +517,24 @@ static char *normalize_value(const char *key, const c=
har *value,
 	BUG("cannot normalize type %d", type);
 }
=20
-static int get_color_found;
-static const char *get_color_slot;
-static const char *get_colorbool_slot;
-static char parsed_color[COLOR_MAXLEN];
+struct get_color_config_data {
+	int get_color_found;
+	const char *get_color_slot;
+	char parsed_color[COLOR_MAXLEN];
+};
=20
 static int git_get_color_config(const char *var, const char *value,
 				const struct config_context *ctx UNUSED,
-				void *cb UNUSED)
+				void *cb)
 {
-	if (!strcmp(var, get_color_slot)) {
+	struct get_color_config_data *data =3D cb;
+
+	if (!strcmp(var, data->get_color_slot)) {
 		if (!value)
 			config_error_nonbool(var);
-		if (color_parse(value, parsed_color) < 0)
+		if (color_parse(value, data->parsed_color) < 0)
 			return -1;
-		get_color_found =3D 1;
+		data->get_color_found =3D 1;
 	}
 	return 0;
 }
@@ -539,66 +542,77 @@ static int git_get_color_config(const char *var, cons=
t char *value,
 static void get_color(const struct config_location_options *opts,
 		      const char *var, const char *def_color)
 {
-	get_color_slot =3D var;
-	get_color_found =3D 0;
-	parsed_color[0] =3D '\0';
-	config_with_options(git_get_color_config, NULL,
+	struct get_color_config_data data =3D {
+		.get_color_slot =3D var,
+		.parsed_color[0] =3D '\0',
+	};
+
+	config_with_options(git_get_color_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (!get_color_found && def_color) {
-		if (color_parse(def_color, parsed_color) < 0)
+	if (!data.get_color_found && def_color) {
+		if (color_parse(def_color, data.parsed_color) < 0)
 			die(_("unable to parse default color value"));
 	}
=20
-	fputs(parsed_color, stdout);
+	fputs(data.parsed_color, stdout);
 }
=20
-static int get_colorbool_found;
-static int get_diff_color_found;
-static int get_color_ui_found;
+struct get_colorbool_config_data {
+	int get_colorbool_found;
+	int get_diff_color_found;
+	int get_color_ui_found;
+	const char *get_colorbool_slot;
+};
+
 static int git_get_colorbool_config(const char *var, const char *value,
 				    const struct config_context *ctx UNUSED,
-				    void *data UNUSED)
+				    void *cb)
 {
-	if (!strcmp(var, get_colorbool_slot))
-		get_colorbool_found =3D git_config_colorbool(var, value);
+	struct get_colorbool_config_data *data =3D cb;
+
+	if (!strcmp(var, data->get_colorbool_slot))
+		data->get_colorbool_found =3D git_config_colorbool(var, value);
 	else if (!strcmp(var, "diff.color"))
-		get_diff_color_found =3D git_config_colorbool(var, value);
+		data->get_diff_color_found =3D git_config_colorbool(var, value);
 	else if (!strcmp(var, "color.ui"))
-		get_color_ui_found =3D git_config_colorbool(var, value);
+		data->get_color_ui_found =3D git_config_colorbool(var, value);
 	return 0;
 }
=20
 static int get_colorbool(const struct config_location_options *opts,
 			 const char *var, int print)
 {
-	get_colorbool_slot =3D var;
-	get_colorbool_found =3D -1;
-	get_diff_color_found =3D -1;
-	get_color_ui_found =3D -1;
-	config_with_options(git_get_colorbool_config, NULL,
+	struct get_colorbool_config_data data =3D {
+		.get_colorbool_slot =3D var,
+		.get_colorbool_found =3D -1,
+		.get_diff_color_found =3D -1,
+		.get_color_ui_found =3D -1,
+	};
+
+	config_with_options(git_get_colorbool_config, &data,
 			    &opts->source, the_repository,
 			    &opts->options);
=20
-	if (get_colorbool_found < 0) {
-		if (!strcmp(get_colorbool_slot, "color.diff"))
-			get_colorbool_found =3D get_diff_color_found;
-		if (get_colorbool_found < 0)
-			get_colorbool_found =3D get_color_ui_found;
+	if (data.get_colorbool_found < 0) {
+		if (!strcmp(data.get_colorbool_slot, "color.diff"))
+			data.get_colorbool_found =3D data.get_diff_color_found;
+		if (data.get_colorbool_found < 0)
+			data.get_colorbool_found =3D data.get_color_ui_found;
 	}
=20
-	if (get_colorbool_found < 0)
+	if (data.get_colorbool_found < 0)
 		/* default value if none found in config */
-		get_colorbool_found =3D GIT_COLOR_AUTO;
+		data.get_colorbool_found =3D GIT_COLOR_AUTO;
=20
-	get_colorbool_found =3D want_color(get_colorbool_found);
+	data.get_colorbool_found =3D want_color(data.get_colorbool_found);
=20
 	if (print) {
-		printf("%s\n", get_colorbool_found ? "true" : "false");
+		printf("%s\n", data.get_colorbool_found ? "true" : "false");
 		return 0;
 	} else
-		return get_colorbool_found ? 0 : 1;
+		return data.get_colorbool_found ? 0 : 1;
 }
=20
 static void check_write(const struct git_config_source *source)
--=20
2.45.GIT


--zE/WnIZb0e9znfnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BE4ACgkQVbJhu7ck
PpRpzg/+POlZaPWa8e8lN3zOuuAbKf3Hr/iIXNSQIh4fpZ3J/h9Ku7ETthw3hjLK
MarBNicXxZA+JIr48RlRZ1JUEnUZQQDVRgj/0DOse+uLiODLIuN5eMKvcijlXMXp
IBbOvr/KQQIQTqIlOMxvJ0QXNrr2AFw5YtAqt41Wds2ZSVY/TqzTnoRE83x3gHEi
N6vD6J+MlS7o6AJkGSBB/u1gPvCM7aMb/emPCa2u6SS6sKeZzaXszCa8XOIepTFa
aYM73uDSmsPesaMdF7p0es4LsUq54/XjSyaQIGJlRD1adQHrkfUuw92yYddHJXoK
1KMa384LMFg7yMFmOWWYfmdJ3wFRDgv4kKcc7SKWcCMC7+b4mulLSr1Ct7isf1jB
VvYgozHPr5w+HDC+zBxhQRxssmWeRfikGjzhz+ggniQvOwHNqvLbfys+dmHA/5S/
UA0qO2/NoiV5Jds3jIFkiyrmLhaIcJ3ob+sV4lILJRfNMvwhKWLxyZ4Uf7p1MWWw
xSwowJKImg+HRs5Hf0ljLj/umcsT5mrGR3aD3WdfZ24YIzLPwPAEoB7cjkWf1w1b
ArzyH21fbijEiNDO5O8nt6MsnQkbYaWS5OIcgJeQWCWWpRDyeRV5DEnhEy9ADu71
weFBtKEcE2EdrnWCoyGXxvCuJN2HisCZ30gTvKGXucg6jzsZH9Q=
=xOFb
-----END PGP SIGNATURE-----

--zE/WnIZb0e9znfnm--
