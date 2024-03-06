Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEEC7FBBD
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 11:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709724720; cv=none; b=uuVTHS/wEcNSJABD2dMzzDjVTLB25QZKZkP0ZJIbYAK8wflVrCGLjQgqNkQznxIYxTi3qX6Zwpm+cyV6Il1HfMHKWfvyyCoQmpxQOjj1qtDxJw32kH6lJbP2/wLcPRnkeXOhN097bSylG2LhzSJt30N64ngHFdzePxR7zNudP94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709724720; c=relaxed/simple;
	bh=XeC6FDg3t7iebnAP5OI0bfKSTj9kiglaVr0mgpsCUc0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+yugFE1SwYcHCNO5H1+5F+Z5AazhTBqxjqhygPboGxBVFW+hCRz7yomJtvnGvbiJI7x1Y7hsto8Dyvs2gRUYoyeoOufGcAnRnJMVQ80CyRiS/Mt55Zzv9YUFYkCwADd2N+zRLWoJ8+8yQNNqtuayZN0q6DM4LmUvujnzEHyJhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BlWPZZ97; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W118BxIC; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BlWPZZ97";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W118BxIC"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 90410114008B
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 06:31:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Mar 2024 06:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709724717; x=1709811117; bh=nscnYRK0fr
	48ef1IrNLBpCOFekbF94OX9yxHf93wvxw=; b=BlWPZZ97O2MGYRpmvXxtsQ24WP
	S1/D68UIDyqopfLp8ct7rsjcSnu649fwvyGzoahfiS+ZHfglHIsdnCOgSFMTHe1b
	PLUfExs78r6/tPkpGQJsqjr7RQLsbaj/pUK2rK/b186u2tsysM5cfXOUNt3xtMkp
	22NWDP1evSLMFGhNod4TDM0zAx35FyxJPzyoeUIDSPcL+sZPf2Bo7vQCct7khsLa
	qTSh+eRpaT4X6Abbhb4dSvcHijA9JjqKG5XO6/q+RlDGa48c0O+m/g5wb0WH4orX
	PCvEru5YXYjyNTzkHL01mlxvG1Dew45wbk2wrjYqn7wsZg9+yECv0K0hlwVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709724717; x=1709811117; bh=nscnYRK0fr48ef1IrNLBpCOFekbF
	94OX9yxHf93wvxw=; b=W118BxICfdDE89miIq/gCuTfhkPoDnQb3+uj9029QwUk
	p9wi6IECBpsfHY+lqs276enIjayrkolQiNjDfnT09+JoWDJtXHtPvYAFHsuxNlPo
	T/dC5tqwGFJalQoqqq2o4rGpZcmJ4rH8l7tdPbb2F1j3ne1h70dFk0h6Mvzn0GAm
	aXPZp6kesLda4+IVHfczLkEhNb9bzplnRZvGRd9ndEGDWNaCS7veLFrsp+osYOaP
	NInS1Qlt2vELA+rSW1Mhek4RKgyEgg2T9ZSsDrqsaCibOeS20DoXpIu2gt/a30WJ
	SpfXmsnOp24NjLDdNYWSwYUX0WyR/PgC33o8rf/Vuw==
X-ME-Sender: <xms:LVToZSFo7hEc_sp_fdQ8RR7TN-dLyuM9ZprkzWPjbZskdNphyC4QUQ>
    <xme:LVToZTUYcrg5-h2dZuQyVsMSxQ1_0lLkBz0g3pyEddFkOeMJQSaGiR9JIY4xpN7fu
    bogDquYmv47lgKSDw>
X-ME-Received: <xmr:LVToZcJEkEip_JNfcTuL2QLzTm16KFt49Oz2f9xKk3MX6aQtjjO2PuIQjvNNSfon0bPCmIp4NW8z_tXsGRI0bFBRNO3fHl8QCLUztxmekfDeB5tsNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:LVToZcH-7mYzug34kAmHCmDQCbXc65lHWF2pLAbuEmWJr3E7tVYfJw>
    <xmx:LVToZYWi0wDZqoSYIwyJkcJcKSNn38jcD2I7Wnl432kXsOmacsuRlA>
    <xmx:LVToZfNMoifyJk9SFu79_E59mlvRkCAJLDhuF3LqSx9B7jw9nYXMXQ>
    <xmx:LVToZTfBRIGscZ2jeMTndn7T7DD53juObACiFgb-SEGd46k1vgIEIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Mar 2024 06:31:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf38db61 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Mar 2024 11:27:27 +0000 (UTC)
