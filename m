Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D422315
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159576; cv=none; b=TlmQOsQfQA6uHJIqC5bjXLgi0j033o4zzHi7xOIQdPnWa/ZPx5svlT4Wyp2fcUj6rWUzcMHS/xB31b/WVUqNIOh3UTmf/9x/n9yfGEpTjA/TnrKSI7tnXl6lZoeyxzxS9zaG53C8yHmcFpew97djtrEIVtWhHrDcF/JEZ48pzh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159576; c=relaxed/simple;
	bh=WqYMCCecvM6i8UGYKR3yEojkCaTJI+/SUHNBS0sRO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHT0hl2CM0I6mrB5c0TdmOhQ/xzMIeF/hD2N302AclEjbT7sbOGDAQuF7iL+udGvf+84OWIfmtO/hGcVgZJsZE8ObFsHKDxEfDrfk7aU7MF0Sc2xmJREsw1k1328TD/MWEi54eTi/RcSZANXfD2jJXkWyiXiDmE00jngeGxRWHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dJWUEtCJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MrZno9z7; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dJWUEtCJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MrZno9z7"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ABAC613801D4;
	Tue, 24 Sep 2024 02:32:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 24 Sep 2024 02:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159574; x=1727245974; bh=fr7mxK0zpl
	mqT+u9vAQsVc6MS+6rf2ad0cq8KJ7SoIA=; b=dJWUEtCJbXGKSlSe3WXFC5Xe9i
	WCmZfrhRVXnHFDXFI5GZMF61KGb6D9l1Xh2qmvMbL5yYjD/KnOBo5RRoeannz39h
	Yqc87WpK29dPmOgin9KtLDgLD//LJaYxZUov8qsarC6yr8YfxlzrJ5+qgS4xHCVl
	prLqvSRnGEmn1PNxr9CuRxMQkmWP9s78zOKnKtMBIEHEdJvZMJ85gXhPIKfL0dUn
	p2qnvuj3cM3N52jrGm71ToT60dMiAs1QNPXHX9jIT3AKUKHwvJD/+X1g8ipVdvfB
	KzekXZRpZ01PnqrkI03/luTXMwYgExrmxrU2BS9HK9LNnx9WkL9bLx5ap6Hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159574; x=1727245974; bh=fr7mxK0zplmqT+u9vAQsVc6MS+6r
	f2ad0cq8KJ7SoIA=; b=MrZno9z7KMGGxMLORUl8rlJHhKW4xfpBzquT4l9K3qc3
	KQ7uwLdQx4qmaXJPDTey9eFrBSpLb2hUvnNyKzI/C7cA1tE5auzsR6c90M5j91XN
	2kmfECb6a5pkdHElCQL3UQIbjzhGeHYlZYTuueFkS+lRKAZjnqqljixnuvT8xfGT
	FhEB4Y9lNyeWC0qJGj+UAUFxP5AoyCykZd0VbJ77bWFPaOp2dV+3deZyk0wusq0L
	w/fuN7AX+ZDMpD42sX4W/0SgwINfRqfrlWXa1iYg9gyENBHFfRtJygQIBISMSUZx
	Zgxm4gtWPU0rsEjuChszayhaKJ+8kcgYiY9pyTvK9g==
X-ME-Sender: <xms:Fl3yZn492ixTzhho5idchr8Ybl4c8PvEP6QLawFWU5lzGilITQjWHQ>
    <xme:Fl3yZs5-SWjGXUJuoPWzC_FJintXUB_jqsF-FdhVjoBTb3mo70tLaIjeM8QHUN4Pc
    8RJ7L43udcIvZyFLQ>
X-ME-Received: <xmr:Fl3yZudpgPCv3_DWN1YfGo4c-YIWjTbxwFcvZAXDxSm9c3kE10gYz7SyW_6FnnTXZ-ZKZZAg8n-rdXu08h82HwEHulvMLzXMxF2d9hn9srWDtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Fl3yZoINqv3DabgwK0b2r9E67BJfO2lQSdQ96mZrqxTl1t2zDEdH6g>
    <xmx:Fl3yZrJQpjVu-Oe7LGT9xw3vs_N9kzoByEF1q4IOrzHACEe6i6mkkg>
    <xmx:Fl3yZhzkToUWE__WXgkCxEy0aFeYJLA4NdWw7nMcjgmXU8yF0cs1gg>
    <xmx:Fl3yZnLZ9acNVTqq86VbXLHEVWxJj1jvc5Q_N0_DtGqm3ANfUghYXA>
    <xmx:Fl3yZj0xjXCEyOdAgExglX6igfGUO3F2fLX3vI5tcba0r-i3ztstKQo3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ba4aaba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:32:20 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 18/22] reftable/blocksource: handle allocation failures
Message-ID: <c41808e9d75fe4a791ffb1980fa1da6e424c9a14.1727158127.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727158127.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727158127.git.ps@pks.im>

Handle allocation failures in the blocksource code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index e93cac9bb6f..6b570751be6 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -30,6 +30,8 @@ static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
 	struct strbuf *b = v;
 	assert(off + size <= b->len);
 	REFTABLE_CALLOC_ARRAY(dest->data, size);
+	if (!dest->data)
+		return -1;
 	memcpy(dest->data, b->buf + off, size);
 	dest->len = size;
 	return size;
@@ -98,27 +100,40 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 {
 	struct file_block_source *p;
 	struct stat st;
-	int fd;
+	int fd, err;
 
 	fd = open(name, O_RDONLY);
 	if (fd < 0) {
 		if (errno == ENOENT)
 			return REFTABLE_NOT_EXIST_ERROR;
-		return -1;
+		err = -1;
+		goto out;
 	}
 
 	if (fstat(fd, &st) < 0) {
-		close(fd);
-		return REFTABLE_IO_ERROR;
+		err = REFTABLE_IO_ERROR;
+		goto out;
 	}
 
 	REFTABLE_CALLOC_ARRAY(p, 1);
+	if (!p) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	p->size = st.st_size;
 	p->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
-	close(fd);
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
 	bs->arg = p;
+
+	err = 0;
+
+out:
+	if (fd >= 0)
+		close(fd);
+	if (err < 0)
+		free(p);
 	return 0;
 }
-- 
2.46.0.551.gc5ee8f2d1c.dirty

