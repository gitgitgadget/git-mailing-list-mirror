Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB649C7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjEQLtY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjEQLtR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:49:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D79655A6
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:49:16 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 84C0D32008FE
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:49:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 May 2023 07:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324155; x=1684410555; bh=WM
        qvXvXb3ZzAa4iyf4MkYprrXQSaVYKyp9cMuIm7n24=; b=JS8U2GeX/93a2Y3KXF
        7B/fc6b0eAvxaWVQqvsjTZ5rYHrtA9zHJlj7lWbShBmfibaDi5FbLQPsMPW8+pRT
        9seBV+uCQVt/C7vAXYoXXOsIYD84XyOeiXP28k2rgE4lcjodq89BbrTvLvSYdXXR
        3PvlJ/aK55eXEuak76c98DEM/txJN8HzjxZ6KnXuItUGdSiAGqk35Mo2165K8dIt
        Ebu80rbvdTe4wrTTLIEBW6l2Az5R1T2jLRxcGn6ncj93hEN23bR6RHMYbj/yH/6y
        2y6EKvANzMVnX7cuvCwMtxiciTrsMa+Lq58LL2unEk9WJy62UyiX2DKdvG9+TyTS
        3WeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324155; x=1684410555; bh=WMqvXvXb3ZzAa
        4iyf4MkYprrXQSaVYKyp9cMuIm7n24=; b=DhJ89AURj875dA50sI+xKMER5Dk2H
        /bMlAkGMHmq713P74t1b3mNgrkGnhjGmSblBAlnpHbJw0pcsI3ZTn0d2oMLuqsbd
        oK0Pra3PSLZ22JvxzrwkRKPlUC2SqPNGCsk6N3vP2SGSBF1wac2nmRhdRnClmcPb
        sqc5iNMh2biKy0rivYyj5Zowl8hUy4G7dDAr+YacuYQWwG99+lTDww14uK7ChSYb
        IrBjhpTIsHMft8imAZu4a8Pun2+OmCiTVwgqlMSB7Px+UKpfF0DladVL+OF2cx27
        UufG6i0mu3cdmj9ImcsCOMik28gyxCG606zfVARv/sGABnWeI8i5nYGqQ==
X-ME-Sender: <xms:O79kZEK6q3hBDzTE-W3XzlCHQwdAu5HKDGAxA-0-2HMVoavEwdhswg>
    <xme:O79kZEK2Q-POkkmRph38iixZXaABYPa2XbJ-3l3r-npBckuGGoZ6OM7i9eeH-FJpk
    fEUbJwVvJwy6y6Qrw>
X-ME-Received: <xmr:O79kZEs-zNEKUaF6dVXAL0Z01vVWJkYb_4uorZdI5_DAm6wradGR1iQT1rXye03USkuo3JB2KgV14cVAHf_fBpfWK84KH-vJ8L_Wh9iPxb3ippuv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:O79kZBZU9Y-4afttzNPLqxVeR7fFJBvTGZMjzQcD2aO4dRrMRcQnIg>
    <xmx:O79kZLZVjIkx5-9BN_Pr6-Xadapkq-BQIsjVyhFeUcNTwl1WHZITkw>
    <xmx:O79kZNCecP6iL9AN35C-d3btdRHP0QQTnpuGlF3VU1-dBBL7pSGDlQ>
    <xmx:O79kZF2vOx9s0jQ3MX874T0inMkI3Lbo3nOrUez8cBq1kWPqEmpwOQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:49:14 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id a64995a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:51 +0000 (UTC)
Date:   Wed, 17 May 2023 13:49:13 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 8/9] fetch: use `fetch_config` to store "fetch.parallel" value
Message-ID: <8e729d7035a5dc2e1bc1272522eeba465051ee37.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DBbtpjr/DZ5+PKOU"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DBbtpjr/DZ5+PKOU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the parsed "fetch.parallel" config value into the `fetch_config`
structure. This reduces our reliance on global variables and further
unifies the way we parse the configuration in git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b40df7e7ca..29b36da18a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -87,7 +87,6 @@ static int verbosity, deepen_relative, set_upstream, refe=
tch;
 static int progress =3D -1;
 static int tags =3D TAGS_DEFAULT, update_shallow, deepen;
 static int submodule_fetch_jobs_config =3D -1;
