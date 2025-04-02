Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97B23A58E
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592436; cv=none; b=tT8p4z90ObgoX66IG+EHMrVejOHG7SGCfFYQc5u5UCYz6Qs7vExgRZmx1XIp8IqF5xwXCmo7BCFtXubK71RUB+7bQ0cOqDC0sjHl8wrKdiNJeD/DMdof4Y7JMUmm4hRfG+FcAMQ08lNJGBAq2LdLz4RzFR7c8O6S1oQJe/XakGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592436; c=relaxed/simple;
	bh=Qn7g8smoJJ5fuPJT31rqixR1VNtloJP5JatPat0gyaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DE2rMkp0K+Z2cegVEV/3XJ6uNKmgGkihJ63Owb2y9ZysPeCiC77nCPz/pIVJ5iuWfvL9wBgYOJ2MAi6xj6wrViYUo3pxnnBt25Kdjb9Qq70pSrnTluyJpvRHRW7dMiuSM8ddhBGScLk9+shnjgOA06PrSRnMEVAKFyyRRFRClYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gny8Wgep; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kumQ3n9k; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gny8Wgep";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kumQ3n9k"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F6AD11401F7;
	Wed,  2 Apr 2025 07:13:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 02 Apr 2025 07:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592433;
	 x=1743678833; bh=aqtCAitEKsEcwznhHXB76ZY0wkH02YhqifNkUrT/dwY=; b=
	Gny8WgepAK6eQYcJM5BoQwLlgeAxQ4N3I+CsSDE1S+NKXR6OktiDnFlCm23Igm75
	OSRANCL3Kzg35IoW5iBSw+bAdrnGn9b5GWvlNbyVTpXvHe+9Ofh6p/OK59uSRwV3
	zxjNqIN8i4xBAhGPJNokK5pNq1uNmTtLm+5iva5VzNrJHWgPRasgsXwsfdpqJqB/
	BsycjZVY+YuIMP9r2FQsk/x7dQy6tOqjArt7DhkKrxZyiy2p2+3tykLYMTh0vCHj
	Y5lmvEmQbislvEoZKFNXtzNavVZSs7BPwfAP2+fQZ2hd/M77Ikl6eD+oX6BMo6yW
	0ZCYBGQtkmp/JpPrx0MyiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592433; x=
	1743678833; bh=aqtCAitEKsEcwznhHXB76ZY0wkH02YhqifNkUrT/dwY=; b=k
	umQ3n9k6T7qXp7syXUwisnRFfLP90leS3WbCk5kzH174LKbVGAYSKyz4cbGp1k94
	/4pBqqG6Zpjg7JXpiPALgSo+/nqcFpYwUlMcFxcpKd9YcDL3uDcIsDbAKnMqlLbc
	2EQnTg7fRhMCwD3mpeCQwZBfKF8MLO4vWh5juEJUd5cirC3Qyel8JoRHs6LeIWzR
	0XSRnOiaV1SB0C9v7IMsFoikyybI0hOs9Kqxga6WbDgug/aGihKsd4CneEn26qFr
	h5pFTjfovXaWN3hEngSQZ1IjfGE1TlcHx9izTXyGAL1FaYHRShmoPf+BhGeXhGCb
	YlCwJIDBGYarROtRiOmBQ==
X-ME-Sender: <xms:8RvtZzUmqTOa2gCVvc16Wb3oCXZ0NZvc_VTiCj8xrX3-lMcue-HdsQ>
    <xme:8RvtZ7n-Km6FAa9XRF-_YBP_NjIYiPaoiZY5neBBMGu-1BiOlHifeU3qkapnlR0up
    x14hT7ziPLtUG7gKw>
X-ME-Received: <xmr:8RvtZ_YCFcEHXjfx7H016aMi-Q5P7w1GsU651pXCltfIU8HC-weVn7jrPQRHDqa7Bu8bZ-I5A35xBE34vNj7czi_tEoHW-64o_EHnQ_DE7BW7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehioh
    httghlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:8RvtZ-WyRmr2cZbvUqzrUuAdazi0mGQ6oYZ5t9UfJufw9xgX56Q_vQ>
    <xmx:8RvtZ9mtM4I1DlGgnJB4pkDrW6q_7Rj_8s9Zc9FwB73enRpXJJaZ7w>
    <xmx:8RvtZ7eXJNFphe7_csMGwRwDtuYJ6vObojpmkMRz_Kqrqukvr1zwbQ>
    <xmx:8RvtZ3GUNO4_w7pR58hCjjkNN39rnKm9pKftv1-hP0UtCQQM9OLpww>
    <xmx:8RvtZwmKerokIjez3iKZntaUGWaIGdiCrC-51i4gyl2ty0LCfBMcb_nF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id da1d702e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:44 +0200
Subject: [PATCH v3 09/11] pack-bitmap: introduce function to check whether
 a pack is bitmapped
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-9-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Introduce a function that allows us to verify whether a pack is
bitmapped or not. This functionality will be used in a subsequent
commit.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c | 15 +++++++++++++++
 pack-bitmap.h |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 6adb8aaa1c2..edc8f42122d 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -745,6 +745,21 @@ struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
 	return NULL;
 }
 
+int bitmap_index_contains_pack(struct bitmap_index *bitmap, struct packed_git *pack)
+{
+	for (; bitmap; bitmap = bitmap->base) {
+		if (bitmap_is_midx(bitmap)) {
+			for (size_t i = 0; i < bitmap->midx->num_packs; i++)
+				if (bitmap->midx->packs[i] == pack)
+					return 1;
+		} else if (bitmap->pack == pack) {
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 struct include_data {
 	struct bitmap_index *bitmap_git;
 	struct bitmap *base;
diff --git a/pack-bitmap.h b/pack-bitmap.h
index 079bae32466..55df1b3af5a 100644
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
2.49.0.604.gff1f9ca942.dirty

