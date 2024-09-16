Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84097155CA5
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487199; cv=none; b=Ja+1BvAsrqUDw8EkPJL4e56KWTwEx4loCCuRycqRcbLb4BJzAuWRsWOdgroMrpJNBNRZV/LzqPnACybtFaJD9Cu3pZ/e7MJFu10TwfVm12O5MjrsEDmOd40DLLqbL0Q/be61AdLnSJZJrrOhy9u+SN7myOwb9ugmRtd0ImG+tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487199; c=relaxed/simple;
	bh=x5kzF8CwhIlxyVtEPJRc3M5vdDPI9gNtSMvV+yBIDbQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KOCoMaHt2+PDqp5OYc92VpjuPEZaBoakuJtB29vYPxJ85N5OZ9SZcSa4pMCsOouOk3IWa2YK3Nco+UOnZBXKm+unUI1hGdCwQ3U4d2dG/447zV0tJ8pNtSLnqwlT6VynCPSflTCh8Owk/F3dJdppZcjp2y+Rd3P+MxOK59zR2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oep97oZI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GXVLtwn3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oep97oZI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GXVLtwn3"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9E7A61140125
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Sep 2024 07:46:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487196; x=1726573596; bh=CRciCBOMuh
	fmW1HHjAE7k6gAAaP0DvaHPl5bv42370A=; b=Oep97oZIVNDB8IvINtgOYe1E/z
	gvKYpYvupCQAtb8R5ejUZ14/Et9aTSL6SC3AW1gbrwtmfbZmg2VQfXjOFFvy7q8n
	R9B/9gOXky0+4YELPHiDepgNToUCEkSd61ScFAjkKt0s41C8VO8sd+xVW8rc9RuD
	eQCFNRmS5ttt6Bp3otDB6banfENQ4DV70tKsnNJZ2e0MNSkLu76p/r0uERZ75kms
	oPOnx6VaiYk/8G91AL0CDq9/t9ELvgUHsXPURXs8LtOHmd01Dh+J58VJ2Y/1vDA2
	JVnxe50hq5Ys5E//QXSRnBE8fmUZYUSrIKJ2tYbCXrPIX+DWMuXMbQs71iHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487196; x=1726573596; bh=CRciCBOMuhfmW1HHjAE7k6gAAaP0
	DvaHPl5bv42370A=; b=GXVLtwn3y4ySBnMIwYmclhUcFH59bh4gV9Pl7oJ0JNnf
	XIYV1j8SSn3qX4h1KfBe31rbzQYfkHwTQ0uzAaNVNtd543++p1kP8j/8LlzVIXOt
	6ULSpdtk+zl0CGplx8DZQHWKrmuuYrKqxOqHU8rtK5wjgz4RXPt+Jz0TTV1GS4iE
	QUNjPQiSPzg2yvXetf9AoHU8mpV8rtuVvGAIImo1wIVdoOgS3HrCDWUqjycoJIGp
	pd8PaMfSMbpYJJN/vYqwVABIqeukZ6+ubRHlFIvhNIDE4ExbgSq1x+gaOKDDytfM
	FzkuvIpnrjTsWDcuUaknZBBb5cH/DSuiDbJvLjvIAw==
X-ME-Sender: <xms:nBroZrPzBO0f0pQsu9KGRUgOSfhrglGquxmTosZZTlt68K7lCLu0zA>
    <xme:nBroZl-xCImIi8hA-3rYEsWi4q8nhVQsB0KG1Qpg6VepF4r1OgaBJ38UNkEGsKmaz
    0_CBzGEzXmNMwtJdQ>
