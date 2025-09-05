Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3FF23B62B
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 06:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053094; cv=none; b=t6NOiywmowTeF74lhNCFjBmMO706/EdMf4vbzEnSd9yUqRx3xORVNJEshWvVNy5iL4kqfVFgL5IYneQl0/Dxh/KRAgVvGxUfdihJclOMfAsWyszvXiOi+TAoX0DjewUT+a6BFrgjiitCg/WAOQGQdpaureGjXS7Lz/bZ220LmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053094; c=relaxed/simple;
	bh=oDlbYejFNUlynZ10DURGDgLEbj8Efy+LowvMTMODihE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B26eaeHeipbhGZxC4L2deqaJjtmFAzt2TNmP8saFqt7H1NayNYCbjubIM1CRQL+nysYsajoILO3A3tROlLK1M9Y7V4Po7ih3D6ffe/hD1dgpFnSTnXB+R4dodwdIxizK7o51C1eVswXUTp3ff+bSVx/ky+ETXAaKyCyHtcCf0Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ki22o7rn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oYrowTnC; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ki22o7rn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oYrowTnC"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 669681D0042C;
	Fri,  5 Sep 2025 02:18:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 05 Sep 2025 02:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757053091;
	 x=1757139491; bh=TZXuzs1NC/X/iyyDTkfXDz4JG3d4QdTp9nVrXoBDOP0=; b=
	Ki22o7rnFc/EOhTCgX43RVYz+Ghcp3p6vTtQH7bPGtZyONne6fQyPN60KktdkeBB
	FXizxgrYaoabJ1HtEQ8YrlfG/wUhLiNzOKulSIh3oF5YNw7XG0ydQ8jzl/T6bDBj
	GRlPSRILS3NWY9sbVop0NSVCiFMrXs43TvWUmY8UjWy2TjbkBwkhNMeP3JacjoLB
	NQPwbhti4eZXBGVrdvo34I6AEJ8trgNkQXouLbAGv65hXSY2DLWuLvchPvmTrH6U
	R/k8WSPSUlNSJqkwccGifZfQLMWBDl1+B+PjdiMw9wtlyDtxpUgOZ+jRqKcZ/pJV
	kFnmF4SqejfEuZASdaRLuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757053091; x=
	1757139491; bh=TZXuzs1NC/X/iyyDTkfXDz4JG3d4QdTp9nVrXoBDOP0=; b=o
	YrowTnC4sjDZtQJnChb9A7qxLCTjGLSCbFQOjPAtNO6aelWc6TpvZOPzhLqF8Ipw
	qtFd/lGiXj1jGyohO3jZx5PX2M7G9A62m7LsDkHiPI8X+7ZXg6TjdMJoSlWJ80m2
	SgVIDJe1Vp8ZHfAtP3aZ28FAuv60AXnscFBfvyDLse9qxceu3yktGuMCi954WbZx
	/j6+WQBuvFBB7ufEgf79h4Nx0uGJkTmrjIWVEc26XzbjsWzy/A+rLr/XpXSkMFXD
	4jC88h4CCfrX5+LDw3GSpEzrJS71bg9pRvKEVCeHvPEs1vnJ3TDLQPONsRREtQY4
	esfV0gYECRCKv+R4LKsvQ==
X-ME-Sender: <xms:o4C6aMU9U20OiwteWeOorVlSUND7Mcl_7-PsjhSmjHAFqsgAGHiaow>
    <xme:o4C6aLJYdosXGDjR2fXPUzzHCwolpiCJEerXHZ_hatazrnzwRkZD3CNWKbpIe2jcG
    nrnWEeYDKGqA-torA>
X-ME-Received: <xmr:o4C6aM-9S67aPZKQAtkf8S1upHVxjpAltxEzaQf8jHNZlLXcqHNIPwnPZKWMH6jWvRGU6-MVn0lob6xg1Ibf2uOFXMWxcnipVHhKA1YqAPOv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:o4C6aOIA3WwNvWgkLo-1TzgfO7768NIVyViLXCSFnl5Dl3A3_6y5wg>
    <xmx:o4C6aBm60gPEehKYEDgx6IZmd_4vLb3C0sSH1YrzcNkeZ21_Yh_EtQ>
    <xmx:o4C6aCPG4rg1fMZ5tENIj3WIUW0IaI4FMClLIZXin6hNdWe2__lYHQ>
    <xmx:o4C6aH21ApT5on1F9IR6FfdfOtnLJtuNgt8VVK9CA5Hk48Wqkkyx5Q>
    <xmx:o4C6aFmkVfDkDcFnUoXwPKr7O3K9Ry_OfUylVsevuaMl1QInaluMDOvo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 02:18:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e83f1011 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 06:18:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 05 Sep 2025 08:18:01 +0200
