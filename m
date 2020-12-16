Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F13C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9695623343
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgLPH55 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:57:57 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45813 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725287AbgLPH55 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:57:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 795315C00FD;
        Wed, 16 Dec 2020 02:57:10 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 16 Dec 2020 02:57:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=CSTjnqGa8LOTtUv/l8Ny2xg47Vi
        uOT81CxYypZ0yfo4=; b=nmLPGu4WB3uTXSR4Od54N4+aS4/MDertDtgIvw9Ioec
        86buF2nCckjTFYXsnFJdsCzuUsTaCjvILUKMcccBDXyDTc0RNZNz52RMrNMgJ4Ly
        55Nd8kON8wjECWOlp3WYemAAeb48eCnLnlmq+mM9P5xZoYOkaeKTLsYYTSmj/+M2
        eVx/B6Ndy1+INGzDdaKgzrPRLmsDqxA2om9B0snGMqjSuK3ZwWyoceoeS3696aW0
        0eCtYBQEXzxrRCtigB33Nhjk8IX/HL4TxEQ+JyGDiSYOJPCO0Glig9gsP+KSttu4
        Eu7qkkxbPHCQ6FnIwnSEqmYABhKCEBJm4qaKOUXdn4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=CSTjnq
        Ga8LOTtUv/l8Ny2xg47ViuOT81CxYypZ0yfo4=; b=Up6diENlkZAjXFMzXOQtwV
        /FqT4V9uQSgOfuPMz/y9cYZdjGhWPlPCtYEhxIB9fz/RhZwe+3MoQHQCuvtKqmvi
        P9+jPff06D9VLGwlj4zCa0PxuC5glnLlxbBehMy0m1d7saMO4vo4EpKC+MCgqmnN
        Njlux/Wu8SI7NM8sLID8ByvL/DD0Zgv8KBaeKqaCcDLdsPWdTAB7cR/1MrpYHCrV
        TnRKlFeUc1FhAjjZh1lvB7BLMmuyeys8Om2+yPbdgsA6tjTG8AZfYife+Xm/X+f4
        Gx+bNGeYO+lIeoQBB8K5EzpYjcCFMm8Gxig5VXSjSlg9xOuw0UP+ZHMsVdTBfKZw
        ==
X-ME-Sender: <xms:1r3ZX7KH1a5Ev1wFhrSCkM0bP4LXd3x9kr9ZntAD7XeYUDoqYL7oPw>
    <xme:1r3ZX_LO4gRK3UAFnVL6j0x_Kkw03itWRtRTc323nrPBQ-kXPWIWP9ds8JA1VgeQQ
    xh9op9V0HbNPiaDvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1r3ZXzvh93RQZ0JXMYQyIHE03ukw929rpswEWGYvK7WfGz91rbG05Q>
    <xmx:1r3ZX0ZULZOwQzUex_s4-cvLx0yHRKLhU6qdSlmrS2eBwpf7qtQJOA>
    <xmx:1r3ZXyaKzwSfXIG4-9BPeKFaCVBuG95UAAZmgBoAndmqm-ThDXsd_w>
    <xmx:1r3ZXyHI4mLmCt3sg1cfrhsN9aF5dfIidWH6hLBusRFKRBscjKcN2g>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 82B7A24005B;
        Wed, 16 Dec 2020 02:57:09 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d4d41f2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:57:08 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:57:07 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 6/8] config: parse more robust format in
 GIT_CONFIG_PARAMETERS
Message-ID: <d832f3dedf5bde4cd9389ddab734703ff2dbd5a1.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0rrVq2wtY+mre7Ih"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0rrVq2wtY+mre7Ih
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Jeff King <peff@peff.net>

When we stuff config options into GIT_CONFIG_PARAMETERS, we shell-quote
each one as a single unit, like:

  'section.one=3Dvalue1' 'section.two=3Dvalue2'

On the reading side, we de-quote to get the individual strings, and then
parse them by splitting on the first "=3D" we find. This format is
ambiguous, because an "=3D" may appear in a subsection. So the config
represented in a file by both:

  [section "subsection=3Dwith=3Dequals"]
  key =3D value

and:

  [section]
  subsection =3D with=3Dequals.key=3Dvalue

ends up in this flattened format like:

  'section.subsection=3Dwith=3Dequals.key=3Dvalue'

and we can't tell which was desired. We have traditionally resolved this
by taking the first "=3D" we see starting from the left, meaning that we
allowed arbitrary content in the value, but not in the subsection.

Let's make our environment format a bit more robust by separately
quoting the key and value. That turns those examples into:

  'section.subsection=3Dwith=3Dequals.key'=3D'value'

and:

  'section.subsection'=3D'with=3Dequals.key=3Dvalue'

