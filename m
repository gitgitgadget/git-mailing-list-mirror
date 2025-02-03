Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF8B1F91C5
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569829; cv=none; b=WItWH3ujFiHCaBpk2/Bl5UJ3GF/2Iazzy3XN5+vRrTm0dEJwaRdrLBUFqoWnOWgatzCJanJQ47oW46JhMaRqx0qPp3Yk6QO0OMnnFCZMDm0AAGJdx10nMXd352TlT4ligpD9QiptSjG+2fWUZuqtSYdJt3hqq6Ahspfg3BzZQ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569829; c=relaxed/simple;
	bh=etbrPyAweu+kY+NpNZyj0yN/nb9xoQzXvMiuumUAI1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KV4YDtuetL0W9uV50e9UsIRsjZxGAYPGtwRp6a+61JKf5sAH0QsAvgoV9EVvwx/Qe/jxaaj8t4uyaD7GaMJhexVPKFCKOIzIbDnxT8PvalTwfrujWhCUMc1kE6bRcyRZD1jcIRmn4I50VX6K/ceFyntjbN2vqqRH0A7giQrdl3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XljITgI1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h4hxtS3i; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XljITgI1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h4hxtS3i"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id B056B138084C;
	Mon,  3 Feb 2025 03:03:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 03 Feb 2025 03:03:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569826;
	 x=1738656226; bh=kjcRMsw9OTxXzc74JbDhsNzf5smEGa7qe85/OK0Q8PU=; b=
	XljITgI1UXsPOsfuNpCVb7z0va6zfomlpncR+gqDXrVmlvtN1Wry6uwoO9Y16D9L
	Wgg3C4fGYnk0Q5MikbzT9W9kl9sgJY81RddJIWiD3Q95nBXN5YAxTee0n1A3QoSO
	iBRVL8sFMhQ18pMh0/vq40fRPtTk3Oc1J0R6A27YCbvIk7L4fCNIKAfR7lJ4qeA0
	zjiags/eNNdlQdRQZFaKGMGBc94pHzdj4IfN4JJpKNzC9Q/kIZoLmVTHaLgMpBUv
	kMhVbHvlNZnlKAADt7QNOt/3iSPQD5XBo+OzSTxZB/BlpH9x1MYwyMOkj76mVv0y
	i0x7cc1P8jT3B0hN4rHQBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569826; x=
	1738656226; bh=kjcRMsw9OTxXzc74JbDhsNzf5smEGa7qe85/OK0Q8PU=; b=h
	4hxtS3i1ky+esAmpu2WUTwBCCqKczZAGjqizClwIqVG73Zn7omxfcYtR6CWhlYOO
	GiwPg25hzXPQ8bmwNMvAdenvga9nX+y4zhZIkK79DViBE3CmagQW+trOwxWDDcOD
	BfK767snOqx4vNSR0rM06B2ET3Cir/9D4SsWoawTaP+OTAtErGjRuV3qV3pvGkGu
	RpBR1IbEovq5cFYrLGZ00yN+7HYTDRD6tCnX5fTVW5KBKsv+tY93K49UOaUwW9iw
	8i1Zd1menbbqOFcgTkc9rQOI4ezQ3of9ot4C5NBMJPhAq4KFR159/IcvUYil2zQ3
	JCuwrPOix8pM5KUAk/UIA==
X-ME-Sender: <xms:YnigZwrq08Z0bJEz0MZd4jeZfA6Tfvx6xS91Cb_xfaduEtTJV8h0VA>
    <xme:YnigZ2q-rcFRqmwA72Pqk2hCoVRRWsdxrDpXcBgZpvg4Da-c92Lj6nVtbEgmqEsOF
    2Qf9pi1vEUTN58yJg>
X-ME-Received: <xmr:YnigZ1OnJf0CMeqEC41QQ35yV6XAeJGLcePozeBYkcChzTVKMlJR-AJeCo8PvNkBqDUzCME_CJfFNunvDm4sROcPJ4aleGujSXVsVUwNMSBVOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YnigZ348xBwb_sFSzU7JU20KZcO-86MSC4onLjG3jxqq182xUXA_VQ>
    <xmx:YnigZ_65UtJMw0H1gShyLlzkGazWt-kg283Oa6lLV1yjhKd7F-B8Tg>
    <xmx:YnigZ3gBYhuA2KDS0xtV-n83Z-FvSqGSYTP36I_4Bdn0_48n_sgkcQ>
    <xmx:YnigZ54BSpP_Thr6gV5cMAGe5UrtsWjAchVe4khFV9NqTYbofMlXUA>
    <xmx:YnigZy3mUqa8VdOVyfXzp2lN_AuhkbTydZcoYfFAEpiDAl-p_GRXOdzm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 218d41db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:33 +0100
Subject: [PATCH v3 02/18] reftable/stack: stop using `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-2-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
2.48.1.502.g6dc24dfdaf.dirty

