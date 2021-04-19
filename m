Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8FDC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE166101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 12:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhDSMbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 08:31:44 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:40195 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239148AbhDSMbn (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 08:31:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A3C2CD44;
        Mon, 19 Apr 2021 08:31:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 08:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4LDCoSQTOENUTUigRwaTsYxrgZ6
        0FiDZK3t+3MTSdd8=; b=Kbz50DDIc+4qvGtouaIundrtjNMFeCz/l4oMPFiOanB
        oFoI5AsuTIyJCn3UatRtkHWjaOq6xM3u7TBY+WCeEsJ8KXeIpv05LTmSNf91NFRN
        ES5iR5M88b+paWULdt8e88oiehsEeV3opOpKKfz1TBGW/o25RioHtZEWEDIfrUYs
        WL7D7NHFmBpdeSREHhq7KuqHGom4BKvVAVkauUXDMzwdhUF32Ii4tb4SEDqPb82f
        +O8s/IIg8VBe3z1pv2dRxMJL+KaF9R2xucydpC8khWZFEjgPgakgWDrKfyJRcpBQ
        EhnXjplKcfFP8KThyEj5EQADGghnI46IWWOCj47NJDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=4LDCoS
        QTOENUTUigRwaTsYxrgZ60FiDZK3t+3MTSdd8=; b=BDTWWUHaVVaBNmgZGCZD4H
        pzO9LNbRaqHTZIXA59PajLb7RBw4Ab9ekvBi+syUoVLIpGaXFpBOJsOC6fVVara/
        hwLzcoSx46U/+nfFNJglz7vEO7GjFrTNrg5POEHCvCYTlFULIYvSvZZbQBpMEhxg
        cNLZF4hvRBpEUhIZZPtNcqts19BxaUTMDxGlTFArXSyp46LWDFCSuAuRRH8pzkmR
        Lce/Rx5M4H811oE9RjBvq8PSrOYoriBoOd1SMbOM+J6N+Lz1fR8/W0wbG7eRNKuo
        dFF2NYb7POLeyqmhqvNkaUZwy4sxq4xt3AHW8LAppYjf18dGs0T6Z10ih+B/0Jdg
        ==
X-ME-Sender: <xms:EHh9YKyhCbl0uwMMvImQ0demlCYSnZtKf-EjS84-8YYxWpaKYLX-5w>
    <xme:EHh9YGR64Oqaji0w5xXV3aqHh241StWm2T1_jGhMzejXPJ5mlguvdZfdX3PbViCdZ
    p9tZhZ4cjXTYpgBjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:EHh9YMVMGjOaVL5Iq3auZlizdnmucd4ZJJuDBK_o4ZlKw6aR7ywQZg>
    <xmx:EHh9YAgaq0NqOlU5smgbbyGBkycmPpIjnp_PirSIUtvLK9-KUv2Zbg>
    <xmx:EHh9YMAJ4bRichwykv_0Z1sMHI5gDPKlKcEHAwJOPjZ_RE-Uze902A>
    <xmx:EHh9YPM4rfQa9Va0EHqxMpdq41tXKnnuqzx8G51q5cOjKbyYr1rEcw>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5BEDA24005C;
        Mon, 19 Apr 2021 08:31:11 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a4bb3c44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 12:31:09 +0000 (UTC)
Date:   Mon, 19 Apr 2021 14:31:08 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v5 1/3] config: rename `git_etc_config()`
Message-ID: <1e8899408a249abd3743b2728434352fba701430.1618835148.git.ps@pks.im>
References: <cover.1618297711.git.ps@pks.im>
 <cover.1618835148.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/NLu8164yaJqVlAH"
Content-Disposition: inline
In-Reply-To: <cover.1618835148.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/NLu8164yaJqVlAH
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
index 870d9534de..e62960b5a6 100644
--- a/config.c
+++ b/config.c
@@ -1830,12 +1830,9 @@ static int git_config_from_blob_ref(config_fn_t fn,
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
@@ -1869,6 +1866,7 @@ static int do_git_config_sequence(const struct config=
_options *opts,
 				  config_fn_t fn, void *data)
 {
 	int ret =3D 0;
+	char *system_config =3D git_system_config();
 	char *xdg_config =3D xdg_config_home("config");
 	char *user_config =3D expand_user_path("~/.gitconfig", 0);
 	char *repo_config;
@@ -1882,11 +1880,10 @@ static int do_git_config_sequence(const struct conf=
ig_options *opts,
 		repo_config =3D NULL;
=20
 	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
-						  opts->system_gently ?
-						  ACCESS_EACCES_OK : 0))
-		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
-					    data);
+	if (git_config_system() && system_config &&
+	    !access_or_die(system_config, R_OK,
+			   opts->system_gently ? ACCESS_EACCES_OK : 0))
+		ret +=3D git_config_from_file(fn, system_config, data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
 	if (xdg_config && !access_or_die(xdg_config, R_OK, ACCESS_EACCES_OK))
@@ -1913,6 +1910,7 @@ static int do_git_config_sequence(const struct config=
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


--/NLu8164yaJqVlAH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9eAsACgkQVbJhu7ck
PpQjLg//bQyA6Eco65UhCQ25xpVvKl83tOvHjSC8UQoGcL/dYN1z0C8UpsjTNxHs
JXIAoPWnzDS8nCrWrsr/LQRz2h49GD/HBmhd5ALMCx84H3k2WbcLoGRnDHb821Gp
eq2UYnMs1esolJFjd5B/f3OMcbc8RoOYuSvZtFzB/S3yFf1Se9jnE0Y9QKnm2E9W
ROqNpbWcCAbLBOvQT/Lm+eTr1CvUDQXlXIYTy0EYLViiI+HrSzZwjZ8w6zg14djm
JX0+52EE2w1jZkH+5JCiYqXsgcGnitvT1Ju8lXC0ytHM9EWPaPTJubdRVIvnAWdz
FBZadH1H0nl4OzBmkXqiWIvkAIArFtaioxqfiFMeKeTK6r26twtkcCDJS6z8Iy8P
lgZnQhgF7pVlBxnE+PUKk8u9Vfp8XPxpwd1KVX/HfRWY8G3oSoFI7KLukEmTGfNA
NflhYA1DRl/LSwSQ2aOs2txgleu1+3rS+MKO1QVwq4QgrHgkb/rctrnpYJMs/J/8
Vh93b7EkxLh3ptTGW3aj354O5vYPGG4bowUz6b/Em1jcXlhGoq4t3k/bnOeknuP9
RBZX0LflkbhVJg63qTmdRs/W3YbhGllpct6ALP2/JbtGmVFIQc8HuzgSbrcFqAdb
eUg6e282mYOv/gqgoYCOXySrIJKYRCpv3WP0jP3KnVU5TAUc90Y=
=ZKrq
-----END PGP SIGNATURE-----

--/NLu8164yaJqVlAH--
