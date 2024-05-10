Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28D16F0D1
	for <git@vger.kernel.org>; Fri, 10 May 2024 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715340293; cv=none; b=UZUPeXFCopP42+XB1CvNHsPZqXOmfjfJ2TjOo4rKlN4CN9mbGiP2jgNd/sUhHgiVKxCEnLerTVw0+tRVSuhLF1pRs1TiUWmgCRGjb2EzWhGWsEDdrTsxuWDr9jeu9q66OOkR2sQUpOQAifYi7G5LOZivLbRAKi+b5/jO6mCNP+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715340293; c=relaxed/simple;
	bh=P198sppntkJHcbeCRTOdMqOUh+AA0WO7O34XuC4SLXo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv0eS4N/lnaa2yWKhiYKJQE5M/fxI4L1tk9Q+eOT80G1bQjlyHw3K0UYl3VLgAKseaZGVIuo8pTmKiVod6usTnej6R8aUxpRnNGaFvQDkW937giy7K7wXjBQv3mpKsvrM0ZUrZKFJBpiSPrTEW3XrTuHqtdq7fTPbjkc7NioSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e9oeLw78; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mxn37WCq; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e9oeLw78";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mxn37WCq"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id F15E11C000E1
	for <git@vger.kernel.org>; Fri, 10 May 2024 07:24:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 10 May 2024 07:24:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715340290; x=1715426690; bh=fdNqRRnAX2
	lsk2MX8tHeXfaOQXOZvHjdwvEt6jKn+EU=; b=e9oeLw783ADNBB1mT06HvF3HKg
	RaRNNBFYhEuIxyy1y1oQ5eLLlbrU7KyhaL1w3ddX39TNY+udi3ynQV58qUuCd6AH
	gufNV5eKNgeLO6V4lx8ClmSR9ro3sQ/6A9AtCBYTlb4ORzYZd34BnPKHg8/X8wEi
	FzTaBNCSSS1eB6bdxDCALTHLkfQ9c8oAbvU83IsXdi7J+pLktrKvhg4hkump04p5
	HpnvWC8r73CCqj3Rolb8eNFKJEMIIVK17S4Bjhy6zkoNHeg9GfWin5zNSm/NzkpY
	qVAdpqXaIF1WGge5AdrGtRudPY7X5EmCJ2ffzWVm0DKBWS7/yY2Y0I9K7zZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715340290; x=1715426690; bh=fdNqRRnAX2lsk2MX8tHeXfaOQXOZ
	vHjdwvEt6jKn+EU=; b=Mxn37WCqwBJVUvkWYnIE074HTWRXaykUQ223231SDhDi
	vdHirxKOGmzy52J/okL+mYO2+1euuFZAbdeHHEWX+JDwEkAIcgPGbeFnC1KyTZ0Y
	cdU/ndn3xfN34NmwvX0PPGIkH6GrsQiA8+5Xu5red4PUKWedaKkhuvQfVvngmgWo
	5oRHNpRvcO8cKztlL8BbCr2uWzE3+JUq0FSlqUtNn6F3/IDIPzlM2RgqGVxIz3tZ
	z7jCHRi9mNcuBHMsKF5X9vx00U6Fj3FSb85/89MmAMJXoB8dSORsCJCcy0ZgSpr2
	FvJeW9AMmD6akwmHeLBHv6m9w29+J4zn0TEeOGaUNQ==
X-ME-Sender: <xms:AgQ-ZiEbCr8hvvrkwBSe9SlRU2ZfAesUXSLs4Cp8pMl0M8tvkTKXew>
    <xme:AgQ-ZjVPD1SdOBey-cngC6SYcMmaPoAsl0rE-R4q6QVgmgmGIaveIdVSW09YXcmXW
    t4vfpBIfxSztnrG7g>
