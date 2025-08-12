Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542922EAB6D
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992498; cv=none; b=XdPObA6DDKuqJasmLdoRBx2h4xC8c/8Cq6bwNCQ7zf16XRLA/1+r67TScRVyfLQDUep0hrg8lDpFSbF7Pm5EToo5Q29dbKAquNZjZj+2c6wfy26bYfbpVpEfoAgeOVSTa7w8nJr2UlG3s4/wU+J5DNeeoqwlw/vLeO5TXsmKkUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992498; c=relaxed/simple;
	bh=oM27Qa6Y16nVxUCfH+sexnEXvwiAngP1OGBo4E+Slis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrJ0rpAfVfQmC3AreRst1MG4NdsNx9bXTzPvsg7a4i7LtcMFqQldOgEJH/HwFidBp8VaoXtAKX3U46BdopYnHFOkD4rqkKJmmx3lRtQpy15096xrc31J9s78QtwC4jespMf4LvFc//vs1oIRI0RtD8gin0e091JhvMnCuNYzac8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WwjJy2k2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gb70uVV7; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WwjJy2k2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gb70uVV7"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7A06C14001EC;
	Tue, 12 Aug 2025 05:54:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 12 Aug 2025 05:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992495;
	 x=1755078895; bh=zLpSVYW7kVUTdz+FH1wbG1U1SmFLLskuluU44egtXHQ=; b=
	WwjJy2k2a0fcugUtyGK+b4KC+A2Gc0OtFV9k/LmS0TOQ3yj8A60X+3aUr1IyH4GI
	lW+Myjw9MW+8M++yukPGOsq6a9d7etogKYJkcp9BjkkQ6jqB6NUKlu2Bhf6hGOTe
	jMIc44mD+tlUn53toiACQEOnMiNNoX2cctnvr8B2Scde+vX69l71EqwJXr0R/84x
	KVcBuoBxui/KYAYLOTIBVT5vhCRc/nSVZNSdeXEG64RGRQ4CKVAS3tG2YGCNHVYT
	cqd0t3nbguOO3H4MgsjHIFHFOG3iBxFCC/krlwyvYPaZkfZ+RMS5Ck1ALbGpW7oX
	lsL8s2Oi9kZdnFIiyzkkxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992495; x=
	1755078895; bh=zLpSVYW7kVUTdz+FH1wbG1U1SmFLLskuluU44egtXHQ=; b=G
	b70uVV7bD7m7c/e9wbIW6lHZvSuUhbBkCCxMtzQyljSBEl95HRBr+sg1MCgNvgLs
	4A7WKnlUVYBAoff/DD927frsK16giLSPeOGxngn28eUEkS8HDtOhbAJVCV8ucAz7
	eXCHO+ywJQ2PrHu74KjK/4E3xCEIDeTvxmbjzoYTBrTPb/RJe/IqTo8DK9o0mV5O
	xQAmtjXlT55xBPVZFDJ1jme2/CEsmPx88lbmPwdD+wAtvUM8x/t4RRZmb7voze19
	h8ogabPHcYt22GSg6iQo15U8gG7MUwkU5kV75n+o3uohfT4P6meKokERgqHOU24m
	UraYyBj/BzsA45JhxuF5Q==
X-ME-Sender: <xms:bw-baEiKfH8dhcy7tSoYszgzuE4m86Po7rXKI05Oydq4g86HtqOB_Q>
    <xme:bw-baIgjtrm_nYX0QMR3v6mDlPfemY5ucMKbBpfD6dBrcuJxstsjTzszb8yVAcPpa
    IcIuBpsEpXWxjBILw>
