Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DD1E1E0B
	for <git@vger.kernel.org>; Sat, 13 Dec 2025 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765590396; cv=none; b=FlOeQBDwUOr+0eVMba3LMa8FLl6SRZENAkXnSYOsNeXobhM9QTdK1MoIP7YVNVQLq3Ro35K0IkwjujbYDGks1tfxOYtA9it/Y0ZpuAANDTQP+PonMpe8pBcFb2fZoqXP9kxy3dJScFmCKOyfaJWRy1C1tproqkjJ+62c9z6UVls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765590396; c=relaxed/simple;
	bh=zHYu8ljGmAAdFpBnbXcts8PoMB74OUgDQEtMV/E5lFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOgt1p13vSR8AGK1/2+YenC3c7BnQhu5HzGajjr6h23RQNWLFHNl3L6C/iXtMquy5FfnAMt7+nJH6xTljvfMYx9hkx+bNp5MdcWlTocF43pfntdOMesg7aKdRPxecubPcB248v6mE3NRBd2Fhv6CzFQ3qfbd1yJLXY4UGCmvxRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lV5qEwjZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Adq4GInq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lV5qEwjZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Adq4GInq"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D5261EC0019;
	Fri, 12 Dec 2025 20:46:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 12 Dec 2025 20:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1765590393; x=
	1765676793; bh=WcwWKgPeRUEtL2AplD8CSV6AdPsl+F4TKOJ94U00fnI=; b=l
	V5qEwjZ4lHvKGmp3tMIVK8tEmJiRfv/lSQWeqiStFkW/abAvWFtbt3pBLSYz2/cS
	5rGHduDZ4ueiQ3D0+1YoiRtR3Rb9dEWmZg0J1oS03yMho0fRwYyk7NJ4Z1x+dhGO
	n+RdbtMM4Grnnsx7zQ/e0Q1s6WVXQvP4KlfMh/HQICWhm5zWnC/NAnGwNgyIVdev
	ijfM8MK2ehfmljKI3Mh2d+9L9JHViaHYuLnUy7B27m1qIfkQjhu3XpzQFXrDA8XV
	o1ueKEfx892cnj4JewSK4Rhx7183mSmzEke7eNZLDYX7TM6RI/WSBTDrLTZAV0Fm
	/BwKz9OnYa8582kXa68lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1765590393; x=1765676793; bh=W
	cwWKgPeRUEtL2AplD8CSV6AdPsl+F4TKOJ94U00fnI=; b=Adq4GInqCaU13qfc9
	BszhN6fwniTwqdDXx9U7lJW1IldqKE8XzwiebETJxCi9cznGsyov/bK4KJIiEc5T
	v3aI0ztiWKSZV0/DCrl+n4k1oI2SQeqHY+rxFtr9DBjc4E95V/oWnpzK4JRjgZAl
	0XcmgC9ozg3sYAGY7f3A2tlhGxDmAr/xBg6Lokoj7WNJpg7ahWKVJ+O20kJSLRVZ
	+xAYroTJ7z9IeCZ2w6hCQh80b1xvqmPUhbu729gnIxyye3jhYQwpnQP0xoCbi8at
	XFWCfGZ5G0Vkk50HYq07RsFjnuWHivkH3nv41Ig7w5MrvG5jAjv8UOYVIp0aS6T/
	kCLMQ==
X-ME-Sender: <xms:ecU8ae8Ffcp0zA7_E__4gmwQvGLfjk6oq4Xhx7pDaQ0iMAWv2ccYRg>
    <xme:ecU8aWI4tva6B2cQfubD7UU8WJrzCy6RamSk0iDizoF44vWdhMLADTwoElkoe9BRT
    bDvJo7ZYM_0kR2idLSlFgb8o10yBxQZmMKmWyJSoqj-45b5rmp9Gg>
