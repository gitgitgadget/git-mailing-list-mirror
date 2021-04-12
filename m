Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0006EC43461
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2E361355
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242464AbhDLOrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:47:08 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:42381 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242427AbhDLOrG (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 10:47:06 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 0C59717AD;
        Mon, 12 Apr 2021 10:46:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 12 Apr 2021 10:46:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=GSFjgsCC/gQ4WOMjWR2NrOtz8zR
        StZ+yFKURkfkfG40=; b=Lj1lM0Dk/Soy+3Kdq7SSMFB1tSfv/BKdT9QDNjivcy8
        /Rs4iJ8xiiJkXHxnGXGnr0fK8LFCkvuzOEIFLu7GwE2DFNj2oeth5KTYS88PqbTC
        piioK+0TKVJ9iShpBC+NeZ15q1pku+yynO9Jwk9kDIB6UJfnEbbX9jHnZQQTvRbf
        NVSqbjrZ3IcZ2PNwZb8q0uu+5OptD5cAJEPPNdUiWBRhz17ezRRC9pqzRDMOfcw3
        eNPw5XFci3CwruXcXqL95XHEftCYcKEpswNTvM5htoQNLup7awvRGywkqNgzezUy
        wCN77/LI9aXQS9XNbXLxyt1LtQysL+0+Cj+ehVO1S0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=GSFjgs
        CC/gQ4WOMjWR2NrOtz8zRStZ+yFKURkfkfG40=; b=S83wadIXQMnOmWPAumPkvx
        ED/OYVcsFel67wXa6nJga3VUarDeGoSb5W5PtCrK6pMrwgSCq9s9dg+/Z19NC7yV
        FGUOB5+nD2Rx8GpWcM6OPyIm5OsRT0sexIa6uzsffGqxNDrG39ECfGPMFLDSjzPT
        E8UNnWbTl2evXkQiXERngUOgOOtfi/Sir7ZwzyYVie6YOfpoon/YGuljIKNh2/XW
        WDYrYthF1yZb/2E+fHnfwK61mjmiBdzVUt2T2wOGRA07rh0P5YhjyXkENg7Eqppu
        7ubVcsN8Llhf6UIwXi2AOEKCDfWone8IEzRHmg2w08JCgK0bkHJAaT9iavj2O2yA
        ==
X-ME-Sender: <xms:V110YLWZ14rz--ZBijLPnEzjvTboGkb6GwYwVloscuFD1Ool7KWGOg>
    <xme:V110YPRIZ-5HrlPbNDwlEsgUL6NYBAcvRXy-FswAZg3B8U4cipqSlN0WKClNNXkA6
    KoKN8xTmj1VjVbn5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:V110YD1J6lZhZmV9VpIwrJHZ64g54DzGvnSguoLOaK-dkmEQIuPURQ>
    <xmx:V110YPfU50WY8b23d6sNom2OMyZ64eGNNYGhEF2vAK6k7ZQQMG_jxg>
    <xmx:V110YLMOwmtP3Pa1v1jYO02JY9kkTn8Tirq9W59k_kilYULCNRiw7A>
    <xmx:V110YBMi_gu3e-8luzBRZc7oKuJBpCZk6eR1knGyuiy8SjGbU4wcuw>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id E2E89240066;
        Mon, 12 Apr 2021 10:46:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dce45324 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 14:46:46 +0000 (UTC)
Date:   Mon, 12 Apr 2021 16:46:45 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/3] config: rename `git_etc_config()`
Message-ID: <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618238567.git.ps@pks.im>
References: <cover.1617975637.git.ps@pks.im>
 <cover.1618238567.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ak6XTDGV60iLql7s"
