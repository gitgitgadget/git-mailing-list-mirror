Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A091FC7ED
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983061; cv=none; b=r9VEfBO4w+5qZiF+LkLYpEqlHTQPVJl/tryk1qychJSGwSQEdQM667e9WSXvsUb9Vc4nDXI1CDmbsytMIm1ljPXjq1GIrsfWVl8S8iVSCmD3ktAdahHKp7aSuEOZRWGa805RCB+euNSevARayhspk1L6l7TjNAedk8dSqRxh6g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983061; c=relaxed/simple;
	bh=PmJRt6fXmGoAwu59QosLn0Idv1b0404jbmWLyYpzdS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKQgiqJZ23vC5bjGRHvWJ9dEwHTJ30w4mtBUxBy3ZsMcfFMiuTKO774SOj7rtUn0uKNu+PxGUoI2BDljKeym2HDh6B8QND4u9n3Byj6x/0i4ysWzUk6ntD3V2twPJ4RQu7q2DY8FTczx8aQHbyhWt7ly9Afl9fR9Ir7sxdLa3X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AAXVe2y6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hsh+U4d5; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AAXVe2y6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hsh+U4d5"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5055A13801C4;
	Mon, 27 Jan 2025 08:04:19 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Jan 2025 08:04:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983059;
	 x=1738069459; bh=PKAhJl6MulJ8BREkwp1+4UxGCBsYnhbC1wjnWaXA8NQ=; b=
	AAXVe2y655TJ2aB95pSSBC3TqboLb1GCbUQOgrX5cmU7bwKQo7WQS1F3lvT/IfY+
	Pn94C2E7nnsS9AnqOSle6s56VbsB8AWSg2LPfOCYI4BWjx21/raJbrxEZML1G36I
	RkHwNJm9kppGaztku7QmBTR8rYD6CWDYfSYXKrFvdt2DZusEtkZXn91WQJz0yrWi
	JgmiW3FxNFuoKQG7P3HczY15xHFPEP/JVX24EUgeh3Un+knl0CF0q1Cx8KbI957l
	NTQpi4ONvrx2Pc5m+dpD4OeqH4iVHKXskQHlFQA16Ooy7eRaX3RgIbiecT0+nZnT
	CwIAfMHoINozslxRJodd4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983059; x=
	1738069459; bh=PKAhJl6MulJ8BREkwp1+4UxGCBsYnhbC1wjnWaXA8NQ=; b=H
	sh+U4d5rLjiSWQu+DJzdi/LxE2XpOWKCSz52+GP2hOYu7cN3GMiZyKWPiNAhCyUz
	tcKQ83knnVELu0IErODjAMHDgnd5S2osQgRh+FW+pcvCevhfkuTAs6P7A4rZ0dZW
	DUVu30kalVWhp7KpggI8/WzyRN4ksSCVr7bpqcbTvN2Rxd56m4KidaQnxLVtYB2/
	zxIzCPj99AG7vh/B+w/0YhHynngYlnf7XGvt0jnBpXhQ+85qbWthx9Oe8/23h39A
	mxo35kMjFiCvLN25yFQR4zabT0nFqouTBnXc9RXH2LgBBVCuHvHhNRVAZ+6Qtic2
	2iWDUlejybScYQlGOI84Q==
X-ME-Sender: <xms:U4SXZ58bVnjcgChnCWOPF7SDvIAu6-CozGXryzOa9gQp0KGzM7ryXg>
    <xme:U4SXZ9u4BDq6ZZrAuLM4J9lDhHaJzQJB1F3EFxImLNVVpzTv2zuRtRHxdyVguXt0-
    61e3zsFWl8CFXb_Nw>
X-ME-Received: <xmr:U4SXZ3DPWz2jN7Cbpgz6oTHJJM9Ys1-h2S41MnTX7GGAk6qQQKM_XKwdZvBJgrfIuYFe0SQ5x_bamI-BvDmQHrbo44Yu65K9noXKjxoDy4qO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:U4SXZ9demTxY-Jm2asf6WgnRpgflXl8uuuYzVKFkKAYZz9CmIqasFw>
    <xmx:U4SXZ-NP-rReqOegVeBw1IfOEj1MSHI9wu-eL25dbnTBBh1sCdY77w>
    <xmx:U4SXZ_mRhPJb9nGcNyjgmKgN6Mpj0qHE8cOUOGSpE1iSaeBduEMNWg>
    <xmx:U4SXZ4tuwU-7esJk4bW2cVTP5EbemNpPRZdgfATPhQ-PKztOWCBZ3Q>
    <xmx:U4SXZ3ZWfBHoqMjhS8WfPJR-MNkDMHno-TJ14gW1o_w0A6L_0QYFHuBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d51e5563 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:11 +0100
Subject: [PATCH 03/19] reftable/blocksource: stop using `xmmap()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-3-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

We use `xmmap()` to map reftables into memory. This function has two
problems:

  - It causes us to die in case the mmap fails.

  - It ties us to the Git codebase.

Refactor the code to use mmap(3p) instead with manual error checking.
Note that this function may not be the system-provided mmap(3p), but may
point to our `git_mmap()` wrapper that emulates the syscall on systems
that do not have mmap(3p) available.

Fix `reftable_block_source_from_file()` to properly bubble up the error
code in case the map(3p) call fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index bba4a45b98..02972c46f4 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -98,7 +98,7 @@ static struct reftable_block_source_vtable file_vtable = {
 int reftable_block_source_from_file(struct reftable_block_source *bs,
 				    const char *name)
 {
-	struct file_block_source *p;
+	struct file_block_source *p = NULL;
 	struct stat st;
 	int fd, err;
 
@@ -122,7 +122,12 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	p->size = st.st_size;
-	p->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	p->data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (p->data == MAP_FAILED) {
+		err = REFTABLE_IO_ERROR;
+		p->data = NULL;
+		goto out;
+	}
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
@@ -135,5 +140,5 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 		close(fd);
 	if (err < 0)
 		reftable_free(p);
-	return 0;
+	return err;
 }

-- 
2.48.1.362.g079036d154.dirty

