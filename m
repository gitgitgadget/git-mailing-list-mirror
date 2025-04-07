Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E63A2550A5
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744031794; cv=none; b=HhPJ99UzlIZG0PLZ3wY4LfBHSWHISOyfZpw60DCgIJf2iBnElYc3Mj74tppk0V+FOLcnpKydd1WZ6idj5/6XjLwWxOH1SEn97vTvVsUHHJ7+aOjz0uSexHuyAqsLBpLsaybjVZGK0JVyuKhaQUr4ssO77hJC+9lxqCY77/kG92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744031794; c=relaxed/simple;
	bh=d76KOJKqgcun7pPgDAsx8hFXmOYxGPQdTS5kx0tTClE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Al0vaxSKw7I6JFK46s2ETMDp9Dz6/9jDE6Yp1l5gnmQKvh1K5lG5OxHfBJNLmFGtDQvFMOqrg+2lJKnQ/UK0qhRZu+hR3Q3jmZm53Yf8ezOrXGujaT72CI9WPPJeMpyGFNSJnwWFPNNEtpOVNVlMJXm5uVnpygaPtiTGvekkRUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OgJ/lOeD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m+YXJqSb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OgJ/lOeD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m+YXJqSb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 297151380333;
	Mon,  7 Apr 2025 09:16:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 07 Apr 2025 09:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744031791;
	 x=1744118191; bh=pwS9BwrKMZMUD6+4b7qHWoSaZJ3fTSjJMOA8n41VTus=; b=
	OgJ/lOeDufguvaegwxyri7BRNBWIpSa3wWDZXqPeQWWTQ2TBQd1UeWc8eO/zIQe2
	SqPMnDsV0exRVgmsoVEmPCo3XVLMcWqO1nS1dnTgwJxnqwk19ziuAZNfKCEMz738
	6W/AzO37NClyq5ck1g/ffnskGEBz6ipsXcKRMGPfC+XGVrtWoGyD9gUANxaaSszl
	RtwEtehigODnBjINL5JfJ2ZKQ4Xulq5bB3yiAPnKqnEKL3CUwO3mRlMWCEWYgH13
	vB0fTMgTjoCZcppJbyisce5GpoOgzAQ2YK40q7FQI4anUYSyfGzRuGHBaNQBJH8m
	ImLft97YlgldzgOfbs8UwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744031791; x=
	1744118191; bh=pwS9BwrKMZMUD6+4b7qHWoSaZJ3fTSjJMOA8n41VTus=; b=m
	+YXJqSbH4BsbhUWnCSodajcQM5P+ljv55kpmvqSdBv9kavQWi1J4c9yj5KGhPVlR
	QbBy0kKWhWTX2hctkwoP7gRprJMS+/IzfCPzXBiRhjA5q88VYQLO+Hv1tilEIyQc
	5lmh1R1VjyQv6qRtgN2a7jRfQ1UtDQUGhKRc4CTCKlYAr5F8sUiwzVbNDulAVvUW
	Xfr3juWxZtrMas1NIFHVOfT7BOON061ImHbmEmDb+GLnE1hS680MtHSQYvzwUGGU
	js52APtz6co8QQ4nadGB0VD+MXLnHMcKu+BklODseSMoOufb02xs4HGJANTceDmw
	ohN+/8yrzxDkRAmoGmoZw==
X-ME-Sender: <xms:LtDzZ7K3iPPpRWIE5o5sQsYzHHtp1AoDr3S6RtlVVXSQ9Htjb66B-w>
    <xme:LtDzZ_I-ToIb2pA341DnMoAuTZ6eN347qXAlJq3MO428JEcLxWG0A49Qud7MUq8S5
    PbGCvvP-ZiZQQL2wQ>
X-ME-Received: <xmr:LtDzZzuRVqJ-_WwYIu_M96UyvlpmpyEILhrCvufghd7c4fCpkDxgJXM_is8Qq555qZxe7AXqApKFscQB1VKyXoRpjkz0cim-4gv0Sb6CgMfrQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddtvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedthfegfeejuefgieffvefhvedvfedtffdtgffh
    heevgfdtjedukefgkefgfeevtdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuve
    hluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:L9DzZ0ZEnjb1WDT2QW3C6t_yDrzqXAt1qeFxbQbWMx_a1aBc7nMyWg>
    <xmx:L9DzZya6hVPQohBI7Hkn-vhjqMK8H5_6cu0PNSkoLyuZPRaNnLUS6w>
    <xmx:L9DzZ4ACHcWeT9-WWbtZapdaJwts9-gCOskrk2ix6tGEmlRilsS0iQ>
    <xmx:L9DzZwaiNr79R-WJpn6z2AZN6qdl6cEtbODHQs4i-yjgnkRbN5suUQ>
    <xmx:L9DzZ7mpgiYJyyTJNIjCyxs0uyJr6G4Jwuow0ZGUTBdbmpSog28B_7Wh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 09:16:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ee5a1226 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Apr 2025 13:16:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 07 Apr 2025 15:16:21 +0200
Subject: [PATCH v2 09/16] reftable/block: create public interface for
 reading blocks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pks-reftable-polishing-v2-9-316c4ff10571@pks.im>
References: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
In-Reply-To: <20250407-pks-reftable-polishing-v2-0-316c4ff10571@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While users of the reftable library wouldn't generally require access to
individual blocks in a reftable table, there are valid usecases where
one may require low-level access to them. One such upcoming usecase in
the Git codebase is to implement consistency checks for the reftable
library where we want to verify each block individually.

