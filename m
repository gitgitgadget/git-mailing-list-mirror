Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EA21494A8
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619018; cv=none; b=qgEAhE2ZmPDQzt/hPJnc+WIx8jH79vwGO4GyXIhwpgKNTMu64Las2rLMSv1ttPXmqAW3Z/R8o1J5eqODWqUdReMHQFuXQzr8oh1JvMv0iaxGDiQU+NFtg/w7eOn0p+Epjks8W3iRTX3+qRYIGIu7UwifW5An6ZXHhjtpVo+FQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619018; c=relaxed/simple;
	bh=lVMJ9p/vQj3kXY1PajVIJTwdgsCTAoYx8uPYoFpDrzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i63UQ6w05kvIZ+n4Ma2B0C88Hqt9i6zNhEfzc76WS5xw24b9vPlux1ntmojDCqyd2t18IFu0XDOCAJfUfX313ziU+j/XMRf9hMUOoragZ/9V728BkasoACwEV8MoDKrI5SOV6vjxyxHoThQSovGCKZSBMWkMPsAcym9YRBeTIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LqTvIOZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxjKggdg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LqTvIOZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxjKggdg"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B2D9E1D000B2;
	Mon,  5 Jan 2026 08:16:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 05 Jan 2026 08:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767619015;
	 x=1767705415; bh=mypJ0wJJkujE65j+dPpgJl6vpc9vuJypkme4FP4DH/Y=; b=
	LqTvIOZDOkAZ7+VYjj3qAEB0tc7+fQeprddsGuzm/gSHkvbJw8bh0VxE/dztNapF
	/PrSSd21fyeVMb6t71OJ41I1BEam+tuxj8rHrBmCasb076FDq4zLhPUaGKK2Ssdc
	xqKEJ1iVmVmxt2RTTDOGzLrXdkTdJCB6nnO/u90Iap4KN6gbJIpds7KuS2E6Q+Pa
	o3H/VD44rGGPd9/qPRunmdNraMtirYZj4MtAUcrBYy2hZzls5iiJeZamOlWDNQkd
	ZexcffO67h56GE/aTL5OlpI5PKCv1Zg0xWcpf+2U8g8/ktaAWgTCt9B+HE1qXIy0
	qZ81kRkhVvekIPlY/VXTuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767619015; x=
	1767705415; bh=mypJ0wJJkujE65j+dPpgJl6vpc9vuJypkme4FP4DH/Y=; b=G
	xjKggdgpqz5hVawlZfH9a1c6TQJYKcqoT9Z8DYDJCjSgx7HSOGxATL1UcTyHtBff
	vtsGqEZlm4WMNuv1/25MprNxtV+Ho50qm23raNocuKGgUdkOc9WGihhdAHJufCCv
	iTVSDsUzCPBSS9vh6XkLEyLn1UDDlD81jmk0lKHNdPcMg0ePHtY3fIgLsOCfSEkg
	beO3zgO4N6zjPD9cSINBTAg1jadlSMXNpOWHmQbGQTl1Zba150qMTilur2aKxdRL
	VhmbNq4HxVPeb1vdtY35WLOTpzlvCQIjIKqLsnCtKzVLrcCkKS9T4Nh4+YrPFbTY
	E5aZ7zFsj9BFRn035Wfhw==
X-ME-Sender: <xms:x7lbadrBIue61j7OSG9qqOL2xitLM6m2abLra5HbK9gmI_PucQoLGA>
    <xme:x7lbaVoFgj2yoDSO-9eqP6pxq7E4SWEZ8izQAy97iqFsKmRrRVz0coRM1eHhKuSdw
    canmT9FW4sKxJ37wh1nFyhxHw6P5lxK5JmMdTc8z_mWE2YW2cjVTg>
X-ME-Received: <xmr:x7lbaX0ZbDD3LcKa5bOuDBKTSlgDnfoZoFy_BKdD1OEiKzfMkGcvP-7unFh_By2v23DPKvvysUv8cFVezMH6Sks0J3ZB4Ib3GONi42SE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeljeegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:x7lbaUBxA8qHi_Pd1rRoCtmwaPA1AGkZmPzOLh6sRsF7XRWjWmEqnA>
    <xmx:x7lbafc1_euGBb_HWUY7egqzK-1hRU9z_D4mSPJX-X4ncafafd53SA>
    <xmx:x7lbaZjPl4iPKu_Quohodvxk6e0sWVMxlUyXve2QcT4qKo89NftVvA>
    <xmx:x7lbaXqm2pjXbkpN-CmR7OibEybdIxRXDGlOevhdSicwZYB468D0Rg>
    <xmx:x7lbaWx59djso9Mcb7Bvvk8-TUUJfy1MsjKqjq85lFVXabSZpOT1lX5N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jan 2026 08:16:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 02a721ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Jan 2026 13:16:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 05 Jan 2026 14:16:42 +0100
