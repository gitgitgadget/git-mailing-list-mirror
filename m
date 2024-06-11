Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE8A176AC0
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097582; cv=none; b=HKgxPHqv6O/kpBoIpbl6D6Y0a82DW9XPU4tgE4o1bo3iyR8039G0091auQPJR8SBd1CbOiqUeHvwYSFxwl3w2Q4cA4j1ooeLbjfQTFocGBLA+BAJGtfsZtvUE53Lw9ILlXB8GSIPdNx9YNInylaeYBuZaegKCEI463/E6jJn/Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097582; c=relaxed/simple;
	bh=e/XRHmyJBFlk5eaI6dKGg+/la0R9PPDu6wupqn8arbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2XVi4NuAqnWNR53H/p+rsMPxPWkoe/bDvVOtBSoCEwUuhypb/lgS/RSME07T+Q0CNdqRhEBk4hSCoTMXDBEtzH4EvLvuzGX+BCCmXEBll9SO2Gk6TS7/2ADNGSabvKOWrgCAVQzR5z3IpxJyHm3jdRS4POMoQ6VA8H+wlchBUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o+JSSNtE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G1UHMJo1; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o+JSSNtE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G1UHMJo1"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id 94D4B1C0010B;
	Tue, 11 Jun 2024 05:19:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 11 Jun 2024 05:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097579; x=1718183979; bh=P2Slu3k94H
	Cf7VgJPAoLH8p5gthLPY+03NMBauOQof0=; b=o+JSSNtEO34nbdoS9/vGVsr9gx
	puz5Xi9KP9Kzt7H8CgmVYihHmk+qID9C105q5dovZh5KPBc2cC7DnA/MYAi0Q5f4
	tsb9yLmJjOLKJjYmGvaK5Plph7GiD8zZ7dJca8V2Yx62SwPJMp8aRSf9dnKvxTJR
	6u+Jqq4y16SrUvoLn8lTQArADpDlEfDYDuL5/OzTFLIJPA5ziukYJooSLKJgfZUe
	JHfzuewvs+bNziyV2YGyxZUBQn84RL0AASSXaTL3TGSpWNvL05iUZmqYG/MGyOJ2
	2q1XV8wkJMyKrpYfCCfHX/5EfLcCVjwprs1d0K7nXWzvq3roD3csv/AcsUmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097579; x=1718183979; bh=P2Slu3k94HCf7VgJPAoLH8p5gthL
	PY+03NMBauOQof0=; b=G1UHMJo1++kO+LX5YrLuZd7emcraaIlJYvbefTij43xW
	b6FQu6r+zZUa5tfRJilqjg2ZWkTpdNC71a35PRvEn9042eK3ZiE2y1GSBFBVfnP8
	LDO7CC6R62Yg1tNnRaUlW0RDK3BBnGl94P2w8b/Ucaw3c3ISBf9/oXOO74MmLvv0
	ONfRpu9Y/LH4HR9HecyEilYO6Syvk4Gndm91qBLDnjGh7I0ro/OYrxtzFfCW9grL
	ue9WgZUMx73udK7Oxe+TKnJcjiWKH5eWhez3Sx8+cjFZfx6XmjcbLrspV9aQeQwg
	N6jNHh795OsLtuXRurj9+0LACz5s50STq+oIQp0whA==
X-ME-Sender: <xms:qxZoZqRMCR-h7k9TwbTBhjZOPVCVdD6hrlX-6TNj9O44e_QP8kTz7A>
    <xme:qxZoZvwV97iEZI89gYfxutg0UuRi0BCPwKsgxY-pfuxHgmNo9hc9fj09oAC3nmTGn
    WwFFldJtJqlAlAdJA>
X-ME-Received: <xmr:qxZoZn0cpYKvTUeVICKG4CL7_hdQTqkiPoqik3v7YeGbDNm4k1PlyQ0BN3nUeLn9_HBaWsORTbFuJoEVO1rDrD2GVwEq9PYErkgEOPO0Z1VZT7Y95Lyi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:qxZoZmDbBOYcN9Jb2pufGH33xG3n_rt7YoqyVwbbYNmArzD4Hqu_kQ>
    <xmx:qxZoZjhs7QVmeWphU0Zf_m_CscbG3h2p22mkXNbiTeSLO2JkHk_BCw>
    <xmx:qxZoZioA2KlnV4sZDiPAbHWMO_wyfNFd9UjLr8Xj-PTlGFeKGtZbkw>
    <xmx:qxZoZmhfc2YXAyvz9dnJxZ8CCb6FNtta4g2dv2M-m1dQ66NrBCOeGg>
    <xmx:qxZoZguBrA52jy7yI7PQC4LWg0nW6swVfivX67pvrfQPP95baLm8Gugq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:38 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d41ae2db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:29 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/29] biultin/rev-parse: fix memory leaks in `--parseopt`
 mode