Create a public interface for reading blocks. The interface isn't yet
complete and lacks e.g. a way to read individual records from a block.
Such missing functionality will be backfilled in subsequent commits.

Note that this change also requires us to expose `reftable_buf`, which
is used by the `reftable_block_first_key()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/basics.h          |  7 -----
 reftable/block.h           | 48 +-------------------------------
 reftable/reftable-basics.h |  8 ++++++
 reftable/reftable-block.h  | 69 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 54 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index 96a2f0d3829..d8888c12629 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -18,13 +18,6 @@
 
 #define REFTABLE_UNUSED __attribute__((__unused__))
 
-struct reftable_buf {
-	size_t alloc;
-	size_t len;
-	char *buf;
-};
-#define REFTABLE_BUF_INIT { 0 }
-
 /*
  * Initialize the buffer such that it is ready for use. This is equivalent to
  * using REFTABLE_BUF_INIT for stack-allocated variables.
diff --git a/reftable/block.h b/reftable/block.h
index 422e2f872c5..4f7f29028c4 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -11,6 +11,7 @@
 
 #include "basics.h"
 #include "record.h"
+#include "reftable-block.h"
 #include "reftable-blocksource.h"
 
 /*
@@ -62,53 +63,6 @@ int block_writer_finish(struct block_writer *w);
 /* clears out internally allocated block_writer members. */
 void block_writer_release(struct block_writer *bw);
 
-/*
- * A block part of a reftable. Contains records as well as some metadata
- * describing them.
- */
-struct reftable_block {
-	/* offset of the block header; nonzero for the first block in a
-	 * reftable. */
-	uint32_t header_off;
-
-	/* the memory block */
-	struct reftable_block_data block_data;
-	uint32_t hash_size;
-
-	/* Uncompressed data for log entries. */
-	struct z_stream_s *zstream;
-	unsigned char *uncompressed_data;
-	size_t uncompressed_cap;
-
-	/*
-	 * Restart point data. Restart points are located after the block's
-	 * record data.
-	 */
-	uint16_t restart_count;
-	uint32_t restart_off;
-
-	/* size of the data in the file. For log blocks, this is the compressed
-	 * size. */
-	uint32_t full_block_size;
-	uint8_t block_type;
-};
-
-/*
- * Initialize a reftable block from the given block source.
- */
-int reftable_block_init(struct reftable_block *b,
-			struct reftable_block_source *source,
-			uint32_t offset, uint32_t header_size,
-			uint32_t table_block_size, uint32_t hash_size);
-
-void reftable_block_release(struct reftable_block *b);
-
-/* Returns the block type (eg. 'r' for refs) */
-uint8_t reftable_block_type(const struct reftable_block *b);
-
-/* Decodes the first key in the block */
-int reftable_block_first_key(const struct reftable_block *b, struct reftable_buf *key);
-
 /* Iterate over entries in a block */
 struct block_iter {
 	/* offset within the block of the next entry to read. */
diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
index ed7c7c9ac2c..6d73f19c85b 100644
--- a/reftable/reftable-basics.h
+++ b/reftable/reftable-basics.h
@@ -11,6 +11,14 @@
 
 #include <stddef.h>
 
+/* A buffer that contains arbitrary byte slices. */
+struct reftable_buf {
+	size_t alloc;
+	size_t len;
+	char *buf;
+};
+#define REFTABLE_BUF_INIT { 0 }
+
 /*
  * Hash functions understood by the reftable library. Note that the values are
  * arbitrary and somewhat random such that we can easily detect cases where the
diff --git a/reftable/reftable-block.h b/reftable/reftable-block.h
new file mode 100644
index 00000000000..13bd68be8c5
--- /dev/null
+++ b/reftable/reftable-block.h
@@ -0,0 +1,69 @@
+/*
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+ */
+
+#ifndef REFTABLE_BLOCK_H
+#define REFTABLE_BLOCK_H
+
+#include <stdint.h>
+
+#include "reftable-basics.h"
+#include "reftable-blocksource.h"
+
+struct z_stream_s;
+
+/*
+ * A block part of a reftable. Contains records as well as some metadata
+ * describing them.
+ */
+struct reftable_block {
+	/*
+	 * Offset of the block header; nonzero for the first block in a
+	 * reftable.
+	 */
+	uint32_t header_off;
+
+	/* The memory block. */
+	struct reftable_block_data block_data;
+	uint32_t hash_size;
+
+	/* Uncompressed data for log entries. */
+	struct z_stream_s *zstream;
+	unsigned char *uncompressed_data;
+	size_t uncompressed_cap;
+
+	/*
+	 * Restart point data. Restart points are located after the block's
+	 * record data.
+	 */
+	uint16_t restart_count;
+	uint32_t restart_off;
+
+	/*
+	 * Size of the data in the file. For log blocks, this is the compressed
+	 * size.
+	 */
+	uint32_t full_block_size;
+	uint8_t block_type;
+};
+
+/* Initialize a reftable block from the given block source. */
+int reftable_block_init(struct reftable_block *b,
+			struct reftable_block_source *source,
+			uint32_t offset, uint32_t header_size,
+			uint32_t table_block_size, uint32_t hash_size);
+
+/* Release resources allocated by the block. */
+void reftable_block_release(struct reftable_block *b);
+
+/* Returns the block type (eg. 'r' for refs). */
+uint8_t reftable_block_type(const struct reftable_block *b);
+
+/* Decodes the first key in the block. */
+int reftable_block_first_key(const struct reftable_block *b, struct reftable_buf *key);
+
+#endif /* REFTABLE_BLOCK_H */

-- 
2.49.0.604.gff1f9ca942.dirty

