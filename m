Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358571649CF
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340362; cv=none; b=PkEam2uFHDc5kn93sR1W6087SWnhVa2tKnFJSvho82gzdQqX5kfa5LIg3KVE84R5nuHD6vHZ4OmBI5iWRGnHNPJNfKzv+0/YrYuQ2BmSNkgvhDtCS9xzvkDdY/fAJevdWnzr35Ydss2LDZEWvgwVYueEb227mkIakS30SymQy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340362; c=relaxed/simple;
	bh=BZpD35ry2n3AAWLhbSYUQwlV3iXgalrbRNcpo4Wx/S8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfPAP/DSh8nDQcGDLkmroR0WIeMfmv3iEInVwL5ioHdisWEnopvz+Wu44b3KyLGWV3/fzUlpcAYnbZ4sjVbEfpsaWfUVhy0nDBUv6w4daTKXCljeG+GcbVzYSzsUCQMTJWmAtp4LTDTTde2Wy5KvKcDNCTJBWT+HtzoHbRgwxSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aBe8QFVx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PzXq+J1j; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aBe8QFVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PzXq+J1j"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 6FFFF1C00098
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:26:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 10 May 2024 07:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340360; x=1715426760; bh=avRezTUubf
	/HrtFhPjgqOQ62HCa2t+BhvE7GpzK9h7c=; b=aBe8QFVxl974/6l0Rv7CT2Jg4c
	69I1PVkQxwIG+lO9X+2Sig7YidIqZHtElgV8WmpqOFpBIO+pQVRsJrLax5ItQFiW
	plQ6QHUp3tLXEZO8pTW+GH6kWAtOhMcYeEJ8+PrkJovgGOF2GtAtTM36vTYB/BDm
	s3nZOcEtyQNc4HdyqraytIv8+hsi8cq9oGDSSL+fvNQkOFeKcc8vBefkH9ARRBC+
	lByuRYE1gSMVlhdYrccT/aown6JnNVZ8hlZ+0xGViEgpLWHNaSrQW7LWM/z8KXhP
	USMCUdLiCMoPo6rP5c8doBc7f+on4orXx7SQGi0gmmr/elq9iwgmreTVxJpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340360; x=1715426760; bh=avRezTUubf/HrtFhPjgqOQ62HCa2
	t+BhvE7GpzK9h7c=; b=PzXq+J1jmaU4No/D5F1yxhmHQPwyEZm87hi+aA/3lPUJ
	hQo8qAO6MWrgE0o5gFrYd/fnk0Kxq3N3tu8j6vITLVlhEuaRtDch4YGV0DCuYnTU
	iLgUGLzmtUTFtYFrK873kMvF8fcmIKGPxhcLBX2GIYYgGbDqcihEvqBm2yS+JXfs
	xy0TJ8ALXPqRjekrSc/mFgylLz7Mayj+UI2T6HoA/noWF+08hArANz91x7D0lYdZ
	RvJnCBeGU2vMa6Dq4a/1tsxhUTAE3wMdTogEw8X2X7W6xMg5co0RMwQddHQE/uFk
	fJZi2Mmr/swIB5H0NbOM/wECEbk77qJ3dlfEf+roVA==
X-ME-Sender: <xms:RwQ-ZvMnCdcpssIWXhg2YJOEN8eLgt3R5fMfkJsOrMgu0Q4AQbfwoQ>
    <xme:RwQ-Zp9wxJ7HFOW3l01jxhgWm6rjfgKY9FhNbSsIUFdIUvESDHlYJ6aP_KGVkhbR9
    2pLoS3BdaXad-ERhg>
X-ME-Received: <xmr:RwQ-ZuQlx8JC-A3R4aOdci6LORYn17iyyrUC4FyBcZ4ciRyA9iEzfefXlbYLAMSY8gg_URJL0VzLNKblmBbdpxFZ9uvlZqmkJAC3TmFBhMyZy_zjAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RwQ-Zjtm6cWZy8UsY4m9kVzw_ziEhzQ52FCiQIj4ctLrZqOlknRIPQ>
    <xmx:RwQ-ZndN4ZqIxZdmF_1O02CjUxfJ2RqhbWbWkisNNA03pID68_ambw>
    <xmx:RwQ-Zv2BIXowTXwpz5uIgXl97J3ZyLNVBNd9n79IP-zkPVKJx39ThQ>
    <xmx:RwQ-Zj8458iCjxR1wmSViIg-MaV62ZxGg8rHf-kwv--9S8IhGb_jPg>
    <xmx:SAQ-ZvHdcgB5KOfJ_sW5pe5LLymjgQPi2k23OCq-69AGVXP5FJi-E1jR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:25:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 27b197e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:25:46 +0000 (UTC)
