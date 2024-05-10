Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCC3165FB6
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340274; cv=none; b=Zsc6ZZsZfLRSYC3HT2d9jKrH//NiLfMCef40ylKiQrgqSUHjY9OT/qNgf0uihi3SwBSbrSIV1juQmefCVAXTzaBRqcpeCDdWZGqE8mOran0W3xzqKq944hcknFu7jegH2vzWtoi16Q/bkVsXFQFCfP/xjhcoxOA8QdjtDZBxjMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340274; c=relaxed/simple;
	bh=vr6LD2HPdPIk5d27M5j5UnBeBs3zwuc4q/0nbXfuaJw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JupjW2I49noC8aC70FoTX+P6uGF39+REN055QNNeIQ0CkB6mXfFRuuIf/B7NZ6oNn3wYifrODIEDWEosf7qg0Pi7ybkIjYMCSviBcHBSyQWoIhtFcXw8gLWaxOzo3uIqlIJn7tKduqkvh8JAudJ61hHTDx+7w2vjah/73cZufFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gKcDsGdu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=anuGZJBI; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gKcDsGdu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="anuGZJBI"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id EF71018000DC
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 10 May 2024 07:24:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340271; x=1715426671; bh=YBEvUeX/J8
	c6jYqaBI85r5olmoK8m7JBuH3P7hWLWF0=; b=gKcDsGdu4cq7DydAqR6akGz2HP
	l6H8Qb2Hyotnv+Jz3GTCNr2jb5wSs6CEU5vVEciQlI9PdKe3/Qj1Nv4+5//myale
	K8IFj51kHHtt4nWgROXlD9vvKVEXXV9QsLK0pOzRSA21RCZrqceVxDwq9aP3mgWU
	eP5JIwBo6FPILFhZsmIw3pT0GjWDVjSpWxQImdPKlUp/gd6CbXGjYJUFFS8HKvEb
	ZHiGvhlMU/9R5S7+Yr+B6+FuQeUxqG7ZZ0KKMCJya3DbvesDsBWUf4Rq2IB2J72c
	ooGCsDBfbXnvqa05CywgPvamWNvb+aWn6nMrk4hisCTxFHbLfSk/HVQosjAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340271; x=1715426671; bh=YBEvUeX/J8c6jYqaBI85r5olmoK8
	m7JBuH3P7hWLWF0=; b=anuGZJBIh3CW/jYyN7HWKqP30rACbpOFf5SW30mul1Y+
	BjUSn+Td52xiJ9mXvHQkSdwag7taQWzQ623e+xL3vE2XpXeKTfLZ8kSqgsC/E3TI
	ngmrx03lLD1/+2izCGM86VItB+JzcSvU4ju/3MTszSEgzwqzyFMlD4H8fr6ZcewA
	PZ4rT9dynX2bU2sn9zA/yVW8SidMov3mj2oGTQ3EvYs+YZGfiHF7fOA8L8jXXnTL
	NRvplqaQYx8dUbulEoFCmwCvIY33lTCDnZRBNj/I5xgRd+bRk2Pg5RG7/JJqP9Na
	8ZoujAWu9o5nZiyrAWUSXPOSq5TvI/mx6qS5TIphiw==
X-ME-Sender: <xms:7wM-Znx-i_dqQMP5lVctcwN3Z30dzKOwVSxn9iGghfjToF-0D7-XuQ>
    <xme:7wM-ZvReTiS_E2M82r5iYu0sZjw1qbIzATTr1icmQ9axpIT42jHZLbC3rH_a6eYrU
    0_LaFZxEIoUhNhvXg>
X-ME-Received: <xmr:7wM-ZhX-_faj3AMRqcPhSwjduanYragLzdfgHHH8u7C-408bsXl7XFOb-uWn1w6H0uQbv5ADkw4trLAykAAGz25-uqP7CcdR-i_KYrbQZpUS-srRGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7wM-Zhh5qxKo7WYUPhrdebYB8PHmwqYm0MF2YkSx-dV25bY2cvPQ9g>
    <xmx:7wM-ZpDjMbASY6ClRnmv-7wrivs3UXAhvsw3fq2RO4PFi2cUK3L9YQ>
    <xmx:7wM-ZqLgVwFOIhhE3yQAedN4HcsOb9kTjbsh_8cnMHQNJDiM_iD_mg>
    <xmx:7wM-ZoDCMYrJVw9L2SCfylEcHfcc-969qkTXpTCBZrGnGodOctlQCw>
    <xmx:7wM-Zm6PH2xYOeZCYjWWo3S2yUIG55RdgXiNCnOvUUo0tTJDTAt6aaWP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7c77fdee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:17 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 01/21] builtin/config: stop printing full usage on misuse
Message-ID: <0ba76281267b324dd7fe8094132dbce11e9f2182.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/OPdP+X0jcQz57HQ"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--/OPdP+X0jcQz57HQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When invoking git-config(1) with a wrong set of arguments we end up
calling `usage_builtin_config()` after printing an error message that
says what was wrong. As that function ends up printing the full list of
options, which is quite long, the actual error message will be buried by
a wall of text. This makes it really hard to figure out what exactly
caused the error.

Furthermore, now that we have recently introduced subcommands, the usage
information may actually be misleading as we unconditionally print
options of the subcommand-less mode.

Fix both of these issues by just not printing the options at all
anymore. Instead, we call `usage()` that makes us report in a single
line what has gone wrong. This should be way more discoverable for our
users and addresses the inconsistency.

