Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F61581EE
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489756; cv=none; b=Mr4XOGiZ9ZKZyh8+BIMMsBtFccz6kli0u5gGR5/O5AkqjEwODvnHMcvOH1Qo9z98Ldpjy4iCqHE3sFuzumN3CKWYMGOhu9ktWhNIdoed/11PXE2xR+OQJeFszEFI/boqvoCwRC/KDHMqv+w2VB3IMdqtzzyxf562PJxsoqxzXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489756; c=relaxed/simple;
	bh=Km+xByotlwGW9VcYygoJQHHl508TZABu/wgo83KWDm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+ZLF8WZg+A1nMlxr2iJ8w30PtQthRubVBKBKmb/8HiITmd3p3Cpic/m5OeVOMNw4rQIvIwGTP+GioHRnA/fAHL/dElVVv9/abO/ZkbCdQgrep9JHagfGJF/2Hn+CW0guuBXXYIFs5b1vYX6QKGsYtg3FmzBjTC4R9G27DoA8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Kq3E3z/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=axLZYBZL; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Kq3E3z/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="axLZYBZL"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B8876138025A;
	Mon, 16 Sep 2024 08:29:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 16 Sep 2024 08:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489753; x=1726576153; bh=gsOs6X26Pv
	QLNUx1jgNy6Z3gF3yvT9Tflpl1UGQhro0=; b=Kq3E3z/yqONOa+dWuSnsnn7O9T
	MlRT6G0qZ6DYErwiNiK7G+DnLLirjN9unacyKEivUfaM+WTvsse/EQn19SWkor7d
	h0V5lPshiAE3N18uWxtsk9Tpir1Q5jyDPRbexWakj3E9o+ONWi4qkppT9aElyO6D
	vsmpnF2x0aYqMy8GijEoMyurVO8fP/i5EiT2/rp7ouicd4u8kpXnwZKXkNqA4RCW
	2C6T1dV2t3LcqnWYzf8RHeiGTglQC/FSGYTP3GPU/s48bGSq316ySmgg7//FJr/s
	fxYo96Yc981vCGnUsvJsmnVGI4KVBmWwjh1HV7iz87Q3oJXd6gN4RkdxO5kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489753; x=1726576153; bh=gsOs6X26PvQLNUx1jgNy6Z3gF3yv
	T9Tflpl1UGQhro0=; b=axLZYBZLfExkyz7/jT1smnCDeNVuBcG9VuZ/eZaBqC9X
	xdAtjOtTgHjpro9feUPkah9nGxldeDZmktYj0tMwwzS4eBxwnxVe6BOBlKZ7kJrm
	nMV2lwM6M5er3Zx9/o/K4vK4InKQIQ7sJSrNSEvG0y2v4rASLZ9MvEzk1NU5h4Yf
	+l5dD3yvH3JbbZXlTI+JMIGLSDKhRaZ0HVMTP0zY6yw9SLwySqaFLhBs9L8aiGY8
	1I5c4v6V6Jxw1g0uXwhZZiCWQNDw8wzG7CQakB8TMaCkVjluHC25jthvMvTZD1Lp
	AeV9oj5JN/VaoYnRzJ7rmxWLAsVjPEk3qrT3WbE7dQ==
X-ME-Sender: <xms:mSToZoPRjP8BeQIHD1AKedh-P0bJOyjy6aAoDz1Sog0mHY7dszm-sQ>
    <xme:mSToZu8C61mGmzQRU5cDKyDn8Szi0JziR1_PXWbj5iSzG_mLsW9CjWF-kHc6FCn7t
    GfVA581n2UcQ0IeRw>
X-ME-Received: <xmr:mSToZvRRZ1sJg88HyJPlaN_5_6tSvpNrb5PS82JYaUgR1WijcjuNfe9C-lM9s8UxNKgAD9e0cd-SZQARPTPNbJ3CQ88hDDxXJ0bCz_qp2FyLTHTS>
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
X-ME-Proxy: <xmx:mSToZguJcihR6JcWMCTaAoBp4bugxgRjzbQUlR7xVUca910yk-h9ug>
    <xmx:mSToZgcATDzCN-cBzK7qSdNwgI2UrSycEAeZURbrhgbsUsaXYevrxA>
    <xmx:mSToZk3pvI2tkSwGGkmHNwQXRRPvtC5iqbYMSKcIT5oTUNSNn-rd3w>
    <xmx:mSToZk8VpF6tud_Vx-ubWxZq8breMpoIdJOAljqM33cRMqbgLBKBaQ>
    <xmx:mSToZhpnnhDitwcaYwNUKFOzf7f1eJm1SVedTlix5Ldo7JL-XVSL0b7S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:12 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21f0953f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:28:56 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 17/22] reftable/iter: handle allocation failures when
 creating indexed table iter
Message-ID: <32fead57de989335b17d16f63c1cd144460495a1.1726489647.git.ps@pks.im>
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

Handle allocation failures in `new_indexed_table_ref_iter()`. While at
it, rename the function to match our coding style.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 22 ++++++++++++++++------
 reftable/iter.h   |  2 +-
 reftable/reader.c |  7 ++++++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index 416a9f6996b..41bdfbb13f9 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -181,14 +181,20 @@ static int indexed_table_ref_iter_next(void *p, struct reftable_record *rec)
 	}
 }
 
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len)
 {
 	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
-	struct indexed_table_ref_iter *itr = reftable_calloc(1, sizeof(*itr));
+	struct indexed_table_ref_iter *itr;
 	int err = 0;
 
+	itr = reftable_calloc(1, sizeof(*itr));
+	if (!itr) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	*itr = empty;
 	itr->r = r;
 	strbuf_add(&itr->oid, oid, oid_len);
@@ -197,11 +203,15 @@ int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
 	itr->offset_len = offset_len;
 
 	err = indexed_table_ref_iter_next_block(itr);
-	if (err < 0) {
+	if (err < 0)
+		goto out;
+
+	*dest = itr;
+	err = 0;
+
+out:
+	if (err < 0)
 		reftable_free(itr);
-	} else {
-		*dest = itr;
-	}
 	return err;
 }
 
diff --git a/reftable/iter.h b/reftable/iter.h
index befc4597df1..b3225bc7add 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -82,7 +82,7 @@ void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
 					  struct indexed_table_ref_iter *itr);
 
 /* Takes ownership of `offsets` */
-int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
+int indexed_table_ref_iter_new(struct indexed_table_ref_iter **dest,
 			       struct reftable_reader *r, uint8_t *oid,
 			       int oid_len, uint64_t *offsets, int offset_len);
 
diff --git a/reftable/reader.c b/reftable/reader.c
index f696e992dfc..0179e4e73dd 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -715,7 +715,7 @@ static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
 		goto done;
 	}
 
-	err = new_indexed_table_ref_iter(&itr, r, oid, hash_size(r->hash_id),
+	err = indexed_table_ref_iter_new(&itr, r, oid, hash_size(r->hash_id),
 					 got.u.obj.offsets,
 					 got.u.obj.offset_len);
 	if (err < 0)
@@ -740,6 +740,11 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	int err;
 
 	REFTABLE_ALLOC_ARRAY(ti, 1);
+	if (!ti) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto out;
+	}
+
 	table_iter_init(ti, r);
 	err = table_iter_seek_start(ti, BLOCK_TYPE_REF, 0);
 	if (err < 0)
-- 
2.46.0.551.gc5ee8f2d1c.dirty

