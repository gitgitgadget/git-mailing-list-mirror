Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74093C433B4
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D98061356
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237806AbhDLOrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:47:06 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:43889 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241014AbhDLOrG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 10:47:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id ACE5E1646;
        Mon, 12 Apr 2021 10:46:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 12 Apr 2021 10:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=rpT4izDLNEsDDNSdOuFJKOYVoHf
        KSTqHokGlAJyt7bM=; b=ZHMVOTQzStnkl61wOYDGHzL7mni1PPwD6Nz1DxVoIsi
        fchrGQ5nlfQd5QxEeCZYLqLIAvjl7VVtK+K0xnN6+44GnX2gvvn6XVj5BU5RwHyM
        1DyiI+RR2VGUwkX2mnqDRs0lXkE2RZPwgnZBzddccImzNaKdwOixhc3AtbgZLtBg
        DHOxxDMGlWkYv9NRfyoFU0po4LRNv5PBtWyPMSr7EbSD4nptZysFpepUvy1Fz0Nq
        zmHzDsFmHh8be+nUboCLhC2wUResAsgo0sINvNn6o9th12xX4wbTEMCci3c+TmzA
        T3EFbkt+ZgOi3QPqQgS7Xkp0BeJvIeURP8eeJR1tofg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=rpT4iz
        DLNEsDDNSdOuFJKOYVoHfKSTqHokGlAJyt7bM=; b=VbSX3AME3aKSqD/jdHf/Ns
        Wvn2RtSBr8S8g/UIGjaqlgVf24Itd/XvOndMsxU8rZ0j2WSKtH3bU55qunEq5h7P
        UI2FfEFetxZpE2kuNxTePBaZjOwRYoNVMSYv4VsvRaiS81K49S9slXvZyQc8JE+H
        bBc/5OacV2d3hOhD/hNckFaNsFb74iX0D62pmCXxB8DaBOXdsvYujbn8Lm39rVSh
        +RLQ3Urw/UB2hZ/H7G3ywb5KYtJOHQ4L+wndVRmj2Ac499LNskQUE1JSUmvTYbRU
        TOHZzNK+38Fx9QdflLiEynvc0IaxZzSIgvELhseHDVqOABVz2y6U+ZO3S0LUS9oA
        ==
X-ME-Sender: <xms:Vl10YFOrFwtS58KutVAzdKsOY7RUQHpS7PO0wQX0f8hDbN_Pm87E_A>
    <xme:Vl10YH4F-k-1ZW9MjZ6t2kfROFrolLRo8L4z-owJWUOWbbniCE0-ZhrBkn2lOXZ_z
    lrnpdjqoynvOhsXbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Vl10YBKAsKN5BEMXrejM7gUve3Dldqk8dGseoWuphqNlr-DdCpGxXg>
    <xmx:Vl10YJegebNwzD43FAljti5kjJALhaRoOR7E0zcBaefpkv-3h0clWg>
    <xmx:Vl10YMcTRL3kdsdTOQV5wM_VzauBhMGM8eedctTECm0k4OFR2nFtwg>
    <xmx:V110YKYfT4AVQKTYeV7x7WIG4wUG6MySNDUGgc2J4GiGJnwSy9EfVg>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id 556C71080057;
        Mon, 12 Apr 2021 10:46:45 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b77e1db3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 14:46:38 +0000 (UTC)
Date:   Mon, 12 Apr 2021 16:46:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 0/3] config: allow overriding global/system config
Message-ID: <cover.1618238567.git.ps@pks.im>
References: <cover.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jm9zS6OyTE66AFUe"
Content-Disposition: inline
In-Reply-To: <cover.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jm9zS6OyTE66AFUe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series to provide a way of
overriding the global system configuration.

Changes compared to v2:

    - `/dev/null` is now truly special-cased to skip reading any file
      such that it's possible to use it e.g. in environments where this
      special file does not exist.

    - There is no explicit requirement for the given files to exist
      anymore. On the reading side, it will in most cases just be
      ignored (except for e.g. `git config --global --list` and similar,
      where we'd also fail if the normal global config didn't exist). On
      the writing site, we now create the config file it it's missing.

    - Both `git_system_config()` and `git_global_config()` now pass
      memory ownership to the caller.

Patrick

Patrick Steinhardt (3):
  config: rename `git_etc_config()`
  config: unify code paths to get global config paths
  config: allow overriding of global and system configuration

 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 builtin/config.c             | 12 ++++--
 config.c                     | 48 ++++++++++++++++++------
 config.h                     |  4 +-
 t/t1300-config.sh            | 71 ++++++++++++++++++++++++++++++++++++
 6 files changed, 133 insertions(+), 17 deletions(-)

Range-diff against v2:
1:  da0b8ce6f0 ! 1:  34bdbc27d6 config: rename `git_etc_config()`
    @@ Commit message
         would start to become misleading.
    =20
         Rename the function to `git_system_config()` as a preparatory step.
    +    While at it, the function is also refactored to pass memory owners=
