Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9B4180A80
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 06:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732603394; cv=none; b=jLX0kh02UFu8QsQMu53DWc9T8+VMdQZW0F+TCKGr6RAxaOkfl/P7tR9QBCDrVYEei+BZgNpa4zXBHdR1oTFNFKBmIbogAvj/GSh1ur+yG8En1AGgl250JpirvgSqGU/V38OjEJ/GajaWw3jGXKesRzukwdjmsUC/fwN5qcwKUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732603394; c=relaxed/simple;
	bh=caHEs5YS+sovNq5SdAZZYy8gNO5YDOU03xMLNEbe+g0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1XR/yghigeNSAUWplbSXWDfRGdEtdvPpcujPIfkWf2YyvIoIIREstpnNDqU1PbAF4PJdbu80pXKjKFXy0twTFEHOpbR2Gd4G98NW8v5k0cGqCk5I8HMFvxVpibTnYlhFr+pQ8lTAOI6KBX9QmYSZsMD+JbrV0HPQz6m7ZX6/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E4U6AXs9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HbvfG5/s; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E4U6AXs9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HbvfG5/s"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 85BCA11401C6;
	Tue, 26 Nov 2024 01:43:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 26 Nov 2024 01:43:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732603391;
	 x=1732689791; bh=f3l+ZSUHDHw7zaVisfjA/AS4PEEsPrmN+yAyIINkxmg=; b=
	E4U6AXs9eGbF+zk4ZQ7O3x7OXgOW2LSZ+DUUYalLlrMNipmnPitTx80SMrr/WoMH
	6S5FxqsmBvc7Guf+1WqGjfD9dsgM3XnRoS9yhn93ULgtwXERDi3+Q9Ojx1aZ5eMh
	7byqLnAdW/QIt/NBjzxaqilfUomVQn6T5WyFSTO1MzClWktSaQ4ZSCo7piU0cRML
	OHU0OX2O+TT19GjFvPMGXkLSItxLB4c9sfeGcnA/1mRXpdEyE9hid+sb9NyC+sRs
	t3eEQmmp1ITkz0mbu4N5pEfSr/+SD3N+uWVsIZUgQbkQRI1qbH1p4vprFSknxmQP
	oioW5mhLoGfgck2wLTlJlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732603391; x=
	1732689791; bh=f3l+ZSUHDHw7zaVisfjA/AS4PEEsPrmN+yAyIINkxmg=; b=H
	bvfG5/st7RNGie9tqMOwcfw7YSvlhcALJhyIqkUXVoTSQxlDaA+THx25Ehn+XKW6
	Iqf4x8zIDQoRm7eAyliNcFZn+nsnBFEydIrVytJ9ge5EKzpuH+nlJ+d8Nj9O7zRl
	oTDl9DdxysSTnBIYeCbhev/pGiRuteyhL3GKzr4ELXPa7YYdGb/n3JPJ5JebzZ4O
	FiCXSgmRw+oGEp931/AgVO6wcuDCvPPRgh3y8EJO7gG/Qjt48CFPVFfvZTb7JxvL
	NQ/so30DWR3waFqXCaR0lXFL1VC27wPkXrgxJeLT6M3p1Bg0WzSEGoQ7TH1bV8Sq
	SUDukQ4M0Uf8hx9XXlWyA==
X-ME-Sender: <xms:_21FZ_1T9f3JCzPdzB3WnzhCWJarzcZHUHxcnY8f_qo7ZkewoiEUiw>
    <xme:_21FZ-EsHKbPF_aatL0sFOifph9MFCW9HJdM0jZgzkeTS7OsUjahFIN4INje2pMp2
    F9iLKz8KfnBa4P1YQ>
X-ME-Received: <xmr:_21FZ_6ZHX_rWkyyOFLyjM6_z4HpKP-FiJ8RtwXfiI-yyHilCxA2kE2n9keduBp1lNzfac6acQVZvvG0QOcMV403-3fGSirUaT63k2L-tE97Og4U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhht
    hhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:_21FZ00xADekU0NUMbbRDIkCLMYz4SxjMacViuUN0mrkg2DdaWk7-w>
    <xmx:_21FZyHwnwzFELLzn-xjFlQv-Pjd4oX7xr_15jPzVH8q3lR8hhjqgg>
    <xmx:_21FZ1-AKY_yVCGk1gXSdt5ipacrzxcFPrr52GDyEtvQZRstgJCdJQ>
    <xmx:_21FZ_mTMmqTjLGuml3cQR4y-y_OccvPXewl00_WFLW41fEk4ULLcg>
    <xmx:_21FZ-Dyd6-y19P7lryEaAsytve0dMpAfeGrazzRJRGX51_S2OHIwA2b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 Nov 2024 01:43:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id bee29068 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 26 Nov 2024 06:42:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 26 Nov 2024 07:42:54 +0100
Subject: [PATCH v4 03/10] reftable/stack: add accessor for the hash ID
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241126-pks-reftable-backend-reuse-iter-v4-3-b17fd27df126@pks.im>
References: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
In-Reply-To: <20241126-pks-reftable-backend-reuse-iter-v4-0-b17fd27df126@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Add an accessor function that allows callers to access the hash ID of a
reftable stack. This function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-stack.h | 3 +++
 reftable/stack.c          | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
index 54787f2ef530406a7970db058c3a0cf456897978..ae14270ea74108cd4c314ec38e7d5c9a4e731481 100644
--- a/reftable/reftable-stack.h
+++ b/reftable/reftable-stack.h
@@ -149,4 +149,7 @@ struct reftable_compaction_stats {
 struct reftable_compaction_stats *
 reftable_stack_compaction_stats(struct reftable_stack *st);
 
+/* Return the hash of the stack. */
+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st);
+
 #endif
diff --git a/reftable/stack.c b/reftable/stack.c
index 1fffd75630266c0d3d1e4a2d037b5cf90455529d..d97b64a40d4ad05cfd9e6f33e8ba1e713281ef6d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1791,3 +1791,8 @@ int reftable_stack_clean(struct reftable_stack *st)
 	reftable_addition_destroy(add);
 	return err;
 }
+
+enum reftable_hash reftable_stack_hash_id(struct reftable_stack *st)
+{
+	return reftable_merged_table_hash_id(st->merged);
+}

-- 
2.47.0.366.gd4f858ca17.dirty

