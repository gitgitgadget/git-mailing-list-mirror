Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E572FC009
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 12:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756990207; cv=none; b=OE7/9bQEl5TSyMUl1u1x7oYC6X9kEqLzUFWjXnwGaWgapxG2ybTbwmKq+5x+lmBHLlcWQGdwcgnzVLAfPo5oB+jHFaYESnohV222mIaO/BfnDFRKp+hyEtrPKOfATivpDTbi+UXGDAl65SsGzp5PT9NAZpMuB55L54JEWdv6WF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756990207; c=relaxed/simple;
	bh=T8JSQbFRF0W3WY+OyIt8tmxN9w8UnL4SM1wZRlPxN/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nnMxFNI0HX8U0dbJtHuxYgKfv71J5dhHXJ/bgBLKgCAbRrJvkkoPFaengZ0eGqF/dPvfE9rUqBKY1v9nuIdh7amrKI+oT68c4PtmTBKbzeaAkDiyZcazrkfq7URDwsi7Fg7x3vkNf81EKNEePEUnJ6ZcjgVpwY/Ww0aFairTOH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eeQjSkku; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fAKKVgC0; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eeQjSkku";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fAKKVgC0"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B67747A0396
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 08:50:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 04 Sep 2025 08:50:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756990204;
	 x=1757076604; bh=h4mFtH4y4ZWpHwRKHV1tcrZkuVn1++pEj+lKcVhfVfQ=; b=
	eeQjSkkuAxCQmRlKIfB5V7nRqpnHj7vnlrTnXoYWhsx+obs1UI/J33LEDpbbNv7C
	h19YaThihYnXaLShQ341y4FgoFTdcOBZNZF7JiCD1we3J728/2t5qPDcMZDLYE7F
	oTc4Tzhhyrs044xU3OTN7LS+cJB9R/3cKGbda9w+sGvFvvRAAgQo2+Bp6JjOMgnL
	ugvXdtrDMzQbKx1LtGlZZ22RGuWs8UeFd758hd5PxaI9H25v8lFcr7Gn7fpZ3iTt
	tepmwYUsMOC4LvfXn4jZ9qWd/X8bdH06mZdsjwJpLdond53V/0aeaqVUHMcIGU0L
	NcA2GK8rxp1c+vcE+G8TeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756990204; x=
	1757076604; bh=h4mFtH4y4ZWpHwRKHV1tcrZkuVn1++pEj+lKcVhfVfQ=; b=f
	AKKVgC0SwZwCFwpJORcTZLS1b0ksv9zRTZqT/7cagS+WYkl1nxV5mzoaphTlmlHR
	skdZno3Iqr9fhPHDaDLDjM1FEKrA1CQ1Fuu6GKHEfR+iM5ovpR5GXSnqoRKWZc7e
	RH3aFbmBeTh9FUul5zgzM8/CIuAGfBVDWHj0u3Y0bkJmv8MYjMdrHgyV1WF9Bmqr
	ECWjYoj4t8XZUeQOxUBi4bWBWxNzJWySVEFosjNhGNzindvHDjBNwDqzn/HINf1f
	6rNB6ThDk59h91FFqRdvPHNsRTVpUgxEp5Z/B94HaiffqUohzW1cvwRrhVEEifmK
	BX/jXIEVHkFofYhrPvFHQ==
X-ME-Sender: <xms:_Iq5aJJkG7vVG39hMc1CH8nIdKgHt07BhXr334lVUbZ0SnKOmloNow>
    <xme:_Iq5aHJpvxUOh5reiPkMWJXyLvHrlQBDTs8UQ3rbY5XJcv8AfaiDQLUN4BcNaOkjJ
    QD5SC6_gNbzitooRw>
X-ME-Received: <xmr:_Iq5aLHSybRbsJkF7i2-_fDThjdtyhW5EYZakYWgHBpAoyEjDQEBIk3O0JN1Wlnx16yMvyJAKQM_EOIXX-O_s0yV2HNAN5wssrfIoWlaoKRX8Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:_Iq5aMmwiqcNz8ABSh2MiEobEIcD8-UOg4JCczytJPy-tsluelNQtA>
    <xmx:_Iq5aILI2Pm4RLlt2JHKZ_dCHGukpqK6EDAZgAfRypwj7-S8Epjj0Q>
    <xmx:_Iq5aNY0Scj7bde1AqKLL3ZFNDRzlB8yf-Luf1QkuwdygBeY2W15wA>
    <xmx:_Iq5aKZify7qxNbiUmqkU-l07ovNdrn0mJTVrTM0-nCeLTEGxcx3dw>
    <xmx:_Iq5aPiZ1-zZBY8kexO2pfRR4h5DBJvMnHx5-rK_sKsBN0i5ePmrQyZN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 4 Sep 2025 08:50:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23333a1f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 4 Sep 2025 12:50:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 14:49:55 +0200
Subject: [PATCH 1/6] blame: drop explicit check for commit graph
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-commit-graph-via-source-v1-1-d932c2481e1a@pks.im>
References: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
In-Reply-To: <20250904-b4-pks-commit-graph-via-source-v1-0-d932c2481e1a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Our blaming subsystem knows to use bloom filters from commit graphs to
speed up the whole computation. The setup of this happens in
`setup_blame_bloom_data()`, where we first verify that we even have a
commit graph in the first place. This check is redundant though, as we
call `get_bloom_filter_settings()` immediately afterwards which, which
already knows to return a `NULL` pointer in case we don't have a commit
graph.

Drop the redundant check.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 blame.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/blame.c b/blame.c
index f1c0670144..cb0b083423 100644
--- a/blame.c
+++ b/blame.c
@@ -2909,9 +2909,6 @@ void setup_blame_bloom_data(struct blame_scoreboard *sb)
 	struct blame_bloom_data *bd;
 	struct bloom_filter_settings *bs;
 
-	if (!sb->repo->objects->commit_graph)
-		return;
-
 	bs = get_bloom_filter_settings(sb->repo);
 	if (!bs)
 		return;

-- 
2.51.0.417.g1ba7204a04.dirty

