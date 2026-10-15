Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47CA49DBB1
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 06:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792047448; cv=none; b=hYAWDMZVw3Xx44nErWfOrK/ikGWFEkkUVwo5l8M0XWR5vxnrGU5jNij3NntSoXibvudtFnHa4VLodH+EOfm0Vg3clF7PvTtSROsXpecS8fXEEDQiPBBQqfU90fCEpViwDU8bXcO8Z2G8PMkynN0vkn5SFBgPepdUxfHxW4oz5Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792047448; c=relaxed/simple;
	bh=TmGHEeJFZkQLdeabKL/0jXGepLHhZTXKeuv/WpuK4kQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CZHfQCaGjuk7vpMkj7t3ycxbtHZT/aPbNPQa7z467lE+lyNFrVcZg9x5h7/baTskEj4jm8T2f14obJrIpBLNlZFBd2pk430EJN/eEu/FxeIHr0PZFRuDcM4JH4vxJxjZf/plH0fCw3x2Dz1Nv/QMAzZ+OjHcHWM4aoaOx4ZvyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YE30dh7+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xFuOUtFv; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YE30dh7+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xFuOUtFv"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C2CD47A0177
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 02:57:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 02:57:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792047439;
	 x=1792133839; bh=KRy+vxmJGCSflWR5q7gMsPHazGw2DHkgFQ2E1AJUb4M=; b=
	YE30dh7+zrPrfmwblbB6qyJ3y9NRQQT/BAIj5F+ugjZy5/rArUdX+xbCKY8VDfTr
	UnXzk1gKlZz+moXhHVi+l7tNC9JwO7lFtvC453TAIuU6ODY+mCkmc8JqgvZqk8JI
	webAmSIJLgiFDrlg7qyeIV0hzv3Pk7YnrVVnQjiyrVFKsn4h9a6hEPrO65j+xI/G
	AHfqAUODX68yPeEvrC34XgfivK+ZUjrtKFwt59AMsgsEOiW1p+YEqlBKH8bcy3dh
	t7S08uQ6yV0Tbvi/dpA18pbJkygSdph27d3oqG+bep/TH0hCfOOFyY5NeVFgcosv
	MWs2G5QvAruMLSQ0wNHcxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792047439; x=
	1792133839; bh=KRy+vxmJGCSflWR5q7gMsPHazGw2DHkgFQ2E1AJUb4M=; b=x
	FuOUtFv7fauAtQQ6C03bTUMSqLrceo7yuqFn5k9ng7bxfW2LDTrrKMPYIWOxiU4H
	oULrDsCT+aRGQs7loloQ2xfQVkrW4+gd+UzH6pLb8HKqy3J+Az58G+gfUj93m1sx
	izZw+pdeA0spr9DbKNpPCzrYAeokEAl+r5nk8LT4GpPenUkPllShazQQoY3JPOA3
	5jZHHCoMfSmtwWCtrRBnSGRa/9yWaYuvkJ68Go9y7dfgMXmgP9Bybcofcu0nstuE
	pq4wtvDoMnmnwEc41dBuB/rGoTTy80X7vWvbUhNBoikuffOBmrtYcFkO61IBkhdU
	lic7xFSQwAXnDpk0NcWYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792047439; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:u0x0POTk6GKitoXdYIc4J8edb4D3HeNYhsIO9alTsMM7jJD
	sLubs1rm/pkiuqEIGasS8R5sNaUMCbUJbvZKBGjNTtSYIg4w7qnox6tLiCzqJtwc
	hd/op1Kx3PcHRDoLkOkwNYhqv3KX9RePdF0aHxhIOVoJMu5GTPTw6xTTbUHXzGrf
	Ghna3QyFUR7lDk+LVX0iZAqP1qqIBT3bNi5GjI4bKZlU/AYiKpVGZQo9Q+4N37so
	HikpI8qOAEA/sbkP5criuApLZvhzj/7qzqkGklhrs33oLZyAL0uQXdrsN63VSRbS
	LdVx5F2cBJum75VZA0yxkUjSu3rJPzJuay+wqFg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KMQ4DkMz6Md0kbZ+FiX8zOOodBduYAMkXNRGGwlwwkA=:TmGHEeJFZkQLdeabKL/0jXGepLHhZTXKeuv/WpuK4kQ=;
X-ME-Sender: <xms:T3nQas1hyE6EIsoUk7VMXgtq_9jnNY9xB4p0_O7Th-fw8E8biSZkEg>
    <xme:T3nQaqwTnXl3Hj3ovCvQS6JyGh9V9r_NmMHg0tBLWRe5Yf95_bZOaiR28zZssTs_H
    1pu_lhw_boJdBQEmBsNftBItKSURiFLdOIW5gB3gaPbBaq2--lP-ng>