Furthermore, this change allow us to inline the options into the
respective functions that use them to parse the command line.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c  | 28 +++++++++++-----------------
 t/t1300-config.sh |  3 ++-
 2 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 80aa9d8a66..3a71d3253f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -125,8 +125,6 @@ static const char *comment_arg;
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
 	PARSE_OPT_NONEG, option_parse_type, (i) }
=20
-static NORETURN void usage_builtin_config(void);
-
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
@@ -171,7 +169,7 @@ static int option_parse_type(const struct option *opt, =
const char *arg,
 		 * --type=3Dint'.
 		 */
 		error(_("only one type at a time"));
-		usage_builtin_config();
+		exit(129);
 	}
 	*to_type =3D new_type;
=20
@@ -187,7 +185,7 @@ static void check_argc(int argc, int min, int max)
 	else
 		error(_("wrong number of arguments, should be from %d to %d"),
 		      min, max);
-	usage_builtin_config();
+	exit(129);
 }
=20
 static void show_config_origin(const struct key_value_info *kvi,
@@ -672,7 +670,7 @@ static void handle_config_location(const char *prefix)
 	    use_worktree_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
 		error(_("only one config file at a time"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (!startup_info->have_repository) {
@@ -802,11 +800,6 @@ static struct option builtin_config_options[] =3D {
 	OPT_END(),
 };
=20
-static NORETURN void usage_builtin_config(void)
-{
-	usage_with_options(builtin_config_usage, builtin_config_options);
-}
-
 static int cmd_config_list(int argc, const char **argv, const char *prefix)
 {
 	struct option opts[] =3D {
@@ -1110,7 +1103,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && type) {
 		error(_("--get-color and variable type are incoherent"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (actions =3D=3D 0)
@@ -1119,30 +1112,31 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		case 2: actions =3D ACTION_SET; break;
 		case 3: actions =3D ACTION_SET_ALL; break;
 		default:
-			usage_builtin_config();
+			error(_("no action specified"));
+			exit(129);
 		}
 	if (omit_values &&
 	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)) {
 		error(_("--name-only is only applicable to --list or --get-regexp"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (show_origin && !(actions &
 		(ACTION_GET|ACTION_GET_ALL|ACTION_GET_REGEXP|ACTION_LIST))) {
 		error(_("--show-origin is only applicable to --get, --get-all, "
 			"--get-regexp, and --list"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (default_value && !(actions & ACTION_GET)) {
 		error(_("--default is only applicable to --get"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	if (comment_arg &&
 	    !(actions & (ACTION_ADD|ACTION_SET|ACTION_SET_ALL|ACTION_REPLACE_ALL)=
)) {
 		error(_("--comment is only applicable to add/set/replace operations"));
-		usage_builtin_config();
+		exit(129);
 	}
=20
 	/* check usage of --fixed-value */
@@ -1175,7 +1169,7 @@ int cmd_config(int argc, const char **argv, const cha=
r *prefix)
=20
 		if (!allowed_usage) {
 			error(_("--fixed-value only applies with 'value-pattern'"));
-			usage_builtin_config();
+			exit(129);
 		}
=20
 		flags |=3D CONFIG_FLAGS_FIXED_VALUE;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index f3c4d28e06..d90a69b29f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -596,7 +596,8 @@ test_expect_success 'get bool variable with empty value=
' '
=20
 test_expect_success 'no arguments, but no crash' '
 	test_must_fail git config >output 2>&1 &&
-	test_grep usage output
+	echo "error: no action specified" >expect &&
+	test_cmp expect output
 '
=20
 cat > .git/config << EOF
--=20
2.45.GIT


--/OPdP+X0jcQz57HQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+A+sACgkQVbJhu7ck
PpTZQw/0DgTJ+LDuEqfPxZ5twmPCCDA2Qj+PF65/3tTl4yMbzyPV4uxmtITL4fhr
9dxfAY0RmTFPjMPnb8cy8s6q0mAyu0AGWfF/qrxlvPOsdP0Wb2eqjSR7/mJWepzS
nG1p/+m4ENpxHq2tQB0pe4uudG+Pbe836Mt2LsycCF+fTzqXsWkDU0DMGyHOJeMw
YdRY2d0sP7Knp9DJIMcB5DbcWHOqkfYahucdlY/ujR3N3MUDCOq+HO4tOcE2orxZ
C6Xz88ar0Lx2fHcFwwC2b6GKDlGoFGkmVloUx2KAGHo0Dc/+o2LHaNJmCjYH4Y6Y
d/Z+YDmpzRZqdjGDekhZu5LJKxt0qzbG9RMNh4gZahRdlu6czS7Whd/N0P8TOeQB
SnrjaWu+0q227tVHzJBNAUqcW8nqlKtC5pC2GV2RsNkwf58wF8n4JPderEM4unCZ
7XfZQOeuW67ljvTPnzK+4y3Fdlod4VW2EQ4UwiaPjvMLPTlLTQiNrFC/X+K5Cmvd
QgWSbbh8RLz+dPAGuY6TgLavJKy5wGobwIgPAeS9fGQ8Iu5N4G199H+cJP/U4ti7
XSM7Ht20GDCVhJ3La/zManFUQ4W3GjcDgkK0PkdoD+xyrU7OQCmdm3YzlIqSlfhP
HB35iTL05pI0zV3/S1c4SJ8bEF83ev0SfWpnUTlzwQvVQBN7mQ==
=30rO
-----END PGP SIGNATURE-----

--/OPdP+X0jcQz57HQ--
