Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F64C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C5822240
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gG4u7NvO";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwCpOUKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgKMMQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:16:38 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38351 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726406AbgKMMQZ (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 07:16:25 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 1815DCB9
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:16:25 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 07:16:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm2; bh=h+KUNt+I082XHsBM0BmO+ips/WCh1M82vQXHgcAY
        ZjQ=; b=gG4u7NvOen7jIoeAHmolj6bgqpjKP0VFcPgfSfxCsEVjF9DKIlRxILg/
        swFsCHV35JMe1Bnl0TsLZImPhZSfzwT/2EUsjbPzivkZwASvK1nZmA+ZUZD/X0wL
        BC90KgUkxL10kpRCYgLg0H2PTlyYSeT7soWj8x5eLiDAAZJC8u5Pxad0OCZaI9d2
        1RAuuzov2MKOA0e9tIq3etsjSjI8uQyTuNWaeki+OMfSzEP2E8ABZu84rVyYJaxa
        zDW6ZaRKldD6ZjTkz1jUgXtym955lgal3G7LtDD6SjI9MB94k9uu6J65TT6iQ2QK
        oCDX1pnpIk9WJYXqzykpZawRFtgBwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=h+KUNt
        +I082XHsBM0BmO+ips/WCh1M82vQXHgcAYZjQ=; b=lwCpOUKLLCVAXt3j/FRl18
        u8l/QC+RZEjtb+pRB3wZ6kI24ASma6pw51OP/L72+jLcv5HTDhHjyasUQMNWKnob
        1H7LSD8sqPIt2vcA1f+3zQ+0BIfJusb2NVx87fgWFpFcJbBeUmQ94gFTCV/3owmv
        t/U2ozHTf4MNZBy8Mr4z7iKE1ODf4zgzkNkqG8wCVB96esY1P+quI4NZ30YJIx4Z
        PqkommbweioJwi/P9N32H+Mn8VMWh2+r4Zl2yTKW9xrz+lYA92lsC+TNkPqRkWpu
        b/kdPtnASFBm68EkDzLbgpV39ddsNmE3hr5jUZrZ6neRsB1GkBpR9szKvPjGRetA
        ==
X-ME-Sender: <xms:GHmuX-PKvRk52lngbkfuVRn8ZnYt7TMpl8_RNs-A6ywtrEonl60zdg>
    <xme:GHmuX89wUaWo7vKBAN7WIIOn_KUy9l0o4M5cHbSmukusq1TTLf_HuZwCYcHDPSepV
    BttGyee0Cfr-tu8OA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvhedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdefuddrvdefheenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:GHmuX1RaOwdpo-c2ec-vWHBYesZ9s8j_qyBNLNtvhiGx3WdZ_YjrMA>
    <xmx:GHmuX-tZwMkSpgoHVtsRJhLKDUr6q5hoRcLsVAIBW23_WiDV_CwSNQ>
    <xmx:GHmuX2cvl6IT4tJa9c4Tss-ngb92vRvwOgJf0TEX_gi0vjAbCxAjFw>
    <xmx:GHmuXwqPmQ4nzybDH5_f5Oc078pNYqjndV8ud3nZ3ZgK8IQ118jBew>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 217B23064AAF
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 07:16:24 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7ee2c928 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 13 Nov 2020 12:16:22 +0000 (UTC)
Date:   Fri, 13 Nov 2020 13:16:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] config: allow specifying config entries via envvar pairs
Message-ID: <44e8dd50c6ea7cbcc5e4fc35c9b9057c0a52038c.1605269465.git.ps@pks.im>
References: <cover.1605269465.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nX9CFOgoZKRfQUkV"
Content-Disposition: inline
In-Reply-To: <cover.1605269465.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nX9CFOgoZKRfQUkV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While not document, it is currently possible to specify config entries
via the environment by passing `GIT_CONFIG_PARAMETERS`. This variable is
expected to hold one or multiple "section.key=3Dvalue" entries separated
by space.

Next to being undocumented, this way of passing config entries has a
major downside: the config keys need to be parsed. As such, it is left
to the user to escape any potentially harmful characters in the value,
which is quite hard to do if values are controlled by a third party.

This commit thus adds a new way of adding config entries via the
environment which doesn't require splitting of keys and values. The user
can specify an config entry's key via `GIT_CONFIG_KEY_$n` and a value
via `GIT_CONFIG_VALUE_$n`, where `n` is any number starting with 1. It
is possible to add multiple entries via consecutively numbered envvars
`GIT_CONFIG_KEY_1`, `GIT_CONFIG_KEY_2`, etc, where each of the keys may
have a matching value. When no matching value exists, it's assumed to be
the empty value.

While the same can be achieved with `git -c <name>=3D<value>`, one may
wish to not do so for potentially sensitive information. E.g. if one
wants to set `http.extraHeader` to contain an authentication token,
doing so via `-c` would trivially leak those credentials via e.g. ps(1),
which typically also shows command arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  6 ++++++
 config.c                     | 41 ++++++++++++++++++++++++++----------
 t/t1300-config.sh            | 23 ++++++++++++++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7573160f21..83fbac3705 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -335,6 +335,12 @@ GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
 	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
