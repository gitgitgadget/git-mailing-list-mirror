Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACD0C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A7BF61357
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242468AbhDLOrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:47:08 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:50167 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242439AbhDLOrG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 10:47:06 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 2FDEA17C3;
        Mon, 12 Apr 2021 10:46:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 12 Apr 2021 10:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=orRfs6ZY0GBrCvK8oXw4i50w+vl
        o+r4wsvBsDy46g3Y=; b=ULOYMawPt1RWJY3mkePe7zVrUkJyTQ2/mhN5aE9x1wo
        fx4ThqXvVWmcSV0DdK2g0KFut3s/ymUwv6QrpQGVDLGpvc1YKLuI9tvjb0fRTRYu
        rb3FRJa7QEfg4psbA4n1BrSJN58jKdCphVy4EyCwKY/FFllWbBHT4PBnuBorxzQe
        N9NJVg40uBl3ybT6Ux35yXgkEkDxuGylpXt0x2e0Jre3D0mNVNOpWX7S54ArgUjd
        mUCsqhFIusQNj7PXS3DZaMLkBeXsYUAvzStG1HzFyV2ulfo7BD9ph0yCnVXdXejT
        4tmBwrvOYx2KzyVjDfrRZVqlv1D67FbuKs1/1kZ5tGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=orRfs6
        ZY0GBrCvK8oXw4i50w+vlo+r4wsvBsDy46g3Y=; b=ppEb2nnu4DaRcNMoj5aHri
        5I7dCuGm5YaRV7L8XQdj7RiptnkspYnTw9677teLPkMJr4DmKlYv1CJyveWFciaK
        QGlztFl6yXEQf9OpVxCEbNJ6+A1mnRwEaRaNZuQLSMFyg7cAEWVtsIeg4WPeyGdG
        KR1qXGArRLYviN6xJd2UeJ/qwmHsHpkCxQ4AaqjQW8DyZHYT6eeQJ8+H7BA1vLdO
        pWmjQOJpOu+tGS9tuMUv+YQVqG+QLat6ZPpm3sZaofOaJJ6wS3N+Il3EOPXNBhOh
        Mi9qHzJwyKwwmpQYaPADK7Ksu7FJxBddrwUvlBCBwOsrEKYeRGmeymoxPYC/O9JA
        ==
X-ME-Sender: <xms:Vl10YNP3UJMSUYRZhPQ49octip6cAuFr5oPJh5ZP8UiFty8vIGeQfQ>
    <xme:Vl10YNjy6NOSkZuotneZkESiIe9SQXScQHIRRb246emXqATEzE9NSrq4rRfUTBVxY
    5VlvkC96pXELeiasw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Vl10YCvkLEIO6fTyJKSa_OfxdqxDUYz81X8yLOhBTcajX8ZRNdECdg>
    <xmx:Vl10YLScdGtVhhFdz5ks-t0ffZLQbblGACel02RYOu6sh6loq1zqjQ>
    <xmx:Vl10YG3QrWVtbyNGdV8ovylmNI0QmIO3dP-_qtFG9epi6TOJYNIYVw>
    <xmx:V110YB82Srsf_0JjClFeI3KU4kU8eXbSkppYYg0k8FgG7zDTsGsA6Q>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC963240057;
        Mon, 12 Apr 2021 10:46:45 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 246c7496 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 14:46:42 +0000 (UTC)
Date:   Mon, 12 Apr 2021 16:46:41 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3] config: allow overriding of global and system
 configuration
Message-ID: <aa0f2957e6f1baf7bd600ad43d34664af51c9c25.1618238153.git.ps@pks.im>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JaB240hM5gSBZKKo"
Content-Disposition: inline
In-Reply-To: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JaB240hM5gSBZKKo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to have git run in a fully controlled environment without any
misconfiguration, it may be desirable for users or scripts to override
global- and system-level configuration files. We already have a way of
doing this, which is to unset both HOME and XDG_CONFIG_HOME environment
variables and to set `GIT_CONFIG_NOGLOBAL=3Dtrue`. This is quite kludgy,
and unsetting the first two variables likely has an impact on other
executables spawned by such a script.

