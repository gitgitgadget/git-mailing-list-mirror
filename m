Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B36255248
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031798; cv=none; b=cw1BxIhnN/OOJk9C/LJyPmfoIHaU9gxNHNwt+QegwsfLNVqDJWH+yDmqnaD+1OHTj/rgO/u4JQb9YHS/vrBKWnZ4WioGNSEkZ4IavgNck0R+xKxWnuQgKYz+Gizjyykmx3OYsQUZwuaPzMK6KL4EnfisbuuIO0rcJiQtB02xpGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031798; c=relaxed/simple;
	bh=l6WJnQBcNmLkTNNSjhjsA7B104zL3JpMeTI7hOFanUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gfDTA+UyqEyPvVUz4JxCX+XxLqsJYk2RMR7eNgk0hpuCbd3G2eqMLCGtK8348UeLETC+bPD6bh+C21Q0SfWLVQiwvysnISdShVNhFrCU8U2ONCI5lBuEIv1Z7ocpQlCWr7/O8ocVDgT4U7HoTfU6TNcywluOCC8uI2sEQVAngbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AFi3R9bE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlgWB7XP; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AFi3R9bE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlgWB7XP"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 047C211401D2;
	Mon,  7 Apr 2025 09:16:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 07 Apr 2025 09:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031796;
	 x=1744118196; bh=d5gUcCMqkjk2qFZG6aNfmROI9AnThXvIZvc0vtu75ZI=; b=
	AFi3R9bEVQ6HNQ/b35MzDEolcFKurokSvuaS48Qy5ZAbUObN07YNDWAvjsoM5duJ
	Dh/GyUpRZdbsTTAQiNEt+YkYMh/MgDpo63bqg0aFI95DtU3UA32hFyc/8RvUh9Tz
	rMUokbAXaVbhGi0P7RY2hAu0VlhlUN00NIZ1BUVT7eYUxukrCjHc+yLRX2jU/s7d
	hT9tDstm2die+P1ncNVePhW6UYxP7QI0L4R+tAI16m2YpQxKKcf9Gj9vCefkrRHP
	5zbG8jhatPKdjJ5e8FYyjUJom+j5p9Ai0IPSKidXCCi3zZj2zZ2vUYnSc7kHHwv4
	oCoHZtuP+q2M0hsQeunZ+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031796; x=
	1744118196; bh=d5gUcCMqkjk2qFZG6aNfmROI9AnThXvIZvc0vtu75ZI=; b=U
	lgWB7XPPNRR7cKqH+yOxISA7wWj/QE0cf1NxCw2SQ+t6ToONDMzNW2EMZH9wUBlN
	0iT7TeZrDT58JbIVdek7dtVRBokKnfq7k7lDJkoNPzK9HxlWdZZHWt8ztPhtubnz
	/o/4vYWLszJXTnZM5sWamJ96jwSEm2eF6hJnGuHcStHBS4St4rxYZo6n1HdgngTi
	d1b5COqrcgaDYfaBvJghTe5Lm9OMgoJIxaQFRp9aCMla/VtgkwUAzBU/uKYkHWmz
	xwq5pXJMfSA/KNeEf+7l7CohAK55Nn/DxodV5jYVo0b+3A5LD1dagVNgpytJjqOb
	2tL3yMVXP8mNonX8wmqBA==
X-ME-Sender: <xms:M9DzZ__-3y_TAhr_pDor7rw4Hlt3zhIMeHdOzeD3AdNnbvvjhM-6Fw>
    <xme:M9DzZ7vIgh7GZos2Ei4H5DIcDE-EZTN6AHcCA4gtjMMrf7u3GMygWA1rOweCMLls5
    tJWdQ5eWHo57fD0AA>
