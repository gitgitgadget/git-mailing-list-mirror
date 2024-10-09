Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0C2197A8F
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480336; cv=none; b=JEnZLcSH70kCAV/UYannDUBEK++If8dhZ/bzGQSlEuukp11TvuDeXYMIckeW8olBXrUeVYIvFKjcxEnlU7y5R2k4YpuPfZpjHRICIZFEvYiMqxK5e79+iNhtNTzxoKqbP6vxft9XikGJartKmjgdAmncL3RrWnNQGZT3bjp8n6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480336; c=relaxed/simple;
	bh=Iy8X2SUpuaVJsImwMkFXxzvGZa8AeB27ZsGN1QNwMqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdHZUUz4DRwUHUvRrsoPlI4hubL1769Wlb2DtRTL2yLHrd4GMWQ+knP0+lVrKPwEcp/S8wkuZXNc3antA8FO2+Ucpa57CAzBIlUUeCqNzKny5/E0IkWaPCdW4Rh8c3Z4173D23s2NFXZXTbO6YUBqmVLnSbEqKAijqmu/ejYTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d/FJ/nn2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MQMGYCS9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d/FJ/nn2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MQMGYCS9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6958C1140122;
	Wed,  9 Oct 2024 09:25:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 09:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728480334; x=1728566734; bh=5wTs+YdBz+
	i4Af878mYXh3lFiQ7KTi+pFV0y/9r2xyg=; b=d/FJ/nn2SQ/rUq//tqyVfxnUmE
	/xS7xhoXYMSDgoIXwSMcSgus4OeC9ropGblpzLb7tDt6Q+fIpgJKWSRi/WNkhT9f
	+kx9j8Jp/PegG7jPmVVfjUwXmlAkrb3Q3BX0StiVsj+HhBl59TSyzGz9Ey2RLqtr
	773dOzdPJ3lFm5mxfJtJ9q4OI7h3WsGB68yy9CS/Hban9X/cxnLl2WZXLxpOXBUL
	C0cMCAq2gVFcNGKk1w4GdTKkmPfP2nznvuSMvvqcvfyG9xdtfYyVXBTDtmGE25wx
	YAtpmnN3c9FRlh6w1gXWa6FCYD003VJrPPq9tZDQupivdcbDb50lXW0MaSSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728480334; x=1728566734; bh=5wTs+YdBz+i4Af878mYXh3lFiQ7K
	Ti+pFV0y/9r2xyg=; b=MQMGYCS9CriC7LI3wHctgad4wKwV8v1jIC3KGOkAjNus
	DvgFGDnScYW5oIELF9qbmP/caO6DIv/lAvgIjU09QTg+yZ4zuWB3egR8Fy6JfYma
	Fcbs3P6HvLgbtMvW87GXiUekGOifwSCbveapBIMRJZTPT0rwIxkDMlX823qMMRy3
	gU5piV634G1Enpz2lHnMDpi00hjbcpjKFuPgsnsJZz2o9VWWhQiF8hqEIHIT5zS9
	5jI39fa5vnn50dVdQf0Mnp5WNN2DRikgIrfecj9ZCPJ8TvzVZ56intaGQb66dhsB
	ZzGFAL4cSMUR4pvp5fVp3EYpaPsIX788/2evqjk9nw==
X-ME-Sender: <xms:ToQGZwt_02TMNm8c0HvdlKSTXQsBrr3QX1VmD-HHJZ5syDfjxuj1dg>
    <xme:ToQGZ9cVS-JWybc-kVVAESbFgEcJu85kWQs2jvWezNIF6JYDGqKo_xTdi7Vslr1Vk
    6ZhV_1lmhsqTIWWFA>
X-ME-Received: <xmr:ToQGZ7zOK1u6h6uR64PCxAbJ6CfQ0rzVsfP2mkyPhNvmSby8dIBksAwakgETEdWcktdeds30EHmjXjG2TYtHu0Sf1lMesaJULOFlJeGoawwvpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgieejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ToQGZzNalw8MDGPUmtpbAdRv72nIbSc2kTWHgwCXJLBDScMN8FvGZA>
    <xmx:ToQGZw_-wjuWD73wHoPKZJJ6hw0EgT2Ehhdkt3eJ1_ShqhiOP2hSGQ>
    <xmx:ToQGZ7VCAltrSctbjr7I8-I-enNwqrULp885ygrcWg-Vmde_Wq1ZzQ>
    <xmx:ToQGZ5eWXq8nFWsRCp_cysMrQOEByrivUoyN-IZ25_LIKqeQ3Qg84A>
    <xmx:ToQGZyIe5JXzcRzKixLGOIv6z6dAHuJ-qCs1-HDKNSY4NprYhuz16Ruw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 09:25:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cb12b44 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 13:24:30 +0000 (UTC)
Date: Wed, 9 Oct 2024 15:25:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 5/5] gitlab-ci: exercise Git on Windows
Message-ID: <15b79665ac35c29d1582eebdf0c223fec358f236.1728480039.git.ps@pks.im>
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

Add jobs that exercise Git on Windows. Unfortunately, building and
especially testing Git on Windows is inherently slower compared to other
Unix-like systems, mostly because spawning processes is way slower. We
thus use the same layout as we use in GitHub Actions, where we have one
build job, and then pass on the resulting build artifacts to ten test
jobs that split up the work across each other.

Unfortunately, the GitLab runners for Windows machines are embarassingly
slow by themselves. So while this strategy leads to around 20 minutes of
build time in GitHub Actions, the same pipeline takes around an hour in
GitLab CI. Still, having late coverage is certainly better than having
none at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e13e8b3866..526ecfe030 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,6 +2,7 @@ default:
   timeout: 2h
 
 stages:
+  - build
   - test
   - analyze
 
@@ -108,6 +109,38 @@ test:osx:
       - t/failed-test-artifacts
     when: on_failure
 
+build:mingw64:
+  stage: build
+  tags:
+    - saas-windows-medium-amd64
+  variables:
+    NO_PERL: 1
+  before_script:
+    - ./ci/install-sdk.ps1 -directory "git-sdk"
+  script:
+    - git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
+  artifacts:
+    paths:
+      - artifacts
+      - git-sdk
+
+test:mingw64:
+  stage: test
+  tags:
+    - saas-windows-medium-amd64
+  needs:
+    - job: "build:mingw64"
+      artifacts: true
+  before_script:
+    - git-sdk/usr/bin/bash.exe -l -c 'tar xf artifacts/artifacts.tar.gz'
+    - New-Item -Path .git/info -ItemType Directory
+    - New-Item .git/info/exclude -ItemType File -Value "/git-sdk"
+  script:
+    - git-sdk/usr/bin/bash.exe -l -c "ci/run-test-slice.sh $CI_NODE_INDEX $CI_NODE_TOTAL"
+  after_script:
+    - git-sdk/usr/bin/bash.exe -l -c 'ci/print-test-failures.sh'
+  parallel: 10
+
 test:fuzz-smoke-tests:
   image: ubuntu:latest
   stage: test
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

