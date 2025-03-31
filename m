Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572361DDC23
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743410492; cv=none; b=T/fldpEUh5VcMVonSFqekTQdJq0JM1TS65X1dIbJRY26TRO3pZXTii6eWedjm1aZqyk4vHVc6h9sBj6YYu8kwZQs5FjX+rkZUWYX1PGO+w1TlMhnPI1DATaH3Y6AE8dhQU3x72BQ3HLselJ5JZ51AAsoWwfhFwppfjCo3f0N9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743410492; c=relaxed/simple;
	bh=+N3gmug5jHG1f45PjZsk/zp2ogbPSGGhC1mIRxXk5Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CO0/lw0C2A5nXwwcCUwB8rcbKbPlSC4wjMM/HzKMFzy58WJ5eJYoNVs3lUOVyd3EbZ16WLoJqJLvGPDZ0QQMD/0p12jH0zWQIA3Lx9Z/1bBVC/rQk2RRbv08/PkzoY5LEypGrmjmV4tv+G+jJ+cy5BxgfLEwiYOCPjhBUQZ8Wk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b30QDP9l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RBVoS6eU; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b30QDP9l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RBVoS6eU"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BF0641140143
	for <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 31 Mar 2025 04:41:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743410489;
	 x=1743496889; bh=M9pOyVwRk1mmMadvmR+wnR8whgzKNm+IijSwsG7+AtQ=; b=
	b30QDP9lrA3iucsIx672PEFX7dNwYW9DlfNwJaBhtc23wsrTHoHok0Ghw+JvK0tU
	GdfWP5oKl4jTZG8/+OTua3mr/ejcTJVzG5dzK65uk6dREAbES/epMxq1WCCnvUg7
	hkFAwJtQSnIqSBUEhMD5sXTTIja9glSV6Qd2/LkqsgiT+/HiBVHcAzeaMldM1rCV
	sbZzcXZSX1f2JIsBvWZYm6OkTIYAIBXqljJkz0gt8MKkgc74OIb/sDSTsyo7ilHT
	oSE0WTG73VBGYRo4umfjIrAwiJsEENRXKNuq/k3PlyTc2rfkNLDtJ0329xZU+F4z
	g+o795VnZz4WdFQ/bSjmdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743410489; x=
	1743496889; bh=M9pOyVwRk1mmMadvmR+wnR8whgzKNm+IijSwsG7+AtQ=; b=R
	BVoS6eUen6vELXZXvSVGtCYPiL9x/cOgLLsCj7QToIUA9qLtxiNRbx9VQOJiJm3J
	O9Web2JVbFhCvZfWVAzJe0gaJssozZAblrpIsDpb8IABSRe7j76hgfBVpr+8UqpF
	+0InaWaPL1JMcX2t6CXHRF29NSjqIK1XYwLFoYLzcgBWYww9VNonVKHQyNyiOC2g
	5S01JR5W/wbBYpWClXRxX2rjypCgx2+fAdbwhjQ609tMHXKeXqMOeEGP6zI/u6kx
	oVbunv3erkN8Byd74KINQThOjcNb/bRyFXCS7IlJDc9XL7g2oEr07KLsNRufJWm+
	taHah+AQaPdm3qNDsYLaw==
X-ME-Sender: <xms:OVXqZyYiF9s5Xy7vCMuLL8C2nqMAb6gi8hgz2PV1GIEoegu0tPl0WQ>
    <xme:OVXqZ1bKhci4OpKfEoPAMdgC-Bzf7ui41NAheBgIvNBJzh7j1XZ8O8W70TBjnNLgy
    FMOokaopTipqGjE0g>
X-ME-Received: <xmr:OVXqZ8_CaKc3ahdaZvwkNK3eW9DBVt8O3CzvLNmXbvMkM7Dq8DMOnksOswXzpVBCd73G45MVtsy1R0yxXuVaVofr_RXwEPsq7tgBJzifjM2yRKlX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OVXqZ0pYWMTmCpnGGGOwZtSBltabsCnRWN8GZf2qlqk0u-qoUTcPfw>
    <xmx:OVXqZ9rXa8WH8cdmdxUvhfA0y_2C6tyfqy_OfIbLoL7M2r5iM6ulgg>
    <xmx:OVXqZyRgt3yxA64fybXqE42PIOSchmrGirGl56L7PqXJIRlltNQUCw>
    <xmx:OVXqZ9rYQSY-ufW1hBtnaIrNiq2ozZCLk965YwE69P53wVxSnlptZw>
    <xmx:OVXqZ-BiQgJr8eSpMZ5XKh3SBvdRDkWfV-2ckxZJpxTx2uID01WmSAGG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 31 Mar 2025 04:41:29 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 49234d2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 31 Mar 2025 08:41:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 31 Mar 2025 10:41:26 +0200
