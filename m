Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AEE1537C8
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983061; cv=none; b=mSOkBeqKiZDC6fukNSUvyWzGlfPg/tC6k+q+u30ojPIh4dzJoH0NR2GleBMS9ynxMVG3Qa3yZD1jbaTA6u19wE59v+GJFuuLRPF40KBz8TNoiySor+w5r87BUM7x//AzKJ1NNR0enmQPeb66J4WK/RwanlVEZ7I1BO7QTk6RNjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983061; c=relaxed/simple;
	bh=ZQ2XEXDcUn70nxnghchKgY/1/IPyW0wJW4m9KlBlwVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UkXRl1Z530u2WJEiXWCsXh+RIFXCdmbpMo8AUwuAgNboRTWgLVog2aMYGAbpWtdmLspvFwrYYrAKS9xzWcZQvB26+uBALCAF3Sa0ogQHfMQjv4O6hf7L/f7YhUTStirDfEoLFRfJ821U6bi9Is46kZsnmcRTQ9xcH2XLXUSuh7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mif+fHx5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IHQGqFJd; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mif+fHx5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IHQGqFJd"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 5476F1380A90;
	Mon, 27 Jan 2025 08:04:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 08:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983058;
	 x=1738069458; bh=OAfz3VQFjKoHw7bRx0dztIrW4fPn64Mv0AWtbw4sj0g=; b=
	Mif+fHx5mHtM4EaghISRNicXDnzz/yzFbuHjPtI3H2raCscKrM3ahit4FpKOuO6N
	cUlICDYZdtEZvvn5AWEHUpwTDdJPReY3q9phtetVKC6ZNK9hjLlSWTC/xZR1BZu9
	tOaSCrAzkOuYGDeSSiHc2Ybg+qD3TfDtM8kzCwQEYh2ITDIQYw/93yCkcE0qBEnC
	PQUl16j/hk5+ICHh5IzontfpnK2JFPRedTAC68MTht/e/uAflyX/ywyhKTTp9qsu
	ohgbOYmAIWSP/BzpZLyuvZxFRawVNhGsuJxLZ/Z7SYLn9B5IwYlrUrrFdXmBtHQF
	f22rXOYFJzFUptFNcua9EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983058; x=
	1738069458; bh=OAfz3VQFjKoHw7bRx0dztIrW4fPn64Mv0AWtbw4sj0g=; b=I
	HQGqFJd7TZBCCeI/IuoRC34XIvcUe0+/nCYqxVgNcmzT9ezVU7XnySrQ7V8ZtYci
	WYAXQYQD5ZAnlHcy/CCugHPZCZijWdH0UElHLh7daeukAKFvsxS4RBxlkaRxVECB
	Vje8xWOlTYZ0K4DlsuLtLc4ay1nYSsLR6pMmGp53BV+a1flpVo82jVAm4CIIsERz
	k72GoqOsJtaD9odE9DY/olDcvftECtpZB5bNHusTGipv/rS7drgf3EUmXBZ090wd
	1q7Fpe1Dq7f8Ow1cI2KJvsQ1Eh6XvUsQxqZ6isMdBXTffsAyt4H9bTpolvj4wi+6
	jBIpjrdxt5i1FoCxl/WIQ==
X-ME-Sender: <xms:UoSXZ3c04XAuslwmDcUTf-luqY6skk5qVlYx3dAVrc4wONS79C3pnw>
    <xme:UoSXZ9NcsDz-Ewc8v8rOWj5BuF9HWMsTxtuZh898cOmnEmn3IKbfk1r-qzlryOJQB
    eSjUKjdqwqUOW1tKg>
X-ME-Received: <xmr:UoSXZwhwYc5m_Lgr7X_sO0x3l1cs5EbZuAoiCDt9E-Rhh022KL6tQ67Lr-t8M2M_0x7etzZ-EELZxI7HFBOHJm6367X4bSTbo2H7ebTLZi47>
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
X-ME-Proxy: <xmx:UoSXZ49PZ-Zhcikdgkvd_cyJdFcKM8wC0dT1ROtcc0wQ3eBJdx_lAQ>
    <xmx:UoSXZzsej4F_ClHuDPOYwlMYNQwVugLlIWyGtyfh-d_wUwnocFuizQ>
    <xmx:UoSXZ3F9Y0gCG4zE3dolVoykaKUbrzROLje3P4WODm1kB7UjNEg5gA>
    <xmx:UoSXZ6OA2UkDKDpCdJfp8Lgxcclb8NPmsl498FwyovfQ-bVxqI1Xkg>
    <xmx:UoSXZ86Xi1eiiwEMjffJ21FaAoBCCmeriIyFygczEttC9d97rvqCXLXC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01f43429 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:10 +0100
Subject: [PATCH 02/19] reftable/stack: stop using `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-2-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

Similar to the preceding commit, drop our use of `write_in_full()` and
implement a new wrapper `reftable_write_full()` that handles this logic
for us. This is done to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 9490366795..5f155b344b 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -48,6 +48,25 @@ static int stack_fsync(const struct reftable_write_options *opts, int fd)
 	return fsync(fd);
 }
 
+static ssize_t reftable_write_data(int fd, const void *data, size_t size)
+{
+	size_t total_written = 0;
+	const char *p = data;
+
+	while (total_written < size) {
+		ssize_t bytes_written = write(fd, p, size - total_written);
+		if (bytes_written < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_written < 0)
+			return REFTABLE_IO_ERROR;
+
+		total_written += bytes_written;
+		p += bytes_written;
+	}
+
+	return total_written;
+}
+
 struct fd_writer {
 	const struct reftable_write_options *opts;
 	int fd;
@@ -56,7 +75,7 @@ struct fd_writer {
 static ssize_t fd_writer_write(void *arg, const void *data, size_t sz)
 {
 	struct fd_writer *writer = arg;
-	return write_in_full(writer->fd, data, sz);
+	return reftable_write_data(writer->fd, data, sz);
 }
 
 static int fd_writer_flush(void *arg)
@@ -784,7 +803,8 @@ int reftable_addition_commit(struct reftable_addition *add)
 			goto done;
 	}
 
-	err = write_in_full(add->tables_list_lock.fd, table_list.buf, table_list.len);
+	err = reftable_write_data(add->tables_list_lock.fd,
+				  table_list.buf, table_list.len);
 	reftable_buf_release(&table_list);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -1468,8 +1488,8 @@ static int stack_compact_range(struct reftable_stack *st,
 			goto done;
 	}
 
-	err = write_in_full(tables_list_lock.fd,
-			    tables_list_buf.buf, tables_list_buf.len);
+	err = reftable_write_data(tables_list_lock.fd,
+				  tables_list_buf.buf, tables_list_buf.len);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
 		unlink(new_table_path.buf);

-- 
2.48.1.362.g079036d154.dirty

