Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2C836681F
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771922761; cv=none; b=c7rio0MNdu5YsDWdP//PIW6rt2YpUHzUZEV1KFbHdBNdd1F9ibwtDpe1pPwWMRE08TxOHEYceWMwH6FKZCvPncT4WfOPQDqYW0Ecb3Ye0HnLQuG54OxJQ5P0WoOscdbfooELW5Elgqf22TfsBC0YPZ9Malkx/jd8Rp18/ShqllY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771922761; c=relaxed/simple;
	bh=mytFHovAW2sHY4lDHEJeKHdrI/eJYpUTHN+8MovzgYg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JVXdFleDZg5Mw85IJNh6FK0ZuqzwFet+ihbwV8SzZ86Pw18NPsE2l+I2fXLj4OTXV15GGRATr7vqX3bTc3iYG3QapLFd8Bv2I2KtMeZl0BkYCiASbmYEdsggMX0zPZJgWgzDE8ergXzA6PKcuTArvcHwg/HR7pjI63kYlDP36Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AReilKp0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vKZvRSDp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AReilKp0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vKZvRSDp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1E6671400064;
	Tue, 24 Feb 2026 03:45:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 24 Feb 2026 03:45:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771922759;
	 x=1772009159; bh=FF/Ena8owYpq5viVtx87FKYKXwCDYHEs9WGMciLBync=; b=
	AReilKp0aJUXfJbZKDN5L/A2ZIvGb7ouiECTXiQMR0IR7+r0vBeRoOTZjOK7WkGe
	uDs+HfyGNcd/m17d5bsh9+ZE2WxmwOcwQik1mfr6evxAwsB9BY0zS543jlcD3Gbn
	7jzfERnE80BA2femVQUTOWc4zUqJDrFg2DxaMO3lKc9G+amGcOnNqilqeE+Otwp6
	QJ94de+7XJGfbOrBQIMVXjj2HU2yZIbhQT84PaAJaVmGqvGI+COz1VZ39ZReA+zf
	8zOXyPtsgqyG8yZ+020JLaDv3EffBoRQ4p8pKmVxR4Nn9GEMllEE+q3+MR4ffwvG
	z+gnY9dOA0uDbVGd8W4+Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771922759; x=
	1772009159; bh=FF/Ena8owYpq5viVtx87FKYKXwCDYHEs9WGMciLBync=; b=v
	KZvRSDpTmHYvbk2Ak3fvy21rtRPtbyHOc5VFQJLIvAsXkqoPmonVRrHqbaMHsrXz
	l3m20ToGWSnnTEfvWcrJhPVjm3KprbAdMkP7oyTwaK77PLCUUvJv0mlXz08W8T3Q
	bpg44jwMdkgcTgTSYiKeqx845q3N25ilFK6HwqHpCrQJfmnPg9eB6liFnRdnfFuD
	SEbFoNsYGOnxVNt2HvjGCuJmXb4TbMZqDS30Vzdfpiq3ISBBwAAWAkBIGOC9FyF/
	J48mfjbOS8emxClZmN4r8tg1Yp7Ts5rxrpvgg/Q1NjheoEOqRvddUTlWdKVqcw8q
	y0asMlSHK6qwCo3g29RAw==
X-ME-Sender: <xms:R2WdabO_y6rdaLyj5Pv2k9OalmhhS7dlSaSasX1BPBJoTx4zrMZpSA>
    <xme:R2Wdac8xLh2YWBp6K4nOFU5LJx0fI6YUIotL9X5mSAX5HcB8cc3Z0sLBJTFq9VY9r
    QIy6DzlqY7nueX_F3RHF_oBxdr6zO-UssSbZJYoFwy2BH7VJszy9w>
X-ME-Received: <xmr:R2WdafQ8Kcj-XgWRigW_HQZ4663QE7c9sWNqP7DkrY9__dZmQKR3oOGuOvyc35Qrvf6tzsCUcdFjNwfObOQK_NOWPHB4TMTVFRejFLL_U-5Svg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:R2Wdaek5YuhA7UlI8ZQDt7jGdSpRyYXnhCBrQzHpxQOpQtdz15qQmg>
    <xmx:R2WdafQz509Lzt23NCTeWlEwv3kt29ofByKqj-nyyoOYHF3cBGxAfQ>
    <xmx:R2WdacOkpIm76wJRk2QMU8W5-tqWAujO4_2BH3-pj7SZkEK4ZBoQVA>
    <xmx:R2WdaYVs0Azd-rdWUxyRwjJqFyQbCIp8e7FthVtjS_vY-a5yyLBK9g>
    <xmx:R2WdaVMKjQpz0LPEVAPyIgF3TQpTc_PJVd0R1lEjzxf94Y6LIxzhWd1N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 03:45:58 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 146c6bd2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 08:45:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 24 Feb 2026 09:45:46 +0100
Subject: [PATCH v2 2/8] t: disable maintenance where we verify object
 database structure
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-2-8657338c6fa1@pks.im>
References: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
In-Reply-To: <20260224-b4-pks-maintenance-default-geometric-strategy-v2-0-8657338c6fa1@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

We have a couple of tests that explicitly verify the structure of the
object database. Naturally, this structure is dependent on whether or
not we run repository maintenance: if it decides to optimize the object
database the expected structure is likely to not materialize.

