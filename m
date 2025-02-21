Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3851FF7C2
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740124063; cv=none; b=f7yscbAxDeSazISn5gM7IR/m4/N2xR0iJxO/bZWayUbS3+C6rvubrx9KhnnI7DOv75AsgmMWIH+rCHcBDjvLMdldjji7c1/eYVGKAmG/vo+jxSlNMbTZ2V9Y8rC7M6yY7wUV5d/IjNhvJJMbNcptWoC9b3+40MFinPHyDoEnG/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740124063; c=relaxed/simple;
	bh=w3HiIqVSgf3p+Pd1ZG+UVtLzttz/N9HHr4U6fkBPD/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kakjc8lMZ2k1tT9sa72lxj1BtdSkaELTJU8cuxEevt9rED5AU+odtEsZmSmi8RKNG00KM4+L+v2SyoNOObWsTkFcKHTZSKezL20cDLvzYNmK3dpKBX+/+KmE+l3I/oeDxAjS5qpdM1aWqzls5K9Df4Zm/KwNF3WxwxAXcvQd4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bQW5lXvG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oes8GrZ7; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bQW5lXvG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oes8GrZ7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E0886114018F
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 21 Feb 2025 02:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740124059;
	 x=1740210459; bh=Vjw84ka1kKhkgSPrF9VCByA96F5OCkzxWRTKbVNFTSo=; b=
	bQW5lXvGtdDHIYvS4l1N0EVaik6nWn2byiTXul9UExi1VdVVGYG1+1pBfvdjx+g5
	apN69NcZ4ec24RZ/SjI/iraVFWJKgc18SiIA/nv+aY5uzruWhsfx/ye/fpYBDQmG
	dKhN6UhDAD1lQYNMxRhMvNb0QY7BEtQivP1I2nqkD3zmXZLtURQsAJ/V125XgI6M
	E5AKbVWB7ww9zI9sXs7sDeoSHZFhkpSvpoVCUE7YaSfm/YQ701ts0iz2BkPvznBD
	ps/CwwhM0p7KcfQ38Ez9ZHJRp1vPigTa/oWuTXTHnOnQoLrXCbHEe751t5FTKQaE
	wKhKydLI8hsE2HjdyHS1RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740124059; x=
	1740210459; bh=Vjw84ka1kKhkgSPrF9VCByA96F5OCkzxWRTKbVNFTSo=; b=O
	es8GrZ7bYOxMO8esnOxBrzAPt/gW+BYH0OFbNNT1T3Bn5DNEoE/bcPebFX0Kj03v
	lSJ5ftArBjuxQ2VQKgW/V5NNjZ4v2zXwUCosVuZbhLBpK2h2NoKx9d5RRovAEASf
	PmS6tcnDGQigwW5E+M5LIwLAOmGqAOlOXskMrNOwnZtoei+vXQN2OtC4PskO9efx
	dAzDcm70CTjHquD52aPt7zvQ25tL2N6gHf9xl2YaI6CHf2Akmojew/owKMAmEqiK
	++aTVjN5BtncGPC+1Yh3sy+UCDY/EA2FNv//lq9+bdfYtmMPpff8E6XjhmnIiXQJ
	BzFzDVeUzmqhzDaLVBuew==
X-ME-Sender: <xms:my-4Z1QJa2WBivmcXei_7EJuxGhWU2JkxqGSkWi96HiQZt3nO2tYuA>
    <xme:my-4Z-yMWhKcT_rrmsIkf7reIJudlzxaitb7MbVKE3-a2xEQatvu4T9AgXY4gayll
    IwFmOe7vbiQiSJUgw>
X-ME-Received: <xmr:my-4Z61gGrRP8kpg-63tjNbZgD_hIIHbwvX_yazR4EcFFq6HDQOvjoNXscaxjORRSEKRYJ68E-DgbItDZC6LrhoOPiQAq5Mk-drY4A7fyzpJBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:my-4Z9ADdszG5jm5hleyt0zgMyQxJuB1EOO_jgfo-zuvv5ypg2VgcQ>
    <xmx:my-4Z-hDsDXeFvUPfAt4ibC1tkW1V9kp2zC8d68XqHhUBBkSpuqs4Q>
    <xmx:my-4Zxr21YM7MYusxxvJr_fuvDfTMqP9X6NFo3ys-32-eCG3RXaxwA>
    <xmx:my-4Z5i2yjuj_mio_SmhTGdGY7QyzeEEggUxsu6-V4X8VXaUnJOoOg>
    <xmx:my-4Zya5-39hbICyV9gfVuganp7wuwr_kM5_bXycG1-RUSSXiUZNah4F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 21 Feb 2025 02:47:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ac22e2f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 21 Feb 2025 07:47:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 21 Feb 2025 08:47:32 +0100
Subject: [PATCH 7/9] pack-bitmap: introduce function to check whether a
 pack is bitmapped
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-pks-cat-file-object-type-filter-v1-7-0852530888e2@pks.im>
References: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
In-Reply-To: <20250221-pks-cat-file-object-type-filter-v1-0-0852530888e2@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Introduce a function that allows us to verify whether a pack is
bitmapped or not. This functionality will be used in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 15 +++++++++++++++
 pack-bitmap.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index fc92e0aae65..3cbe5bfe909 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -658,6 +658,21 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 	return NULL;
 }
 
+int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
+{
+	if (bitmap->pack)
+		return bitmap->pack == pack;
+
+	if (!bitmap->midx->chunk_bitmapped_packs)
+		return 0;
+
+	for (size_t i = 0; i < bitmap->midx->num_packs; i++)
+		if (bitmap->midx->packs[i] == pack)
+			return 1;
+
+	return 0;
+}
+
 struct include_data {
 	struct bitmap_index *bitmap_git;
 	struct bitmap *base;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 3368e79ed5a..45e96b213e2 100644
--- a/pack-bitmap.h
+++ b/pack-bitmap.h
@@ -67,6 +67,13 @@ struct bitmapped_pack {
 
 struct bitmap_index *prepare_bitmap_git(struct repository *r);
 struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx);
+
+/*
+ * Given a bitmap index, determine whether it contains the pack either directly
+ * or via the multi-pack-index.
+ */
+int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack);
+
 void count_bitmap_commit_list(struct bitmap_index *, uint32_t *commits,
 			      uint32_t *trees, uint32_t *blobs, uint32_t *tags);
 void traverse_bitmap_commit_list(struct bitmap_index *,

-- 
2.48.1.683.gf705b3209c.dirty

