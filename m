Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA89385277
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407643; cv=none; b=s19lOm0cysnEC4EwKo73pTeO1LO+lK/mc92tz3Yia5bX2AVGknd9B1E1loCXqXYp2a0WDbrez5/M6iyD+PUQvWzT6F4V8faWhjU+69FDPZTmgCVh/ltQe0TFbjwKWcTgJufW2Pj/Duuo1Bmne0+eFlFFjFZYzKkBB9pEbvy2ax4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407643; c=relaxed/simple;
	bh=+NuBitQ6dhNaAsP8WDcZxSC0q24zbFi5leqFxAYRVSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=caE77SnxabD0irxyeNDfR3yE84VCton1vLXRuYBkbM+YQSUwj3Hc1AQtDERH8kwcxAp59qmZcr+cOFucqGPK5Fox3HM7ow+dQnTU8TZpMKu9pGjCRp5c0L2Dmrk2wKU5+VdDAqzKr0La7iIiTYyssUaEW4Abb0lMEaUGIIVg5VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Si/3vTUf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iWZkEmGq; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Si/3vTUf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iWZkEmGq"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1D66118000F6;
	Mon,  3 Jun 2024 05:40:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:40:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407640; x=1717494040; bh=s9f8F7zj9a
	5hMGScmVLaK5hp+BJI0KqfRM/mH7GW+Bs=; b=Si/3vTUft461K9anD/gCGf9Dl/
	vMBDvjOIwZnMX7/K6IwTHtG95oqaJ1aPLu3NFM23DxAJXe6Wdxr13ZjwBU3/BnjL
	8qtTSwiYPJiuFxRdgURuBvN7HvgvFIbv161QqXKFiu811o9+KxXSmR5hXCOgh0xg
	DVrkt4SOUlmEPSuU/kOtgufb2zICmOJ1TRM3cxiRm8TZr4C02SnjAwhntpHLcU3a
	PuRYX79Rtxmt0Ypi3g6TegN6WjijiXdEI7lm9mumP7wa9XnMv0dXlrQt4Tdi4fXr
	QINMuHqWDHlJEiOooSmUM+PdEhmPOKAAYL5DK5ViFPCRBvutGYwgHVfgTHOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407640; x=1717494040; bh=s9f8F7zj9a5hMGScmVLaK5hp+BJI
	0KqfRM/mH7GW+Bs=; b=iWZkEmGqE0FfhOdsujE9kRSVBlwE8Xw6cHjfjdYrOk6y
	9qY5j23TiEjqY0f93M2dTSeiW3BttYHPQMMqzZl+z61JGBP6SLT4AIVkWG0fgnmA
	XxMRm2q8WeGuu5YPe0n42y1xq3fTOShgkaYSLmmmOp/yd3j6wF012EU5VTSHJRQ2
	EpQrpW6L5JmfxaiAtcJrk1itS/KgfTUb/EdhmwqC+U8q2xrE1WyRDGp29t8lv8y7
	a6zlrC28ca5Oa0HwO4r2t7qQAVyc70IsXoD6bJJOKTcYW+a4KecRnw29Xkp9HDEG
	/YmGDc2NThGQt744KIRo8XAapMQQeKxAnQiUbHfUnQ==
X-ME-Sender: <xms:mI9dZsVpvobc5f9SS0eqWbC8U5xrnvgp275eDg9v-pNRy2IROgmZPA>
    <xme:mI9dZgkjrBF-88lFR7BvzZmVYoyq8ITk-IOgngY-OV2oYiX7NyL5NvBN-F-1UUDMi
    E6tSmvV6v1rx8G-SQ>
X-ME-Received: <xmr:mI9dZgZZcT-GDpZFdj37htxe3DfRJwPa_tN5j1256sDE2oIC635m6TQ2h6EWet_5sw_esnnK6HlbWekCUTkes7DmwJlrFK8jodnwLVQh21yUhBk8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpeefnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mI9dZrW3qWP-496eYv1taXJ9lKSdfv-hOSxzYabSuA8SJfSlj23fxA>
    <xmx:mI9dZmmab3fJ8PAXgQmRPR8rZqDEjZPLQyhBHkmg_NKIK0JYq_qBnA>
    <xmx:mI9dZgex8Qa7u-uK0W9VIxdkToCAGuXKvbkbph_7qoai4EyOiSqR_Q>
    <xmx:mI9dZoE7BtFcXMz98AZif5JLGQ0BcT3_2yBWLoOvpTDN69rse_agyQ>
    <xmx:mI9dZoiQxtZQ6N35UBWT7BXaUP9UyBKZtX1XgLXC1Y15A2N191sC8Vmp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:40:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f6bcb001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:40:15 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:40:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 21/27] mailmap: always store allocated strings in mailmap
 blob
Message-ID: <fb240598b4ecc5b64069c5e7bd8cd9f71d16b564.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KbqG0LE0u19Sz6bC"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--KbqG0LE0u19Sz6bC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with the preceding commit, the `git_mailmap_blob` may sometimes
contain an allocated string and sometimes it may contain a string
constant. This is risky and can easily lead to bugs in case the variable
is getting re-assigned, where the code may then try to free the previous
value to avoid memory leaks.

Safeguard the code by always storing allocated strings in the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..3d1e092fef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ int read_mailmap(struct string_list *map)
 	map->cmp =3D namemap_cmp;
=20
 	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob =3D "HEAD:.mailmap";
+		git_mailmap_blob =3D xstrdup("HEAD:.mailmap");
=20
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |=3D read_mailmap_file(map, ".mailmap",
--=20
2.45.1.410.g58bac47f8e.dirty


--KbqG0LE0u19Sz6bC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj5QACgkQVbJhu7ck
PpTu9w//WPRQrd+JTPcdNwk9iOy63XhH08r071wSRg5JdbJ62P6LieffsXOC2BkR
TvwH2eGFoQ4FX3bE3n1gGaNW+EzWldrfggEP+ruSD5sAwQiCsh0AYbv4iQorE//J
Q4D4f1/PrgK2uGNBasrf7JR8TiT6vtf+oBKJ9gs8vKn2nOOp6fJylO6EYL9IQg+B
uK4VgF91/ujE3Qndp4KDgmFnT8rKI/yN/TbSBcOIt8lbPHlW+391i09gN/NrYY5+
/ogUKDXO3PVdP32G2Np4CwAJx5+XqsuXFqn1GkEbTPE/FqcpuQGKcS9Zp847kwTD
ZnUCjkORoGPW9+/hRDtA5SZitEVvqs9Z/3vkZew6VgkfXaR6HWi9AmeshVmSZY73
vAKNIVn9viDTj0zRkAoVY5aVx0fg9OT6jNXjsXSBCSnB0a3F4Ws7C5F4knoz2hCR
4O3C+vKh0M8q0v3OKLQjo2Qq0S3pnp/U7evPe6p7it+k3EniEU2DyKgTbnCiWyva
VvoQqCxMzHnzGrsU78Yd5J1hXDBKcH47OBP4xaaF9/JUye2cxjL/xXR91DciQ0JL
keqnhd+Y2WpcfLxr1tp30VNHQcuIt1YoHuuJrLN0akTzAjbjW/HVGXhWruROI+lw
kMq60+oZ/eBpIMMO89p5L0NNEW5E+CqqNVBMZnWIHs5rlk51LR0=
=+bIx
-----END PGP SIGNATURE-----

--KbqG0LE0u19Sz6bC--
