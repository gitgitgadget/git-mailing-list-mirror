Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1121D6199
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741590817; cv=none; b=g+H0Bi5ZEbZOMPmM/40nQJqC0/yRiQUZwhvAz2Mq/NzDWWbLaCtz+Brco/W5dPvDqk4/YGflQ4uvvoW7oTbZ1ZdSyYn+UNRjNvhNOhYAFoKs73ulqOk7m+HtR1NL0HJFaDy0F1Tj+JxmNyGVih2soMnBWLeuzckD8IWWQyXcP3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741590817; c=relaxed/simple;
	bh=l6vfHxMQsfAk2Qo3m9vjhJ+Y7ZUBwfGJqNafkI6rHmQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FL8yYmpls9yqhNqh2F3z3VshvYenGeo1//dMNVpm65zb81XTOj/XvmucxwD54XMlPOSBIbz1j1iQOUWhd28nLnaYqyRXNhTHQ/bUiXkm8avK2/bknNaQE3Av/Px0nH2IS7eDnN1t2BU9jJfKSOkf6dQVjvRodF86jt6YMsez4I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UttWCfkx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7tdDdxn; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UttWCfkx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7tdDdxn"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3A0952540135;
	Mon, 10 Mar 2025 03:13:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 10 Mar 2025 03:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741590814;
	 x=1741677214; bh=EB42OqKPgYccqjSUi5BBsPv0PfiBSBd8mpmIBQub4AE=; b=
	UttWCfkxkIBodRFCDVM4tHgTfNrq1LuzsHvIXPCPQni3ucmiTHf739HgkimS+xMx
	wuFPWhB2YXZBHbQHiAD/6aIyjLZ/316C4KQJB9oollfLYXjbVYSsS01dQrvsg17W
	7TNL+/HQab/HSCQE5LZS/JZmT+LbbPyOi8DTipT5dlaslo49nAA8lVgFDs0OxTaz
	spqxTy/sNTzzH9N5UBpPdSX1Pd71hWNCSL1zy1Ldp3aa97i0xT6lBaRaax4ENIkr
	ZzdW4jrNcYKGFUkaqimutnqfZKhYOhTjMp1eAanVs9U822U9XSHG6oY2Ti5iAOhp
	+A/M6j031DfwGyosft2NKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741590814; x=
	1741677214; bh=EB42OqKPgYccqjSUi5BBsPv0PfiBSBd8mpmIBQub4AE=; b=e
	7tdDdxnpZXddpqx4kv9Tyd6LQr+Ozs+AmlHIX4XC+BkZPdp9SPl7eBH2WB5WLyOy
	MqKAwOODIdvyRUulxFNVrJ0oQKS29NyRKn81ByBDJe8HgJTfqhXh6ys9OcFU8CKd
	3eU361zMn7ZDkZdIews6wNls0jU5DPHxmSrDDtSqRc/sEJOM/DoSNHtCEgbzIP+V
	VqTPEcmL5KBoPE54i1aQ22S0EGTPdLOhx/uBVmksDCotv0QhKV2OC9Mjt0ba4+uE
	TDPbaIuWB2qO6HLJsJg5yVjOCUffO0EN6A4eE3uPkh7+SbIx2iIASxKKvIMbHdB6
	p/uRj2Olvjoo4pKC/pHyA==
X-ME-Sender: <xms:HZHOZ0JHOWj04qQowKntWaalOOlfnJ9TEA8DZ1HrSmTm-_WdavrJnA>
    <xme:HZHOZ0K_NgtXRzleigFr4nFdDnSsPNPS0gJBvn3t-sSlWgHPrg0rNe3X2spwdwXgd
    RXXXdU42Hsh5a_6xg>
X-ME-Received: <xmr:HZHOZ0sTXXprKOJim-STFyYK7vqjcZml5Qpjv3oKIIcAIzH7QeBtGZwVPFQnyppJnDmBN01sA-db6ZGhvEdXeYN8cjoY6LPALjnZoTjWqj4eVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrh
    esghhmrghilhdrtghomh
X-ME-Proxy: <xmx:HZHOZxYF_tBqyLFcBFXQ5Z-ojRfewUdODg1j8vGt9v5-fAUiA5FKUg>
    <xmx:HZHOZ7ayRTUwgudBS2ZUzE_h-1TQuFtaan7GheLLNZCTXf0jUfk64w>
    <xmx:HZHOZ9A362HQ1KdDjn6lLlXKFjzqAuKYAQ-dy688MbL2yEkroglJMQ>
    <xmx:HZHOZxY1qUufBJfJ78UGCTwgMOePmQrqddAHR27q-shpPXqngQLHXg>
    <xmx:HpHOZ6UQ6IMoNituTriuA9nV6nUFP_UbugQzj6_Ybh6EF-PQqy3XkYA2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:13:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b81a658 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:13:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 10 Mar 2025 08:13:24 +0100
Subject: [PATCH v4 05/12] pack-check: stop depending on `the_repository`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250310-b4-pks-objects-without-the-repository-v4-5-f201b8ec57ba@pks.im>
References: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
In-Reply-To: <20250310-b4-pks-objects-without-the-repository-v4-0-f201b8ec57ba@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Elijah Newren <newren@gmail.com>
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
2.49.0.rc1.455.g4cd33545ba.dirty