=20
+GIT_CONFIG_KEY_1,GIT_CONFIG_VALUE_1::
+	Each pair of GIT_CONFIG_KEY_/GIT_CONFIG_VALUE_ is added to the process's
+	runtime configuration. It is possible to add multiple entries by adding
+	consecutively numbered pairs, starting at 1. If the value corresponding
+	to a key is not set, it is treated as if it was empty.
+
 See also <<FILES>>.
=20
=20
diff --git a/config.c b/config.c
index 3281b1374e..ab40479df2 100644
--- a/config.c
+++ b/config.c
@@ -485,37 +485,56 @@ int git_config_parse_parameter(const char *text,
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	const char *env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	struct strbuf envvar =3D STRBUF_INIT;
 	int ret =3D 0;
-	char *envw;
+	char *envw =3D NULL;
 	const char **argv =3D NULL;
 	int nr =3D 0, alloc =3D 0;
 	int i;
 	struct config_source source;
=20
-	if (!env)
-		return 0;
-
 	memset(&source, 0, sizeof(source));
 	source.prev =3D cf;
 	source.origin_type =3D CONFIG_ORIGIN_CMDLINE;
 	cf =3D &source;
=20
-	/* sq_dequote will write over it */
-	envw =3D xstrdup(env);
+	if (env) {
+		/* sq_dequote will write over it */
+		envw =3D xstrdup(env);
=20
-	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
-		goto out;
+		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
+			ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
+			goto out;
+		}
+
+		for (i =3D 0; i < nr; i++) {
+			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
+				ret =3D -1;
+				goto out;
+			}
+		}
 	}
=20
-	for (i =3D 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
+	for (i =3D 1; i; i++) {
+		const char *key, *value;
+
+		strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
+		if ((key =3D getenv(envvar.buf)) =3D=3D NULL)
+			break;
+		strbuf_reset(&envvar);
+
+		strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+		value =3D getenv(envvar.buf);
+		strbuf_reset(&envvar);
+
+		if (config_parse_pair(key, value, fn, data) < 0) {
 			ret =3D -1;
 			goto out;
 		}
 	}
=20
 out:
+	strbuf_release(&envvar);
 	free(argv);
 	free(envw);
 	cf =3D source.prev;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 825d9a184f..2ae9533aa8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,29 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAMET=
ERS' '
 		git config --get-regexp "env.*"
 '
=20
+test_expect_success 'git config handles environment config pairs' '
+	GIT_CONFIG_KEY_1=3D"pair.one" GIT_CONFIG_VALUE_1=3D"foo" \
+		GIT_CONFIG_KEY_2=3D"pair.two" GIT_CONFIG_VALUE_2=3D"bar" \
+		GIT_CONFIG_KEY_4=3D"pair.four" GIT_CONFIG_VALUE_4=3D"not-parsed" \
+		git config --get-regexp "pair.*" >actual &&
+	cat >expect <<-EOF &&
+	pair.one foo
+	pair.two bar
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git config copes with missing config pair value' '
+	GIT_CONFIG_KEY_1=3D"pair.one" git config --get-regexp "pair.*" >actual &&
+	echo pair.one >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git config fails with invalid config pair key' '
+	test_must_fail env GIT_CONFIG_KEY_1=3D git config --list &&
+	test_must_fail env GIT_CONFIG_KEY_1=3Dmissing-section git config --list
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
--=20
2.29.2


--nX9CFOgoZKRfQUkV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ueRUACgkQVbJhu7ck
PpQZtA//Z/INmI6q4aUGzfgc6bUm9HzxMUae9H92r/uWSnzyqhBjYa+CEtXtpr3G
NnLZeeDZPPyFSMV14g6u3erP0LPFQN53jlnCIn/FlZ7xPDQK6FGYLpmMQ1yn/+E9
LkUak88FV9onAKr67HkuADUj4Anlouo3jvxrkUh80DDB94/ccT10FgH3h1Bnw5wt
aoEWA8wRTgGkznQ0igJQsobABDZCCf6npIgwa9QuggwJDwlxWD3behbbq1fx3iVU
gA5PI09B/zFT097qI+nXJBNmjit2y7DjcVCeOXvMbGRI0WGHE6dwGGAg25Coh2cV
B5XaXePGfqBkVALmXqhqygfcdwweMCeOWzg3V8C/bNbqCaiJk9Qf+ZZpk4j+Vdxq
nL+Hr1WTBl6KdI55VP6Teb7Asl+Njgfswnzje8v3fCjroVcA+8J48+53IVHxkgYA
OCiH5g82flDwqptDECuMNnqy7LCOMYPH07X33LAECBDCYFpwfKrEtPyS9c/LO+Yt
Uvs3iNlnUQkQW6PVPeieydvQWct5aWwccUKArhRP9/7DiIDgnFfLByF/NK/fzQj+
ErPmaHy+HdkLI+NRctH1lRVLXQicTsQ85m8cAoSs6fu5YGyWGwsKYej4HTotUuAv
yleMOW23fOtVKgAm1Qq/SopbOEY1Lw8s2bPyPkdcZmjFQzmXcWc=
=G/Gg
-----END PGP SIGNATURE-----

--nX9CFOgoZKRfQUkV--
