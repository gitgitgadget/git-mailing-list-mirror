Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92D21364
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530273; cv=none; b=n3NQoVv1l6+wyQhuftb2V0cGtokODkSKrdTZLUXIk4MSOyoBqikAvpMxVjHRj5+WnkVkO4u9Az1MBxnhs8muiVUz3QHZOffCHpZLKPofxaPvQEPZoIGnv2/1LQd+vrDdqKnLqONp2hq3l1abekB7Q/B2YMuLkUyUosIDDCrJvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530273; c=relaxed/simple;
	bh=r5VuZnNzzCesQA11EYvHShl4fGeZTGgYnXDVZZEcqDg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YPc1rKbqSWDKzXB7OUL8M8o7b6q0jH+9O/KNZXOK083AEC91AHMn84nss+5pGMqtd3lRu53XdLblO6ImeyCGM6HiZDheAPejxSDBDZX8aJuWJk83LcFGRExwzm0ZhpOUGB5guO8pRrUdwzyFTiUrOOm12g6PlQPSpUKvU6+5y3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AR2R5JY5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dkZGGw3R; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AR2R5JY5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dkZGGw3R"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 450991151B14
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 02:24:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530269; x=1723616669; bh=2gBsMCtfwi
	nPFzx0Qt+z7LVbBUwnUEyg8ZD/2vGjjMQ=; b=AR2R5JY52ZKOPtE/+0s7jbuk/9
	JJERkaPg+SQcM/2XHYfP3q6nfqqs6Uu/DxWl5i0HdhwY4hesJA9tuD0+xO78ksP4
	RKQI1H4Q/pn4YSJ+KJzCiSLacF3ZPi8s+JmL5QvL4Rxh/ToAEfpQh9w+i2GcHEgm
	6sjMiO7khG5lXrmwSSvkVttAA5ePGZt2MPhNUpoFiCOA6eEPdDXqprge4SRraraE
	0czkMNK1WB6yVFxrKYfodZzUZHTurMiTiBZbJciUVpGwjqjnJXxa/7m3wCOoSPsR
	Lk8jfpXOi9atj/0AXCetygPk2CmpuwA/KqcVpUwTNKfoRp+5P61XhoXXUTaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530269; x=1723616669; bh=2gBsMCtfwinPFzx0Qt+z7LVbBUwn
	UEyg8ZD/2vGjjMQ=; b=dkZGGw3Rnp0Z8+bEyDJvWSIbViS8JfW1gafJK/VunO8W
	dhRF/BTOxtbWjUQ9mGlePQvt1jSy8XqBp8RPnRnTP8RVSStUgYG+zCtLfMVSHybd
	SVif3MXq/F/L3alMT4aojEAJWFBLCmEOKiFb9eX0nVMQGQY892Q2Bzsv5DX+6DnH
	Zynqdt/RDgyg0F5Jprkpb0BcuI28FVU7QiP2YHm8MMw7ZE2axaWhzX1KmVpdLLVK
	/QVP4N+WyObfo/OugVwwhiMOplzQ28THUG0gW45rKD05VxXoD7xPCMBa/7X+m37Q
	aosSU+wPrE6qAfupPe02NOqGbTVpB69L2Z2zzf7ijQ==
X-ME-Sender: <xms:Hfy6ZvOg-7qj2T3KFTJ_BQorpS762lz-avoiMTcNEoD9B4C6lzewiA>
    <xme:Hfy6Zp_1txHbBmapwpCKKkdTkuedOz_rC4JJ1JoW2x2KzvhwFe_f3V4DsYZ_w3ks7
    Yxc5VU1LqKrppcYHg>
