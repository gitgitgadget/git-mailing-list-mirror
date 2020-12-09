Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD1DC4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 675A9221FA
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:54:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731086AbgLILy3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:54:29 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59365 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730999AbgLILy3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:54:29 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C81F8BC0;
        Wed,  9 Dec 2020 06:52:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mhEufTolWJxfbTq6pXoFv+MnxU/
        bRcbzA4WCQACz3e4=; b=PZeT/eU3Eg0lKhrB3CSg70Z+YHqoai2sQ2ET56CI94c
        uHUk2rwjdUNTlz9ZXwQXPhPZRQ8MaPyC32B8ntDHhWAWAVck5f1tRckHQmAuZgJj
        ghWUKF6BGa1fi9fkTheDNnp0RWQB8Pdfcu/Q1EQ6xOFRprqX85PAw6vsW/sxt/JZ
        4TUgG9Iz2N8TUfF1YrpH/s9AABEQfnfaegFhERlXL9dfmK7ClMbLAzyb34MZpFUJ
        BEtExxJiuV2KUzmD+aGK3i/GnKsEEEz9oR+3qtDKHRKBDuCoR9x+l2dfzr90V+Up
        PegZ7SWP0NCMbqYrJNZCzJpkspB9zDj+17vMrXgERnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mhEufT
        olWJxfbTq6pXoFv+MnxU/bRcbzA4WCQACz3e4=; b=P0mlMhpbqfRKTrdz4cAF4k
        +A6vE9MaCBdF+1oRnFKRoCvm3I+CE6d8fJimprqh0hrz5UtGpSoycxg7bcxRsaJn
        TGkSLnwceirkUxEjtTPLMap+mtvq6GQSTjM1RXzDptDmx8foA/8sZUkWshW2ato1
        1qEwF0CjzVVF47YzQDM+OtG88kZFQ3ytWWUFo0uMcfD83Ryq9uMoHDZiMY9b1fE9
        l5AyKBZhl+Jc+O4jw8ktnwb6yYChzB0VPp3ozJEkUGuuWcXcMcYisGw/xfh+Y12T
        6qlJN5reNPnUP2Rt0S0QNiX+fidFgUO5CcZP96Zjr8GUxQxoFBD4Z+g/Y0LJIj6Q
        ==
X-ME-Sender: <xms:jrrQX41-uSNtgzsujXFixikiDxAAJdgQOnLm_muDkin3ifiXeLQTgw>
    <xme:jrrQXzGsnxVJrrWiC0We6WdE9c5hG8x8J_Bw2GkFftDkhtfvBNsAIA_WqoSdfD5H7
    Op7ClwZjs5MdALE4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgepieenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jrrQXw6vPNwhdQxXG8dtuFFJRXNA-sJXzmHLeLQSWP5Fg6GWRJcWyQ>
    <xmx:jrrQXx2J6BTZz8aQn6IYVAeYMSvrno15kyU0d94Y6pY9iLOTTyG2EQ>
    <xmx:jrrQX7EzMptfP_OK9G7Onqz6arvd0zd2LMwb3sH2UiJw4y1fiuQryQ>
    <xmx:jrrQXzBRlDj4iEba4I8BMMmQxmj9a1e7Jiq_SSlvWAet1lvwc6HoQw>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8116E1080068;
        Wed,  9 Dec 2020 06:52:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 6a3182c0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:44 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 6/6] config: allow specifying config entries via envvar
 pairs
Message-ID: <659e20697fa29d996f54015852b3314c37d432e5.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Mm5Mlosc+LbJfBSm"
Content-Disposition: inline
In-Reply-To: <cover.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Mm5Mlosc+LbJfBSm
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
 Documentation/git-config.txt |  12 ++++
 cache.h                      |   1 +
 config.c                     |  46 ++++++++++++++
 environment.c                |   1 +
 t/t1300-config.sh            | 115 ++++++++++++++++++++++++++++++++++-
 5 files changed, 174 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 0e9351d3cb..54c994aea1 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -346,6 +346,18 @@ GIT_CONFIG_NOSYSTEM::
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
+
=20
 [[EXAMPLES]]
 EXAMPLES
diff --git a/cache.h b/cache.h
index 8d279bc110..294841fca7 100644
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
index 8162f3cec8..779487bc2d 100644
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
@@ -506,6 +507,8 @@ int git_config_parse_parameter(const char *text,
 int git_config_from_parameters(config_fn_t fn, void *data)
 {
 	const char *env;
+	struct strbuf envvar =3D STRBUF_INIT;
+	struct strvec to_free =3D STRVEC_INIT;
 	int ret =3D 0;
 	char *envw =3D NULL;
 	const char **argv =3D NULL;
@@ -517,6 +520,47 @@ int git_config_from_parameters(config_fn_t fn, void *d=
ata)
 	source.origin_type =3D CONFIG_ORIGIN_CMDLINE;
 	cf =3D &source;
=20
+	env =3D getenv(CONFIG_COUNT_ENVIRONMENT);
+	if (env) {
+		unsigned long count;
+		char *endp;
+
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
 	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
 	if (env) {
 		int nr =3D 0, alloc =3D 0;
@@ -538,6 +582,8 @@ int git_config_from_parameters(config_fn_t fn, void *da=
ta)
 	}
=20
 out:
+	strbuf_release(&envvar);
+	strvec_clear(&to_free);
 	free(argv);
 	free(envw);
 	cf =3D source.prev;
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
index 46a94814d5..f157cd217e 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1361,6 +1361,117 @@ test_expect_success 'git -c and --config-env overri=
de each other' '
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
@@ -1706,9 +1817,11 @@ test_expect_success '--show-origin with --list' '
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


--Mm5Mlosc+LbJfBSm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/QuooACgkQVbJhu7ck
PpSgeg/9GxSQWmmDJUyc3xed+JZYzpVxneSMq3OucMZILW8GVO8742HbYm9WvWLg
vR5SFXd2tvcl3HsLyyMs+uomaxaubyS2J4NVNJYUl01R4raPstDjiLX8wdzMBwQn
qg0uD3dU5pJZYlqOqvS33LVh3pteSV+db00oyIsOxRoCRsd7yo+68QbvKxwesYuc
EHRolNeZ0O/hciqzrcm8TXyTIgCV4LUn7V1IsI3OoHJgfi1Wkad4l1ikmvf2w9UX
TeaUGkNQ+eZbtylgXAv28twAY1P6kWBtzu2/W6QqXMG8hK9YpR0YzEoLsaTXcK5y
AFlLxXKP4QvN7DVLaWB8tcGJjc9ULql/hDXPkgJRqckrOwYGADoL326Fmc7+bVpS
GGz6Ri8JXfq3xOcgaJv3PxKo1jd4CVruoA6AsJBAMe9YxRppfE9Am+vq6bYwpfpq
TSA9rG/vFtYiYb6osAJExNzAJ3XdpBIW9X19E7oKeIOPfMwaR8+fODPE1Ywzy7bF
AMErNaNd1BznWi/XA0H/gYHopVyrtCpo3D02RFLnVnsjhkZVtJLLjf78hxNN+Qrv
HJSyBsfrVINfmzCJGjrDVf0oUZrh89Ko5mGjKINM06VOxg20yN2MDLEianLnSMQ8
YRCeEfpLYT9kB1Zy4tYsiNi8yOP/bkuRFzBKn3cAn3V3it23a5Q=
=G7pl
-----END PGP SIGNATURE-----

--Mm5Mlosc+LbJfBSm--
