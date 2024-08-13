Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC993A8CE
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 06:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723530268; cv=none; b=Me3xGKpXYzEhaeUYa2X0TxO53F02M/JtijoSaHcmvMUR2+IpZlLMiCS3R6GdtlF867/D0uEcAMrvS1W56yM9UcZed2IpatQsJ97hBCA0G3+lKthPdMPk3+p4EKtRk0v1CQL3FaCpEDkJv7hc1V4Dl7g+6u2Rq/84QhnO0xMvggw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723530268; c=relaxed/simple;
	bh=/n1ONX+6Rl8Wxi2ERbWSYHCjKw1b17YJJeMkYdzohw8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC9bnwXZAVH6AIBAYUQIdRyqIDzaFeUZ/zqfAJkNSphtODnlseoisF8wV8EuQeqI1Wsy4iXmvbxF6MupkBpmKQR/PQEzG2pZ66fzE7gOdMuebisJpUFoMSgdc0ZQ9v1d5LgUh9gLAbZysvlKdy5rz5D83SK7E5Ufo9xZWmH2uM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jFxwLgmT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HoPSKusg; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jFxwLgmT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HoPSKusg"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfout.nyi.internal (Postfix) with ESMTP id 61029138FD36
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Aug 2024 02:24:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723530266; x=1723616666; bh=lSyf3bDsCR
	KY5WWxvlKmO3/3JrFUopcOcNf1JFBjfxs=; b=jFxwLgmTlVNEgkBNzAwCasr3Qm
	NuxqEKjWLRAXJSUqFMXiNUEkLASd9+1N3IWTBgJsXakfgiSZlLeQolIgj6Yn1Bfi
	ykSTJ9hICrddLLAWa8lCw6KzHLV9q4Gu8DWHJcAr8w/Moxx6MXJVR6eaPIcWMzDN
	REVjMeowH5fJ+6A42EDkGi7AdyksDyw5vzgR8DEL6OLRKCkaeGgAif35q5+vboi6
	/MMCggZjSlLOxtSbTHpL72EFaatkwWjaR+m0hknbjJBw6QhUzPmEbunZ4PuEWK3p
	F85nLTm4sFIi2ywuj5sp9Hj23IWZTegC/1kyzk3LPKDlvjIKKeGFa6gbDPAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723530266; x=1723616666; bh=lSyf3bDsCRKY5WWxvlKmO3/3JrFU
	opcOcNf1JFBjfxs=; b=HoPSKusgBvx5cW72PVH3X96Qc/Gmpj3R4bkWJKJuvpQ6
	l1zXE9/OzXHz1ZKk9LOr73fXAbqoVr5qEoJSKVPCdum6Na7psvin9wR1dccD2SWC
	z3T1CbUJ6SOy8xueXNzBQExgmi+oXv0Kj65ZLp+3M6kGvQJ9oVd1ktEKp+F3usxf
	89aELosXulbWxpQOm8x6jFkAW48LD80J1UvPtSCFPlM1UkxQLoB2XrGM8/5eYHJC
	AgMouHhPUdAza/7+jSPwo8/NxYthJ0XCAJTTbN/r5NRhRE1XVJQLflxkJPQfO6KW
	t2/zLMbhrBlHoOp7YUJDYlHAheg8dIUIUwJdWDR56w==
X-ME-Sender: <xms:Gvy6ZmNbs0mNrRaWqUAD0WKk5dc2GRV2ewfVLawTavRds-4BuYLUXg>
    <xme:Gvy6Zk_3suZ5lpmnH8DfTvjnYVYbg9WTmNFCnZ3P43F8pFKgaeTiAdAe24zsTImnD
    B4n5V3h3WGl8KpvTQ>
X-ME-Received: <xmr:Gvy6ZtSemHoqSOdUWIe-skoS6EO-pQJ9WMfI2GzrRo4wHz1f0ncLTJ-OEKZoTXncPNbaFciPwert_vz8xUfnmB6fwoPcQGkiqA0ZAjthk54OCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtuddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeegge
    dvgedvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Gvy6ZmuEAdrpJdBsQ4A9ismWCZSvgh2zxH3Qv9zSSoYpc9JSldlNvQ>
    <xmx:Gvy6ZudHhUibPdPuD8Fn6fgxmZWZ8eG5d8Dzkl4iRhU117AgZooLvA>
    <xmx:Gvy6Zq3DM7vNHAw4n9eQr_-mrOQcJAKtsuUSnjMxMRIXwUTyiLuBzw>
    <xmx:Gvy6Zi9Q8RI80N6GbqBxqge99RbQ7LKTXNllmxJ2sz3pLNrfS7OVtA>
    <xmx:Gvy6ZiGSPr_gwY6VEf1ZmY07CtJDot_6hy6sx5i7i-izwheMRnhZk8KG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 13 Aug 2024 02:24:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0f0c8b85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 13 Aug 2024 06:24:09 +0000 (UTC)
Date: Tue, 13 Aug 2024 08:24:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 04/10] reftable/stack: open-code reading refs
Message-ID: <d5d24e03bd9d901e83ff3cd0f580b66e3601482a.1723528765.git.ps@pks.im>
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

To read a reference for the reftable stack, we first create a generic
`reftable_table` from the merged table and then read the reference via a
convenience function. We are about to remove these generic interfaces,
so let's instead open-code the logic to prepare for this removal.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7f4e267ea9..d08ec00959 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1468,9 +1468,28 @@ reftable_stack_compaction_stats(struct reftable_stack *st)
 int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
 			    struct reftable_ref_record *ref)
 {
-	struct reftable_table tab = { NULL };
-	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
-	return reftable_table_read_ref(&tab, refname, ref);
+	struct reftable_iterator it = { 0 };
+	int ret;
+
+	reftable_merged_table_init_ref_iterator(st->merged, &it);
+	ret = reftable_iterator_seek_ref(&it, refname);
+	if (ret)
+		goto out;
+
+	ret = reftable_iterator_next_ref(&it, ref);
+	if (ret)
+		goto out;
+
+	if (strcmp(ref->refname, refname) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		reftable_ref_record_release(ref);
+		ret = 1;
+		goto out;
+	}
+
+out:
+	reftable_iterator_destroy(&it);
+	return ret;
 }
 
 int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
-- 
2.46.0.46.g406f326d27.dirty

