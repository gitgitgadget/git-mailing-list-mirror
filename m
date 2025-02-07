Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231821DEFF7
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929129; cv=none; b=ct6ZBXUlO9TtrlKS9FEYnNiYtBNsCXUPlsYkeIgGt075X+i8nMGwwl1q82okAZpaBT/hHpp0sRztRxQ2R49y5I7IK/tig//k2KZmbSfC4kYSehTnhrLFYk30K/0OACjoUKyPmQ0FMsO+7WNq+t/04DFTl0c4oydpROpSollj9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929129; c=relaxed/simple;
	bh=DRli0EDBg6LEhX0SobEDNZwu4aBVnUCI6NfiuJLblnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXCe+A0jTBPCDYHzNuPcA20+2+fct3CB6/s9bzn8NM1lgXX5nfPTxmKy5kcOf/IeIfesxW+tf+F2Y0OXrgOjKlbe4OtPBhDP/eV4oYNgqXKrNQ/MnEvUgz/l7Luv27pKjrMCiRA7gc/FrA1rm2ul5KtKqoHFTAfSHY+9sdaPTXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h7/Q5dYq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nwcbj+ww; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h7/Q5dYq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nwcbj+ww"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 165B713801B4;
	Fri,  7 Feb 2025 06:52:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 07 Feb 2025 06:52:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929126;
	 x=1739015526; bh=0gV166oCJt0XD15OCQi4cHbM6whojCeNI4Y8xLFoMoY=; b=
	h7/Q5dYq3h1vEuAh8hZqWVT/xn08gSSsmCYDqHTUJ1wBnNBm+kP4h1vD7KbQtd8e
	Tjva843dUkq22wBj8dLfeyO8vGnAVin4R0rXdhZIwkzzZFzxgIJLhT9uXM0ND8b2
	4qEGb3U+3z5rHACR5/XP/0MS4F918Sf/KQ3h2EVYw5ftIMJndDhVvVXLpr0662pm
	/9XcSF6PIxb49g8RgHVNuXSxUgPk/4Dcq2jz2z5MO2zXqMij4GSlZvhpTdchM1WE
	mAlzGW30sBNh76n0KbxeFOM4MBvaJjj8P77gPqNpOJFNOI0gz4AbJep0OExtA2KJ
	/gQs7x2f3iGc57EEY8byGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929126; x=
	1739015526; bh=0gV166oCJt0XD15OCQi4cHbM6whojCeNI4Y8xLFoMoY=; b=N
	wcbj+ww9PKU2f5Br4bNwrbHH6K9oNUgZ2R9Y9QFxTQ6BHvGW6mjNs2UL4YuHo12O
	eDQEosM+zQ13fobElOgnm6cCk0iiUdGnKBR+vbnmJOPpMZ2fPt7+jnkJD2iwyVV9
	dOHBN4biEPQ4NUygU+LtdjeuosDOsmMRqgFMxDOfJ+8x/OknGbl4C1Ws81+c5OcL
	LSF/JealIn142SD0kI9mBlRofw4Dmlrk49RV4Saap+ivuXeZd1e2OmAcCPZheQbi
	M95zMkJRgFt3nIHdviLc8fipE54KJ+YnaGviucbTvJKIsN5b1w7LXJFstqZleI2U
	WMT5nt7MXpUUFlLX2HOcQ==
X-ME-Sender: <xms:5fOlZwh_p2Oh_QYCkygSD6_X-_to2xXsfVucmfOO0885Q6lHUF7hDw>
    <xme:5fOlZ5BiyD0APqkUCeS_os3fZZAOfn6VIWSxLnoVjtowtXWeImxT6Dq2nxVFOx27-
    uEcBKX4hGWbl8hrcA>
X-ME-Received: <xmr:5fOlZ4Gv_wrjdTj78OgFDipnx1rPb-VIfo5TQT8oFymNXonVeZkS5r0BUvke_-mToKsORi4w8pPRlc_WZ_B-ZopTS-SFbrw6GD0xln8bAFCpwt6e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5fOlZxQMW1S2VSxqQciroriWord88-FK91lMFdQW0bOevKeF9B2ZmQ>
    <xmx:5fOlZ9zgUW4LZmrsLTLF78RJHj7SN0gzz8mq8XUe1fyPo0t3DbhHBw>
    <xmx:5fOlZ_4BmRxJqnOL_Im2eao-DJcI5YVp_JX2p7WCx55UMqYkxPsGQA>
    <xmx:5fOlZ6yetTFFLdBHUMBYlLCNOkfTmq8Cbc1mVUa6u2qeHA8O7_DTzA>
    <xmx:5vOlZwoBNR1WDLljnG9phbFA6GgOuB2KlG8JK0n2BrhtYtPegj3gkyBM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 122e2f1b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:51:57 +0100
Subject: [PATCH v5 02/18] reftable/stack: stop using `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-2-ba2adc79110f@pks.im>
References: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
In-Reply-To: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.2

Similar to the preceding commit, drop our use of `write_in_full()` and
implement a new wrapper `reftable_write_full()` that handles this logic
for us. This is done to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index d57acd9540..46abf51ec5 100644
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
2.48.1.538.gc4cfc42d60.dirty