X-ME-Received: <xmr:T3nQautC4Xo7bXNal_RJRvGdF3bp-MlNBCl5BBtdZ9_ZIs9cFe8HyknO60uc57hRFyWjYBg>
X-ME-Proxy-Cause: dmFkZTFvW2ZcyFYbrypEYX2sA8j8Et1PQWDCuZpGC82+NcQXOOhrkrqYBDkcrITZAg+d5G
    2gadSZPxsLaSnL74NtUAhHCUKZKz7vqKiFd6O3SohiT9mf4MBdOX0hDOVF6MccKkIZjDjq
    CVxTI0aIrp2wnZhSy3pmEB3vE17Mx2LYnV2C5Z/fynsx+UOdvcLXrPA+CZVowLlT/MQ/eV
    MO+seJCiUJktXGgyzu2b5OyVoiOASc54iBPMi31LvNbRlX0Q0hMcV1TCuagjFKUtzl0IIo
    BMVOpuXzUcnGCupbwvTtYX6sT2Lw9M0XytnZTMai9Gir4grJibF37LLrvokmO8plEqENIE
    cY5g+ZqhNBcbyb9k01P0zLDD9fGMKXCDI9nGk8/Cescee/8/SwhXmOsrDVk2sO7jGY+pT2
    dIlf4kL+pSt+KIvHJ2btuYYtmpGRf8N3PlqhhClEKuHg6BUYQgqJnc7N08WqMSxY1pOdV6
    6ojicDhfWDxJYLxvfEUnM5tEACGco+6yj6Ob4w35o7yqc760nCjVBAxJsrSYVwpUoYofyj
    YbsisjGEBnzutY4Kce2/ZEfxppnRoFEzrM/grBrgIUAus2j2qC0vxd5OKznP0gkcYGPjBT
    WJzWQAkoDQ6p01MCQX0w0lL8wKdVpdTxF1wbGxwVr0euQAzBVKSy6HaBjlXQ
X-ME-Proxy: <xmx:T3nQaswPmhJtO_O-esn81XW8kE90eidqRrsHZkn7bbqv8f9Ody0nqw>
    <xmx:T3nQahDRTzTedwDdUp9vB_wd_NXy3pOkyj1YApatcJXWZ5uJpMUSkA>
    <xmx:T3nQaqeCwCVIWWTy6lRILWIdMM7cbzIKmBx3yYNgl5fFzF45omPTXQ>
    <xmx:T3nQarkhVlpkhqarbdT5tRr781G4_IIUbjlPvfHeUaRkMJ_2TFCPBg>
    <xmx:T3nQanlrHhL8Q5FX2CgQI7kULMf6-l8s420NNT21bGKfzl_lqGhD4VT0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 02:57:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f07db11a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Oct 2026 06:57:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Oct 2026 08:57:10 +0200
Subject: [PATCH v4 1/8] t5004: fix test creating an archive with large
 objects under SHA256
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-pks-ci-housekeeping-v4-1-c2c88f1b198e@pks.im>
References: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
In-Reply-To: <20261015-pks-ci-housekeeping-v4-0-c2c88f1b198e@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Todd Zullinger <tmz@pobox.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

One of the tests in t5004 extracts a ZIP file that contains some objects
larger than 4GB and then double-checks whether we can read and archive
such an object. That test has a bunch of prerequities: it requires a 64
bit `long`, unzip with 64-bit support and it only runs when EXPENSIVE is
enabled. Consequently, not a lot of jobs even exercise this.

One of the jobs that does run it though is our Fedora-based job, as it
ticks all the necessary boxes. But that job was silently broken: while
the intent was to run on Fedora with breaking changes enabled, they are
in fact disabled due to a typo.

We're about to fix that typo in the next commit, but this will also
uncover that the above test case is broken when running in SHA-256
repositories. The extracted objects are SHA-1 objects, so extracting
them into a SHA-256 repository is not going to yield anything good. So
once we fix the Fedora-based job to enable breaking changes, which will
make tests use SHA-256 by default, the test will break.

Fix this issue by explicitly creating the repository with the SHA1
object format.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5004-archive-corner-cases.sh | 42 +++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 768b0ff85d..13edfbe5bc 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -187,25 +187,31 @@ test_expect_success EXPENSIVE,UNZIP,UNZIP_ZIP64_SUPPORT \
 
 test_expect_success EXPENSIVE,LONG_IS_64BIT,UNZIP,UNZIP_ZIP64_SUPPORT,ZIPINFO \
 	'zip archive with files bigger than 4GB' '
-	# Pack created with:
-	#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
-	mkdir -p .git/objects/pack &&
+	test_when_finished rm -rf big-file &&
+	git init --object-format=sha1 big-file &&
 	(
-		cd .git/objects/pack &&
-		"$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/big-pack.zip
-	) &&
-	blob=754a93d6fada4c6873360e6cb4b209132271ab0e &&
-	size=$(expr 4100 "*" 1024 "*" 1024) &&
-
-	# create a tree containing the file
-	tree=$(echo "100644 blob $blob	big-file" | git mktree) &&
-
-	# zip it, creating an archive with a file bigger than 4GB
-	git archive -o big.zip $tree &&
-
-	"$GIT_UNZIP" -t big.zip &&
-	"$ZIPINFO" big.zip >big.lst &&
-	test_grep $size big.lst
+		cd big-file &&
+
+		# Pack created with:
+		#   dd if=/dev/zero of=file bs=1M count=4100 && git hash-object -w file
+		mkdir -p .git/objects/pack &&
+		(
+			cd .git/objects/pack &&
+			"$GIT_UNZIP" "$TEST_DIRECTORY"/t5004/big-pack.zip
+		) &&
+		blob=754a93d6fada4c6873360e6cb4b209132271ab0e &&
+		size=$(expr 4100 "*" 1024 "*" 1024) &&
+
+		# create a tree containing the file
+		tree=$(echo "100644 blob $blob	big-file" | git mktree) &&
+
+		# zip it, creating an archive with a file bigger than 4GB
+		git archive -o big.zip $tree &&
+
+		"$GIT_UNZIP" -t big.zip &&
+		"$ZIPINFO" big.zip >big.lst &&
+		test_grep $size big.lst
+	)
 '
 
 build_tree() {

-- 
2.56.0.212.g129ede20d9.dirty

