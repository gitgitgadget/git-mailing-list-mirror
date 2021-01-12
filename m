Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA967C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92F6F22BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbhALM23 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:29 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36049 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbhALM23 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 03A0C1B62;
        Tue, 12 Jan 2021 07:27:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Z8V2pd0MfmHsfdRmYE95phtHm0D
        82L12wUS+8PuZVq4=; b=vERlydDFIql0WKdsCwVfV3a2DRG4KIKegQ8RYBbWYlm
        DyTNmPLHQMc/orMNOl4eJ4gDZKSIHLJXbYYtVJ0xYXJF0rT1RZSU7ahnICBaZdlP
        wmL4gto22i6TBPa+bjAeDdDHrPiEEhBwC1MO1k3KB1Y03GtbJdbVbVhc9xL9sM77
        oamh2sRyTxIw3HelgbXRE017yQeRP/lLNjkDINJT8PfGNijodhqe6SXiapisbuT9
        kaXhiZA4/NorPEdtsmH/l3M/zDFfM//MV/K/ENC6pAdzOOpa0t3DWR6a+343QFtg
        0D4ibIu5SPNMy59phGTtp9oJHkJMQcyWf4lp3JgpERA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z8V2pd
        0MfmHsfdRmYE95phtHm0D82L12wUS+8PuZVq4=; b=iwVCGZwHEtkxfFKCvdQjeo
        KZV1MCEAPRxtEFSu9UspeGxzhhHaoV+YWfq4DuTB9gP/8vIqr6KumE4rr7B9vsJK
        cii4QX77tIGsQetsXVmUr3qoePdzBDjkypCSI8B9/zZo/mUjjx4V+/buYeY4y+cq
        3jogXGoqPxBljalNiRl4z4OzksptMQNJBOCCMpp9bI8ikCXLdmWQy7N+DuL9ufZd
        IZVD7dL3u8miQzWA0NehF4pLEQg/+Dj3w/JgngBpc8Rgk+RRlw2OHNXBXFMATwU2
        4QSGuXRM7rskkIZd4U7/WRUChEtEkXdgdcS7vPpBbdl0CLN2A9sdiQzh7dH7FXeA
        ==
X-ME-Sender: <xms:pZX9X3KyH8jJQTiUBXlTMFNLLluGs_0yKLISQ7lH6AWgiSgIKv9WVA>
    <xme:pZX9X7KC31RnMFALzXXGk-vMbtn55Z9G_nHjfywXBMoeUB9piKhJ3-kW8p_wMDXvY
    rsDv6WTfnUmxT4BPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:pZX9X_vpDsLowUOBp3HZ5wsQNiroz-RUEDYrdXhsXIYeL1eQhin-rQ>
    <xmx:pZX9XwaO2KgOIKVHJgC63jLeLlJkIjSPbrg37MVhsdO3i6ZuEuuJLQ>
    <xmx:pZX9X-agmdHEks1PuiBKUoutqO_NMBqZwj73RTUkGlGEWQx71FKPVg>
    <xmx:pZX9X1Uo4TFQ-tDhyt5Z_awgA6WSfkNQfgIMnB-Rl_2UIpOcaK3Ykg>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8EDC11080057;
        Tue, 12 Jan 2021 07:27:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c7e4c098 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:16 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 8/8] config: allow specifying config entries via envvar
 pairs
Message-ID: <07697b0c21db06c9a88cc54cf671db48aa8a2f8f.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+nCt4ZYu+LRgSL8"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--k+nCt4ZYu+LRgSL8
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
index 99062915d7..a32569438a 100644
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
@@ -598,23 +599,73 @@ static int parse_config_env_list(char *env, config_fn=
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
index 3f6778d474..89b47bf5bd 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1424,6 +1424,117 @@ test_expect_success '--config-env handles keys with=
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
@@ -1769,9 +1880,11 @@ test_expect_success '--show-origin with --list' '
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


--k+nCt4ZYu+LRgSL8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9laIACgkQVbJhu7ck
PpSWjQ//Xx56wROY2XCRz9dxH9OP/ijAduo8VEmyLADCLuSVkJR27KF44IXzsdnz
faK10pMyP7dq+osHRVGEJ3D0XsURa45fJYd9wkuxJYaDpzdqTR+qhJjIJ1xF8zt9
Zd6kz9hcTbNULLHrcw+5y3nRshac+y2L1y+eFiEVo2OVaCPwStr72zZBtTJmPLg8
Vq3UQsYXEK1BBUdG0YgnqEnScxBEhs4s9jtPEsYyyu2XIFvSSRosaOqXfQbh0u0k
nrCZ0RJjbi0JZYVOHl7mWRC5a7ZcU00zabXUbIzsSHvXmYg6Qa3VRslFTly5SnMj
lHm/DJCYUryakxv9L7Zoh26C2J4hJh3/T+JNRum1Vs/1Wax/ahgh055MxahJFwgD
37UCJ3nsjzDWzZbyxHeBZz5Up8cBih5ahGDwmg+TSZ14N2z0dsIhitlOWitdYTdo
DNRtvQICn6k8fRLaYyl7u0OFcvYRBTaVQ8x4v+F5L+HBc+vgPqIMnxNZCs6jfAVB
W+p+PS9Vy6Geki1XDs66qrpEpw5zwg4/vIXVgr9FENx1GbTy+lUyAxLUvrFKDSKK
eULuy2VI2/gCWPeQPJt7TVhAG8+v1+tp32mbWXFEdy8ElYMX1uRoQFFu/kW2+05J
/IKNml5Xp9Iylha3OduWlXSMHPPu95kx2hNEFhyQUhm0WE+kAr8=
=vRsz
-----END PGP SIGNATURE-----

--k+nCt4ZYu+LRgSL8--
