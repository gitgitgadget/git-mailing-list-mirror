Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E63200121
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866563; cv=none; b=eno8GK0AkgoFKglXx9j1vphBERsNKy1gnrD1AUXA9tSVtJJmcVN26kpm1ws51KfYwN4jhvRgkW0hKlxayMtNSHUQHUjuNZ5VbwaAYvVmrbhOzQvvp0QrRQcGS1hdC8BUz5MQcRuzQIcwyp5pEWCFmhnE2LLWInsqk11LgFajLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866563; c=relaxed/simple;
	bh=xofDXl8q4K22VJ53veiXYSPxdRfBrc039/G542444dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYtCVXosIO/ZhI5r/wXduQfriOLnKTR5OzvHMQfjuS5ZkQnL9abIUKXrPoneLRx5NFhoNHby1htOVaU+29OlIgqf7G54F99xDGJl1e5XcEJ6JOZmN3YzQM8gp0yph4hYre+yjJgGYaHY67nQp3XIb5voozPMoRmj5flb9B0M5uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UdGo7zh0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDeOCuZM; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UdGo7zh0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDeOCuZM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EFB381140237;
	Wed,  2 Oct 2024 06:56:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 02 Oct 2024 06:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866560; x=1727952960; bh=oDRrIWmC22
	bLluO2AcwVBGHLbXpBHEkqKVOnaBep/VA=; b=UdGo7zh0ZeG/NSMGA0lP4PIr7b
	+bdKLcjy8095fZWJFVxntbNCVYrPnsX5JT9u3lM/EvqpYsXDbpT5rRCIhARL9qe1
	gOhZKFkR3Y76aSP2kiH1ThaRTAisIqiB2qVipv6qcGca3ppUPjuaBaKre3T+mZW4
	C/VxcbyH73Omf7/XgcagksYKokNgZtvLrPJDTqcaptt4O6XoVSQ8TWa6Grc9XU41
	4sCnKpotiWm9hP6vMn/zXFWwiSeP9kgQCsWL3L7vsikx6/wtPhQCMEUeh+JaCxMi
	wf/9FimRMeYICEFuUZcEULdvjDY7eXFbbQt8wIl142hvk8g7NWeCtAto8OLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866560; x=1727952960; bh=oDRrIWmC22bLluO2AcwVBGHLbXpB
	HEkqKVOnaBep/VA=; b=oDeOCuZM0aSILLp+Krg59Tq450+VC1voPNEZHZvgIxVY
	LyU+xqbeORwZl5I0Tph6S42YXUdfgS0kAnOqHATadnAo4mNqvKqhzWMyF0UqT95P
	M3NjoTMiQVOs9vvVHO+ijz1OXp1BvmV8AP/lSmv+WpbKIGrb1szoeQHdPb0p3oNw
	MipgBU1aWJ/HpsiBbqhAcM/P4H85YPBggqa1VAJUtnhLSVyjOGoNE+C2wgQmznuC
	lAOBtB5tylYjiqKu/9UKsaLsXzar/sXXeB7VMkX5pOTqSvI577jVx1i057T3DJ6f
	F1+0BqEHfjCueQC3MSrQso1iks0D8A//N4xYtnoSIA==
X-ME-Sender: <xms:wCb9Zlv3bSTiYQizBJhSpwkzqzkznRfCJf0uteAt5DAsIzCO9gnrxw>
    <xme:wCb9Zucv6Ij0tvBChgRxp17WtsQE3rXJ0gyHPAPnY4WZo3vTYO2SkMa0u13phtsBO
    Xoo5ka1YHhk3aWVYA>
X-ME-Received: <xmr:wCb9ZoxHOljKG8r8KyBUzjq9S5IIEnXqHmn9yhQmFGSHsf9BrFfrqFZDKSnlocsmFDFyJlyLNgzEnMPTWiC8pyU1UvWpnYa8EMIOeHYKyyjI5mBC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:wCb9ZsOqC48rMAkC040JSAFx1ISvY7wpGpDJ27yog9IIAAGrum4mBw>
    <xmx:wCb9Zl-raiWgswpoIulWztkrD-4DvKqFGmeQTlV98BvELNpGT3Sihw>
    <xmx:wCb9ZsXt3KJqFfGEBDO1Im_6w28nXuYn1Ba7rtUzxyRmRoiC1yJ9nA>
    <xmx:wCb9ZmfM6U9H0HKKFyj8E1rMFl4kr9jvRkPH3gOpLXGdZFi5FfGAXw>
    <xmx:wCb9Zhbh61tMyuz8PWWwwEcuWhQ1cu4DHgV4FWQUtXIAKfSTiMlV8PKN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:55:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8c99478c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:09 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:55:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 11/25] reftable/reader: handle allocation failures for
 unindexed reader
Message-ID: <7b592a6c6b8b08a7e8089364abfc6d2d6f6e83e4.1727866394.git.ps@pks.im>
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

Handle allocation failures when creating unindexed readers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reader.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/reftable/reader.c b/reftable/reader.c
index 6494ce2e32..485ee085da 100644
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
2.47.0.rc0.dirty

