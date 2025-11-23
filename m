Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ABC15ECD7
	for <git@vger.kernel.org>; Sun, 23 Nov 2025 18:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763924393; cv=none; b=kVj5bfcGfWxKp70IgfMCkbdGYqWE1k9x6qRM7X+rX+JB1FW8OTjBVU1yU7ajDhwiyGwK8vj2G0ZtBZo3DhvckHLvsztTQUbHui9u/gBd5U7hU3GvlN9+V7AKUomls2O513XIa3uG7qe+gdP+L1hdn9oW//FLlfRlBPJgw4EEr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763924393; c=relaxed/simple;
	bh=btb42P3kHIXabFxoOSEXLKkAJxvS54tT91LTtAM0/eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DpNx2Cd2BLgBifvAEBJeNkVolMBXEAlZFy52AIpDRr8m1OH+BX468Tm5XoOZ8bokt5ThKS775pqKBqxCCu4NjF/dQprbYSvDl2MB7Edw1jBLVRp25tQxjq63odrJrTaDnQKqCwc5a99VDO8A8XcZCf+yCddvKURg8R6rn0pPYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PHYJqfdI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WP6L1Ex7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PHYJqfdI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WP6L1Ex7"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3267F7A0091;
	Sun, 23 Nov 2025 13:59:50 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sun, 23 Nov 2025 13:59:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763924390;
	 x=1764010790; bh=gyWKqIQh/wGdlzd4q+swOQ9IKfoVwpymQm44k+SnCas=; b=
	PHYJqfdIBe6efYAZO4IbuK6L3UJ+dACsteeW+FxGZ6/XyUVXYaLg0hR+dV2dk1tc
	FKWXtR/PaZqZYTxiHMK4e6vcarEHi361SYIEpUbkx3bI8KmBTJ+iBr0O5DxzMPAU
	P/r1DXRqFiNBtFX3479Y7FE9MaxdPfSHl9eR2OO0VUbWP7edO3170zbUAv15g5sS
	hrj3C+IHapVTkWTKZT+tnCeFT8YDwPUXCN6C2fREcCUFzHQDU4UNf/jizSnFpMkU
	U2jRr+eVpE56F1rf64cVaTuhAd8VDfyuJW8I/N9aqRla6KBJtzHmEUJVhky4AovD
	hWlabbEJsgqy5nxoEMMTyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763924390; x=
	1764010790; bh=gyWKqIQh/wGdlzd4q+swOQ9IKfoVwpymQm44k+SnCas=; b=W
	P6L1Ex7XCJwXo2JSaUpDPvoO+1k7/tV3jMGybd3b7os49l5nonsFJ2q5eKImVfV4
	+rHUFqshYcXlksIdVxPR2pGahNRQ4qXoLsDHSC/bXYhPZXzUr+oIh+nxhscZoHSb
	9ajQM5NHe5ff6NSg2U4frVHLCMRNxV/CtSbqiVqHyIz8M8JlaCIaw3kTEOybpwh6
	C+VlkZw4uCCY/lrlssTXzKXF5CXWmRzqTjx7lObyBZC+IAmfF97w/P3qe2KkcpTr
	P/gYCXKegxoCsD1aqCYtjrxzuQLB6mUzIC8smrpwVUkepjDxUJYHwSYzn8XJivze
	Kh83uW41GonqxViGnZ7iw==
X-ME-Sender: <xms:pVkjaUD6zXUfqpnYReQC7c8-jJFyZNsNUkLEvhxTpRMPMfm-E9xcFg>
    <xme:pVkjadjNt83IfTX83hlS6efU2FSwHkQKPs-vgPzH_Vku-WDG6t6rEwDT25XQVsST8
    3mzG7Wc9ypV2vnSypK8Q-B1Ea_fgfmceQ8TaqfMuvGY1wJzmd_K>
