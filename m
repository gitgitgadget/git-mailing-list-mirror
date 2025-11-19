Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822741E0083
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538483; cv=none; b=EE73P/8JELNvdKLa4xhFPg+EInz6TzjBjUWDq/xXkRMkwGINEAzSuYRQgEggT8YFwMofBKsTgLxZ3/zkvf1Ic3uLm4D5YCXFYvdtKq5Ug7Q/MfcxZ2Vp2F3iGWj7aQ7DVaU3qvaREEyzE3+2x0HsFqntibZXZBjZtOBqm90+HuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538483; c=relaxed/simple;
	bh=35WOrkqWFL5zjegHDK6DNqKjQEY2sBfWevu47z7DBp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bvwc9BnpupoALfxnGZRL7fynKpnOiSRBwk3Sf5sEcSico9mVp42JJIBqmSSX9OWQtZexAKn08MO9KCUEByuEY0WEbK/4W4UzUEHJogASYbfp/aFNA0wVVeWsva7tBbj/FrkIkUXLSNi/RrmBYNT8tVM+p+0JrKYVKJxYTInUfA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QCOc7wz9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=glcSS8jz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QCOc7wz9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="glcSS8jz"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9FAAA1400204
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:00 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538480;
	 x=1763624880; bh=8jTwA/BOPOTnY0cRiKEhFZy9qKE3nycOXiP2+6TklAY=; b=
	QCOc7wz9T+BHzhwHpfwU6kIDd4dNevFq8g47GvCkFkQpEp7BQspEAyIQsfBLn02h
	Uky7XKVwiWl+LC9BQ6uEFQcxCGovHLCYCj4Nrd3HFH9aE/BGklpMMjKidpdq2Lhz
	1A5eLLKjIlhLVmgLNgrHEsVGvPpaz5C69nnDGlbViKOEFXh38pXLPLbEm2on69tg
	vZK9y7YvVbffMzNSD7dTu/5w5fXGz8X0YXoGc/iVL32zhB+0VPK7oRaDJfxV/7NE
	0BjYJILIsyEFOunD1h9wHXscBZvx+OoVTxaTfuOnRRL39yjlpFbJMoe0RLCNgSc1
	WQ0QMtQJrWfUb83+L3pi/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538480; x=
	1763624880; bh=8jTwA/BOPOTnY0cRiKEhFZy9qKE3nycOXiP2+6TklAY=; b=g
	lcSS8jzTqkYHIBnGC30+JkEjX+iz6iTIO2BBFAlhhKvPJVQufgrduZAbZfn9HgyA
	l5a5DCSuRzH+68GVCC51+xa/WvFENJuHRCo0Dg54NQRuEt/gYXq2+D8/hsPVcv58
	VT9G38Auws9WH3m1rtvcAl74tv84hKZ8nfdcX4bwXFgJb6cAvdL/0/oo9yBIbTOO
	aOPP7wiKIDssdpFweF1QRKrOItNLcgjHCXDwPER2loYrxm76EJkn8xiZ4k/u8Cx5
	h5mNSBMmgTeMsbBaeIfRO0f2E2b3vTAmPDa37Ane3e1BnuAvA0tvP6L0GVtcYHVf
	BRQmbeIxvRRGuFA6vSfbQ==
X-ME-Sender: <xms:MHYdacCL0x0xoOpLIgWloY35KMIZUA69frErD0LbL2wGEw9zT3L41Q>
    <xme:MHYdaVcVQb7S9pnDIfmf-ep_jA1j-NQGZ4Yr76LdMTwS3d7TgPhfOHtKUcH_Uy9Ig
    VRXr4BheR9eFpeVinJbiCkC4jY-4HLpUrUi_wjazDL4v4fJYjwp>
