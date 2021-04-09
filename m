Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACCCC43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FCE610D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbhDINnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:43:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46703 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233784AbhDINnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 09:43:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 221045C00B5;
        Fri,  9 Apr 2021 09:43:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Apr 2021 09:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=HuQXxss9Mwae18r/WxIrG9zOroT
        5E4HVShjgnBrcC5s=; b=U/haWJJzfZHZwznt6+eyapNKSLR1/UIp0MBCCXYjC7+
        VV62+A0h1vvE9FugIx/wqJGHwKGaK3eVWlURSeREBh/ucMbAd1OLYOlTzXf2Xa3W
        qu7QiQ84Xkv1STZ3jCAflOrZG1smYsuWOK4HlljgfuFEOinkUmp62GKpjGrMRjoO
        hbpGqza6CCvseb4lONjw3CWULnr8csOM6e6ZYRvWqxE9d1OXRB/ZdZ/JErdZ5BH2
        yQdQL9xLpG/b1ga8y0mZdgXtaGhEcvMpX55eQxlC30luD+USPSf62PVzzi2urip3
        YzJ8QVYcBiDjWJwxvV+zQVCAMqdeSF/c3gK/z1ZmOmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HuQXxs
        s9Mwae18r/WxIrG9zOroT5E4HVShjgnBrcC5s=; b=rLU4cu4/Fq8qdRM0q4fe7d
        qKhut/pq1a3FB2A2wTC5RryuzgRVP+XYV1GJ9q0ogCQDuWOGBUDVQdfDQTIFR/uF
        tI7TRWDKIYpvC1OECBuvdksZE8l/NzF90/UatKTS7N0ud126BWHlIGkitQ51fjhI
        xdFDW8ai6tCFqA3Q8GJO6RsGdv3J/yJPCOtuNCrIPeEU/lJWKd3dW0EY368lsSsW
        goYcCGoRfUE33zqnRerDV6nun3h7vvyDdY+fYdOGecT4fhwoaTDvjaq0OOuV9UlZ
        7ArVTk4SWtL9JOzxB3ohLOM2BN8bWnyj/gPegleFYJbPwrzEUYLz6eNLgFul09xQ
        ==
X-ME-Sender: <xms:AFpwYETGN4NonmjtINo9-yVwFkR_SgjaoCz8EUAYZUxpIaOjtLQTIQ>
    <xme:AFpwYGFuKFeu7T5Te3H97FLyWhDQW_UCxCozy3WfGTWp7R8LqMZVK7wFccDX7nluW
    EgeRS_lJRSNb-KceQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:AFpwYA_YYipJB37GnBOnx2hUJBPVu5wYCqLPWICxObLPe67VAGE57A>
    <xmx:AFpwYAJw2bvFB5we69lU7O9XPyS9muJTS-_Afzac9FTkXT0CL0mByA>
    <xmx:AFpwYDaFjIiVCs0i44eFyrCfMNHDWKtWZ-9eEF07HAeVxOQbEqxEmg>
    <xmx:AFpwYFmHALsiEpx-zOLVcy329hnhlSUK-q9MEvn8csgYuDdymTqCXA>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5EA22240067;
        Fri,  9 Apr 2021 09:43:27 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e88e3d29 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 13:43:27 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:43:25 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 2/3] config: unify code paths to get global config paths
Message-ID: <dddc85bcf54e9b19f1612cf2a5be928dcb2bad7d.1617975637.git.ps@pks.im>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8XSwNFrW0pzryg9P"
Content-Disposition: inline
In-Reply-To: <cover.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8XSwNFrW0pzryg9P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There's two callsites which assemble global config paths, once in the
config loading code and once in the git-config(1) builtin. We're about
to implement a way to override global config paths via an environment
variable which would require us to adjust both sites.

Unify both code paths into a single `git_global_config()` function which
returns both paths for `~/.gitconfig` and the XDG config file. This will
make the subsequent patch which introduces the new envvar easier to
implement.

