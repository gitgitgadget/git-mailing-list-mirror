Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98AC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5CD06113D
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 14:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbhDHOSa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 10:18:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:53143 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232053AbhDHORn (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Apr 2021 10:17:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id A48D15C0063
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 10:17:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 08 Apr 2021 10:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm3;
         bh=t8YZOlEcQYkTExDZY5XIkIf7Jx8bX0he0VBmOix8Yd4=; b=HtGSlNss6HXt
        a0cuw5NVT4Kjll6EfXcDEjekh4NXwkTCr0rLdY8sXKAbeLUDQimtb0VOacv/fzoU
        7tvesEz1yf36b+4PmNzFq448lyaX+IIapZ1xXvz1jJdocyTRHWVjjx5aaMWzsgR8
        9qDdtje1cKC+lN6U3ExX3RAq3FVPOKbCYAAyqO6Iu5pGdvoWu2yZBCQ/usaqKWeE
        uR253ILIen9UpVPQxesxI6W9Ys8Wk948tURoA01mE0lrB5kBdCttCMnKhS5cERe4
        G7W568QDBe2xKwt56vH28PMAhpuML4MgsuD68vOCwrTPHwniDDXSLGlRArX7/I9X
        2WghXAMRbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=t8YZOlEcQYkTExDZY5XIkIf7Jx8bX
        0he0VBmOix8Yd4=; b=DazOwu0pIsanRK2Tq2XrqvhLKOsjEi/3DgAfZte+hXmgw
        EETV1GXKhUlOFRGLx3QX3QnbjF/wEgtmGHskSyUgbrI7ShiicN6vFI9Gt6vRGZy8
        +Zz+rIarglyvy2cRrp4WsXico65ytkBzoOcwPQ1xuVpR98z8iWRsalJu7xr/D2vz
        RvMbQ1iGRovmxPgQz6HaBsL/nEwu3TEKHgBFc6POF6xU+YjiWUNPRQgv2Eud0pI6
        apqFc2moWnYg2+6KHsaLWpdJ+J4uywpYIQYRPsD30u55H4mYzw2cyzOhadyGsoz+
        HHTqAa4YTvtp9tgaWsRAuRzr5WEKS/p0hqtUm2mrA==
X-ME-Sender: <xms:exBvYGvnhaSQiICFSwtF212G3jnaQmgtoYk_zU_gn2x1l-EcIfK_Lg>
    <xme:exBvYIlnp7CLm3WHZe-beCNg8YFDL1V8qjICYC7pasf5Qxq4aNF24O0-EqJWSGwH0
    -9VSJI2qD4bHckqiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudejledgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeejjedrudeluddrgedrleelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:exBvYAyFlOJAF0W09UsgQjaQv6B-GjC245NT7GJKZXRAOHnsALvCGg>
    <xmx:exBvYCO2Dk6cHGP3QXlMaZNrg8Mq0HV7e_fTz8ow5evmYTJvQc5Rmg>
    <xmx:exBvYEpAnK1apR1Pcbd2w08If3O7xhILm1ulbZofA1cUMjrCisUZKA>
    <xmx:exBvYCUbaWj-EED5g2jnmKbL-Dwgc-tyYR8PETaT0wjIqZUudhx-Dw>
Received: from vm-mail.pks.im (x4dbf0463.dyn.telefonica.de [77.191.4.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id F30D81080069
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 10:17:30 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 599fa1cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Thu, 8 Apr 2021 14:17:24 +0000 (UTC)
Date:   Thu, 8 Apr 2021 16:17:23 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
Message-ID: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="I2UmYPcyVgD7iqsh"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--I2UmYPcyVgD7iqsh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While it's already possible to stop git from reading the system config
via GIT_CONFIG_NOSYSTEM, doing the same for global config files requires
the user to unset both HOME and XDG_CONFIG_HOME. This is an awkward
interface and may even pose a problem e.g. when git hooks rely on these
variables to be present.

Introduce a new GIT_CONFIG_NOGLOBAL envvar, which is the simple
equivalent to GIT_CONFIG_NOSYSTEM. If set to true, git will skip reading
both `~/.gitconfig` and `$XDG_CONFIG_HOME/git/config`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-config.txt |  4 ++++
 Documentation/git.txt        | 16 ++++++++++++----
 config.c                     |  9 +++++++--
 t/t1300-config.sh            | 31 +++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 4b4cc5c5e8..88cd064abb 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -340,6 +340,10 @@ GIT_CONFIG::
 	Using the "--global" option forces this to ~/.gitconfig. Using the
 	"--system" option forces this to $(prefix)/etc/gitconfig.
=20
+GIT_CONFIG_NOGLOBAL::
+	Whether to skip reading settings from the global ~/.gitconfig and
+	$XDG_CONFIG_HOME/git/config files. See linkgit:git[1] for details.
+
 GIT_CONFIG_NOSYSTEM::
 	Whether to skip reading settings from the system-wide
 	$(prefix)/etc/gitconfig file. See linkgit:git[1] for details.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 3a9c44987f..4462bd2da9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -670,13 +670,21 @@ for further details.
 	If this environment variable is set to `0`, git will not prompt
 	on the terminal (e.g., when asking for HTTP authentication).
=20
+`GIT_CONFIG_NOGLOBAL`::
+	Whether to skip reading settings from the system-wide `~/.gitconfig`
+	and `$XDG_CONFIG_HOME/git/config` files.  This environment variable can
+	be used along with `$GIT_CONFIG_NOSYSTEM` to create a predictable
+	environment for a picky script, or you can set it temporarily to avoid
+	using a buggy global config file while waiting for someone with
+	sufficient permissions to fix it.
+
 `GIT_CONFIG_NOSYSTEM`::
 	Whether to skip reading settings from the system-wide
 	`$(prefix)/etc/gitconfig` file.  This environment variable can
-	be used along with `$HOME` and `$XDG_CONFIG_HOME` to create a
-	predictable environment for a picky script, or you can set it
-	temporarily to avoid using a buggy `/etc/gitconfig` file while
-	waiting for someone with sufficient permissions to fix it.
+	be used along with `$GIT_CONFIG_NOGLOBAL` to create a predictable
+	environment for a picky script, or you can set it temporarily to avoid
+	using a buggy `/etc/gitconfig` file while waiting for someone with
+	sufficient permissions to fix it.
=20
 `GIT_FLUSH`::
 	If this environment variable is set to "1", then commands such
diff --git a/config.c b/config.c
index 6428393a41..19c1b31c75 100644
--- a/config.c
+++ b/config.c
@@ -1879,6 +1879,11 @@ int git_config_system(void)
 	return !git_env_bool("GIT_CONFIG_NOSYSTEM", 0);
 }
=20
+static int git_config_global(void)
+{
+	return !git_env_bool("GIT_CONFIG_NOGLOBAL", 0);
+}
+
 static int do_git_config_sequence(const struct config_options *opts,
 				  config_fn_t fn, void *data)
 {
@@ -1903,10 +1908,10 @@ static int do_git_config_sequence(const struct conf=
ig_options *opts,
 					    data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
-	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
+	if (git_config_global() && xdg_config && !access_or_die(xdg_config, R_OK,=
 ACCESS_EACCES_OK))
 		ret +=3D git_config_from_file(fn, xdg_config, data);
=20
-	if (user_config && !access_or_die(user_config, R_OK, ACCESS_EACCES_OK))
+	if (git_config_global() && user_config && !access_or_die(user_config, R_O=
K, ACCESS_EACCES_OK))
 		ret +=3D git_config_from_file(fn, user_config, data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_LOCAL;
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e0dd5d65ce..0754189974 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2059,6 +2059,37 @@ test_expect_success '--show-scope with --show-origin=
' '
 	test_cmp expect output
 '
=20
+test_expect_success 'GIT_CONFIG_NOGLOBAL' '
+	test_when_finished rm -f "$HOME"/.config/git &&
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
+
+	cat >expect <<-EOF &&
+	global	xdg.config=3Dtrue
+	global	home.config=3Dtrue
+	local	local.config=3Dtrue
+	EOF
+	git config --show-scope --list >output &&
+	test_cmp expect output &&
+
+	cat >expect <<-EOF &&
+	local	local.config=3Dtrue
+	EOF
+	GIT_CONFIG_NOGLOBAL=3Dtrue git config --show-scope --list >output &&
+	test_cmp expect output
+'
+
 for opt in --local --worktree
 do
 	test_expect_success "$opt requires a repo" '
--=20
2.31.1


--I2UmYPcyVgD7iqsh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBvEHIACgkQVbJhu7ck
PpTJtQ/9EsVAahAI7QkeidfiKCUaWrdDAtyLsT2l3Hknz26Kdug8GxTznVIg7QiL
qDxYlkvDOux7zfct88IwJKLK4NZptbEZ/Xmr+J8vtQkTibVmVAE6GqOkQw44/0QM
B/QxkcO0JVtm3WFUwXBP+Sza1LfeKxfxL8Dg9tdl5iocrSWI/wIrfqjhfMuU3qv+
uyeskGrwFdQiTWYlAC0P9NLFXYhhHI9WalAYtJARw5+Xi8+YbYC91h1S5XtDCPbQ
exKn0iM5rXzlRUTDlW414SWGMxLNafAGvjWgH3zsNQvMVWwnkHTNsjs9ogB1A+no
P0T+vsgi5UWnjrnqiT5qOZUHxYXQ77qe7UMe/oEKi1ty/kvTJfn08crGB1bP3BQX
hUnH3Vclb2jGzUs2HvikOQWJqhlqSq1wq9qnkpcIva32CzJqyxmJlGO6w6HtoMPL
vgfiD+qUgSGCdSsE7pQxTirk+++oCnxve/IRkEdyxQt4ZIWTNJVVYOYbX6LHH7A0
wWotVxPOdS9MtUOL22IjBG2+YadXSBXNFv6yFFYYpb6BWrj6NjHi6YE8pn/d7UZ7
D7d+M0dQlUm9ozTgdn/LXbkJEnMk8XNBfvBXHvXnXfAVR4bIGJF7kooaSoUbbTQ4
8jm955Ovw9GhBa12j+y4LTgMW1wgwjyyAM7pzCuEXtE01gqneR8=
=0HKR
-----END PGP SIGNATURE-----

--I2UmYPcyVgD7iqsh--