X-ME-Received: <xmr:nBroZqQ3AwUefI6I5iXYyrb4gec3FPPclJCZrD_SbU1ui7hx_kFq4QYhLxqMZMXyLhxmnRS985cs8ZOKpVz8eGo2UIzkPy3iqGCxmq-HasbcoTlO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nBroZvt0b84v3PKlFAjWcHUIkUoBf6khQAi3EvE4cnuR-3DQ2vmJYA>
    <xmx:nBroZjcVNsbvDFJT2K5whXo3cQbHdz8gEG2yhbSf3cuuXBRMedJ03g>
    <xmx:nBroZr0Osb1rOJKSKGogxDGC9yrYtonUmd2Qw5Ksjk6fFneI2EsLGQ>
    <xmx:nBroZv-lesZGId_33OU7Tuw4uJyoMv9_ve5lUqkwC-vvhpGkkw4l5w>
    <xmx:nBroZrEEpL60UwfzT-ZUs52cHFs9Lyn4UUm4RtLSiGdK7PoJMrQ9NEQE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a06f3ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:46:19 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 23/23] diffcore-break: fix leaking filespecs when merging
 broken pairs
Message-ID: <57a3a9e9f8d400d3a3f4de1fa39f41ba80e2eda6.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

When merging file pairs after they have been broken up we queue a new
file pair and discard the broken-up ones. The newly-queued file pair
reuses one filespec of the broken up pairs each, where the respective
other filespec gets discarded. But we only end up freeing the filespec's
data, not the filespec itself, and thus leak memory.

Fix these leaks by using `free_filespec()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 diffcore-break.c                  | 4 ++--
 t/t4008-diff-break-rewrite.sh     | 2 ++
 t/t4022-diff-rewrite.sh           | 1 +
 t/t4023-diff-rename-typechange.sh | 1 +
 t/t4031-diff-rewrite-binary.sh    | 1 +
 t/t7524-commit-summary.sh         | 2 ++
 6 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/diffcore-break.c b/diffcore-break.c
index 831b66b5c3e..02735f80c65 100644
--- a/diffcore-break.c
+++ b/diffcore-break.c
@@ -266,8 +266,8 @@ static void merge_broken(struct diff_filepair *p,
 	 * in the resulting tree.
 	 */
 	d->one->rename_used++;
-	diff_free_filespec_data(d->two);
-	diff_free_filespec_data(c->one);
+	free_filespec(d->two);
+	free_filespec(c->one);
 	free(d);
 	free(c);
 }
diff --git a/t/t4008-diff-break-rewrite.sh b/t/t4008-diff-break-rewrite.sh
index 562aaf3a2a2..b0ef0026e08 100755
--- a/t/t4008-diff-break-rewrite.sh
+++ b/t/t4008-diff-break-rewrite.sh
@@ -21,6 +21,8 @@ With -B, this should be detected as two complete rewrites.
 
 Further, with -B and -M together, these should turn into two renames.
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh ;# test-lib chdir's into trash
 
diff --git a/t/t4022-diff-rewrite.sh b/t/t4022-diff-rewrite.sh
index 6fed993ea0b..77bc36d5d8f 100755
--- a/t/t4022-diff-rewrite.sh
+++ b/t/t4022-diff-rewrite.sh
@@ -2,6 +2,7 @@
 
 test_description='rewrite diff'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff-data.sh
 
diff --git a/t/t4023-diff-rename-typechange.sh b/t/t4023-diff-rename-typechange.sh
index 787605ce3fd..e6f4fe441e1 100755
--- a/t/t4023-diff-rename-typechange.sh
+++ b/t/t4023-diff-rename-typechange.sh
@@ -2,6 +2,7 @@
 
 test_description='typechange rename detection'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index c4394a27b56..1b8cd3e4c97 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -2,6 +2,7 @@
 
 test_description='rewrite diff on binary file'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # We must be large enough to meet the MINIMUM_BREAK_SIZE
diff --git a/t/t7524-commit-summary.sh b/t/t7524-commit-summary.sh
index 47b2f1dc22a..a8fceb6a47c 100755
--- a/t/t7524-commit-summary.sh
+++ b/t/t7524-commit-summary.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='git commit summary'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

