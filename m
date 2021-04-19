Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E466C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D36761245
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbhDSMbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:31:52 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44821 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239169AbhDSMbu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 08:31:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 47E1F10BF;
        Mon, 19 Apr 2021 08:31:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 08:31:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=tFme/WO6dkgmqMMBtDL2DgIYXX6
        N8iQRO7bGYcFxOwA=; b=SNy4HpPNZ8pkn1kzt3X3aFux1vNDCj9EqnPWvRvHfIu
        jdKOmu+Mu+nprD/J8ZM7xi26TKSwUtfhulu/kNcG9PZN7z4ntb+Nrdup6jRfnn8V
        kEMZDNYEBhN6UjDSw34i3wU8QTSoSqu1ZC9diVZ+LBo8RftO8SWH9cBI28eABe8v
        tpYPUDB2MVjyT6H5ZWxICclbJk8S1UglZOjCbR5lYIEkVv7D/5hwHKMAR7bSLoi5
        SmDItW9XhjDr2/uqCnAeoVtr9yOMinMjFrpby6yY2SjQ602youBnGGmQSs2Cs0wL
        3H5g3Ttf8yVlevAwyWj0h+kQ92LmwqMKjnfTYi7xbvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tFme/W
        O6dkgmqMMBtDL2DgIYXX6N8iQRO7bGYcFxOwA=; b=I0SBz6KlfV25OYRpCJHN3J
        nmLyhwPKxsROvxFVc0Ocm3DbwMgWP5YyYFxOXdH5TaNFd0ni2lgNtaFTT+0wpmwA
        +MnmWv4psHWBfWaHp0I0B4VPenHdtIv8RDoMUuUnRb0OxfSZd2mh3R0wa1mFe/D+
        J2XliAVuyatvXw+0ogYQMbqFxxw049HzaBXRAyMuoZ4hWWvaivdKRpj3eB7+gO4u
        cFiALXTGI23DlOAh5rKWaLZmGoezB3+dh5u7KBeuQHs4t3gmdSAXzpL+NiuiKFoI
        4S7ICc8XS9rsPL2Y8HeJ/RhD/tSuu29C90RmpNDlCbiGS3sPJLLXxqmFVgU04eMA
        ==
X-ME-Sender: <xms:F3h9YJ79gGwTCaNdbeHU6KqEOk25Gtmn7gvnF06R44JV5jSBd6v4nA>
    <xme:F3h9YG4MZjB3Y3cnSR_-EJUO2NeyfwfY2rQ5ChD1cgQECiQIQ6iWIQR3wgx75KzOG
    fpivRKda82-3EIFPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:F3h9YAd3Zhv0swBqc0SQ9-QqMSu-4sgxCIfDzfZiXLLx4q_OsHX4GQ>
    <xmx:F3h9YCJk6Mrg0-ffogsISH16pbRr-ejKIZBeDz5cBYsP0VO3ys5zkQ>
    <xmx:F3h9YNLyhDZMtNpeRrh3jnT_OUlty3WUEWZv0_8b5ARM0yIlqMm67A>
    <xmx:F3h9YN1MFuxrjeF1Vrj6PP1Ft3duN8A23Sl4aVwHZLYU2UJqu6oDRQ>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7B631080069;
        Mon, 19 Apr 2021 08:31:18 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a84fff4a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 12:31:17 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:31:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 3/3] config: allow overriding of global and system
 configuration
Message-ID: <7e7506217e4aac82e3a03013d24e6f885383ecd3.1618835148.git.ps@pks.im>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wmPDeZlEZ7U6rDyt"
Content-Disposition: inline
In-Reply-To: <cover.1618835148.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wmPDeZlEZ7U6rDyt
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
 config.c                     | 17 +++++--
 t/t1300-config.sh            | 86 ++++++++++++++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 3 deletions(-)

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
index 161dfaa707..f9c400ad30 100644
--- a/config.c
+++ b/config.c
@@ -1832,13 +1832,24 @@ static int git_config_from_blob_ref(config_fn_t fn,
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
index e0dd5d65ce..0f92dfe6fb 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2059,6 +2059,92 @@ test_expect_success '--show-scope with --show-origin=
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
+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=
=3D/dev/null git config --global --list &&
+	test_must_fail env GIT_CONFIG_GLOBAL=3D/dev/null GIT_CONFIG_SYSTEM=3Ddoes=
-not-exist git config --system --list &&
+	GIT_CONFIG_GLOBAL=3Ddoes-not-exist GIT_CONFIG_SYSTEM=3Ddoes-not-exist git=
 version
+'
+
+test_expect_success 'system override has no effect with GIT_CONFIG_NOSYSTE=
M' '
+	# `git config --system` has different semantics compared to other
+	# commands as it ignores GIT_CONFIG_NOSYSTEM. We thus test whether the
+	# variable has an effect via a different proxy.
+	cat >alias-config <<-EOF &&
+	[alias]
+		hello-world =3D !echo "hello world"
+	EOF
+	test_must_fail env GIT_CONFIG_NOSYSTEM=3Dtrue GIT_CONFIG_SYSTEM=3Dalias-c=
onfig \
+		git hello-world &&
+	GIT_CONFIG_NOSYSTEM=3Dfalse GIT_CONFIG_SYSTEM=3Dalias-config \
+		git hello-world >actual &&
+	echo "hello world" >expect &&
+	test_cmp expect actual
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


--wmPDeZlEZ7U6rDyt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9eBMACgkQVbJhu7ck
PpRaWQ//WVYcLy9ZmxkQrm6BaalYYNeveio4pkWVb03KW73YVStz5YRC/Dvqw5K6
rLf8Me9PQOQii/oYnLTN64qIN6DX95LElv9g/ZDHrPI6ih6fviuKUTukSa286DY6
k//LzaDX6Fqjo6zcY5mzEmFAms4Mu1Hrg5l/z0HTPftXbE65fkk5zG3m3i8g+yAW
jJRByymtKPcNwzqKamUWMFpCck4+XN2IfojRQs9p4wzvNZB5INJltiv2dWh5ybAd
JjV4UmeOY+Mnc59HEsw8AxSYqND97JPupwciitlXAudjQP7F6PvPx6Upc6plcmPW
O+Oq9lFEyUsaeig/s2TOt9X8hys/EK+Jkd/8w5emAyjP3LoHk7+O09KM8jDHcFzq
3GFWgY/ejMzL1g1ly/JcVOt1Q1W7GfxZGifzFVLmHagRNLDCD/QMNHq9Rx6S2fhV
NAvqz+JkSW2qbjYZ8QmFOHYXhR00P89+BWszua3Ah+ADaguie7vu8jol+DXy8y38
PO2Dljz4JYbcKRzWe+VvJFeL1jwhChGtqSsrQ1rHS3VGC1K0LPuy8g4Dauxm0/6+
zcVbZMmlJh9wdhnapq38aVYyH8hYc2fS6xsUqhVFTblsv6FnJLv9/J4nBqw2NAy2
Sc70krSmg+QLhyOQdKr4TFzoFv3Vi2ROtaLtdZOeiXLWPSf2ecg=
=fNQx
-----END PGP SIGNATURE-----

--wmPDeZlEZ7U6rDyt--
