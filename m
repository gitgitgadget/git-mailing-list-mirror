Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B752C4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12BD423357
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLPHzi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:55:38 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:47259 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726095AbgLPHzi (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:55:38 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 82F2E5C019F;
        Wed, 16 Dec 2020 02:54:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 16 Dec 2020 02:54:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mjDMbyK9y+QDamh72Yv9WL633s+
        MrLsdaYcmbqK1qbw=; b=vbDW1hq1htnNWq4anV8PncKvMyBFybglCI3Y7OYc10D
        FkMrXBDR3Pf+JyEBWe8Iy3kjRkj19MFEfnhXM7WWBVvvXDlv9cUknf1mnJvSWZj3
        DvNix+ZBOcWj06LD5336SXUIm1O//69d6Bcgc0MS0DnLofdOFNLKS63RZCtF6Aaq
        KDccQqk//URVI/IiGx4+v1uHO0SKE4iPyLHOjNWeVu/m3u1ZMgOOejiCNlSOLoIL
        NCbKpjXZjNHUhFc9zxPuZb+m5bTAobB17v2C7rc+UjtYhWPezbX92bS0jEYvRVF9
        70vK56bp85O18bgTALNtwRUd0dWOKesT3FpV3AEsdhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=mjDMby
        K9y+QDamh72Yv9WL633s+MrLsdaYcmbqK1qbw=; b=pVckOGDCOxroPdY84zF3v7
        xdNUDHjNMXvgpPdhx2ksKi9RotYbVk+qV2KmriykcLW4g/mL2eqPHB+xChz7uxbR
        qqbY/AlQBQqQQoH7i5YaVhI0iFnRzU2GkAIfu30d5Eg3Lv+eVJ1W9vZw737Br5ol
        ECDWJMwDeYTD1ULFE2RtWD8bX6dxE1yEAoKbyE7nH2zOr74lIBFBLNyHd4HOabfd
        oZezY3ZYrGdAmQOaTDO3So5ulovZ8mP7r126CKl9M1MI4dNG4B2+I+mvrgBWH4hv
        uwjHIPVX5GfutrKC4JJjfuUApHZhGqTohBd0rnrBjN724G49j3dtSCng+Utmqkdw
        ==
X-ME-Sender: <xms:S73ZX2KuxG8eGQDDCzGgyXhcUP1M1yB4FdZZbmLP2MjV9W7-ge3a5A>
    <xme:S73ZX-HMN3JcXWuyVagz4UZQneeHJ1KPpZDHWhPfAzZCGhg5tHLtMzmwUEdzT2Zj8
    C69fhxtxL44xqrpew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:S73ZXzlXZWJhyrAC_OE2sf8cKDbT9jI0YOwTS8GSGc3r8IeXPCNMbw>
    <xmx:S73ZXzJGuon0LJRE5BK_wMnZmAnVnvUTPc8lTBTbmeCvsaqhsUP9Xw>
    <xmx:S73ZX8bYdyDG-cPx89D0PNaahco13iksyjJ14NL89gY3wRxPDW4o_Q>
    <xmx:S73ZX0W7bcc_uXgNZxeOOoBzgGNJY8El1TTRJjfR7MlO9qj8M9e-Vw>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id A52C0108005C;
        Wed, 16 Dec 2020 02:54:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id efaf7c28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:54:49 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:54:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 8/8] config: allow specifying config entries via envvar
 pairs
Message-ID: <dfceffd8d4fbc3c99cfa7c5d838e4c3a2db6598a.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yn00K8WqDX9iH1TB"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yn00K8WqDX9iH1TB
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
index 0e9351d3cb..72ccea4419 100644
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
+
+	This is useful for cases where you want to spawn multiple git commands
+	with a common configuration but cannot depend on a configuration file,
+	for example when writing scripts.
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
index 60a7261807..1742aefa3e 100644
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
@@ -594,23 +595,73 @@ static int parse_config_env_list(char *env, config_fn=
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
index 35a1a6e8b1..e06961767f 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1421,6 +1421,117 @@ test_expect_success '--config-env handles keys with=
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
@@ -1766,9 +1877,11 @@ test_expect_success '--show-origin with --list' '
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


--yn00K8WqDX9iH1TB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvUcACgkQVbJhu7ck
PpRLow//c9r2hV7DRNW+wcPOAnI8arBJbzU67MaIhEJIYxkGnVN18KGI+QdDr2qL
ZHPE3IYtOch/pPxOoi/I+iHYunolBOBBzY3gHyX3wdGTKE2trpGO3opIN+6PGoDb
UnofDbXQ+ShHvOvwn+yH03a/1T35lfR1yB5FllS5O2vH3iUNQdBSgTTWwLEUGsL1
G3V0Fr/TDmwT4EYgToooVMGfNkiWXt6U6sH6XDUEBBsjQsxWxn+zTDP5wcoLpBlh
2v/dOzLJMwYZJMgQvsnGkYAVJcYnpNG8EvOezi/ARwhKLlhoT4l1QPknw135uD0q
Q/eZcChAdXViFY4jeQd92D4Ic0/lFAY8hZmN4ZbE6KzdwE0W51MbTI9UqtQ+YqfY
XdiVya2ws56xxkNbEFSsn3q+TEJ2wjMxQYpdu0PGBTDeG14eZf9dRL8uSfUhmGVf
Tl3dORJddJCNZNuX1XmQ19TntFIWVfR11QUnZaLw9WO6N7qanY3d61ZhBPWdBZcP
/91kmZdyYEdx7E3/HIqKCrFd1RRSYfi4yWbmUklrA6wJocKA6qjBZqTRKRv/Aw9T
IPFeXovDR82JhwFCe5Vq9JZUvcq72CGo5aljkPlklcpb+4zth4oaMBnVQg5ATGgu
Kkx6W2Fh8SaJG0CzfuL+umWYzz4QUa8NiPfAXbVBEuk+SL73j4M=
=5q9y
-----END PGP SIGNATURE-----

--yn00K8WqDX9iH1TB--