Content-Disposition: inline
In-Reply-To: <cover.1618238567.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ak6XTDGV60iLql7s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_etc_gitconfig()` function retrieves the system-level path of
the configuration file. We're about to introduce a way to override it
via an environment variable, at which point the name of this function
would start to become misleading.

Rename the function to `git_system_config()` as a preparatory step.
While at it, the function is also refactored to pass memory ownership to
the caller. This is done to better match semantics of
`git_global_config()`, which is going to be introduced in the next
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c |  2 +-
 config.c         | 18 ++++++++----------
 config.h         |  3 ++-
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index f71fa39b38..02ed0b3fe7 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -695,7 +695,7 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 		}
 	}
 	else if (use_system_config) {
-		given_config_source.file =3D git_etc_gitconfig();
+		given_config_source.file =3D git_system_config();
 		given_config_source.scope =3D CONFIG_SCOPE_SYSTEM;
 	} else if (use_local_config) {
 		given_config_source.file =3D git_pathdup("config");
diff --git a/config.c b/config.c
index 6428393a41..8c83669cce 100644
--- a/config.c
+++ b/config.c
@@ -1844,12 +1844,9 @@ static int git_config_from_blob_ref(config_fn_t fn,
 	return git_config_from_blob_oid(fn, name, &oid, data);
 }
=20
-const char *git_etc_gitconfig(void)
+char *git_system_config(void)
 {
-	static const char *system_wide;
-	if (!system_wide)
-		system_wide =3D system_path(ETC_GITCONFIG);
-	return system_wide;
+	return system_path(ETC_GITCONFIG);
 }
=20
 /*
@@ -1883,6 +1880,7 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret =3D 0;
+	char *system_config =3D git_system_config();
 	char *xdg_config =3D xdg_config_home("config");
 	char *user_config =3D expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
@@ -1896,11 +1894,10 @@ static int do_git_config_sequence(const struct conf=
ig_options *opts,
 		repo_config =3D NULL;
=20
 	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
-						  opts->system_gently ?
-						  ACCESS_EACCES_OK : 0))
-		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
-					    data);
+	if (system_config && !access_or_die(system_config, R_OK,
+					    opts->system_gently ?
+					    ACCESS_EACCES_OK : 0))
+		ret +=3D git_config_from_file(fn, system_config, data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
@@ -1927,6 +1924,7 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 		die(_("unable to parse command-line config"));
=20
 	current_parsing_scope =3D prev_parsing_scope;
+	free(system_config);
 	free(xdg_config);
 	free(user_config);
 	free(repo_config);
diff --git a/config.h b/config.h
index 19a9adbaa9..2be8fa1880 100644
--- a/config.h
+++ b/config.h
@@ -318,7 +318,6 @@ int git_config_rename_section(const char *, const char =
*);
 int git_config_rename_section_in_file(const char *, const char *, const ch=
ar *);
 int git_config_copy_section(const char *, const char *);
 int git_config_copy_section_in_file(const char *, const char *, const char=
 *);
-const char *git_etc_gitconfig(void);
 int git_env_bool(const char *, int);
 unsigned long git_env_ulong(const char *, unsigned long);
 int git_config_system(void);
@@ -327,6 +326,8 @@ int config_error_nonbool(const char *);
 #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
 #endif
=20
+char *git_system_config(void);
+
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
=20
 enum config_scope current_config_scope(void);
--=20
2.31.1


--Ak6XTDGV60iLql7s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0XVQACgkQVbJhu7ck
PpRiZg/+ICGJWXD4T7dB8bYm4bnDuxwyUoKZZ/9Y0RHw1recqQSbfhuKkQiiymBy
6Vb+moW19JhDzeKOK6cn6DmbsX+E+4UVk/xz5QJq8gzOTKq5u3TvujjqyxELNvfO
9F7w7tS7Gy0c2v6AD/9x9HN4CHedujqlc8K39svIqRmPA4hO2IGfSC7MnH4iE7Rg
PiyBvgKPfhoFC0Iid3hqzSrj9jHAvBuZSbRHx2s81UUUAMGVoEgSqahZcO6HlLx1
HuRkOxaHuDeio6Bt8S8AQUQZj9LOiIymd3JKixTEG+hO9/9v1PAy38uXWTYac/Fn
QC2Y6qKGgw+5GK/b54KaDcm9fvmRSmB/d8lbX5/Exw5puJE6crdEJkSbQDedcQW8
LSdaYaPT9VnJECeFFaRkm33bTUgqApkYRk4sm1i+d6nePG4FldFKjpZ7SUI5AN6C
7FHBKWdB8AbtjLDK76OdDmyDpWE0CfEmAhUx9QyK1jtp7Wu+c+i9pkc+83+52RFh
I1RYyxJZ4q6mumuxIRsGhVNy4d2+r7Myiyqng+1WBjWAKNHJtaatKE25pO64lJ01
myigPzV0+kAxCQENNEs9PUIDp4dLmtm1mZX+y9sceQsosyDwgOHka8vNONYTwbRq
Xh+3flxZE7uPgUjqo6KNgK0ShabwLBlObh9l6ZRorJDc11UbwWI=
=azkq
-----END PGP SIGNATURE-----

--Ak6XTDGV60iLql7s--