X-ME-Received: <xmr:ecU8aRYWFO0vsqOmG8_iLGcaPtKWbFnbX-7ZhzDyQQ2b_mPjCCMUJ8U9P0WdDIdboAdsSY7o_NplcerW3OD9f7wilkrbZxV6Tg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpedvffelhfeutefgkeettdfhudelffduteelfeeiueelhfdvudeiueekhfdtvddu
    keenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:ecU8aQKvd1aMGMec1TTmo5kNBdk77-EC0Yy3w64F46QJ_agqKZFACg>
    <xmx:ecU8aXDLatRiC-da2osUfZjat3eZ85qh8vvIc-Hc5zzn9_pTPKo7tw>
    <xmx:ecU8adq_EBo22lyDDjf6QxD2zKxHLJKS6NaWw9RA30srVR0ZlHZICw>
    <xmx:ecU8aaiVSnx6QaK3Jl93zL6txAozZakR35l-hKPQVBuAQqkLYH5aNQ>
    <xmx:ecU8aZxZVGuoYQZy9-I84G-qKpX3R25lTd3si3YSd4nC5uqGHrfaBijK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Dec 2025 20:46:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>
Subject: [PATCH 2/2] cocci: use MEMZERO_ARRAY() a bit more
Date: Sat, 13 Dec 2025 10:46:28 +0900
Message-ID: <20251213014628.3380826-3-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-357-gead5eaf5b3
In-Reply-To: <20251213014628.3380826-1-gitster@pobox.com>
References: <20251213014628.3380826-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing code in files that have been fairly stable trigger the
"make coccicheck" suggestions due to the new check.

Rewrite them to use MEMZERO_ARRAY()

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diffcore-delta.c    | 4 ++--
 linear-assignment.c | 4 ++--
 shallow.c           | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index ba6cbee76b..2de9e9ccff 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -56,7 +56,7 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 			     st_mult(sizeof(struct spanhash), sz)));
 	new_spanhash->alloc_log2 = orig->alloc_log2 + 1;
 	new_spanhash->free = INITIAL_FREE(new_spanhash->alloc_log2);
-	memset(new_spanhash->data, 0, sizeof(struct spanhash) * sz);
+	MEMZERO_ARRAY(new_spanhash->data, sz);
 	for (i = 0; i < osz; i++) {
 		struct spanhash *o = &(orig->data[i]);
 		int bucket;
@@ -135,7 +135,7 @@ static struct spanhash_top *hash_chars(struct repository *r,
 			      st_mult(sizeof(struct spanhash), (size_t)1 << i)));
 	hash->alloc_log2 = i;
 	hash->free = INITIAL_FREE(i);
-	memset(hash->data, 0, sizeof(struct spanhash) * ((size_t)1 << i));
+	MEMZERO_ARRAY(hash->data, ((size_t)1 << i));
 
 	n = 0;
 	accum1 = accum2 = 0;
diff --git a/linear-assignment.c b/linear-assignment.c
index 5416cbcf40..97b4f75058 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -20,8 +20,8 @@ void compute_assignment(int column_count, int row_count, int *cost,
 	int i, j, phase;
 
 	if (column_count < 2) {
-		memset(column2row, 0, sizeof(int) * column_count);
-		memset(row2column, 0, sizeof(int) * row_count);
+		MEMZERO_ARRAY(column2row, column_count);
+		MEMZERO_ARRAY(row2column, row_count);
 		return;
 	}
 
diff --git a/shallow.c b/shallow.c
index d9cd4e219c..c20471cd7e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -713,7 +713,7 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 
 	if (used) {
 		int bitmap_size = DIV_ROUND_UP(pi.nr_bits, 32) * sizeof(uint32_t);
-		memset(used, 0, sizeof(*used) * info->shallow->nr);
+		MEMZERO_ARRAY(used, info->shallow->nr);
 		for (i = 0; i < nr_shallow; i++) {
 			const struct commit *c = lookup_commit(the_repository,
 							       &oid[shallow[i]]);
@@ -782,7 +782,7 @@ static void post_assign_shallow(struct shallow_info *info,
 
 	trace_printf_key(&trace_shallow, "shallow: post_assign_shallow\n");
 	if (ref_status)
-		memset(ref_status, 0, sizeof(*ref_status) * info->ref->nr);
+		MEMZERO_ARRAY(ref_status, info->ref->nr);
 
 	/* Remove unreachable shallow commits from "theirs" */
 	for (i = dst = 0; i < info->nr_theirs; i++) {
-- 
2.52.0-357-gead5eaf5b3

