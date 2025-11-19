Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B42EB843
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 07:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538471; cv=none; b=ILtqf//DpFk43O24ySHTA+ce6QrFQDv6cONobUtfsoY+zzJpalNS2BBA54NDgIXL0xSq2NpBvnvL/B11onaS1UpW51EPwqVMMucgXqPw59OVvPN+QANjlfnH8+bWyqPVAwMf4CoIM2Ufg7E5Dxkz5ks7NAc9wJsyLjYgeiWLoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538471; c=relaxed/simple;
	bh=OQKxnr/htzUU+jL/3b9xAn2CCnzsJk1HW73yornV1Gk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W649GFmcD/Ne8xfldG5sqlUYBAFcRPohNd6AcCOolKz1AZqo0FutFhSxAQLvr/pvIVYJQuFgBVHep7rw/x0/j9wR9CHAtJGImPa9UzClAOtVSz0Zv792xNCdrmY7nhgOBGwBuEO8ln9oPeHN3C6zjm1RlhUabGR2Mb/aVKreCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bE+jxeqs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d2yJmw73; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bE+jxeqs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d2yJmw73"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D9B751400200
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:46 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 19 Nov 2025 02:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763538466;
	 x=1763624866; bh=JOntJUQcbDtP2HvWju1evYMfq5laf/M/lmNvkMxPfcM=; b=
	bE+jxeqsSu7A3k2Bc2TXhe1w1HWajDJRstsYiOIznbbHJslPsQumaXpAyP/wq2jB
	gBYEnHxtvneovHFHJWG0WoV/HRXk5+f1BQdenhRyNbIeQ7C1NH4C99Gy+dMkodQ+
	bVOwpdP66JqKT97bsYlSKofv+lXwd8Dz+O2NZBfvwDcz6Zdh/EQleXrQy+V0b4wv
	E8i4q68KZfQ6I52AiRTmPPdd9uDbhtVeb/ODkLGN7SufCME0X+DsKp7NqFGOfyai
	T53eEruSfQs2y/it8t1SFDagsRF+e0fqSoYyyaCjmUHOJs6We4NokaKN/ePy39bK
	gDw4lFbC7WmN7ab1VbDu5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763538466; x=
	1763624866; bh=JOntJUQcbDtP2HvWju1evYMfq5laf/M/lmNvkMxPfcM=; b=d
	2yJmw73DimdmMnvE689SwQ+4gqfuIHc7XU1pjLXSLLpLzd9KIAM02uvuP9qHpOUO
	enB7YP6gGdI7zlL/NDabGdvUYGvQ6fpyP48yF4q+1CwMQj4OjObkGAKEf8RAFviY
	Mp5hUxBZR3xBpqcPbaUnID/EihF3ertvbiiadcBye/4TSFNMmsmKuJUQUEfCsdED
	zR2p5vwpmSEarQwQVKqLQgRRJJkFypbdNkxV+s0m0Mlnp/qIYadu6CcjTgbpqnqu
	n+NSJXaHzKVT4m5cj74yf8W3nBAS0AtCFpiKI4hTZFQfD5qui7QG15r/0so/Ye+P
	8mcjU84/5FtAkCfIJCWCg==
X-ME-Sender: <xms:InYdaWmPVUnwXS6C4jC1UGxcvZYg5_N4_CY6ZZazfXhmRAc0LbITHg>
    <xme:InYdaUx6sgHNgTfp5gT54KKZRSfUNt2b-xo_DY3ot0B9Yuuk6fOcQBoi9j7sR7pBX
    3lZYGwV2HcPmKxN0XPCerVysIGUAWAtMh_yodlD7WBiPDDhzFOC>
