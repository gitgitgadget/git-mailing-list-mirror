Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859A4155CBA
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489759; cv=none; b=B3u4IbBTswMK9V86+IwdF5F8Z4OZsCei1lGOwDfOb729hl6yXc2U2yJhidVoVHfAmaqJuPGjUExAyWV/bwKgdEZbmdwIRGHiYpBftlgy1qI/Eyd35uH4TSoFy+it691cOplgUasooO4I3PyJHSSQkkUqLpe1S3AUwkD1prLWQcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489759; c=relaxed/simple;
	bh=WqYMCCecvM6i8UGYKR3yEojkCaTJI+/SUHNBS0sRO+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1cgaj0yAogGRowgtKgE5pzn3TwcPp4W8xXUq+Th+frbrsgkwFyu6g+BT2Bk28JTSCfRT/Marq48BwAApTlnfZLpjQTzivfEOslGCv7CamhEQ8r2EdrvuMVxy5OHOCR+X+F/L9iAKrP96stDan2oCVrN/j5ULL3+3FxF5BffDjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ar2XjVJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjGxbZQt; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ar2XjVJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjGxbZQt"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B2CF411401C2;
	Mon, 16 Sep 2024 08:29:16 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 08:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489756; x=1726576156; bh=fr7mxK0zpl
	mqT+u9vAQsVc6MS+6rf2ad0cq8KJ7SoIA=; b=Ar2XjVJX66x5I490qRd1pufM3s
	1OAqgf0sfEBlh2WaMrWyG3CEdwkbCr9QLnR43XUifFzOL59+I81CH1qxG0SAtFEi
	md7gBVj/162xH7+6Ep5SBoFizzVCPgsNS0UlWqUbX2XX27in6AzmgWRIEMZg036Q
	p+5WmWT6/0ul0atLEblg/bsAmUIwBacunlNUQ5jtZqu5V4KVTMc7ZVCpmEsVfMzC
	oKDjUOCjZvAaar9hgZVBUs/RoHKDltdJ5Z2d2FYOWI+/raHFoX320cejbeCJZ07m
	B0p+LPv6x8rwAr3zkS5hBkjSxRfSZ2rB9cLzQgCwfPT8JNO3SUk01WgWTC7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489756; x=1726576156; bh=fr7mxK0zplmqT+u9vAQsVc6MS+6r
	f2ad0cq8KJ7SoIA=; b=HjGxbZQtZpq0FV1Jffho8uKRVDQHk2oFy27GiAyIDns0
	97UdvtGlh0p02kOW4QTX0/Ua4Cw8hdHUgZaHasYjx3rPJXh2y03hP20ENuP0VAAc
	DuED6KMUQKFv/alEDp6ROj82izcjco3er7TSGtHqjNZhbaFzwaxCSzCdjH5ZHIEt
	9ds+vXGeG/Nq11k5ctIm0QQDvFofiQyQNUo8PCh+RDeGob6pknmsRxPJxYwZEhxI
	abRtplNK3roZfxityZdhn30pyuEndjecQJ0PXTjn4p8NQhXP7y/8+Wazm1d2rSKK
	36PqLM/K8rKFvxW1QAwOXPFr7QBEp2bIkh887AVJ+Q==
X-ME-Sender: <xms:nCToZsynENd1nXxKiBuFoFEJH9R4DqxLjWwJ8dru9zJIxmjjve2jhA>
    <xme:nCToZgTW3mj-01lzlu07qgiHcUfCw3qLTVl0Dj92VsfUiEUaCFhiVUD_478pu4r-c
    wbP2JZpvPjQ8tk5mA>
X-ME-Received: <xmr:nCToZuUPOZZWrbd1fKjP-aXH4-2Sk7fiDkuCte9FYvCy5HIH4Uu3jqHOHLNFSPSTy4xIlEpHJCOrd-C29_sgsHKKHZrChdoQ7gPbcq2u6KY-s9TK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nCToZqjukrwwwtSeitGqbjaMqeRsrd_qxQpZnaZaBoUmMRPVeLBVXQ>
    <xmx:nCToZuBRHjyOI_xZcELWHLSuvjcc3qWsdsVkqulr-MBPNPeYYdQQ0g>
    <xmx:nCToZrK43hHE1kK9AASNQgJnr380AvAl5trSQG_NtpHdEfmYMftF1w>
    <xmx:nCToZlAhesjGEKMKRcqYwSV8sBgD_1MYF26hR94sAuhIPGUE39rkqg>
    <xmx:nCToZhO77UY42-aSmH0eOuIR63E27gj7xMlPCFGFXHg3YDxV0ladRBe8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:15 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00e8b508 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:59 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 18/22] reftable/blocksource: handle allocation failures
Message-ID: <4d672ab9b15fcced1eef887fb22fc4aefdd12b90.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

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

