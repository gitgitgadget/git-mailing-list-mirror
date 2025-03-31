Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E3B1DE2C6
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410494; cv=none; b=dtGoXeuYfk94vKnrbVsWyqT8aK/J1W+G8I0HdZKILb0ZF2vB3Q8PwT/4DZ7l0nYCvQfZXelsYAVeg/4htwkM68TmWN3pLFTBiJKGjee+iYw54WQcU9AALrN2aSzbMjcrRjrOI4CY4rF1Xuk7hIrBU4TUJBXy8Uy9n0y+XbAqe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410494; c=relaxed/simple;
	bh=BbxAPT/4ImLamLOceijUVkNxCCm/oxx8dhMbs42grkI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nWfDN6WHOggjoD/nTNVWa9ujTK8fLaiCzwkUKt7/8SfoFt1kXd1AhonyZtMFii/RY2d2paNp7xvKvADOhcZEwvIqY3EjUPwO2EMrH1k5GnvwRScTRbsVUXwQmNLrzc6njr6jmIf9TmOgX802gwKnscVPvHNkTNMDVJvuiF7csD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bgNlMOnp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Am9QjsrU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bgNlMOnp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Am9QjsrU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 82E021382DE8
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:30 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 31 Mar 2025 04:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410490;
	 x=1743496890; bh=r9h8h/HNPqnifL+6IaLEqGCmNoPo/AOwpPBjNP64+jc=; b=
	bgNlMOnpO5xXUghP6L65kJsADbJnyfJfYJqdTCECkLX4kJxOoBnU+KsieVF2lJ61
	HxZNxUuy398v8sFN3ecJU3irfegA7wAIgMiSNdHTlF1o8oVaKQz+kOMj9Rx2RFFl
	lLF9sTelbBXTExtOEIQy9tMBnotr+eSHWEb6UP6DAjTSb53tsO+CbVJTiuAw7ksq
	I3L18novl9pl4F/Buuj/K9nft7c42wsRZsSlLm7QOyjWQ/U5Or+5j8t4akLahcJ2
	YVzj7ZWWejHzWyyiL+3D7sJNYVvGi/2IAFXY7TWYYnHLQ9vDapBsHHlqV/TuWO3f
	p0ZK2HrHETjSin7v0AnENw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410490; x=
	1743496890; bh=r9h8h/HNPqnifL+6IaLEqGCmNoPo/AOwpPBjNP64+jc=; b=A
	m9QjsrU/994w4JYn/s4UQS/IpbuDczTh/xttJELWGlevPQZj3zTeidX2qZDeqt6Y
	fZObqz+TOQxHnfhTVP0kIo2MER9WxMbRmOJhMRmbivmXIEnUCWnJKz2zvSmbMsJK
	xsEY2CNPSfohqMwFINGpoiLwTJbsgc/ZINT87i0s0Ocltegb+ka6VwyffjSaHMif
	dxSPw8t7N1eSxmj4z99j71SYWaXxEbpT2RPqpJHprAweGDR4AbF21fwmQArNcjbw
	4ZmHonXn5Dp4O+QAmqCGW4RdiTY94a7w6iEUyf7zMLpYipA3pDiMa9B6xrqOIA2b
	MOI9meGrsOeQrQomsHB7Q==
X-ME-Sender: <xms:OlXqZ2Wd8i83cPA9nZErnpVfhnB9lckyMIg-KndR00PSRKa0ezW-Mg>
    <xme:OlXqZynex1pjBSQOWo84fMnz0EtGJ7fMaCiYDh5NgI2o1jxbUd0AwBbsRp-q2Ovqb
    Y015wOWzhvqTWartQ>
X-ME-Received: <xmr:OlXqZ6bF3ouNy172vK22LFKONnNbLyxD1b_0O82MofVNsTYPQ2aGWredUwk3rpDzkmaZdE_Ziq1Fi0c0L7C2XXjiTG1RinUvkmbjHbh6mN-iakKl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephfffufggtgfgkfhfjgfvvefoseht
    jeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpsh
    esphhkshdrihhmqeenucggtffrrghtthgvrhhnpedthfegfeejuefgieffvefhvedvfedt
    ffdtgffhheevgfdtjedukefgkefgfeevtdenucffohhmrghinhepghhoohhglhgvrdgtoh
    hmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OlXqZ9W3WCHBD2RpHZiDctvWIEZCiND0DzSNCippMEd69e4d2oeMfQ>
    <xmx:OlXqZwloj1JRjoiGsSFSIGmTuJ99bfmIIRDZNWPVMTM0yo-aIvPSfA>
    <xmx:OlXqZyf-uTX5YswcOikQ-wwFXlh1Zvh1h1NgOJl7YCfi8weEuZO0lw>
    <xmx:OlXqZyHSGYuB1_p0c0JqSJ2022uiai_hFNMiW-VH8WWokW3aicJoWw>
    <xmx:OlXqZ8sIvV585DUdAREjI74MJL0s2N7K0cXJSn67cZ9G3_0IN39cKdKN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0726a8f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:27 +0200
Subject: [PATCH 09/16] reftable/block: create public interface for reading
 blocks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-9-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 75bc10f63a3..4f7f29028c4 100644
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
-	struct reftable_block_data block;
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
index 00000000000..ce1d9d3ce79
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
+	struct reftable_block_data block;
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