-static int fetch_parallel_config =3D 1;
 static int atomic_fetch;
 static enum transport_family family;
 static const char *depth;
@@ -108,6 +107,7 @@ struct fetch_config {
 	int prune_tags;
 	int show_forced_updates;
 	int recurse_submodules;
+	int parallel;
 };
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -144,11 +144,11 @@ static int git_fetch_config(const char *k, const char=
 *v, void *cb)
 	}
=20
 	if (!strcmp(k, "fetch.parallel")) {
-		fetch_parallel_config =3D git_config_int(k, v);
-		if (fetch_parallel_config < 0)
+		fetch_config->parallel =3D git_config_int(k, v);
+		if (fetch_config->parallel < 0)
 			die(_("fetch.parallel cannot be negative"));
-		if (!fetch_parallel_config)
-			fetch_parallel_config =3D online_cpus();
+		if (!fetch_config->parallel)
+			fetch_config->parallel =3D online_cpus();
 		return 0;
 	}
=20
@@ -2118,6 +2118,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		.prune_tags =3D -1,
 		.show_forced_updates =3D 1,
 		.recurse_submodules =3D RECURSE_SUBMODULES_DEFAULT,
+		.parallel =3D 1,
 	};
 	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
@@ -2411,7 +2412,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 			      "from one remote"));
=20
 		if (max_children < 0)
-			max_children =3D fetch_parallel_config;
+			max_children =3D config.parallel;
=20
 		/* TODO should this also die if we have a previous partial-clone? */
 		result =3D fetch_multiple(&list, max_children, &config);
@@ -2433,7 +2434,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 		if (max_children < 0)
 			max_children =3D submodule_fetch_jobs_config;
 		if (max_children < 0)
-			max_children =3D fetch_parallel_config;
+			max_children =3D config.parallel;
=20
 		add_options_to_argv(&options, &config);
 		result =3D fetch_submodules(the_repository,
--=20
2.40.1


--DBbtpjr/DZ5+PKOU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvzgACgkQVbJhu7ck
PpSsbA/+O+2Q6yJ4/sYL7biJ3hsAx8reT7TLtuSewlIDho3f6aPRdPO1NYIMD5tJ
0aB9tkyYekKEXdrf9pZkI3gAwnAGj7ybW4yALWlwQQ4BBQrZT1Syv+xBgs6R0a2o
LkxjM9WSupq7Ra9PpeaQ4h9ZnzxcXLwk8dV6SNw2A1AO0iEC/xw+PTMtJu2b37ap
qva8XDci73rqP0+PvMrOgPbTeQmyEbK9coioI9ulSER3/Ef22ehlCLJGl/RLRndm
qM1JP+SnJmzhyuRn6OZ10kRLav/ljALAqGKxvdFV53nvoDv2LmQlkKqiipbrj172
U4P7YqXtCWRa1wQuPxDGWcf8zGtmoqB8t1c9nXFwbuKxw4Hyp8pX7WGegbeJGln+
u8gDc1dSYzpdNmSgjFJ4ITAfmIejTPqxCYmUQHFRhTSJ15HUAta3SPIPCPeXQltv
i3heV00ZEdqFEMXAWbAYfJquvxhhhZufiq/Jd6+/n+mNlqfCdT1Peeo/EtAsvWTX
9WWx53hyAGmUS3IUcH+JMJijb9rmLp+Va7uTommfBO3cz9EPzmWtU6KHLDPN5YmN
1//9O/1ZXyV/9y2+rDxaj+aqVttOY8KHibMMXQRU9yRY29WwQdS4Tjsnkdi/XRRe
r9TC4OUGzascLK9oz8WLr4ziCX0l8yYfH/g2vnfy5j/DgOP3qhc=
=IxOA
-----END PGP SIGNATURE-----

--DBbtpjr/DZ5+PKOU--