Explicitly disable auto-maintenance in such tests so that we are not
dependent on decisions made by our maintenance.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0081-find-pack.sh                    | 1 +
 t/t5316-pack-delta-depth.sh             | 1 +
 t/t5319-multi-pack-index.sh             | 1 +
 t/t5326-multi-pack-bitmaps.sh           | 3 ++-
 t/t5327-multi-pack-bitmaps-rev.sh       | 3 ++-
 t/t5331-pack-objects-stdin.sh           | 2 ++
 t/t5332-multi-pack-reuse.sh             | 1 +
 t/t5334-incremental-multi-pack-index.sh | 1 +
 t/t5500-fetch-pack.sh                   | 3 ++-
 t/t5616-partial-clone.sh                | 1 +
 t/t7700-repack.sh                       | 3 +++
 11 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/t/t0081-find-pack.sh b/t/t0081-find-pack.sh
index 5a628bf735..26f017422d 100755
--- a/t/t0081-find-pack.sh
+++ b/t/t0081-find-pack.sh
@@ -68,6 +68,7 @@ test_expect_success 'add more packfiles' '
 '
 
 test_expect_success 'add more commits (as loose objects)' '
+	test_config maintenance.auto false &&
 	test_commit six &&
 	test_commit seven &&
 
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 03dfb7a61e..8a067a45cb 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -48,6 +48,7 @@ test_description='pack-objects breaks long cross-pack delta chains'
 # repeatedly-modified file to generate the delta chain).
 
 test_expect_success 'create series of packs' '
+	test_config maintenance.auto false &&
 	test-tool genrandom foo 4096 >content &&
 	prev= &&
 	for i in $(test_seq 1 10)
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index faae98c7e7..7672d599d4 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1315,6 +1315,7 @@ test_expect_success 'bitmapped packs are stored via the BTMP chunk' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 
 		for i in 1 2 3 4 5
 		do
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 892aeb09e4..62bd973d92 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -93,7 +93,8 @@ test_midx_bitmap_cases () {
 	test_expect_success 'setup test_repository' '
 		rm -rf * .git &&
 		git init &&
-		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+		git config maintenance.auto false
 	'
 
 	midx_bitmap_core
diff --git a/t/t5327-multi-pack-bitmaps-rev.sh b/t/t5327-multi-pack-bitmaps-rev.sh
index 9cac03a94b..cfa12de2a8 100755
--- a/t/t5327-multi-pack-bitmaps-rev.sh
+++ b/t/t5327-multi-pack-bitmaps-rev.sh
@@ -30,7 +30,8 @@ test_midx_bitmap_rev () {
 	test_expect_success 'setup bitmap config' '
 		rm -rf * .git &&
 		git init &&
-		git config pack.writeBitmapLookupTable '"$writeLookupTable"'
+		git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
+		git config maintenance.auto false
 	'
 
 	midx_bitmap_core rev
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index cd949025b9..b03f6be164 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -14,6 +14,7 @@ packed_objects () {
 
 test_expect_success 'setup for --stdin-packs tests' '
 	git init stdin-packs &&
+	git -C stdin-packs config set maintenance.auto false &&
 	(
 		cd stdin-packs &&
 
@@ -255,6 +256,7 @@ test_expect_success '--stdin-packs=follow walks into unknown packs' '
 	git init repo &&
 	(
 		cd repo &&
+		git config set maintenance.auto false &&
 
 		for c in A B C D
 		do
diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 395d09444c..881ce668e1 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -59,6 +59,7 @@ test_pack_objects_reused () {
 
 test_expect_success 'preferred pack is reused for single-pack reuse' '
 	test_config pack.allowPackReuse single &&
+	git config set maintenance.auto false &&
 
 	for i in A B
 	do
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index d30d7253d6..99c7d44d8e 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -15,6 +15,7 @@ midx_chain=$midxdir/multi-pack-index-chain
 
 test_expect_success 'convert non-incremental MIDX to incremental' '
 	test_commit base &&
+	git config set maintenance.auto false &&
 	git repack -ad &&
 	git multi-pack-index write &&
 
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 4bb56c167a..0c88d04d0a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -154,7 +154,8 @@ test_expect_success 'clone shallow depth 1 with fsck' '
 '
 
 test_expect_success 'clone shallow' '
-	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow
+	git clone --no-single-branch --depth 2 "file://$(pwd)/." shallow &&
+	git -C shallow config set maintenance.auto false
 '
 
 test_expect_success 'clone shallow depth count' '
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index d62760eb92..1c2805acca 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -585,6 +585,7 @@ test_expect_success 'verify fetch downloads only one pack when updating refs' '
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" pack-test &&
 	ls pack-test/.git/objects/pack/*pack >pack-list &&
 	test_line_count = 2 pack-list &&
+	test_config -C pack-test maintenance.auto false &&
 	for i in A B C
 	do
 		test_commit -C src $i &&
diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index 73b78bdd88..acc2589f21 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -217,6 +217,7 @@ test_expect_success 'repack --keep-pack' '
 		cd keep-pack &&
 		# avoid producing different packs due to delta/base choices
 		git config pack.window 0 &&
+		git config maintenance.auto false &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
 		P3=$(commit_and_pack 3) &&
@@ -260,6 +261,7 @@ test_expect_success 'repacking fails when missing .pack actually means missing o
 
 		# Avoid producing different packs due to delta/base choices
 		git config pack.window 0 &&
+		git config maintenance.auto false &&
 		P1=$(commit_and_pack 1) &&
 		P2=$(commit_and_pack 2) &&
 		P3=$(commit_and_pack 3) &&
@@ -534,6 +536,7 @@ test_expect_success 'setup for --write-midx tests' '
 	(
 		cd midx &&
 		git config core.multiPackIndex true &&
+		git config maintenance.auto false &&
 
 		test_commit base
 	)

-- 
2.53.0.536.g309c995771.dirty