Subject: [PATCH v2 1/2] t5530: modernize tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-1-d2e67f3cb94c@pks.im>
References: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
In-Reply-To: <20250905-b4-pks-upload-pack-repeated-non-commit-acks-v2-0-d2e67f3cb94c@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Refactor tests to follow modern best practices:

  - Merge together tests that set up and verify a single use case.

  - Drop empty newlines at the beginning and end of test bodies.

  - Don't change directories in the main test body.

  - Remove an unused `D` variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5530-upload-pack-error.sh | 33 +++++----------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/t/t5530-upload-pack-error.sh b/t/t5530-upload-pack-error.sh
index 558eedf25a4..8e505786f1b 100755
--- a/t/t5530-upload-pack-error.sh
+++ b/t/t5530-upload-pack-error.sh
@@ -4,8 +4,6 @@ test_description='errors in upload-pack'
 
 . ./test-lib.sh
 
-D=$(pwd)
-
 corrupt_repo () {
 	object_sha1=$(git rev-parse "$1") &&
 	ob=$(expr "$object_sha1" : "\(..\)") &&
@@ -21,11 +19,7 @@ test_expect_success 'setup and corrupt repository' '
 	test_tick &&
 	echo changed >file &&
 	git commit -a -m changed &&
-	corrupt_repo HEAD:file
-
-'
-
-test_expect_success 'fsck fails' '
+	corrupt_repo HEAD:file &&
 	test_must_fail git fsck
 '
 
@@ -40,17 +34,12 @@ test_expect_success 'upload-pack fails due to error in pack-objects packing' '
 '
 
 test_expect_success 'corrupt repo differently' '
-
 	git hash-object -w file &&
-	corrupt_repo HEAD^^{tree}
-
-'
-
-test_expect_success 'fsck fails' '
+	corrupt_repo HEAD^^{tree} &&
 	test_must_fail git fsck
 '
-test_expect_success 'upload-pack fails due to error in rev-list' '
 
+test_expect_success 'upload-pack fails due to error in rev-list' '
 	printf "%04xwant %s\n%04xshallow %s00000009done\n0000" \
 		$(($hexsz + 10)) $(git rev-parse HEAD) \
 		$(($hexsz + 12)) $(git rev-parse HEAD^) >input &&
@@ -59,7 +48,6 @@ test_expect_success 'upload-pack fails due to error in rev-list' '
 '
 
 test_expect_success 'upload-pack fails due to bad want (no object)' '
-
 	printf "%04xwant %s multi_ack_detailed\n00000009done\n0000" \
 		$(($hexsz + 29)) $(test_oid deadbeef) >input &&
 	test_must_fail git upload-pack . <input >output 2>output.err &&
@@ -69,7 +57,6 @@ test_expect_success 'upload-pack fails due to bad want (no object)' '
 '
 
 test_expect_success 'upload-pack fails due to bad want (not tip)' '
-
 	oid=$(echo an object we have | git hash-object -w --stdin) &&
 	printf "%04xwant %s multi_ack_detailed\n00000009done\n0000" \
 		$(($hexsz + 29)) "$oid" >input &&
@@ -80,7 +67,6 @@ test_expect_success 'upload-pack fails due to bad want (not tip)' '
 '
 
 test_expect_success 'upload-pack fails due to error in pack-objects enumeration' '
-
 	printf "%04xwant %s\n00000009done\n0000" \
 		$((hexsz + 10)) $(git rev-parse HEAD) >input &&
 	test_must_fail git upload-pack . <input >/dev/null 2>output.err &&
@@ -105,18 +91,9 @@ test_expect_success 'upload-pack tolerates EOF just after stateless client wants
 	test_cmp expect actual
 '
 
-test_expect_success 'create empty repository' '
-
-	mkdir foo &&
-	cd foo &&
-	git init
-
-'
-
 test_expect_success 'fetch fails' '
-
-	test_must_fail git fetch .. main
-
+	git init foo &&
+	test_must_fail git -C foo fetch .. main
 '
 
 test_done

-- 
2.51.0.417.g1ba7204a04.dirty

