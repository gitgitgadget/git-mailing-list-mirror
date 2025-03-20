Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CB225412
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463353; cv=none; b=qZtPnHRmfHWnjeh2B2YY11nhGnh7hfcKAuo/d36EIyL28go49bUyUiaZmWfyL6/Ni5TfHB9aFNyRoIUfE+tP2ulcR6vppzv9pUwdpdUUnpDUwxRZmknaLx/4p0tw2+H3aZUfHxXqmCAI6820aEKIlp+MmKwH8Yqhkq0kgbgSXdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463353; c=relaxed/simple;
	bh=VOGHVEB5DBeBsc1IOz0MKfPvuvyDiSI9QbAo+vfau2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uO0rKg7GxP3NPj5Q8/JfrHqDJPJjmCwyO26AA6pYNBirFO0C9l26lz7atcxhB8LUVOr+AUcyhR5bJeURlM9UWRf3KcgnAOXb0CjjDXH+Dwu+qjI3U7QtCTHQw+LflmulaPyHwFaC9vg47o/8YJnCd0AaV02JSmjo4/FBN/whkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dKeBUTxZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lr9AmMs3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dKeBUTxZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lr9AmMs3"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id E657A11401B1;
	Thu, 20 Mar 2025 05:35:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 20 Mar 2025 05:35:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463350;
	 x=1742549750; bh=0JV8nY16uI93FpC8oc8O/Ba/p4JfeYQlUD8rsognpdk=; b=
	dKeBUTxZWEdWGD+4fbjzVgJS87Q1O3BayyqVG1gDVcRzLDoNXG6rQMiVH0umpriR
	aw1zZdJPq9Op68Qd2zylHFLcYoKHtBvNzyZMzcgmZHlzybvK8mxKkA0X+tnkCIc3
	Woe+PxmJqz0TJqNcu1GGppBcU7UXy9HpEfYo5mV9zfsqJhm10G9Lj1Ibx9cVZGvR
	3DR9j5e0mnF2Z0NDzQYFiZisS4zQUaTgSSnKRBTos/FEWPf4uxPNrTcAviw/Wf3y
	8xBY7VHLmV5crLFFuC84/vusYdGVRcPD8XVuH6fsIDyWyVYsm2s/JGsGyBbLpxI4
	RhvaKklvOow8AcH21UuKdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463350; x=
	1742549750; bh=0JV8nY16uI93FpC8oc8O/Ba/p4JfeYQlUD8rsognpdk=; b=L
	r9AmMs322BLTWBpXb9aU3SQ7lJen1sVLYI6nYQ8ofTiYWi1c13i4jlxiQyAJdbXo
	nd1s5CB5nhtXqKixsgwVbxlthpPZnC+tb3PRNAskrqUKzU9Q2WANiTtrw6LSXcL5
	yuKvGN/ujgJdYshobhhTccoadz4p9HQD2LKlbC2ad3OEDmGxeL6XtdoqG1fC717q
	wu+FQvvYy5+ADihyT85YcNwtfij7af0dCpeZ825tLMJ4nWChpoEgBr+wtXRD5nIC
	MXbzm1P/6sjwiQNcrIzzEj6ecp9joGcTG8HryQdYQNtDKnIaEfGSxe2xgnOhTjz1
	B58fdgu8DA/UzbmgjP1kA==
X-ME-Sender: <xms:duHbZwTFGRyHsoeIRySEEh60wdkQF7wB5nMd7IOkHCEXFcdI198fEw>
    <xme:duHbZ9yWoH2HBze736G982y0I5Hu-4k1ht1Es1QmDpI-z7Joyu7znwNEBZ8F6451w
    DINgd6KVjximaoHNQ>
X-ME-Received: <xmr:duHbZ907GpdE2bFcSDPpOa-tDB38DojMX9vTqFiYXjjMxMIzisPE9Vb-_U-huvrGV9QtNqcqVy4i1USzCsnVgoO1UJOklQd2cJKGTwrAsRHtAOM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:duHbZ0B3kwKYg2hgUq8mTYzvPjwHwPHq5BcYvbFJCeLwNUVfWiM_DA>
    <xmx:duHbZ5gKMUH05V6D0eabamlnPJAihcSV24jmr4ZFGIftAMH0Ypndtg>
    <xmx:duHbZwqvbOZayTTqoermJ_-LPgl8_VjB-ScqP4EPfLZUTj4v20O9pw>
    <xmx:duHbZ8gUXz39rl-kXwpAzJ--rl7MWKm7hPbpQuZFqm7JshOACWAWUw>
    <xmx:duHbZ8vSqYlO8qD2Zr3_Z9V-EWwZTP5vmBIyJV9BCCFUxyqX1hQ3weXW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dfd2fad1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:46 +0100
Subject: [PATCH 19/20] t5316: refactor `max_chain()` to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-19-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

The `max_chain()` helper function is used to extract the maximum delta
chain of a packfile as printed by git-index-pack(1). The script uses
Perl to extract that data, but it can be trivially refactored to use
awk(1) instead.

Refactor the helper accordingly so that we can drop a couple of
PERL_TEST_HELPERS prerequisites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5316-pack-delta-depth.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index cd947b5a5ef..defaa06d650 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -76,18 +76,18 @@ test_expect_success 'create series of packs' '
 
 max_chain() {
 	git index-pack --verify-stat-only "$1" >output &&
-	perl -lne '
-	  BEGIN { $len = 0 }
-	  /chain length = (\d+)/ and $len = $1;
-	  END { print $len }
-	' output
+	awk '
+		BEGIN { len=0 }
+		/chain length = [0-9]+:/{ len=$4 }
+		END { print len }
+	' <output | tr -d ':'
 }
 
 # Note that this whole setup is pretty reliant on the current
 # packing heuristics. We double-check that our test case
 # actually produces a long chain. If it doesn't, it should be
 # adjusted (or scrapped if the heuristics have become too unreliable)
-test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
+test_expect_success 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
 	# not computing a new long chain.
 	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
@@ -96,21 +96,21 @@ test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS '--depth limits depth' '
+test_expect_success '--depth limits depth' '
 	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS '--depth=0 disables deltas' '
+test_expect_success '--depth=0 disables deltas' '
 	pack=$(git pack-objects --all --depth=0 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'negative depth disables deltas' '
+test_expect_success 'negative depth disables deltas' '
 	pack=$(git pack-objects --all --depth=-1 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&

-- 
2.49.0.472.ge94155a9ec.dirty

