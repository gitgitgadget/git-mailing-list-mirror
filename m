Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650FC31A67
	for <git@vger.kernel.org>; Mon, 13 May 2024 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715595749; cv=none; b=nlessVY8tyc8SQ1gpHzIx8tRJW2AsExasQHWpyQsV99VjhMuBTF4QODaAFOcmxH3Zt4ZKCU1IWZH7chWyZ/g/4XFU/UYW34at51MsQMgNuejxmGSSMoEhM9iU8eSVkD9sP5pTN21CXUHbIrrdLmt7wEYDeO2XkeQeJrjLhH6X5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715595749; c=relaxed/simple;
	bh=mT6zu9eLLZyXuOIlhl5hDQS0ALUMAlR8ESLr+C5z9EM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIw1ROcU8SomOPXH/RF2bMi+PUmJHqMu6S1yA+IBkV1y+zfJ4X2NXzmG9c38ssNP/tc5HRbWR0B9xlM4siEMIvUCssBYEQPTMiXms5Qg1G7D1ef5xGo7FSzXC585+txed2WQuPu6aSKcEfI9cREpI6Zb/AzUc0RWAThtLllBfYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AZmZBgSA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LIwcGXIf; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AZmZBgSA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIwcGXIf"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3111E180012A;
	Mon, 13 May 2024 06:22:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 13 May 2024 06:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715595746; x=1715682146; bh=4l+p2hD2Ou
	KLPkyu/cwI44fKsEEqTpE2N+9MJLku4es=; b=AZmZBgSA/zNoCPMapbg97fJd/I
	x5mYTRlkUprB9LNr6ip9YtWD5/PyyPCYVpZttO5FnVc9Ms7J5UUqGOoTZSxg7k35
	3pqU/m024seqj4LHz8CEvn9ScYtuGgwC58nSgb5QzYYLqtocbNenombX1GrqmuEO
	IFKYAQ6PwUdcjehOTCWtMENM5xrqsS0JEQ1KWnaVgm9kou6JJ/wDb/SgvBMi6vJE
	zckeG2iTGR6MucAz/0bIcKWpTQN3Zfxoj92JRuHs/QDwzFI6H53nLMXdxi1Yr9iG
	yA8RdUbDDV/hjDDVjjesKEwuSDYGKmxzcCEZk4pBuJIJhbIiMNURk4YgxPWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715595746; x=1715682146; bh=4l+p2hD2OuKLPkyu/cwI44fKsEEq
	TpE2N+9MJLku4es=; b=LIwcGXIfgmUaywIrgKo8SitdRmB7PqmltlTmdAMDPslj
	N1jYh+t0UdCWXDsWiRgns0qXbSEPIFK3X05LP55IXpt36Sjh52Am1tXC4G1qh0Oq
	gA3+L7GnM7iU7Vj/hF9t0BV76rqdms1lukbxOz1lT4x+DZrLMPyOlFP/TgQQUlnk
	ndQ+ym2sMChcqvzbzTNKCSzUUFcq/9eE00Cj3O87vHGkqp0ALgB+qly86i2n80+7
	xKNm/LzJXx8KywRWHumRasv9NKy7D6KtrL+rEE3NeP8KHTD8SwWYNgVDpm0SGmaa
	LnFlpRKrtwWFW0KsZYT2aldlXHMqSVLozfI92iWWsA==
X-ME-Sender: <xms:4ulBZoNGhj64AXdksNRJiJ8HjcMBXtheC1F4qb5ZLhFRygod90OrJg>
    <xme:4ulBZu_TPyXBWy7unQ_wtUsNv6BfHRChip8vxOuQ9kiJGuMdZZ6m2MX5HIibfBqni
    5v5yONnpUsZJIebmA>
X-ME-Received: <xmr:4ulBZvROSs4mcX2W-iTPjMxH_PkJ-4meT0MU1-jy8bnH-UeaYwLOkhdgzxTffejZTI4e37j2nwM32e62-8-cObjrukuCvL8BHB7gkiPYCp36WUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:4ulBZgtCZj7G1qJJ25q2BjH2Ts5RClhWWpsKQyiVOehzSkTb7cGtUQ>
    <xmx:4ulBZgfFRxn3L7JyNimSWL2PKxuwOIDoXq_91rz6WB4nykaCZ6RYuA>
    <xmx:4ulBZk3K7XMJVHDMiYvXIbyMa6ynQjuOwfdhYopOWGL2gQFmEWOgRg>
    <xmx:4ulBZk_imbfhwc0KxPCrql_DqkvIyVZybtypoLYsqe9StL5pjgSHyw>
    <xmx:4ulBZv7LwVlz-PZO2kaqtzsYQv7LemjMFUTcvR-OZvR0BZ984NabSMFf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 06:22:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2a658b85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 10:22:06 +0000 (UTC)
Date: Mon, 13 May 2024 12:22:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/21] builtin/config: move actions into
 `cmd_config_actions()`
Message-ID: <0a6ecae2ccc55789bce3f9c42900b3f41c1cb06a.1715595550.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715595550.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4jlxYz9+OI402wCJ"
Content-Disposition: inline
In-Reply-To: <cover.1715595550.git.ps@pks.im>


