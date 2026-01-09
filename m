Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8F134A3CC
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947606; cv=none; b=f3zgc/Fa4PIXe+0wulpcjxYKYkcBxr2dSaSwI4ECTaGLTiSbXs324+Q/DpVXaT2meN5AgO5ooVDfl/vEpzLIcGOslonUnUAI0WZg2Sp0hRAJKKlHExQRGeE04DddjeJXr/6yh2xn8fP75IvrEqs0rtD+xrwzWG0h9lPlq3qFuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947606; c=relaxed/simple;
	bh=OrNm/MKyLpMNk+5d3H49xl0MMj2b/cQDjAKWTr8sQUw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLPsAIpCgS3vn2i38d7gGzfUMqsxAvp9VZUiuNRh888qsJk1rrhVvlZeSvG5Kin8/WuScLOzArmHZ/sPR8EV1+Zn7yRniO8OjQ4BD4stKOLg39Sj0/VZwIUH9Mo3nBsYq0hxgvAou4IBPJaAYa75Ik/xQBTApLuHnr/AmaV4nNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HZj9OHhu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x6qxbNz+; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HZj9OHhu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x6qxbNz+"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 7C10AEC009F;
	Fri,  9 Jan 2026 03:33:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 03:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947604;
	 x=1768034004; bh=0dIOeBu1A78dPDoGLdWsDhH9/VFlo5GY7D7bTKHwsHw=; b=
	HZj9OHhu+zMb2ejNzJ3YiosBZInwi8U1To+Tizohvt6Hqrm7i44WE59+h8ZtMt7p
	bD5erSmrUDc5QQenMaCfadWehQpNV6ag3KKtq79kR2T+HQFmvDNeRkVnZt3Si4My
	ltV/BP14kZGRyYK4aYOBc7+1bz8xOO/f11ENhwQYMvt3ZFiVUpsj45p7iJdVUN2K
	XGgkIqHZau0qItppTdx8C/5t/Tx6yUOJm2TzV4UXbZc6AxlHtpMKYgxq3mT0ECcn
	YC90HgPTPW0y9/IL1kXQy5TP0YsxOcpTLBMxsa8Vk74Eqv/JbUotGwb6rW+lr4T9
	mAoT43CaJGTeygS4xbQIjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947604; x=
	1768034004; bh=0dIOeBu1A78dPDoGLdWsDhH9/VFlo5GY7D7bTKHwsHw=; b=x
	6qxbNz+srrxn3tAz15GyFsBDcv6K5xevwTpzN9O1/sqZS6BkPqGnOJ14hkeIE/jW
	ZO5coWWb0CAu94dYepiVOBOumtrvfcNSM6N2t+UMoQMIB90XhH+ZuT+gFkabOkaT
	OxN5Tr09TXh2ECkpVhIYE88uI88k1MpW7TPERzbS7JI4OekFC6d6WYPE4eqzfWZv
	lTMAKZI2GaTpDztKFqojBXoxTJ7DQkC8b+XouNGE9BlHtEKQJi7ke5lUvbsYGJPx
	0bt6Nn1zM8JEQCdKZx2SxrNViSQ0d96YtBlE5DhYftBiScd8o/s3BhlL8BwoIyPj
	Qz8klmGfzUaxEdwwuy25g==
X-ME-Sender: <xms:VL1gaUnWrkTOVnHSRbMdxJFxTB1jUixgYSTOwkqZ7SMkLXgphyu-Sg>
    <xme:VL1gaa2TcY9nEvzdVffimfI9x4c39nJOOSurBYP4gaffKjtahHSFQF8bavFVrr99P
    aEaG2FgAOgBHo1-3GNGzhDxHKjUouQtS53eA-jdtBjI3DylwVydoA>