X-ME-Received: <xmr:Hfy6ZuTG9BnhYTYGneWYNzuJ98Ahr5HXK2tIWLQZBqeYQ-4aNoYFebI2ACAOu7d6lXoO5mtcrEuxjVWO6E3_DWtAeV1IoPStqFdGqWmmuP_Ozw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevveeukeeuje
    ehtdelveeuffffhfduteektdehtdfhtdetgfejtefhveegheekjeenucffohhmrghinhep
    vhgrlhdvrdhtrghrghgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Hfy6Zjvz_E5KD5sTu8PysY1ZQk_HEDxuJfFZBEHdQLmTHLbzctO3Vw>
    <xmx:Hfy6ZndW4oTtkKXFlLe760vJcS_zfL2YZc271GeIvHmoKq_D9A6SiQ>
    <xmx:Hfy6Zv1WqFZIq1KZ22ODQkEoT7IGWWESV11cxSOWiOovaBbA1EOt2Q>
    <xmx:Hfy6Zj_prS3H0x1cabz3P0CGkJzYbRNKzuavvbTA2R240yHmHCxgUg>
    <xmx:Hfy6ZvEKizFa8BQCHBfrc9ckN_WzQTRpr4lKCWoYlk2PenP56Mtsjpku>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 47e029ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:11 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/10] reftable/iter: drop double-checking logic
Message-ID: <ab7538d0bbb8b3c02b5db71a421163fbf87a45f6.1723528765.git.ps@pks.im>
References: <cover.1723528765.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723528765.git.ps@pks.im>

The filtering ref iterator can be used to only yield refs which are not
in a specific skip list. This iterator has an option to double-check the
results it returns, which causes us to seek tho reference we are about
to yield via a separate table such that we detect whether the reference
that the first iterator has yielded actually exists.

The value of this is somewhat dubious, and I cannot think of any usecase
where this functionality should be required. Furthermore, this option is
never set in our codebase, which means that it is essentially untested.
And last but not least, the `struct reftable_table` that is used to
implement it is about to go away.

So while we could refactor the code to not use a `reftable_table`, it
very much feels like a wasted effort. Let's just drop this code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/iter.c   | 20 --------------------
 reftable/iter.h   |  2 --
 reftable/reader.c |  2 --
 3 files changed, 24 deletions(-)

diff --git a/reftable/iter.c b/reftable/iter.c
index fddea31e51..a7484aba60 100644
--- a/reftable/iter.c
+++ b/reftable/iter.c
@@ -42,26 +42,6 @@ static int filtering_ref_iterator_next(void *iter_arg,
 			break;
 		}
 
-		if (fri->double_check) {
-			struct reftable_iterator it = { NULL };
-
-			reftable_table_init_ref_iter(&fri->tab, &it);
-
-			err = reftable_iterator_seek_ref(&it, ref->refname);
-			if (err == 0)
-				err = reftable_iterator_next_ref(&it, ref);
-
-			reftable_iterator_destroy(&it);
-
-			if (err < 0) {
-				break;
-			}
-
-			if (err > 0) {
-				continue;
-			}
-		}
-
 		if (ref->value_type == REFTABLE_REF_VAL2 &&
 		    (!memcmp(fri->oid.buf, ref->value.val2.target_value,
 			     fri->oid.len) ||
diff --git a/reftable/iter.h b/reftable/iter.h
index 537431baba..b75d7ac2ac 100644
--- a/reftable/iter.h
+++ b/reftable/iter.h
@@ -18,8 +18,6 @@ license that can be found in the LICENSE file or at
 
 /* iterator that produces only ref records that point to `oid` */
 struct filtering_ref_iterator {
-	int double_check;
-	struct reftable_table tab;
 	struct strbuf oid;
 	struct reftable_iterator it;
 };
diff --git a/reftable/reader.c b/reftable/reader.c
index f7ae35da72..e3f5854229 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -735,8 +735,6 @@ static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
 	*filter = empty;
 
 	strbuf_add(&filter->oid, oid, oid_len);
-	reftable_table_from_reader(&filter->tab, r);
-	filter->double_check = 0;
 	iterator_from_table_iter(&filter->it, ti);
 
 	iterator_from_filtering_ref_iterator(it, filter);
-- 
2.46.0.46.g406f326d27.dirty