hip to
    +    the caller. This is done to better match semantics of
    +    `git_global_config()`, which is going to be introduced in the next
    +    commit.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ config.c: static int git_config_from_blob_ref(config_fn_t fn,
      }
     =20
     -const char *git_etc_gitconfig(void)
    -+const char *git_system_config(void)
    ++char *git_system_config(void)
      {
    - 	static const char *system_wide;
    - 	if (!system_wide)
    +-	static const char *system_wide;
    +-	if (!system_wide)
    +-		system_wide =3D system_path(ETC_GITCONFIG);
    +-	return system_wide;
    ++	return system_path(ETC_GITCONFIG);
    + }
    +=20
    + /*
    +@@ config.c: static int do_git_config_sequence(const struct config_opt=
ions *opts,
    + 				  config_fn_t fn, void *data)
    + {
    + 	int ret =3D 0;
    ++	char *system_config =3D git_system_config();
    + 	char *xdg_config =3D xdg_config_home("config");
    + 	char *user_config =3D expand_user_path("~/.gitconfig", 0);
    + 	char *repo_config;
     @@ config.c: static int do_git_config_sequence(const struct config_opt=
ions *opts,
      		repo_config =3D NULL;
     =20
      	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
     -	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
    -+	if (git_config_system() && !access_or_die(git_system_config(), R_OK,
    - 						  opts->system_gently ?
    - 						  ACCESS_EACCES_OK : 0))
    +-						  opts->system_gently ?
    +-						  ACCESS_EACCES_OK : 0))
     -		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
    -+		ret +=3D git_config_from_file(fn, git_system_config(),
    - 					    data);
    +-					    data);
    ++	if (system_config && !access_or_die(system_config, R_OK,
    ++					    opts->system_gently ?
    ++					    ACCESS_EACCES_OK : 0))
    ++		ret +=3D git_config_from_file(fn, system_config, data);
     =20
      	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
    + 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
    +@@ config.c: static int do_git_config_sequence(const struct config_opt=
ions *opts,
    + 		die(_("unable to parse command-line config"));
    +=20
    + 	current_parsing_scope =3D prev_parsing_scope;
    ++	free(system_config);
    + 	free(xdg_config);
    + 	free(user_config);
    + 	free(repo_config);
    =20
      ## config.h ##
     @@ config.h: int git_config_rename_section(const char *, const char *);
    @@ config.h: int config_error_nonbool(const char *);
      #define config_error_nonbool(s) (config_error_nonbool(s), const_error=
())
      #endif
     =20
    -+const char *git_system_config(void);
    ++char *git_system_config(void);
     +
      int git_config_parse_parameter(const char *, config_fn_t fn, void *da=
ta);
     =20
2:  dddc85bcf5 < -:  ---------- config: unify code paths to get global conf=
ig paths
-:  ---------- > 2:  30f18679bd config: unify code paths to get global conf=
ig paths
3:  272a3b31aa ! 3:  af663640ae config: allow overriding of global and syst=
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
    @@ Commit message
             - If unset, git continues to use the usual locations.
    =20
             - If set to a specific path, we skip reading the normal
    -          configuration files and instead take the path. This path must
    -          exist and be readable to ensure that the user didn't typo.
    +          configuration files and instead take the path.
    =20
             - If set to `/dev/null`, we do not load either global- or
               system-level configuration at all.
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
    ++			if (getenv("GIT_CONFIG_GLOBAL"))
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
--=20
2.31.1


--jm9zS6OyTE66AFUe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0XUwACgkQVbJhu7ck
PpQB3Q/+JFG+CJRq4sGjVdO0bzlVLBDoBJT6b8wb0Jdl62aVOI+Ha1MRsdFMWnJ3
ebt8h+60ujUo6iBqdac6T/g628EAaD+8VsaQkHwx55RBdHyyI08elGEpPtobu7Wh
ouu7PmvtA/flAMHzNM/jYaR/ebLci3UjQmDOkwkvRYQvX94Y8MgCKNEyAylnJ5Jh
e3pX9iMynDFsjipDCqWfnm+XQLZTC5OBgzkri54mbsNLQk9LKyN5fivP3XeWw5z5
nSs5RYAHR4nfNNCIzFd3znJ+tX9tp1cPvVkMYbh46Q47eXb+dVNZipncjujWBmD1
7cQTQGmrhHXNYerpY2KzmI8Px/JYMTD0f+dDBAVY4whDYju6L9cJ/g99V3p2LiIA
tswTNu9oNs9aKTfPObyBnmf9ZupvROblzSjL7ylF0pLd15w5Bqu//ipT0joz1Ozf
0K4r03P30Jkq6CmTtkHzMY7WNiZNdkrE+oJ7YDTcIuO5UH5/kMv/OQISUFpHIpcL
nAk8aT111H3lV9WsNS+ACz3O65Hye30tq8qYEu7YlJ6d4pxiDWxI7x2Z3Ic8Ht5D
h6iMBgPWPPsNeV7zqiwpZ+UOxe4RcjWd7HIKRplIi334wNz9GJzjBe/HXsFqqzBZ
XgmsCpboza+ktssFXdRy4Cut8sJ6mdjmwc6WlmTbf/+EsVnUfbM=
=lpmU
-----END PGP SIGNATURE-----

--jm9zS6OyTE66AFUe--
