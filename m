Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85825C56202
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C720708
	for <git@archiver.kernel.org>; Tue, 24 Nov 2020 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OYV927SL";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a070+629"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732183AbgKXKvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:51:00 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40321 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732047AbgKXKu7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Nov 2020 05:50:59 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 607591385;
        Tue, 24 Nov 2020 05:50:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 24 Nov 2020 05:50:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=YULP1JJ2ZfjiWumdcJCaqvN9X2Q
        xBD+f3EfiynLQa7U=; b=OYV927SLs0giTbIpN1tQQHnUEjmuIG5QVmlx3cU6slv
        Y9otA1rmRL+HVcsy/ptwKxv2EHEtZ/slA+/22OHW0/0AqyUc9WgnzsYsXgaYepgo
        ZFxsEqA8rUxJvLIEgQSVkHRvTTaGlnf1lJhqsKRrSSVasqAX3k3vmqWNURfkegr/
        OIko6V9KeqI6umajMM/1B9snOZdcfuivXV5W98YSt4lp+Eh+ROSSKhLss54B2BOP
        K87ZS7/ei+YmxlI7Uuwbr3wcRjG1Afr+WJGm5fILODSXfu5HEgUDltsB1JuCWiaH
        izUqI7iKszoEiBHYM5bVYaWW9UvGR+O8kJM+vN/C2Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YULP1J
        J2ZfjiWumdcJCaqvN9X2QxBD+f3EfiynLQa7U=; b=a070+6292xdtD3kQ0/k2Jj
        t/iDUc3Natdo8eyycoAkzvS4iC8YkVCT4wjEgYnJfAopteJ62QFL9mQopUejcJUV
        /XKwduJSZZomR1PAQ+XSQRwIdWdW4np5jaxR6EIro4QXodbnYWv7GTISbD/75C2K
        dtz/BZvcl+3e5vq/87/kveQBHA5iwijYZuZWnY+oGv1Whl3amqg3dmQKqsw5oz9V
        1FjBvJYsqytmP/Uva3hJylGuLWmeqynqkr4kS8I0B1X/BiGweU9dRufV6K+XC3il
        DRZ0PFOveCFtTjxV+Xn0sOCabjfHSIDnSlTUTsHtlYBcWR2RkuOrC8SsF/khzYiA
        ==
X-ME-Sender: <xms:keW8X5Nd1rNzik_WX7dNizfBdFDydrw83MHO5OnbC7lKc9KXDWiNrg>
    <xme:keW8X78F0i_bGgsMTbLHx_YeVCtTNkuaSstYO25vTqoNvz2OYocUdAwens4OCqgR0
    KKfJULHVkLsqMG6Cg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrheegrdeknecuvehluhhsthgvrhfuihiivgepudenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:keW8X4RkCvMWUSAHMrnHiGgH9jm7fk5djuCR72UYGUNWBJfyS0qIRw>
    <xmx:keW8X1vQTjjqi6h7DipqL-0k7nIVWTNblP0JhMPlhYXiWdcwh9Mf6A>
    <xmx:keW8Xxc96AJKS8kshRD07mIVTgzeloNZxRv7S1rz0k_DhbqxkU_GVw>
    <xmx:kuW8X17VCsycCXs_BO7ELJXMHCdATNA3O0ofIBAztIS_miaNQIcrfA>
Received: from vm-mail.pks.im (dynamic-089-014-054-008.89.14.pool.telefonica.de [89.14.54.8])
        by mail.messagingengine.com (Postfix) with ESMTPA id 057663280063;
        Tue, 24 Nov 2020 05:50:56 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fe40eb9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 24 Nov 2020 10:50:56 +0000 (UTC)
Date:   Tue, 24 Nov 2020 11:50:55 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v2 2/2] config: allow specifying config entries via envvar
 pairs
