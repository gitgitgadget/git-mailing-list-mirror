Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BABD156C76
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489733; cv=none; b=iuDi2MME/ecbF2rQ/j2BsuP0/hrq6oS6FQNT0m6Ta2GI6GflsR00NN/0EUvAVg1TCaHljSXO/NEk1AwjjnH02+UQUvnioCu84P+Yit2Bbsd+DjXN/56y/c7BW0djXyHeAJLrOxooQeRU0BwXltv0MPEpbW7OQVbS//GanoYGwe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489733; c=relaxed/simple;
	bh=eA8NMKqk1Szn0k7fi/zgzcJdkCvA+Etu97O3SlFHlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPiX5bKmnjm21LLb4TVJGgrq6GNrnCBacs+/PnIuQthDsUFD9abMin32Ngxr4aAdsNIUJF8YXWsY1keHV0IjFp9a7tDDsXF1Ho3faaBwhxiKIJRYYomcrgJvPRpOdLKSu+reiOAAylxGpdGssNPooFbAPpCoxrIs0utxf4mjxbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=evXZiFym; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OvzT//9B; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="evXZiFym";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OvzT//9B"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A6C511401A9;
	Mon, 16 Sep 2024 08:28:51 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 08:28:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489731; x=1726576131; bh=GbknQKQBLS
	3075pf+ySe9rFpDgS6Xx+Wy3XYr4IUf/8=; b=evXZiFymR35zqELnnslp+qj+wC
	I6Z6ot0G4E60KW+WX2CKAW50UGKzyslMb2NGWEY2ij8dCte/hxGtWoODYcJaeNKh
	N4u9shSP+m5GNzYx/bOKJxjyU8Gd7fyQ3WgVdOVVvzlyQS8gJD90YzLEjTFT2987
	q573EMbfmmks+v70omoWufpSwmzsvL6kkaCnfAXhtShlLD6OtxKIl3AQJ3q3O0w6
	pJO79YM1t9e4ZqQwA0HYldFUsJtsVOf4cyyxOZmYXPYecvlnpMLmktYcHUkjnG9w
	byIfYsY4U8WuTx8Ipui23qs+DckzWePWTnOFrhZcgNQBMeZYwF5UF0/fcGIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489731; x=1726576131; bh=GbknQKQBLS3075pf+ySe9rFpDgS6
	Xx+Wy3XYr4IUf/8=; b=OvzT//9BAhO+TtxnqX0zaHIohILBVdttVkpuNUMxEv3x
	8CZWcsnHlE2ud06QtpydvsC56fKRtmYPQGzdsmjRWlV9jMHs1LzbPYzlHbPtEYdU
	QoZSWthel6iOs7gQC4kC8OSdGgyiEujVYjYMLNxnbSgF7c/OlryfPDqPrKP9kdLT
	8MS2pHZlTLFk4xTndNhMgaHiXj8dcZh40QE8c5pGNRF5zG1rjLo47MwegvOHL92E
	9N/zKf6kdPky3Bu/kzZnsD0ux5oJq313ufkudzkE81ZqvuI3gUSi4m/4MUq+dbqn
	Hb/99YEHaBROBbKmvXhNfmGloJLZwZTmYzOZcQiC8w==
X-ME-Sender: <xms:gyToZs3TZab3k3lREhzKuWw5g6D5BbdBi13_5yzafv6THcTN7Xp_hA>
    <xme:gyToZnF4l6TYTwqCSVsWaT_ADdclHI1CoD_6y39_6ZA4hJFhoP_490oooVeVcgig8
    KVq2gr2XJ0x7mJG-A>
X-ME-Received: <xmr:gyToZk4mQCj5PGyXCZJleVIolD201m6BxG5XjVKQ-wmxMZVaUtw8oKXaBl8-tJaorDaeIDoo2fWw3-iG2VWMiLY-R2xMfuTfv9uu3MVrR2MntLOz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:gyToZl3Phf7dz2dUMAtUwqVNxfLcj5bK04o48h3_QzXa4Wy_mrfHug>
    <xmx:gyToZvGcRqO50wod_0r-6MLJCiik8HQwtgIlX7HqVcipEkq_REik4Q>
    <xmx:gyToZu_0IyMCMnF-hkLJhGeWMMOFCK7O6YhgoQ_mr2chWb56VLmDtA>
    <xmx:gyToZkmVT8URHtgwLs4SZ64sjMBNRhIr_6UdfBUKeSqLkB6TW1U5JA>
    <xmx:gyToZkT3MwLrF-wuU0c2m7diNp8709aZJ1nql49oAT3IXsU7wZV6ab-l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:28:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 09e68f50 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:33 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:28:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 11/22] reftable/reader: handle allocation failures for
 unindexed reader
Message-ID: <c4985e64ce2ea13e1a367d8e058f40e97ec5689a.1726489647.git.ps@pks.im>
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

Handle allocation failures when creating unindexed readers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 6494ce2e327..485ee085dac 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -734,19 +734,30 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	REFTABLE_ALLOC_ARRAY(ti, 1);
 	table_iter_init(ti, r);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
-	if (err < 0) {
-		reftable_free(ti);
-		return err;
-	}
+	if (err < 0)
+		goto out;
 
-	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
+	filter = reftable_malloc(sizeof(*filter));
+	if (!filter) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
 	*filter = empty;
 
 	strbuf_add(&filter->oid, oid, oid_len);
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
-	return 0;
+
+	err = 0;
+
+out:
+	if (err < 0) {
+		if (ti)
+			table_iter_close(ti);
+		reftable_free(ti);
+	}
+	return err;
 }
 
 int reftable_reader_refs_for(struct reftable_reader *r,
-- 
2.46.0.551.gc5ee8f2d1c.dirty

