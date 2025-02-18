Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA50B22AE4E
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870521; cv=none; b=NsRqo+B7EHGBPUd5h/+aGSOSdJdVufrS9zXwgHW9kstnOTTV+n2zLtvC/JDhoBVfwgLwtDf15W+lxnZ2gk7nemYKCHwx12z0V4qP049v4YW+1+R+rN6UIjqgTuEvlhCg4rDorlTfO2IaiGcgrnwmSuWBF69UHY15/LrgMr4VKWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870521; c=relaxed/simple;
	bh=j48WArHjAVjo+/EVKsp1MgAa5QLMTZ6mQ/JfqdN6LMM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZyDC2bVNWLZVu+EjqUn14R6zIanF6v3xLGsCAK19XGKGfnG5fZti7iAD+JfXCkI3v7/2DYbjLrmSlDKojjyHvzSC3MdCrskd8GHm/0u2hYEnpq8LG0T3m4omxrI7QrRUQVDCg2vcJYFcbcBKgpsgbDPQ5jOBh2SniN/8AvJpheo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e31bTeX6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DBbCw23m; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e31bTeX6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DBbCw23m"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C55E9114022F;
	Tue, 18 Feb 2025 04:21:58 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 18 Feb 2025 04:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870518;
	 x=1739956918; bh=9emk5faD1f372VtXqJuCOrl7YP/RK8vn39dEGJQ5n+k=; b=
	e31bTeX6199X0s65POrtoEb1hVdJc1mo8RcJIASPMsliCgIDQ0VmuQBdQ91eSJFD
	yQcyFcGtJ7fNI/+1EcUOJed8ZqF9uEBU8qvKdrwL0VzWud0Md4TVYK4q7knjecDZ
	jgukgUjpfO8xT+MrlVelDYS50Fm2+cEfkt/HjbSCWZNn6wb75YQfcDb8kYLsgvTh
	/P/GNGCtuygbwrmy+K4kecyXT//6MozkUpTPuXq/xJZlFHd++wPE47Mzh2mBpeDJ
	yacQ91hMHwgfv/N+gTHXJ3eTkF7tiFeya38RBxq/K8vvBluSIEgKNVVxYI4V2K/l
	BaEKq3b/HYm87RR3SEKPNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870518; x=
	1739956918; bh=9emk5faD1f372VtXqJuCOrl7YP/RK8vn39dEGJQ5n+k=; b=D
	BbCw23mR3dPHD+1L5MLZg1m+mwriBBDgBarBmD0lRztyZC8whdpZ7F1pNHUd+QqV
	6SOiL2Yvu3GYBv0+sUUBok1bXTvcDzLRnFfFAomaDm+SPWHSGMFFl8VpvN4ZlDVM
	kk0lp7Mu+DkZcYbMsC73WRXUp6smwDF+s+6cmRGpbFps5T4BBI1MEQbwxzlxgibf
	Kpc5doTXLAzV6JhJ1n62agwsY6+bLGg1IuoWQ9F8iJ+kE3k3p4QXEppLU4bbK8D4
	p2zu0TED22I+tGv93f7+7TFyty0+Wr8I793YYYGb2mXsZQgW/XsDWKFKJWI4wocu
	+iSgDTloNuNVyAcz5AcpQ==
X-ME-Sender: <xms:NlG0Z2mm-9D5321J7FwTWJvqo0yso71B1BJGah-DuQ8rOaFLn17dPw>
    <xme:NlG0Z91MatGchtfJgo00iVNnLwUqP0_d_C9bCZ-2Bcuqg9mmUHA0agT9xasGLT8Af
    9zKYAy6xjt27WoRQA>
X-ME-Received: <xmr:NlG0Z0qgbSSPsVGnGHb5dCVy4wRlE4iqsswkgrpHQ67oD6zJEwL7ZrhUnKHhNB97LDoJp_aKFtYSXks4gzvOmo6s08bk1GSk8c2Q7wh-p0Yx2jM8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshho
    nhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NlG0Z6knyzUo97LeEhVq1MgSOaqZBGp-JR8OGnHMZX4nMasFx-oROA>
    <xmx:NlG0Z019Mcfid6BXvrL2pe3ntbyD7hVKhvQqy6LABjYjZzrahDnM6w>
    <xmx:NlG0ZxskiBBQFUfKMrHNRYXNWSAk5OY81EpwoemHdqd3Tlu_inKHXw>
    <xmx:NlG0ZwUz6X-UsHoXJNLmjQ4cU8tR_q_70Vclf4YV1SBdqMYA6RdvEw>
    <xmx:NlG0Z-p3M3r8aWUp2nLqU6vr8xmFhnJeLD_WoaziLjeVq_Bn7Z0yTj8F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:21:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94c342a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:38 +0100
Subject: [PATCH v6 02/18] reftable/stack: stop using `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-2-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

Similar to the preceding commit, drop our use of `write_in_full()` and
implement a new wrapper `reftable_write_full()` that handles this logic
for us. This is done to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1cc47b94d9c..c33f0c3333a 100644
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
@@ -1470,8 +1490,8 @@ static int stack_compact_range(struct reftable_stack *st,
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
2.48.1.666.gff9fcf71b7.dirty

