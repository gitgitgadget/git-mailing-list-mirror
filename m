Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6334D16E870
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340279; cv=none; b=p/oMXAc9IoYu7IV7i8OOxSB6StPZqbx9ss9mc7cz10YOO4XCNFNop4jJfStm0vZGUCJkRNMCECKvK0upmJa70CtTa/Ps7I5E20tQfCqFVh1zr+JLIL4lr2lKw6G48y1Xfx1LdT8FyeAsK7dKFXiPgiv8Z986jay2+4JAch28UaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340279; c=relaxed/simple;
	bh=/HJ83uU4El6nADQA3/FmdF+/s6cQm93RVQ3av4u3WJs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUlTBtB8yytL1AsC+plfN788L0wjRlONlWyj4onEd2tJoY7shy1dmJGhCbNhzLgG81fT50lk0tsk1Vq7G5e3rUjEwQqc+oHNCOJrJNi1JLGHWa4TdwXJVwVzCsZbciENvuZwpSvDXPB0q235sIOjBBGLjRZOT8/nWDeAlOVJQzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L2YB/QkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FQusTkK3; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L2YB/QkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FQusTkK3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7E4EB180006D
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 10 May 2024 07:24:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340276; x=1715426676; bh=IwtG6pClnx
	g2wXb3lqb09qlcEbJFFdm+eyQLmlVhgRY=; b=L2YB/QkUsYREim9L0mJ9oziUbx
	BLp/wI5rButcbnVTQcdIYQqvckWg9pT+O8NARKHhP1TOL5y8qD7wy3UDFCkqoGyR
	8PEELYkgHIdhfIr8gXdG3/77LzI1Zs9muX38N4tOXLl6wzkyHDneEF/qbr0ppzSP
	nQOZ9NgVqFX9DMD5bwEpOJjgjKn7kBeAEx+rseP+RSX8U6ePm13fL1B848NIgqSx
	Wyslv0vcN/So2FBtadUTgUeq06hcnJbA1wnJM4EGdiZ1r8e50vRHBh70oPUE9Fd5
	EBHUQUhSGpTTAMe/1HKgOO+E7WtOC+rSn55X4SjDGn3IJYcKxH+5Y57/C2dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340276; x=1715426676; bh=IwtG6pClnxg2wXb3lqb09qlcEbJF
	Fdm+eyQLmlVhgRY=; b=FQusTkK3e7Mw6f9Kc7mY4XhD9SV+uDeJA33bFi0+OsYm
	D+ar0UmF8pwvlE0WBggCCUyufuRjXkA6zcEEPQA8fk4M3NuV7Qhy0vTDv/nwGr67
	aWQbLC8ruo8KuP34MK6Mjo97f1HYxN1qSNH06MZhZPNnVFEP9xw+m4l8joC+QLuQ
	bBPnWi9Bga5akSBrjGbX8QxANQRYw1zWlAW2gWDIZEPqolx4elMnCW1CqXEz9CqS
	6CcEj84NPM6s9rOzQZcKBHNwxavPmDDrpHWksV8JKCnga1YQDtfhQAUi5JYs7EXr
	DHgB7bG0cCYKyaa5SllnRJxtFj1Yn0LujU2QgkMBDw==
X-ME-Sender: <xms:8wM-ZmnoFK5j5WkqgresjHiTdAT1UZT2doHHqJ2XbXxha--2WmZL6w>
    <xme:8wM-Zt1md34u85Jet1_4HZqfelOGDYjB6aDZthXP6rOZT8YcjJdeTWQaJFcumYdbb
    LLHPSU3LAQzFMnc_Q>
X-ME-Received: <xmr:8wM-ZkqyXZAofFGXBn1cPXkQmVQ6mmNRv36mYykKullCDTtO62Z2vteHp-QztxO_Xv0s2fZBVduekD9VOoBV34DjlpzRTvgFhbv7rbN-hmgR2Z88ZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:8wM-ZqnRLnNSVNkJ2s6axsfiBLrIujai-zo4908thaBw7EA47gF0gQ>
    <xmx:8wM-Zk3fXC3HNsPpFDpUBFguykkQ36XUaFpwMZeT7j7VUw69wpFVGg>
    <xmx:8wM-ZhveDOPDIYdk6Yqzx71JSjQSt3T7Blza4P0tpaha6ymkQkg6rA>
    <xmx:8wM-ZgVliNmEPPFjgW5Nf0vespJUAkY0zsvDi4YacLcD-cE059kXpQ>
    <xmx:9AM-Zh8JBU38eYt6NmzbbmmNptlu_0oX1IyKQcIh-LXN8rWlauOIVqU9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:35 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5640b551 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:22 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 02/21] builtin/config: move legacy mode into its own function
Message-ID: <663e1f74f82b8c1acdd0c35ad87736c071eafb33.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mHHDm1X9kUQknobE"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--mHHDm1X9kUQknobE
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


--mHHDm1X9kUQknobE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+A/AACgkQVbJhu7ck
PpSHBA/+NscndB96gkHe0bYyADez4+7UGSI1zqpqGYdxRvEtzQfLAEu3nHPy1Vts
Li5XyPkIXrYkDTQifWDA0NpDx+iAqAtcojhCptKIZ/RIcTvwVJAbX3kRTkQyQ/hC
PMnXTIUrcvozwwcXDqbTTqAUVO8KHJ+Jy0Oz1y0uyUS8GSCWlM9xVZcwJVhgMRof
KyBLOYNEZJPiecwRUb+AoUFEe741ntCqdoUYADMoLQs4JynZUiXjGyc2nWUum0Dn
aTwzADEFDDm9W83vyokfBnCY0zS/4nSotTiqDhHUuwwfS+ntSdN9bjzH/Oyk1mjm
1ZWBrCg60WvVY77Ge6YsqpuMZcet+ZmrnNfTYX8pcJoOd/e0l361FcDv8u0+eFez
mQFqPoP+cpEYAt62nFg3BiCMLMjCRHyEc+5R3SSvMvWFq+dP8B/pyQMqaEpmKO+s
zZxQvHGw9RiThSg34OQ/pyCYUAJRGVVhBMA1B/MwEzZ9bLZe8L6fyDYu5enVyTEU
okU1uYCgXbwRQhzyhIbBNlXT7Hy/kTCQNXFg2se/VaPuUDTFOZFjH0UUZ4uCsU4h
vcF8XOtDgFr9+tYD8fLi+43z4e+dE+FX5ETeHaQG7sovtS9PQVNswH4YW0mh70bA
IsZ3L54B09JiYJQVsIY31PTEWna04pFtHstkAw7MakrUqVxjMC8=
=tpGp
-----END PGP SIGNATURE-----

--mHHDm1X9kUQknobE--
