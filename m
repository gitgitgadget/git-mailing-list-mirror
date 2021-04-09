Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E369C43461
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 333AC610D1
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbhDINnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:43:42 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51323 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233734AbhDINnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 09:43:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DE4AF5C00A8;
        Fri,  9 Apr 2021 09:43:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Apr 2021 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sqZfY6zP54LdSHfMdBstCPdC7a1
        f8Q4xPhQeZXvxQx0=; b=g33iKOMLHXar3TbTsrdP5uwtdPYQJu5VWdNULH9kcdH
        tmb1c8n0K2YYQv+cMcDBRkGqXHt1h/uCtluPCg2ZCqYhZZdbiWTZEPaF3rv54z7r
        I4LZ89o9NhlWZeCW0zhl97mJj91RcuLORlODGw8v5o0PJYYLDgXfNwu6NaceGU7f
        yRZTl5NrcbRleeBjuyUQyLYWGIJW/VsUOdawebGpocLbxZzXPjIBD0igkARf8IsX
        A18cCFOvNABIcrc/95ul5kYmUh0Lx6AHFFYBAh+Oj8xjNwzAva05sBfh8mIUJqwF
        kfdEUY9CwP6FXPR2U0GxLiokEVs6CA37ATASDUUoRng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sqZfY6
        zP54LdSHfMdBstCPdC7a1f8Q4xPhQeZXvxQx0=; b=BvLUe5h7a9kk9SG2GJgMwZ
        +j2Pq2lUKeLcMCpRPIU3iIpLp+8zAttCrsZqt9EB9Y+GvWDywxHfmEVHnSeLSbld
        qNJaE2EgppXYtPZpaQw8Mi6ugnhkLtpC9ejpsivQ4mWBndPwosa3BdIEMQm2iWSx
        2zHBexheWBKOvCST/gIYYQntCSlAFLdNQ5Gip3Lk13SgyNK/DWbNlPycbgNLcIsZ
        aRA1mE2pI/+N3jdIj1sI853+/KfFBhoH6OL3xSyyzOcfLMQapbr6w4F/JNTP96Q1
        N/nFotw2PyYBKwyGS+HFN5wknSsxWw/EvSIU4sLzfSoQwv8pF7IsUJHoM93xFvtw
        ==
X-ME-Sender: <xms:_1lwYCy6q7kLE0E73Xw4LFCU7jZKlUPkkOD-up4Z4mD9Z3cN8asC5Q>
    <xme:_1lwYAQ4FJz8h7nep7Az7vrm0x0ZQs-vmpYtl-oS5rq7dUGOws5Tc0KZq-Ac5UnGe
    SRMSgRNcW9FPEE9Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_1lwYNvyFCM697fdoqhAzNW373mDrLEPW8uXYXktfAlG-WjpX_anjw>
    <xmx:_1lwYKseJS-9frMrADCUzW7kusaGIjlsEr1RnlTjmkiVb7FnK5PamQ>
    <xmx:_1lwYLydqr3oj96e7hbso38qyOOnrltIYrQ9WPe8tq6ytb9uGIlxkg>
    <xmx:_1lwYPdKyoLFrUz-MLNzb5ANbSiDILECxeRaGTUxA5BMig9pWnH1Pw>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 275D6240057;
        Fri,  9 Apr 2021 09:43:27 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 8eff4ef9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 13:43:22 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:43:21 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 1/3] config: rename `git_etc_config()`
Message-ID: <da0b8ce6f02d9d182446671cc06b9ee1cda77785.1617975637.git.ps@pks.im>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
 <cover.1617975637.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OeX8lt7rOY0pR+t/"
Content-Disposition: inline
In-Reply-To: <cover.1617975637.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OeX8lt7rOY0pR+t/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_etc_gitconfig()` function retrieves the system-level path of
the configuration file. We're about to introduce a way to override it
via an environment variable, at which point the name of this function
would start to become misleading.

Rename the function to `git_system_config()` as a preparatory step.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 2 +-
 config.c         | 6 +++---
 config.h         | 3 ++-
 3 files changed, 6 insertions(+), 5 deletions(-)

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
index 6428393a41..c552ab4ad9 100644
--- a/config.c
+++ b/config.c
@@ -1844,7 +1844,7 @@ static int git_config_from_blob_ref(config_fn_t fn,
 	return git_config_from_blob_oid(fn, name, &oid, data);
 }
=20
-const char *git_etc_gitconfig(void)
+const char *git_system_config(void)
 {
 	static const char *system_wide;
 	if (!system_wide)
@@ -1896,10 +1896,10 @@ static int do_git_config_sequence(const struct conf=
ig_options *opts,
 		repo_config =3D NULL;
=20
 	current_parsing_scope =3D CONFIG_SCOPE_SYSTEM;
-	if (git_config_system() && !access_or_die(git_etc_gitconfig(), R_OK,
+	if (git_config_system() && !access_or_die(git_system_config(), R_OK,
 						  opts->system_gently ?
 						  ACCESS_EACCES_OK : 0))
-		ret +=3D git_config_from_file(fn, git_etc_gitconfig(),
+		ret +=3D git_config_from_file(fn, git_system_config(),
 					    data);
=20
 	current_parsing_scope =3D CONFIG_SCOPE_GLOBAL;
diff --git a/config.h b/config.h
index 19a9adbaa9..8e8376ae19 100644
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
+const char *git_system_config(void);
+
 int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
=20
 enum config_scope current_config_scope(void);
--=20
2.31.1


--OeX8lt7rOY0pR+t/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwWfgACgkQVbJhu7ck
PpRCRRAAoVOBZFeAfkcd5Xg8xDYuZcJ3gyDTjFVcgrI64k5QKd4owgq0+lB1C39s
cdQkveaF2lQfvc5iR+GnDdl6Z5oJdwqOLLnEzV/Zakwg+1B5fZQu/GyEfeUcuua6
HMV6bBSCKFTZqHPNb2MbucLEpFMS2zJ/oAQthRHlzxeOOmDdqgRoQAnUMSqO9sTy
qc5VTmcYlhc86eBf+vYel9eSyK1xmoJnmXwWtboeXkstIUa3m2o5ceygWz+kWFUQ
kFR7fFEEZiSUYxThYIeRnT9HMkevEDXkaiJ53MqJwqurz0eMl/VWmELjmoUVJlCF
1l9v8Z75elcB6bczeTpB51OiWQJRB3FeUMkFDAG9geBP6H56HDZoxK45Qjq7/1h6
5N7JZokY7/Wy+tVMazSi1Lz+uZkXHOvQKVJ9UTn5waWaGV51xq9uW2jMzYJ344Hc
19QdIffM/441kXO0+AtA5HVlo26JP3V08dDraE9U8sn3avSbBulfmGey1CNvbPud
r9L+Wnqs5R0AOTVZJ2J9tDqA7NQYd9SsirZbrR5RVo4/6YQfbiqr1SH/I94LFRp4
+rdoLwYGkrQaXLEm52bYJxAlztAiakn/4DP+PozndJuu1yItasq4a6HEoEW5kVBP
2DS1R27vcr4vlcN65UCh096xoNV+GnzVaPNpskNfgIyTdq38Adk=
=1osp
-----END PGP SIGNATURE-----

--OeX8lt7rOY0pR+t/--
