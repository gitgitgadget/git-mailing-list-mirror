Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3295C77B7F
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjEQLtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjEQLtB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:49:01 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E40110F7
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:49:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 89A8D32003D3
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:48:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 17 May 2023 07:48:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324139; x=1684410539; bh=fV
        MMzq9hRkc2kXRlI1eMhydet6eRIFeoDKrYv9w2Uxc=; b=T9v3MMxaKuPuFo2kbJ
        GjRhyberCEUxISVmOMMaRfS0/ZWx9AWgrEcd6YTEGeh9RQq3H2S40c9Cm4sACK4Y
        jmiPUuLiG4t28XGQM+yu3d+0da496ZGF7p6CSviP+7pRSVinD7j2Q/lDMfrbzs05
        KxA+SF3B6f0RCzjyS4sKV1O8i0lIfC9kgiBffWQoE6rpWGONF4pK65Tm/1ZE5RPB
        CdIjXxFg+HX/85SQ787SckhOdKpc+zxB2XldnKIRCEt07hg5K4E/3aEGf7GYXHkm
        v3eR/R8zv15HkMijwCezNievBZgY0ULy/s/iRsHXy+JJ5cVsapwhNg2Hh+0lRA4a
        wtFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324139; x=1684410539; bh=fVMMzq9hRkc2k
        XRlI1eMhydet6eRIFeoDKrYv9w2Uxc=; b=Vs7H4mi4MlQw/5I3UFiPq9iFXVZnJ
        FGW1SVeMadWSbr1TehHz2J9w1IO1ADKFo85q9OpboKTo2Y1pxD+080UmDPqMVrLr
        PuLZhY35zRsCkIKt1za1KdRsT3HaeURk4+UqQndsNlg5kFRe/wulocai+SJ6/eNy
        P2xq6SMSHM8K7QhSh97EWXpHiRulsQsfnZl4zD1wKmP1PTFkwlmagyydIKzdiqRL
        bihzMnMf1JMrM5Cskzshc3UelcULvGrs9xvxDXPQ0fQUjNrbF9Mr3o5n4A56d4P3
        E7zGWHxaHhcr/sssrAFaz3OGz2LYOMZxGRBKT9pRtRjB3XntUohOz/VkA==
X-ME-Sender: <xms:K79kZDL75K8k4bBxJKLyjtZ2T_732mEEM2oU_yS_VOI0zrsvpBTMxg>
    <xme:K79kZHL8O9RmtBCjrhlznXkwyFnZHLbRLGzyWw2XwDjBtJT8q5PLk1J4ofvqFwiM5
    TS9Y8vIxtyqtoZJ8g>
X-ME-Received: <xmr:K79kZLtA0c5SLus7r1ODZ_XwINuigCsyztT88HlfCKc7iLDY5kAyINKSJoZQs-pgbJq7ytqfNTZfvRC3MCg9nTakf1CglDA680t1sNwbGjMBfiNy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:K79kZMb9hyp0aH6FfKRgifRuKtM2nLJJzXYHWCLbTvEWWDxYH6LXmw>
    <xmx:K79kZKa1siy_OguMpvqdkToupNuGI0Gh86RQV5Dxgm8JV5qW2Ggf5A>
    <xmx:K79kZAAYOYHUHJNoLbMErL6T7m_WIvNn23Z8aqrrKeLjm0yqg9PARQ>
    <xmx:K79kZI2LxFd6gcGEm7pRArhFMt8eUdFiKtlFymvsYbFGEfEidf_4mQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:48:58 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 899e0444 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:34 +0000 (UTC)
Date:   Wed, 17 May 2023 13:48:56 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 4/9] fetch: use `fetch_config` to store "fetch.prune" value
Message-ID: <1fa4922bea12ef0363e2638bbb5c70218c6ec357.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ks1ZP6u0LJhD6gKf"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ks1ZP6u0LJhD6gKf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the parsed "fetch.prune" config value into the `fetch_config`
structure. This reduces our reliance on global variables and further
unifies the way we parse the configuration in git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 401543e05d..488705b519 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -73,7 +73,6 @@ struct display_state {
 	int url_len, shown_url;
 };
=20
-static int fetch_prune_config =3D -1; /* unspecified */
 static int fetch_show_forced_updates =3D 1;
 static uint64_t forced_updates_ms =3D 0;
 static int prefetch =3D 0;
@@ -108,6 +107,7 @@ static struct string_list negotiation_tip =3D STRING_LI=
ST_INIT_NODUP;
=20
 struct fetch_config {
 	enum display_format display_format;
+	int prune;
 };
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -115,7 +115,7 @@ static int git_fetch_config(const char *k, const char *=
v, void *cb)
 	struct fetch_config *fetch_config =3D cb;
=20
 	if (!strcmp(k, "fetch.prune")) {
-		fetch_prune_config =3D git_config_bool(k, v);
+		fetch_config->prune =3D git_config_bool(k, v);
 		return 0;
 	}
=20
@@ -2047,8 +2047,8 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 		/* no command line request */
 		if (0 <=3D remote->prune)
 			prune =3D remote->prune;
-		else if (0 <=3D fetch_prune_config)
-			prune =3D fetch_prune_config;
+		else if (0 <=3D config->prune)
+			prune =3D config->prune;
 		else
 			prune =3D PRUNE_BY_DEFAULT;
 	}
@@ -2108,6 +2108,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 {
 	struct fetch_config config =3D {
 		.display_format =3D DISPLAY_FORMAT_FULL,
+		.prune =3D -1,
 	};
 	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
--=20
2.40.1


--ks1ZP6u0LJhD6gKf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvycACgkQVbJhu7ck
PpSRwg//QOj2YA4oq6QHGLgL0hufzbPgVxsxsalJvKuShaBJTXzrasx/da02MNAz
jm8Sg/YFs63EWTb76A5pqR09F7GHBOBEBwsBmcF5qpPsvw2gS0i8EU60XYY9IGlj
CauQJ3qJZ/RR5CbWbWyNULFpjZWaQIdzxrMU+S3msCgxAdj289M1NGe6fX2uHzks
hNxO8I9DKU6fzTdZ48jft7jPUVEtrmisXDVHd6HBnSiAJvT3/YQb1j/I0k9nRz+X
F2LvKsi/kznr2v/25X8O123X3WE8C6f+sHU8pOLejEJ2KrPzm+6zhdNv2SshABIQ
ewLDOHf2miw0lwpWDJymL09WlqS+ZYlU2gilXL70TWWyTtZ9R3secveUIGjVJmsR
gNFxrO5eBkeNQVzcs6YfquGDD/fO6AWH3txUXV43rBBgwSa3SsAk1aojhPKb8+i/
X7BdO2cUJ2QskbSPCwk2tw5TcopFjuRTkUtmB7IvTd0woXJxJV9dufH7Skriuh3/
S/QWmfHRaGtT14qytTu/RtRKEzy4SIZG86MLxIrQp6EeMC6I52db+0Dm527BQmxN
GVDIKW8DShBgKqZeimlGFtH6GmnaUwKJjC4Cox42gFSLImQna4ApB03E4Ox8AXKW
o+d7BR7nmaCg3gcfILBbhUEIYmylhFzz4BZCBs/jbyMgWBze1Rk=
=G2CM
-----END PGP SIGNATURE-----

--ks1ZP6u0LJhD6gKf--