Message-ID: <91eefcf64af0e74ce004ea605f7fcb59e7700d5c.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XxPlCPgyLuqk6lBR"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--XxPlCPgyLuqk6lBR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have a bunch of memory leaks in git-rev-parse(1)'s `--parseopt` mode.
Refactor the code to use `struct strvec`s to make it easier for us to
track the lifecycle of those leaking variables and then free them.

While at it, remove the unneeded static lifetime for some of the
variables.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-parse.c     | 53 +++++++++++++++++++++++------------------
 t/t5150-request-pull.sh |  1 +
 t/t7006-pager.sh        |  1 +
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 1e2919fd81..ab8a8f3b0e 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -423,12 +423,12 @@ static char *findspace(const char *s)
=20
 static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 {
-	static int keep_dashdash =3D 0, stop_at_non_option =3D 0;
-	static char const * const parseopt_usage[] =3D {
+	int keep_dashdash =3D 0, stop_at_non_option =3D 0;
+	char const * const parseopt_usage[] =3D {
 		N_("git rev-parse --parseopt [<options>] -- [<args>...]"),
 		NULL
 	};
-	static struct option parseopt_opts[] =3D {
+	struct option parseopt_opts[] =3D {
 		OPT_BOOL(0, "keep-dashdash", &keep_dashdash,
 					N_("keep the `--` passed as an arg")),
 		OPT_BOOL(0, "stop-at-non-option", &stop_at_non_option,
@@ -438,12 +438,11 @@ static int cmd_parseopt(int argc, const char **argv, =
const char *prefix)
 					N_("output in stuck long form")),
 		OPT_END(),
 	};
-	static const char * const flag_chars =3D "*=3D?!";
-
 	struct strbuf sb =3D STRBUF_INIT, parsed =3D STRBUF_INIT;
-	const char **usage =3D NULL;
+	struct strvec longnames =3D STRVEC_INIT;
+	struct strvec usage =3D STRVEC_INIT;
 	struct option *opts =3D NULL;
-	int onb =3D 0, osz =3D 0, unb =3D 0, usz =3D 0;
+	size_t opts_nr =3D 0, opts_alloc =3D 0;
=20
 	strbuf_addstr(&parsed, "set --");
 	argc =3D parse_options(argc, argv, prefix, parseopt_opts, parseopt_usage,
@@ -453,16 +452,16 @@ static int cmd_parseopt(int argc, const char **argv, =
const char *prefix)
=20
 	/* get the usage up to the first line with a -- on it */
 	for (;;) {
+		strbuf_reset(&sb);
 		if (strbuf_getline(&sb, stdin) =3D=3D EOF)
 			die(_("premature end of input"));
-		ALLOC_GROW(usage, unb + 1, usz);
 		if (!strcmp("--", sb.buf)) {
-			if (unb < 1)
+			if (!usage.nr)
 				die(_("no usage string given before the `--' separator"));
-			usage[unb] =3D NULL;
 			break;
 		}
-		usage[unb++] =3D strbuf_detach(&sb, NULL);
+
+		strvec_push(&usage, sb.buf);
 	}
=20
 	/* parse: (<short>|<short>,<long>|<long>)[*=3D?!]*<arghint>? SP+ <help> */
@@ -474,10 +473,10 @@ static int cmd_parseopt(int argc, const char **argv, =
const char *prefix)
 		if (!sb.len)
 			continue;
=20
-		ALLOC_GROW(opts, onb + 1, osz);
-		memset(opts + onb, 0, sizeof(opts[onb]));
+		ALLOC_GROW(opts, opts_nr + 1, opts_alloc);
+		memset(opts + opts_nr, 0, sizeof(*opts));
=20
-		o =3D &opts[onb++];
+		o =3D &opts[opts_nr++];
 		help =3D findspace(sb.buf);
 		if (!help || sb.buf =3D=3D help) {
 			o->type =3D OPTION_GROUP;
@@ -494,20 +493,22 @@ static int cmd_parseopt(int argc, const char **argv, =
const char *prefix)
 		o->callback =3D &parseopt_dump;
=20
 		/* name(s) */
-		s =3D strpbrk(sb.buf, flag_chars);
+		s =3D strpbrk(sb.buf, "*=3D?!");
 		if (!s)
 			s =3D help;
=20
 		if (s =3D=3D sb.buf)
 			die(_("missing opt-spec before option flags"));
=20
-		if (s - sb.buf =3D=3D 1) /* short option only */
+		if (s - sb.buf =3D=3D 1) { /* short option only */
 			o->short_name =3D *sb.buf;
-		else if (sb.buf[1] !=3D ',') /* long option only */
-			o->long_name =3D xmemdupz(sb.buf, s - sb.buf);
-		else {
+		} else if (sb.buf[1] !=3D ',') { /* long option only */
+			o->long_name =3D strvec_pushf(&longnames, "%.*s",
+						    (int)(s - sb.buf), sb.buf);
+		} else {
 			o->short_name =3D *sb.buf;
-			o->long_name =3D xmemdupz(sb.buf + 2, s - sb.buf - 2);
+			o->long_name =3D strvec_pushf(&longnames, "%.*s",
+						    (int)(s - sb.buf - 2), sb.buf + 2);
 		}
=20
 		/* flags */
@@ -537,9 +538,9 @@ static int cmd_parseopt(int argc, const char **argv, co=
nst char *prefix)
 	strbuf_release(&sb);
=20
 	/* put an OPT_END() */
-	ALLOC_GROW(opts, onb + 1, osz);
-	memset(opts + onb, 0, sizeof(opts[onb]));
-	argc =3D parse_options(argc, argv, prefix, opts, usage,
+	ALLOC_GROW(opts, opts_nr + 1, opts_alloc);
+	memset(opts + opts_nr, 0, sizeof(*opts));
+	argc =3D parse_options(argc, argv, prefix, opts, usage.v,
 			(keep_dashdash ? PARSE_OPT_KEEP_DASHDASH : 0) |
 			(stop_at_non_option ? PARSE_OPT_STOP_AT_NON_OPTION : 0) |
 			PARSE_OPT_SHELL_EVAL);
@@ -547,7 +548,13 @@ static int cmd_parseopt(int argc, const char **argv, c=
onst char *prefix)
 	strbuf_addstr(&parsed, " --");
 	sq_quote_argv(&parsed, argv);
 	puts(parsed.buf);
+
 	strbuf_release(&parsed);
+	strbuf_release(&sb);
+	strvec_clear(&longnames);
+	strvec_clear(&usage);
+	free((char *) opts->help);
+	free(opts);
 	return 0;
 }
=20
diff --git a/t/t5150-request-pull.sh b/t/t5150-request-pull.sh
index cb67bac1c4..86bee33160 100755
--- a/t/t5150-request-pull.sh
+++ b/t/t5150-request-pull.sh
@@ -5,6 +5,7 @@ test_description=3D'Test workflows involving pull request.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 if ! test_have_prereq PERL
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index e56ca5b0fa..60e4c90de1 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test automatic use of a pager.'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pager.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
--=20
2.45.2.436.gcd77e87115.dirty


--XxPlCPgyLuqk6lBR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFqcACgkQVbJhu7ck
PpSwSxAAhTX9HEllpvxq+key32jAiPimrj8kdXdloUFb/CcOwJPts8w5UzldqqNh
RAgpeB2e71apMHFGn9pxOx7dicn5mLnfXTeXExJx8+bgrS+bg1wMvtKuhbu9GKK5
4TtsDhKn+cW4GfGeCB61Bn+m+I5/6mA4zG8GKPHqziUoD7ZkqrHgBCknaXXm9Axc
tra0Xq/Ut3XevphYXUVXioL9Wl/Hkhf+N/maE9FnbxSHahAp7okJvkCta2M2B7aZ
tV2XMekW6Fj4qIdhrbgQ8RkhUiCRtx5HHnosVx0cc93L1yCCZdQ/isBm6nHv1SpV
d/mYrH1mc3lsP2gbYkioFDutkdIm/h9GqNjFczd9iPGmzjsD6fsCZBOezYoSfSj7
+nYY6oqfE9gmT5xk3u8kbN6OAvlLpFwqP3NqvyKYIZscaIYKtZjI8FbOHXylw0L2
EiIT+6CkWwuJO9o5XjjcwafURQgMYWPwp8Y7ByIcTkGbGPfULjQFfflfI4vDMSzk
CasvRhb/O5RuBKKqMpKUEjCMliy5iBBOMS6BL0RpIZ48dfTnGt6YmRnE7vEiYLjj
+7hGRByzJoVPoZLP0lHoLdWv1xEqVTOi5XxcuPZ+ME40eFwMOA5G3F6ApAm/Sc70
JgA4WMno2yqjzTvn1qf08yt2MF47oCP8Q46q+9VjkH8DG5TKx28=
=rXwN
-----END PGP SIGNATURE-----

--XxPlCPgyLuqk6lBR--
