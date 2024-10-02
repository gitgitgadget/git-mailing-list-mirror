Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182F1EC00B
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866568; cv=none; b=bDo9qlSulvsoZ1l9lYBsfuBCuDiH6TPRgyv+4xbswgW1t3b3fPsxyNTybAEVM+B3RjOigd9tYj8FWbAAyOwykrEvVLWFj96EfijaVmsDkkeYPkxZd8Cqjdm88V1S/ggiCbS/43wRdZ5ge8t4YWaGRuqxPS6MtgYYpMQSClBivv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866568; c=relaxed/simple;
	bh=H1Mm5KhJsOjzDHAUqGiZuYfA3ybGguq0Ienl5++K7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwQs0RCbnBivOZoWf3PTapp8VkQWdSwWG20Dd0qcKE26aW+SVFgnggnpUrSTCQEKOrlrsNlscUH3kfRfZsj5B9Z0TLyzGqv1lCHfwwlsOM7tjVESvTInW653eoreGTR1E+nKpPeALWIQUcHip2Ji+bMpR/Zm9oOy+bri2cuuf1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lOjTzHwQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cO6avJuW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lOjTzHwQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cO6avJuW"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DEF7E1140243;
	Wed,  2 Oct 2024 06:56:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 02 Oct 2024 06:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866565; x=1727952965; bh=CDOp7/ndkP
	DBDZK6gpRVe4iy7BT+NlOm7JPhmzrAe1I=; b=lOjTzHwQYmV84nS7Q2KbsTPkTP
	zUL/5uc6eorgAcwJZChmU68NCVOWVcvr8m7I1TRXx3k3xaukrTN4R9vH4izjUH3e
	bVvRfTc9hmuzIvwi5xSa80nygZwI+b9q0FN793jlkeUlJa95DxKnnEjBADZx5bON
	HC2+LW54x/NWTZB5LGOE8L6s7w51rRL/wvIBivFWa5GJkFI+n2Fbwn59LKw7LcEd
	7I/U149h22j8X9rwbIOsHB+fIIHmNBCNFjJuwauZW9aclI9nmtqeYeTo5Ejp0h7Q
	4eUnc4MYR749YjDK0gK8qL2ZnYM8RDEp21dyYzTcz3vVvgASARVeFH5Ursjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866565; x=1727952965; bh=CDOp7/ndkPDBDZK6gpRVe4iy7BT+
	NlOm7JPhmzrAe1I=; b=cO6avJuWUxca9IksU5QGqES4sY6taonZV831FI3yM2lY
	dmFxGEUsgcw3K+tqsjMY0dlR7wo0PuTEb4BctuO7Z5OI8LHQpdfQXDM7TCHdXgXH
	96bcheCsMvAmLKVYi9JgLsKXNt0rY1S73WRUDuXgRaeXAqius+WDsLdLzLt3Brr4
	j1lYQT9KM+n+NqTbupf9SSQDrtwmBmp0OCpki83ySQFLANn9wLUR7rnFmNAV2jtR
	rQUDXUW+lh38R6TU5UNdYpcT9tR3Brl0WhbCFT/vVdyVoipf29uRNfrh94zPog5U
	fvqYI6hujt1bBPxOtVuwcDTRVLFD9qAz9eLTIxfL/w==
X-ME-Sender: <xms:xSb9Zp9UtgHWkfaHmXeBN_tcqN7rL-cWR9Abv-rV6IafJS5s9GnAiA>
    <xme:xSb9Ztv9MrdLV_-_AVPtNUE4T7yRwRvmJpeykzq0YVqgg5zilKKueCT2CNx9w81YC
    AHaHf7A2E8ZwATX1Q>
X-ME-Received: <xmr:xSb9ZnAwDbjwsqbfdoQ5Hi5kWGuiT07FxlgpkhHADI_toz6c5nhj9lJpgAFlb_frulUq36eRFKDuor6mlNijBpg4VgtDWH_OW6s00dJFEJcV3GeD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:xSb9ZterRUPMpmaUH1FAyIGWWCzwqL93RmpkH1oKXZLujKizXqQ2xQ>
    <xmx:xSb9ZuMYhVVBCvDm1F8qyO-t2LXF3JTuvztJB0D4c498Fe9N7JrWhg>
    <xmx:xSb9ZvkmMkq0hI782wjCjlTn47uIFJNH1jxgFUekJc90uFqUELYQeA>
    <xmx:xSb9Zovfh_RahBvkFxEuW5S0MMrtug7gfTs0pEwg98cuId_PnZudMQ>
    <xmx:xSb9Zrq0Y-KKDEPUh6v6Dqi3uU3RC0JKsYrOsiR0PWnQ6fUxIdID9y0C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d7db1d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:14 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 13/25] reftable/stack: handle allocation failures on reload
Message-ID: <1e997a576693a9ae1841b14ef7f2a02841694bfb.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

Handle allocation failures in `reftable_stack_reload_once()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index bb4d230918..060b2c1b90 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -214,13 +214,13 @@ void reftable_stack_destroy(struct reftable_stack *st)
 }
 
 static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
-						   int cur_len)
+						   size_t cur_len)
 {
 	struct reftable_reader **cur = reftable_calloc(cur_len, sizeof(*cur));
-	int i = 0;
-	for (i = 0; i < cur_len; i++) {
+	if (!cur)
+		return NULL;
+	for (size_t i = 0; i < cur_len; i++)
 		cur[i] = st->readers[i];
-	}
 	return cur;
 }
 
@@ -229,18 +229,30 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				      int reuse_open)
 {
 	size_t cur_len = !st->merged ? 0 : st->merged->readers_len;
-	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
+	struct reftable_reader **cur;
 	struct reftable_reader **reused = NULL;
-	size_t reused_len = 0, reused_alloc = 0;
-	size_t names_len = names_length(names);
-	struct reftable_reader **new_readers =
-		reftable_calloc(names_len, sizeof(*new_readers));
+	struct reftable_reader **new_readers;
+	size_t reused_len = 0, reused_alloc = 0, names_len;
 	size_t new_readers_len = 0;
 	struct reftable_merged_table *new_merged = NULL;
 	struct strbuf table_path = STRBUF_INIT;
 	int err = 0;
 	size_t i;
 
+	cur = stack_copy_readers(st, cur_len);
+	if (!cur) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
+	names_len = names_length(names);
+
+	new_readers = reftable_calloc(names_len, sizeof(*new_readers));
+	if (!new_readers) {
+		err = REFTABLE_OUT_OF_MEMORY_ERROR;
+		goto done;
+	}
+
 	while (*names) {
 		struct reftable_reader *rd = NULL;
 		const char *name = *names++;
@@ -261,6 +273,10 @@ static int reftable_stack_reload_once(struct reftable_stack *st,
 				 * do by bumping their refcount.
 				 */
 				REFTABLE_ALLOC_GROW(reused, reused_len + 1, reused_alloc);
+				if (!reused) {
+					err = REFTABLE_OUT_OF_MEMORY_ERROR;
+					goto done;
+				}
 				reused[reused_len++] = rd;
 				reftable_reader_incref(rd);
 				break;
-- 
2.47.0.rc0.dirty

