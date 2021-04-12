Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D2C43462
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C012A6135A
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 14:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhDLOrM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 10:47:12 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:58689 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242439AbhDLOrL (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 12 Apr 2021 10:47:11 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2FECB17AD;
        Mon, 12 Apr 2021 10:46:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Apr 2021 10:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=esXFnW26KkdAsYxobvs3tHJkdld
        f+sbO6+xRblzyDZ0=; b=J6yl0WLZtZGiTefsH3mSCv3NWrFzVUGKDCY0HbF6WlV
        GZmDiWTAeoVaB4a77SsfRZTQFE3EtisGrPQoSgWTO4GTZhwTrNGq/kuS1xcRlB6B
        X8bWnThmoE9iSdOEbOGkCEAv3+Xhiz977vQH/8hEQnERxJxIZxItNKg3O1ncyXlz
        uSAtjsuRxK0AcBB+HGkeuGhHoVfBaWm/CBxzbXAHyaferePO+V1WY8RVTTx12mGG
        cA0ZQuRYKDMrNXh9EhB10aKdm+i0lMRNe2ArGfSDA4ErE4N0YWBPyfF8XfeHDwGT
        PRD38HEy2fh+/gqltSN9nPV0gjsmp6PYFciXns/jT/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=esXFnW
        26KkdAsYxobvs3tHJkdldf+sbO6+xRblzyDZ0=; b=RJAykQhI6YFAxMocEt7XpH
        Ij/W9y1PoYr3TkbusvOvIiBd7Le6gprZOoiOe0x1VeipXbDFhU9SdDMYpRKIvtqm
        wxL6PLxk/kNaFR+iMOYCVfKV+767LYPU1clsKpRGXR6gCQtjyw6ciPoKvnhbda+g
        auiTyJRyCmzxsEQdgoOdjL0IyqG2KebT0eGaVsPwYdHYqoJD+q1qB1u9T2InD+tG
        ATBYoghhF1A0bXNO9iztcxAytvRwVLrDjF38O4D3ZbW3yJM+wB5mjkFzyyuwfOwM
        aKkJEZOhm2S+PtG54vjAqX35nloF10U9mf5Rss9N34iIVSY7NS/INOwgsPf5lscQ
        ==
X-ME-Sender: <xms:XF10YGJRmk2mCus3yXHNySFW_cDnXx3augB2u9eODbjyj5j6Wnspww>
    <xme:XF10YOLOIPo-jjfKGBikHXsh0IRPrLfDKe3YBxk9741eXgDkvY8oib537W5pedP6C
    ceICJCfo0C5CbM_rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekjedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedrfeehrdeftdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XF10YGt6j6VbRnne2_TV4uTFNFZEKv1lfkjcaLviGlQhkUyYjUjbuA>
    <xmx:XF10YLatmk9j0D9xtgPEbxQAS0iyjJVPZMDuI_G5ewJt_OEXWH44Zw>
    <xmx:XF10YNY--RAljwzrORf_SA6hVmGPPs01xLIKcY0NwgH2Wn02kvqEkA>
    <xmx:XF10YMkQ4bmSVJw0SA2h7LLiOot1KGW8mwPWEWe1TaOAYL4Y18K5gQ>
Received: from vm-mail.pks.im (dynamic-078-055-035-030.78.55.pool.telefonica.de [78.55.35.30])
        by mail.messagingengine.com (Postfix) with ESMTPA id D64C524005B;
        Mon, 12 Apr 2021 10:46:51 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 0429a9c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 12 Apr 2021 14:46:51 +0000 (UTC)
Date:   Mon, 12 Apr 2021 16:46:49 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 2/3] config: unify code paths to get global config paths
Message-ID: <30f18679bd5b5afb581506b95f76871124be5126.1618238567.git.ps@pks.im>
References: <cover.1617975637.git.ps@pks.im>
 <cover.1618238567.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="68rcN9OiwjQ7k9r1"
Content-Disposition: inline
In-Reply-To: <cover.1618238567.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--68rcN9OiwjQ7k9r1
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


--68rcN9OiwjQ7k9r1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB0XVkACgkQVbJhu7ck
PpTbcA//Zo/K/o+CJ0LH5ZMM/q+sjfd3p+XuFVNFBfMXug8FKMusPTJJR75XQpnO
rH/bo40Cy1P+ELqlatkpx6a2pJE8PkFzZAlxBiV7zotvwLSaK+btdcHX/DFR+UUk
tgT8AyFCeBOpKiESRWAx30YcMfzBoDUSRWPfNS8SF5kZtl28M4SldKve0X8ExFPw
z8GEGXAeQiF/JEh34RwiBkGors7RzJtPaheWXxDfk8EFCDaRO+L0Nq5ThS/Pv6aw
hRHRRmGeiWunMWw9a/hGGGEwzUM3P2R0rW+KB7RXVIpe83wUpXtcYUR/j+7seujE
69dcI4xQrF8vUoQgUjOyoXT/XK9JykxrQ62av4MHRapyeO/+nYz2VRetTviQ8XBM
hPnvm87iTcJedbBT6iZGMJvD2pGah+EgPtHJGaD6qJzsix30Rp82S6LSbUYxXWED
hPKQ8dbV/lB0/z+M7l75onR5/dARv2fQahv73qtSlZdF2itcDBZ621uyB7SEGoWr
B8T45O5bWN3v32XQjo4Rv2HNeCRwNQrnsNwvz3x2j3mB2bmm6Bc1TmQTv1RLMSDB
QpGxLjuLd5ideuXno7Mqe2yM9+mW/4Nw/qYOlKte1sOOVhabtsjp3Qk5LzNgNRh+
MJioSF+LvClxildeQHjb1vXQQudii2zkUuIEmfRh5+wf1ZtMPM0=
=iT43
-----END PGP SIGNATURE-----

--68rcN9OiwjQ7k9r1--
