Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FEB83CDA
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408012; cv=none; b=YogVJv6RNUxix1MJkXfxOwgT/O/ujmekdJfqXjtAs2Aau4aSYKOg1L5+B/g6taBaEZAg1lG89vwoYmQVZyD6/bBkUDdLoPnfp3aHfbew7oSAY0//aevHR4336yUOEux4xI776l6MXiB70xKTgmIigfCLpY5czoqg5yqzE9yQECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408012; c=relaxed/simple;
	bh=/KhxEe6Bc689lVnnctldS4HeL+g9nh07w9urwIEOLGA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZmzxcwLJKXyOWDo6x1YsxPkitr5keETdRaNhpoZ/wqTPH3muzToa+O2a7kifRj6QEeRtU3NAWbJUPO61HrJt86e1dGeTs/QlviN+GUYVDMHM0q2E48nF7ywJN9+CE1NbigMBaRRNGGg2zKz9+vh/pwAXjU+c9wfAob5cMfCzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OvNmaPIx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I7L+IYCx; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OvNmaPIx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I7L+IYCx"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id AB7291C000EF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:46:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 03 Jun 2024 05:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408010; x=1717494410; bh=xRg2RANr1C
	qzBbllrJDqywkaoZlwCU5C0KDSTZAgOpc=; b=OvNmaPIx22eDGYQwXUQLCNKo41
	vPZNc1aYmfCOd3zqntevNr+y/gCrb2jCGY/QBjq5AesKjorYSg3ndDBJCVBuST5i
	16CdhEkX01X46TOF1+fWUITYs1OZv9QZrVS3Fxb0VLPiozTTebBbJm5ZzAoDAI6o
	dgnYK80TheU2Xpd2IV0QG0vmYKarkWlcuFqaQTXTs2Rhw2RIEByeHlSfvhI1lHvB
	n4w/58VCR8/VQ/9XnMBkT+qyQce1AvhB/BxtdGI0vwlk3hH05WpkORGrSVOce5e5
	TQM08Dpk62Uhz57xVnbXUSHQ5ibk9vAQbrti95TqrBHb5Sm5jD0xuX9LMb+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408010; x=1717494410; bh=xRg2RANr1CqzBbllrJDqywkaoZlw
	CU5C0KDSTZAgOpc=; b=I7L+IYCxPGtxvTFdqF0b2jfoAJK+jbEtyAOX0smosCBB
	FUBjv/7zLqzB9eYDEFYSkDMWDGn627bbSA72nV1qV881K9jbcD+7s6la03AqIjsQ
	FMbDr2imLs/k1TqpD+JgkdDxuJ6QWxdF4X3IFUah7k4A49LpR1ZOGJ3CIgnUQigt
	o4lQVC8/YVl9ONhH7fabyqF11evOH481FNBHvmQjxbcBu05doBuPiaL/8z8HkD2c
	9AY3SLyggJYSQScVA9GslWcX243NSF19KIYdVSU0QOs863ieKXTLPjGBQMHA2wSp
	b4AnJwYifhZzMIrRPAeMWWby2amTHTHEzF/TZXrn5g==
X-ME-Sender: <xms:CpFdZmgm8_DpffmHqIA5fsGTaIVJxXKX_IR-HfuvyHZkA922QGYQhA>
    <xme:CpFdZnDm3uv14f7ujbPe585sqiiMCRkl83mRheWCEn2-yGH556OF43TDEOMFpUjXd
    ChSqYyoPXu0tt6LNQ>
X-ME-Received: <xmr:CpFdZuEVkTfmmhfhC7UiucWc5r8oDQncjP2nEYilgGibhD41RRGttscNAykFuIhtH652LQ39Wpz3cJS0o-lWcz0ge_T-gXw2rn6BoKI5AZNvSKb6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:CpFdZvTivZCbvBPCZ8sQnZNL_FRcY3LqI0ebNcrixzd646cWrI2cIA>
    <xmx:CpFdZjye9Ef7zV4mvtKMVYeHD351am7XVOM-B51bT1grOog2PXCH7g>
    <xmx:CpFdZt7jh9F8Qy_ifRyaPThyELZqWpduI0VQEikC1YQi6XKufUK19Q>
    <xmx:CpFdZgwL21TEfRAGFu2aBu3kcfznoLrqO9tRXcNsKaJ3hSc-m5vdyg>
    <xmx:CpFdZsrYCg2jbOxJV-QgCizGey3n1fHzatgoEbH75bbs9QFXyuObzAxt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:46:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 43fef64e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:25 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:46:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/29] biultin/rev-parse: fix memory leaks in `--parseopt`
 mode
Message-ID: <620814fb99f4ef51ce9389ec098670b3d167f391.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="839os477up2pcrKs"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--839os477up2pcrKs
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
2.45.1.410.g58bac47f8e.dirty


--839os477up2pcrKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkQYACgkQVbJhu7ck
PpRD9xAApbGl852hFbkTRvkK5umd3GAlKuLiGP6ofkjWKC/zUTU0Zxq8u3HjFEci
rMIPqCoDXLq+AqIiXudIO73fKxWBl4pTDgiFrHKJoaI2zPNi17Ig8+ajG/lsofZn
CeUbbe2QyE7gwrPtH+EBj1HIpPGxiShF9+px0SABpbYiwUHTH2g2+3D15I4PoqIY
CtdHwNFNGCHNGd0f0WWR1koLLzoWtClMN/HFZE+0PRtZEx2Xz+HJIHeFDRhXQpO1
UKFvDNOwpdio+0iSYByJa8DLBKRuJPyReIPTFkXSvGkC4C+erIumJ8vrUqnGrywY
yrVBPDkRgRM9i3O4hXb2Wfr3fI3aUYoD/EZ1gGeUKUVgv19DJYFlacM7biqysgNB
yw5kLWRNoJb2WrNTXeL0FSxsyPehSwwww0onzfyFc3oRB78+c4IpRBgHjKeqalBQ
nqivz/sbK0RTWl1C+Vnfr5z5YE1rb7uvb1h/fp0wEkHoI0GVfemAwtsgbpcdGbMk
FVRLI2mhkgyS0tHhiplIqfZf+MHhp3juus5DJuFBklzJgF+aD+pfTLLb6PN6+6M9
fwyiZSRtCFrfxML87Mkr+KcCs1A+okN8VCH/jxwlTdBxRwSMvIYElyBGiEoYLn4f
gUQj6P+GKwPKHRFFajcvU1yVulbZnGtQJHOAQwVioQvEdLTZZT4=
=H/uq
-----END PGP SIGNATURE-----

--839os477up2pcrKs--
