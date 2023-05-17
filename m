Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A40EC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 11:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbjEQLtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 07:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjEQLtE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 07:49:04 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8564B55A6
        for <git@vger.kernel.org>; Wed, 17 May 2023 04:49:03 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0376B32000F9
        for <git@vger.kernel.org>; Wed, 17 May 2023 07:49:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 May 2023 07:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1684324142; x=1684410542; bh=oi
        3WQx5ml4mCOJQ3vAt6QwS7Smz/2w63JEUYLLntlDA=; b=r3m5AQhDJBqECZJoRq
        erFRZI1bcOQlKIQ+hVY1V80SlUk88/ck5SRhFZa7jcQb5+m8ZCB6jofun3mFEPwy
        bHXDq4sxnNELlvp3f2bHTj9ziG6QEqAgH3ZT8dWUzNTmDZJsN5+Um8B30/OZo0VB
        EGsaJGLN65gVTKOeKy+9DxdlvmWeYpDW8RdJ099IAEJ00kvw9gSajfO6neDWKB9z
        k0SiNL1qzg0c8K4nSFwrqr4g7EL0ZueJMVhbj4dKREgu8rHN0HS40n0Egf5zJo1P
        jnxekWtcu9krXz2rhM8jLngVUav2C5J6QhJTmFR85+3ST4AYJqANe87ssBdoIDDf
        NjKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684324142; x=1684410542; bh=oi3WQx5ml4mCO
        JQ3vAt6QwS7Smz/2w63JEUYLLntlDA=; b=qL+H50xobp8PtEEEAcUG7yZzK4UXq
        D2DGQPG4T5okPNpK2JmMb0jg9+kpazDR3VamieM32jzTkF9uCCxbkIgBrIXD+4Be
        BkIllVlesOFZYlpM6E2zKlGBUOmHEfEhtPREh/2k0DwAnh3XUyamJMwolOsDjvL3
        7Q2BLLQQlRkpR4HrRiq6T18SGxIx8hzOGFxkXGkyYozyMnJc8EhivZgUtLpTh3cf
        7l+7R4bp/j9g6MZH6tCt4NKopOGGDep/qwO1+HJECBm244o33OotriNsmZixyKbo
        nLmjKZKpt+p3U+suXCp0MbLu3br4JEHcrJMP128YWkKEwKFBrSMJcUuvg==
X-ME-Sender: <xms:Lr9kZBaZTfqCYWQ8Z-g64Rt59PIyqacvOsFs1a8pNRgtgksfa7bMww>
    <xme:Lr9kZIYO0saJMflDvwrP5Hvitanchk7iRBJHdh3CB5LceBaDwe064i0fFvkM50rx1
    wSCx1LSlbQ8BMU2TA>
X-ME-Received: <xmr:Lr9kZD_rZO_3JlF2udbgFIrdFGADwhutbpRxlycEjGyq4CX-IEyr7l30NBR_O7q4_U-rgjKRov6_XZI3fyf7xJeWx0IOdD7ghhPoO37Q6-yl5qjy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Lr9kZPovSl5GgayOUKRhf6gAnNc7sMR6-PUT7heMu0AlRMV71uR_6w>
    <xmx:Lr9kZMrNbA8D-wtHCotTSAwKYYMdusIEOpmLhvlF1GqY9qyK3CaSVA>
    <xmx:Lr9kZFS3VbU-Gp1UMm4KaNv8khInVI4VCrthefDYykHWFMNJ-stKgg>
    <xmx:Lr9kZCFMO9szGYMFY03Z4b50xI6cnbFBaOHJ-XASNY7c2J0aXmIfGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 17 May 2023 07:49:01 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 69fbfc6c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 May 2023 11:48:38 +0000 (UTC)
Date:   Wed, 17 May 2023 13:49:00 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 5/9] fetch: use `fetch_config` to store "fetch.pruneTags"
 value
