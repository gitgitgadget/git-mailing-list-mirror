Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4191DE3B7
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022131; cv=none; b=C6rk93SbVdBnUE5vm7IRlOxXcDcC9V5HB0a+ovFNlbMMtriRvQMcaKDg0s8ANDfaG4sk6T29EPu04wLu+TvjMTN1QxUhuHI5urVOgj80f5vylaqi+5w0L1j1KSO5VGYvPIC9XHdjiQ7/xf4+tEdvutV9crNG18j99Ph9OPtptnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022131; c=relaxed/simple;
	bh=KHATIjskoB4bhJF+0J+m+X9nHi1qhOtXWq5B4Y/S02s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B9bNznp5ecncPdKaKvupCZC/PyPTRzwHW1dxGpIt5O/ToinupUdlEFvqvODbjfPgc0tE+bNsDmXQyqV6/Sbge6vjw4Wfl/kQm+lTxOxW1L4zCY7c7w0qvr3pLSioPRcyhZR77Wkkuh1/GxYZIdTmIYlHP47ncE3kGODFzJRykFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F4OkGeES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wwWiDo1D; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F4OkGeES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wwWiDo1D"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B2FD2540115
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:49 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 05:08:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022129;
	 x=1737108529; bh=GIzFW0s1680vF9ZEfl1E8iPBDs2KKkZmm+XTbQT8FjQ=; b=
	F4OkGeESiN/TAOqnGoFWjJbTFZWFpyDlgsgSi76wFmbIWKWqIR+IbzZ/QU6ed5Iw
	aBl1T0Gh34D3cNyNNljCa7RE+bvocQkZi+AXNlJggQJKgRTu5hpyZJW25pDMetYb
	Ex4YQUt3z4IlrvptKMYp00UUTdL75oWQt8+HBtVnje02RCA8TlluK8TFbkv3Ex9F
	HGJ/dEvxbQH4trS2yrLmSg5Ucl/t7HKHr0uIgoAQ6a2DiW0A/tu0z0jg5fTURA7Z
	1HJ/2WbVz+ZnJiFpud9Q7+PHbgorExmS/xKbr3WEhEUGQ2gJzQFz6J89V+qAS/ql
	ikSACTBmtq+D0Iz2lxDVrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022129; x=
	1737108529; bh=GIzFW0s1680vF9ZEfl1E8iPBDs2KKkZmm+XTbQT8FjQ=; b=w
	wWiDo1D8Ipx136bPc/vYFgN7jKQskKXLzOPJvMMl9XfbC3a4mCHGRBtIbXDvhVX+
	sFTGdxxGgdubJ/ufOuHSaMr56+WXoIVaahXVDqXvXCl1LAGEkXTTccTGTDvqAK6o
	+nNnzR5Z6ST0fQ4WeoLfnKLjw0bZ1PHZuZOy8GRPngA3rwi53OxxbpImHN3TdzJ/
	B2Pew3olH0eK22DqqbhZmdluudqIZaTNOihKwdBxc8mDf88XBuiSwO3km7ujsaXt
	8QwAe03YD2m2SKCeCMNBJhyd1J/5mHYrbwywxDz+fYdRTroxJPBKXM1MKGQ26lqU
	D38f6XJLmpEScmRaB8pcQ==
X-ME-Sender: <xms:sdqIZ-7VY30mnqoFxpn6Otaw0_kOjXR9BcSJ0GSoYVlSUjU-rHgc7g>
    <xme:sdqIZ34GFPmI_VKBxzkm_exPpptKTugWwo7COOiWpeBLlGrixFEDpKiw5de29OYYs
    umdgXaAgCzq7RCLMw>
X-ME-Received: <xmr:sdqIZ9dP5EKtyimIOtF35zPfM3f4e8Hdg1-yp-KUZVV3EFlbEA5kPd6S4QOgFhT2-zA5uSRyH_WAoSVNoXnF6szY0f8X_vTLF9T7UI-M2gsU7VXN5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sdqIZ7KUCOxMR8kZCTpub3KHVOWWPbuZ2CH4waOHThW36lG44AwE_A>
    <xmx:sdqIZyIAm-FupN6vP4Nk_9qyuY3Idte7kGHDYZPfLB8ZE4NUpXabEQ>
    <xmx:sdqIZ8w2XG3REEROYQ4mJeBaftpKWy_htw-OLpB1iE5SOst6phIDPQ>
    <xmx:sdqIZ2IuLEgEd75-yuw8IQqQVAApoIUqtVkK6ogHEEzgi1epjm1tDg>
    <xmx:sdqIZ0jEhujAx53sa7XJ0P79K6fLKboKJ38T-7nB0tZ2oSD-74IG6rRX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:48 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f6f935d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:41 +0100
Subject: [PATCH 09/10] reftable/blocksource: adjust `read_block()` to
 return `ssize_t`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-9-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `block_source_read_block()` function and its implementations return
an integer as a result that reflects either the number of bytes read, or
an error. As such its return type, a signed integer, isn't wrong, but it
doesn't give the reader a good hint what it actually returns.

Refactor the function to return an `ssize_t` instead, which is typical
for functions similar to read(3p) and should thus give readers a better
signal what they can expect as a result.