respectively, and we can tell the difference between them. We can detect
which format is in use for any given element of the list based on the
presence of the unquoted "=3D". That means we can continue to allow the
old format to work to support any callers which manually used the old
format, and we can even intermingle the two formats. The old format
wasn't documented, and nobody was supposed to be using it. But it's
likely that such callers exist in the wild, so it's nice if we can avoid
breaking them. Likewise, it may be possible to trigger an older version
of "git -c" that runs a script that calls into a newer version of "git
-c"; that new version would see the intermingled format.

This does create one complication, which is that the obvious format in
the new scheme for

  [section]
  some-bool

is:

  'section.some-bool'

with no equals. We'd mistake that for an old-style variable. And it even
has the same meaning in the old style, but:

  [section "with=3Dequals"]
  some-bool

does not. It would be:

  'section.with=3Dequals=3Dsome-bool'

which we'd take to mean:

  [section]
  with =3D equals=3Dsome-bool

in the old, ambiguous style. Likewise, we can't use:

  'section.some-bool'=3D''

because that's ambiguous with an actual empty string. Instead, we'll
again use the shell-quoting to give us a hint, and use:

  'section.some-bool'=3D

to show that we have no value.

Note that this commit just expands the reading side. We'll start writing
the new format via "git -c" in a future patch. In the meantime, the
existing "git -c" tests will make sure we didn't break reading the old
format. But we'll also add some explicit coverage of the two formats to
make sure we continue to handle the old one after we move the writing
side over.

And one final note: since we're now using the shell-quoting as a
semantically meaningful hint, this closes the door to us ever allowing
arbitrary shell quoting, like:

  'a'shell'would'be'ok'with'this'.key=3Dvalue

But we have never supported that (only what sq_quote() would produce),
and we are probably better off keeping things simple, robust, and
backwards-compatible, than trying to make it easier for humans. We'll
continue not to advertise the format of the variable to users, and
instead keep "git -c" as the recommended mechanism for setting config
(even if we are trying to be kind not to break users who may be relying
on the current undocumented format).

Signed-off-by: Jeff King <peff@peff.net>
---
 config.c          | 69 +++++++++++++++++++++++++++++++++++------------
 t/t1300-config.sh | 52 +++++++++++++++++++++++++++++++++++
 2 files changed, 104 insertions(+), 17 deletions(-)

diff --git a/config.c b/config.c
index 53ed048689..60a7261807 100644
--- a/config.c
+++ b/config.c
@@ -541,14 +541,62 @@ int git_config_parse_parameter(const char *text,
 	return ret;
 }
=20
+static int parse_config_env_list(char *env, config_fn_t fn, void *data)
+{
+	char *cur =3D env;
+	while (cur && *cur) {
+		const char *key =3D sq_dequote_step(cur, &cur);
+		if (!key)
+			return error(_("bogus format in %s"),
+				     CONFIG_DATA_ENVIRONMENT);
+
+		if (!cur || isspace(*cur)) {
+			/* old-style 'key=3Dvalue' */
+			if (git_config_parse_parameter(key, fn, data) < 0)
+				return -1;
+		}
+		else if (*cur =3D=3D '=3D') {
+			/* new-style 'key'=3D'value' */
+			const char *value;
+
+			cur++;
+			if (*cur =3D=3D '\'') {
+				/* quoted value */
+				value =3D sq_dequote_step(cur, &cur);
+				if (!value || (cur && !isspace(*cur))) {
+					return error(_("bogus format in %s"),
+						     CONFIG_DATA_ENVIRONMENT);
+				}
+			} else if (!*cur || isspace(*cur)) {
+				/* implicit bool: 'key'=3D */
+				value =3D NULL;
+			} else {
+				return error(_("bogus format in %s"),
+					     CONFIG_DATA_ENVIRONMENT);
+			}
+
+			if (config_parse_pair(key, value, fn, data) < 0)
+				return -1;
+		}
+		else {
+			/* unknown format */
+			return error(_("bogus format in %s"),
+				     CONFIG_DATA_ENVIRONMENT);
+		}
+
+		if (cur) {
+			while (isspace(*cur))
+				cur++;
+		}
+	}
+	return 0;
+}
+
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	const char *env =3D getenv(CONFIG_DATA_ENVIRONMENT);
 	int ret =3D 0;
 	char *envw;
-	const char **argv =3D NULL;
-	int nr =3D 0, alloc =3D 0;
-	int i;
 	struct config_source source;
=20
 	if (!env)
@@ -561,21 +609,8 @@ int git_config_from_parameters(config_fn_t fn, void *d=
ata)
=20
 	/* sq_dequote will write over it */
 	envw =3D xstrdup(env);