The obvious way to fix this would be to introduce `GIT_CONFIG_NOGLOBAL`
as an equivalent to `GIT_CONFIG_NOSYSTEM`. But in the past, it has
turned out that this design is inflexible: we cannot test system-level
parsing of the git configuration in our test harness because there is no
way to change its location, so all tests run with `GIT_CONFIG_NOSYSTEM`
set.

Instead of doing the same mistake with `GIT_CONFIG_NOGLOBAL`, introduce
two new variables `GIT_CONFIG_GLOBAL` and `GIT_CONFIG_SYSTEM`:

    - If unset, git continues to use the usual locations.

    - If set to a specific path, we skip reading the normal
      configuration files and instead take the path. This path must
      exist and be readable to ensure that the user didn't typo.

    - If set to `/dev/null`, we do not load either global- or
      system-level configuration at all.

This implements the usecase where we want to execute code in a sanitized
environment without any potential misconfigurations via `/dev/null`, but
is more flexible and allows for more usecases than simply adding
`GIT_CONFIG_NOGLOBAL`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Range-diff against v2:
1:  da0b8ce6f0 < -:  ---------- config: rename `git_etc_config()`
2:  dddc85bcf5 < -:  ---------- config: unify code paths to get global conf=
ig paths
3:  272a3b31aa ! 1:  aa0f2957e6 config: allow overriding of global and syst=
em configuration
    @@ Commit message
         and unsetting the first two variables likely has an impact on other
         executables spawned by such a script.
    =20
    -    The obvious way to fix this would be to introduce `GIT_CONFIG_NOSY=
STEM`
    -    as an equivalent to `GIT_CONFIG_NOGLOBAL`. But in the past, it has
    +    The obvious way to fix this would be to introduce `GIT_CONFIG_NOGL=
OBAL`
    +    as an equivalent to `GIT_CONFIG_NOSYSTEM`. But in the past, it has
         turned out that this design is inflexible: we cannot test system-l=
evel
         parsing of the git configuration in our test harness because there=
 is no
         way to change its location, so all tests run with `GIT_CONFIG_NOSY=
STEM`
    @@ Documentation/git.txt: for further details.
     +`GIT_CONFIG_GLOBAL`::
     +`GIT_CONFIG_SYSTEM`::
     +	Take the configuration from the given files instead from global or
    -+	system-level configuration files. The files must exist and be readab=
le
    -+	by the current user. If `GIT_CONFIG_SYSTEM` is set, `/etc/gitconfig`
    ++	system-level configuration files. If `GIT_CONFIG_SYSTEM` is set, the
    ++	system config file defined at build time (usually `/etc/gitconfig`)
     +	will not be read. Likewise, if `GIT_CONFIG_GLOBAL` is set, neither
     +	`$HOME/.gitconfig` nor `$XDG_CONFIG_HOME/git/config` will be read. C=