X-ME-Received: <xmr:InYdaaTFEDWCv_cCocCwpfTp1wtW2md0n0jaUhwXQPqPTQMUQodrNYHWQBKZmHzLMCOcM0Ip-Qawy0KOwcDgEKp-ZjZGsCTG49Xq6-cvBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdefieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgovfgvgihtqfhnlhihqddqteefjeefqddtgeculdehtd
    dmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefr
    rghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrg
    htthgvrhhnpeeukefffeegfedvfffgiefffeelhfekvdfhvdelieeilefhgeeihfegteeh
    ledtudenucffohhmrghinhepihhntghorhgvrdhrvggrugenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgt
    phhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:InYdafv_Wn3UW98EMjVpMVhbQoOKDFQaXbnOnjmNTLX6TqzilQbT1g>
    <xmx:InYdaUt1Q2jGc-uOz8UFTKDAinhE68tgF9p1TjV3KffQbVAj-9V0BA>
    <xmx:InYdadw_6eyzWEQTfzhtc4Vea_iMrr8VoNOuMcz6SwEQuUT94jPUbA>
    <xmx:InYdaSjifiQLQVmMFgVQ9-5ywjX2ctqj90V92z_0_XcQJojmN9Mdog>
    <xmx:InYdaS1EywnYa0VodF5DkAKheFLjBpJSemKUg9zxb75tU5O-0F5eCtQK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 19 Nov 2025 02:47:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf21925a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 19 Nov 2025 07:47:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 19 Nov 2025 08:47:06 +0100
Subject: [PATCH 06/18] streaming: create structure for in-core object
 streams
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-b4-pks-odb-read-stream-v1-6-adacf03c2ccf@pks.im>
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
In-Reply-To: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

As explained in a preceding commit, we want to get rid of the union of
stream-type specific data in `struct odb_read_stream`. Create a new
structure for in-core object streams to move towards this design.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 streaming.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/streaming.c b/streaming.c
index b8ce82483f..9018b10b23 100644
--- a/streaming.c
+++ b/streaming.c
@@ -39,11 +39,6 @@ struct odb_read_stream {
 	enum { z_unused, z_used, z_done, z_error } z_state;
 
 	union {
-		struct {
-			char *buf; /* from odb_read_object_info_extended() */
-			unsigned long read_ptr;
-		} incore;
-
 		struct {
 			void *mapped;
 			unsigned long mapsize;
@@ -401,22 +396,30 @@ static int open_istream_pack_non_delta(struct odb_read_stream **out,
  *
  *****************************************************************/
 
-static int close_istream_incore(struct odb_read_stream *st)
+struct odb_incore_read_stream {
+	struct odb_read_stream base;
+	char *buf; /* from odb_read_object_info_extended() */
+	unsigned long read_ptr;
+};
+
+static int close_istream_incore(struct odb_read_stream *_st)
 {
-	free(st->u.incore.buf);
+	struct odb_incore_read_stream *st = (struct odb_incore_read_stream *)_st;
+	free(st->buf);
 	return 0;
 }
 
-static ssize_t read_istream_incore(struct odb_read_stream *st, char *buf, size_t sz)
+static ssize_t read_istream_incore(struct odb_read_stream *_st, char *buf, size_t sz)
 {
+	struct odb_incore_read_stream *st = (struct odb_incore_read_stream *)_st;
 	size_t read_size = sz;
-	size_t remainder = st->size - st->u.incore.read_ptr;
+	size_t remainder = st->base.size - st->read_ptr;
 
 	if (remainder <= read_size)
 		read_size = remainder;
 	if (read_size) {
-		memcpy(buf, st->u.incore.buf + st->u.incore.read_ptr, read_size);
-		st->u.incore.read_ptr += read_size;
+		memcpy(buf, st->buf + st->read_ptr, read_size);
+		st->read_ptr += read_size;
 	}
 	return read_size;
 }
@@ -426,22 +429,24 @@ static int open_istream_incore(struct odb_read_stream **out,
 			       const struct object_id *oid)
 {
 	struct object_info oi = OBJECT_INFO_INIT;
-	struct odb_read_stream stream = {
-		.close = close_istream_incore,
-		.read = read_istream_incore,
-	};
+	struct odb_incore_read_stream stream = {
+		.base.close = close_istream_incore,
+		.base.read = read_istream_incore,
+	}, *st;
 	int ret;
 
-	oi.typep = &stream.type;
-	oi.sizep = &stream.size;
-	oi.contentp = (void **)&stream.u.incore.buf;
+	oi.typep = &stream.base.type;
+	oi.sizep = &stream.base.size;
+	oi.contentp = (void **)&stream.buf;
 	ret = odb_read_object_info_extended(r->objects, oid, &oi,
 					    OBJECT_INFO_DIE_IF_CORRUPT);
 	if (ret)
 		return ret;
 
-	CALLOC_ARRAY(*out, 1);
-	**out = stream;
+	CALLOC_ARRAY(st, 1);
+	*st = stream;
+	*out = &st->base;
+
 	return 0;
 }
 

-- 
2.52.0.rc2.482.gaa765fefd0.dirty

