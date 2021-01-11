Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16AAC433E6
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A8622527
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbhAKIiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:38:52 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54049 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727899AbhAKIiv (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:38:51 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 0FE5024FD;
        Mon, 11 Jan 2021 03:37:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 11 Jan 2021 03:37:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=E4haySKwgRYiuhiLpNBNZVuc2uF
        yomZjBxhpoNURHeg=; b=xdDsbRdLh+lMjh7dj4j7soV/Fhyp19chF4p1vfXOIBI
        oSfFS59yFom13YK4sDtMBYb53v6H2vzdLm4BFWiei9YbehzOGko0RmOgZ4VIQ7z0
        aHe2UGlAw6GoNJH8EAtSCavC8NUDfUbdBkIyaCMeDAtRSyvQQs278xClVHZD0aUP
        CcDnUHt4ap/8/z7Qwv06g2DOzuaSdCVz1qtijWDw3zIuANx0AQwF/IowMHKeeGTY
        9+2F9A/5xhmqS/APLucOSRSyiWBWy5PlmWk8h/KiP2cZ8bs50PMz15jRX+3cp19f
        28d+JO9vWVls4K5IAk/HKtML8H/ahzVqGiPy7veehIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=E4hayS
        KwgRYiuhiLpNBNZVuc2uFyomZjBxhpoNURHeg=; b=paxm1cHnpyo7RsmLuW3/Cf
        CY6ey+QoXvkaHFLzFXBMrj9ybwosRjx4uz51mFWCaD7P7eOqOqYmTLSJ1/kOhiFo
        Ns5HIZZwlUzDNuHasvXbtwd09/GsW7EIBhBnSMcZg9xobNFAvmIDwsHEjDZH0kVr
        mnj+VN07sfIaKouUnC6fVwJ2XOAvsm5SQ+Y+tZ4mkjkN1jWv2d92XjCGni76P6Kg
        u9rorjT0d6WWz8safGjhuhNIEQ9Ogj2YYfuzYFFXY85ca7ckhMpaUPU/hvFM7m8a
        ktXGSZ42svTxEMr1B7XXMFCFrYPnxf96WdYQfAu0ihH5uoDhSH9LnOkctxA+4/iA
        ==
X-ME-Sender: <xms:Pg78X4-dkudOF8KkNetwnre-oMeMH4phx1oraGmiXgqZL5Qq2cK39A>
    <xme:Pg78XwoRRf2r9UUMkBv7jTX2niOnqDzybeUizjn0GsX5iNNpi9N2JL-t1S6InpOSJ
    4atkvOOSeZtzzBsZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Pg78X64yFObj6DlV5g9kNf5DSbVISx7UWImGpnhan70PeKB07u4cfQ>
    <xmx:Pg78XwPVNHpsg66KJr8BRtUeRAopGkby8MNIZxz4YSCjzt8WG6mosw>
    <xmx:Pg78X8NtoodXnljFSGrdAB0TEXerhhAZ4pQ1a1xwJBE_pwM7DapSRw>
    <xmx:Pw78X1xHVUSFSjiVFGT5vUqcffhCg8SPQvVxerkCD8x3x357Gjk9QQ>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0062F240067;
        Mon, 11 Jan 2021 03:37:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fcdaf6ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:37:17 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:37:16 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 8/8] config: allow specifying config entries via envvar
 pairs
Message-ID: <ac9e7787049d673c3227437660140f0f6de7e1cf.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SGz8lTK+5sb74Whq"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--SGz8lTK+5sb74Whq
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
 Documentation/git-config.txt |  16 +++++
 cache.h                      |   1 +
 config.c                     |  67 +++++++++++++++++---
 environment.c                |   1 +
 t/t1300-config.sh            | 115 ++++++++++++++++++++++++++++++++++-
 5 files changed, 191 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 0e9351d3cb..4b4cc5c5e8 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -346,6 +346,22 @@ GIT_CONFIG_NOSYSTEM::
=20
 See also <<FILES>>.
=20
+GIT_CONFIG_COUNT::
+GIT_CONFIG_KEY_<n>::
+GIT_CONFIG_VALUE_<n>::
+	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
+	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
+	added to the process's runtime configuration. The config pairs are
+	zero-indexed. Any missing key or value is treated as an error. An empty
+	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=3D0, namely no
+	pairs are processed. These environment variables will override values
+	in configuration files, but will be overridden by any explicit options
+	passed via `git -c`.
++
+This is useful for cases where you want to spawn multiple git commands
+with a common configuration but cannot depend on a configuration file,
+for example when writing scripts.
+
=20
 [[EXAMPLES]]
 EXAMPLES