X-ME-Received: <xmr:bw-baCh7eu1NxLwxaDLKD06BJBpBlGszE72pzBIKJsTI_KaRmPxRs4R3RPjizjwMlIYSishVDp0OEj-VeSSotL0gN8A73QAskEmOpcxZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtoheptggrrhgvnhgrshesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:bw-baAIdwpXTix37SwrZGVOVuEEMA2rliOEE6UB8egXVyUAt0bd9Vg>
    <xmx:bw-baJF_iqeTWlhnxen0elSLQiAtb-G73AYwB1xsKHRQcnkcUPy1fw>
    <xmx:bw-baMTeeXJukWi5EpzfM6bCShoLdEvQMk5mJ39r59E3AFA0s4M3Mg>
    <xmx:bw-baNcyKYhNbSBS_vvhQO9twy6GFUKruG2GCCOfwSNIg7dYn4HHaw>
    <xmx:bw-baDf2d-Y8DmtGN-Zmo75r1Rf2pBt42B-LBHT8ArSbvApVIXUIrqkE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d7d08e57 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:22 +0200
Subject: [PATCH v3 8/8] refs/reftable: always reload stacks when creating
 lock
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-8-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
X-Mailer: b4 0.14.2

When creating a new addition via either `reftable_stack_new_addition()`
or its convenince wrapper `reftable_stack_add()` we:

  1. Create the "tables.list.lock" file.

  2. Verify that the current version of the "tables.list" file is
     up-to-date.

  3. Write the new table records if so.

By default, the second step would cause us to bail out if we see that
there has been a concurrent write to the stack that made our in-memory
copy of the stack out-of-date. This is a safety mechanism to not write
records to the stack based on outdated information.

The downside though is that concurrent writes may now cause us to bail
out, which is not a good user experience. In addition, this isn't even
necessary for us, as Git knows to perform all checks for the old state
of references under the lock. (Well, in all except one case: when we
expire the reflog we first create the log iterator before we create the
lock, but this ordering is fixed as part of this commit.)

Consequently, most writers pass the `REFTABLE_STACK_NEW_ADDITION_RELOAD`
flag. The effect of this flag is that we reload the stack after having
acquired the lock in case the stack is out-of-date. This plugs the race
with concurrent writers, but we continue performing the verifications of
the expected old state to catch actual conflicts in the references we
are about to write.

Adapt the remaining callsites that don't yet pass this flag to do so.
While at it, drop a needless manual reload.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 3f0deab338..66d25411f1 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1006,10 +1006,6 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
 	if (!arg) {
 		struct reftable_addition *addition;
 
-		ret = reftable_stack_reload(be->stack);
-		if (ret)
-			return ret;
-
 		ret = reftable_stack_new_addition(&addition, be->stack,
 						  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 		if (ret) {
@@ -1960,7 +1956,8 @@ static int reftable_be_rename_ref(struct ref_store *ref_store,
 	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -1989,7 +1986,8 @@ static int reftable_be_copy_ref(struct ref_store *ref_store,
 	ret = backend_for(&arg.be, refs, newrefname, &newrefname, 1);
 	if (ret)
 		goto done;
-	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg, 0);
+	ret = reftable_stack_add(arg.be->stack, &write_copy_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
 	assert(ret != REFTABLE_API_ERROR);
@@ -2360,7 +2358,8 @@ static int reftable_be_create_reflog(struct ref_store *ref_store,
 		goto done;
 	arg.stack = be->stack;
 
-	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg, 0);
+	ret = reftable_stack_add(be->stack, &write_reflog_existence_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 done:
 	return ret;
@@ -2431,7 +2430,8 @@ static int reftable_be_delete_reflog(struct ref_store *ref_store,
 		return ret;
 	arg.stack = be->stack;
 
-	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg, 0);
+	ret = reftable_stack_add(be->stack, &write_reflog_delete_table, &arg,
+				 REFTABLE_STACK_NEW_ADDITION_RELOAD);
 
 	assert(ret != REFTABLE_API_ERROR);
 	return ret;
@@ -2552,15 +2552,16 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_init_log_iterator(be->stack, &it);
+	ret = reftable_stack_new_addition(&add, be->stack,
+					  REFTABLE_STACK_NEW_ADDITION_RELOAD);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_iterator_seek_log(&it, refname);
+	ret = reftable_stack_init_log_iterator(be->stack, &it);
 	if (ret < 0)
 		goto done;
 
-	ret = reftable_stack_new_addition(&add, be->stack, 0);
+	ret = reftable_iterator_seek_log(&it, refname);
 	if (ret < 0)
 		goto done;
 

-- 
2.51.0.rc1.163.g2494970778.dirty