X-ME-Received: <xmr:pVkjacnCPDsgBg-eRkf0E02QzitgP_2aBXvQr-2EFuPvXhq4eFm5nuP1pK_FuK5DAMWGqSbcX2CxzNsm0zQrG0j9LrPZI82ZnMULLRB-atZztA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvfeeiheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukefffeegfedvfffgiefffeelhfekvdfhvdelieeilefhgeeihfegteehledtuden
    ucffohhmrghinhepihhntghorhgvrdhrvggrugenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:pVkjaZqTS4gVrnh2hOSMjvy_oFB0dkze1ijMiQQ_1SjLDlRJkO4zCg>
    <xmx:pVkjaVFqAzqarw0-5kjjrEOlfhBhSpGgfCVz2YNw-H43D6kzk69LMA>
    <xmx:pVkjaVxYO1TFcK6z3y77S_oJ68kXlnPyGvLrUujBV7OggsBm8cWH_w>
    <xmx:pVkjaapaYvNOUPpl_BVlvhHoHC-RPbTRnpR0_PSdALU3ZQxGPsB_Cw>
    <xmx:plkjaUHe-sXApZjI6jMo9gLtIukHzefwIzjJFQ6mszmLfaZnvQz0Z3QN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Nov 2025 13:59:48 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 592f2762 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 23 Nov 2025 18:59:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 23 Nov 2025 19:59:26 +0100
Subject: [PATCH v3 01/19] streaming: rename `git_istream` into
 `odb_read_stream`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-b4-pks-odb-read-stream-v3-1-1a129182822b@pks.im>
References: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
In-Reply-To: <20251123-b4-pks-odb-read-stream-v3-0-1a129182822b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

In the following patches we are about to make the `git_istream` more
generic so that it becomes fully controlled by the specific object
source that wants to create it. As part of these refactorings we'll
fully move the structure into the object database subsystem.