X-ME-Received: <xmr:M9DzZ9DRy6vZdiP0GfJ-wqEmDYvgPLkJhkO1mZyJ3UhNl93rMWSy8hpOw-5akuVgcWlOdVERAT65-zTh_DxKp2tkiW12rS2AOFkOU8VhzMdH5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:M9DzZ7eh7FQiE7xOrz38gAlLBYKxQG-Ojl6UWDJesc7H91CZSgBMKQ>
    <xmx:M9DzZ0MJA8U7OyFrLz0V0yFCfcDdBbX66o4JDGdVHCLrSYBQE7UQQg>
    <xmx:M9DzZ9m_R8EXKAE6YLLc8Gct45hgvY9S32nVTSsPfEfkFgbZzp7yeg>
    <xmx:M9DzZ-s2kz4ZiOO2JSNDH37ZcW61deGRFdtUAuQ03ueI_xwQVS3abA>
    <xmx:M9DzZ46WIfcKRLXoqgZkyyCQDLYkiGzW_SgfYa3iC0aktiv7NwLHWiAg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:34 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3fa9e5f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:25 +0200
Subject: [PATCH v2 13/16] reftable/table: add `reftable_table` to the
 public interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-13-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `reftable_table` interface is an internal implementation detail that
callers have no access to. Having direct access to this structure is
important though for a subsequent patch series that will implement
consistency checks for the reftable backend.

Move the structure into "reftable-table.h" so that it part of the public
interface.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-table.h | 32 +++++++++++++++++++++++++++++++-
 reftable/table.h          | 33 ---------------------------------
 2 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/reftable/reftable-table.h b/reftable/reftable-table.h
index 94379026727..a78db9eea7e 100644
--- a/reftable/reftable-table.h
+++ b/reftable/reftable-table.h
@@ -20,8 +20,38 @@
  * reftable_merged_table and struct reftable_stack.
  */
 
+/* Metadata for a block type. */
+struct reftable_table_offsets {
+	int is_present;
+	uint64_t offset;
+	uint64_t index_offset;
+};
+
 /* The table struct is a handle to an open reftable file. */
-struct reftable_table;
+struct reftable_table {
+	/* for convenience, associate a name with the instance. */
+	char *name;
+	struct reftable_block_source source;
+
+	/* Size of the file, excluding the footer. */
+	uint64_t size;
+
+	/* The hash function used for ref records. */
+	enum reftable_hash hash_id;
+
+	uint32_t block_size;
+	uint64_t min_update_index;
+	uint64_t max_update_index;
+	/* Length of the OID keys in the 'o' section */
+	int object_id_len;
+	int version;
+
+	struct reftable_table_offsets ref_offsets;
+	struct reftable_table_offsets obj_offsets;
+	struct reftable_table_offsets log_offsets;
+
+	uint64_t refcount;
+};
 
 /* reftable_table_new opens a reftable for reading. If successful,
  * returns 0 code and sets pp. The name is used for creating a
diff --git a/reftable/table.h b/reftable/table.h
index e15d58d8e9e..c54703e6210 100644
--- a/reftable/table.h
+++ b/reftable/table.h
@@ -14,39 +14,6 @@
 #include "reftable-iterator.h"
 #include "reftable-table.h"
 
-/* metadata for a block type */
-struct reftable_table_offsets {
-	int is_present;
-	uint64_t offset;
-	uint64_t index_offset;
-};
-
-/* The state for reading a reftable file. */
-struct reftable_table {
-	/* for convenience, associate a name with the instance. */
-	char *name;
-	struct reftable_block_source source;
-
-	/* Size of the file, excluding the footer. */
-	uint64_t size;
-
-	/* The hash function used for ref records. */
-	enum reftable_hash hash_id;
-
-	uint32_t block_size;
-	uint64_t min_update_index;
-	uint64_t max_update_index;
-	/* Length of the OID keys in the 'o' section */
-	int object_id_len;
-	int version;
-
-	struct reftable_table_offsets ref_offsets;
-	struct reftable_table_offsets obj_offsets;
-	struct reftable_table_offsets log_offsets;
-
-	uint64_t refcount;
-};
-
 const char *reftable_table_name(struct reftable_table *t);
 
 int table_init_iter(struct reftable_table *t,

-- 
2.49.0.604.gff1f9ca942.dirty