Date: Wed, 6 Mar 2024 12:31:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/8] builtin/config: introduce subcommands
Message-ID: <f79c0f94e415de5c1c7b4120af5270fe4900d825.1709724089.git.ps@pks.im>
References: <cover.1709724089.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1kMKiyTMUVZACVlS"
Content-Disposition: inline
In-Reply-To: <cover.1709724089.git.ps@pks.im>


--1kMKiyTMUVZACVlS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While git-config(1) has several modes, those modes are not exposed with
subcommands but instead by specifying e.g. `--unset` or `--list`. This
user interface is not really in line with how our more modern commands
work, where it is a lot more customary to say e.g. `git remote list`.
Furthermore, to add to the confusion, git-config(1) also allows the user
to request modes implicitly by just specifying the correct number of
arguments. Thus, `git config foo.bar` will retrieve the value of
"foo.bar" while `git config foo.bar baz` will set it to "baz".

Overall, this makes for a confusing interface that could really use a
makeover. It hurts discoverability of what you can do with git-config(1)
and is comparatively easy to get wrong.

Modernize git-config(1) so that it understands proper subcommands like
"list" or "unset". Like this, a user can say "git config get foo.bar" to
retrieve the config key's value and "git config set foo.bar baz" to set
it.

One concern in this context is backwards compatibility. Luckily, we can
introduce subcommands without breaking backwards compatibility at all.
This is because all the implicit modes of git-config(1) require that the
first argument is a properly formatted config key. And as config keys
_must_ have a dot in their name, any value without a dot would have been
discarded by git-config(1) previous to this change. Thus, given that
none of the subcommands do have a dot, they are unambiguous.

Consequently, we introduce subcommands in such a way that git-config(1)
understands both the old and the new syntax at the same time. This
should help to transition to the new-style syntax until we eventually
deprecate and remove the old-style syntax.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 52 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 0d58397ef5..10fa933931 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -859,6 +859,26 @@ static parse_opt_subcommand_fn *subcommands_by_action[=
] =3D {
 	[ACTION_GET_COLORBOOL] =3D cmd_config_get_colorbool,
 };