Subject: [PATCH 08/16] git-zlib: use `struct z_stream_s` instead of typedef
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250331-pks-reftable-polishing-v1-8-ebed5247434c@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
In-Reply-To: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Throughout the Git codebase we're using the typedeffed version of
`z_stream`, which maps to `struct z_stream_s`. By using a typedef
instead of the struct it becomes somewhat harder to predeclare the
symbol so that headers depending on the struct can do so without having
to pull in "zlib-compat.h".

We don't yet have users that would really care about this: the only
users that declare `z_stream` as a pointer are in "reftable/block.h",
which is a header that is internal to the reftable library. But in the
next step we're going to expose the `struct reftable_block` publicly,
and that struct does contain a pointer to `z_stream`. And as the public
header shouldn't depend on "reftable/system.h", which is an internal
implementation detail, we won't have the typedef for `z_stream` readily
available.

Prepare for this change by using `struct z_stream_s` throughout our code
base. In case zlib-ng is used we use a define to map from `z_stream_s`
to `zng_stream_s`.

Drop the pre-declaration of `struct z_stream` while at it. This struct
does not exist in the first place, and the declaration wasn't needed
because "reftable/block.h" already includes "reftable/basics.h" which
transitively includes "reftable/system.h" and thus "git-zlib.h".

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/howto/recover-corrupted-object-harder.adoc | 4 ++--
 compat/zlib-compat.h                                     | 4 ++--
 git-zlib.h                                               | 2 +-
 reftable/block.h                                         | 6 ++----
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/Documentation/howto/recover-corrupted-object-harder.adoc b/Documentation/howto/recover-corrupted-object-harder.adoc
index 5efb4fe81ff..86a1ba75cf9 100644
--- a/Documentation/howto/recover-corrupted-object-harder.adoc
+++ b/Documentation/howto/recover-corrupted-object-harder.adoc
@@ -125,7 +125,7 @@ static int try_zlib(unsigned char *buf, int len)
 {
 	/* make this absurdly large so we don't have to loop */
 	static unsigned char out[1024*1024];
-	z_stream z;
+	struct z_stream_s z;
 	int ret;
 
 	memset(&z, 0, sizeof(z));
@@ -278,7 +278,7 @@ int main(int argc, char **argv)
 	static unsigned char buf[25 * 1024 * 1024];
 	static unsigned char out[25 * 1024 * 1024];
 	int len;
-	z_stream z;
+	struct z_stream_s z;
 	int ret;
 
 	len = read(0, buf, sizeof(buf));
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 0c60e3af331..ac082766229 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -4,8 +4,8 @@
 #ifdef HAVE_ZLIB_NG
 # include <zlib-ng.h>
 
-# define z_stream zng_stream
-#define gz_header_s zng_gz_header_s
+# define z_stream_s zng_stream_s
+# define gz_header_s zng_gz_header_s
 
 # define crc32(crc, buf, len) zng_crc32(crc, buf, len)
 
diff --git a/git-zlib.h b/git-zlib.h
index 1e8d9aabcb4..0e66fefa8c9 100644
--- a/git-zlib.h
+++ b/git-zlib.h
@@ -4,7 +4,7 @@
 #include "compat/zlib-compat.h"
 
 typedef struct git_zstream {
-	z_stream z;
+	struct z_stream_s z;
 	unsigned long avail_in;
 	unsigned long avail_out;
 	unsigned long total_in;
diff --git a/reftable/block.h b/reftable/block.h
index 880e2e61938..75bc10f63a3 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -18,7 +18,7 @@
  * allocation overhead.
  */
 struct block_writer {
-	z_stream *zstream;
+	struct z_stream_s *zstream;
 	unsigned char *compressed;
 	size_t compressed_cap;
 
@@ -62,8 +62,6 @@ int block_writer_finish(struct block_writer *w);
 /* clears out internally allocated block_writer members. */
 void block_writer_release(struct block_writer *bw);
 
-struct z_stream;
-
 /*
  * A block part of a reftable. Contains records as well as some metadata
  * describing them.
@@ -78,7 +76,7 @@ struct reftable_block {
 	uint32_t hash_size;
 
 	/* Uncompressed data for log entries. */
-	z_stream *zstream;
+	struct z_stream_s *zstream;
 	unsigned char *uncompressed_data;
 	size_t uncompressed_cap;
 

-- 
2.49.0.604.gff1f9ca942.dirty

