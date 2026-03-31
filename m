Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E03D5659
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956430; cv=none; b=O3fjm1Ebxdd2Zh1qqSIJV7BLWlL3NR5tiZoPuMsJAtG3XqSqLdiK2D+4ZqkxVYxHbFNcg9RRJJ3vmPB4xWajU2sMAHYbA82QPtFtX5oAowLwY36LGBcuLyy7CSO3PFNAJ2nhH76kza9PpWzNFqNAqjODvRAc9urDQusOZC8Txxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956430; c=relaxed/simple;
	bh=0eBMxWeYVKD+YGT84BkLaTR2q6o7WAV4Z/1wy+Jmpwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnTjALHSkssNjMnt/Kx51G1EEZ8Wxvif0+mesx+lmGPkrqcLckSTZb9W6sPE6fYSYHJ/kVQRPJzsLtRlC0nZHVcWwL2LLI3ZbOZMxGtXr8RSRcNIFpcyDFcE74hmjQFyaToFKKtH+d8IEfBkDl1nW8qB6aq/f91DaX1c5olBCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CRfZ/Yso; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N8kZSGSu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CRfZ/Yso";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N8kZSGSu"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 690ACEC00FB
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 31 Mar 2026 07:27:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1774956428;
	 x=1775042828; bh=ha3rJub+GpPBYai3uJiw2E+L0XZC9cfCugFiF4NOc0I=; b=
	CRfZ/YsosrTa8IaKi/trFbpMUTTVUiEaIthPVz1N/BF4BWcgVaYxgUc8F/uivBES
	fWYKBEsbsNliYPBHtKjsrxUUrDAiklXE9EVlEjIRop+LZXrg5XCcmbvK6OGdP9Kp
	BqnvGK61BiaYWhrLmr7XbzfAn9kcPYJbbnegXn5DszOxRAOLD7L9Xy+8nYyKypxe
	4J/qumaJr/5UbjpevNbujhenQn39Ejmx3iFUFOu5FstV6MNskYjgz6P2aWz0LoVw
	hwLtRIESSuS5Q3xSZJU0Uv8E68fAw3sTjQHunBdIYLDAzNpUBoF6S5vhr2/YGZkl
	XHSedW8JizJ0DG23j81CCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774956428; x=
	1775042828; bh=ha3rJub+GpPBYai3uJiw2E+L0XZC9cfCugFiF4NOc0I=; b=N
	8kZSGSuI2et6mcUAjr2YyeUMtr+zJpQ0u4ubrEug9ccTGtePdtoeo9wlB4LncQpQ
	WEit6M4PuKOvq5/ogHNNnqSZNXL8VHWZd4NIEF24QtKq5+1OGSXoUBB7yNjKxK4K
	pWO5d0/31pN+20zGfGBPNLT8gKIS9XgvYxy7YsRJovvf8me4Av5z3w//aiD25Geb
	dNyykoqFBuhhGrrf6WxNceQrLvBdEuZ1/Daorndk474/ax+jtX+Mk6U1RhER5MYo
	4+91mRG9F/455JjKzcBnIf+JrF+zidTFfQp6RhHFV9jWE0WyAEBaLN6vcyV+wvhR
	SH6Mj9/R9+SBwbCEVFAnA==
X-ME-Sender: <xms:jK_LaUStr2JnSuuPCDt5zbz_QJJOh3WII0vY9WmlSUyQ3UGtsrVTrg>
    <xme:jK_LaYvyxzOBssU6mY6wQYXJ8F7vyH1IJKB6al24LHxzrQ6NScCdUigQeYULUZaEd
    PPsiZq-xIly9kj4yopbMhrdqsFtDeWz_-kqIHz-WOfBS6XaSDpCyhc>
X-ME-Received: <xmr:jK_LaXeSUU7oBKXYNaPAc-JKba_P8RuLO5TOLUy9Jif26nsCD__Cv9QJgaWsqaLiW-qYgsNkmgE6jnWzmnTKCeO9Ls-Ve06zIohNjOXm1FA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertd
    ejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekud
    ehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jK_LadLHe0Iz0eD8h_8v0EMoIIlv5mGHo4nWcLeZAjpzx_QJJdw6sQ>
    <xmx:jK_Lada193ZAepjJ2rpoc44pth9awY84PBne_x6Q_qvRWqHEUJWKfw>
    <xmx:jK_LaQudyStYK4XBX5bKa87Ttg6gopn2AmTnIX_w_tsIw6Kd9DogFQ>
    <xmx:jK_LaSvJEifgOA_bPqSFxyWE-RVNdYpeoZ3_yxvRLfF1kWgNWW4lBw>
    <xmx:jK_LaUX8c5soFEMuZTRptB3Bjr2kFV8kozCXQZFetQ8xR7yDbXVPVl7G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 31 Mar 2026 07:27:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b03e5028 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 31 Mar 2026 11:27:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 31 Mar 2026 13:26:51 +0200
