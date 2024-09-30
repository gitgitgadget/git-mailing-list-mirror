Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EA1185942
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683748; cv=none; b=YiQs8oJ2CVtAZw8MXD+MAIese0Jla+ARUW6M5kI79LhLDVcsfFN/MVZEuv2R53FLBlwERTouZf7UW736PeWHNIqld33kJjbpNJvYQKbURNV2HvEqj2HihAJ0ctGZH7G3ODwB2TOGfNZu0U/T7d2tctVIB0iBn7HQZaeaaNX3IR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683748; c=relaxed/simple;
	bh=F7wU+IiBbOWZgvBmqaEEGMyvLo7ZvnWV8//7QHQMt/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMaW/nRSTP5m8AJrcYcjzLOyJU8zftlnasDQy59Kry43NmPNDw5zTaz++3eEFoks4S8fNz28RDp+ZAWejjnEgj0nqkeJwV2odfz2yR2ff6U2k/EQTcWGkKC5rTjgTxhcZhjb5JLr5doi5KGXTBAQfdHwAbr0dPstPbqeODKNGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0eyz0VJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XkRRxKCw; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0eyz0VJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XkRRxKCw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7DA0D1380204;
	Mon, 30 Sep 2024 04:09:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 04:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683746; x=1727770146; bh=pXxAysYYRE
	Ff25klp07abIVy1Gw0VwgB8A31zApwhXQ=; b=X0eyz0VJY6KAile5A2sdYC8f/m
	hCBy/9+B/TuZHl7AbHKO1z4iJJw3zhKQeChdmgM+idJaUoy3CnXxzQEsK3J7Af7/
	7zjFAMJ0lv8gT9t9OI4gcags71fz8XDFLRv3a8UtYK3FEzOeBqGqvtbRc+86Von8
	Umdog9jqzL/XOHlr80jKpOdZt7DGnXT9mBFx/lCtj2LK/3pzn2fkRWFzPGixsBeO
	VDMbJoyigBscqg6jIgtKLAnLPvblGRYole312zH5Hfwnkt+rOqHksSLppgIw9MEM
	UIZzUV4P1MimpBrel1ocKkaMpNLtmNGtrKSkGawa7eUnfr3HakVubVMxSNDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683746; x=1727770146; bh=pXxAysYYREFf25klp07abIVy1Gw0
	VwgB8A31zApwhXQ=; b=XkRRxKCw03gaqZT9bfyu1GHyX7OK4w5w/HP4i2xePZnQ
	AuP7rCi69OzzvghfJGV1koPzBf2hDcMS4YnnHdU1Y8m12K0CYTBHh77QhLHZ567h
	W7bPnuc3LLDDIeIasINpsW9v81NUTb0fTdd0nGUvK9J7jexjE9W4RvgD1VdVsexg
	/60+fNS252pHHKmFbaR9IJut//NOAVVJYOSbiyFa12HaC1gfu3DABxqYSgyWh3un
	DK0VpKjVRhwklavdOhKjPoHPFUzY7CqO7/NQk+beotb3MLHmnQJr0RjkD3b8vD7+
	WWuA4cE4KbBc//J5VmSpOaTzYtJ21xHGf054Qym0Ag==
X-ME-Sender: <xms:olz6ZtxrAnjUKDl0sgb3Q4yYoT-mLdenqvo6ug-3Ie1xaIpm4r3eew>
    <xme:olz6ZtSwtcTDr_2iWQEhdP46Y_XwSVGogTB8GielG-nn6CLgWsxodCRt67AmwXPL5
    fcBH62H4MbBSWR3kw>
X-ME-Received: <xmr:olz6ZnUaC9Euy87i-g2pli0ODuvt5nmacfDrNV5KotBETvuM1oydXWTsdmfWAzP77kQI3qf0wI8oU_Dxz0QaIFETaUXIhSd_YyWHrFawVRfF13c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddugedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnsegv
    ugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:olz6ZvjNPhqRle9eGPU277hqYGmwsu0NlrsTbZFLuUrMCkKJYvtwDQ>
    <xmx:olz6ZvBGrsY9Um5Nor5awAxC4BHrG9rrPE6wguoELxXxoJvXxk3sHA>
    <xmx:olz6ZoJwFjJY1dsfcqfHQJrwXkdgsSJBbJcHKubcHYbHwUJvbjSrNg>
    <xmx:olz6ZuBEGGOqvhGLPIS2TeC7VyGD3vkxnj6CUltzihHsSFW3cGumvA>
    <xmx:olz6Zq-POUJuMxBrUpWdBS-MAUavSLnPswEn3WFMuptMWaLMqIKiS4ZQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:09:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e80e635f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:20 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:09:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 18/22] reftable/blocksource: handle allocation failures
Message-ID: <48047dd4c9f20c320a2a596d3596687afc838740.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures in the blocksource code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index e93cac9bb6..6b570751be 100644
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
2.46.2.852.g229c0bf0e5.dirty