Prepare for this change by renaming the structure from `git_istream`
to `odb_read_stream`. This mirrors the `odb_write_stream` structure that
we already have.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c          |  2 +-
 archive-zip.c          |  2 +-
 builtin/index-pack.c   |  2 +-
 builtin/pack-objects.c |  4 ++--
 object-file.c          |  2 +-
 streaming.c            | 62 +++++++++++++++++++++++++-------------------------
 streaming.h            | 12 +++++-----
 7 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 73b63ddc41..dc1eda09e0 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -129,7 +129,7 @@ static void write_trailer(void)
  */
 static int stream_blocked(struct repository *r, const struct object_id *oid)
 {
-	struct git_istream *st;
+	struct odb_read_stream *st;
 	enum object_type type;
 	unsigned long sz;
 	char buf[BLOCKSIZE];
diff --git a/archive-zip.c b/archive-zip.c
index bea5bdd43d..40a9c93ff9 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -309,7 +309,7 @@ static int write_zip_entry(struct archiver_args *args,
 	enum zip_method method;
 	unsigned char *out;
 	void *deflated = NULL;
-	struct git_istream *stream = NULL;
+	struct odb_read_stream *stream = NULL;
 	unsigned long flags = 0;
 	int is_binary = -1;
 	const char *path_without_prefix = path + args->baselen;
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 2b78ba7fe4..5f90f12f92 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -762,7 +762,7 @@ static void find_ref_delta_children(const struct object_id *oid,
 
 struct compare_data {
 	struct object_entry *entry;
-	struct git_istream *st;
+	struct odb_read_stream *st;
 	unsigned char *buf;
 	unsigned long buf_size;
 };
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 69e80b1443..c693d948e1 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -404,7 +404,7 @@ static unsigned long do_compress(void **pptr, unsigned long size)
 	return stream.total_out;
 }
 
-static unsigned long write_large_blob_data(struct git_istream *st, struct hashfile *f,
+static unsigned long write_large_blob_data(struct odb_read_stream *st, struct hashfile *f,
 					   const struct object_id *oid)
 {
 	git_zstream stream;
@@ -513,7 +513,7 @@ static unsigned long write_no_reuse_object(struct hashfile *f, struct object_ent
 	unsigned hdrlen;
 	enum object_type type;
 	void *buf;
-	struct git_istream *st = NULL;
+	struct odb_read_stream *st = NULL;
 	const unsigned hashsz = the_hash_algo->rawsz;
 
 	if (!usable_delta) {
diff --git a/object-file.c b/object-file.c
index 811c569ed3..b62b21a452 100644
--- a/object-file.c
+++ b/object-file.c
@@ -134,7 +134,7 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	struct object_id real_oid;
 	unsigned long size;
 	enum object_type obj_type;
-	struct git_istream *st;
+	struct odb_read_stream *st;
 	struct git_hash_ctx c;
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen;
diff --git a/streaming.c b/streaming.c
index 00ad649ae3..1fb4b7c1c0 100644
--- a/streaming.c
+++ b/streaming.c
@@ -14,17 +14,17 @@
 #include "replace-object.h"
 #include "packfile.h"
 
-typedef int (*open_istream_fn)(struct git_istream *,
+typedef int (*open_istream_fn)(struct odb_read_stream *,
 			       struct repository *,
 			       const struct object_id *,
 			       enum object_type *);
-typedef int (*close_istream_fn)(struct git_istream *);
-typedef ssize_t (*read_istream_fn)(struct git_istream *, char *, size_t);
+typedef int (*close_istream_fn)(struct odb_read_stream *);
+typedef ssize_t (*read_istream_fn)(struct odb_read_stream *, char *, size_t);
 
 #define FILTER_BUFFER (1024*16)
 
 struct filtered_istream {
-	struct git_istream *upstream;
+	struct odb_read_stream *upstream;
 	struct stream_filter *filter;
 	char ibuf[FILTER_BUFFER];
 	char obuf[FILTER_BUFFER];
@@ -33,7 +33,7 @@ struct filtered_istream {
 	int input_finished;
 };
 
-struct git_istream {
+struct odb_read_stream {
 	open_istream_fn open;
 	close_istream_fn close;
 	read_istream_fn read;
@@ -71,7 +71,7 @@ struct git_istream {
  *
  *****************************************************************/
 
-static void close_deflated_stream(struct git_istream *st)
+static void close_deflated_stream(struct odb_read_stream *st)
 {
 	if (st->z_state == z_used)
 		git_inflate_end(&st->z);
@@ -84,13 +84,13 @@ static void close_deflated_stream(struct git_istream *st)
  *
  *****************************************************************/
 
-static int close_istream_filtered(struct git_istream *st)
+static int close_istream_filtered(struct odb_read_stream *st)
 {
 	free_stream_filter(st->u.filtered.filter);
 	return close_istream(st->u.filtered.upstream);
 }
 
-static ssize_t read_istream_filtered(struct git_istream *st, char *buf,
+static ssize_t read_istream_filtered(struct odb_read_stream *st, char *buf,
 				     size_t sz)
 {
 	struct filtered_istream *fs = &(st->u.filtered);
@@ -150,10 +150,10 @@ static ssize_t read_istream_filtered(struct git_istream *st, char *buf,
 	return filled;
 }
 
-static struct git_istream *attach_stream_filter(struct git_istream *st,
-						struct stream_filter *filter)
+static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
+						    struct stream_filter *filter)
 {
-	struct git_istream *ifs = xmalloc(sizeof(*ifs));
+	struct odb_read_stream *ifs = xmalloc(sizeof(*ifs));
 	struct filtered_istream *fs = &(ifs->u.filtered);
 
 	ifs->close = close_istream_filtered;
@@ -173,7 +173,7 @@ static struct git_istream *attach_stream_filter(struct git_istream *st,
  *
  *****************************************************************/
 
-static ssize_t read_istream_loose(struct git_istream *st, char *buf, size_t sz)
+static ssize_t read_istream_loose(struct odb_read_stream *st, char *buf, size_t sz)
 {
 	size_t total_read = 0;
 
@@ -218,14 +218,14 @@ static ssize_t read_istream_loose(struct git_istream *st, char *buf, size_t sz)
 	return total_read;
 }
 
-static int close_istream_loose(struct git_istream *st)
+static int close_istream_loose(struct odb_read_stream *st)
 {
 	close_deflated_stream(st);
 	munmap(st->u.loose.mapped, st->u.loose.mapsize);
 	return 0;
 }
 
-static int open_istream_loose(struct git_istream *st, struct repository *r,
+static int open_istream_loose(struct odb_read_stream *st, struct repository *r,
 			      const struct object_id *oid,
 			      enum object_type *type)
 {
@@ -277,7 +277,7 @@ static int open_istream_loose(struct git_istream *st, struct repository *r,
  *
  *****************************************************************/
 
-static ssize_t read_istream_pack_non_delta(struct git_istream *st, char *buf,
+static ssize_t read_istream_pack_non_delta(struct odb_read_stream *st, char *buf,
 					   size_t sz)
 {
 	size_t total_read = 0;
@@ -336,13 +336,13 @@ static ssize_t read_istream_pack_non_delta(struct git_istream *st, char *buf,
 	return total_read;
 }
 
-static int close_istream_pack_non_delta(struct git_istream *st)
+static int close_istream_pack_non_delta(struct odb_read_stream *st)
 {
 	close_deflated_stream(st);
 	return 0;
 }
 
-static int open_istream_pack_non_delta(struct git_istream *st,
+static int open_istream_pack_non_delta(struct odb_read_stream *st,
 				       struct repository *r UNUSED,
 				       const struct object_id *oid UNUSED,
 				       enum object_type *type UNUSED)
@@ -380,13 +380,13 @@ static int open_istream_pack_non_delta(struct git_istream *st,
  *
  *****************************************************************/
 
-static int close_istream_incore(struct git_istream *st)
+static int close_istream_incore(struct odb_read_stream *st)
 {
 	free(st->u.incore.buf);
 	return 0;
 }
 
-static ssize_t read_istream_incore(struct git_istream *st, char *buf, size_t sz)
+static ssize_t read_istream_incore(struct odb_read_stream *st, char *buf, size_t sz)
 {
 	size_t read_size = sz;
 	size_t remainder = st->size - st->u.incore.read_ptr;
@@ -400,7 +400,7 @@ static ssize_t read_istream_incore(struct git_istream *st, char *buf, size_t sz)
 	return read_size;
 }
 
-static int open_istream_incore(struct git_istream *st, struct repository *r,
+static int open_istream_incore(struct odb_read_stream *st, struct repository *r,
 			       const struct object_id *oid, enum object_type *type)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
@@ -420,7 +420,7 @@ static int open_istream_incore(struct git_istream *st, struct repository *r,
  * static helpers variables and functions for users of streaming interface
  *****************************************************************************/
 
-static int istream_source(struct git_istream *st,
+static int istream_source(struct odb_read_stream *st,
 			  struct repository *r,
 			  const struct object_id *oid,
 			  enum object_type *type)
@@ -458,25 +458,25 @@ static int istream_source(struct git_istream *st,
  * Users of streaming interface
  ****************************************************************/
 
-int close_istream(struct git_istream *st)
+int close_istream(struct odb_read_stream *st)
 {
 	int r = st->close(st);
 	free(st);
 	return r;
 }
 
-ssize_t read_istream(struct git_istream *st, void *buf, size_t sz)
+ssize_t read_istream(struct odb_read_stream *st, void *buf, size_t sz)
 {
 	return st->read(st, buf, sz);
 }
 
-struct git_istream *open_istream(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type *type,
-				 unsigned long *size,
-				 struct stream_filter *filter)
+struct odb_read_stream *open_istream(struct repository *r,
+				     const struct object_id *oid,
+				     enum object_type *type,
+				     unsigned long *size,
+				     struct stream_filter *filter)
 {
-	struct git_istream *st = xmalloc(sizeof(*st));
+	struct odb_read_stream *st = xmalloc(sizeof(*st));
 	const struct object_id *real = lookup_replace_object(r, oid);
 	int ret = istream_source(st, r, real, type);
 
@@ -493,7 +493,7 @@ struct git_istream *open_istream(struct repository *r,
 	}
 	if (filter) {
 		/* Add "&& !is_null_stream_filter(filter)" for performance */
-		struct git_istream *nst = attach_stream_filter(st, filter);
+		struct odb_read_stream *nst = attach_stream_filter(st, filter);
 		if (!nst) {
 			close_istream(st);
 			return NULL;
@@ -508,7 +508,7 @@ struct git_istream *open_istream(struct repository *r,
 int stream_blob_to_fd(int fd, const struct object_id *oid, struct stream_filter *filter,
 		      int can_seek)
 {
-	struct git_istream *st;
+	struct odb_read_stream *st;
 	enum object_type type;
 	unsigned long sz;
 	ssize_t kept = 0;
diff --git a/streaming.h b/streaming.h
index bd27f59e57..f5ff5d7ac9 100644
--- a/streaming.h
+++ b/streaming.h
@@ -7,14 +7,14 @@
 #include "object.h"
 
 /* opaque */
-struct git_istream;
+struct odb_read_stream;
 struct stream_filter;
 
-struct git_istream *open_istream(struct repository *, const struct object_id *,
-				 enum object_type *, unsigned long *,
-				 struct stream_filter *);
-int close_istream(struct git_istream *);
-ssize_t read_istream(struct git_istream *, void *, size_t);
+struct odb_read_stream *open_istream(struct repository *, const struct object_id *,
+				     enum object_type *, unsigned long *,
+				     struct stream_filter *);
+int close_istream(struct odb_read_stream *);
+ssize_t read_istream(struct odb_read_stream *, void *, size_t);
 
 int stream_blob_to_fd(int fd, const struct object_id *, struct stream_filter *, int can_seek);
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

