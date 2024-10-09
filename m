Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEB1197A8F
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480330; cv=none; b=GKsOkUUfP8vpVB+CDwAQ+S3glNL8xo4NAhU5+vHe4vdnVpse/Kev8ND19LVSbKAaZLiMtK0IfMme16fdD4HEt22aeNHMIpNUdLUv87UJhWhrj5jFu544rFxTcY3vRYg+fjcKK5y6TeqeTFVM+gZBU+a7DLJ6w154Le3aCtSYIrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480330; c=relaxed/simple;
	bh=mSbQnWsBaBd2VMWDG8A528q99JLvTJMJ681u0w7agyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H93I0ZzycY4O3qoTvBw/5Z51CrzVzXkS06biN4I82I/eXdnFeiw6UfGoEdQ5r18NGj9tvdoRSk9MkTjI4spWWGDcPNe/MCqj8rw84+WuQNYxKYb6GYqaEYUnSw/+EZWeK2cL0dKlAfyRyoc0aKr1jF2hUq5MktH83mHpp5eh8X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gidMSci3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRwkjnmp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gidMSci3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dRwkjnmp"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5ADA41140122;
	Wed,  9 Oct 2024 09:25:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 09 Oct 2024 09:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728480328; x=1728566728; bh=I1SRFazplQ
	CZroKhQ8qoUf1zvWTp/bdltE+1eVAUlaQ=; b=gidMSci3GpBbJMGuy+83rH1O8G
	UpsrL4dPbhyrWW1osF9qxOjVN2tOsXRU9W4o0HnwYO8rXlFfFxFXv88eTwm/fUKr
	Wv2xRjSPZYTCTqKFqxsv7iPLB+ddwTZnyBBcjakZ6Dsow4UmgoBv07749noLmMN6
	ldgqRzv500x7w597FJ0BBxvmFMQ9WY4qmuC68Q3NKDmSncl3VoJ05TfifXWJQaVS
	sdbP6RPhJHrnZyW3hWpEvh1pjkcZVdiCrtH5A+9m9gmUtf59YKFTEOlR38IRId1J
	6FlyMEJSjUzDMxZFfTiSCpdZLbPss+1XsC8T52kIplOD8bU6Cu50BodxABaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728480328; x=1728566728; bh=I1SRFazplQCZroKhQ8qoUf1zvWTp
	/bdltE+1eVAUlaQ=; b=dRwkjnmpGByXFKN7sfkjC91z+EmLcgFklBRmC7QPvAFq
	Agg/YOSiZVF6fStzduE/hrre+YLWNa6edRLXSL0rD4y+XpeLulzGcj889Ii/CeS9
	03Ir0gF1JsSgV33x2NmBMHcUluW2j6Nf09A5I/uCmudjzfi64tJv6d4m144irVTP
	v5CRBHm5S0fOtfSNj/HRnEsD1cat0vbfg6txUQ7PBw7qrVXr8L/D6mv7Kbwbxivu
	k8k2Q6yAOTbmNzqDjfHN1aBaiK4RfUtl6qZmldVv2LhRKbyjqyvJnLba+mHIsb2r
	iH2hhsWNHIbDDGpxnncUYzsA2EEA76JYHGz3y7yzGA==
X-ME-Sender: <xms:SIQGZ6PoiADSMbonGb_9ETA5uIxhIHd0Nth8luji-JC6CQEI1J42yA>
    <xme:SIQGZ4-bh1MYu3ACanEglgxerMJiCDT4sdeYAAkSeT3kI7XRrhf0w40YWp8T2Qnle
    UxfyqnxEAjl3U9ePg>
X-ME-Received: <xmr:SIQGZxQOtMe8tkLJnW5JuMe-6lzXPbaVTTrBoYKc7GC1d1GfxMFYY6NKt2cMLSLzU_aTBNTw2ZyeS5dK5-lrZr_bwdxpWmRQeJTlaKgYlHCnzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SIQGZ6tio2Neiq7xlJwZBHt6LLH7NWf1kxnKIc1vtiPzWFUKoF02ug>
    <xmx:SIQGZydpHrMqOdxf5NlqsJ2pgcO3SrCOF6GFTuRFnL9636xyVLVJLQ>
    <xmx:SIQGZ-1rRtmvqeVCWXOwHE1VAK5X3-HOVcbv_2k-orHfObo3Sw6Uyg>
    <xmx:SIQGZ29zDD-safm7wAjIJ00ZCUabtbsH7oTizO5YrIQCOFgp1On8rw>
    <xmx:SIQGZzrUqCIESwFx8Ynw3ieylo_3PimY2W9PovW_TnUaO4JD8cjAQ0Dz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:25:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 374e4395 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 13:24:25 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:25:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 4/5] gitlab-ci: introduce stages and dependencies
Message-ID: <6ff5aabfe190dfc0e75c7b995a2a63e8f5cc640c.1728480039.git.ps@pks.im>
References: <cover.1728480039.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728480039.git.ps@pks.im>

We're about to add a couple of jobs for Windows. As the Windows runners
are quite slow, we will split those up across two stages: one stage to
build the artifacts, and one stage that runs test slices in parallel.

Introduce stages and "needs" dependencies for the preexisting jobs as a
preparatory step. The stages will lead to a more natural representation
of jobs in the UI, whereas the "needs" dependency ensures that jobs do
not have to wait for all jobs in the preceding stage to finish.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 4abfbc3e20..e13e8b3866 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -1,6 +1,10 @@
 default:
   timeout: 2h
 
+stages:
+  - test
+  - analyze
+
 workflow:
   rules:
     - if: $CI_PIPELINE_SOURCE == "merge_request_event"
@@ -9,6 +13,8 @@ workflow:
 
 test:linux:
   image: $image
+  stage: test
+  needs: [ ]
   tags:
     - saas-linux-medium-amd64
   variables:
@@ -67,6 +73,8 @@ test:linux:
 
 test:osx:
   image: $image
+  stage: test
+  needs: [ ]
   tags:
     - saas-macos-medium-m1
   variables:
@@ -102,6 +110,8 @@ test:osx:
 
 test:fuzz-smoke-tests:
   image: ubuntu:latest
+  stage: test
+  needs: [ ]
   variables:
     CC: clang
   before_script:
@@ -111,6 +121,8 @@ test:fuzz-smoke-tests:
 
 static-analysis:
   image: ubuntu:22.04
+  stage: analyze
+  needs: [ ]
   variables:
     jobname: StaticAnalysis
   before_script:
@@ -121,6 +133,8 @@ static-analysis:
 
 check-whitespace:
   image: ubuntu:latest
+  stage: analyze
+  needs: [ ]
   before_script:
     - ./ci/install-dependencies.sh
   # Since $CI_MERGE_REQUEST_TARGET_BRANCH_SHA is only defined for merged
@@ -135,6 +149,8 @@ check-whitespace:
 
 check-style:
   image: ubuntu:latest
+  stage: analyze
+  needs: [ ]
   allow_failure: true
   variables:
     CC: clang
@@ -153,6 +169,8 @@ check-style:
 
 documentation:
   image: ubuntu:latest
+  stage: analyze
+  needs: [ ]
   variables:
     jobname: Documentation
   before_script:
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

