Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259EC13774D
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259275; cv=none; b=q7C8QN0orMWInxbXaPhhFQkVs34QfEM+ZOB3ZG16kDjybgA9+L9pB/bDGGFu6hqU9Pq/t5UWe8PNaURtkBXGQjlRI6LDgpFylOMZnwdruELpVtzL/gDfbmKpyXNXbLJKJtH0wSzFL75elko/mHj0YRevF9KK2KqJyc/pSzyrheU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259275; c=relaxed/simple;
	bh=hgDy8hBomKSZwdmUG29XnZTXslDVuO3BV7Dk/PKX12g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYHqjZ+fM5L/22M3KQjyr1Aa73zOTrL/Mqy1I2rH4XQuZgiRmB8xgU5oPvO7S0FXHuikHUHt5HG9ElnfW/0lPAHEpic4hLpVMG+StD3LNGoeVdyFpLVyH8eCuQGlMdlJ2Eth/YRt//vuA/cdRf6xR5tm2Ek59A3ZA2NDi7S/i18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Lzf33aLY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcEpZNQM; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Lzf33aLY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcEpZNQM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id 557711C000A6;
	Thu, 13 Jun 2024 02:14:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 02:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259272; x=1718345672; bh=YB0ZXtIC8Z
	CycOLVKLg/aUZzdixFgu0ZJ3y7jvvA5JM=; b=Lzf33aLYU65DyZgtmZ18Ysgf2B
	VB69Ei8Fz+p99kDjZVAw1Xt1NsmBsoAln2fIdQqs7Vz9+lQHJfaAZmEXXuDncDA4
	omTpJnYj+mxlmugcVceYUj7/0CRDM5PJeVhtjDnnhrMDA/KNImUE0atV2TKh+6v+
	xgWEBl0C7BJIB09SMbDS7vsPOEAniN53tuUy4OcGaumBVl2Gki8ZhYq6eSEqUGD/
	4NI5VBnLv3pEjMstroU9jqvvs2j+Swaj+cJV25DVmr/BZzXTEY3a9JpcBRQqPPWm
	ZWFnqqdFW/zhuQ4MGRN2hs/K8aWWYt43ZaR5SLeGfekRnaeV3vUeCfUoxTgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259272; x=1718345672; bh=YB0ZXtIC8ZCycOLVKLg/aUZzdixF
	gu0ZJ3y7jvvA5JM=; b=JcEpZNQMRitcPVYMAGr9+CuX1JhlJmNhdDH8AWgK8Oiv
	S8FrSpcAFmClx4fkfOtlAd5yT4wRtbaBYahOWNu/Ftkh0om+035PlJjthf9RILTg
	IuOcyRtDUdVvWcQzGpYsj+Ez0GKzebn2NPeM268g2+q5GrMYXn1dUBDQ9IE7BfXS
	TKc1fHCv4EJMlqLGvCItiSWf1WNDfOcjUGgf+pd50+AUrzBxDPCN/P3aJmHfyRp1
	bQ+YUEXEmiOlzbhc4+08h2x676iUxyrnlkTLBll12GZ/edyTK9q8IEq9GdsZjT6t
	DlMLUl5WTNrzEaIiSO2UQphc696IGwjkwCkRl10oTw==
X-ME-Sender: <xms:SI5qZojoMpEFcCv2BANJZkcJwqlDZhhRwg_n7t-h7B5Uoutau09FBA>
    <xme:SI5qZhBO7SRQ3fBb94bNOINH726ZI-TzhVsX1z8YVxN91e9zwKTWRyrBZGLKeDOWW
    nG0GisEhmJi9xdy2w>
