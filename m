Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A4D1FBCA0
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915637; cv=none; b=hqlAepZHtqKfVscvjvR6EgAmqdAJqQP1cj4csoKYeMsLl+CDoTCADUzim6dZsbuYzbzJ2014prXpJWtCKE/WxmDhc2U24uV4ntjNFY1HNU2zxW+EPtP5KxjCC0J25QOtgbqW3920WmEf5lrecHrzmThIpxa8sD0eiCKdtBqr3uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915637; c=relaxed/simple;
	bh=P+v8Mc/qPApKyabATAa9egObyGr2AwtUVDH/PYFah68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NJiZqTrouTERURuPplm+bvxArAwveAekKPCvBOuNp6+91/iJg855OXpseZdOc5BDXOpcjlf+pRa2mQLZh93BJU2Mu/2BeMu9YP50ToIpaJaWlyBcwUqfnZT+PdVvRq0KqmnXnDxcOxHb3q3X8QDsvk/busGg2VCDu7ZGyEFLL2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tOdugH73; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EF/7Ikbo; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tOdugH73";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EF/7Ikbo"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B6A8B13802FB
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 09:47:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 03 Jan 2025 09:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735915634;
	 x=1736002034; bh=AnRIxFRbt8HbaCvzozuFuZ/dYSxnaW8wdxdEC0MBHzU=; b=
	tOdugH73zXPUFAlIke+MlJkqSA28yUdhNSLrBKkSPKMKcbzgndvYccA7Dt+/YzTt
	/notLBfjQ31BTL+09WtLFYXJFg+E7IvbAk1prSBSBVBUnwpJOdrTsCwu1V3gy0uP
	KvfVJ7e0HrTNhm0+W1vvkomcoG9XMcGlUx6B1rjCVHIOblrUf3KssB14gqOa4pi0
	bdYwfLbJ/NkT1gF58dUUw2pMCSYgNexdVK8ILv0lrjncT/balje5tamvGqsqyyYK
	YWhOPksybyCZ9frZ4EZLFqEGvdxBJyeobc+n8ubrefkVhvVFSJeQTkCwHB75s56+
	dx6aBtd7LK5QsmFxAUV5Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735915634; x=
	1736002034; bh=AnRIxFRbt8HbaCvzozuFuZ/dYSxnaW8wdxdEC0MBHzU=; b=E
	F/7IkbokAJp+xAUgJgamAdCsEK1A7IOReFzSw2pggE9icOH7cIpjlQu4rTrQx0m1
	DmxyMrQ2uyCJosri68aXDt4tTm7sUqD9Gss5fluSea0AA4nvt+7jQJszaT0cFGWo
	WZVFYOFROq2buNlQAVJdcwdCCO1MMrRaQ0bwjv1je0zRZ5L8snxpwCYjYW+CvWCC
	OYkJF/KxIonbxQ8ER33cC4PPpnBwHp2cy+3pyfnEtNikpaFXZyaE3xhuZtD+GfSv
	24BvrCVlou2jryK7VUufVfRX+u9oEQbB2AHpHDaXg8CxSJ1WJzjs/nyIXOrkL+jI
	hrPqPd9Bv/1uitxEXH81A==
X-ME-Sender: <xms:cvh3Z4R2I5v78U4dXP6cnqRW10E4nC7G0VbSXQ_MQC4SRTBHmfJdfg>
    <xme:cvh3Z1wqOuz5OP_UUUrGu926IORR1TtOw3gu0CItaG6EbADeL5Vta4LXbEfVR1Tkn
    ZUT8D9GY-_2G77-rg>
X-ME-Received: <xmr:cvh3Z10JA6MlqzCQka1UUtuLriGAb8kI1w0b5VAu4SvH3MJjqZt27GAR0xGY_M_n9BUXGYB9nbI0JsF0b3xPr6Pl_NgLj84SOk8Ikk2mEayBHmk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:cvh3Z8D2U68wWUja1rMn54paEIHcR2PDQUJr4s9KG_LAAG4SnhkY4g>
    <xmx:cvh3ZxhUtEsjmKK-jmj2nvm6v3sDWlA2Gr11YsBgWoDvvKVK3TSlew>
    <xmx:cvh3Z4r6WxZ_WaCv2EW74a_ZKpmcbLYuJL3mbhozWss2HwOOhQYk_w>
    <xmx:cvh3Z0g6Fz6gInxYlbyEGuCEOZk8moGM-i0aVw1sYgq-1eK7xAFszQ>
    <xmx:cvh3ZxYaK8XmuKUEho_eabl4q_Am5D5cPCKZS4EIKVIhpSmi4ozsyDkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Jan 2025 09:47:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2a0acf53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 3 Jan 2025 14:47:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 15:46:45 +0100
Subject: [PATCH 08/10] ci: stop special-casing for Ubuntu 16.04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-ci-fixes-v1-8-a9bb95dff833@pks.im>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
In-Reply-To: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

With c85bcb5de1 (gitlab-ci: switch from Ubuntu 16.04 to 20.04,
2024-10-31) we have adapted the last CI job to stop using Ubuntu 16.04
in favor of Ubuntu 20.04. Remove the special-casing we still have in our
CI scripts.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 2293849ada3b45873f80e4392ab93c65657d0f13..77a4aabdb8fb416c1733f02d02145b6bc0849998 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -347,14 +347,7 @@ ubuntu-*)
 	fi
 	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
-	case "$distro" in
-	ubuntu-16.04)
-		# Apache is too old for HTTP/2.
-		;;
-	*)
-		export GIT_TEST_HTTPD=true
-		;;
-	esac
+	export GIT_TEST_HTTPD=true
 
 	# The Linux build installs the defined dependency versions below.
 	# The OS X build installs much more recent versions, whichever

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

