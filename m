Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD91F2B85
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 08:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740991663; cv=none; b=IoEBKr9nmByjICNxI678khFqYTy5Hx5Vgqg0lCpbzVjzCeo9Rp3I6TwiXI5avN5BZu8MubduhFdFeJMN1bUjZuW1HQ9SEmk2F0k2pDS9t0FZ571Fq2iPbxjO2h0Gw6TXhOrd/PUeLjYzPMbBMl8xv05vGw1glWo3CKCeQ2znE3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740991663; c=relaxed/simple;
	bh=H4JfD85vgnyqyOwAYoltElTI/OxOKJcj+bqkNxRt3h4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ddPNZ08TQ9DtNJpCOtiED2/zEAulQ8mUPRC6uWQdzAcmM0DLd24cFOXq/59Y2ppVm0I2DEvtNRYhvzgLIfNC4PDAuxwoxleHBSdCBxhEXlVcxWJ04xE4e0NMxnVIFogAAboMt9nNPpk7vHlw8ykXMRxsTQ9A06aLO4lsnz34c7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fiz3iW0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbxyezS4; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fiz3iW0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbxyezS4"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 337E6114016C
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 03:47:40 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Mar 2025 03:47:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740991660;
	 x=1741078060; bh=UAXgCKoMn99EL3s6+C/d4DDc5ZplDQenFuIP6GZWTr8=; b=
	fiz3iW0lClBAKrvDiMGtPj0Tms7g+Ej0xkrPdrXCQHDmm6t9TYYS+qiC2NXlVfcL
	hxd5z5qOVKE36xDHECtoN3JwTynG8CFNv4KWqCA90dOVxJUNzC46jmQwFARMBTWY
	afzra8X9T1RyYJ6SiySGcqdgzveg0EGGbLmm1pRffiySYg1ITsk4qvLPxsBx4eLT
	MsHhRc5zOs+SECk9YwK5U5YsKj16xjsRS4/vfCUAQWK1lN40VQtKibnAxgViiTCd
	5KiCL8uIk8wju1ZXv5BbW/xyPGP8ag1/y0h8fDr8ggNnElGsPo2eUw6nKxSQ9/ox
	nqve0wxVN3w8gBvOboGdKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740991660; x=
	1741078060; bh=UAXgCKoMn99EL3s6+C/d4DDc5ZplDQenFuIP6GZWTr8=; b=M
	bxyezS4BIW0HOZnWRI2/1+5ExxjzUwI7VESgIQTJWkkjS/oOrbirwCHnfLXnAb/A
	P+P4ilYQ56FyaxchWSOGiP1ukboj79PWP6gRQBNBpU+lWi5SC/pqIUgz2rBI7FWh
	lSq1BE2VQ4qGzCFiINMFL12swQaWBiC4OmgbI6StGNtgcTLYLy6T+9gK0alcdZK8
	u5uOoSJrCtcQ6dB7vccp0fM6YFrJ6IJ/piQdstU4AWkKthgUg3KQ/5qAcQEgFAKI
	q09kW7+49P95qaeu/gSKSJRgfxV5d0R7VFNC8/FLwAwWkysbBxjbcSIiBljJCHP6
	F/eUxGWfvw4zVcv9CB2UQ==
X-ME-Sender: <xms:q2zFZw8Q2t2BPbjCQS6Pds62i8cRjzml7zNWZ2XEBDXEGvHT0pnNGA>
    <xme:q2zFZ4tsEHiqKs6V53VZvZH9gIpT0p7SVPaNhySfz5ueSAlOHQWSPyUEz5edifhTM
    IDxD6Aw-U9saCXbLQ>
X-ME-Received: <xmr:q2zFZ2BxB3L2a-YsdDk3y1Bs717jqdtwHFGV1IzlBprCctB5QVoERjGS2W0Du--yDJRrJ7MkW9TgHvKM3YRV9eje26aUHgeZiQe61vddiyU2k79k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:q2zFZwfyakaEpafadVmn7IwYt4a4N2Yb6b8-G8RmHqKZDdnPuGdGhg>
    <xmx:q2zFZ1Mbs30V-VpWoHKhF9ed_tn0OS6y6jeNFvALMhOWmSubzLjs5Q>
    <xmx:q2zFZ6nQORu-kyopo9Iafwo7y16S_zaTlfZJ-1jTFDx9FYp7ryhT8w>
    <xmx:q2zFZ3s_f-V0TtsXHrkr5soW6dzo496Ng4LBbjSogdRbvAV--fuzqQ>
    <xmx:rGzFZz2Xde_z9EkeTrPSNJhtB1fiWCHLZZ9dlLMR-Sz6o5MKB4BetuHy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Mar 2025 03:47:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e030f57e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Mar 2025 08:47:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Mar 2025 09:47:34 +0100
Subject: [PATCH 05/12] pack-check: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250303-b4-pks-objects-without-the-repository-v1-5-c5dd43f2476e@pks.im>
References: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
In-Reply-To: <20250303-b4-pks-objects-without-the-repository-v1-0-c5dd43f2476e@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.49.0.rc0.375.gae4b89d849.dirty

