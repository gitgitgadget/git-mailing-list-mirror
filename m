Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5931C433DB
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E4422D71
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbhAGGia (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:38:30 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37085 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbhAGGia (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:38:30 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 395285C0163;
        Thu,  7 Jan 2021 01:37:13 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=y/+sWOf+wYwj+cOQ3h+b/kngs62
        nC5tNfMvarA9Le+Y=; b=hxtdH8MvyJiYSlr3FGJZE2ehditdWpll7f2BM7y4wEX
        Dn2XDYUPgE2V4FN3BQJK/kIvttBEti1pMa8GSkOsIknfxywDUbRv2f1LnLZ8RswE
        feD4HQyzjmBZOCE4ghd2SJkjVUZ5kxpRRge4xdLy6PEZd5U6PO8DoHLYDADlRhdk
        aKmGm2kqbHG3Z0SJCBd3YYPjpa5UxWs4GLKpufO//HBH5AvZCwSEgy2bRdTHzH32
        GuF9za92TyIyjyiyZEJH1Zew4DuVVcdv2so8vdsW/PcMKPteWoSGnjhwS1/Vmzkp
        h9SkN6qlwhHPPfKptWILmSCacZ84/p8VBrNWgb1J0+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=y/+sWO
        f+wYwj+cOQ3h+b/kngs62nC5tNfMvarA9Le+Y=; b=ICkLIA5mHl65yX8p1C+F8/
        xeSgEkRNVbAX0c1YF0bPjNVna2bC2/2pxfJioXAgdBtjRUXwa/7e7fIYRB0aW6j+
        XgsIwQhoUb8JCfQl6MiI563n2CUnYe9gWoXGoC2P31VBjAGAmZMV2vuXtfmaTPLZ
        804ZxMnttvxET2DNoUdkkdAKGxlja5+JZu6yhVnjnokn6K7ND3XjS2al6fiHavWy
        qWCl6Z3YjeVD24tuS0nvy9VtoGGIL5HGo2m+En28RGVSamJ8c7CCa/Rv+HxZflz4
        l2PJAew/11sK90hLP0wJ7BoLIHzARA82NKk56CK+E14Y9LLccn2uLkMYU1F+rHvw
        ==
X-ME-Sender: <xms:Gaz2X2KhhbUsuMr3oeJcWcqjk5TSXhSTdV3i5ulsngtq-qRR7yrP2g>
    <xme:Gaz2X-LeMWMKwt3oNXG6Z_0NSCz6Rj0RmUgELU5WEG5mGcQALMr-4Ryg0TKRAJA-X
    NuC7xbPpsYkYWBVIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgepieenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Gaz2X2tKM3Yfw4MjUzNBVY9iA0IpsGkq2MZqiJejFXB2tevW7oWhnA>
    <xmx:Gaz2X7Y9OhLX0NnwSdeXK6_jVYpS8orJQJYfcYE-23RJWAVsrRECVw>
    <xmx:Gaz2X9aOSQon5VFmaQU_RUqgC2-KndK7d4HRlAwzpMvcohTIQKugGw>
    <xmx:Gaz2XxHVd6nCrgU6QVF9vAP9z6E2vu8HxBb9bvKDxOnzv1WjtxjYbw>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 490E9240057;
        Thu,  7 Jan 2021 01:37:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6f004ab2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:37:11 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:37:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 6/8] config: parse more robust format in
 GIT_CONFIG_PARAMETERS
Message-ID: <6597700ffbb338feb3d82e6baca2591c4e403a24.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4aSYXN2uq6T+qDfj"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4aSYXN2uq6T+qDfj
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
2.30.0


--4aSYXN2uq6T+qDfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2rBUACgkQVbJhu7ck
PpSb2Q/9Eqy4zCN5/SCodqdxwRgnnETuE3qyP1ZzC7yjZeQzvooDDhsa4NmfYfKZ
ZgV1Rye5LM1xrSmM37HfTYtkK+P8Q0QBmwVxSvXPCIPZvZTVzBw0nCvVj5joLJLc
owzJRBdGjAmyvaNrMF7jFNeifmxjxTMgDAE+4QvaHLkz0eXMplMxkgkFcT6j+W7g
uA+IptsF5D3CGootwvSEs00vYCWcGP4fk3DINOFYyn5Clrk8hcz6BR0Uc+SDO83z
nDW8jcC+sjW9BWlQDG2ecbS1n8wuaE3eTme1Ibe/IeS3qqXY+UfxWtFuhkglhxb4
Amr3ybbxjbSi8dxvmBz2KV+hJ7Owr+B6Ece+8UzOk2MYFNFayM2FcUWTGVts+1qa
GQNuJpzFV5O+lfDNuro2qoeU+S4LU/G9Wb4O9WlC5+HgTB8RuEHnfyx3CAHsd+n/
AaoM+J5BIKgptB7YNN6zfXoVxDLWMDERVdrFh2SMFI9jLYtymeb1PPteSmOKJaCj
sDqPNwnIS3Y5lzv4ir2BiqeqZl6Gb4gi66XbURpp00zsG+1fRjrXQHUClJWk1Nmh
Vp4zV/eIKjjNCYc8qmPrQHwxvOVUHgdhmB4fiEdQjSUJOZ3O9C2hSE5WrdJKR/ab
XxXqKYb/IetoD0mEny93rTNwucoiaBnrXPSOIVunFvSS0auiF0w=
=NegD
-----END PGP SIGNATURE-----

--4aSYXN2uq6T+qDfj--
