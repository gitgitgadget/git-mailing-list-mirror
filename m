Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B3717BD6
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624749; cv=none; b=JkUig2KNI8T+sDLCmNHwbIzY9QhZzyVIs31QsS+L0X+KxgZCwd1Gnyx1Jxkwh+TEVWVJryayQt30J0vracbv7m+KPSpW10wtmAYflikiI9vetFLpVETHhg69hM0BVZOFj4kX562Ze4UpVXnegA5AocsaWATYhbvbNeqGa1cwDXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624749; c=relaxed/simple;
	bh=tgf0OzZ6vuqhuhaUTvcG/E9zISlOXXdkQBRamJsdNIg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OydyaiTiT7frXNEhaixoJW01EhYPVfd36PAQAel7cq2TSRwTHpkCK4Kf4SoyX/tQLzQqkkvkMvzoBVUUAx1n4dDbZBoLuwPSkBPcAwn9Y6s/0Gd2qCaL7cm4+QJWn5jWLCdqPs7ZuHEmtqwNYHooyU+tqOBkfgliiWLvV4MOd1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ehhlwww3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZONdqBLU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ehhlwww3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZONdqBLU"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8C82B11400E9
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 11 Oct 2024 01:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624746; x=1728711146; bh=AA92HFalRt
	xRyoO1rIrKdaVpaQIBuLNNOulhPy1mNDY=; b=ehhlwww3iGk4Y0npvb9i3QFFTL
	WhHNi1VHj4QfJIPZBs9GpLvcy6/kkSo//9ZZDXOiJMEF6VWrBiJ4thzxMkWaD7v8
	BFrh1MZsgACtKMK4F3t6uKs6Nl8sWaAEEnUl6QAZLxJkfGMdN/gmIGkGXN4GGF/f
	OeTDLK/8MuJTXIAgEHnB/KA/9MfqjvlvvFwTB6JJH+dPh2FErYEQRIhmLVAL/G8s
	DG8oUBKrO90+kjUgyYZa7IekL67/OF+m1a690GriYFeWifsdrkIYJVk40mM/LKQ6
	HuVfCgHZPvjuWFdzx/0wMEplj/SMSnmkBvSokebYH+ha7a7IIxN+bVK2ZXvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624746; x=1728711146; bh=AA92HFalRtxRyoO1rIrKdaVpaQIB
	uLNNOulhPy1mNDY=; b=ZONdqBLU9HnCsxVrqoYI7RocKHB+Y3So8+1Nn/H7ZTwP
	hIl0DcUUPTWCGtos7G1dDifscXjzqu6lUr706GpuEB9UToEqoMuY7RMv7BFaX0++
	g1Jgf+861kPeXQERjdTrzowdsyZES1SrmcUbtR63p8s0TTdDyZ6rh9ug2O9ssc5T
	52wIezTufqRe3z5eFp+aIfT9qtHoHBE1o0cCMFsI1mvrRhkCNUvo5etHGdRlmbgz
	jnnfkWzGStSL9t+nrS/kXhWXYC4/naH4f0QTDNbBg4SnXGeUSr8Bw4cOg9/4QDlA
	7NKCEPN4y3xVz3VlyUSVRtXMa9wKJf93Y/G7dH7lcw==
X-ME-Sender: <xms:argIZ_xjIkvZI-93w9BQMXW5aVqmC00LrXdSRXLiZdDvFkq9ltu-0Q>
    <xme:argIZ3QWv9_SUuzm98wf72nF-aZJ18DrRuOvGswfEXtctnG5_1R28zZcQNFA5qxx1
    v-8uQ4biXZKIQfZUw>
X-ME-Received: <xmr:argIZ5Uf2TSvGgBCAZ1UvOfqoM5m1MlXvou_qzlP_Z07gV8Y14mQrO2qbiJRhXXKyKtnlVlRJQqTX27FswCvxtIYftube2dDPPn7M9ypsYF0JvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:argIZ5i8ESu0HbXkLnacK8FlKZtEtEBi5EHe8OONJil7C3Hx8Gmmmg>
    <xmx:argIZxChYS7XXp2yX3gRIqoDg4i42aMlYgp-P6WoM_k-fereFzL7dQ>
    <xmx:argIZyKQ7FFD8UpS2gOCBMUD0aZsejHMWIuKZSm3Bg6nZJnTAH46eg>
    <xmx:argIZwB8LTl_HDxnWZ2Su0-L0MFTiUJDWbx0VQ1s-48Q0jUzNlCKyQ>
    <xmx:argIZ-7CulZd2Pee-x4tM9-j9DM94SxVYlc59-ekmSvwQWFZIOciwytB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:32:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a6e27ab4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:31:19 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:32:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 05/21] revision: fix leaking bloom filters
Message-ID: <7527b31a28f4c9d2e689c9749b6f9f0615ba1261.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

The memory allocated by `prepare_to_use_bloom_filter()` is not released
by `release_revisions()`, causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c           | 5 +++++
 t/t4216-log-bloom.sh | 1 +
 2 files changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index f5f5b84f2b0..8df75b82249 100644
--- a/revision.c
+++ b/revision.c
@@ -3227,6 +3227,11 @@ void release_revisions(struct rev_info *revs)
 	clear_decoration(&revs->treesame, free);
 	line_log_free(revs);
 	oidset_clear(&revs->missing_commits);
+
+	for (int i = 0; i < revs->bloom_keys_nr; i++)
+		clear_bloom_key(&revs->bloom_keys[i]);
+	FREE_AND_NULL(revs->bloom_keys);
+	revs->bloom_keys_nr = 0;
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 3f163dc3969..8d22338f6aa 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -4,6 +4,7 @@ test_description='git log for a path with Bloom filters'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-chunk.sh
 
-- 
2.47.0.dirty