Subject: [PATCH 5/6] reftable/system: add abstraction to mmap files
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-pks-reftable-portability-fixes-v1-5-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

In our codebase we have a couple of wrappers around mmap(3p) that allow
us to reimplement the syscall on platforms that don't have it natively,
like for example Windows. Other projects that embed the reftable library
may have a different infra though to hook up mmap wrappers, but these
are currently hard to integrate.

Provide the infrastructure to let projects easily define the mmap
interface with a custom struct and custom functions.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 19 +++++++------------
 reftable/system.c      | 20 ++++++++++++++++++++
 reftable/system.h      | 18 ++++++++++++++++++
 3 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index 573c81287f..7f7441f751 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -93,13 +93,12 @@ void block_source_from_buf(struct reftable_block_source *bs,
 }
 
 struct file_block_source {
-	uint64_t size;
-	unsigned char *data;
+	struct reftable_mmap mmap;
 };
 
 static uint64_t file_size(void *b)
 {
-	return ((struct file_block_source *)b)->size;
+	return ((struct file_block_source *)b)->mmap.size;
 }
 
 static void file_release_data(void *b REFTABLE_UNUSED, struct reftable_block_data *dest REFTABLE_UNUSED)
@@ -109,7 +108,7 @@ static void file_release_data(void *b REFTABLE_UNUSED, struct reftable_block_dat
 static void file_close(void *v)
 {
 	struct file_block_source *b = v;
-	munmap(b->data, b->size);
+	reftable_munmap(&b->mmap);
 	reftable_free(b);
 }
 
@@ -117,8 +116,8 @@ static ssize_t file_read_data(void *v, struct reftable_block_data *dest, uint64_
 			      uint32_t size)
 {
 	struct file_block_source *b = v;
-	assert(off + size <= b->size);
-	dest->data = b->data + off;
+	assert(off + size <= b->mmap.size);
+	dest->data = (unsigned char *) b->mmap.data + off;
 	dest->len = size;
 	return size;
 }
@@ -156,13 +155,9 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 		goto out;
 	}
 
-	p->size = st.st_size;
-	p->data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (p->data == MAP_FAILED) {
-		err = REFTABLE_IO_ERROR;
-		p->data = NULL;
+	err = reftable_mmap(&p->mmap, fd, st.st_size);
+	if (err < 0)
 		goto out;
-	}
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
diff --git a/reftable/system.c b/reftable/system.c
index 7aecd3859d..a5603f5f61 100644
--- a/reftable/system.c
+++ b/reftable/system.c
@@ -137,3 +137,23 @@ uint64_t reftable_time_ms(void)
 {
 	return getnanotime() / 1000000;
 }
+
+int reftable_mmap(struct reftable_mmap *out, int fd, size_t len)
+{
+	void *data = xmmap_gently(NULL, len, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (data == MAP_FAILED)
+		return REFTABLE_IO_ERROR;
+
+	out->data = data;
+	out->size = len;
+
+	return 0;
+}
+
+int reftable_munmap(struct reftable_mmap *mmap)
+{
+	if (munmap(mmap->data, mmap->size) < 0)
+		return REFTABLE_IO_ERROR;
+	memset(mmap, 0, sizeof(*mmap));
+	return 0;
+}
diff --git a/reftable/system.h b/reftable/system.h
index 6e00cd32a3..dffc717bd4 100644
--- a/reftable/system.h
+++ b/reftable/system.h
@@ -113,4 +113,22 @@ int flock_commit(struct reftable_flock *l);
 /* Report the time in milliseconds. */
 uint64_t reftable_time_ms(void);
 
+struct reftable_mmap {
+       void *data;
+       size_t size;
+       void *priv;
+};
+
+/*
+ * Map the file into memory. Returns 0 on success, a reftable error code on
+ * error.
+ */
+int reftable_mmap(struct reftable_mmap *out, int fd, size_t len);
+
+/*
+ * Unmap the file from memory. Returns 0 on success, a reftable error code on
+ * error.
+ */
+int reftable_munmap(struct reftable_mmap *mmap);
+
 #endif

-- 
2.53.0.1185.g05d4b7b318.dirty

