Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A374820E6F9
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 15:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741273841; cv=none; b=ipxMRnNNon4b3KC6U5kcaikif7Ukdb2UWVp3P7tX2pzlw1e3pNSDQpHMYf8IbtNHqk598BxLkyjoxSZZrJwRgP2w1tl6/n+blm3p9UTA49ECE2FWvEZxeaxg1fURWBhX8TI/hLLwjqIk9J3SkRWObsoomDKovbkwtSsKDf46hUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741273841; c=relaxed/simple;
	bh=JTaxFXFk1YyIJvT4fdA0GjgQ7A+/wuMn4NdLjhHhBEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f7Zk00hDdcsw78WgYvvO/TIVjYgmAkLetgQVHGno46KRWIonBvK2b8nB111rtAl3WRO0AjjTqCk4LYdyZapWLMr+1PW2vrPR6f2Xgn77SZpuWo58vW3czukQevBEAEJ78jOaETqL7ktnhEjPy6Mq5w8irPdeeZSltdnti5JftUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BpdWrHtJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BDa89tRl; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BpdWrHtJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BDa89tRl"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfout.stl.internal (Postfix) with ESMTP id AD95F11401EA;
	Thu,  6 Mar 2025 10:10:38 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Thu, 06 Mar 2025 10:10:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741273838;
	 x=1741360238; bh=vJ6Zh+VitBpJwH3xfl2cVqYZW/iosQ1EEW9obxwEx0g=; b=
	BpdWrHtJcPD3KEl2lhGVwQ3Bloa249SWGOEYcDaQSvHWdeBgqwc5zDohM2mkoKU6
	UNdW026/UP4U2+IqCZKpd1WOdgdFVXsUDRF/ONmG5nMh6cNlXTfvbHOy489N0sCo
	kI0gH8KIqji43GsP2RgaLpP+8rDJKhxmE3u3kaJ+IAQFKKH2xUee/TejD0QlHWlS
	3WOoT1rrfaAZWN3ymPFJ3C2KXvj+r1y0vGbSZVnLceRvAS/sUooaafuGGAMlxfJv
	OybKA8B/gvDKdAcb53bpNPLDFk1FRkME+KtHOm6z4UlsmA/rzv/yTT7WbbTtdQDe
	cMYcaPDoXLwhkVCpi/71mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741273838; x=
	1741360238; bh=vJ6Zh+VitBpJwH3xfl2cVqYZW/iosQ1EEW9obxwEx0g=; b=B
	Da89tRlHQTX7V1xT5TRvlZsKwUupszq6ttb0INmlQL+qq/hr7wRqFcCzZ72RWmeT
	j/puXUGAAo6xvd9QPJK56unD/CBwunzY3hrXN/PeN1w80mmPh7rknPAiMtqABB5X
	zXav+46fKR81X0LIOrs753HxQLX8G2j0WjmlE9R1Y+LHoUXfgjqh2bKD4OON82Pk
	ArNRQ4GaIeBuOdpo0hnRe7h7oMVMqTRBLiKjmRn9p6a1QxU8VuOurWUm0mhYyfaV
	jPUr1Sjd3v1muyLx+FlhP0sKNg2/Td4Gq2Gj1iPK4e7oJdkM/z/ht97biWZfMjUu
	q9RrNri5mIoxL9ckSaRtg==
X-ME-Sender: <xms:7rrJZ7qKeyZ-SpctTCIp3o21Ig-u1Z-Un6lgvFt2AWHcVpr79c8wwg>
    <xme:7rrJZ1pJq9gy6XaPf_69NVUEcnD6QbfSz9JKse1VevS34YFZSgwaXzlOaMJTJT13b
    ugY3gdEZpJOkOibHg>
X-ME-Received: <xmr:7rrJZ4NvLceDyQT96G8k896ybanRuZKtTNpBD6jt9IhHIh4H44XGgBqLYTBtWuKTrGid1AsSyfmJt6Z-rWyW1lLk1VBALlUlvI09R-zTQFSTow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:7rrJZ-6YL0zipJ0R9jCyhR8TRFdVwE4fbBq5exdwqrIOwJn5r22anA>
    <xmx:7rrJZ661Vc8-blz2f8IWB34BYCJXE2Vz5t-_IYNlWGIUHK7Rzn1OQw>
    <xmx:7rrJZ2hLByraQV_IALvFHZGPTRBZmjBFzF-oxxD13fGBN_pO4M7SFw>
    <xmx:7rrJZ84cWJmwSBJk8-Kqpo676T6Hg5VTWoVMA1PhtUo65R4fCPs9jQ>
    <xmx:7rrJZwm2dla_Zu8--BKhjrryxR1UUmsXOSVIyXFnG4Kky7PyGdT14oZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 10:10:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5c849384 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 15:10:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Mar 2025 16:10:29 +0100
Subject: [PATCH v2 05/12] pack-check: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-b4-pks-objects-without-the-repository-v2-5-f3465327be69@pks.im>
References: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
In-Reply-To: <20250306-b4-pks-objects-without-the-repository-v2-0-f3465327be69@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.2

There are multiple sites in "pack-check.c" where we use the global
`the_repository` variable, either explicitly or implicitly by using
`the_hash_algo`. In all of those cases we already have a repository
available in the calling context though.

Refactor the code to instead use the caller-provided repository and
remove the `USE_THE_REPOSITORY_VARIABLE` define.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-check.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/pack-check.c b/pack-check.c
index 017dc740f7b..95dcbbe9852 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -1,4 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
@@ -44,7 +43,7 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	} while (len);
 
 	index_crc = p->index_data;
-	index_crc += 2 + 256 + (size_t)p->num_objects * (the_hash_algo->rawsz/4) + nr;
+	index_crc += 2 + 256 + (size_t)p->num_objects * (p->repo->hash_algo->rawsz/4) + nr;
 
 	return data_crc != ntohl(*index_crc);
 }
@@ -81,11 +80,11 @@ static int verify_packfile(struct repository *r,
 	} while (offset < pack_sig_ofs);
 	git_hash_final(hash, &ctx);
 	pack_sig = use_pack(p, w_curs, pack_sig_ofs, NULL);
-	if (!hasheq(hash, pack_sig, the_repository->hash_algo))
+	if (!hasheq(hash, pack_sig, r->hash_algo))
 		err = error("%s pack checksum mismatch",
 			    p->pack_name);
 	if (!hasheq(index_base + index_size - r->hash_algo->hexsz, pack_sig,
-		    the_repository->hash_algo))
+		    r->hash_algo))
 		err = error("%s pack checksum does not match its index",
 			    p->pack_name);
 	unuse_pack(w_curs);
@@ -132,7 +131,7 @@ static int verify_packfile(struct repository *r,
 		unuse_pack(w_curs);
 
 		if (type == OBJ_BLOB &&
-		    repo_settings_get_big_file_threshold(the_repository) <= size) {
+		    repo_settings_get_big_file_threshold(r) <= size) {
 			/*
 			 * Let stream_object_signature() check it with
 			 * the streaming interface; no point slurping
@@ -181,7 +180,7 @@ int verify_pack_index(struct packed_git *p)
 		return error("packfile %s index not opened", p->pack_name);
 
 	/* Verify SHA1 sum of the index file */
-	if (!hashfile_checksum_valid(the_repository->hash_algo, p->index_data, p->index_size))
+	if (!hashfile_checksum_valid(p->repo->hash_algo, p->index_data, p->index_size))
 		err = error("Packfile index for %s hash mismatch",
 			    p->pack_name);
 	return err;

-- 
2.49.0.rc0.416.g627208d89d.dirty

