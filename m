Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FED1DF277
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410496; cv=none; b=WPDRJoKb9gGpx/4T5p5kv/FUfJJ7lt+MkPjWS8+cl9o487QUpBYZGs1Xo3RJ38qRR2jw5btWH1CY/AcCWkeJsBwuTkvD47E3ZoUYOwgNcJ+OcjWtjRhuCO7f5dTRO8U9oMX60sbcjHRPd/j1wzBE9nzQHfQ8UoVJuRQqFYh1vUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410496; c=relaxed/simple;
	bh=l6WJnQBcNmLkTNNSjhjsA7B104zL3JpMeTI7hOFanUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQgRHlFpicVdrmdGElB7/8XI28OJ3Gfc3e0PV/KOwzD6KMryKDqc0lF03+k5kh0+2hcbYpGQjL4AL4iXSgnSYtxVNf2+Dt3c/OcinfjID+5QKKhazJJjDtThKxAOnSuB8MZupG+ae8PqwLEJmzOlYssOn/sFj4zZJoaL5R65srA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sQPAgt36; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CVLuLLOW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sQPAgt36";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CVLuLLOW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 9D6CF13833B4
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 31 Mar 2025 04:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410494;
	 x=1743496894; bh=d5gUcCMqkjk2qFZG6aNfmROI9AnThXvIZvc0vtu75ZI=; b=
	sQPAgt36urMCfGBlSbv/DRY/foY/jN4DA89TEv/Ae6uMNg0XZpMOB7Oy8HMjhye6
	repiFi/AIdOZOQAy81Gu5e//MoEJzdidZ86jBQBt5k4jZec2YAo+iG0rYH2cSNkJ
	4vLcrRA8FyjsBqTU4q/TMKCdrBPPYeWrX8nVAV6WhWqfZ13iMdNTeK/fGm69CFcM
	ttOVTmlrL9S2zkYr8ansCKDOFZYYbu51If31q2idP2b/ZMPB2B2F282INkxO22L3
	HR3YIe+WI2S8lXpskTGjcKPOmy1N7cxT0jHiO2+CfcfiDWIkilKlB/1JXPd+EiQZ
	oZhQDXiFN0jZGF6fQfsOKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410494; x=
	1743496894; bh=d5gUcCMqkjk2qFZG6aNfmROI9AnThXvIZvc0vtu75ZI=; b=C
	VLuLLOWpT96GPEUjKZE9kovU1vXSTAFDI1iyiWTDE2qM7/jINQIUqJ8bUK27czFw
	HgFHRK6ahGh/cG61UshJq7I20B/zd71gdJSjRN7YAGchwm4rsKrcvyec3FI/ujUH
	gKteOznBuvSLMsGZ6T05o/6vv1jQSW6mDG+RSIVImnuQgfi20CAvAxkBwx8sUJLx
	hZk5zZNOkfJDaNhm6i/wrJ/72JMmqP3y7O6UNFGEBd3t1vpdh/5b63bJ8XaF6YeH
	yONq0ub+LuSblvMmlMYW4P3p5SQtP16K4VxebELqsDbezQI+xwzibDoAm71dRVMf
	JKbNC9qnpE0Rp6OIUrpOw==
X-ME-Sender: <xms:PlXqZxqX2ZOpTz5N6mytlMQ5iI9AH5Nk4o2meNxfCD1815sXoKadAA>
    <xme:PlXqZzrOVJGxS-aW78pInu1WRhuJRt-dStPjai2Z5ZH7zr79ZpD1bBuASA1NIucJm
    UC23CxcP3EobNOclw>
X-ME-Received: <xmr:PlXqZ-NCPHOvLxl6D88ke83BPasPsQMVCbQNafSRda-7BU3nkkbyeEg_JQUPfbvVS6DmmWQsK1xGfIKVRV9nYBoXALiuGL0h5hq0W1x1iDRxf0L2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PlXqZ87Y5_y6MWLZoNK3tIL1PkJF-_YxElOViI98AZ1J6zY4-kaGdQ>
    <xmx:PlXqZw4orLlTgK8YURhF7jVxRFt2xN3WMDXb_b_hRyrd_rFVSy5YYQ>
    <xmx:PlXqZ0g-GEzvm2dBcG5PrRK8rVGwio92Q6lGtSbhPLJfEOqLIhKVWA>
    <xmx:PlXqZy7GRHtLtXUUiENKoc9f_z2FMGxAPNlOCHzYoDr2uDHPAzV7-g>
    <xmx:PlXqZ-Tvp_yeZi2igrwhAaEp4ju5heG0azyxRTfM8A5sTUEUH77MjULs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6c0b2664 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:31 +0200
Subject: [PATCH 13/16] reftable/table: add `reftable_table` to the public
 interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-13-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
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

