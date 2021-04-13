Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B940C43461
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E58613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhDMHMK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:12:10 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53833 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhDMHMJ (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 03:12:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 911705C0102;
        Tue, 13 Apr 2021 03:11:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 03:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=qeLMnBMKGKaw2Uss9hskEdUFaTM
        rgqNGtnBXjCtLBWM=; b=P1FlDIIoqZv2qA/hEqgsjpy0eoGEXYk3nhT52cbNl6B
        Glx34Izt3NN2XfIGr0GcdjSoIE0Hv/06Cpst+zyG4mLk+vO0LbgEq8Z4dYchtsVy
        bM/Wfw/29Ax2xRAopLytYMQZ/jdukY6KuKahXtkMgN/vrZU3F9d6uIzb0CQEpthz
        a0pkH/jlMVfvpPhRGMkX+PUnePhFwT0lIe2sVwL4MkQEa+l8bkNstaRvTDrzmKRu
        tWVvS+sWEUwMDRoCFDDnzZ4I9oQDu73cy/YfQPGOlHOuxhrt3ULzTpyIzxmEOdGK
        xijiNXwODkOd3u0zuAp2mzw2CaqRY8ZTDqTXq6sb+gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=qeLMnB
        MKGKaw2Uss9hskEdUFaTMrgqNGtnBXjCtLBWM=; b=Or1t3XxJaT7S/37eHrs4g+
        nCnaAgD1VH/ZLuxt/Yb7X+khjejJFcEMVU2gu9KQ/JxIoQ+54gRQrX54Pe/VfVrl
        6MFhbybYnc/OzIM4Zjp7zyLUC9lzVpkPTP8i5U50iV4Iwq68iV1AS7Vebcz4i4a5
        SVFvyy6s8EabfA450bxR7x/6mT2pXx9jpqUKbIINp4WBHPOel6EJLeBdkHhAO3Bu
        Yv6zeOpJZNZgW94mSlklQGxOQQA2FL7hDtw5MwEh1URKOB4i8yKh2n7IxdHKLtrw
        SJCtrRFHCNQMP/mbPlqq2tZaTMyK3w5WzV0WBYMmmWsXzYqcwilmox9Vn1HI9pRA
        ==
X-ME-Sender: <xms:NkR1YERRpLwek-Xm7MAD24d7z_vhxodkYpNciq3Xplw5TexOVeeGxQ>
    <xme:NkR1YBszHz7RyFA6LHjBZdBJSBzNVOm_57tSGA6iLqBWGRbbzDGr5nLT0pfK4pajK
    f-6LJ0gWgaNvf8nHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdefhedrvddufeenucevlhhushhtvghrufhiiigvpedvnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NkR1YOv5O6MrCZ-t3cH445vpkLbZqAkHg9mprU9WXTm5d2mIX4RqpA>
    <xmx:NkR1YPx3YVN2kYu0owfiTzjwTaDoqNcfkuC-y5CGERGKDZD3p4nJvA>
    <xmx:NkR1YMiHm0VOwDeYmAt7Svs6SKJzAONdQS_bq4okxgqtHCiEFwx2vQ>
    <xmx:NkR1YMeyxsdGveQJNotQtPuB2aDvxQMq2QEYTQYhn5piOvGSl9tkyA>
Received: from vm-mail.pks.im (dynamic-089-014-035-213.89.14.pool.telefonica.de [89.14.35.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id C53D324005D;
        Tue, 13 Apr 2021 03:11:49 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id fceca94f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Apr 2021 07:11:49 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:11:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 2/3] config: unify code paths to get global config paths
Message-ID: <30f18679bd5b5afb581506b95f76871124be5126.1618297711.git.ps@pks.im>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pQFtqYObqSJHwxFk"
Content-Disposition: inline
In-Reply-To: <cover.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pQFtqYObqSJHwxFk
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
index 8c83669cce..ebff58aa57 100644
--- a/config.c
+++ b/config.c
@@ -1849,6 +1849,12 @@ char *git_system_config(void)
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
@@ -1881,8 +1887,8 @@ static int do_git_config_sequence(const struct config=
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
@@ -1900,6 +1906,8 @@ static int do_git_config_sequence(const struct config=
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


--pQFtqYObqSJHwxFk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB1RDMACgkQVbJhu7ck
PpSNRw//cGB//nA3K8MMoGq0jdsferIMX0X1cBcPh8Iz8Zf+sMS+mmAxCLSrBsxf
ZTtYzVd0rvB7T5HvAPAR/eZ58uJmKTeMAdPsCnp4ZrOjtuv0HwTGL3OBS5NKjXn9
Drto1G+v+qIxx9yFTQ3e/TLt3jqlKr9HAYynkHWTLeFmFp4zvGnBKdEbTSyNISb+
l961sBILm9gMbjdNf83dDbxJIUCH+uQprIP9CFCYlTOt61s4047yiQy/pmc7KoAu
/gOEI5D/X2dSa5KYO0Tggk0613ikPQMZcKDPLB9L0Syz88ZKnbw4nxKtYFauH4y/
S+Csb3CgTbWrtM1/5KRUlJQfny/0Yvh2gEqxwy6BFmLh/OOnEbf8QYsXJFLZewLV
c7Dz7Ls75I0h/nsKItQwfk29gVZ0IJmXQkn+WCz8SBRcBdDjCpVPu/9zonAI9k0W
W9OWorz8dpDag+SP1fbNyZpXDBLHS5FfM6VwLa4MUUD86pIISVnqq+4gYt6XKlaP
kbVz+D9HqXCH1ZZrn9EbIcLlkmM0/Mfz/mTMtadUiyB708jRVmX5lyI5ZiV7oTPY
NE3n6gzy730zn11ojKNkO2xegU1HmtjAdpIvvlqY5ZSKTm04K9e8eWDbGMIR/5s8
74cY1FTtDmpbfSd01VhAzgndR/Lv06uJ0WXQSIfD585IA+AdAys=
=zjth
-----END PGP SIGNATURE-----

--pQFtqYObqSJHwxFk--