X-ME-Received: <xmr:SI5qZgH1TLtXUpGWQTDgl7ATAupyyQJGpdXRkIkBRjOCycBRKNhpjIuUR_Pl6i-Q7TeGnRyvHlPCCTrxYbsNmcK1UaN5VbQWAfRDmCwapxfSX4T6iR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:SI5qZpSjsuPIdB39_aeHeN8aHyJsf02-KOMqTr8iIjkIoSWxIvNH5Q>
    <xmx:SI5qZlxiutL0r05mEJXuzzNxQIdxToFATNrrEYKsdUI6kp5p_FzQcw>
    <xmx:SI5qZn4lcSODxokq36Pnetri_zbY7u30Oo3x7FK81TOxABtadReq0g>
    <xmx:SI5qZiy8oQU53ElonclQuCdJpCOo3F5Bgt57f_PnfNmV0I_Iq880zA>
    <xmx:SI5qZt98vWo3WdiTnFqWuq8-VAJh2ooJSePkiWm6nGAVIYQl_aVA2I1H>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f6dc6cca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:18 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 14/20] protocol-caps: use hash algorithm from passed-in
 repository
Message-ID: <c7abfbc48994515fa19350e80309d8d0f4798470.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LSlhAnYwn2STMvXu"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--LSlhAnYwn2STMvXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `send_info()`, we pass in a repository but then use `get_oid_hex()`
to parse passed-in object IDs, which implicitly uses `the_repository`.
Fix this by using the hash algorithm from the passed-in repository
instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 protocol-caps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/protocol-caps.c b/protocol-caps.c
index fe8d1d5c63..855f279c2f 100644
--- a/protocol-caps.c
+++ b/protocol-caps.c
@@ -7,6 +7,7 @@
 #include "hex.h"
 #include "object.h"
 #include "object-store-ll.h"
+#include "repository.h"
 #include "string-list.h"
 #include "strbuf.h"
=20
@@ -52,7 +53,7 @@ static void send_info(struct repository *r, struct packet=
_writer *writer,
 		struct object_id oid;
 		unsigned long object_size;
=20
-		if (get_oid_hex(oid_str, &oid) < 0) {
+		if (get_oid_hex_algop(oid_str, &oid, r->hash_algo) < 0) {
 			packet_writer_error(
 				writer,
 				"object-info: protocol error, expected to get oid, not '%s'",
--=20
2.45.2.457.g8d94cfb545.dirty


--LSlhAnYwn2STMvXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjkQACgkQVbJhu7ck
PpTBfxAAl1EPLS69ANKoL1sTrT1vSLGwBQFNctLyujguPzxKagTwRgZq6x6LCbdK
lFYElL1hCfb9bsIkHuSalj7oBTSPOjqj0LycjyFhR7t5CzFJR+2Y+u3ANot6h+8O
aAAl4ozJbl/+qzuqJTQpUfOAXkbKGLXPgH3pD5eL4DyWy8APciPdL2mrlhcCz6+n
XpQevwc3EKPlSuPDOgGBqu7f4JV0cs8OwSUEz3cCNViCmbEwgt9/RuuN4RyCYlV1
nKhe8cj4jbhz8U1Ir83iDGaW4fxoDvgGRi/tq2uGuYkwzeoJG/ErNuBMa/gcBWV4
k6ByOAMpAmVMu6a+oJWSQ8do3otgprnbWKn/kSRcNLQG5dNei/5oIbH9eXxBLPUv
l06kRvfFSLSzS+ljWBygmsLz8C2m+BJfZRATkqbFPn0M3LKk1eQ77PLkA5JxQMLE
eM574103oG3p3GnP3DFxcWs1kWFZZ7oCOpDMuO0BOwPiecZ9N8/l02JUbEVU2nay
eMygbNIflN/uWu9Wcah0tZ8RqJgvzsDWWxWhyQbiFsfMrZCHzh4ItGi93qwGFJyl
rY/9/cm+EiOrd8QkU41Pq8axanVmzdHG2FGumyMFhvlN8tFhlKBTKBIM2J+g5UKy
d5WxYvCCKGszNt4ZodjKSez6AHkT5CcbAK+FkHODD+0KcrXzN28=
=ZclQ
-----END PGP SIGNATURE-----

--LSlhAnYwn2STMvXu--
