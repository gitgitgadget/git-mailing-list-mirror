Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE3CC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 732D76128C
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239167AbhDSMbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:31:48 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:44547 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239157AbhDSMbr (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 08:31:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 5C237D58;
        Mon, 19 Apr 2021 08:31:17 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=VVKz9f89ZLEQDq0V65lSjfS0qLq
        aSstlo67QgL8RnGQ=; b=cGiCvRgq8v1lkIiGhzkq58mClp28JHt/q7+H/M6KHzW
        93PbSTlLuKGcO9aru5rPO1UoPfHvhVyjDUTH8EzrOWUHYQMbrGJJf/pU+u+ABCl2
        XHboOcaPIZ6kALsLUt+3TPXcGv1zyO1zYnOZY2UtMSHMGYxpHtQqhq+qmWuhBnuK
        NtprU8hP6w5PRFwxRE7ogaCOpZwczhfdKO8mUsBmCKduMIpqazXnsENA4Ap8xWCK
        aPxE0T+E5+xakqGMIerP8TMO5vgsPx+nN1IxSehQjcEgD0ib3H5r8gV6pNSMSMtt
        NUr+Vfm9dK60EsQ3NAJBjpBsqsSZ6ICo5TsNt8GIOqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VVKz9f
        89ZLEQDq0V65lSjfS0qLqaSstlo67QgL8RnGQ=; b=gKF1ZZ1Ghg41ATg7K+nHnd
        A4zMQDcLLelTYJRu8SOpUs4+q4zs/6oEiMGcJaKxpY/15hBHcgKIN11bE+cpjKHS
        XMfxlUIarkSZYYph2z0Bb+kKnnuwMmniwuIdlebVZGqmoA2QTtPZdwbHmuVi/fEc
        1+TCLV2papRklLcGSKgNEWaD/cz50axahrxSr77t8B1WahBLmHKkygC8QXKupO3J
        gZynP6KjTKwaLr8/eWkih4qd3nVVeAiR5mAqccqPWVCwAk0D7eOiCV7/GM0uGcWI
        tnyiTNp+ETImxBAbakbGip46roCKHTr2SUl5SD6Rq2a4jh4zvx6/xfIKT5+DfdvQ
        ==
X-ME-Sender: <xms:FHh9YF0Qq_ZPfGVR2REvXfEGl1KLz2pijW0qJKNIyqm1_dFbmFdYmg>
    <xme:FHh9YMGhO7uHde9PLtVW2s6SUwHRMYy3Rw5YbvJn98oUAEW4t5x1eDIIllfuXXKDv
    Qo6bE7xmThrQJALiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FHh9YF6dA79tlW9FimD1mJAj3PgX5u_fUJS-_6lfA5-JzouJP2pObw>
    <xmx:FHh9YC3hd2_OK4UJea41jh7TQG0IQYrgSW4I6OxG6gb60qVWU8F-YQ>
    <xmx:FHh9YIESGQKK4e90gRG4uN9yfZG9Qq9263E0MAE4PtOG3lFjeVhJAQ>
    <xmx:FXh9YMBRc9ohSfv9RxKAj8bg5Ylrr9IN_jb82wJoggU-3QLVsYGjsQ>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id C891D1080066;
        Mon, 19 Apr 2021 08:31:15 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0dc247c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 12:31:13 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:31:12 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 2/3] config: unify code paths to get global config paths
Message-ID: <39468f45d23ef2f993f53afdc3b3b67c38d76903.1618835148.git.ps@pks.im>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n85hZdhmvDwNCq1Z"
Content-Disposition: inline
In-Reply-To: <cover.1618835148.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--n85hZdhmvDwNCq1Z
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
 builtin/config.c |  4 ++--
 config.c         | 12 ++++++++++--
 config.h         |  1 +
 3 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 02ed0b3fe7..865fddd6ce 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -671,9 +671,9 @@ int cmd_config(int argc, const char **argv, const char =
*prefix)
 	}
