Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7661DE3A4
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737022130; cv=none; b=kxD/McYJRFKytYDydeCGdBr6m49N6f6aDtfDN6Wf8KvUs+9onPm9BNzEEQsSD+2igKlz/+qhHx+FqaewguIF53A6m7pKfrAnesFS1ADkcNNRhBqbjj5fprB1IhnywSh5I/svLt6LYVVVvTy/UVYoADMIrb7B6rIKYjZcnTTR9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737022130; c=relaxed/simple;
	bh=6tvhN6EcJgITAjChpiuF7TVBt5Fr+ayJ+qqaWOlQjXA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6y4OisJ5PKb0ljtcTjYC7ikZMDqd2b8AjEby3zDDKWN/Mv2/ivUXowcXs/EJkBtHGMagL088SsY7fOKiiXycQOfsLrbS+qE4EA+QkWlYH+KVZcVFIcG5IMEN1k3dCxgoexvfOJMzoPNm2aqBPSbXDyu6kNHgwqtNJEro+Hss5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YvlOyWUt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=amtsEHCA; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YvlOyWUt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="amtsEHCA"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5BF0B25400B8
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:48 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 16 Jan 2025 05:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737022128;
	 x=1737108528; bh=T2SLHxlQijOEtbTTMYIgVBEVuxkdCkkIuy/Uf0jnA+s=; b=
	YvlOyWUtQiLj0LvTQ44EAAE/YFNr2vlXqmV1pIeYp1N0gSar0Ge+vYDqWgJDwkUn
	7s1XsZL+alfHbHL6THjZTM9JW0YJ+aKM5ELloFcvdZA2/C1OEZAazLjQIJ/C6Woa
	Apq3oRK444ioA5+C4cJK9rM1bJbcUg6P0QgQ/LmNv8lnhHbuA/eJJ2RS1OaobkOp
	rOAsao3JcS7OWLMmAQNermp8i1vqy9Uk83BtrLGDP1WGSKNiNavDk5uhv+AlWzno
	clpUSV3BmfhgZkA8fEUIlSy/OL50Htv63i+xG0rpI+OUewYcOJf72VHbCiQtTJ3Y
	fsuRoLgZ7e2tkc8XZU+9Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737022128; x=
	1737108528; bh=T2SLHxlQijOEtbTTMYIgVBEVuxkdCkkIuy/Uf0jnA+s=; b=a
	mtsEHCA2smJlC9525rQ0yxcaDMeCmkO2ZBMU97e+JvWjDELnDOaQSlcAqU12sqZw
	QcbMur5LRZLqPrLFaB2JYkRzoKHlP9l6FCL4hXI+JRiQqDcSIPz08rmerB4y5YXc
	VTjWfGmDKDtqb/wN1a1Tnwu4cP+wiVcKBv66rN5eMVBn0ldff2lrtzwOOTYsTw8V
	P1lHk61q+1yBIwowO3csKycu3F29ktrPgO+XTQholkCcv58T5hKRLLirdq9x4uRY
	WJS/uOrYxozCrK4Ib9FT3lUfGg/rtUq+lBPAI6qf/EAsKlVShzj0ZaOmcMWd0z9k
	5htAB7lhVGLfBfWX5k+Nw==
X-ME-Sender: <xms:sNqIZ7RzESOoEK6VdgZC-MQqQrAgsa2Rp0_Zmb1RJ7BKrb3LP1kcCw>
    <xme:sNqIZ8wXSKaJe3AuuQS6vFiDegdJv_8CV5OBjbXmUpwXLQ-Syg6_4RgOUtrKwGF4X
    Fq-7-rhSm7zGIa1eQ>
X-ME-Received: <xmr:sNqIZw3Cg2Ggsg0GMQuzFpY5DzrrkUE0oPJcMXZ4_ylQlAd9PIfTXAI1gT_1oNI_Z5rnFpUMUtXqmxiNJ9vuPEifi6G8455qIi0-olLit1mUcHHaXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:sNqIZ7C5UFSfiEI1tC76lGvnpo4mu7zQkF1Rpz1i8k446_cIRyCjBg>
    <xmx:sNqIZ0j0tnf-F56uowHyyC33PYjzN0ZFFfr4Ceq-WfOIhcEKWHGzlQ>
    <xmx:sNqIZ_pOpXuBnZhtVFObvHQP5_dN8XAfq7HYpfsCIh6cCA1FhMxs_A>
    <xmx:sNqIZ_jNbDdD-OQXHLTDLJCJNc5CED2Qpl5eDe_WcR0mG_nf6aPC1w>
    <xmx:sNqIZwZLg0No19OwcqqEweuDI8N7bkCwLjoSWlYNkM7zILQJaBpbnZcU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 Jan 2025 05:08:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2712bedb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 Jan 2025 10:08:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 11:08:40 +0100
Subject: [PATCH 08/10] reftable/blocksource: adjust type of the block
 length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-reftable-sign-compare-v1-8-bd30e2ee96e7@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
In-Reply-To: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The block length is used to track the number of bytes available in a
specific block. As such, it is never set to a negative value, but is
still represented by a signed integer.

Adjust the type of the variable to be `size_t`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/reftable-blocksource.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/reftable-blocksource.h b/reftable/reftable-blocksource.h
index 5aa3990a57..f06ad52e0a 100644
--- a/reftable/reftable-blocksource.h
+++ b/reftable/reftable-blocksource.h
@@ -22,7 +22,7 @@ struct reftable_block_source {
  * so it can return itself into the pool. */
 struct reftable_block {
 	uint8_t *data;
-	int len;
+	size_t len;
 	struct reftable_block_source source;
 };
 

-- 
2.48.0.257.gd3603152ad.dirty

