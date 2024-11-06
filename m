Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C730201256
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905865; cv=none; b=NAuNR9ghElKj0bpSwM1x8tVXZ2C/rda0JBjEyoyqbcdd4XJh5ro42S+oF8gMKD2adHisGtZ3eQjVzCij2sTn/Ps0BB5n4Y3yZ+XVi1ggqIoADkctcWk7b5NOrkWr5RIJq4hbI5LcO1v8KkdoAl38ahKYLxsNrHNQqR7DP/DKfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905865; c=relaxed/simple;
	bh=RwoFxamEH7jTMKoPgW0OF5hw4sZwaz50ZU3z3/BrftE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qhf0zjshzGpeY9N5nXVsiOPGOwynheGt/kqooNwF4IJIGqalLj7wyRNI7+o7LqfT5dwox1a+z9fV8lvNu0XZj2ysmpYNHeIO2a4nzhiHiB6w5xx1/5VPRWlejHkxI1ZNnFPnKTptHwk681lNxcItxvGqOApJP5s+v1XGH0USynw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vP3Go9Yx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GR1ejy70; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vP3Go9Yx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GR1ejy70"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 94D8F114008D
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:11:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 06 Nov 2024 10:11:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905863; x=1730992263; bh=tMo/EEfWgh
	iWYGNLJ+9z6EdA7i/jNEbiNFzskvfoxrE=; b=vP3Go9YxNpS5/I1CwQe/7fWZBV
	aCspj4/JtaOdouqHTpSpS8oXg8ENFxpeu2LNLpF5XCqFHIqSNsxywGwUtzuvWNPS
	rjIWvwQufIBiPq4qiruNSCt8IBxG/+N13ArK0wNfptsIqcYfGS1VyNsY7UMqdrhA
	r3oxtWtnJBrQNM1pOg6usmQkW+OiZ23oHXT5n/u0Gjj0KF1LRH2FV2poCst085sR
	/hcePgA49f7uSiQjlxtKDW/3w3xIu/474ywsR91paEkAizJO9XoGqLDmYfgoMbaV
	vxG8TlRsqmOHPFr2zv8e+7Yhazh42tcUf8lZsW7uYaYFCOnpgDRqcfrx7sig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905863; x=1730992263; bh=tMo/EEfWghiWYGNLJ+9z6EdA7i/jNEbiNFz
	skvfoxrE=; b=GR1ejy70gQ0jePBWt/1568LeG9kp5mmS3nGMRxuFiD+c8b7SWzP
	BiOuB3Jgqf7yoVyxhX9uX25f9E/Mj8AFRHeWZ1kisZOr1OelKjgy7W+PNKojRjhU
	9iJAVsA5H1ZjwEbQGJ+toVHNzTu0zAxUFaA8N3n5EGQqA0xs1dTgsKeRonTfmB1e
	dEDB+nsXNEwOdH7evKJ99qi7JFkUFPja5asjDqQzIF50GFOAMGEG0IoXtadSI/ry
	tTh32StowI6J0SxOVYF0HSBNClAlSCoCOGY7KTi29QXLVZLK6GGsnMNHq26WdDM2
	TkgKDUP9YJxrdzjAh4uQXHJRvoB/yyFwWhQ==
X-ME-Sender: <xms:B4crZ584etFoesSt4mCnN97vIvhNBBqyhnbKjxszbX6_riZES3eSRg>
    <xme:B4crZ9sRc1zgo2Q9KAIJxPAO-rDH6sbe26llLFEoqsZ_ByeV_qciT9q0huu1PM8xs
    8r-TL7f7T16twlggA>
X-ME-Received: <xmr:B4crZ3C0TRYl1L50WDI8qnzafxtr2trM8eL5TYm4twyC1Qf8Ni6sMV5oqLb0_pyHUnLWOamU40pCqYfsMqH9s27OsVlJTp_LOi0wXFjZ59H4NQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:B4crZ9ffVQs9bi42GS47lknVkLvyrxm8-ICYbFOWn_oHED0MykHgiw>
    <xmx:B4crZ-M8IwOCbabGFwqLUa9vbQqm_SzIOLShH633GlKb37B60aTwew>
    <xmx:B4crZ_l633qrxd7GedurxV2KEOKEDGB0L5zW0SMPb-XuH-rDIVqfRA>
    <xmx:B4crZ4ujzNfIRuY_f6J5J1oiaeDO60V7FFlrmtykDmRBM29f6khAlg>
    <xmx:B4crZw1vgso33AlJlYbu1jAlyXAjb-4SucETn4myTv_fRe30NuMbGpiX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:11:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42d0e54f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:38 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/26] split-index: fix memory leak in
 `move_cache_to_base_index()`
Message-ID: <88e727407242248173f1e0f39d7b85b681234f4a.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

In `move_cache_to_base_index()` we move the index cache of the main
index into the split index, which is used when writing a shared index.
But we don't release the old split index base in case we already had a
split index before this operation, which can thus leak memory.

Plug the leak by releasing the previous base.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 split-index.c          | 6 +++++-
 t/t1700-split-index.sh | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/split-index.c b/split-index.c
index 120c8190b18..cfbc773e6cd 100644
--- a/split-index.c
+++ b/split-index.c
@@ -97,7 +97,11 @@ void move_cache_to_base_index(struct index_state *istate)
 		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem_pool);
 	}
 
-	ALLOC_ARRAY(si->base, 1);
+	if (si->base)
+		release_index(si->base);
+	else
+		ALLOC_ARRAY(si->base, 1);
+
 	index_state_init(si->base, istate->repo);
 	si->base->version = istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index ac4a5b2734c..2625ac44889 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -5,6 +5,7 @@ test_description='split index mode tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We need total control of index splitting here
-- 
2.47.0.229.g8f8d6eee53.dirty