X-ME-Received: <xmr:AgQ-ZsKv6n2EjVBtobeHbkNeGPSdBbLfR0FcdSmx4Pm_rrdN3aHirVMV0v0mx4baHALWivIMjRWecnNMJYmrTAtHkIcwWa6KgiCN023BKP9YpF1h9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdefkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:AgQ-ZsGNkP5sYxUFGiXyelMOxdWHMKTeidqtbdjQaEecBHWEB72gbQ>
    <xmx:AgQ-ZoWFF4skUlZCx4XflnE5eXiwymQTm0brZLsr3kwExRrMCEzVhg>
    <xmx:AgQ-ZvPze0gHMQKIgP_bcK_Q1jMIYNBvB84xbzVIB4aztKCwtNSrJw>
    <xmx:AgQ-Zv3BlEqDGuAOUQQS7F_glQFGC1JltNr5QMEs_iWznc8YUdbaSQ>
    <xmx:AgQ-Zjcw6Q_fwaxkAXDlUDzRdfgadP0CCVnORrY76XSr7S_zECND_0Gc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 May 2024 07:24:49 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e00b6d90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 May 2024 11:24:37 +0000 (UTC)
Date: Fri, 10 May 2024 13:24:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/21] builtin/config: move actions into
 `cmd_config_actions()`
Message-ID: <2e308393edb0c34593e78603b43bee8d3a45dd8a.1715339393.git.ps@pks.im>
References: <cover.1715339393.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CH+60qi43GhAzl3K"
Content-Disposition: inline
In-Reply-To: <cover.1715339393.git.ps@pks.im>


--CH+60qi43GhAzl3K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We only use actions in the legacy mode. Convert them to an enum and move
them into `cmd_config_actions()` to clearly demonstrate that they are
not used anywhere else.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/config.c | 44 +++++++++++++++++++-------------------------
 1 file changed, 19 insertions(+), 25 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index e9956574fe..8f3342b593 100644
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
@@ -1147,7 +1141,7 @@ static int cmd_config_actions(int argc, const char **=
argv, const char *prefix)
=20
 	comment =3D git_config_prepare_comment_string(comment_arg);
=20
-	if (actions & PAGING_ACTIONS)
+	if (actions & (ACTION_LIST | ACTION_GET_ALL | ACTION_GET_REGEXP | ACTION_=
GET_URLMATCH))
 		setup_auto_pager("config", 1);
=20
 	if (actions =3D=3D ACTION_LIST) {
--=20
2.45.GIT


--CH+60qi43GhAzl3K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY+A/8ACgkQVbJhu7ck
PpTYoQ//Z8KIeSFzZiMdOct6XP/b9L5vP9IAcMh1bTojFadAKcd0bXpBtQGohSr9
IMm67CgMV8jwBaW6l3+9U9+J1NwJUPjpqTJ3JmFU0XENq8nyfBbG4rxnBlpxVLj4
s7pcmGx5a0g1tbV5w3cf7Xdw/940IsUKBG2ElmVuBWoOAavFfYdWQWTOGVJ39zms
bGLxxhPzQN9PeSZEVKD6CHxHgQYtU/kdfcBDg8X2daFXjU0wvyxAvJ7tIGBAs7yL
IiEb3QU6/DowIqfWQ/6/b0CRCdEA9WuLKpYhrQYhr5WOX5t25/Zq7mq0YxJGKJbg
TW/DPYvJGwNYjhmniIchUQYmh+xt2v4y6Ft9s7rRr6O2LBjUmoKlZ1xO3a/F4bUK
oKNUfj2EkJnBj0l9EkjmNJI5Cudo+L516uoZ+SNvGCp+W17zX1a+/xbxpsrqmPW0
VVxUfPDlktqFT2jl+2/Rni+SG537uYSWtZbtyEEfsuO7uBDJ1P8Qjh39B9ZUOaBp
XVJsKvgoQRB5C7e78Vhokdk7RDrESUcZ2X69heb9O+66WoUzYHfkLG5D7jksdZ3o
PnWCy/MlCYKbfQ1aMAmrAXruPG+SHlsnMe7M4GjMfU34Cyim55Ye1THbyt9EqaqY
7ughgRlEK5rpx8gMnIT6IY6rR2JEdFELyZ6pkaw2BZY9l9x3+yc=
=omK2
-----END PGP SIGNATURE-----

--CH+60qi43GhAzl3K--
