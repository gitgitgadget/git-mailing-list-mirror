Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA5C43460
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9155C613B1
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 07:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhDMHMI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 03:12:08 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49603 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231223AbhDMHMH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 13 Apr 2021 03:12:07 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B36095C00AC;
        Tue, 13 Apr 2021 03:11:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 13 Apr 2021 03:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=yCaWi49rK7WJqDD2hSk5PZ09lFv
        MrJjfTHV04OGMfwA=; b=ytQkOkJBL4Nf6JWIZSLZqjbS4pploOhdCr/mHwZnNm+
        Hq47BiBAjRWA6FF6LwrUIUkNQYohD2otqbmmjA+2wA/VIX5Xh/aiy97z4uW9gR2v
        UMFVZbl6ID4UCcFouy1iPcnD2kCIIv0QbgdBc6l0yHEQlyCM5HNfqGWpBkbMyhE6
        sn+UefV7ljdSpbl2j/0ayeEMpXFNzu40OEgpDcUuW8dZoq3zq/RzG5A29pItCUqd
        OwS5YlkZY91BiiWSmJJPL7NBKZIpBIR61Nvv5E0X1P5C1tGYMqBtL9KVrbjBzBqC
        rzo7Jmw5io5qdvysFOZ/0JfKwBVSnuGxgsRlJGM9yXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yCaWi4
        9rK7WJqDD2hSk5PZ09lFvMrJjfTHV04OGMfwA=; b=KRFTzKxmPWCLQCaC6Ei0LU
        8y3l+2zBVj8EYoqKlP9E3pukB8X2ki9PWziR2FilPGjuicQeUx6EO0uHm7GwHS7H
        PdaVzTF9q3+K+Hps5Ef5NB1/12wcOfNgHV1cOiOF0VhstXl9Spwzq8nK6DiUw1lV
        HwqDs2agcTpnpZpwlFxa0KqHd2FagWUxbjbnZBEQFlZwYXu74A8nqrHLJJr9O9JE
        c3gqTop9cTKP4XvEi+fqyj11nZxxyhVumTtLIoZbIcx2FQM4sPgdJco0IxLWRDeR
        mlWas+XCDuvEGh8cDJbf2hvkEsTQuNXTBSHctaEdvlhuQMFartl9ir/NkIrMe8YQ
        ==
X-ME-Sender: <xms:M0R1YCfvU4-qMBlzBzrAiYI5d5SOZ3zZ8L1Pytq6IgS6FitJfg6BaQ>
    <xme:M0R1YMP5gwH9Rttkk47aCefAqpuna6FF5TRSQJ6SFV_XjnfWAxKprtSiS1EpB7nbS
    JVPMNjRLvAl2eYtUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekkedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdefhedrvddufeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:M0R1YDjiuogtZHSCLWEE-lKT-IYhkC5pqCKXHoTkMeV4WNYk3R2kAA>
    <xmx:M0R1YP8NVH9Xjn83yaC-pt56SzYMPRK06_zFWQyDeDVU3BU-AOydVQ>
    <xmx:M0R1YOvTtAA_Whl6_xAdVzF770z6_a-s7z4DVZzJD2mjhxYDy324Aw>
    <xmx:M0R1YH5TsLl08w5xcYPFwn7pk_JS2LZ20rMvPL0C03W3hXYvI1AftA>
Received: from vm-mail.pks.im (dynamic-089-014-035-213.89.14.pool.telefonica.de [89.14.35.213])
        by mail.messagingengine.com (Postfix) with ESMTPA id 810821080063;
        Tue, 13 Apr 2021 03:11:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 67f4379b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Apr 2021 07:11:45 +0000 (UTC)
Date:   Tue, 13 Apr 2021 09:11:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 1/3] config: rename `git_etc_config()`
Message-ID: <34bdbc27d618d7467d2caf6844d8c06bdcb8545b.1618297711.git.ps@pks.im>
References: <cover.1618238567.git.ps@pks.im>
 <cover.1618297711.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sivkJA7debA+e9z2"
Content-Disposition: inline
In-Reply-To: <cover.1618297711.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sivkJA7debA+e9z2
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


--sivkJA7debA+e9z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB1RC8ACgkQVbJhu7ck
PpTuDw//SKdlJFCnJUsyPL6jQgKzM1ICTPoeYJOUR1HAxmjdTbEGxgAGl6oBg4VO
rfVP7wUOukhDRv/I4DNJEpPdv3Fp7Pw4DFGxh0kmPWhmqw4f9Xcmc4qDlq46HQ1R
Yb04XGtbaVhLuO1k+QNC9cZqBouKYMhpWJHW8ULoypIZG0Rc4OatM1G357OBVupH
ONBEk2747zeDABeRKP38ffkGIDdpKmLChNeqlbMK+TdcW0f3tA5DfAgZRSm+vN7u
jo3uSfqG0g0kuJIfyJOKNeygSB9q2TmuVFV+2HlD420d/G2qH4kl2zZqy2SMFheQ
d5muatyrssn2zCLdjAoCiyul73mlmNUHCpo8/aTvlbrA0nOBIG2mAyz8BExVYPuR
KfoENU3mROzteGpLm7dOnYwRXErqg2GQGFE4QEwKQuOKi8AmT/jujpaRdZBSnOdw
UWbfigrXOvfRq05Ii83fRElFzfrpq6K/9YQ/LjjyhyuF2QeTd0WGqiSii3lWWQYf
LFn6ajA1hxBQdLjWEo8ZChRtEuLlvCcxkEvAiv++CfyimOAH0HYUeejgNH/uVxEp
RftSIjw5K1tPTAGPRpXgdppQGsfy0zJqvx8W0QBgppCf3HtZzfAEcjQg07jdgZFG
Ct45fMlOb6vIEHB78qgAEsmgpxjc7aszoFAlQcAFow+nCYkLWpc=
=ZDP6
-----END PGP SIGNATURE-----

--sivkJA7debA+e9z2--