Subject: [PATCH 2/5] repack-geometry: extract function to compute repacking
 split
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-pks-geometric-repack-with-promisors-v1-2-c4660573437e@pks.im>
References: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
In-Reply-To: <20260105-pks-geometric-repack-with-promisors-v1-0-c4660573437e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We're about to add a second caller that wants to compute the repacking
split for a set of packfiles. Split out the function that computes this
split to prepare for that.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repack-geometry.c | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/repack-geometry.c b/repack-geometry.c
index b3e32cd07e..17e6652a91 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -78,33 +78,32 @@ void pack_geometry_init(struct pack_geometry *geometry,
 	strbuf_release(&buf);
 }
 
-void pack_geometry_split(struct pack_geometry *geometry)
+static uint32_t compute_pack_geometry_split(struct packed_git **pack, size_t pack_nr,
+					    int split_factor)
 {
 	uint32_t i;
 	uint32_t split;
 	off_t total_size = 0;
 
-	if (!geometry->pack_nr) {
-		geometry->split = geometry->pack_nr;
-		return;
-	}
+	if (!pack_nr)
+		return 0;
 
 	/*
 	 * First, count the number of packs (in descending order of size) which
 	 * already form a geometric progression.
 	 */
-	for (i = geometry->pack_nr - 1; i > 0; i--) {
-		struct packed_git *ours = geometry->pack[i];
-		struct packed_git *prev = geometry->pack[i - 1];
+	for (i = pack_nr - 1; i > 0; i--) {
+		struct packed_git *ours = pack[i];
+		struct packed_git *prev = pack[i - 1];
 
-		if (unsigned_mult_overflows(geometry->split_factor,
+		if (unsigned_mult_overflows(split_factor,
 					    pack_geometry_weight(prev)))
 			die(_("pack %s too large to consider in geometric "
 			      "progression"),
 			    prev->pack_name);
 
 		if (pack_geometry_weight(ours) <
-		    geometry->split_factor * pack_geometry_weight(prev))
+		    split_factor * pack_geometry_weight(prev))
 			break;
 	}
 
@@ -130,21 +129,19 @@ void pack_geometry_split(struct pack_geometry *geometry)
 	 * the geometric progression.
 	 */
 	for (i = 0; i < split; i++) {
-		struct packed_git *p = geometry->pack[i];
+		struct packed_git *p = pack[i];
 
 		if (unsigned_add_overflows(total_size, pack_geometry_weight(p)))
 			die(_("pack %s too large to roll up"), p->pack_name);
 		total_size += pack_geometry_weight(p);
 	}
-	for (i = split; i < geometry->pack_nr; i++) {
-		struct packed_git *ours = geometry->pack[i];
+	for (i = split; i < pack_nr; i++) {
+		struct packed_git *ours = pack[i];
 
-		if (unsigned_mult_overflows(geometry->split_factor,
-					    total_size))
+		if (unsigned_mult_overflows(split_factor, total_size))
 			die(_("pack %s too large to roll up"), ours->pack_name);
 
-		if (pack_geometry_weight(ours) <
-		    geometry->split_factor * total_size) {
+		if (pack_geometry_weight(ours) < split_factor * total_size) {
 			if (unsigned_add_overflows(total_size,
 						   pack_geometry_weight(ours)))
 				die(_("pack %s too large to roll up"),
@@ -156,7 +153,13 @@ void pack_geometry_split(struct pack_geometry *geometry)
 			break;
 	}
 
-	geometry->split = split;
+	return split;
+}
+
+void pack_geometry_split(struct pack_geometry *geometry)
+{
+	geometry->split = compute_pack_geometry_split(geometry->pack, geometry->pack_nr,
+						      geometry->split_factor);
 }
 
 struct packed_git *pack_geometry_preferred_pack(struct pack_geometry *geometry)

-- 
2.52.0.508.g883dcfc63e.dirty

