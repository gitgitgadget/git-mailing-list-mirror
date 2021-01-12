Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD0DC433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68E5822BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbhALM2V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:21 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49507 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbhALM2V (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:21 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BDE951525;
        Tue, 12 Jan 2021 07:27:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=+82KNILWNeTZMZbbHiHV5Hhv/zl
        m2vuCVZPq6y0gkbA=; b=i2T4kPaq51kGxN6P3OLGQ5UO3+pVMzHemngEWoF39w0
        eG8FRU6V1Kmp7ebHriEgGy9aQvRRhg9BqlbB3jHl2sDttK+Wu3NZ/3MgmR2gOrjj
        rdci4jxaDuSYAzhZIN+85+omyvgx3kHDf5t/hnL2si3nOZ+876ldizKUJ31bH2FC
        32ypkJUnPkjH5faIJbNJzKOPGrkWE921o5Q1o7x0dfEWX5kF9+u/GulA8f0kamH8
        pVCCv4FCaGx5JI4hY3lIZUj4xmpeuiF61oFwfQerfIekdD23HldJc7E36c3CiMGX
        RqMpkr0SwC3e+pyjF7Eizy+s/krxO+/jrWPU5i4v5Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=+82KNI
        LWNeTZMZbbHiHV5Hhv/zlm2vuCVZPq6y0gkbA=; b=jFZQf7/uoKKzu4nm1Dlsw6
        yeqfGa2EihPZ3gNc124ar5r2v+K9FHCmG91dunDT6RLJDRmEvs3MhcD7qB9vQarQ
        qVOvikP5VrqRZFpfQlwmotAIP7FQe86w0zr84NwnhrWikpY5geAFK5m39Cjaobew
        A9j7OlDv9ew3JEDwBL15uPUTsLZ3qpSyC6o4tZiIIW4jF0CLARTNSs4uAw29sgJT
        T84gzm1sF0+nnffsHodxw7Pm6H16r6naxKpZtEglURhrWZ7GfNN8Jl9vQ5u2hCoC
        H8/YOVPj+4dB+JuSthC75w4d7kqX+9yoFFD4/zLAcq7LkB+nwg2ufCWuxobu+EcQ
        ==
X-ME-Sender: <xms:nZX9Xz_RuJjw4dlVp-bv3dPE8FiZWwTGXpaf1TWVOAzKHe21yxmnug>
    <xme:nZX9X_vNueLwNp0KXI3H8xLODp6Hq1ty4QGtT_L7uDHpiEm_0SeNewSuvl7r2F1lr
    iykxL5l52N44YYnQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nZX9XxCO8PxbGxyyR1IgNXbn0aK-1OHQbCeWv7vKGudFu2267ba3FA>
    <xmx:nZX9X_dIsu1Zs6p98BzPvhRe4KWKWHkJO2Z-rkcGOa0-EC1GL9LBgw>
    <xmx:nZX9X4O_bhTOE898aw16m4ucflvYino81g2uKyAbM07k_jip2VAOsQ>
    <xmx:nZX9X1qg-khBGSduVeBD-cG1lcUbzv2Laob3SXuNPat_7qKyponuhA>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 650541080063;
        Tue, 12 Jan 2021 07:27:08 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 510d6177 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:07 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:06 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 6/8] config: parse more robust format in
 GIT_CONFIG_PARAMETERS
Message-ID: <d67a3c0f9f37288e2d5e2ab6dbe88c2bb8971fc2.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="o0pKXYCiGryJwnDF"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--o0pKXYCiGryJwnDF
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
index 7f7da60574..99062915d7 100644
--- a/config.c
+++ b/config.c
@@ -545,14 +545,62 @@ int git_config_parse_parameter(const char *text,
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
@@ -565,21 +613,8 @@ int git_config_from_parameters(config_fn_t fn, void *d=
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
index 25437324c1..3f6778d474 100755
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
2.30.0


--o0pKXYCiGryJwnDF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lZkACgkQVbJhu7ck
PpQoIQ//Zi9dgBQotMrhJoiVRY8K86Uzilzov1toCXWxy1Lc80kO84mcBNEVE/g5
d5qlOl6n0rjaPQy5rMe5/5U8c0HGWz5L7cuSP3R5jEo44wlYXAnAAPbH6fOQALxw
rs+FUzl/8+uu5/rlohC/FYkbstq0x8RYzcbG+jtpGY7LLy4ZGFaXXJx/zDdc64yj
bHyDLcWDgsNcA1HVETrY1xJ1/0cxs+8TBAd5mqVMabejwAlzp+S2UJwT1/1sVq5Z
Re3wNqbh3K8ABwH0s0K43Ha/0uED7WYCy7XKvoShFi8qCSxKkuBMIr8XZdPs+KjP
7DvzVjzxLgypBHBVWRNjFVPfocB2hn5MsBeizTO2I/gFt6KpbAXjPuAs7noz92Ob
aJJcA7t2k9q+DNkg8K9UBUsEJJO3AfsMtSXH4Jadks3yy4JtlK1lrV7u/g5A4Ff6
XqOpYfxFL1hsuKnShQKiwhC70QzV1NM+BId3EJiGK3Z4yJWBIHFVcQ3XLFPv/l0C
mpmY6QWpoKdkuCra2NTVJitU8Pg7fJxuOKi+/iQTkdGhIc7NUZTV15w+zhhFEd/f
E0td/X25gvbBMq3tmcWe+bOs4fJBg95pfY7Cipa0u1EfADuc4KaeglSXaggUg9gW
U2Nds2snq41AKIZK4JncR/PPtMOx/yaqOsSdDLU6HhfmvNu7pAY=
=yAy8
-----END PGP SIGNATURE-----

--o0pKXYCiGryJwnDF--