diff --git a/cache.h b/cache.h
index 7109765748..a2e318c62b 100644
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
index 33099a3b0d..2627a05e91 100644
--- a/config.c
+++ b/config.c
@@ -8,6 +8,7 @@
 #include "cache.h"
 #include "branch.h"
 #include "config.h"
+#include "environment.h"
 #include "repository.h"
 #include "lockfile.h"
 #include "exec-cmd.h"
@@ -597,23 +598,73 @@ static int parse_config_env_list(char *env, config_fn=
_t fn, void *data)
=20
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
-	const char *env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	const char *env;
+	struct strbuf envvar =3D STRBUF_INIT;
+	struct strvec to_free =3D STRVEC_INIT;
 	int ret =3D 0;
-	char *envw;
+	char *envw =3D NULL;
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
-	ret =3D parse_config_env_list(envw, fn, data);
+	env =3D getenv(CONFIG_COUNT_ENVIRONMENT);
+	if (env) {
+		unsigned long count;
+		char *endp;
+		int i;
=20
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
+			key =3D getenv_safe(&to_free, envvar.buf);
+			if (!key) {
+				ret =3D error(_("missing config key %s"), envvar.buf);
+				goto out;
+			}
+			strbuf_reset(&envvar);
+
+			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
+			value =3D getenv_safe(&to_free, envvar.buf);
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
+	}
+
+	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
+	if (env) {
+		/* sq_dequote will write over it */
+		envw =3D xstrdup(env);
+		if (parse_config_env_list(envw, fn, data) < 0) {
+			ret =3D -1;
+			goto out;
+		}
+	}
+
+out:
+	strbuf_release(&envvar);
+	strvec_clear(&to_free);
 	free(envw);
 	cf =3D source.prev;
 	return ret;
diff --git a/environment.c b/environment.c
index 2234af462c..2f27008424 100644
--- a/environment.c
+++ b/environment.c
@@ -117,6 +117,7 @@ const char * const local_repo_env[] =3D {
 	ALTERNATE_DB_ENVIRONMENT,
 	CONFIG_ENVIRONMENT,
 	CONFIG_DATA_ENVIRONMENT,
+	CONFIG_COUNT_ENVIRONMENT,
 	DB_ENVIRONMENT,
 	GIT_DIR_ENVIRONMENT,
 	GIT_WORK_TREE_ENVIRONMENT,
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 0063e9f059..6ecf2c11a7 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1423,6 +1423,117 @@ test_expect_success '--config-env handles keys with=
 equals' '
 	test_cmp expect actual
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
+test_expect_success 'GIT_CONFIG_PARAMETERS overrides environment config' '
+	GIT_CONFIG_COUNT=3D1 GIT_CONFIG_KEY_0=3Dpair.one GIT_CONFIG_VALUE_0=3Dval=
ue \
+		GIT_CONFIG_PARAMETERS=3D"${SQ}pair.one=3Doverride${SQ}" \
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
@@ -1768,9 +1879,11 @@ test_expect_success '--show-origin with --list' '
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
2.30.0


--SGz8lTK+5sb74Whq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DjsACgkQVbJhu7ck
PpQ06RAAnqYE9/KKClFsOHxwsx/MuR7DbSxl8xTvJbttkDV3b9WW9UiawiR4bz1p
dad2AvDKnyw25BY1FpcpTfTpMGiKWY43Hl5aqxPXgQ+DUDkcbF1RHdFB32l6UZyW
Q8xL2S7Tbv0ch0LPVrYe7Z9lt65Xhdukzqs7OWDIkvQCag13Iep6K7zlK2TL0ryn
D6N6fq0f8+tMqy6wUPL9JOZyLt70NIUlSrasaZ2xGHj0By8Wnw2QFRzTmPeQrBHn
GyGDXpxG0m5AeNgnUYXQr8+XXmij3KXBkKRUb3y95S332GT5XFvC2DKXbQ9XwsNz
8M2gdJ0COq+FpnIcg26cZdUp3vvg32MC2HX/5IC2oRCVD0t6jBHgG6Lxxj89hB6p
wiZXbm2HHWbTdEsIZs97WN0ompyie1G8eKX1+jDVn4eAg0L9rVTgUAZ2QsMl2n6E
gjVxPGPZfb1uATR5U/OSX0yS3PFAr6ckqa43FfAq6vN435xCt4CNl4bEApRTEp9t
cayqs8ARSmaThfDH1+3esGWmUwGZJ66QhrEkBQnTQw3MKZ/nCBJuuLU8bipQil90
wv0UmwAqWXSj2MXuqCmPI1CIHEkK/KXbIVNQqeQ+Zn6mOfeq+FcBJqCT/yrpxHi0
yWeMbydp70IHWerjFBEvmIdCuyf2nVeYuS3sDKZI8vXIODbFzlU=
=6bJ8
-----END PGP SIGNATURE-----

--SGz8lTK+5sb74Whq--
