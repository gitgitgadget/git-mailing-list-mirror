Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E49DC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1ACA6113A
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbhDINnr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:43:47 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58941 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233619AbhDINnq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 09:43:46 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 898785C00C1;
        Fri,  9 Apr 2021 09:43:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 09 Apr 2021 09:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=U4716Iwoh4d6ho57TmV/bQPCxrw
        UYaW9Tymr2kwNFUY=; b=qUBQgFd/XUb/nS20ddBoNEox5T1dUqvSPCGc5zXMpiK
        VuuIQCY8/D0BKGDAws5itmFQiItJ8n7pyh5aY3FBbyU0te3XSvsKsxtOX5dVAcBV
        BJAEnszZGCUjqw3XUiGBeXOIfc4YWF2yn+pXFV2YZVaWJgulWlhwc3UJ95NYXd1g
        l5aUq/QuNifLd0AXBn+4WmcnrzIVaL1JgQdER4G1/XjoAQq6RlU17oEyIwCoSoNL
        twAfTu1FnURGuqEdUUOnbafQF80SMgWRVZcEI2nUFN0bhDUcZ89N1ZZC0P2tFu5c
        kQtl0f2l5AFj+MJx8iKvdcRMaZGI7hH99AEFMwCV3fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=U4716I
        woh4d6ho57TmV/bQPCxrwUYaW9Tymr2kwNFUY=; b=HSc+dtpKYqklkMBr2XsHuI
        KYRdMhpBtWqzDrocD5Z+eiU5AnNXIbkp9F2NtOA7BEjAPD2sR2CVTmi7zRlsDrRQ
        +FKagasJgTXzxeYHEkTcraiUviFUbOtXpyvigGM9vrgpnraLQgVN7XunehtM50FX
        1UyBWYqC+2Ovb0mkGZJt6sHbkpQF557NKrs9U1GY3EW4GPbNKa2WjJO1mCoQNYtv
        mVcTLpzfXM42Ik2svykyS6y/z9Il4k1jL6ELklZ6+p/i0bP1xWt6b3BK5AszHtA2
        IeR0l8dR+84Za941S1KnhrfR3A2p16JvWhUyokJk99AQ27g7of+VJA3mjpK22XJw
        ==
X-ME-Sender: <xms:BVpwYAqU4RNCq7fe4StJP7mXWPfOhlVi0BtT8sR8DdBuTgzy_lHOUw>
    <xme:BVpwYGogO48On0xuDn5JSAr4JfYx1E1C5zXuIVc0vHiIG4e5-dbbtlIISajNPiblw
    4a56AjWGe5YHNtbuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:BVpwYFNhZOBs41gtfiGnJnCiNHRhS9Cd2q-mvUz2bWZdWgITaWAsjA>
    <xmx:BVpwYH5ulbEvNhjuCSvrG1Zn23v_P8FnUv-78thMPEBMNf9uEO_eJA>
    <xmx:BVpwYP4DUTqDlMm_EJ3lk-gNNY-2N5Bflr-8xckvqWQyVDxSHbjz4A>
    <xmx:BVpwYPFSbeigufr8gzCEel6SWlYdw-IeJmXrV1vxkUNZbsVijdByew>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4EDF3240054;
        Fri,  9 Apr 2021 09:43:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 60857d5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 13:43:31 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:43:30 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 3/3] config: allow overriding of global and system
 configuration
Message-ID: <272a3b31aa73da8d65b04e647b1b9ca860f4e783.1617975637.git.ps@pks.im>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOcc1yX9Q53rMEqH"
Content-Disposition: inline
In-Reply-To: <cover.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--oOcc1yX9Q53rMEqH
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

The obvious way to fix this would be to introduce `GIT_CONFIG_NOSYSTEM`
as an equivalent to `GIT_CONFIG_NOGLOBAL`. But in the past, it has
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
 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 config.c                     | 34 ++++++++++++++--
 t/t1300-config.sh            | 75 ++++++++++++++++++++++++++++++++++++
 4 files changed, 120 insertions(+), 4 deletions(-)

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
index 3a9c44987f..2129629296 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -670,6 +670,16 @@ for further details.
 	If this environment variable is set to `0`, git will not prompt
 	on the terminal (e.g., when asking for HTTP authentication).