=20
 	if (use_global_config) {
-		char *user_config =3D expand_user_path("~/.gitconfig", 0);
-		char *xdg_config =3D xdg_config_home("config");
+		char *user_config, *xdg_config;
=20
+		git_global_config(&user_config, &xdg_config);
 		if (!user_config)
 			/*
 			 * It is unknown if HOME/.gitconfig exists, so
diff --git a/config.c b/config.c
index e62960b5a6..161dfaa707 100644
--- a/config.c
+++ b/config.c
@@ -1835,6 +1835,12 @@ char *git_system_config(void)
 	return system_path(ETC_GITCONFIG);
 }
=20
+void git_global_config(char **user_config, char **xdg_config)
+{
+	*user_config =3D expand_user_path("~/.gitconfig", 0);
+	*xdg_config =3D xdg_config_home("config");
+}
+
 /*
  * Parse environment variable 'k' as a boolean (in various
  * possible spellings); if missing, use the default value 'def'.
@@ -1867,8 +1873,8 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 {
 	int ret =3D 0;
 	char *system_config =3D git_system_config();
-	char *xdg_config =3D xdg_config_home("config");
-	char *user_config =3D expand_user_path("~/.gitconfig", 0);
+	char *xdg_config =3D NULL;
+	char *user_config =3D NULL;
 	char *repo_config;
 	enum config_scope prev_parsing_scope =3D current_parsing_scope;
=20
@@ -1886,6 +1892,8 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 		ret +=3D git_config_from_file(fn, system_config, data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
+	git_global_config(&user_config, &xdg_config);
+
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
 		ret +=3D git_config_from_file(fn, xdg_config, data);
=20
diff --git a/config.h b/config.h
index 2be8fa1880..9038538ffd 100644
--- a/config.h
+++ b/config.h
@@ -327,6 +327,7 @@ int config_error_nonbool(const char *);
 #endif
=20
 char *git_system_config(void);
+void git_global_config(char **user, char **xdg);
=20
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
=20
--=20
2.31.1


--n85hZdhmvDwNCq1Z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9eA8ACgkQVbJhu7ck
PpTztQ/+KS9MjvDhNuLCWCCQsBQOaQQy2eLjbZARyzNt4tkWDJN3at315Sa6z0IX
AR1/L6gc6XdLCaBYOFwv2BnTCVf5gG6/+RUh3FrnnLp7HNdeh95Mf42FIVrgM9UB
JszrOZvdRDJc9b9o4XCs1o3GEWPfdA4oxhRm0IxVwl7W0BZ5tLw82GYqA6YjJqgM
pNgAez+VlVkF8jSls3A9pwLwwK3PY4NnRRwfI/g0U1Y9IdlENtPiOzag2xi55zPx
g/tGmEq2bzv8i7N/ENv4vox4Pahj6NuQURCDmHQeGjh70yNBmgnevFjUfrkxcLNU
C6wJ/oW7wxGERWJrzDh6oKuD2qaUcsNQa+6n2jkBpLHd75PvI6ng/JkmuuIGnYYZ
nYbK+EHyGrUMR53gq4/OLHZkH9smCFgzflk873Z2Co1LQIZWF25Hy15maH2KrhmT
6OzTBeNCn2yoDs9m6wF+lVIUYvExuktp7Lao8it6G4JLL70xZYJktqrPd6j8Xaji
gBPzqCwOse4SHHnOy6CAC002u7FLjlxe30Fr8UOKcuKmMVhA6v9IyQK2UzNS2q8b
Q55njBxrPyTy+0riaWI28+7LvU75yOv7zbJ4dMO5KAjzrOatbtPQhHzznJ89t87f
JiG4z2CFirXBryDaiqjUqvzv+PAfYI/NR58Ri0Wa0WyPwUOJaFo=
=Pjmw
-----END PGP SIGNATURE-----

--n85hZdhmvDwNCq1Z--
