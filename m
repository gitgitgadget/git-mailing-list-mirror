Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5506C19E7C7
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775759; cv=none; b=OZ/MZ9fszIFcGexPr82DO5dAY+WT8dyMSes1Y9pl7Udo8D3RFHGCmBpSOb0dCESHNVXi3e7LEUia7CdJmL95JGIhIhHJ69JGTq1oY4nf1C6YvI+XXBijGUDeK9odoHYOyp2+/qRsezTMCpm7NVwGmRDoouHf776T3IY5c1rpeqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775759; c=relaxed/simple;
	bh=w+2eowW1AanmbkxWiJ4TTQpslKYmKUD6TDLC/4OpVVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hW2g7WnlSyEtkvVtkc3DKShVaSttduIuMo6jVZM67Yzo4IkB1Vp6GcxpcQazLseTteGUpdjatACllc18m8pjSxdxnqAuMNru10lT7dL/l16PvgdyOVUraNj5wWgesoYpyHgjO4AUHdMVl8Um/wESoAyffVhXYo9Gv+cVYALjfcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iRK9srlu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HrNcTFkg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iRK9srlu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HrNcTFkg"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B06921381535;
	Tue,  1 Oct 2024 05:42:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 05:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775757; x=1727862157; bh=ctMvMp+aBj
	0Gl7Q5KgdMIXoAv9A2WUMeXeT3hFDa88s=; b=iRK9srluFJOqoY/PSMNXCBQcLh
	l0YHNpxWCBzndcPuWMVOzZwI9+wLkZthxYIIsBkTQRPSGw2hJpbGcA0uNkOAfG4n
	f28a+e2vv0icuOGgsnjW1PWWn6RYrsZYv10spPCvbfeWVx6boCQ+3L9t9D5oEZTe
	3n8H+ES7gM+lxEbL1GOiOr9+73cO/oyo6hEMMweiXnCZbUm3Ug/PhuFhbf3wuNcE
	rke6jrnmj11L63F8hV5QMhsOcBhe+0U5aqjnZwBPUa11NhNe7/08TAfeAzhpP8Za
	6HGDFBpX8wrl3x77o9FmTvetkQTQ0FTOi04S49AvXafJghE6fuIbvTYFkIqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775757; x=1727862157; bh=ctMvMp+aBj0Gl7Q5KgdMIXoAv9A2
	WUMeXeT3hFDa88s=; b=HrNcTFkgepPHrIP7W++KvDTtog3/Lhp30EUXitabHyM4
	qFD+ElGWPA2naXsxMrfNRDsQzqKEHqowin4o149b0EZ0KZyquqaIpAukwyj23XPx
	/dPzfCp/28El9JrIB7+TZFgXAFmki8FL0hHe0EpOJ/zWXp6Ct8W65L/OcChItz+p
	T1u9EArmi3+gEvpcnJG4a4wMa/yzTi7X123XApjnj8mkw36VHtX3JWoMzvD2myLP
	vGp0iFh8j2ferV3nCuE6PRE6tgljhZ7L9WYKEIvSmHet4KTLL9h0hMNfRoMW2Kxo
	u4o08pzIEE/xxGPT0F89ezQeX7D+X7U+VcvJJzo2Mg==
X-ME-Sender: <xms:DcT7Zlqt1BOUZ3_dzN28IQtOXpp3DG1un0nM1dzcxSsorFHEF2z1FQ>
    <xme:DcT7ZnrHOqi9-I7-Hz95gaZfEOqqxzO8CJCTJ8UGVc9b6wDr2SAlFhRZAl1RzEnFH
    3mAxl7GQ5v5n-WYow>
X-ME-Received: <xmr:DcT7ZiPjFhgqNx3_2AY0BIg0LczLzKL-bqkjkk9OH3nUQf2a7FDhNMseAOMs_7K5tbGLWAbQiYK-EfKzscFT9aH1unDHFc3JL8ns38AjaqEC6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhesvggu
    figrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:DcT7Zg6U99TEuo3KnGI3f6Zgfw_bsgnLfwmnIahfgEq5gbcdwuiF2A>
    <xmx:DcT7Zk5imvkitASAPMImoY_g_yzDzGNBww-AJIXf079ymi78K9QhcA>
    <xmx:DcT7ZoiL3L_sRmUrSId_5Be7PxSJambwJ70c4FpnaMz8th1ML0JBhg>
    <xmx:DcT7Zm4qQdo_od1EDOcTfBlZe2qjODpD0b9bjrssWxKBEnrRE24riQ>
    <xmx:DcT7Zv1YmGQvb00RnO5djss4hWH0bWfoEAd1YqU_V1e5ZOhbPvOoQAad>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8326b0ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:48 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 16/25] reftable/stack: handle allocation failures in auto
 compaction
Message-ID: <103a59ef0a5318b2ecef7ba65b7bb0c049b6dc6c.1727774935.git.ps@pks.im>
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

Handle allocation failures in `reftable_stack_auto_compact()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 2e6dd513d7..990784d9d2 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1518,6 +1518,8 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 	uint64_t *sizes;
 
 	REFTABLE_CALLOC_ARRAY(sizes, st->merged->readers_len);
+	if (!sizes)
+		return NULL;
 
 	for (size_t i = 0; i < st->merged->readers_len; i++)
 		sizes[i] = st->readers[i]->size - overhead;
@@ -1527,11 +1529,17 @@ static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
 
 int reftable_stack_auto_compact(struct reftable_stack *st)
 {
-	uint64_t *sizes = stack_table_sizes_for_compaction(st);
-	struct segment seg =
-		suggest_compaction_segment(sizes, st->merged->readers_len,
-					   st->opts.auto_compaction_factor);
+	struct segment seg;
+	uint64_t *sizes;
+
+	sizes = stack_table_sizes_for_compaction(st);
+	if (!sizes)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
+
+	seg = suggest_compaction_segment(sizes, st->merged->readers_len,
+					 st->opts.auto_compaction_factor);
 	reftable_free(sizes);
+
 	if (segment_size(&seg) > 0)
 		return stack_compact_range(st, seg.start, seg.end - 1,
 					   NULL, STACK_COMPACT_RANGE_BEST_EFFORT);
-- 
2.47.0.rc0.dirty

