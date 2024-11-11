Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F58F18D656
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321540; cv=none; b=QIEejb0p8KDbRG6m4W17ygpN40Ls8YYv5F4Y9ZbaBlHYSKbGVvz8hTux4+aTwcdPRxfjIkDmMHmgIq49e0GScmeNkyt2u8tMuo23gup9wAtzKxaC1AT1XNZl6B6UQaAmrq+guoo7shGqs7zbxEqfLhTjN29oGlSxfa81grexBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321540; c=relaxed/simple;
	bh=XKmLXrKDYBWrA4AtfpJtHgaZtzOnW9vUOeDrcubiE6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4cEp9uMU8Q4yOS/DhgvhwoJdWyxFSHNN1KekSsGo4tA38e5pJYolbPGOJrMbPIfHLoV4emUmLQ+3vl5l7+ssjUmfSu6tyBoXUUReCxa6gWrhwCrARw82VyW8G2JblMW6EGgVDh1Zh8ErMkLicmEYeDGKBL2j5APeDV9IrGFsq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M7tXykir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AgNELi9g; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M7tXykir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AgNELi9g"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E57651140114;
	Mon, 11 Nov 2024 05:38:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 11 Nov 2024 05:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321537;
	 x=1731407937; bh=SSBPGz7Gfk5phwq5LfXS74d4MpTmyMcofPL4voC/fIs=; b=
	M7tXykirqwovpviZGx/+mAmrGQz8dy2FwMbbAxZ+xnVGEnO+q8CzsC/nAEkYmvHk
	VPaE3jQ54K/Np57O1Q7v1yXX3FBFhHQ8sEWR8vrBwAwbxMqT3iaD00HA6cs6Y5e8
	569o2vZaiiuOefKmmNcaNvg/6sj96hcfoNvwJ87Fsd3eT8CoCgEMt0KBI16i30BI
	EW+B3tichXLQ5ANlGi4aogVKhvtBVbjR7lWQzggwq0RIDyKxLZaoLpDEHriBjgu+
	2vAkLvY+C5j7JJlbB9MXyzhNYX4kv9jqeEIqThSO+GCyKD9YBm0hNNcCwEF9tUgt
	ydLYqLSDMESkN/ZmSUM7Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321537; x=
	1731407937; bh=SSBPGz7Gfk5phwq5LfXS74d4MpTmyMcofPL4voC/fIs=; b=A
	gNELi9gmz38ohspSAj4ovoNCMM18YnV9xYbEUjxIOZa245U4vSYzF1LDVtuPP4ag
	KN2wt2hJSG07qmlwl3HDVgd99DZQVxCKGxPayAxWoqc+lgCLeHUIwZvT479XHmyL
	4YbfOZDdmLeJ9Vi0pTdSDGvcQ6+QbnShzRJGLJxm1lhuJfst3QQlVPinStihAtXS
	cV7znOUu5pMXoovvMyX2GW+QV++dhhQV2kESIjqYeICvTk/uAmeevnjcqLBIyIrg
	7HR5pN3Fyw3uwBU49Mu61AhaB6ovdngHOUr2smQ79ffQu5q1vvHzO+pzAtXYR3kf
	lnjzDZQ+kWS/wFmfn7Xfg==
X-ME-Sender: <xms:wd4xZzdOn2r6SLnxr_f6qnXkaE9UTZN-rQwnJPrbf8T-ENqY8HrtRw>
    <xme:wd4xZ5PTw5pSJ--mRh_xWk4yQzv7n-4RjkQ3zSxsGZ_3WLtORpHG8j1dP0QkPm6p8
    I1NBhSxn7Gm9TrQrQ>
X-ME-Received: <xmr:wd4xZ8h_W1KhJbhmE5caFFaNbufPecDnm_zm-UpekzgcPqY9DjJrNwlO8Dm-5LPR6n4SRAL-AQIu7nElS-OhSOZdrFEdV4gPUUJ2AXN9-F026aoh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wd4xZ0-EBsedCFWN17Yi2Ec7p-DEpAsnd2xkeBAmbSuMFEuM7WT1YQ>
    <xmx:wd4xZ_sTvU_tYy4May25h2xyrs1Ex44cZ3H7d4qVZvVrsN6NSFrYUw>
    <xmx:wd4xZzGgv2kjWl1CvBi72JpsHw1mubyZmVkSIVpX5DeMs94pA0936Q>
    <xmx:wd4xZ2PMTM7lPZ8zqISF7llOuv2smwuW7-zi-jSJ7P_zyROmTh-jWw>
    <xmx:wd4xZ46F2jt9Aluhml2aBValuH0EGhFomE4J9wph4q2tzHipau4xTAFR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 835ee436 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:41 +0100
Subject: [PATCH v2 12/27] split-index: fix memory leak in
 `move_cache_to_base_index()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-12-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

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
index 120c8190b187bc8c6c73630f06f5dd4dc994df30..cfbc773e6cd3b11ea5f47ab92310a56c30f6971c 100644
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
index ac4a5b2734c0784c2cb8878112a5ead9593860de..2625ac44889a5c9219e9575a9bbc5265d3c419d5 100755
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