--4jlxYz9+OI402wCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We only use actions in the legacy mode. Convert them to an enum and move
them into `cmd_config_actions()` to clearly demonstrate that they are
not used anywhere else.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 48 +++++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 25 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e9956574fe..0842e4f198 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -87,30 +87,6 @@ static int show_origin;
 static int show_scope;
 static int fixed_value;
=20
-#define ACTION_GET (1<<0)
-#define ACTION_GET_ALL (1<<1)
-#define ACTION_GET_REGEXP (1<<2)
-#define ACTION_REPLACE_ALL (1<<3)
-#define ACTION_ADD (1<<4)
-#define ACTION_UNSET (1<<5)
-#define ACTION_UNSET_ALL (1<<6)
-#define ACTION_RENAME_SECTION (1<<7)
-#define ACTION_REMOVE_SECTION (1<<8)
-#define ACTION_LIST (1<<9)
-#define ACTION_EDIT (1<<10)
-#define ACTION_SET (1<<11)
-#define ACTION_SET_ALL (1<<12)
-#define ACTION_GET_COLOR (1<<13)
-#define ACTION_GET_COLORBOOL (1<<14)
-#define ACTION_GET_URLMATCH (1<<15)
-
-/*
- * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
- * one line of output and which should therefore be paged.
- */
-#define PAGING_ACTIONS (ACTION_LIST | ACTION_GET_ALL | \
-			ACTION_GET_REGEXP | ACTION_GET_URLMATCH)
-
 #define TYPE_BOOL		1
 #define TYPE_INT		2
 #define TYPE_BOOL_OR_INT	3
@@ -1031,6 +1007,24 @@ static int cmd_config_edit(int argc, const char **ar=
gv, const char *prefix)
=20
 static int cmd_config_actions(int argc, const char **argv, const char *pre=
fix)
 {
+	enum {
+		ACTION_GET =3D (1<<0),
+		ACTION_GET_ALL =3D (1<<1),
+		ACTION_GET_REGEXP =3D (1<<2),
+		ACTION_REPLACE_ALL =3D (1<<3),
+		ACTION_ADD =3D (1<<4),
+		ACTION_UNSET =3D (1<<5),
+		ACTION_UNSET_ALL =3D (1<<6),
+		ACTION_RENAME_SECTION =3D (1<<7),
+		ACTION_REMOVE_SECTION =3D (1<<8),
+		ACTION_LIST =3D (1<<9),
+		ACTION_EDIT =3D (1<<10),
+		ACTION_SET =3D (1<<11),
+		ACTION_SET_ALL =3D (1<<12),
+		ACTION_GET_COLOR =3D (1<<13),
+		ACTION_GET_COLORBOOL =3D (1<<14),
+		ACTION_GET_URLMATCH =3D (1<<15),
+	};
 	const char *comment_arg =3D NULL;
 	int actions =3D 0;
 	struct option opts[] =3D {
@@ -1147,7 +1141,11 @@ static int cmd_config_actions(int argc, const char *=
*argv, const char *prefix)
=20
 	comment =3D git_config_prepare_comment_string(comment_arg);
=20
-	if (actions & PAGING_ACTIONS)
+	/*
+	 * The following actions may produce more than one line of output and
+	 * should therefore be paged.
+	 */
+	if (actions & (ACTION_LIST | ACTION_GET_ALL | ACTION_GET_REGEXP | ACTION_=
GET_URLMATCH))
 		setup_auto_pager("config", 1);
=20
 	if (actions =3D=3D ACTION_LIST) {
--=20
2.45.GIT


--4jlxYz9+OI402wCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZB6d4ACgkQVbJhu7ck
PpS2rA/9HLJRvoAkQj+ikKcacan96bKKmxMzt7sNVQuttrGgqV4a9Ia4f7j1ZD0b
MoHWHNLPDOEto3K5Pp6eXWS4umMuv5MbtPeDLExa08YweGVncKZH+vCH37h+jrJZ
Rhymzqo6To0LdZnSTwBijWDiuofw0T3uRBy37/nmcNMob5MI5EgKK0Xa63J0IDsX
+AKYXhERKVieVa062U0i9i/vobnYZFH8KYSPMmZXiwWBQvTx7ljj2m5MRxw3FQhH
uhNDgT1m2833hQFnXhS84Zz+PUmrvoUcdgHBXhYXbPk2/pmDN7aRqn+Q1AhfTXzJ
gPCxFwuQjU0KLC3tJOdj8Sl0ZTSlgX87JXS2YwYIN84vvxqY51Bt+hO+yULjYQ56
ogTF+ysMqEmxul2tsSqUXBUDm5ksCgeYdO3ddeQNz3k3yZbBIImEOUSY1A+MJoK4
PCDG1EnIDV2/+FKe6BxanCxOlooFuqr8x1TebrCEqng2d5GF/UadFRIkpXB8x+PI
nNaYOvqYTzLuXUBxdGg3nAdlUGK5w6meNxS1osQkQ+5ya/V94kvN1X/Dq/hifsbm
iFKRcxe1zwJSdcUogJcfprxOnMyq0JqsjZm98FfOWTucf3xpSK7wc8RISXAgJu3G
HUX6ms6HWYS79i8uazxdRL2/RHkjQaCzNuoV0zZSrgRAFbfrAfE=
=2+2A
-----END PGP SIGNATURE-----

--4jlxYz9+OI402wCJ--
