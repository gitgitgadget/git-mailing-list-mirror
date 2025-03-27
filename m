Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3ED20D4F4
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743068654; cv=none; b=cfPRqlPvomAIkYF28MsmEZIlvAr0+ZZMUWurQPzj+9drWFHu2fMvUReXfpa1gFCFFJNycLozOALRk0Bwq2IdqSmU7LZkaV8He4SP2zXTFiiwHOCqU8mO98sZZuiqHaiUBQj8Lpy+gxAEGnyJnBBeUD8R9vK2PZOUMegWy3H+Zgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743068654; c=relaxed/simple;
	bh=e3c/1YnWAg5vDU5GcXfsdJYchir509njFQiiTNvLbUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jNPkn98sGFRGfDZvBb/YqPpxqdSbXpVioMu0NuYaKDv4ko8hUz5JZWBTv1HyZ84OJu7Qw/4xWN+80BxGMK2kJgHjdaNwyBT9WeD2j4S+NNclOZv3pDLVyTe77dSd3AO3U2UFroX6SUEqPOhh9IVZiuWhqhPb6r1IakXOXHWOY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UKPzNK1S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dg0rWeEc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UKPzNK1S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dg0rWeEc"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id EE0F013838F0;
	Thu, 27 Mar 2025 05:44:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 27 Mar 2025 05:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743068651;
	 x=1743155051; bh=IDDQoKnXvmO9ksps6g5P+W5QuLBESQF351rouoJykng=; b=
	UKPzNK1Sw3jTyuxMzlwy972AldSucQasgrzSYuk5wCvBoSthbLt0pkizeHbYCmjP
	s9TgNK4JYhnd6g8OuHqaQOAhbdytBtA+sxX5TEipblTEbcZ670tGEls6ix26YNOO
	fBYPu5YKQbO5YB3MsQR/pMk1dAeEo8Egi50uxlZVO4mMWZNrR6LUYifsdkdZzETF
	J1c/PW6E+PKDsDK56NQQwJU1TAbTOKR7gryB05y5Ggn15lYlW01AlQBzDzo8BtB/
	NzvNRxfqn/+QmdNj0dWlX38EdKGACnN0T5VQx61zyDlJrQit/mOSuQ9fNMZ9/F8h
	WD6sJNg4h81f9KKU0V4GAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743068651; x=
	1743155051; bh=IDDQoKnXvmO9ksps6g5P+W5QuLBESQF351rouoJykng=; b=D
	g0rWeEcT4IdihtGCYVJUC3K6qqzVEe+XUadxrIAEx7cFJP9fKBPuCht79IIsCDop
	6DnYX7ddALuoZ5Tw/MAsKns+ZhBt5rVxWJJZ3zZUjdka6rm+W6ST/6hvEN/0K9w7
	L6u3K5rcVMOLUwv1omvV/PMxs7/glxuKG0CMu29thdaxqUZkzi3iEeyBkYWAwDJs
	GAE0HrAT3OBH63Ru/YhJDflVrI/Uh5PKHTVuH0VvkTSUQDaFkdLiQgsdaZDteQDX
	0I7ZCMFI6VoLWYQInPIXn5lee7lMY1Gzja1jVdQaLnIQUPQhbaf/NHSioMZrSzid
	GwBlmyci5FaRMBgcQy80A==
X-ME-Sender: <xms:6x3lZ80n5I5Iz_ugDePTDbcdvnfmMS4j5pj4VJjL9ALD4UtBZzo7RA>
    <xme:6x3lZ3E82ZGW-wz7SMbNrA_cyFAfDyRKSFNZDwEy6ES_hMBpoDtBSf7e4Dk2YmI7X
    rihet8KilGjiC6ofg>
X-ME-Received: <xmr:6x3lZ06aWPM4FDdFD28NICyylmjhPSgWdNc9ZLx6XK9zWx0zuotcfV_i_E0E3dmDfEzllYy6uZrg7Lf4xk_2B3z3TAQbTvzwFqKXVbHkwEOOQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:6x3lZ10zJ2AKoohvf-YNGpU3MEEulCC-TkCmauyK2MJm4uGQ5XVRSA>
    <xmx:6x3lZ_Ew1mRO2LSC--tE5Y7cidsnUTVg2fbp1Y8vQntthDSwxqii1Q>
    <xmx:6x3lZ-_4PfzaRCR4Nnh_2W3DmsjomGmSK2UArWJbsHSckg2v6MumxA>
    <xmx:6x3lZ0lJ-0SxY4Rz01YpBytT5INFG1Ml48d7_nbtGJwpHKrftpdbNg>
    <xmx:6x3lZwPWK8-7A4yJebMrPnbaDpbv73m4_6U13UIda-_rHe9AHLGLeeYI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 05:44:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 41fe0760 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 09:44:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 10:44:03 +0100
Subject: [PATCH v2 08/10] pack-bitmap: introduce function to check whether
 a pack is bitmapped
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-pks-cat-file-object-type-filter-v2-8-4bbc7085d7c5@pks.im>
References: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
In-Reply-To: <20250327-pks-cat-file-object-type-filter-v2-0-4bbc7085d7c5@pks.im>
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
2.49.0.472.ge94155a9ec.dirty

