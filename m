Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3845B823C3
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 06:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727159553; cv=none; b=jdKunvNRhQNbp6ICphR0BNgd0EC/b3/ejX4fQ5uD6COn6xebrMb6JcFAX0QcXyX2Mja/hvahM0EDrn68/MsioB6ZRnZeXFqBZzF7P+LZ5XO6ttOgLvNxA7NYAVlYpRCOf9mkb4gBIiRN9vBbVpD7Zw/zkQPXYbGAAH4YIonbcSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727159553; c=relaxed/simple;
	bh=eA8NMKqk1Szn0k7fi/zgzcJdkCvA+Etu97O3SlFHlRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7JEyr7DsmKrN+9gjUG6aGnfxWBH7mvH5tnTRmlFONg8w1hAflJqEnteQmuYMABrFJTRysWv/xC6OfLnZPdcK//ps9VkTi7mgbJ9ok7UfrcT3fa6lDtgI3dlUbfiAjujdGUIMl8lYrbl47ZE78QIZaMFpMmdfW1Rt0HA332yUzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QdKNfXyX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GY07+kL5; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QdKNfXyX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GY07+kL5"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 83DAA13801D4;
	Tue, 24 Sep 2024 02:32:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 24 Sep 2024 02:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727159551; x=1727245951; bh=GbknQKQBLS
	3075pf+ySe9rFpDgS6Xx+Wy3XYr4IUf/8=; b=QdKNfXyXSyEvySW+HFvka1YlX+
	+kRZ/Z1UxkHt+1YALmCwMgtJqLT8/NHym95ft6xaz+ZV8XTh3JabxB4Sm+IoNDhB
	DbCKHJoQTW5ur9TdL472I6JHJj9M0WR4KJ/FsQHzYkq7ZlAk7lnG9Oglot0u0g7K
	tvhlThF01aqxwRYc4NbIMV4XUZ3Ag0yFjR3965i8jFBzxt5aVdF7+B6bSapmLkIG
	Onzjh+RbGl07iQipOp3PdyGLp8FLdPxpzlkdSqOp4xVPb1GoDpDFl7D4xTH3gXxC
	sxA4XuSLjQkU+TzxhCaaGgsM6HC6fDnni4Mvqy6PcxDC2C10Yc8HQpZ+ED0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727159551; x=1727245951; bh=GbknQKQBLS3075pf+ySe9rFpDgS6
	Xx+Wy3XYr4IUf/8=; b=GY07+kL5/a3dJDrYfUzLCId0UChdIg1+kuKqIcwzDHyb
	y9OL3yWxq5SHIyf+PEt0AGS2qbSgudJ+qpcSrMF9bl2sfFXuU7AFM4Br3va6hzW7
	GoYKgVTXIFzb+2RbzddF0/70Pm9sF0S1yeiN+1aCcZ0HH9GiKFz2GiErz6KDQRka
	kypvJHiA4YKyNrJkqi4L6c7TGvuyCG6zYE0OlSyPZip0WIM5YNymTZOYRiTsJEF+
	VE9xCeKCD7+vb33+I3PnKA8NTF8RvtncXCy3+FqNdfi3t94u9rNYHgzhVVJsyMcU
	cKi9m1Hnx3ZQ5swcCOpY38ILMIAyIZmfDyyyTBUQoA==
X-ME-Sender: <xms:_1zyZshDnQkr5I2l780FnYMGAPe7yrJw6Q6BwMKPCB3qVxhfWNzhxw>
    <xme:_1zyZlCoMZcDymdGxWoJAnJtf2YBo44O_mwU7qBH4HOkpEiEAr374vFz4ZBFdqSVi
    cV7hw9PMDTbB_OdXg>
X-ME-Received: <xmr:_1zyZkHifH4mNtIZardoQ-lelaZ4fwk0viKKoFznhp_imL0sETduiCg9N8Jguez9juMYe-G7Smwj1iqFLwQRD-JNB22TGkc1KeepXW7KlGTdVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtuddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhho
    mhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:_1zyZtQnQkWFnpjOZZjwl8UeLZ2Ym1WOlf_wKGToVVBYFDPXXVGL4Q>
    <xmx:_1zyZpwxp7iHWGTXycgjHPcm_idCz-hiXako6s24qZnLwOV4KKwkog>
    <xmx:_1zyZr7jeFrVvmW2PdI5iytLsUNr5yhwTvYD8laXQNYjYy8QbK6FVQ>
    <xmx:_1zyZmw920s86EDGQfge8baf9I3IQRdOBDfUQQCJXYJKHCoSy-YMbw>
    <xmx:_1zyZh_DJpH3VoozYses6LVUTxv6hlbt6RMisbiRxxu-FWPvKTdHCLZL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Sep 2024 02:32:30 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dde46f4c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Sep 2024 06:31:57 +0000 (UTC)
Date: Tue, 24 Sep 2024 08:32:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 11/22] reftable/reader: handle allocation failures for
 unindexed reader
Message-ID: <20d3833014190af7cd42f3d6be79e944d4fd0de7.1727158127.git.ps@pks.im>
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