=20
+`GIT_CONFIG_GLOBAL`::
+`GIT_CONFIG_SYSTEM`::
+	Take the configuration from the given files instead from global or
+	system-level configuration files. The files must exist and be readable
+	by the current user. If `GIT_CONFIG_SYSTEM` is set, `/etc/gitconfig`
+	will not be read. Likewise, if `GIT_CONFIG_GLOBAL` is set, neither
+	`$HOME/.gitconfig` nor `$XDG_CONFIG_HOME/git/config` will be read. Can
+	be set to `/dev/null` to skip reading configuration files of the
+	respective level.
+
 `GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
 	`$(prefix)/etc/gitconfig` file.  This environment variable can
diff --git a/config.c b/config.c
index 6af0244085..9dfc4a79f7 100644
--- a/config.c
+++ b/config.c
@@ -1847,8 +1847,22 @@ static int git_config_from_blob_ref(config_fn_t fn,
 const char *git_system_config(void)
 {
 	static const char *system_wide;
-	if (!system_wide)
-		system_wide =3D system_path(ETC_GITCONFIG);
+
+	if (!system_wide) {
+		system_wide =3D xstrdup_or_null(getenv("GIT_CONFIG_SYSTEM"));
+		if (system_wide) {
+			/*
+			 * If GIT_CONFIG_SYSTEM is set, it overrides the
+			 * /etc/gitconfig. Furthermore, the file must exist in
+			 * order to prevent any typos by the user.
+			 */
+			if (access(system_wide, R_OK))
+				die(_("cannot access '%s'"), system_wide);
+		} else {
+			system_wide =3D system_path(ETC_GITCONFIG);
+		}
+	}
+
 	return system_wide;
 }
=20
@@ -1857,8 +1871,20 @@ void git_global_config(const char **user, const char=
 **xdg)
 	static const char *user_config, *xdg_config;
=20
 	if (!user_config) {
-		user_config =3D expand_user_path("~/.gitconfig", 0);
-		xdg_config =3D xdg_config_home("config");
+		user_config =3D xstrdup_or_null(getenv("GIT_CONFIG_GLOBAL"));
+		if (user_config) {
+			/*
+			 * If GIT_CONFIG_GLOBAL is set, then it overrides both
+			 * the ~/.gitconfig and the XDG configuration file.
+			 * Furthermore, the file must exist in order to prevent
+			 * any typos by the user.
+			 */
+			if (access(user_config, R_OK))
+				die(_("cannot access '%s'"), user_config);
+		} else {
+			user_config =3D expand_user_path("~/.gitconfig", 0);
+			xdg_config =3D xdg_config_home("config");
+		}
 	}
=20
 	*user =3D user_config;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e0dd5d65ce..5498ca32b0 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2059,6 +2059,81 @@ test_expect_success '--show-scope with --show-origin=
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
+	test_must_fail env GIT_CONFIG_GLOBAL=3Ddoes-not-exist git version &&
+	test_must_fail env GIT_CONFIG_SYSTEM=3Ddoes-not-exist git version &&
+	GIT_CONFIG_NOSYSTEM=3Dtrue GIT_CONFIG_SYSTEM=3Ddoes-not-exist git version
+'
+
+test_expect_success 'write to overridden global and system config' '
+	cat >expect <<EOF &&
+[config]
+	key =3D value
+EOF
+
+	test_must_fail env GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --globa=
l config.key value &&
+	touch write-to-global &&
+	GIT_CONFIG_GLOBAL=3Dwrite-to-global git config --global config.key value =
&&
+	test_cmp expect write-to-global &&
+
+	test_must_fail env GIT_CONFIG_SYSTEM=3Dwrite-to-system git config --syste=
m config.key value &&
+	touch write-to-system &&
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


--oOcc1yX9Q53rMEqH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwWgEACgkQVbJhu7ck
PpTSgQ/+NziLak8eFngMrUWGIDTDX+c8jDZnBgwkomnqFSnnLTZd/4fwndZjvqxG
YSiVyD9ikdBamoGM9DBuOKOQ2M5fhZb3Lg4LepFtKlhBmTd2r2mRgndf3/9r097e
jzBqEknNrxGhhf1o7Z7HaaZG77uAep60f+b9+az1gDnHh3yrIPCOmtpciw5PPiCz
XoUL32IdAtxq9i8Mze5s7s8D8nflFTydg+xZAaxnXVgNYClBE1nyuQswphU4E8LT
Ibnu63Q/VbnXNEUeLg5xW1N6JFMAwLK9SPAvSvWLaihKmC/vPItTp7R1uxiSWnUZ
EiEk/X7wgtIoSyjEZ4NC8r8xP22OS/Aqkn3UfGyhd6cHd6iHkRBN28bRNeDr+f2m
aRbe0v3c+u4QbvmArleO+yzFAqmjO5bVMxMDfjeRKMW5ZmrMZznowQ/zTr6UX2GA
MiI4abOSOVl0jvbTP5eKBx6uoCOduFwHMIdEmxDa8RsfX+8WaoN6YEP6pOpzYmTc
oL9TqVxS6ebruIETF5At1lolMA1KEY6GbLVXDHePBc3ZOnmHuL8VOz6V+EoT+OAb
z2kJK+K6990FQSb82D/CJox2LbbsDp8rTNT+jK2l9FFh8S0nYhAAMEKjHyipudcf
UXZaHxfXle3Ai/XWVDljbDk23uTv49FeY5Ih/ZRPGNfyhSgyvRg=
=gYus
-----END PGP SIGNATURE-----

--oOcc1yX9Q53rMEqH--