X-ME-Received: <xmr:VL1gaXpcb7V9Ah0RnRUaFtpGgMp5IpK_INvvnUgFIrVucE2nBdWRtlj-kNIFM2DWFDBDjDcK5HIZhgMIs8ma-pUnu2T9x2jy_k6m4K5sTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:VL1gafcJGDPb91lV75MD1wrHuTiQ1-KyNAtClPvL5USQl2vcMX5TPA>
    <xmx:VL1gaepdJWmmvAPTa6oZG-JDKE5b8dNFAux5NUak2MrRE-LFHIKtDg>
    <xmx:VL1gaYGGlyW94I6pAkDg2s3oXksEJDF9D4tUUYYvKLUXF3Plihg20w>
    <xmx:VL1gaWs-M4ktyTO_pfewMOvh_8p5TkZJkRtc9X5KKnPvsMEh-FCrQA>
    <xmx:VL1gaZpuKbFXbjZx4JheJWQA26mgfenictvgAAUgirJZrWriiwZK1WeW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:33:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78d86c59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:33:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:33:12 +0100
Subject: [PATCH v3 04/10] packfile: refactor misleading code when unusing
 pack windows
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-pack-store-via-source-v3-4-877fd7b7bf81@pks.im>
References: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Toon Claes <toon@iotcl.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: b4 0.14.3

The function `unuse_one_window()` is responsible for unmapping one of
the packfile windows, which is done when we have exceeded the allowed
number of window.

The function receives a `struct packed_git` as input, which serves as an
additional packfile that should be considered to be closed. If not
given, we seemingly skip that and instead go through all of the
repository's packfiles. The conditional that checks whether we have a
packfile though does not make much sense anymore, as we dereference the
packfile regardless of whether or not it is a `NULL` pointer to derive
the repository's packfile store.

The function was originally introduced via f0e17e86e1 (pack: move
release_pack_memory(), 2017-08-18), and here we indeed had a caller that
passed a `NULL` pointer. That caller was later removed via 9827d4c185
(packfile: drop release_pack_memory(), 2019-08-12), so starting with
that commit we always pass a `struct packed_git`. In 9c5ce06d74
(packfile: use `repository` from `packed_git` directly, 2024-12-03) we
then inadvertently started to rely on the fact that the pointer is never
`NULL` because we use it now to identify the repository.

Arguably, it didn't really make sense in the first place that the caller
provides a packfile, as the selected window would have been overridden
anyway by the subsequent loop over all packfiles if there was an older
window. So the overall logic is quite misleading overall. The only case
where it _could_ make a difference is when there were two packfiles with
the same `last_used` value, but that case doesn't ever happen because
the `pack_used_ctr` is strictly increasing.

Refactor the code so that we instead pass in the object database to
help make the code less misleading.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 packfile.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 191344eb1c..3700612465 100644
--- a/packfile.c
+++ b/packfile.c
@@ -355,16 +355,15 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current)
+static int unuse_one_window(struct object_database *odb)
 {
 	struct packfile_list_entry *e;
 	struct packed_git *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
 
-	if (current)
-		scan_windows(current, &lru_p, &lru_w, &lru_l);
-	for (e = current->repo->objects->packfiles->packs.head; e; e = e->next)
+	for (e = odb->packfiles->packs.head; e; e = e->next)
 		scan_windows(e->pack, &lru_p, &lru_w, &lru_l);
+
 	if (lru_p) {
 		munmap(lru_w->base, lru_w->len);
 		pack_mapped -= lru_w->len;
@@ -740,8 +739,8 @@ unsigned char *use_pack(struct packed_git *p,
 			win->len = (size_t)len;
 			pack_mapped += win->len;
 
-			while (settings->packed_git_limit < pack_mapped
-				&& unuse_one_window(p))
+			while (settings->packed_git_limit < pack_mapped &&
+			       unuse_one_window(p->repo->objects))
 				; /* nothing */
 			win->base = xmmap_gently(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,

-- 
2.52.0.542.g9473a8513b.dirty

