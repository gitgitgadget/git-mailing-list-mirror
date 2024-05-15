Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2F53D984
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755305; cv=none; b=VdJmbOxbjK4CjhAE7lTF0lEn01d6ITq0BqfGz2o++o+mBdXcPJuhhI7JcfLz+YdKiYLHr1hxTK0MDEunV8gGJNMikMj1Nl8Gf+qflHLse7vxN5cYqLSH08OdbTJhPiqeABei0TB/QtvvzJB1H6aWPpz38rQ85FSax4u+pEGrkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755305; c=relaxed/simple;
	bh=ms/S5F1877L3tjjlCdcIPBncgqsl6Wdzm5/5ZnHGcRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XKleyYzxEdqgFlHN0/4ZKmuu/3l6pISbncNKuJFrjm5kw4zjEfdk4oxf3NxSmB6JPe7bKWq+KSWKf4Yvyrasn/qWlNJUQMtMfmTgUonbTW5Ro55wporFs9quOfsiFyjeQ7sw8+IjLKFxVl4VeS9H6W2MLCMev1VhGJbGGkFxPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O3x+Qt7T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KyLvV8Lc; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O3x+Qt7T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KyLvV8Lc"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 30EC611400F9;
	Wed, 15 May 2024 02:41:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 15 May 2024 02:41:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755302; x=1715841702; bh=CQMH3+Gi8c
	DLedxydyECVd9qgxgP35vlAJ9Si3KeZJY=; b=O3x+Qt7T8c6dH3A3LNGQ1rw1D5
	0R2gdfEAFVJBUlKbSTwsOHbR+H8bzd2yVcZBRfnhAGrHjnjUZgOQ83jz8eKGn/Jx
	XX+Y96Cj8tMpogSU04QRuK5YiTGsWwJphl+rFfuqiW+Shcu3kGVjLrx0VPjWim8y
	hQ10iMdN3jRiVgMic0KcHyxzd7rxwmRCpHXoxYhVNBeXcxX3Rz/g5bEcqblO3tjO
	tBbmCih8ZrkoDZPPrgDIyk5wxlkL0wQ/9Wqv/REg1yOTV6wj45Y+U6flJzQgvbjw
	ZYDlcqqozOQVlhg1blZ0mIG4ukL4z1wMqoYIoaHExQ05DVL2ErpqR+Vjx0iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755302; x=1715841702; bh=CQMH3+Gi8cDLedxydyECVd9qgxgP
	35vlAJ9Si3KeZJY=; b=KyLvV8Lc1n97ctXyewZM3hAjNg1aXJvgvgM1yt6Ae9yV
	8hNVl6g8sSnic6Bv2RZe5+eq3HgRZllfuTqjRQlfM77L3Gks56ucjfrCs20snA21
	P/dqVeI0zrf4lGXeeEx+TtGCSaj2YAv7fQfBC1ZVgbSAHGsNIeoiJsFtL/7N44sw
	yn8zEK1eTnP7c9CDum6IKQTq7TB7BG3hfDS5TDVt9TyCBiBmu7hQ+GNVAA6gJELh
	j2wVPlDd4Xl/9LgooR6lVnWTye0BO8sjLjX8CehWxPuolKxxY+v6SQ2VwE8oDX6w
	GtS2MVC2VlY4YE1TkcPpLddcBHIFJIT1MSHM6XYW7A==
X-ME-Sender: <xms:JVlEZqLjfhkhqI3E9tJJEmObRQT2lYVMu5OqJ1hZSktmmTV42xaUQg>
    <xme:JVlEZiKU2HjZxZo27qhgJIUT3HXCv6rMplStSwJP5QtNyvaIfs9p9k22UQJXO-I-p
    6ejoYyYXYfaa1SLtg>
X-ME-Received: <xmr:JVlEZqv2BQzNRJiKmIx6_qJ34uQeTJerCq71sCruL4vDrd1tTmsTl__0dgLfKnYO29w-urLspERMbUPFQF0lDjOsPFLfKwQka9cCJC0Bh7Qfpg0t>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:JllEZvYUr27EJHqLJqeb1cE3O1WTT5eb6XZK2NgQPmY3J_B3oTlZbg>
    <xmx:JllEZha1bFCePMYt5K_nXjRT0W7HoKe3tpv50rjkuLFZlIDgWekLbw>
    <xmx:JllEZrB6KW5pK0hpSi2vy-rGZiOiiAL5pWSy6ZoOFdGBzngE4CVspQ>
    <xmx:JllEZnbuwFh_YK76E_8oQC-e41-gWJavRzveQ1S_3bQAVLLv19oglQ>
    <xmx:JllEZgWW-VrnILlwCeNdS2CHRlWTGe-B5O1NVWHzr6FI08tJ111muGzz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:41:40 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e6ae0b37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:18 +0000 (UTC)
Date: Wed, 15 May 2024 08:41:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 01/21] builtin/config: stop printing full usage on misuse
Message-ID: <32380a12fd8dff2b700d3076e5f5a5441d573405.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D6E2sNElYwn2EY2a"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--D6E2sNElYwn2EY2a
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


--D6E2sNElYwn2EY2a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWSEACgkQVbJhu7ck
PpTN3w/+OT0ri2ew8/7qb67iM5cPx/1JCB0q5oIPSM/kuDlB3ITJ8RyyOsiFpZZI
Sus7qdioPCFfvg21XZi8AHZgRYJbVbOqKHxVqZMJxTHzQj5L0oafYjHiwFiR86GJ
pie07CnP4/5O98CrKrKrO+0mnRpvOlfqlkIPzWSgc72DUT1BAr6+RbKGhyAcd3Pf
obdho3ILbxRoBiZthLz5YyMv1gCLBfvO8OmmWk6N76CKahRRHuMTIOcsaum2nvF4
UCdsoxW7yOMw9JBeugJczfIzgkOZGFzoswHSfEZPljRdojX3bhA8XONcZnNteq+Q
/BH1+uQUjHhzVNLrMKrYWLQZBmNwwu+txBYuEuusTlpqhhhuybMKYGpAzP8lKL5A
/BjQqlOYV1wfQ6hFRI4qesgzVABf0Rgv/tviRkntiX6XqxC6F86ISIucveRBI5kB
3ThjqLjpmXXkHg21oeE7y1dCx5sgoVWsNekkjGoIPhrG8NQC9imvAYR7FcuvGXAE
k3ToxLs3AnhPtsPMfZR41gN2W61+xavhy2zh4zo+t99T5xB+F22HDZCCw/4MsJGl
gIxQ4xGeeex18NuOldOhjW7OxWAiBx6qkoyBmujbPCu9yNK3aQDby352KGhtFMj7
YQx1xp949MQgXkR2pyNy4ibfKd459bcK+8cyfVd37stMFqHASUk=
=YJYc
-----END PGP SIGNATURE-----

--D6E2sNElYwn2EY2a--