No functional changes are expected from this patch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c |  6 ++----
 config.c         | 20 ++++++++++++++++----
 config.h         |  1 +
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 02ed0b3fe7..604a0973a5 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -671,9 +671,9 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 	}
=20
 	if (use_global_config) {
-		char *user_config =3D expand_user_path("~/.gitconfig", 0);
-		char *xdg_config =3D xdg_config_home("config");
+		const char *user_config, *xdg_config;
=20
+		git_global_config(&user_config, &xdg_config);
 		if (!user_config)
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
@@ -688,10 +688,8 @@ int cmd_config(int argc, const char **argv, const char=
 *prefix)
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
 			given_config_source.file =3D xdg_config;
-			free(user_config);
 		} else {
 			given_config_source.file =3D user_config;
-			free(xdg_config);
 		}
 	}
 	else if (use_system_config) {
diff --git a/config.c b/config.c
index c552ab4ad9..6af0244085 100644
--- a/config.c
+++ b/config.c
@@ -1852,6 +1852,19 @@ const char *git_system_config(void)
 	return system_wide;
 }
=20
+void git_global_config(const char **user, const char **xdg)
+{
+	static const char *user_config, *xdg_config;
+
+	if (!user_config) {
+		user_config =3D expand_user_path("~/.gitconfig", 0);
+		xdg_config =3D xdg_config_home("config");
+	}
+
+	*user =3D user_config;
+	*xdg =3D xdg_config;
+}
+
 /*
  * Parse environment variable 'k' as a boolean (in various
  * possible spellings); if missing, use the default value 'def'.
@@ -1883,9 +1896,8 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret =3D 0;
-	char *xdg_config =3D xdg_config_home("config");
-	char *user_config =3D expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
+	const char *user_config, *xdg_config;
 	enum config_scope prev_parsing_scope =3D current_parsing_scope;
=20
 	if (opts->commondir)
@@ -1903,6 +1915,8 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 					    data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
+	git_global_config(&user_config, &xdg_config);
+
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret +=3D git_config_from_file(fn, xdg_config, data);
=20
@@ -1927,8 +1941,6 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 		die(_("unable to parse command-line config"));
=20
 	current_parsing_scope =3D prev_parsing_scope;
-	free(xdg_config);
-	free(user_config);
 	free(repo_config);
 	return ret;
 }
diff --git a/config.h b/config.h
index 8e8376ae19..53a782e0f5 100644
--- a/config.h
+++ b/config.h
@@ -327,6 +327,7 @@ int config_error_nonbool(const char *);
 #endif
=20
 const char *git_system_config(void);
+void git_global_config(const char **user, const char **xdg);
=20
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
=20
--=20
2.31.1


--8XSwNFrW0pzryg9P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwWf0ACgkQVbJhu7ck
PpR8hA/8CawdxWEew+ql9tG8aQ6STCtNjOQpyyRxVqSRUeSBO3VAqK41KnheBY/Y
Q/2tlxfcHMxWs0vm6/hy/b2UDe8RZUc7Aa3TfPmrUCizdZExuT2Td09w0a+bNSvs
mRgsfN0gAoj1XVKvcksO/VxnzSPWkyUltELSx4fSvXkBygFMTUmTi3ce036o/7wi
OGGGD43WaWzNQroAv30T1REr4KokQfiy4h5/xQic+7Ag7nncKzPv3xt0C7kLKYqr
285J/ZqivGt9lgrdoeLm+yam7mhy+SManwN0Jg9Z8jgr8/Zu6llFB1l3XvmWDT5S
xnMkad+Wwqrv5DZb8O5HpgJX51o7bmmgg3KoBt4ts9ZUxozjG4CkhFy7aJznxbeU
CyhzIUdZR2yD6tFvEVK12iIwOTgepJcI5DAJgTJfim1FUPuY+utKj+wzThs6V2TW
IWgD80o5gqZeMrIRP1frKUPxMj+1jm0kQ1Pff2v5RD+R3XqHoxbySkPLDypE5ZzF
KGuKW11kH9elGpKFf79cPxxV2K84U+o2+Ej+oUkwVFANUklRQ/i8oNRKvrr043OV
ZtLUt3t1b4YUCljLhMlxoPO5JoGrXip3a1ZehESXxuYhPEu+DrT4CCM98hf4c23x
JahSH/TMQa+oc/4Ari6nQKGbr/0LPaKRcK75Ho7+bL5O5zOYM8E=
=Lbp6
-----END PGP SIGNATURE-----

--8XSwNFrW0pzryg9P--