Date: Fri, 10 May 2024 13:25:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/21] builtin/config: track "fixed value" option via flags
 only
Message-ID: <625216a7741b64b63717c72fd3c906b04c256bbf.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ghUIumpnxgBfWCnB"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--ghUIumpnxgBfWCnB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We track the "fixed value" option via two separate bits: once via the
global variable `fixed_value`, and once via the CONFIG_FLAGS_FIXED_VALUE
bit in `flags`. This is confusing and may easily lead to issues when one
is not aware that this is tracked via two separate mechanisms.

Refactor the code to use the flag exclusively. We already pass it to all
the require callsites anyway, except for `collect_config()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 8cedf67a4f..e6bc283751 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -124,7 +124,6 @@ struct config_display_options {
=20
 static int use_key_regexp;
 static int do_all;
-static int fixed_value;
=20
 #define TYPE_BOOL		1
 #define TYPE_INT		2
@@ -327,6 +326,7 @@ struct collect_config_data {
 	regex_t *regexp;
 	regex_t *key_regexp;
 	int do_not_match;
+	unsigned flags;
 };
=20
 static int collect_config(const char *key_, const char *value_,
@@ -340,7 +340,8 @@ static int collect_config(const char *key_, const char =
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
@@ -362,6 +363,7 @@ static int get_value(const struct config_location_optio=
ns *opts,
 	struct collect_config_data data =3D {
 		.display_opts =3D display_opts,
 		.values =3D &values,
+		.flags =3D flags,
 	};
 	char *key =3D NULL;
 	int i;
@@ -1115,6 +1117,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	struct config_display_options display_opts =3D CONFIG_DISPLAY_OPTIONS_INI=
T;
 	const char *comment_arg =3D NULL;
 	int actions =3D 0;
+	unsigned flags =3D 0;
 	struct option opts[] =3D {
 		CONFIG_LOCATION_OPTIONS(location_opts),
 		OPT_GROUP(N_("Action")),
@@ -1137,13 +1140,12 @@ static int cmd_config_actions(int argc, const char =
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
@@ -1193,7 +1195,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
 	}
=20
 	/* check usage of --fixed-value */
-	if (fixed_value) {
+	if (flags & CONFIG_FLAGS_FIXED_VALUE) {
 		int allowed_usage =3D 0;
=20
 		switch (actions) {
@@ -1224,8 +1226,6 @@ static int cmd_config_actions(int argc, const char **=
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


--ghUIumpnxgBfWCnB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+BEQACgkQVbJhu7ck
PpTDPBAAgDI5JForOt5gLXUQykBx0hL/abzlXJQrbeB9KOU1JOqkKIwHQBsB2yDd
PaBKFjbfomvRQ3yYsn9f9fWr85JPq94W2VMdfoxsh7I/Guj96ktsA+AuADzujH7+
ltT29FPQd6epFt40K0Tsgc/kodMAgasZQ1I0rCaUNyMwt7uy577/mhnxgHYBWBM+
nmSU3IYXUr5NQROnO4rlSAlDFQXXSk51+4gybtYGDzTg1leQqaXuK0vlpP5VW/vn
B8dtdDae6ITEYDSdbvFtu0A196zXuoDLtfK0WqaSAgITZkGk4gJBb0N4l6uysfpA
XmosZISBYab79AZ7+QIwYPOBYOQmnGvyLDQD5SGbCahOTvSLb7JDqiwGZTWtHv3v
FYlo3OHAR+xGKX5rwJK9XHOWCrQj7mH8zP85nW/S0qwKIubpaY6w9n8merJEznUA
LeMWSxgN84t7DFHaSCGdqahmnHsbXimWMiIsqgXyEfOl0A7DSFUgUX02S6xlafDS
YYZsqW3mHGbLRi5JOhTBEPN++F+Vtg3v87jhc35QbP8+RICCVy5aSbELp81hIM06
lhRDgX7WCVZFIVabxc897/XcDfRaxPbJGa5dFa8nGnk2HYq5yD7wp+CAoIvXOlx6
8cESLQz6kguntvLsE1BfC/zCPDgT6v7gQRrnZFgThZKqTNlGOlI=
=nH/7
-----END PGP SIGNATURE-----

--ghUIumpnxgBfWCnB--