an
     +	be set to `/dev/null` to skip reading configuration files of the
    @@ Documentation/git.txt: for further details.
      	Whether to skip reading settings from the system-wide
      	`$(prefix)/etc/gitconfig` file.  This environment variable can
    =20
    + ## builtin/config.c ##
    +@@ builtin/config.c: int cmd_config(int argc, const char **argv, const=
 char *prefix)
    + 		char *user_config, *xdg_config;
    +=20
    + 		git_global_config(&user_config, &xdg_config);
    +-		if (!user_config)
    ++		if (!user_config) {
    ++			if (!strcmp(getenv("GIT_CONFIG_GLOBAL"), "/dev/null"))
    ++				die(_("GIT_CONFIG_GLOBAL=3D/dev/null set"));
    ++
    + 			/*
    + 			 * It is unknown if HOME/.gitconfig exists, so
    + 			 * we do not know if we should write to XDG
    +@@ builtin/config.c: int cmd_config(int argc, const char **argv, const=
 char *prefix)
    + 			 * is set and points at a sane location.
    + 			 */
    + 			die(_("$HOME not set"));
    ++		}
    +=20
    + 		given_config_source.scope =3D CONFIG_SCOPE_GLOBAL;
    +=20
    +
      ## config.c ##
     @@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
    - const char *git_system_config(void)
    +=20
    + char *git_system_config(void)
      {
    - 	static const char *system_wide;
    --	if (!system_wide)
    --		system_wide =3D system_path(ETC_GITCONFIG);
    -+
    -+	if (!system_wide) {
    -+		system_wide =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
    -+		if (system_wide) {
    -+			/*
    -+			 * If GIT_CONFIG_SYSTEM is set, it overrides the
    -+			 * /etc/gitconfig. Furthermore, the file must exist in
    -+			 * order to prevent any typos by the user.
    -+			 */
    -+			if (access(system_wide, R_OK))
    -+				die(_("cannot access '%s'"), system_wide);
    -+		} else {
    -+			system_wide =3D system_path(ETC_GITCONFIG);
    -+		}
    ++	char *system_config =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
    ++	if (system_config) {
    ++		if (!strcmp(system_config, "/dev/null"))
    ++			FREE_AND_NULL(system_config);
    ++		return system_config;
     +	}
    -+
    - 	return system_wide;
    + 	return system_path(ETC_GITCONFIG);
      }
     =20
    -@@ config.c: void git_global_config(const char **user, const char **xd=
g)
    - 	static const char *user_config, *xdg_config;
    +-void git_global_config(char **user_config, char **xdg_config)
    ++void git_global_config(char **user_out, char **xdg_out)
    + {
    +-	*user_config =3D expand_user_path("~/.gitconfig", 0);
    +-	*xdg_config =3D xdg_config_home("config");
    ++	char *user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
    ++	char *xdg_config =3D NULL;
    ++
    ++	if (user_config) {
    ++		if (!strcmp(user_config, "/dev/null"))
    ++			FREE_AND_NULL(user_config);
    ++		xdg_config =3D NULL;
    ++	} else {
    ++		user_config =3D expand_user_path("~/.gitconfig", 0);
    ++		xdg_config =3D xdg_config_home("config");
    ++	}
    ++
    ++	*user_out =3D user_config;
    ++	*xdg_out =3D xdg_config;
    + }
     =20
    - 	if (!user_config) {
    --		user_config =3D expand_user_path("~/.gitconfig", 0);
    --		xdg_config =3D xdg_config_home("config");
    -+		user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
    -+		if (user_config) {
    -+			/*
    -+			 * If GIT_CONFIG_GLOBAL is set, then it overrides both
    -+			 * the ~/.gitconfig and the XDG configuration file.
    -+			 * Furthermore, the file must exist in order to prevent
    -+			 * any typos by the user.
    -+			 */
    -+			if (access(user_config, R_OK))
    -+				die(_("cannot access '%s'"), user_config);
    -+		} else {
    -+			user_config =3D expand_user_path("~/.gitconfig", 0);
    -+			xdg_config =3D xdg_config_home("config");
    -+		}
    - 	}
    -=20
    - 	*user =3D user_config;
    + /*
    =20
      ## t/t1300-config.sh ##
     @@ t/t1300-config.sh: test_expect_success '--show-scope with --show-or=
igin' '
    @@ t/t1300-config.sh: test_expect_success '--show-scope with --show-ori=
gin' '
     +
     +test_expect_success 'override global and system config with missing f=
ile' '
     +	sane_unset GIT_CONFIG_NOSYSTEM &&
    -+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist git version &&
    -+	test_must_fail env GIT_CONFIG_SYSTEM=3Ddoes-not-exist git version &&
    -+	GIT_CONFIG_NOSYSTEM=3Dtrue GIT_CONFIG_SYSTEM=3Ddoes-not-exist git ve=
rsion
    ++	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYS=
TEM=3D/dev/null git config --global --list >actual &&
    ++	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=
=3Ddoes-not-exist git config --system --list >actual &&
    ++	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exis=
t git version
     +'
     +
     +test_expect_success 'write to overridden global and system config' '
    @@ t/t1300-config.sh: test_expect_success '--show-scope with --show-ori=
gin' '
     +	key =3D value
     +EOF
     +
    -+	test_must_fail env GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --=
global config.key value &&
    -+	touch write-to-global &&
     +	GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --global config.key v=
alue &&
     +	test_cmp expect write-to-global &&
     +
    -+	test_must_fail env GIT_CONFIG_SYSTEM=3Dwrite-to-system git config --=
system config.key value &&
    -+	touch write-to-system &&
     +	GIT_CONFIG_SYSTEM=3Dwrite-to-system git config --system config.key v=
alue &&
     +	test_cmp expect write-to-system
     +'

 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 builtin/config.c             |  6 ++-
 config.c                     | 24 ++++++++++--
 t/t1300-config.sh            | 71 ++++++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4b4cc5c5e8..5cddadafd2 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -340,6 +340,11 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
=20
+GIT_CONFIG_GLOBAL::
+GIT_CONFIG_SYSTEM::
+	Take the configuration from the given files instead from global or
+	system-level configuration. See linkgit:git[1] for details.
+
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
 	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3a9c44987f..380422a6a9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -670,6 +670,16 @@ for further details.
 	If this environment variable is set to `0`, git will not prompt
 	on the terminal (e.g., when asking for HTTP authentication).
=20
+`GIT_CONFIG_GLOBAL`::
+`GIT_CONFIG_SYSTEM`::
+	Take the configuration from the given files instead from global or
+	system-level configuration files. If `GIT_CONFIG_SYSTEM` is set, the
+	system config file defined at build time (usually `/etc/gitconfig`)
+	will not be read. Likewise, if `GIT_CONFIG_GLOBAL` is set, neither
+	`$HOME/.gitconfig` nor `$XDG_CONFIG_HOME/git/config` will be read. Can
+	be set to `/dev/null` to skip reading configuration files of the
+	respective level.
+
 `GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
 	`$(prefix)/etc/gitconfig` file.  This environment variable can
diff --git a/builtin/config.c b/builtin/config.c
index 865fddd6ce..a577a53af7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -674,7 +674,10 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 		char *user_config, *xdg_config;
=20
 		git_global_config(&user_config, &xdg_config);
-		if (!user_config)
+		if (!user_config) {
+			if (!strcmp(getenv("GIT_CONFIG_GLOBAL"), "/dev/null"))
+				die(_("GIT_CONFIG_GLOBAL=3D/dev/null set"));
+
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
 			 * we do not know if we should write to XDG
@@ -682,6 +685,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 			 * is set and points at a sane location.
 			 */
 			die(_("$HOME not set"));
+		}
=20
 		given_config_source.scope =3D CONFIG_SCOPE_GLOBAL;