=20
+static struct option builtin_subcommand_options[] =3D {
+	OPT_SUBCOMMAND("list", &subcommand, cmd_config_list),
+	OPT_SUBCOMMAND("get", &subcommand, cmd_config_get),
+	OPT_SUBCOMMAND("get-all", &subcommand, cmd_config_get_all),
+	OPT_SUBCOMMAND("get-color", &subcommand, cmd_config_get_color),
+	OPT_SUBCOMMAND("get-colorbool", &subcommand, cmd_config_get_colorbool),
+	OPT_SUBCOMMAND("get-regexp", &subcommand, cmd_config_get_regexp),
+	OPT_SUBCOMMAND("get-urlmatch", &subcommand, cmd_config_get_urlmatch),
+	OPT_SUBCOMMAND("add", &subcommand, cmd_config_add),
+	OPT_SUBCOMMAND("set", &subcommand, cmd_config_set),
+	OPT_SUBCOMMAND("set-all", &subcommand, cmd_config_set_all),
+	OPT_SUBCOMMAND("unset", &subcommand, cmd_config_unset),
+	OPT_SUBCOMMAND("unset-all", &subcommand, cmd_config_unset_all),
+	OPT_SUBCOMMAND("replace-all", &subcommand, cmd_config_replace_all),
+	OPT_SUBCOMMAND("rename-section", &subcommand, cmd_config_rename_section),
+	OPT_SUBCOMMAND("remove-section", &subcommand, cmd_config_remove_section),
+	OPT_SUBCOMMAND("edit", &subcommand, cmd_config_edit),
+	OPT_END(),
+};
+
 static struct option builtin_config_options[] =3D {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -910,6 +930,20 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 {
 	given_config_source.file =3D xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
=20
+	/*
+	 * This is somewhat hacky: we first parse the command line while
+	 * keeping all args intact in order to determine whether a subcommand
+	 * has been specified. If so, we re-parse it a second time, but this
+	 * time we drop KEEP_ARGV0. This is so that we don't munge the command
+	 * line in case no subcommand was given, which would otherwise confuse
+	 * us when parsing the implicit modes.
+	 */
+	argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, bu=
iltin_config_usage,
+			     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_ARGV0|PARSE_OPT_KEEP_=
UNKNOWN_OPT);
+	if (subcommand)
+		argc =3D parse_options(argc, argv, prefix, builtin_subcommand_options, b=
uiltin_config_usage,
+				     PARSE_OPT_SUBCOMMAND_OPTIONAL|PARSE_OPT_KEEP_UNKNOWN_OPT);
+
 	argc =3D parse_options(argc, argv, prefix, builtin_config_options,
 			     builtin_config_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
@@ -993,18 +1027,22 @@ int cmd_config(int argc, const char **argv, const ch=
ar *prefix)
 		key_delim =3D '\n';
 	}
=20
-	if (action =3D=3D ACTION_NONE) {
+	if (action !=3D ACTION_NONE && subcommand) {
+		error(_("subcommand and action modes are incompatible"));
+		usage_builtin_config();
+	} else if (action =3D=3D ACTION_NONE && !subcommand) {
 		switch (argc) {
-		case 1: action =3D ACTION_GET; break;
-		case 2: action =3D ACTION_SET; break;
-		case 3: action =3D ACTION_SET_ALL; break;
+		case 1: subcommand =3D cmd_config_get; break;
+		case 2: subcommand =3D cmd_config_set; break;
+		case 3: subcommand =3D cmd_config_set_all; break;
 		default:
 			usage_builtin_config();
 		}
+	} else if (action !=3D ACTION_NONE) {
+		if (action < ACTION_NONE || action >=3D ARRAY_SIZE(subcommands_by_action=
))
+			BUG("invalid action %d", action);
+		subcommand =3D subcommands_by_action[action];
 	}
-	if (action <=3D ACTION_NONE || action >=3D ARRAY_SIZE(subcommands_by_acti=
on))
-		BUG("invalid action %d", action);
-	subcommand =3D subcommands_by_action[action];
=20
 	if (type && (subcommand =3D=3D cmd_config_get_color ||
 		     subcommand =3D=3D cmd_config_get_colorbool)) {
--=20
2.44.0


--1kMKiyTMUVZACVlS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoVCoACgkQVbJhu7ck
PpR0bw/8Cqro9mJBIxSRqkua51YnfO9PFykpUO9TmZe5MRMfUF5BTzf1UDi2vfsX
vo0FdoZ9T/OutLB5oqVazobsXRuNc5fepeptzYb/XWTPTBY+MMHQPYK3PF3CVont
zJYGG6tG4rbGewxKOVQLtZzHn/lqTIFxN98FYUQR/wamwnKUeCd6IsJHLuA2a9Zn
ZKhx0mtFhksYLweKoW82ESdkVj7jOJx8v7B8VhdJvB4tFygcdOBRCDLo33vt4MsP
9Nlpy/JU6grv9FC9I1cW5g4WjTLl6pkJww9TM90XUpNCma+ccwNQHdTL6U81zqUs
4RFlUKqk8aTCD5N9Bm1B8ah8upkQC8fJQP+2H0d3qa+f79Hc89Tl9ImENM0N1+Z8
G3+bcJNKtGcv0dXhPLMeqkDMhlwvta6wYQ/HFt/s6iJ0xkJIE01sS2LmquQ0xiLS
ab6FRL5dWXeY94U0grH0lWdveluhEJagdlU46tMVvi7GJae78Bo+QpmSDXhHAEkZ
ZCDD2BuPIWtzN7HDU0X7+jH/WOHP9AddmGfFlN6kYLGlXIYxBTxPjFSS05mSkpLW
0OfzpSRU4gkQIdzXLI3f1tjZVy7hOrlzl9b+sPMW6DxdzBwrikJSG3yy3D3PWYt4
15Z7wv0XBywx77H1iTwzJSNHfT0xIIRX/2uykiPKcwFaV7Emac4=
=gIMo
-----END PGP SIGNATURE-----

--1kMKiyTMUVZACVlS--
