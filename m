Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4525BC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B2A613B2
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237349AbhDMHMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:12:16 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49757 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhDMHMO (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 03:12:14 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 865F85C0090;
        Tue, 13 Apr 2021 03:11:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 03:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=X4ANgMOYVKPIWSmkwER0u23dZ0r
        EUT0aMeN2wqx/rAo=; b=qrcLkBF6TgrDsZMG1NnhdYqrNFwQRu1qMdrvtFUowc/
        IO4Hj0hLG3GmDPHz5BrAp9s8P0rKr3hqSnaQLhfWadGfEOy5LRKt8/yHFSoEJ8JN
        RW4fg2syO6ssFc/QDz1wAcoxmoUhbhLNSAXe+43pvp9i19Toaw/UX9DjCg4bfgK/
        xy02Bo3VhA6OKx9L4Uw1rFYxm1av7RDnwW8E3caCmphmXoXZb8vV4V9lqj1zG4xf
        ZZQGU4dMJt/VI6dgXyosxfZRtX7Sd6pck8S+P7hHro0ZVKHkTD3pAgcMPS0vqggj
        sEcE+GIZD+PVa/JXxLwZ1gO4mtVEkeat//b5iizr3aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=X4ANgM
        OYVKPIWSmkwER0u23dZ0rEUT0aMeN2wqx/rAo=; b=XgEPKj/74luAqkn8F3dmRP
        gE22aFqMNMrzpYZ7Ou5c+cyP13uvo3ikTlO37VTJK0G3j8V6tXoSBRr3m6DtH/BD
        w6IibCWgY+PCeiv6jp/Tw40sezeCvO3NI2WqkmBiOig6Nken9OkXLDXHjWuo2B7e
        G1cGv09NUJTkTgBI4eE5R+d2yy9HaZgQEut4VPD/62Mz4FUCh4WEhG2qX4z2sSez
        Sr8LQvtZQro4aSxcFzItWIhdPiKb0L4Yu9hq3EOSfnuGoj1qxv3OWDC5Tfc3cFYj
        tHpNiYRLMJuxGoXpBVpTWtO5L5I2VwHDHa4DxaImuiaIoOLO1FxSZo1kkPTxKNqQ
        ==
X-ME-Sender: <xms:O0R1YKYCTvbsYYFiBC3twkfsTJ-jZ5hzOXOAR69GEPnUef8buRAI8Q>
    <xme:O0R1YNZglqKI5_BmNHu8x4962aRtwygBFWBDQoy9n3WwjHII9Jzcxz3RLP0eJ_LAC
    nY4KOZ9RhVSeLfSew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdefhedrvddufeenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:O0R1YE_XryVDQC0djBtup5DAl85XgIF4jXBswpBUFsvydBM8TlA1ww>
    <xmx:O0R1YMoSB0tPltK37_TeRsxjtOXjodOnrd3fp0tOznODY-l37lSydg>
    <xmx:O0R1YFpAYAd8vv6p7MLNI6S7_c1bHetQYgKkwIZ-EFZyc2djmT5Qhw>
    <xmx:O0R1YM0-LatkfKmRQ1bKcHJV4-YtYI2u-uAoqKH2hkVO1WRGykbpzA>
Received: from vm-mail.pks.im (dynamic-089-014-035-213.89.14.pool.telefonica.de [89.14.35.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id B99C7240065;
        Tue, 13 Apr 2021 03:11:54 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9d4eafa0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Apr 2021 07:11:53 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:11:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 3/3] config: allow overriding of global and system
 configuration
Message-ID: <d27efc0aa847f3fb179307b3a265b3759b7d9570.1618297711.git.ps@pks.im>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qjPk/EmmhrP31hxW"
Content-Disposition: inline
In-Reply-To: <cover.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qjPk/EmmhrP31hxW
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
      configuration files and instead take the path. By setting the path
      to `/dev/null`, no configuration will be loaded for the respective
      level.

This implements the usecase where we want to execute code in a sanitized
environment without any potential misconfigurations via `/dev/null`, but
is more flexible and allows for more usecases than simply adding
`GIT_CONFIG_NOGLOBAL`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 config.c                     | 17 +++++++--
 t/t1300-config.sh            | 71 ++++++++++++++++++++++++++++++++++++
 4 files changed, 100 insertions(+), 3 deletions(-)

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
diff --git a/config.c b/config.c
index ebff58aa57..7caf6c1e53 100644
--- a/config.c
+++ b/config.c
@@ -1846,13 +1846,24 @@ static int git_config_from_blob_ref(config_fn_t fn,
=20
 char *git_system_config(void)
 {
+	char *system_config =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
+	if (system_config)
+		return system_config;
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
+	if (!user_config) {
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


--qjPk/EmmhrP31hxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB1RDcACgkQVbJhu7ck
PpRvWA//dEvfqW6fzWKCb/QpAjGaE/gGpwnhq42S7uuGACFiuk5YPRuDw1nho6OZ
RiPPyBnUsMp74E0oW4RSJ6W9GsVvlHmowD5ASA43HgvbGkLEYVtpnw7qP7NOKvHV
LsjJrQQTGHOTAISDEVyeQ7lXaQq+aMUmBfsX3AhrUoQFTMHQvgrwMMyTYD9tU3+5
HoNvQdszxzbH8SssQ8UgR9Dk8MMcaNqpMzuf4ya8uLBqtDB33pvzxrOUfDx4q6XH
5Y5TJbQgNekRg6ttWYlMksis13rr3+D2BuIucu7TaYNJAnTKSkj+/69z/ZqaSP+B
yi3HjsdfVQWl3BVGBXl6pqBlbjypQlz3bdiEV+aQiYT+/pmrWWjqkUmTsK71rz2N
DtpCxNi7bDVV4EmgR40tqYJRv5574B1rcBU9WJ+/2bcvIqzDW9y0oMF5pFuS8Suw
23dwp948i38NinGVzvJSnu91K9dN0UOwBKMZrJkFHGkGmIfBUyfHzbZQuGM6xUxo
YIngeYFYtv95LP/TE1rNlhkhgVDDvhSUkR/hKh8DQ8JO0RC/OrvTHBSaG4Fxt+q0
+pDtRHlWmLJ6x1XkbIoHvnUx9UokQGPFOVX7Qs+CtqBWBa++fz1NH8kG0rav7Rb9
igG5jDAPE/UO5c9sVqCv1f5eKhxin3GdJMhdWBZW88TFQ6tMFeA=
=H48D
-----END PGP SIGNATURE-----

--qjPk/EmmhrP31hxW--
