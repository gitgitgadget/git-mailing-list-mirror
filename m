Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B633F9F9
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 06:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724308484; cv=none; b=q5+Z/4grWCaFFw8IGDGxRG4cO4zB4ku7MtxedT0XWaWzOBg4wrdV7WUIIUHsg2/jRrt4h5KxiOhSwM6VP0977S15gnM57zqe0PyZYRzHKlcwP6s8jSKUQlRzrzRGzvHHE1CIYN0Us18pSsPtotLWOxhgu8wB/Six78VhyBcbyNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724308484; c=relaxed/simple;
	bh=9AMmEU6dn6hK4aEZwweXr6TDxZaIUUXGWOsHyZBTwq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akw8ci5T43anl1ueATRHej8bsE5RR8fy4KPq8vYcboQklEPJcSQodSh7fKV/pqg8NXo7qmC/NKNbZZOX+F0WCsxXADjGLDgX9R/ehWuL3mc3m8w7D6wTKPnBHYUs8c8tJ1gOxSifE9raO38jSNLwVUqxgLu/Aiz9a6HCyq93vNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YaIHD3Ob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sw++VSmy; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YaIHD3Ob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sw++VSmy"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id EEB83138FF1D;
	Thu, 22 Aug 2024 02:34:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 22 Aug 2024 02:34:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724308481; x=1724394881; bh=PWVhlmu27/
	zqKL6sLqTigT4B710qyT6FlT5NXxYYrhM=; b=YaIHD3ObzwJtqNxktA5VZOLGIQ
	BXwJKP7UyjRUpCP+HRfKMhxEOKO7DcmJk7RP/YwOsb3Qt2KGBsLvvbOz1wx0oytR
	G3acnYQjiiiZeUDSzB3VRWtSRZdjCKtKPqKDqfQWbKKvRZPrYNmfG6IKeU9RpgMM
	rmjA0mBTb3sPxI0mAMbdm9vJBdAY/8C+FXXHQCMA69/xzrjt76hs8op4Bejx8adK
	d1wjBml83bx1SqGqhvimXMeLyTMKyatAy4I4VlkHHYaSSKRI1usz4AlnNAMLVMyZ
	gEJ0SbIcGaKSDN6/KIZUU3upwBoPZvIKVZqiDqEyHj4Orq6ktYuZB8qvgYaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724308481; x=1724394881; bh=PWVhlmu27/zqKL6sLqTigT4B710q
	yT6FlT5NXxYYrhM=; b=sw++VSmy51j3rYAQ3NoSE9C2kakCTCT5VMar0iex0fKD
	xrmv1P1N1ekTJXEK9C6Ap5Vx8Ou+q2/cIVqCAESDT3vGvm9diJVl/8+gYUc08ui8
	dGrZpD0JlbTIiSAl0aMsj89hRrlx4dGwwmnOgsGc6jGpg+26S3DoocsusmShbZTc
	rTw68TRqkO2dTkx/CrP9HQdWm3MY7Wg0Pu7/1K8mi1YRhQPHVr9ZBU3ES71Jg2db
	pJk8qZeFgKmsRNP90KIjHBjxpc07Ko/hkk/ILotJ/nMOvJQT2UK0GRDbTACQGH/q
	KuZh/AYdl0Sc3cRwh2P8tTfrjPTuqpwFqtZN5oyIvQ==
X-ME-Sender: <xms:AdzGZgkjRTEKaCj8Eo2s40LMCySkDdCtFPOUToOnE8YLoqBHzS3v6Q>
    <xme:AdzGZv0cLHq6eeCqDfOAFmepvmfoMnl7aKaDpw_EoXUyFiLLIvTsAS_NGy04Jb0uz
    26lTxZkxxsgfKnu2w>
X-ME-Received: <xmr:AdzGZur9b71_bHWCuAj78d2txfhyeA1V9SIsV9v23q-72BZJh81MABvuXDkl2wbBokcFVZHC8z-Z5x6XYWHklX1j9AyQBv24voo4G-MMVU661jY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    rhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:AdzGZsnEaotIK_GsEMLamMXbUZCjyUlCZyN68p_3c9qeuBJpJ3VkpA>
    <xmx:AdzGZu0j0jy4k8K7Azyr6H1hC7lCc_LAUalEuCdqb_e6WYx6h6sDtA>
    <xmx:AdzGZjvWItde_igujR3CovlotqPMmmCgmk_NgCe4uqs7iu4NiuK-Gw>
    <xmx:AdzGZqXKTwEb-ZNXKAa_iRwZwfJQ6ayzHzEW2ez9p3K2rSNxV8Mj_Q>
    <xmx:AdzGZjyou9896CdUOaFUfpYGN-rZG4EZVADHtp9l-z9lqEUcDKKMOWJT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 02:34:40 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e767441b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 06:34:06 +0000 (UTC)
Date: Thu, 22 Aug 2024 08:34:38 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 01/15] reftable/merged: expose functions to initialize
 iterators
Message-ID: <472c169b501d060a90607c6ca9552eee807cb286.1724308389.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
 <cover.1724308389.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724308389.git.ps@pks.im>

We do not expose any functions via our public headers that would allow a
caller to initialize a reftable iterator from a merged table. Instead,
they are expected to go via the generic `reftable_table` interface,
which is somewhat roundabout.

Implement two new functions to initialize iterators for ref and log
records to plug this gap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c          | 12 ++++++++++++
 reftable/reftable-merged.h |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/reftable/merged.c b/reftable/merged.c
index 6adce44f4b6..8d78b3da719 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -254,6 +254,18 @@ void merged_table_init_iter(struct reftable_merged_table *mt,
 	iterator_from_merged_iter(it, mi);
 }
 
+void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it)
+{
+	merged_table_init_iter(mt, it, BLOCK_TYPE_REF);
+}
+
+void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it)
+{
+	merged_table_init_iter(mt, it, BLOCK_TYPE_LOG);
+}
+
 uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
 {
 	return mt->hash_id;
diff --git a/reftable/reftable-merged.h b/reftable/reftable-merged.h
index 14d5fc9f05c..4deb0ad22e1 100644
--- a/reftable/reftable-merged.h
+++ b/reftable/reftable-merged.h
@@ -36,6 +36,14 @@ int reftable_new_merged_table(struct reftable_merged_table **dest,
 			      struct reftable_table *stack, size_t n,
 			      uint32_t hash_id);
 
+/* Initialize a merged table iterator for reading refs. */
+void reftable_merged_table_init_ref_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it);
+
+/* Initialize a merged table iterator for reading logs. */
+void reftable_merged_table_init_log_iterator(struct reftable_merged_table *mt,
+					     struct reftable_iterator *it);
+
 /* returns the max update_index covered by this merged table. */
 uint64_t
 reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
-- 
2.46.0.164.g477ce5ccd6.dirty