Adjust callers to better handle the returned value to avoid warnings
with -Wsign-compare. One of these callers is `reader_get_block()`, whose
return value is only ever used by its callers to figure out whether or
not the read was successful. So instead of bubbling up the `ssize_t`
there, too, we adapt it to only indicate success or errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c          |  8 ++++----
 reftable/reader.c               | 30 +++++++++++++++++-------------
 reftable/reader.h               |  6 +++---
 reftable/reftable-blocksource.h | 11 +++++++----
 4 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 52e0915a67..bba4a45b98 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -24,8 +24,8 @@ static void reftable_buf_close(void *b UNUSED)
 {
 }
 
-static int reftable_buf_read_block(void *v, struct reftable_block *dest,
-				   uint64_t off, uint32_t size)
+static ssize_t reftable_buf_read_block(void *v, struct reftable_block *dest,
+				       uint64_t off, uint32_t size)
 {
 	struct reftable_buf *b = v;
 	assert(off + size <= b->len);
@@ -78,8 +78,8 @@ static void file_close(void *v)
 	reftable_free(b);
 }
 
-static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
-			   uint32_t size)
+static ssize_t file_read_block(void *v, struct reftable_block *dest, uint64_t off,
+			       uint32_t size)
 {
 	struct file_block_source *b = v;
 	assert(off + size <= b->size);
diff --git a/reftable/reader.c b/reftable/reader.c
index 9df8a5ecb1..3f2e4b2800 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -20,11 +20,11 @@ uint64_t block_source_size(struct reftable_block_source *source)
 	return source->ops->size(source->arg);
 }
 
-int block_source_read_block(struct reftable_block_source *source,
-			    struct reftable_block *dest, uint64_t off,
-			    uint32_t size)
+ssize_t block_source_read_block(struct reftable_block_source *source,
+				struct reftable_block *dest, uint64_t off,
+				uint32_t size)
 {
-	int result = source->ops->read_block(source->arg, dest, off, size);
+	ssize_t result = source->ops->read_block(source->arg, dest, off, size);
 	dest->source = *source;
 	return result;
 }
@@ -57,14 +57,17 @@ static int reader_get_block(struct reftable_reader *r,
 			    struct reftable_block *dest, uint64_t off,
 			    uint32_t sz)
 {
+	ssize_t bytes_read;
 	if (off >= r->size)
 		return 0;
-
-	if (off + sz > r->size) {
+	if (off + sz > r->size)
 		sz = r->size - off;
-	}
 
-	return block_source_read_block(&r->source, dest, off, sz);
+	bytes_read = block_source_read_block(&r->source, dest, off, sz);
+	if (bytes_read < 0)
+		return (int)bytes_read;
+
+	return 0;
 }
 
 enum reftable_hash reftable_reader_hash_id(struct reftable_reader *r)
@@ -601,6 +604,7 @@ int reftable_reader_new(struct reftable_reader **out,
 	struct reftable_reader *r;
 	uint64_t file_size = block_source_size(source);
 	uint32_t read_size;
+	ssize_t bytes_read;
 	int err;
 
 	REFTABLE_CALLOC_ARRAY(r, 1);
@@ -619,8 +623,8 @@ int reftable_reader_new(struct reftable_reader **out,
 		goto done;
 	}
 
-	err = block_source_read_block(source, &header, 0, read_size);
-	if (err != read_size) {
+	bytes_read = block_source_read_block(source, &header, 0, read_size);
+	if (bytes_read < 0 || (size_t)bytes_read != read_size) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
@@ -645,9 +649,9 @@ int reftable_reader_new(struct reftable_reader **out,
 	r->hash_id = 0;
 	r->refcount = 1;
 
-	err = block_source_read_block(source, &footer, r->size,
-				      footer_size(r->version));
-	if (err != footer_size(r->version)) {
+	bytes_read = block_source_read_block(source, &footer, r->size,
+					     footer_size(r->version));
+	if (bytes_read < 0 || (size_t)bytes_read != footer_size(r->version)) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
diff --git a/reftable/reader.h b/reftable/reader.h
index d2b48a4849..bb72108a6f 100644
--- a/reftable/reader.h
+++ b/reftable/reader.h
@@ -16,9 +16,9 @@ license that can be found in the LICENSE file or at
 
 uint64_t block_source_size(struct reftable_block_source *source);
 
-int block_source_read_block(struct reftable_block_source *source,
-			    struct reftable_block *dest, uint64_t off,
-			    uint32_t size);
+ssize_t block_source_read_block(struct reftable_block_source *source,
+				struct reftable_block *dest, uint64_t off,
+				uint32_t size);
 void block_source_close(struct reftable_block_source *source);
 
 /* metadata for a block type */
diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index f06ad52e0a..6b326aa5ea 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -31,10 +31,13 @@ struct reftable_block_source_vtable {
 	/* returns the size of a block source */
 	uint64_t (*size)(void *source);
 
-	/* reads a segment from the block source. It is an error to read
-	   beyond the end of the block */
-	int (*read_block)(void *source, struct reftable_block *dest,
-			  uint64_t off, uint32_t size);
+	/*
+	 * Reads a segment from the block source. It is an error to read beyond
+	 * the end of the block.
+	 */
+	ssize_t (*read_block)(void *source, struct reftable_block *dest,
+			     uint64_t off, uint32_t size);
+
 	/* mark the block as read; may return the data back to malloc */
 	void (*return_block)(void *source, struct reftable_block *blockp);
 

-- 
2.48.0.257.gd3603152ad.dirty