Message-ID: <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WNgu9BNCTBa///xX"
Content-Disposition: inline
In-Reply-To: <cover.1606214397.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WNgu9BNCTBa///xX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While we currently have the `GIT_CONFIG_PARAMETERS` environment variable
which can be used to pass runtime configuration data to git processes,
it's an internal implementation detail and not supposed to be used by
end users.

Next to being for internal use only, this way of passing config entries
has a major downside: the config keys need to be parsed as they contain
both key and value in a single variable. As such, it is left to the user
to escape any potentially harmful characters in the value, which is
quite hard to do if values are controlled by a third party.

This commit thus adds a new way of adding config entries via the
environment which gets rid of this shortcoming. If the user passes the
`GIT_CONFIG_COUNT=3D$n` environment variable, Git will parse environment
variable pairs `GIT_CONFIG_KEY_$i` and `GIT_CONFIG_VALUE_$i` for each
`i` in `[0,n)`.

While the same can be achieved with `git -c <name>=3D<value>`, one may
wish to not do so for potentially sensitive information. E.g. if one
wants to set `http.extraHeader` to contain an authentication token,
doing so via `-c` would trivially leak those credentials via e.g. ps(1),
which typically also shows command arguments.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |   9 +++
 cache.h                      |   1 +
 config.c                     |  72 +++++++++++++++++++-----
 environment.c                |   1 +
 t/t1300-config.sh            | 105 ++++++++++++++++++++++++++++++++++-
 5 files changed, 173 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7573160f21..84ae9b51a3 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -335,6 +335,15 @@ GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
 	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
=20
+GIT_CONFIG_COUNT,GIT_CONFIG_KEY_<n>,GIT_CONFIG_VALUE_<n>::
+	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
+	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
+	added to the process's runtime configuration. The config pairs are
+	zero-indexed. Any missing key or value is treated as an error. An empty
+	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=3D0, namely no
+	pairs are processed. Config entries set this way have command scope,
+	but will be overridden by any explicit options passed via `git -c`.
+
 See also <<FILES>>.
=20
=20
diff --git a/cache.h b/cache.h
index c0072d43b1..8a36146337 100644
--- a/cache.h
+++ b/cache.h
@@ -472,6 +472,7 @@ static inline enum object_type object_type(unsigned int=
 mode)
 #define TEMPLATE_DIR_ENVIRONMENT "GIT_TEMPLATE_DIR"
 #define CONFIG_ENVIRONMENT "GIT_CONFIG"
 #define CONFIG_DATA_ENVIRONMENT "GIT_CONFIG_PARAMETERS"
+#define CONFIG_COUNT_ENVIRONMENT "GIT_CONFIG_COUNT"
 #define EXEC_PATH_ENVIRONMENT "GIT_EXEC_PATH"
 #define CEILING_DIRECTORIES_ENVIRONMENT "GIT_CEILING_DIRECTORIES"
 #define NO_REPLACE_OBJECTS_ENVIRONMENT "GIT_NO_REPLACE_OBJECTS"
diff --git a/config.c b/config.c
index 3281b1374e..5da1ae16c9 100644
--- a/config.c
+++ b/config.c
@@ -484,38 +484,82 @@ int git_config_parse_parameter(const char *text,
=20
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
-	const char *env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	const char *env;
+	struct strbuf envvar =3D STRBUF_INIT;
 	int ret =3D 0;
-	char *envw;
+	char *envw =3D NULL;
 	const char **argv =3D NULL;
-	int nr =3D 0, alloc =3D 0;
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
+	env =3D getenv(CONFIG_COUNT_ENVIRONMENT);
+	if (env) {
+		unsigned long count;
+		char *endp;
=20
-	if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
-		ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
-		goto out;
+		count =3D strtoul(env, &endp, 10);
+		if (*endp) {
+			ret =3D error(_("bogus count in %s"), CONFIG_COUNT_ENVIRONMENT);
+			goto out;
+		}
+		if (count > INT_MAX) {
+			ret =3D error(_("too many entries in %s"), CONFIG_COUNT_ENVIRONMENT);
+			goto out;
+		}
+
+		for (i =3D 0; i < count; i++) {
+			const char *key, *value;
+
+			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
+			key =3D getenv(envvar.buf);
+			if (!key) {
+				ret =3D error(_("missing config key %s"), envvar.buf);
+				goto out;
+			}
+			strbuf_reset(&envvar);
+
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			value =3D getenv(envvar.buf);
+			if (!value) {
+				ret =3D error(_("missing config value %s"), envvar.buf);
+				goto out;
+			}
+			strbuf_reset(&envvar);
+
+			if (config_parse_pair(key, value, fn, data) < 0) {
+				ret =3D -1;
+				goto out;
+			}
+		}
 	}
=20
-	for (i =3D 0; i < nr; i++) {
-		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
-			ret =3D -1;
+	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	if (env) {
+		int nr =3D 0, alloc =3D 0;
+
+		/* sq_dequote will write over it */
+		envw =3D xstrdup(env);
+
+		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
+			ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
 			goto out;
 		}
+
+		for (i =3D 0; i < nr; i++) {
+			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
+				ret =3D -1;
+				goto out;
+			}
+		}
 	}
