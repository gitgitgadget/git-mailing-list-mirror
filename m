Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D5B4594C
	for <git@vger.kernel.org>; Wed, 15 May 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755322; cv=none; b=taReVsy2IwZONFpC9hvWT2KTLho8JqwCvzjXLSTs53m1zIb2A+9Vv3DMaaU0Hysqnuu5+xzf4LjfdUqPPK7v2aBYKs4TJaao/WQyTwJzgzGQyT0N/I6XpeHbfB+QNM/FPGUCY0f6cTa5/AxaBdVBJQBRXArb+P74Q0Y6ZeXsi9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755322; c=relaxed/simple;
	bh=AwBQFwTze18dMZf3Bb23nJ67cWsfdyS7RyQ/vSt6pvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ByQhRa8RCj3NJrU0Dqa4E/9EdBzCuM0A0lUPEUCdQWNPNE12t4OBz8cseNpUDcLXQg2/3qkJH9rioRojK3iDpXz73MEmv9NM+EtB/WChTj7Cn/yKTDp0Mjchn9yS1yn2ckOfwfLgZS3htSITSPmSzqRDdENvz2v2ikU0eiIoTag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+f0MdS9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IR7p8fTs; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+f0MdS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IR7p8fTs"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9590F11400C7;
	Wed, 15 May 2024 02:42:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 15 May 2024 02:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715755320; x=1715841720; bh=4xvDSRvaJh
	POcz+fFTPEbmjluNnhey3h8a3fyH4gGcI=; b=V+f0MdS9tW7GX9ypmoRjY+DGfg
	Y9nbGmrBvCUVt0C2+RmlJ8hJFX4C8LHaAMiqq0YhaxORyVAI6n3D6pQ0Efx9a/Mu
	87hZLcTco60BKJCr+lqgZchX+zB6y8idNRY/edUCQhZaA9pFB1ToF5Vot9TmFHMh
	sH17k4SOd9BlJdnatLuU3fa5vvM1UAYLQcUtlEzcO1qSqZxgD3oKfO+A97rEO+xM
	oEEcneiXM9RpBPz4NCw+oh0qTOYmUTUFMHs5Dt7Lk1dnDA9doZ6ZC/VFbaL4CAYM
	EkVAFnfAMipl4xb+UN4E5Q3GWR2DLdjeI1Y7xxk4SEmQ+F4v05syKYhQeGKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715755320; x=1715841720; bh=4xvDSRvaJhPOcz+fFTPEbmjluNnh
	ey3h8a3fyH4gGcI=; b=IR7p8fTsRC3VGaLjbRW7QOI/jbPG+WzYxNmIaEWP5IBF
	2Pnao2sGtog2+RmsetZVqmRBq9lFV5cG+QCRMaByLQH1Bk1CT6RFdyz/goFM+GMo
	MTc1CgHp/QZFM7bsYHkUnOoaenVSLfx360f6Joy4UqDtn8khrWLjttaEWzNzQRht
	+vEeUXhVfxjZ7fLy4153M3pSjFsT6r8xD4e+XOacg5myrzZYoCJBzH4yO/e8Kd5p
	4AJJ5B4sazeFrhCOUMGrikk9nGwRoDtJ3EKPvkz5WDfKRbnV30+RK7Hgw5CXiGUJ
	0T+ENh9MATkOyQ3XCPO1RkceVVW6GN5t4CIn3ZqG1g==
X-ME-Sender: <xms:OFlEZj89uZWTYhq9KqDLJKBy8Zkh_TGjZGzTJenCeV-GQ-CHXIaETQ>
    <xme:OFlEZvvJ74xO-va5Nxoao9NxuXOz8Olnzla7d6O2LcxYkULXgVmhRHtPStUGAkiB9
    dkQgbJH5vrS5bhDBg>
X-ME-Received: <xmr:OFlEZhDaVEaisGSp-lSWpx8VO6eqcRhV-r2QOLvzZ4r35_S8eWt6tIByUrp54deSKy2dyq3EAG0RpPBZdRI32_XK8UAZ5_M24HoU7RmV8Q0CfqXt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:OFlEZvekrlmMvagfMtKlhxT68h3A12vgIZqxt09s_G0nTT3n6r1R1A>
    <xmx:OFlEZoPriZml85kxkvuNkLLnsxMe_epvBiypsr0dx1JMNs2XJnCbxA>
    <xmx:OFlEZhmV-4A4BUY0b95QC1L-BVIGUb7dHhUyNWASzE3ptTrARA7o7w>
    <xmx:OFlEZiuDvIaqC_fyqHzsILHnO_uujeJzPnJyrvK-nbhUse1lmuR5xQ>
    <xmx:OFlEZlos7XJzBBmPhSYw2aS_gsnFAdkwAAcl9HEuaVUiBctiIdtD73vV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 May 2024 02:41:59 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id aa5de69f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 May 2024 06:41:37 +0000 (UTC)
Date: Wed, 15 May 2024 08:41:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Kyle Lippincott <spectral@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/21] builtin/config: move actions into
 `cmd_config_actions()`
Message-ID: <4950ddcecd30257469acc27dd6f5fb4ea7b3a050.1715755055.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
 <cover.1715755055.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YGioqT9FLaZeqWlR"
Content-Disposition: inline
In-Reply-To: <cover.1715755055.git.ps@pks.im>


--YGioqT9FLaZeqWlR
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


--YGioqT9FLaZeqWlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZEWTQACgkQVbJhu7ck
PpSxHQ//RzmV+shAj2Q26CRL4Twsr2tMJOvajrKnWO2C6C6K7i6Pqx7lV5phN0sI
4d2A0HZkc6m4FSSOhIL0zwUZmWQ4FhzKlaq10+7o1By9iqEB+1oDOdnXYtVHycQL
D+Gd07tjJr3QGNgNvpZAVADqJ3Q9BMandbIPvOxTAldA0phnBgq/cV3X43VkhFSe
/xfF9jqo5Stvfm7MlBPBRhwIatujyLyHDmUMCbkIl5RDvaU2L7mcz7D5tj3h/JQr
3Fpc2ky+ZnDGFvoXosGVv79u/8D2AK5xc9thwMcBsch/8VViP+/2DGMB4LUIYxXM
jfzkH3dcgapq/5o7k15sqIqhdCF12i5+RyBtKABfQYUfk6vhhgJEWREAvNokrzrc
6OX2c3cf76m6d9VGyoDGqR8Wiy3PUKZW9Eo62LT4YeeJ1JZnaI79WzRdaYTvdM9r
Tl4JbjPxqKofvpaNoBcxZKEeavJw4flmZyjqnerV4a1v4VkXkzTx78kkmO7sF0UG
Kr3IByYS8onDhkULU+T1be+HlUKIdId2XOgU1eyIMQFNvYMFZgvXLi7d9ikZC+BP
yRfNoTi9D1SzeDePFe+NLGCTEulMKT31QtLxbVEIt4j6LMWJEKoyaKbDm2jZRF+6
2j8SxU8ypxN8Rgc6XhGlYcclnhFKPZiwUbb/J7Y6IwEpY8T2dD0=
=wHcd
-----END PGP SIGNATURE-----

--YGioqT9FLaZeqWlR--
