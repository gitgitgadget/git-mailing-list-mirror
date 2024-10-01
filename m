Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2581A01B5
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775750; cv=none; b=ZJ78GUbBjq7+GFunxj6xNmERPxx74hxATgPoaZsfKWz3uj4LpyNTLUTdtQ0pwXehM/o9UDU7rvq+CD67yZM1nHF2owEA5+dPycQi+50uwYGE287fsLXAGWFhmDEIn1INXpKGnFkPxiII7/9bbn0g+cGcVimibrjJcJy6dznvoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775750; c=relaxed/simple;
	bh=H1Mm5KhJsOjzDHAUqGiZuYfA3ybGguq0Ienl5++K7jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akRNzHg1ZRsobJSvcLIgDm7aGdKQiLEje4dqLg4fRcCjFwqrBXoiuaswVS9TK4bnmvT8fLl85BrkiD9LHUCBhSPTuw8bbuE1EDoFvsTTHzcS8BcMBB1wP+w4K1RLVbmamzCNaNs3xv9eqaOFhcSAMw1u7FFm8HlexLUkrC1dnws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZUcJlTIO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eLyKEXFK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZUcJlTIO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eLyKEXFK"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C008A1140E88;
	Tue,  1 Oct 2024 05:42:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 01 Oct 2024 05:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775747; x=1727862147; bh=CDOp7/ndkP
	DBDZK6gpRVe4iy7BT+NlOm7JPhmzrAe1I=; b=ZUcJlTIORVxGh1o1DTlkm4/9uw
	44Mp/sqPCZ46TDMKZOCe9PZzkwBrhGVlEY2Q/hSDbSjjgvtLILE56cmus09vK+S2
	VV0tp635z5x5xMPYuqwsd6x1bjTihn8BApbElkyFoa5FkIiHPNYXVdKLKyUw7MAV
	u98rA2cXQNOR1kz0VTjXDZ/Gz+weBBnbxTD2gwQCrR/1orpbf8u3DjRwzRZy1Zv0
	pasL6YObQUeinJV431PSpTsPqkP9YH9alszTP0OgFVhWiLU1a1u7YZEmk/yuPu+k
	GAZ0hPSY1vW5LL6mZIDlR7l2Xs9Gu7z6mZ6OdUun1kSRyFqOZpCmlK+Nrkyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775747; x=1727862147; bh=CDOp7/ndkPDBDZK6gpRVe4iy7BT+
	NlOm7JPhmzrAe1I=; b=eLyKEXFK7z7MKSqVA1qKkVj5yxRzx274LAgnAUqUhDJT
	n4syzValEoTj5ueumJCjzIajxIVjXYr122BD9xYK9ixfEqHzhiS1ESz2hjU/yp/n
	DK9QwuzmFseYVyCihmKR/iNGDnzylAp6kj+kkCSw/KnCxX5MtoIqc2hHcpBI0Yd6
	w0jPyJ0zKI9ZZRcjN/f8WjjMhB/z/x8wZDvNHjZqb/rrUCmvbPPz5ebQi4i8zH+x
	+ingVCS7nOEABLfjL4WtqxwbWK+eM/Ktp99YZTqbYhH5z7HMkYNJ3D63x70EMC+D
	ib95lJOt0GgkBt5Exl1Otyg4Q5xRnqkWSZYxNR41Sg==
X-ME-Sender: <xms:A8T7ZrdW-MvKEuQdUn7VCwetxEGN_8gUecKmMaPMbc8B-C7tkMrC1A>
    <xme:A8T7ZhNyT-FlkV3_J1pVUD6H-vklV7p3vLcIfsk-XHnDQjKvSc2XAH07xAhZksFd9
    lBAHDLQKz9ngyJumg>
X-ME-Received: <xmr:A8T7Zkj8NOrwHz-rWWMjbLgROIK7ynIuTeI9Ofk6JiSsXFjTmN73JX8VVOXec6IwEOROVQRvOvjlRQr11yYo2E6rhQ43AxjAze2t-iLSTJGB9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepvg
    hthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:A8T7Zs-Ge5oJMtWdDykMXL9B_m998-yEGw22fdPqMDQziY93fCd7hg>
    <xmx:A8T7ZnskzsYEIKzmJeei_cwX6AUz44U83iSxD31pUA1-MOUGEl9K4g>
    <xmx:A8T7ZrGm1qYn19n1Khgn7SR8EQa81jvpJs9EDhtBtHpe2HQix1z-jQ>
    <xmx:A8T7ZuOQ8X4ShOUUkCLp1CNOWEUTPV1VjwopQCS6sWa96TM2QmQlKQ>
    <xmx:A8T7ZhI54ajWAk86vilSo43WbHmbulyr1__WxN0Q_LmhMalyCGnbA3Ky>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:26 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bf89ceb1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:38 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 13/25] reftable/stack: handle allocation failures on reload
Message-ID: <1e997a576693a9ae1841b14ef7f2a02841694bfb.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