=20
 out:
+	strbuf_release(&envvar);
 	free(argv);
 	free(envw);
 	cf =3D source.prev;
diff --git a/environment.c b/environment.c
index bb518c61cd..e94eca92f3 100644
--- a/environment.c
+++ b/environment.c
@@ -116,6 +116,7 @@ const char * const local_repo_env[] =3D {
 	ALTERNATE_DB_ENVIRONMENT,
 	CONFIG_ENVIRONMENT,
 	CONFIG_DATA_ENVIRONMENT,
+	CONFIG_COUNT_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 825d9a184f..8c90cca79d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1316,6 +1316,107 @@ test_expect_success 'detect bogus GIT_CONFIG_PARAME=
TERS' '
 		git config --get-regexp "env.*"
 '
=20
+test_expect_success 'git config handles environment config pairs' '
+	GIT_CONFIG_COUNT=3D2 \
+		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"foo" \
+		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"bar" \
+		git config --get-regexp "pair.*" >actual &&
+	cat >expect <<-EOF &&
+	pair.one foo
+	pair.two bar
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git config ignores pairs without count' '
+	test_must_fail env GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"va=
lue" \
+		git config pair.one 2>error &&
+	test_must_be_empty error
+'
+
+test_expect_success 'git config ignores pairs with zero count' '
+	test_must_fail env \
+		GIT_CONFIG_COUNT=3D0 \
+		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value" \
+		git config pair.one
+'
+
+test_expect_success 'git config ignores pairs exceeding count' '
+	GIT_CONFIG_COUNT=3D1 \
+		GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"value" \
+		GIT_CONFIG_KEY_1=3D"pair.two" GIT_CONFIG_VALUE_1=3D"value" \
+		git config --get-regexp "pair.*" >actual &&
+	cat >expect <<-EOF &&
+	pair.one value
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git config ignores pairs with zero count' '
+	test_must_fail env \
+		GIT_CONFIG_COUNT=3D0 GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D=
"value" \
+		git config pair.one >error &&
+	test_must_be_empty error
+'
+
+test_expect_success 'git config ignores pairs with empty count' '
+	test_must_fail env \
+		GIT_CONFIG_COUNT=3D GIT_CONFIG_KEY_0=3D"pair.one" GIT_CONFIG_VALUE_0=3D"=
value" \
+		git config pair.one >error &&
+	test_must_be_empty error
+'
+
+test_expect_success 'git config fails with invalid count' '
+	test_must_fail env GIT_CONFIG_COUNT=3D10a git config --list 2>error &&
+	test_i18ngrep "bogus count" error &&
+	test_must_fail env GIT_CONFIG_COUNT=3D9999999999999999 git config --list =
2>error &&
+	test_i18ngrep "too many entries" error
+'
+
+test_expect_success 'git config fails with missing config key' '
+	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_VALUE_0=3D"value" \
+		git config --list 2>error &&
+	test_i18ngrep "missing config key" error
+'
+
+test_expect_success 'git config fails with missing config value' '
+	test_must_fail env GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3D"pair.one" \
+		git config --list 2>error &&
+	test_i18ngrep "missing config value" error
+'
+
+test_expect_success 'git config fails with invalid config pair key' '
+	test_must_fail env GIT_CONFIG_COUNT=3D1 \
+		GIT_CONFIG_KEY_0=3D GIT_CONFIG_VALUE_0=3Dvalue \
+		git config --list &&
+	test_must_fail env GIT_CONFIG_COUNT=3D1 \
+		GIT_CONFIG_KEY_0=3Dmissing-section GIT_CONFIG_VALUE_0=3Dvalue \
+		git config --list
+'
+
+test_expect_success 'environment overrides config file' '
+	test_when_finished "rm -f .git/config" &&
+	cat >.git/config <<-EOF &&
+	[pair]
+	one =3D value
+	EOF
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dove=
rride \
+		git config pair.one >actual &&
+	cat >expect <<-EOF &&
+	override
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'command line overrides environment config' '
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
+		git -c pair.one=3Doverride config pair.one >actual &&
+	cat >expect <<-EOF &&
+	override
+	EOF
+	test_cmp expect actual
+'
+
 test_expect_success 'git config --edit works' '
 	git config -f tmp test.value no &&
 	echo test.value=3Dyes >expect &&
@@ -1661,9 +1762,11 @@ test_expect_success '--show-origin with --list' '
 	file:.git/config	user.override=3Dlocal
 	file:.git/config	include.path=3D../include/relative.include
 	file:.git/../include/relative.include	user.relative=3Dinclude
+	command line:	user.environ=3Dtrue
 	command line:	user.cmdline=3Dtrue
 	EOF
-	git -c user.cmdline=3Dtrue config --list --show-origin >output &&
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Duser.environ GIT_CONFIG_VALUE_0=
=3Dtrue\
+		git -c user.cmdline=3Dtrue config --list --show-origin >output &&
 	test_cmp expect output
 '
=20
--=20
2.29.2


--WNgu9BNCTBa///xX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+85Y4ACgkQVbJhu7ck
PpS8ORAApftw1FjJTPESxmKP73/CQGFLG23V+GOP4eK/+Nn9MojDHJk67r8MOwEj
aKTBiwh/rxYqA3IYXfM+vQlKRpwiyMPVVTb9aBes7iZiT0I1XSNLooJYeGRtuKZT
KtFowmlZcZUY6XJ62YL3K852Gb++558Zm8jBLFczr+vHi/3dtmMKXhygbUpnizgT
x//LxJ+JqJwfkX7oDuwi723zATt2roPiDJvMEZPjh+hoANYK7VpH+GMs/0dpUpRB
vQ0hkXCEBBZV98dI2b7ZeYjeqH/mj5qE/j6WsEiplPGrt8Wrn+z1C7t3OXfcIlQJ
nNAD+PoYQIDANyghwRUzdE3SeWBITyUnlZZ8itI48XbIfS3vh/g1hEdJC3rsPdTK
u2kmGjhytTEgoUChbAQZfRjQcpXguqFRdbGqffrXOYyMQ46AN3Ur/0as3DwtH+iK
NCIUB+AxnOv786UTAcNqmyDS4gn0CIAaONZOgHR3gYxXay76dHU8tubisoOnPzQk
c7okYdXiiYtMw2OiOEMcqI1LUm2kJpYAOfMSHOOcLoyAKmpE5gaV9S0DMtxG3lmF
/nAiZxHsqI0bnLw+p7AByxo2GuGGip7081zOzbcfGA2ce1uyFEoj2pGabCqIwyab
h3004MN6zBsJAHU1AvTz9ssOfMLnrakwNkpz6r/Ntz89hQxNzU4=
=v/l3
-----END PGP SIGNATURE-----

--WNgu9BNCTBa///xX--