X-ME-Received: <xmr:MHYdaVOrOBW7MmXFlPR0HVvL9n7kecRXBLhG93iqjxE0qeqO3ZyzPiG2Vq7JcyiomJxlYc4ZoJINyml8X0IQJ5B6ApkDnJ8c3A6WwjVUpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:MHYdaX4FB0YZxWr_gGskwNj3XTSosIVTa1ckQVxk3LGk2Fa3ahxnqA>
    <xmx:MHYdaRKAORWqqNbvm7P9MypOJ2ZGT3ZbdDzT1skl-DICptvDJpF1yw>
    <xmx:MHYdaZegziBdwW6g3i4CwKjB7xLSbICFS7TCI6MCVpYrvxxFbN_pxQ>
    <xmx:MHYdaccTdaij6Q4aym0IyZL-nySHSzKpKLdNKSJnjyeU0q0JUfT1gA>
    <xmx:MHYdaXCw3_TQp4OIgmAP-a7Mj_EyursBFkOi8_RvbAZUTkMT3iS4MrGz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:48:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f02d74ad (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:10 +0100
Subject: [PATCH 10/18] streaming: move zlib stream into backends
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-10-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

While all backend-specific data is now contained in a backend-specific
structure, we still share the zlib stream across the loose and packed
objects.

Refactor the code and move it into the specific structures so that we
fully detangle the different backends from one another.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 104 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/streaming.c b/streaming.c
index 8210b21b53..572be98248 100644
--- a/streaming.c
+++ b/streaming.c
@@ -25,23 +25,8 @@ struct odb_read_stream {
 
 	enum object_type type;
 	unsigned long size; /* inflated size of full object */
-	git_zstream z;
-	enum { z_unused, z_used, z_done, z_error } z_state;
 };
 
-/*****************************************************************
- *
- * Common helpers
- *
- *****************************************************************/
-
-static void close_deflated_stream(struct odb_read_stream *st)
-{
-	if (st->z_state == z_used)
-		git_inflate_end(&st->z);
-}
-
-
 /*****************************************************************
  *
  * Filtered stream
@@ -150,6 +135,12 @@ static struct odb_read_stream *attach_stream_filter(struct odb_read_stream *st,
 
 struct odb_loose_read_stream {
 	struct odb_read_stream base;
+	git_zstream z;
+	enum {
+		ODB_LOOSE_READ_STREAM_INUSE,
+		ODB_LOOSE_READ_STREAM_DONE,
+		ODB_LOOSE_READ_STREAM_ERROR,
+	} z_state;
 	void *mapped;
 	unsigned long mapsize;
 	char hdr[32];
@@ -162,10 +153,10 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->base.z_state) {
-	case z_done:
+	switch (st->z_state) {
+	case ODB_LOOSE_READ_STREAM_DONE:
 		return 0;
-	case z_error:
+	case ODB_LOOSE_READ_STREAM_ERROR:
 		return -1;
 	default:
 		break;
@@ -183,20 +174,20 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 	while (total_read < sz) {
 		int status;
 
-		st->base.z.next_out = (unsigned char *)buf + total_read;
-		st->base.z.avail_out = sz - total_read;
-		status = git_inflate(&st->base.z, Z_FINISH);
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		status = git_inflate(&st->z, Z_FINISH);
 
-		total_read = st->base.z.next_out - (unsigned char *)buf;
+		total_read = st->z.next_out - (unsigned char *)buf;
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_done;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_DONE;
 			break;
 		}
 		if (status != Z_OK && (status != Z_BUF_ERROR || total_read < sz)) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_error;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_LOOSE_READ_STREAM_ERROR;
 			return -1;
 		}
 	}
@@ -206,7 +197,8 @@ static ssize_t read_istream_loose(struct odb_read_stream *_st, char *buf, size_t
 static int close_istream_loose(struct odb_read_stream *_st)
 {
 	struct odb_loose_read_stream *st = (struct odb_loose_read_stream *)_st;
-	close_deflated_stream(&st->base);
+	if (st->z_state == ODB_LOOSE_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
 	munmap(st->mapped, st->mapsize);
 	return 0;
 }
@@ -238,7 +230,7 @@ static int open_istream_loose(struct odb_read_stream **out,
 	 */
 	CALLOC_ARRAY(st, 1);
 
-	switch (unpack_loose_header(&st->base.z, mapped, mapsize, st->hdr,
+	switch (unpack_loose_header(&st->z, mapped, mapsize, st->hdr,
 				    sizeof(st->hdr))) {
 	case ULHR_OK:
 		break;
@@ -256,8 +248,8 @@ static int open_istream_loose(struct odb_read_stream **out,
 	st->mapped = mapped;
 	st->mapsize = mapsize;
 	st->hdr_used = strlen(st->hdr) + 1;
-	st->hdr_avail = st->base.z.total_out;
-	st->base.z_state = z_used;
+	st->hdr_avail = st->z.total_out;
+	st->z_state = ODB_LOOSE_READ_STREAM_INUSE;
 	st->base.close = close_istream_loose;
 	st->base.read = read_istream_loose;
 
@@ -265,7 +257,7 @@ static int open_istream_loose(struct odb_read_stream **out,
 
 	return 0;
 error:
-	git_inflate_end(&st->base.z);
+	git_inflate_end(&st->z);
 	munmap(st->mapped, st->mapsize);
 	free(st);
 	return -1;
@@ -281,6 +273,13 @@ static int open_istream_loose(struct odb_read_stream **out,
 struct odb_packed_read_stream {
 	struct odb_read_stream base;
 	struct packed_git *pack;
+	git_zstream z;
+	enum {
+		ODB_PACKED_READ_STREAM_UNINITIALIZED,
+		ODB_PACKED_READ_STREAM_INUSE,
+		ODB_PACKED_READ_STREAM_DONE,
+		ODB_PACKED_READ_STREAM_ERROR,
+	} z_state;
 	off_t pos;
 };
 
@@ -290,17 +289,17 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
 	size_t total_read = 0;
 
-	switch (st->base.z_state) {
-	case z_unused:
-		memset(&st->base.z, 0, sizeof(st->base.z));
-		git_inflate_init(&st->base.z);
-		st->base.z_state = z_used;
+	switch (st->z_state) {
+	case ODB_PACKED_READ_STREAM_UNINITIALIZED:
+		memset(&st->z, 0, sizeof(st->z));
+		git_inflate_init(&st->z);
+		st->z_state = ODB_PACKED_READ_STREAM_INUSE;
 		break;
-	case z_done:
+	case ODB_PACKED_READ_STREAM_DONE:
 		return 0;
-	case z_error:
+	case ODB_PACKED_READ_STREAM_ERROR:
 		return -1;
-	case z_used:
+	case ODB_PACKED_READ_STREAM_INUSE:
 		break;
 	}
 
@@ -310,20 +309,20 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 		unsigned char *mapped;
 
 		mapped = use_pack(st->pack, &window,
-				  st->pos, &st->base.z.avail_in);
+				  st->pos, &st->z.avail_in);
 
-		st->base.z.next_out = (unsigned char *)buf + total_read;
-		st->base.z.avail_out = sz - total_read;
-		st->base.z.next_in = mapped;
-		status = git_inflate(&st->base.z, Z_FINISH);
+		st->z.next_out = (unsigned char *)buf + total_read;
+		st->z.avail_out = sz - total_read;
+		st->z.next_in = mapped;
+		status = git_inflate(&st->z, Z_FINISH);
 
-		st->pos += st->base.z.next_in - mapped;
-		total_read = st->base.z.next_out - (unsigned char *)buf;
+		st->pos += st->z.next_in - mapped;
+		total_read = st->z.next_out - (unsigned char *)buf;
 		unuse_pack(&window);
 
 		if (status == Z_STREAM_END) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_done;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_PACKED_READ_STREAM_DONE;
 			break;
 		}
 
@@ -336,8 +335,8 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 		 * or truncated), then use_pack() catches that and will die().
 		 */
 		if (status != Z_OK && status != Z_BUF_ERROR) {
-			git_inflate_end(&st->base.z);
-			st->base.z_state = z_error;
+			git_inflate_end(&st->z);
+			st->z_state = ODB_PACKED_READ_STREAM_ERROR;
 			return -1;
 		}
 	}
@@ -347,7 +346,8 @@ static ssize_t read_istream_pack_non_delta(struct odb_read_stream *_st, char *bu
 static int close_istream_pack_non_delta(struct odb_read_stream *_st)
 {
 	struct odb_packed_read_stream *st = (struct odb_packed_read_stream *)_st;
-	close_deflated_stream(&st->base);
+	if (st->z_state == ODB_PACKED_READ_STREAM_INUSE)
+		git_inflate_end(&st->z);
 	return 0;
 }
 
@@ -384,7 +384,7 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
 	stream->base.read = read_istream_pack_non_delta;
 	stream->base.type = in_pack_type;
 	stream->base.size = size;
-	stream->base.z_state = z_unused;
+	stream->z_state = ODB_PACKED_READ_STREAM_UNINITIALIZED;
 	stream->pack = pack;
 	stream->pos = offset;
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

