Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B02A2D481C
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 04:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875271; cv=none; b=mBIgTQrhE3u2R5Zdg5FWEgmyvbntyNzwvyy+rlfeLLAlhjDcaSuTcRQf0E7aOr2+tewUF4TtnXfc8ybE/6fgiq8Tp2senX5k/MWjTukOn547BxYp11uwKmBTiQ06IHsIde2wXqxlCsaatTGNPOkTvY7ciFTvGFIOeE63xcma80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875271; c=relaxed/simple;
	bh=5/ESUggDVlPlKiGiHGDsqdgifc3NJpaiTvPmw/PGe+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L87uuFD2fhZE/zRyGV5aJ2mRp6V7vbyVMW2u0Db0Juk/W2odGFqS1rX49VDMogW0h7ZsvkTGVXv+qDVqIivrdEaDt5XnOx1+gcQlsCqm1lRGeI8BErAG01pb7kUNQE8J9Eml3PEF1uxj/DjmLyZsK3qJo/yveSUp3QifPMRYhx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ldl5S8WR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B6LsxrGp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ldl5S8WR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6LsxrGp"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7C61F1400403;
	Wed,  3 Sep 2025 00:54:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 03 Sep 2025 00:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756875268;
	 x=1756961668; bh=FYby5rWio9S0NFw7ttvN3QliXVCDUpoPz2hh06lMzRY=; b=
	Ldl5S8WRRQ9jkrMHh5B769W2J7smLGPUVZsuPXwk+8c6sKdtZOs8EXROAtQ7nqQx
	3wHp+SNwyPhtYhzkvtaYHo+laa8o2MSXYxUQthZsiTMI04mkFnQSwGttZcvkZB4b
	FckBmOlY6p7JwK/bMGH0yy/O2zHhaTfwwaHN0rPSItTH11GEDniIA82yOe7ri/8I
	w5iH8ARnt60KDS94QEmc0WO4SFYJHvv51HCx1vfpjkaEruD3PaGQrLFge9ncg5ot
	Q/kmTXttvNBszPGAhZOBGkKDN5AvRU/S2BcKIZ3lqrvQAUOekdkV0/2qooxp6Dmz
	qrmaxWBHC1sZgL8bonT6Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756875268; x=
	1756961668; bh=FYby5rWio9S0NFw7ttvN3QliXVCDUpoPz2hh06lMzRY=; b=B
	6LsxrGpy+RsoB0aV89YSkEpmVSkqRpdNH7q0VGbocK9EyEsivhWhuGmXG4a7OO/z
	sRUkiff308vyK4v2usbD0S/6NkmJCIA6Jdr1TDlM2ksT9RkcCdW9HbQjLKb/eMek
	8dV29vjF0tx+C3t6VtqmclFnJOAfH63Dm6mexeu4jZX6kOWRVuKyyRXQNdid8PMC
	QShE01DyWTC9YO7Tngn8UH1pt7Mc1eFzH26HfMfB0gZyGupEYj/SaTrfFAoVS9Xh
	ZCMAh1C9I3tlsRqc07nX1OQJDnLMuf0cH2zqL9P/hss6gCqtpEgtlk5I93HZYGoB
	zXUYYNMkY4fSAJ3gW5/Wg==
X-ME-Sender: <xms:BMq3aL9BJQkFdqD4xCHB0Z2JhAZ975-rVxKDVyqKd1z_gXSL23lVOA>
    <xme:BMq3aCSm7AnwlfiFUvp1vctcuIfc17JXKBCKGxP-E4IW-7B8aNb56A1LGE2d-tSWu
    i7f6VPYeI1VDIGimA>
X-ME-Received: <xmr:BMq3aFkjVxECZwi6I8PEEa9HCzBnT8h04JHFOYPq7tIRBpRVe17gXkF2rxjGruNI3e2yBC-1AD5rrp1t8Z5FQnngUuiPoyTCYNiNieo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetke
    duheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:BMq3aKQ4KR0GUmMRMAnuUKjY2SywR9Rq8iTaM6zn6vrQR_IUQBztDA>
    <xmx:BMq3aLPDNjGMzLUhn1KmEKE0_WU2Obwyp1ZRTnj4QzQ_XMIKUnKU8A>
    <xmx:BMq3aLU4E1ONIlpRbtyTIgyTyoWOYnkLe5a_qUJ5H2urEfeoC1T_Eg>
    <xmx:BMq3aKepKvw3rwjhugBX-P7qXVA9wpTxjB2BnseyvonMdpLnXThJ0w>
    <xmx:BMq3aGOauZ3lcF9ge55wCAON11FGAmOPHjiJ8eDAvVofjeu3HgRu3t6O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 00:54:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f815acea (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 04:54:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Sep 2025 06:54:10 +0200
Subject: [PATCH 1/2] t5530: modernize tests
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-1-4e019af4dddc@pks.im>
References: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
In-Reply-To: <20250903-b4-pks-upload-pack-repeated-non-commit-acks-v1-0-4e019af4dddc@pks.im>
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
2.51.0.384.g4c02a37b29.dirty