Message-ID: <3aa64ca1941cb8204448a48e1d44b9563c002d19.1684324059.git.ps@pks.im>
References: <cover.1684324059.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LHunFaMXNku/fKUy"
Content-Disposition: inline
In-Reply-To: <cover.1684324059.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LHunFaMXNku/fKUy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Move the parsed "fetch.pruneTags" config value into the `fetch_config`
structure. This reduces our reliance on global variables and further
unifies the way we parse the configuration in git-fetch(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 488705b519..94718bcb2a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -79,7 +79,6 @@ static int prefetch =3D 0;
 static int prune =3D -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */
=20
-static int fetch_prune_tags_config =3D -1; /* unspecified */
 static int prune_tags =3D -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
=20
@@ -108,6 +107,7 @@ static struct string_list negotiation_tip =3D STRING_LI=
ST_INIT_NODUP;
 struct fetch_config {
 	enum display_format display_format;
 	int prune;
+	int prune_tags;
 };
=20
 static int git_fetch_config(const char *k, const char *v, void *cb)
@@ -120,7 +120,7 @@ static int git_fetch_config(const char *k, const char *=
v, void *cb)
 	}
=20
 	if (!strcmp(k, "fetch.prunetags")) {
-		fetch_prune_tags_config =3D git_config_bool(k, v);
+		fetch_config->prune_tags =3D git_config_bool(k, v);
 		return 0;
 	}
=20
@@ -2057,8 +2057,8 @@ static int fetch_one(struct remote *remote, int argc,=
 const char **argv,
 		/* no command line request */
 		if (0 <=3D remote->prune_tags)
 			prune_tags =3D remote->prune_tags;
-		else if (0 <=3D fetch_prune_tags_config)
-			prune_tags =3D fetch_prune_tags_config;
+		else if (0 <=3D config->prune_tags)
+			prune_tags =3D config->prune_tags;
 		else
 			prune_tags =3D PRUNE_TAGS_BY_DEFAULT;
 	}
@@ -2109,6 +2109,7 @@ int cmd_fetch(int argc, const char **argv, const char=
 *prefix)
 	struct fetch_config config =3D {
 		.display_format =3D DISPLAY_FORMAT_FULL,
 		.prune =3D -1,
+		.prune_tags =3D -1,
 	};
 	const char *submodule_prefix =3D "";
 	const char *bundle_uri;
--=20
2.40.1


--LHunFaMXNku/fKUy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRkvysACgkQVbJhu7ck
PpTPFhAAn7/lybICyuxUYD03g39liqT2n32sHzvElBiZ3dTMrrUvyiMRDezf2czp
u9S5u1vYu3/qXfM+rZI0h6zHgc390CSdRmOwEKciGHr3q67FkMjjj5gOYTuLACex
2P9xeE+nqO9aV39/7u0Dla6drS4Y+nDfNjbF6V4STUIFs2TsBHxEreLQ7moDO82h
W94N/3J6DAHcNRk7pJh3XvkWJDfYkIx4X/J5iwx1PpqluSn677LUzliVUYH1YKNC
EWmqAohKpRClas1fzOhKBjuauCM4lnjeoumneq9NysKWM5PUDM6hZvKi+mpgXU00
/keJi4+48tCCkcnHzMk6r43J0Z5aKysCOy3Kx7IAYFGODKoILny6GfnQfmhT8k1h
PiEO1dtoU5m/AVk4gZK2NRjhQtHL5K1Zk+qXNN61/sDARh+3sp6zV+a3N96jYkek
ekz2s6/Ra1ETOiz01qTADK8j4LWYsdRHHfgDP6jyx6T/905Bbwau0APmCOPcJm1k
4LT/RzSx3GvK3M1otqQ1BLqibgvFnz6MW0dwuFT3YW+YYKYMZjh539U+uEGt0sJ7
cjZrkc4AXUqMeaGo0v01Z+doaYmV6AnpKkd2yR3yY6XL2EfCcXCpRKbr61QVLxjU
e6manqeUWZFlQCRnzI/lXXH7v8zwXL9XZE4KQ+dxjEfeb6jNoqg=
=IMX2
-----END PGP SIGNATURE-----

--LHunFaMXNku/fKUy--