+	ret =3D parse_config_env_list(envw, fn, data);
=20
-	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
-		goto out;
-	}
-
-	for (i =3D 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
-			ret =3D -1;
-			goto out;
-		}
-	}
-
-out:
-	free(argv);
 	free(envw);
 	cf =3D source.prev;
 	return ret;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 36a60879f6..35a1a6e8b1 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1294,6 +1294,58 @@ test_expect_success 'git -c is not confused by empty=
 environment' '
 	GIT_CONFIG_PARAMETERS=3D"" git -c x.one=3D1 config --list
 '
=20
+test_expect_success 'GIT_CONFIG_PARAMETERS handles old-style entries' '
+	v=3D"${SQ}key.one=3Dfoo${SQ}" &&
+	v=3D"$v  ${SQ}key.two=3Dbar${SQ}" &&
+	v=3D"$v ${SQ}key.ambiguous=3Dsection.whatever=3Dvalue${SQ}" &&
+	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.one foo
+	key.two bar
+	key.ambiguous section.whatever=3Dvalue
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'GIT_CONFIG_PARAMETERS handles new-style entries' '
+	v=3D"${SQ}key.one${SQ}=3D${SQ}foo${SQ}" &&
+	v=3D"$v  ${SQ}key.two${SQ}=3D${SQ}bar${SQ}" &&
+	v=3D"$v ${SQ}key.ambiguous=3Dsection.whatever${SQ}=3D${SQ}value${SQ}" &&
+	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.one foo
+	key.two bar
+	key.ambiguous=3Dsection.whatever value
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'old and new-style entries can mix' '
+	v=3D"${SQ}key.oldone=3Doldfoo${SQ}" &&
+	v=3D"$v ${SQ}key.newone${SQ}=3D${SQ}newfoo${SQ}" &&
+	v=3D"$v ${SQ}key.oldtwo=3Doldbar${SQ}" &&
+	v=3D"$v ${SQ}key.newtwo${SQ}=3D${SQ}newbar${SQ}" &&
+	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.oldone oldfoo
+	key.newone newfoo
+	key.oldtwo oldbar
+	key.newtwo newbar
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'old and new bools with ambiguous subsection' '
+	v=3D"${SQ}key.with=3Dequals.oldbool${SQ}" &&
+	v=3D"$v ${SQ}key.with=3Dequals.newbool${SQ}=3D" &&
+	GIT_CONFIG_PARAMETERS=3D$v git config --get-regexp "key.*" >actual &&
+	cat >expect <<-EOF &&
+	key.with equals.oldbool
+	key.with=3Dequals.newbool
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'detect bogus GIT_CONFIG_PARAMETERS' '
 	cat >expect <<-\EOF &&
 	env.one one
--=20
2.29.2


--0rrVq2wtY+mre7Ih
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvdIACgkQVbJhu7ck
PpT4BRAAkbIFlxhLjVEMcJvGUqnQNLs2HnGpDVQuaM/ReFc7ELHgQHwJapxeQ/yr
XZuG2bL5W7EzsTRAFfDkZH9uc4yyu2wVbWwrn/NuN2PyHRV/HzoZ2d+wT3jT5YzX
qV+SyFtzJtFP4k6O6GuQcK47Jh/0XNjrAm8U0IV0WQrsG9yCeHApxi/xaZtIqhI1
b1jL+ueWOf5oezg1e+gQ6MSAWJ1FGJETnn2tCXjxwgchOVg7To7k4mDl+PGnSMn3
511EuaBH++pujmrWjFwAVLkYmrjs3MPUMmx1MwWdhWfbdJja8Tazf3a4/yFyLT7M
uD4wMcq3nWvGGopvGb94k6815Dpc2UkTxceMHr/cLK5RZA7c+rlYLZpIhsbs14ob
lb2ILiOlQjyLxsSTThWOFC6WBojLcpN9+3AYWpOs1W7nwjpPp/N2VCR79zKg5501
IukwvzIOZr2ZSp5p+tFEUH3v11YH0aCqSzRKhL4NlH5eDB5LOaWciDFedJ9YPbxE
JPfpegWwWWe7jqJSFGIQ0iZ+k+f5CwKG/+BHdM1Y1D3/yjKcr1OTZGd5+kRgSP13
GtzGMINRIj+vXICpE5V41bD87Oj/kB3xxJI5SEs8e+3epkjUMsINj3PLkeHMRVmZ
e/+3Qwouznku+TU+F5VP9S48zGmUGGgbhx9nkHQ4FtEtxq0NJFY=
=Qj/q
-----END PGP SIGNATURE-----

--0rrVq2wtY+mre7Ih--