=20
diff --git a/config.c b/config.c
index ebff58aa57..ed46eda997 100644
--- a/config.c
+++ b/config.c
@@ -1846,13 +1846,31 @@ static int git_config_from_blob_ref(config_fn_t fn,
=20
 char *git_system_config(void)
 {
+	char *system_config =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
+	if (system_config) {
+		if (!strcmp(system_config, "/dev/null"))
+			FREE_AND_NULL(system_config);
+		return system_config;
+	}
 	return system_path(ETC_GITCONFIG);
 }
=20
-void git_global_config(char **user_config, char **xdg_config)
+void git_global_config(char **user_out, char **xdg_out)
 {
-	*user_config =3D expand_user_path("~/.gitconfig", 0);
-	*xdg_config =3D xdg_config_home("config");
+	char *user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
+	char *xdg_config =3D NULL;
+
+	if (user_config) {
+		if (!strcmp(user_config, "/dev/null"))
+			FREE_AND_NULL(user_config);
+		xdg_config =3D NULL;
+	} else {
+		user_config =3D expand_user_path("~/.gitconfig", 0);
+		xdg_config =3D xdg_config_home("config");
+	}
+
+	*user_out =3D user_config;
+	*xdg_out =3D xdg_config;
 }
=20
 /*
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e0dd5d65ce..17f1b78c01 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2059,6 +2059,77 @@ test_expect_success '--show-scope with --show-origin=
' '
 	test_cmp expect output
 '
=20
+test_expect_success 'override global and system config' '
+	test_when_finished rm -f "$HOME"/.config/git &&
+
+	cat >"$HOME"/.gitconfig <<-EOF &&
+	[home]
+		config =3D true
+	EOF
+	mkdir -p "$HOME"/.config/git &&
+	cat >"$HOME"/.config/git/config <<-EOF &&
+	[xdg]
+		config =3D true
+	EOF
+	cat >.git/config <<-EOF &&
+	[local]
+		config =3D true
+	EOF
+	cat >custom-global-config <<-EOF &&
+	[global]
+		config =3D true
+	EOF
+	cat >custom-system-config <<-EOF &&
+	[system]
+		config =3D true
+	EOF
+
+	cat >expect <<-EOF &&
+	global	xdg.config=3Dtrue
+	global	home.config=3Dtrue
+	local	local.config=3Dtrue
+	EOF
+	git config --show-scope --list >output &&
+	test_cmp expect output &&
+
+	sane_unset GIT_CONFIG_NOSYSTEM &&
+
+	cat >expect <<-EOF &&
+	system	system.config=3Dtrue
+	global	global.config=3Dtrue
+	local	local.config=3Dtrue
+	EOF
+	GIT_CONFIG_SYSTEM=3Dcustom-system-config GIT_CONFIG_GLOBAL=3Dcustom-globa=
l-config \
+		git config --show-scope --list >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+	local	local.config=3Dtrue
+	EOF
+	GIT_CONFIG_SYSTEM=3D/dev/null GIT_CONFIG_GLOBAL=3D/dev/null git config --=
show-scope --list >output &&
+	test_cmp expect output
+'
+
+test_expect_success 'override global and system config with missing file' '
+	sane_unset GIT_CONFIG_NOSYSTEM &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=
=3D/dev/null git config --global --list >actual &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3Ddoes=
-not-exist git config --system --list >actual &&
+	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exist git=
 version
+'
+
+test_expect_success 'write to overridden global and system config' '
+	cat >expect <<EOF &&
+[config]
+	key =3D value
+EOF
+
+	GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --global config.key value =
&&
+	test_cmp expect write-to-global &&
+
+	GIT_CONFIG_SYSTEM=3Dwrite-to-system git config --system config.key value =
&&
+	test_cmp expect write-to-system
+'
+
 for opt in --local --worktree
 do
 	test_expect_success "$opt requires a repo" '
--=20
2.31.1


--JaB240hM5gSBZKKo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0XVAACgkQVbJhu7ck
PpRJKA/9GQdzarAaG32nqgnU++uxNiSk1blschQ6Yxt/1Jv5U7udtX23GHjzZsDq
/UiZEQOr9USce/BW0RMvbsWOd6N7mLX26nUjtfTd/dr54CqgBWNHZAfTkIZoNbFv
TGI+jGBhLe4sPLXkRYPXmagACE+wTb8Qvhrk+yYcF7ENMTVy1z88ERcaL5KalrQU
VBVHxEnixkgL8KYZ/M1gqtEv2sUV1b1Qd1jDNLCj3OWvB0d4ACb6AZQI9u8UYY07
wwgxpTgLRFjY7N80pIzbDOZHr1S1YTwYyQfrbB6oEmnRrtqrW0LWmO1Tvbulsx/8
Zab6KXk2xXveaGKJRnrE0VvrojX1Dzp+CH44P2Vhqaxv6IZpoTlRlrSyNvczVp73
/QXxW9ruxCjGUsalqiKHeoeT7ahlLxcRbbKmgoRYJMgsFqF/tkEUSLaxUMNFu979
e/LEZy/bk2fm6cw4DqSWtBW5vO9VfWOyxg6PrMCxyGQUJNBX0nCRK0bfl4tIYBS1
PmXuBCJ9OZS5sVR4ioYIAIpnAr3JeioLjVsyA4/dzs2xszfnoJ9Tmf5T/Ga3VxrX
Q3TbOcUx31HVm+o3u1aVjnraPpJnYIFlEEwaGabQC6SNyVlg0eqZmanj0+bdfIj2
EY9yaL24M8gHG5xI5hT4fdlJjWB8D+JK7gANlTk5pN/zI+PR99I=
=Z+n1
-----END PGP SIGNATURE-----

--JaB240hM5gSBZKKo--
