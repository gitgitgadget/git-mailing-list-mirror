Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B62253E9
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828345; cv=none; b=NNILWquUxjqi3672AOwr//S7WCryKB4yoy2cyreDwyoK/DNTSZ6pW633r8oMuECysv05kqtsZIsHr/gMfdJ7CzXBejP1MvnruRSZ0Hm/FbMd+x8SF5lM0XH4Qb9pYTBy896hZvwPA/TYaYrjvgouMJDjNyD9kfkQAmePpGwHPB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828345; c=relaxed/simple;
	bh=DRli0EDBg6LEhX0SobEDNZwu4aBVnUCI6NfiuJLblnk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKPa5ZabvO8lAc+sRi2pBmzb5Z4rytO9SY+6FmLTybchABSaVaxX/CFw0tYcFiApgtk50kgegFlYCWZPIiKF5BDXPuKoBsfYyTfe/gKbK41br4mjVeYT2aKPZNUSS8mm7jeIWGRjZFL2Gdzy1AZL5ahM+nkBUMR+p3/G9JXslI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HaUcEqRD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iz5ZXM81; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HaUcEqRD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iz5ZXM81"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0EDFD114015E;
	Thu,  6 Feb 2025 02:52:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 06 Feb 2025 02:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828342;
	 x=1738914742; bh=0gV166oCJt0XD15OCQi4cHbM6whojCeNI4Y8xLFoMoY=; b=
	HaUcEqRDvRYK5vdakiQgK0HKBlhCHG3RR7C8horI3DFYXbbNwQxbezbXYtmy7sNo
	m1ywvR3DWnc1oZjNZldwwrBgmVntdNuecOlFIlaDpxLqicd9Y72ihZzc4N8AC2Jq
	9AMoSyKf+/VsJku3VcJbQYGXvdv/8EYc6gdx2H+sXuBMrofImzJXelC9DyG+U4hY
	BB3rRY6GWQPePWszNkplCq4UdoBPW5qEnWkPleCMeXoCPoO9+vT8KWnkR8+wFJJV
	XmXFa+YPklJnXk8rRrDxpqyDTLHYM1/WmiHjhlzyAXqsqjv7vTMLI7ddH4qR5a9H
	UStXyblWsj7TPaYOtYgehg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828342; x=
	1738914742; bh=0gV166oCJt0XD15OCQi4cHbM6whojCeNI4Y8xLFoMoY=; b=i
	z5ZXM81e81VpIYyvt6F2AzHdJAjhKBKPAMOapkd0kGTjQ2wQlFT2+28RsoHwcTQn
	BNSHjOEuoWvvDAZ33TnQcC/gyX+Bf1vaiQ8vdkqEKzjGJvsH2WcK5NyLFqOKreUi
	Ui73U7+GoFePUH19PtN9yYnB4KIhlYsgHZiO/7nBHhuu98mwcwBJLJQpc3lzs18K
	a84GbUpD++zpSOwroVR614fIguEKZFpTFlvU/f/gfk5MuTb8+/zhtFlmryPOSi80
	fymV+pH4eoF4cZYgnkqOGb1+h+VfFkWcouN9dGsv3kQXEHfD7DZeLY9whZ6iWXvO
	2J/7LPx0hPGXnKcOFHiCQ==
X-ME-Sender: <xms:NWqkZ9tBNeRPYLXCxE_1lUsAtmrJpn-4d_I75gRCCBYJOx0spxeDcw>
    <xme:NWqkZ2foset5KDDvIxacV6-Z28Iw0sUo23BNtFShBpBXABuYkK3AiW8wjUDva3n9r
    T8VRQGyFQS_HwCwPw>
X-ME-Received: <xmr:NWqkZwzW4LklvpJY-okQHrbIgnEO5yZT9uxduNQYZFHtpDofZdX9RmhkCMHFpkX5TzcdZ9Bdxcrbk61YuvfuauVBMMOoZSckEGgFX5uh96io>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhr
    tghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NWqkZ0NX_SQeQbKNBtJXQSlz9ou5WkcjEo-Zh8j9r_D88BFJ5yUvrw>
    <xmx:NWqkZ98dTCSCKhX7fhhcM05U8KS_LmsMVAyaCzVlcEhl6VPIEuuRpg>
    <xmx:NWqkZ0WuuUO777RqBzXntbabqkU_R0ABWp7WpYgqsSZtWSVFN-7yxw>
    <xmx:NWqkZ-fC2phZg3gLnSdgmi0g7A1Hp2VpiW43y177-YqjubqfjGiDBg>
    <xmx:NmqkZwmVo6NINWnXUGDi4vyi-FfDHUmXUzRgWZAVkpWuHtNYuFT8grsS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:20 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d3a7f3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:04 +0100
Subject: [PATCH v4 02/18] reftable/stack: stop using `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-2-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
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

